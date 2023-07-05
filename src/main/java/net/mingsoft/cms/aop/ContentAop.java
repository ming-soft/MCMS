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

import cn.hutool.core.io.FileUtil;
import net.mingsoft.base.constant.Const;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.base.exception.BusinessException;
import net.mingsoft.base.util.BundleUtil;
import net.mingsoft.basic.aop.BaseAop;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.biz.IHistoryLogBiz;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.cms.entity.HistoryLogEntity;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

    @Autowired
    private ICategoryBiz categoryBiz;

    /**
     * 注入浏览记录业务
     */
    @Autowired
    private IHistoryLogBiz historyLogBiz;

    @Value("${ms.diy.html-dir:html}")
    private String htmlDir;

    /**
     * 文章浏览记录，
     * 如果该文章该ip已经记录过，则不在重复记录
     * @param pjp
     * @return
     * @throws Throwable
     */
    @Around("execution(* net.mingsoft.cms.action.web.ContentAction.get(..))")
    public Object get(ProceedingJoinPoint pjp) throws Throwable {

//        获取方法参数
        ContentEntity content = getType(pjp, ContentEntity.class);
//        如果id为空则直接发行
        if (content.getId() == null) {
            return pjp.proceed();
        }
        content = contentBiz.getById(content.getId());
        //如果文章不存在则直接发行
        if (content == null) {
            return pjp.proceed();
        }

        HistoryLogEntity historyLog = new HistoryLogEntity();
        historyLog.setContentId(content.getId());
        historyLog.setHlIp(BasicUtil.getIp());
        historyLog.setHlIsMobile(BasicUtil.isMobileDevice());
        historyLog.setCreateDate(new Date());
        //保存浏览记录
        historyLogBiz.saveEntity(historyLog);
        //更新点击数
        if (content.getContentHit() == null) {
            content.setContentHit(1);
        } else {
            content.setContentHit(content.getContentHit() + 1);
        }
        contentBiz.updateById(content);
        return pjp.proceed();
    }


    @Pointcut("execution(* net.mingsoft.cms.action.ContentAction.delete(..))")
    public void delete() {
    }

    /**
     * 删除文章后并删除文章对应的静态化文件
     *
     * @param jp
     */
    @After("delete()")
    public void delete(JoinPoint jp) {
        List<ContentEntity> contents = (List<ContentEntity>) getJsonParam(jp);

        // 获取栏目ID对应文章ID数组 map
        Map<String, List<String>> categoryIdByContentIds = contents.stream()
                .collect(Collectors.groupingBy(ContentEntity::getCategoryId, Collectors.mapping(ContentEntity::getId, Collectors.toList())));
        List<String> categoryIds = new ArrayList<>(categoryIdByContentIds.keySet());
        // 考虑到在全部中删除文章 栏目不同
        for (String categoryId : categoryIds) {
            // 获取栏目
            CategoryEntity category = categoryBiz.getById(categoryId);
            // 获取栏目路径
            String categoryPath = category.getCategoryPath();
            for (String contentId : categoryIdByContentIds.get(categoryId)) {
                // 删除静态文件
                deleteHtml(categoryPath, contentId);
            }
        }
    }


    /**
     * @param categoryPath 栏目目录
     * @param contentId    文章ID
     *                     根据文章实体删除静态文件
     */
    private void deleteHtml(String categoryPath, String contentId) {
        // html真实路径
        String htmlPath = BasicUtil.getRealPath(htmlDir);
        // appDir
        String appDir = BasicUtil.getApp().getAppDir();
        // 文件路径组成 html真实路径 + appdir + 栏目路径 + 文章ID + .html
        String path = htmlPath
                + File.separator + appDir
                + categoryPath
                + File.separator + contentId
                + ParserUtil.HTML_SUFFIX;
        // 校验路径是否合法
        if (path.contains("..") || path.contains("../") || path.contains("..\\")) {
            LOG.error("非法路径："+path);
            throw new BusinessException(BundleUtil.getString(Const.RESOURCES,"err.error",BundleUtil.getString(net.mingsoft.basic.constant.Const.RESOURCES,"file.path")));
        }
        // 删除静态文件
        boolean flag = FileUtil.del(path);
        if (flag) {
            LOG.info("删除静态文件成功！");
        } else {
            LOG.info("删除失败！");
        }

    }
}
