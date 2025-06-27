/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * <p>
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * <p>
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.mingsoft.cms.aop;

import com.baidu.ueditor.define.BaseState;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.aop.FileVerifyAop;
import net.mingsoft.basic.bean.UploadConfigBean;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

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
        Object[] args = joinPoint.getArgs();
        MultipartFile file = null;
        // TODO: 2025/6/12 通过getType无法获取file文件信息，所以改成这个方法获取文件信息
        for (Object arg : args) {
            if (arg instanceof MultipartFile) {
                file = (MultipartFile) arg;
            }
        }
        // 如果没有文件，可能是获取配置文件时，直接返回
        if (file == null) {
            return joinPoint.proceed();
        }
        UploadConfigBean bean = new UploadConfigBean();
        bean.setFile(file);
        ResultData resultData = prepareUpload(bean,false);
        if (resultData.isSuccess()) {
            return joinPoint.proceed();
        }
        return new BaseState(false, resultData.getMsg()).toString();
    }

    /**
     * web上传文件的时候，将验证zip里的文件
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("execution(* net.mingsoft.cms.action.web.EditorAction.editor(..))")
    public Object webUploadAop(ProceedingJoinPoint joinPoint) throws Throwable {
        Object[] args = joinPoint.getArgs();
        MultipartFile file = null;
        // TODO: 2025/6/12 通过getType无法获取file文件信息，所以改成这个方法获取文件信息
        for (Object arg : args) {
            if (arg instanceof MultipartFile) {
                file = (MultipartFile) arg;
            }
        }
        // 如果没有文件，可能是获取配置文件时，直接返回
        if (file == null) {
            return joinPoint.proceed();
        }
        UploadConfigBean bean = new UploadConfigBean();
        bean.setFile(file);
        ResultData resultData = prepareUpload(bean,true);
        if (resultData.isSuccess()) {
            return joinPoint.proceed();
        }
        return new BaseState(false, resultData.getMsg()).toString();
    }

}
