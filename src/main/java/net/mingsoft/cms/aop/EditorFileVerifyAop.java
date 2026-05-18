package net.mingsoft.cms.aop;

import cn.hutool.core.io.file.FileNameUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpDownloader;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.aop.FileVerifyAop;
import net.mingsoft.basic.bean.UploadConfigBean;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.FileUtil;
import net.mingsoft.basic.util.IpUtils;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.action.BaseAction;
import net.mingsoft.cms.bean.EditorStateBean;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 铭软开发团队
 * @ClassName: EditorFileVerifyAop
 * @Description: 检测编辑器上传的文件是否合法
 * @date 2025年6月12日15:14:17
 */
@Component
@Aspect
public class EditorFileVerifyAop extends FileVerifyAop {

    private static final Logger LOG = LoggerFactory.getLogger(EditorFileVerifyAop.class);

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

        List<MultipartFile> files = this.getFiles(joinPoint);

        UploadConfigBean bean = new UploadConfigBean();
        // 会有抓取批量操作
        for (MultipartFile multipartFile : files) {
            bean = new UploadConfigBean();
            bean.setFile(multipartFile);
            ResultData resultData = prepareUpload(bean, false);
            if (!resultData.isSuccess()) {
                return new EditorStateBean(false, resultData.getMsg()).toString();
            }
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

        List<MultipartFile> files = this.getFiles(joinPoint);

        UploadConfigBean bean = new UploadConfigBean();
        // 会有抓取批量操作
        for (MultipartFile multipartFile : files) {
            bean = new UploadConfigBean();
            bean.setFile(multipartFile);
            ResultData resultData = prepareUpload(bean, true);
            if (!resultData.isSuccess()) {
                return new EditorStateBean(false, resultData.getMsg()).toString();
            }
        }
        return joinPoint.proceed();
    }

    /**
     * 获取上传的文件数组，可能存在多个
     * @param pjp
     * @return
     * @throws Exception
     */
    private List<MultipartFile> getFiles(ProceedingJoinPoint pjp) throws Exception{
        // 1. 获取请求操作
        String action = BasicUtil.getString("action");

        List<MultipartFile> files = new ArrayList<>();
        MultipartFile file = null;
        // 判断当前编辑器什么操作
        switch (action) {
            case "uploadscrawl":
                // 上传涂鸦文件
                String base64 = SpringUtil.getRequest().getParameter("upfile");
                byte[] bytes = Base64.decodeBase64(base64);
                // 尝试从流中获取后缀地址

                file = FileUtil.bytesToMultipartFile(bytes, "png");
                if (ObjectUtil.isNotNull(file)) {
                    files.add(file);
                }
                break;
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
                files.add(file);
                break;
            case "catchimage":
                // 抓取网络图片到本地
                // 获取图片地址
                String[] urls = SpringUtil.getRequest().getParameterValues("source[]");
                for (String url : urls) {
                    if (StringUtils.isBlank(url) || !isValidUrl(url)) {
                        continue;
                    }
                    // 根据文件后缀当默认值，防止出现某些文件通过字节流获取后缀为空的情况
                    String suffix = FileNameUtil.getSuffix(url);
                    suffix = StrUtil.isBlank(suffix) ? "png" : suffix;

                    // 获取远程文件字节流
                    bytes = null;
                    try {
                        // 获取远程文件字节流, 默认超时时间为10秒
                        bytes = HttpDownloader.downloadBytes(url, 10000);
                    } catch (Exception e) {
                        // 捕获异常，防止因异常导致后续错误
                        LOG.debug("下载远程文件失败，地址： {}", url);
                        e.printStackTrace();
                    }

                    if (bytes == null) {
                        continue;
                    }

                    // 转成multipartFile对象方便组装成上传bean
                    file = FileUtil.bytesToMultipartFile(bytes, suffix);
                    files.add(file);
                }
                break;
            default:
                break;
        }
        return files;
    }

    /**
     * 判断url是否合法
     * 1. 协议限制：只允许 http 和 https
     * 2. 域名/IP：禁止访问内网
     * @param url url
     * @return 合法返回true，否则返回false
     */
    private static boolean isValidUrl(String url) {
        try {
            URL u = new URL(url);
            // 1. 协议限制：只允许 http 和 https
            String protocol = u.getProtocol().toLowerCase();
            if (!"http".equals(protocol) && !"https".equals(protocol)) {
                LOG.debug("协议错误，请检查远程地址协议： {}", url);
                return false;
            }

            // 2. 禁止访问内网
            String host = u.getHost();
            if (IpUtils.isInternalIp(host)) {
                LOG.debug("禁止访问内网，请检查远程地址： {}", url);
                return false;
            }
            return true;
        } catch (MalformedURLException e) {
            return false;
        }
    }

}
