/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
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




package net.mingsoft.cms.action;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import cn.hutool.core.date.DateException;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.annotation.LogAnn;
import net.mingsoft.basic.biz.IModelBiz;
import net.mingsoft.basic.constant.e.BusinessTypeEnum;
import net.mingsoft.basic.entity.AppEntity;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.bean.CategoryBean;
import net.mingsoft.cms.bean.ContentBean;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.constant.e.CategoryDisplayEnum;
import net.mingsoft.cms.constant.e.CategoryTypeEnum;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.util.CmsParserUtil;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @ClassName: GeneraterAction
 * @Description:TODO 生成器
 * @author: 铭飞开发团队
 * @date: 2018年1月31日 下午2:52:07
 * @Copyright: 2018 www.mingsoft.net Inc. All rights reserved.
 */
@Api(tags={"后端-静态化"})
@Controller("cmsGenerater")
@RequestMapping("/${ms.manager.path}/cms/generate")
@Scope("request")
public class GeneraterAction extends BaseAction {

    /*
     * log4j日志记录
     */
    protected final Logger LOG = LoggerFactory.getLogger(this.getClass());

    /**
     * 文章管理业务层
     */
    @Autowired
    private IContentBiz contentBiz;

    /**
     * 栏目管理业务层
     */
    @Autowired
    private ICategoryBiz categoryBiz;

    /**
     * 模块管理业务层
     */
    @Autowired
    private IModelBiz modelBiz;

    @Value("${ms.manager.path}")
    private String managerPath;

    @Value("${ms.diy.html-dir:html}")
    private String htmlDir;

    /**
     * /**
     * 更新主页
     *
     * @return
     */
    @GetMapping("/index")
    public String index(HttpServletRequest request, ModelMap model) {
        return "/cms/generate/index";
    }

    /**
     * 生成主页
     *
     * @param request
     * @param response
     */
    @ApiOperation(value = "生成主页接口")
    @RequestMapping(value = "/generateIndex", method = {RequestMethod.GET, RequestMethod.POST})
    @RequiresPermissions("cms:generate:index")
    @LogAnn(title = "生成主页", businessType = BusinessTypeEnum.UPDATE)
    @ResponseBody
    public ResultData generateIndex(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 模板文件名称
        String tmpFileName = request.getParameter("url");
        // 生成后的文件名称
        String generateFileName = request.getParameter("position");

        // 防止篡改主页
        if (tmpFileName.contains("..") || tmpFileName.contains("../") || tmpFileName.contains("\\..")){
            return ResultData.build().error(getResString("template.file"));
        }
        if (generateFileName.contains("..") || generateFileName.contains("../") || generateFileName.contains("\\..")){
            return ResultData.build().error(getResString("template.file"));
        }
        // 获取文件所在路径 首先判断用户输入的模板文件是否存在
        if (!FileUtil.exist(ParserUtil.buildTemplatePath())) {
            return ResultData.build().error(getResString("template.file"));
        } else {

            CmsParserUtil.generate(tmpFileName, generateFileName, htmlDir);
            return ResultData.build().success();
        }
    }


    /**
     * 生成列表的静态页面
     *
     * @param request
     * @param response
     * @param categoryId
     */
    @ApiOperation(value = "生成栏目接口")
    @RequestMapping(value = "/{categoryId}/generateColumn", method = {RequestMethod.GET, RequestMethod.POST})
    @LogAnn(title = "生成栏目", businessType = BusinessTypeEnum.UPDATE)
    @RequiresPermissions("cms:generate:column")
    @ResponseBody
    public ResultData generateColumn(HttpServletRequest request, HttpServletResponse response, @PathVariable String categoryId) throws IOException {
        // 获取站点id
        AppEntity app = BasicUtil.getApp();

        //栏目列表
        List<CategoryEntity> columns = new ArrayList<CategoryEntity>();

        if ("0".equals(categoryId)) {// 0更新所有栏目
            CategoryEntity categoryEntity = new CategoryEntity();
            columns = categoryBiz.query(categoryEntity);
        } else { //选择栏目更新
            CategoryEntity categoryEntity = new CategoryEntity();
            categoryEntity.setId(categoryId);
            columns = categoryBiz.queryChildren(categoryEntity);
        }

        //文章列表
        List<CategoryBean> articleIdList = null;

        // 获取栏目列表模板
        for (CategoryEntity column : columns) {
            // 如果栏目被禁用则跳过
            if (CategoryDisplayEnum.DISABLE.toString().equalsIgnoreCase(column.getCategoryDisplay())){
                continue;
            }
            //如果是链接就跳过生成
            if (column.getCategoryType().equals(CategoryTypeEnum.LINK.toString())) {
                continue;
            }
            ContentBean contentBean = new ContentBean();
            contentBean.setCategoryId(column.getId());
            contentBean.setCategoryType(column.getCategoryType());
            articleIdList = contentBiz.queryIdsByCategoryIdForParser(contentBean);
            // 判断列表类型
            switch (CategoryTypeEnum.get(column.getCategoryType())) {
                //TODO 暂时先用字符串代替
                case LIST: // 列表

                    // 判断模板文件是否存在
                    if (StringUtils.isEmpty(column.getCategoryListUrl()) || !FileUtil.exist(ParserUtil.buildTemplatePath(column.getCategoryListUrl()))) {
                        LOG.error("{} 模板不存在：{}", column.getCategoryTitle(), column.getCategoryUrl());
                        continue;
                    }

                    CmsParserUtil.generateList(column, articleIdList.size(), htmlDir);
                    break;
                case COVER:// 单页

                    // 判断模板文件是否存在
                    if (StringUtils.isEmpty(column.getCategoryUrl()) || !FileUtil.exist(ParserUtil.buildTemplatePath(column.getCategoryUrl()))) {
                        LOG.error("{} 模板不存在：{}", column.getCategoryTitle(), column.getCategoryUrl());
                        continue;
                    }

                    if (articleIdList.size() == 0) {
                        CategoryBean columnArticleIdBean = new CategoryBean();
                        CopyOptions copyOptions = CopyOptions.create();
                        copyOptions.setIgnoreError(true);
                        BeanUtil.copyProperties(column, columnArticleIdBean, copyOptions);
                        articleIdList.add(columnArticleIdBean);
                    }
                    CmsParserUtil.generateBasic(articleIdList, htmlDir,null);
                    break;
            }
        }

        return ResultData.build().success();
    }

    /**
     * 根据栏目id更新所有的文章
     *
     * @param request
     * @param response
     * @param columnId
     */
    @ApiOperation(value = "生成文章接口")
    @RequestMapping(value = "/{columnId}/generateArticle", method = {RequestMethod.GET, RequestMethod.POST})
    @RequiresPermissions("cms:generate:article")
    @LogAnn(title = "生成文章", businessType = BusinessTypeEnum.UPDATE)
    @ResponseBody
    public ResultData generateArticle(HttpServletRequest request, HttpServletResponse response, @PathVariable String columnId) throws IOException {
        String dateTime = request.getParameter("dateTime");
        // 网站风格物理路径
        List<CategoryBean> articleIdList = null;
        List<CategoryEntity> categoryList = new ArrayList<CategoryEntity>();
        ContentBean contentBean = new ContentBean();
        contentBean.setBeginTime(dateTime);

        // 时间格式化
        Date contentUpdateTime = null;
        try {
            contentUpdateTime = DateUtil.parse(dateTime);
        } catch (DateException e) {
            e.printStackTrace();
            return ResultData.build().error(getResString("err.error",this.getResString("datetime.format")));
        }
        if ("0".equals(columnId)) {
            categoryList = categoryBiz.list();
        } else { //选择栏目更新
            CategoryEntity categoryEntity = new CategoryEntity();
            categoryEntity.setId(columnId);
            categoryList = categoryBiz.queryChildren(categoryEntity);
        }

        for (CategoryEntity category : categoryList) {
            // 如果栏目被禁用则跳过
            if (CategoryDisplayEnum.DISABLE.toString().equalsIgnoreCase(category.getCategoryDisplay())){
                continue;
            }
            //如果是链接就跳过生成
            if (category.getCategoryType().equals(CategoryTypeEnum.LINK.toString())) {
                continue;
            }
            contentBean.setCategoryId(category.getId());
            contentBean.setCategoryType(category.getCategoryType());
            contentBean.setOrderBy("date");
            //将文章列表标签中的中的参数
            articleIdList = contentBiz.queryIdsByCategoryIdForParser(contentBean);
            // 分类是列表
            if (category.getCategoryType().equals(CategoryTypeEnum.LIST.toString())) {
                // 判断模板文件是否存在
                if (!FileUtil.exist(ParserUtil.buildTemplatePath(category.getCategoryListUrl())) || StringUtils.isEmpty(category.getCategoryListUrl())) {
                    LOG.error("{} 模板不存在：{}", category.getCategoryTitle(), category.getCategoryListUrl());
                    continue;
                }
            } else if (category.getCategoryType().equals(CategoryTypeEnum.COVER.toString())) {
                continue;
            }
            // 有符合条件的就更新
            if (articleIdList.size() > 0) {
                CmsParserUtil.generateBasic(articleIdList, htmlDir,contentUpdateTime);
            }
        }


        return ResultData.build().success();
    }


    /**
     * 用户预览主页
     *
     * @param request
     * @return
     */
    @ApiOperation(value = "预览主页接口")
    @RequestMapping(value = "/{position}/viewIndex", method = {RequestMethod.GET, RequestMethod.POST})
    public String viewIndex(HttpServletRequest request, @PathVariable String position, HttpServletResponse response) {
        AppEntity app = BasicUtil.getApp();
        // 组织主页预览地址
        String indexPosition = app.getAppHostUrl() + htmlDir + File.separator + app.getAppDir()
                + File.separator + position + ParserUtil.HTML_SUFFIX;
        return "redirect:" + indexPosition;
    }


}
