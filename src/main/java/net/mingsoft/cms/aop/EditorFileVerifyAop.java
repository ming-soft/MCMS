package net.mingsoft.cms.aop;

import cn.hutool.core.io.file.FileNameUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.Header;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.base.exception.BusinessException;
import net.mingsoft.basic.aop.FileVerifyAop;
import net.mingsoft.basic.bean.UploadConfigBean;
import net.mingsoft.basic.service.LocalCacheService;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.FileUtil;
import net.mingsoft.basic.util.IpUtils;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.bean.EditorStateBean;
import net.mingsoft.config.MSProperties;
import net.mingsoft.mdiy.util.ConfigUtil;
import org.apache.commons.codec.binary.Base64;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 铭软开发团队
 * @ClassName: EditorFileVerifyAop
 * @Description: 检测编辑器上传的文件是否合法
 * @date 2025年6月12日15:14:17
 * 修改说明：2026年9月17日 增加@Order注解，方便其他aop获取抓取图片缓存
 */
@Component
@Aspect
@Order(1)
public class EditorFileVerifyAop extends FileVerifyAop {

    private static final Logger LOG = LoggerFactory.getLogger(EditorFileVerifyAop.class);

    /**
     * 可抓取图片数量
     */
    private static final int CATCH_IMAGE_COUNT = 50;

    /**
     * 切入点
     */
    @Pointcut()
    public void uploadPointCut(){}

    /**
     * 后台上传文件的时候，将验证zip里的文件
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("execution(* net.mingsoft.cms.action.EditorAction.editor(..)) ")
    public Object uploadAop(ProceedingJoinPoint joinPoint) throws Throwable {
        // 1. 获取请求操作
        String action = BasicUtil.getString("action");
        // 获取配置操作直接返回
        if (StrUtil.isBlank(action) || "config".equals(action)) {
            return joinPoint.proceed();
        }

        ResultData resultData = this.checkFiles(joinPoint, false);
        if (!resultData.isSuccess()) {
            return new EditorStateBean(false, resultData.getMsg()).toString();
        }
        return joinPoint.proceed();
    }

    /**
     * web上传文件的时候，将验证zip里的文件
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("execution(* net.mingsoft.cms.action.web.EditorAction.editor(..))")
    public Object webUploadAop(ProceedingJoinPoint joinPoint) throws Throwable {
        // 1. 获取请求操作
        String action = BasicUtil.getString("action");
        // 获取配置操作直接返回
        if (StrUtil.isBlank(action) || "config".equals(action)) {
            return joinPoint.proceed();
        }

        ResultData resultData = this.checkFiles(joinPoint, true);
        if (!resultData.isSuccess()) {
            return new EditorStateBean(false, resultData.getMsg()).toString();
        }
        return joinPoint.proceed();
    }

    /**
     * 校验编辑器上传的文件合法性
     * <p>根据 action 类型处理不同的上传场景：</p>
     * <ul>
     *     <li>uploadscrawl: 处理涂鸦 base64 数据</li>
     *     <li>uploadimage/uploadvideo/uploadfile: 处理常规文件上传</li>
     *     <li>catchimage: 处理远程图片抓取，包含安全校验和大小限制</li>
     * </ul>
     *
     * @param pjp 切点连接点，用于获取方法参数
     * @param web 是否为前端上传（影响文件大小限制配置及缓存策略）
     * @return 校验结果，成功返回 success，失败返回对应的错误信息
     * @throws Exception 处理过程中的异常
     */
    private ResultData checkFiles(ProceedingJoinPoint pjp, boolean web) throws Exception {
        // 1. 获取请求操作
        String action = BasicUtil.getString("action");

        MultipartFile file = null;
        UploadConfigBean bean = new UploadConfigBean();
        // 判断当前编辑器什么操作
        switch (action) {
            case "uploadscrawl":
                // 上传涂鸦文件
                String base64 = SpringUtil.getRequest().getParameter("upfile");
                byte[] bytes = Base64.decodeBase64(base64);
                // 尝试从流中获取后缀地址

                file = FileUtil.bytesToMultipartFile(bytes, "png");
                if (ObjectUtil.isNull(file)) {
                    LOG.debug("上传涂鸦文件时，为获取到文件");
                    break;
                }
                bean.setFile(file);
                return super.prepareUpload(bean, web);
            case "uploadimage":
            case "uploadvideo":
            case "uploadfile":
                // 上传文件
                Object[] args = pjp.getArgs();
                // TODO: 2025/6/12 通过getType无法获取file文件信息，所以改成这个方法获取文件信息
                for (Object arg : args) {
                    if (arg instanceof MultipartFile) {
                        file = (MultipartFile) arg;
                    }
                }
                if (file == null) {
                    LOG.debug("未获取到文件，请检查文件是否正常");
                    break;
                }
                bean = new UploadConfigBean();
                bean.setFile(file);
                return super.prepareUpload(bean, web);
            case "catchimage":
                // 抓取网络图片到本地
                String[] urls = SpringUtil.getRequest().getParameterValues("source[]");
                if (urls == null || urls.length == 0) {
                    break;
                }
                if (urls.length > CATCH_IMAGE_COUNT) {
                    LOG.debug("抓取图片数量超出限制");
                    break;
                }
                LocalCacheService localCacheService = new LocalCacheService();
                List<String> catchImageUrls = new ArrayList<>();
                long maxSize = getCatchImageMaxSize(web);
                for (String url : urls) {
                    // 根据文件后缀当默认值，防止出现某些文件通过字节流获取后缀为空的情况
                    String suffix = FileNameUtil.getSuffix(url);
                    suffix = StrUtil.isBlank(suffix) ? "png" : suffix;

                    // 不跟随重定向；先按 Content-Length 判断是否下载（超限/重定向会抛 BusinessException）
                    byte[] remoteBytes = null;
                    try {
                        remoteBytes = download(url, maxSize);
                    } catch (BusinessException e) {
                        LOG.debug("抓取图片失败", e);
                        // 抓取图片失败，清除缓存中数据
                        for (String catchImageUrl : catchImageUrls) {
                            localCacheService.remove(catchImageUrl);
                        }
                        return ResultData.build().error(e.getMsg());
                    }
                    if (remoteBytes == null) {
                        continue;
                    }

                    // 转成multipartFile对象方便组装成上传bean
                    file = FileUtil.bytesToMultipartFile(remoteBytes, suffix);
                    bean = new UploadConfigBean();
                    bean.setFile(file);
                    bean.setFileName(file.getOriginalFilename());
                    bean.setFileSize(file.getSize());
                    ResultData resultData = super.prepareUpload(bean, web);
                    if (!resultData.isSuccess()) {
                        // 抓取图片失败，清除缓存中数据
                        for (String catchImageUrl : catchImageUrls) {
                            localCacheService.remove(catchImageUrl);
                        }
                        return resultData;
                    }
                    // 抓取网络图片使用本地缓存
                    localCacheService.put(url, bean);
                    catchImageUrls.add(url);
                }
                break;
            default:
                break;
        }
        return ResultData.build().success();
    }

    /**
     * 获取抓图允许的最大字节数，与编辑器上传配置保持一致
     */
    private long getCatchImageMaxSize(boolean web) {
        if (web) {
            return ConfigUtil.getLong("文件上传配置", "webFileSize", MSProperties.upload.multipart.maxFileSize) * 1024;
        }
        return ConfigUtil.getLong("文件上传配置", "imageSize", MSProperties.upload.multipart.maxFileSize) * 1024;
    }

    /**
     * 下载远程文件
     *
     * <p>下载限制：</p>
     * <ul>
     *     <li>1. 不跟随 HTTP 重定向</li>
     *     <li>2. 必须返回 2xx 状态码</li>
     *     <li>3. 必须存在有效的 Content-Length</li>
     *     <li>4. Content-Length 不得超过最大文件大小</li>
     *     <li>5. 实际读取数据时再次限制文件大小，防止 Content-Length 不准确</li>
     * </ul>
     *
     * @param url          远程文件地址
     * @param maxSizeBytes 最大文件大小，单位：字节
     * @return 文件字节数组，下载失败返回 null
     */
    private byte[] download(String url, long maxSizeBytes) {
        if (!isValidUrl(url)) {
            return null;
        }
        try (HttpResponse response = HttpRequest.get(url)
                .timeout(10000)
                // 不允许自动跟随重定向，避免跳转到其他地址
                .setFollowRedirects(false)
                .execute()) {
            // 不允许自动跟随重定向，避免跳转到其他地址

            int status = response.getStatus();

            // 3xx：不跟随重定向，直接拒绝
            if (status >= 300 && status < 400) {
                throw new BusinessException("远程地址存在重定向，禁止抓取");
            }

            // 非 2xx 响应
            if (status < 200 || status >= 300) {
                LOG.debug("远程文件响应异常，status={} url={}", status, url);
                return null;
            }

            // 1. 获取 Content-Length
            String lenStr = response.header(Header.CONTENT_LENGTH);
            if (StrUtil.isBlank(lenStr)) {
                throw new BusinessException("无法获取远程文件大小，禁止抓取");
            }
            long contentLength;
            try {
                contentLength = Long.parseLong(lenStr.trim());
            } catch (NumberFormatException e) {
                throw new BusinessException("远程文件大小异常，禁止抓取");
            }
            // 2. 文件大小必须大于 0
            if (contentLength <= 0) {
                throw new BusinessException("远程文件大小异常，禁止抓取");
            }
            // 3. Content-Length 预检查
            if (contentLength > maxSizeBytes) {
                throw new BusinessException("远程文件超过允许大小，禁止抓取");
            }
            // 4. 流式读取，防止直接 bodyBytes() 导致一次性加载超大文件
            try (InputStream inputStream = response.bodyStream();
                 ByteArrayOutputStream outputStream = new ByteArrayOutputStream((int) Math.min(contentLength, 64 * 1024))) {

                byte[] buffer = new byte[8192];
                long totalSize = 0;
                int len;

                while ((len = inputStream.read(buffer)) != -1) {

                    totalSize += len;

                    // 防止实际文件大小超过限制
                    // 即使 Content-Length 不准确，也不会无限读取
                    if (totalSize > maxSizeBytes) {
                        throw new BusinessException("远程文件超过允许大小，禁止抓取");
                    }

                    outputStream.write(buffer, 0, len);
                }

                // 实际读取到 0 字节
                if (totalSize <= 0) {
                    return null;
                }

                return outputStream.toByteArray();
            }
        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            LOG.debug("下载远程文件失败，地址：{}", url, e);
            return null;
        }
    }

    /**
     * 判断远程 URL 是否安全
     *
     * <p>检查内容：</p>
     * <ul>
     *     <li>1. URL 格式是否合法</li>
     *     <li>2. 协议仅允许 HTTP / HTTPS</li>
     *     <li>3. 禁止访问内网、本机及链路本地地址</li>
     * </ul>
     *
     * @param url URL
     * @return 安全返回 true，否则返回 false
     */
    private static boolean isValidUrl(String url) {
        if (StrUtil.isBlank(url)) {
            return false;
        }

        try {
            URI uri = new URI(url.trim());

            // 1. 协议限制
            String protocol = uri.getScheme();
            if (!"http".equalsIgnoreCase(protocol) && !"https".equalsIgnoreCase(protocol)) {
                LOG.debug("协议错误，请检查远程地址协议：{}", url);
                return false;
            }

            // 2. 禁止 userinfo
            // 例如：http://user:pass@example.com/test.jpg
            if (StrUtil.isNotBlank(uri.getUserInfo())) {
                LOG.debug("远程地址禁止携带用户信息：{}", url);
                return false;
            }

            // 3. 获取 Host
            String host = uri.getHost();
            if (StrUtil.isBlank(host)) {
                LOG.debug("远程地址缺少有效主机：{}", url);
                return false;
            }

            // 4. 禁止访问内网 / 本机 / 特殊 IP
            if (IpUtils.isInternalIp(host)) {
                LOG.debug("禁止访问内网，请检查远程地址：{}", url);
                return false;
            }
            return true;
        } catch (URISyntaxException e) {
            LOG.debug("远程地址格式错误：{}", url);
            return false;
        }
    }

}
