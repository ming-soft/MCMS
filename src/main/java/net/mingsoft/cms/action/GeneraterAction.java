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
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateException;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.annotation.LogAnn;
import net.mingsoft.basic.bean.EUListBean;
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
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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
     * 获取所有栏目数据
     * 重写接口说明：
     * 处理静态化生成页无法获取所有分类信息问题
     * 目前栏目作为一个公共数据，方便以后拓展其他业务
     * @param category 分类实体
     */
    @ApiOperation(value = "查询分类列表接口")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "categoryTitle", value = "栏目管理名称", required = false, paramType = "query"),
            @ApiImplicitParam(name = "categoryParentId", value = "父类型编号", required = false, paramType = "query"),
    })
    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ResultData list(@ModelAttribute @ApiIgnore CategoryEntity category) {
        List categoryList = categoryBiz.list(new LambdaQueryWrapper<CategoryEntity>(category));
        return ResultData.build().success(new EUListBean(categoryList, categoryList.size()));
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
                        LOG.error("静态化单篇类型栏目异常：{} ，异常原因：没有文章", column.getCategoryTitle());
                        CategoryBean columnArticleIdBean = new CategoryBean();
                        CopyOptions copyOptions = CopyOptions.create();
                        copyOptions.setIgnoreError(true);
                        BeanUtil.copyProperties(column, columnArticleIdBean, copyOptions);
                        articleIdList.add(columnArticleIdBean);
                    }
                    CmsParserUtil.generateBasic(articleIdList, htmlDir,null);
                    break;
                default:
                    // 为了方面拓展其他静态化栏目，都默认走这个业务
                    // 判断模板文件是否存在
                    if (StringUtils.isEmpty(column.getCategoryUrl()) || !FileUtil.exist(ParserUtil.buildTemplatePath(column.getCategoryUrl()))) {
                        LOG.error("{} 模板不存在：{}", column.getCategoryTitle(), column.getCategoryUrl());
                        continue;
                    }
                    // TODO: 2024/11/26 目前只根据内容模版生成静态文件 
                    CmsParserUtil.generate(column.getCategoryUrl(), column.getCategoryPinyin(), htmlDir);
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
            // 根据leaf进行升序排序，让叶子栏目最后静态化 保证文章上下篇关系正确
            LambdaQueryWrapper<CategoryEntity> wrapper = new LambdaQueryWrapper<CategoryEntity>().orderByAsc(CategoryEntity::getLeaf);
            categoryList = categoryBiz.list(wrapper);
        } else { //选择栏目更新
            CategoryEntity categoryEntity = new CategoryEntity();
            categoryEntity.setId(columnId);
            categoryList = categoryBiz.queryChildren(categoryEntity);
        }

        // todo 这里延续之前的详情上下篇思路(不考虑跨栏目)，只对栏目内的文章进行上下篇处理，且单篇没有上下篇；
        // 获取叶子节点栏目
        categoryList = categoryList.stream().filter(item->{
            return item.getLeaf();
        }).collect(Collectors.toList());

        for (CategoryEntity category : categoryList) {
            // 如果栏目被禁用则跳过
            if (CategoryDisplayEnum.DISABLE.toString().equalsIgnoreCase(category.getCategoryDisplay())){
                continue;
            }
            //如果是链接就跳过生成
            if (category.getCategoryType().equals(CategoryTypeEnum.LINK.toString())) {
                continue;
            }

            // 如果是单篇文章跳过生成
            if (category.getCategoryType().equals(CategoryTypeEnum.COVER.toString())) {
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
                // 有符合条件的就更新
                if (articleIdList.size() > 0) {
                    CmsParserUtil.generateBasic(articleIdList, htmlDir,contentUpdateTime);
                }
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

    /**
     * 删除页面
     * <p>
     * 页面名称
     *
     * @param request 响应
     */
    @ApiOperation(value = "删除页面")
    @ApiImplicitParam(name = "fileName", value = "主页名称", required = true, paramType = "query")
    @LogAnn(title = "删除页面", businessType = BusinessTypeEnum.DELETE)
    @PostMapping("/delete")
    @ResponseBody
    @RequiresPermissions("cms:generate:del")
    public ResultData delete(HttpServletRequest request) {
        String deletePath = BasicUtil.getString("deletePath");
        if (StrUtil.isBlank(deletePath)) {
            return ResultData.build().error("请先输入要删除的文件路径");
        }
        // 确定以html开头
        if (!deletePath.startsWith(htmlDir) && !deletePath.startsWith("/" + htmlDir)) {
            return ResultData.build().error("删除路径请以" + htmlDir + "开头");
        }
        if (deletePath.contains("..") || deletePath.contains("../") || deletePath.contains("..\\")) {
            return ResultData.build().error("非法路径");
        }
        String appDir = BasicUtil.getApp().getAppDir();
        // 用户输入的实际路径
        String realPath = BasicUtil.getRealPath(deletePath);
        //站点的真实路径 html/web(站点id)
        String webRealPath = BasicUtil.getRealPath(htmlDir + "/" + appDir + "/");

        String htmlRealPath = BasicUtil.getRealPath(htmlDir);
        // 取html下的文件
        List<String> paths = FileUtil.listFileNames(htmlRealPath);
        // 暂不考虑 html/web/index 与  html/index短链 同时存在; 只处理html/web/index 与  html/index短链 单独存在的场景
        if (CollUtil.isEmpty(paths)) {
            // 为空则说为目录  就有web；
            // 判断传入的路径是否以 （html+/+站点+/ yaml配置中） 开头；是则为同一个站，不是则跨站
            if (!realPath.startsWith(webRealPath)) {
                return ResultData.build().error("不允许跨站删除");
            }
        }
        //  只剩下情况  文件 html/web（本站）/index  和 html/index  判断直接删除文件
        if (FileUtil.exist(realPath)) {
            FileUtil.del(realPath);
            return ResultData.build().success();
        } else {
            return ResultData.build().error("文件不存在");
        }
    }


}
