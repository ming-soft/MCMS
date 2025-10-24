package net.mingsoft.cms.aop;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.aop.FileVerifyAop;
import net.mingsoft.basic.bean.UploadConfigBean;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.FileUtil;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.bean.EditorStateBean;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

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
                if (ObjectUtil.isNull(file)) {
                    files.add(file);
                }
                break;
            case "uploadimage":
            case "uploadvideo":
            case "uploadfile":
                // 上传文件
                Object[] args = pjp.getArgs();
                file = null;
                // TODO: 2025/6/12 通过getType无法获取file文件信息，所以改成这个方法获取文件信息
                for (Object arg : args) {
                    if (arg instanceof MultipartFile) {
                        file = (MultipartFile) arg;
                    }
                }
                files.add(file);
                break;
            case "catchimage":
                // 抓取网络图片到本地
                // 获取图片地址
                String[] remotes = SpringUtil.getRequest().getParameterValues("source[]");
                for (String remote : remotes) {
                    if (StringUtils.isBlank(remote)) {
                        continue;
                    }
                    file = FileUtil.remoteUrlToMultipartFile(remote, "png");
                    if (file == null) {
                        continue;
                    }
                    files.add(file);
                }
                break;
            default:
                break;
        }
        return files;
    }

}
