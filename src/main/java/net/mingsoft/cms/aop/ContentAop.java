/**
 * The MIT License (MIT)
 * Copyright (c) 2020 铭软科技(mingsoft.net)
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package net.mingsoft.cms.aop;

import net.mingsoft.basic.aop.BaseAop;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.biz.IHistoryLogBiz;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.cms.entity.HistoryLogEntity;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * @author 铭飞开源团队
 * @date 2019/12/23
 */
@Component
@Aspect
public class ContentAop extends BaseAop {

    /**
     * 注入文章业务
     */
    @Autowired
    private IContentBiz contentBiz;

    /**
     * 注入浏览记录业务
     */
    @Autowired
    private IHistoryLogBiz historyLogBiz;

    /**
     * 文章浏览记录，
     * 如果该文章该ip已经记录过，则不在重复记录
     * @param pjp
     * @return
     * @throws Throwable
     */
    @Around("execution(* net.mingsoft.cms.action.web.ContentAction.get(..))")
    public Object get(ProceedingJoinPoint pjp) throws Throwable{

//        获取方法参数
        ContentEntity content = getType(pjp, ContentEntity.class);
//        如果id为空则直接发行
        if(content.getId()==null) {
            return pjp.proceed();
        }
        content = (ContentEntity)contentBiz.getEntity(Integer.parseInt(content.getId()));
        //如果文章不存在则直接发行
        if(content == null){
            return pjp.proceed();
        }

        //查询判断该ip是否已经有浏览记录了
        HistoryLogEntity historyLog = new HistoryLogEntity();
        historyLog.setContentId(content.getId());
        historyLog.setHlIp(BasicUtil.getIp());
        historyLog.setHlIsMobile(BasicUtil.isMobileDevice());
        HistoryLogEntity _historyLog = (HistoryLogEntity)historyLogBiz.getEntity(historyLog);
        //如果该ip该文章没有浏览记录则保存浏览记录
        //并且更新点击数
        if(_historyLog == null || StringUtils.isBlank(_historyLog.getId())){
            historyLog.setCreateDate(new Date());
            historyLogBiz.saveEntity(historyLog);
            //更新点击数
            ContentEntity updateContent = new ContentEntity();
            updateContent.setId(content.getId());
            if(content.getContentHit() == null){
                updateContent.setContentHit(1);
            }else{
                updateContent.setContentHit(content.getContentHit()+1);
            }
            contentBiz.updateEntity(updateContent);
        }

        return pjp.proceed();
    }
}
