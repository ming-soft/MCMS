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


package net.mingsoft.cms.util;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.PageUtil;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.TemplateNotFoundException;
import net.mingsoft.base.constant.Const;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.bean.CategoryBean;
import net.mingsoft.cms.constant.e.CategoryTypeEnum;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.biz.IModelBiz;
import net.mingsoft.mdiy.biz.impl.ModelBizImpl;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.util.ConfigUtil;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * 文章解析工具类
 */
public class CmsParserUtil {


    private final static String FIELD = "field";
    protected final static Logger LOG = LoggerFactory.getLogger(CmsParserUtil.class);

    /**
     * 指定模板，指定路径进行生成静态页面，会自定识别pc与移动端
     *
     * @param templatePath 模板路径
     * @param targetPath   生成后的路径，默认生成的html文件，所以不能带.html后缀，
     * @throws IOException
     */
    public static void generate(String templatePath, String targetPath, String htmlDir) throws IOException {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put(ParserUtil.IS_DO, false);
        CategoryEntity column = new CategoryEntity();
        //内容管理栏目编码
        map.put(ParserUtil.COLUMN, column);
        map.put(ParserUtil.HTML, htmlDir);

        //站点编号
        if (BasicUtil.getWebsiteApp() != null) {
            map.put(ParserUtil.APP_DIR, BasicUtil.getWebsiteApp().getAppDir());
            map.put(ParserUtil.URL, BasicUtil.getWebsiteApp().getAppHostUrl());
            map.put(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getAppId());
        } else {
            map.put(ParserUtil.URL, BasicUtil.getUrl());
            map.put(ParserUtil.APP_DIR, BasicUtil.getApp().getAppDir());
        }

        //对项目名预处理
        String contextPath = BasicUtil.getContextPath();
        if (StringUtils.isNotBlank(contextPath) && "/".equalsIgnoreCase(contextPath) ){
            contextPath = "";
        }
        map.putIfAbsent(ParserUtil.CONTEXT_PATH, contextPath);

        String content = ParserUtil.rendering(templatePath, map);
        FileUtil.writeString(content, ParserUtil.buildHtmlPath(targetPath, htmlDir, map.get(ParserUtil.APP_DIR).toString()), Const.UTF8);
    }

    /**
     * 生成静态列表页
     *
     * @param column
     * @param articleIdTotal
     * @throws TemplateNotFoundException
     * @throws MalformedTemplateNameException
     * @throws ParseException
     * @throws IOException
     */
    public static void generateList(CategoryEntity column, int articleIdTotal, String htmlDir)
            throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException {
        try {
            // 文章的栏目模型编号
            PageBean page = new PageBean();

            //获取列表中的size
            page.setSize(ParserUtil.getPageSize(column.getCategoryListUrl(), 20));
            page.setRcount(articleIdTotal);

            int totalPageSize = PageUtil.totalPage(articleIdTotal, page.getSize());
            page.setTotal(totalPageSize);

            //全局参数设置
            Map<String, Object> parserParams = new HashMap<String, Object>();
            parserParams.put(ParserUtil.IS_DO, false);
            parserParams.put(ParserUtil.HTML, htmlDir);
            parserParams.put(ParserUtil.PAGE, page);

            //站点编号
            if (BasicUtil.getWebsiteApp() != null) {
                parserParams.put(ParserUtil.APP_DIR, BasicUtil.getWebsiteApp().getAppDir());
                parserParams.put(ParserUtil.URL, BasicUtil.getWebsiteApp().getAppHostUrl());
                parserParams.put(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getAppId());
            } else {
                parserParams.put(ParserUtil.URL, BasicUtil.getUrl());
                parserParams.put(ParserUtil.APP_DIR, BasicUtil.getApp().getAppDir());
            }

            parserParams.put(ParserUtil.COLUMN, column);
            //标签中使用field获取当前栏目
            parserParams.put(ParserUtil.FIELD, column);


            //对项目名预处理
            String contextPath = BasicUtil.getContextPath();
            if (StringUtils.isNotBlank(contextPath) && "/".equalsIgnoreCase(contextPath) ){
                contextPath = "";
            }
            parserParams.putIfAbsent(ParserUtil.CONTEXT_PATH, contextPath);

            String columnListPath;
            ModelEntity contentModel = null;
            // 判断当前栏目是否有自定义模型
            if (column.getMdiyModelId() != null) {
                // 通过栏目模型编号获取自定义模型实体
                contentModel = (ModelEntity) SpringUtil.getBean(ModelBizImpl.class).getById(column.getMdiyModelId());
            }

            if (contentModel != null) {
                // 将自定义模型编号设置为key值
                parserParams.put(ParserUtil.TABLE_NAME, contentModel.getModelTableName());
            }

            int pageNo = 1;
            //文章列表页没有写文章列表标签，总数为0
            if (totalPageSize <= 0) {
                // 数据库中第一页是从开始0*size
                columnListPath = ParserUtil.buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.INDEX, htmlDir, parserParams.get(ParserUtil.APP_DIR).toString());
                // 设置分页的起始位置
                page.setPageNo(pageNo);
                String read = ParserUtil.rendering(File.separator + column.getCategoryListUrl(), parserParams);
                FileUtil.writeString(read, columnListPath, Const.UTF8);

            } else {
                // 遍历分页
                for (int i = 0; i < totalPageSize; i++) {
                    if (i == 0) {
                        // 数据库中第一页是从开始0*size
                        // 首页路径index.html
                        columnListPath = ParserUtil
                                .buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.INDEX, htmlDir, parserParams.get(ParserUtil.APP_DIR).toString());
                    } else {
                        // 其他路径list-2.html
                        columnListPath = ParserUtil
                                .buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.PAGE_LIST + pageNo, htmlDir, parserParams.get(ParserUtil.APP_DIR).toString());
                    }
                    // 设置分页的起始位置
                    page.setPageNo(pageNo);
                    String read = ParserUtil.rendering(File.separator + column.getCategoryListUrl(), parserParams);
                    FileUtil.writeString(read, columnListPath, Const.UTF8);
                    pageNo++;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 生成内容
     *
     * @param articleIdList 文章集合
     * @return
     * @throws IOException
     * @throws ParseException
     * @throws MalformedTemplateNameException
     * @throws TemplateNotFoundException
     */
    public static void generateBasic(List<CategoryBean> articleIdList, String htmlDir,Date datetime) {


        Map<String, Object> parserParams = new HashMap<String, Object>();
        parserParams.put(ParserUtil.IS_DO, false);
        if (BasicUtil.getWebsiteApp() != null) {
            parserParams.put(ParserUtil.APP_DIR, BasicUtil.getWebsiteApp().getAppDir());
            parserParams.put(ParserUtil.URL, BasicUtil.getWebsiteApp().getAppHostUrl());
            parserParams.put(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getAppId());
        } else {
            parserParams.put(ParserUtil.URL, BasicUtil.getUrl());
            parserParams.put(ParserUtil.APP_DIR, BasicUtil.getApp().getAppDir());
        }

        parserParams.put(ParserUtil.HTML, htmlDir);

        //对项目名预处理
        String contextPath = BasicUtil.getContextPath();
        if (StringUtils.isNotBlank(contextPath) && "/".equalsIgnoreCase(contextPath) ){
            contextPath = "";
        }
        parserParams.putIfAbsent(ParserUtil.CONTEXT_PATH, contextPath);


        Map<Object, Object> contentModelMap = new HashMap<Object, Object>();
        ModelEntity contentModel = null;
        // 记录已经生成了文章编号
        List<String> generateIds = new ArrayList<>();
        // 生成文章
        for (int artId = 0; artId < articleIdList.size(); ) {


            CategoryBean categoryBean = articleIdList.get(artId);
            String writePath = null;
            //设置分页类
            PageBean page = new PageBean();
            // 文章编号
            String articleId = categoryBean.getArticleId();
            // 文章的栏目路径
            String articleColumnPath = categoryBean.getCategoryPath();
            // 该文章相关分类
            String categoryParentId = categoryBean.getId();
            if (StringUtils.isNotBlank(categoryBean.getCategoryParentIds())) {
                categoryParentId += ',' + categoryBean.getCategoryParentIds();
            }
            // 文章的模板路径
            String columnUrl = categoryBean.getCategoryUrl();
            LOG.debug("columnUrl {}",columnUrl);
            // 文章的栏目模型编号
            String columnContentModelId = null;
            if (StringUtils.isNotBlank(articleIdList.get(artId).getMdiyModelId()) && StringUtils.isNotBlank(categoryBean.getMdiyModelId())) {
                columnContentModelId = categoryBean.getMdiyModelId();
            }

            // 文章是否已经生成了，生成了就跳过
            if (generateIds.contains(articleId)) {
                artId++;
                continue;
            }

            // 判断文件是否存在，若不存在弹出返回信息
            if (!FileUtil.exist(ParserUtil.buildTemplatePath(columnUrl)) || categoryBean.getId() == null || categoryBean.getCategoryType() == null) {
                artId++;
                continue;
            }
            // 将
            generateIds.add(articleId);
            //如果是封面就生成index.html
            if (categoryBean.getCategoryType().equals(CategoryTypeEnum.COVER.toString())) {
                writePath = ParserUtil.buildHtmlPath(articleColumnPath + File.separator + ParserUtil.INDEX, htmlDir, parserParams.get(ParserUtil.APP_DIR).toString());
            } else {
                // 组合文章路径如:html/站点id/栏目id/文章id.html
                writePath = ParserUtil.buildHtmlPath(articleColumnPath + File.separator + articleId, htmlDir, parserParams.get(ParserUtil.APP_DIR).toString());
            }


            parserParams.put(ParserUtil.COLUMN, categoryBean);


            // 判断当前栏目是否有自定义模型
            if (columnContentModelId != null) {
                // 通过当前栏目的模型编号获取，自定义模型表名
                if (contentModelMap.containsKey(columnContentModelId)) {
                    parserParams.put(ParserUtil.TABLE_NAME, contentModel.getModelTableName());
                } else {
                    // 通过栏目模型编号获取自定义模型实体
                    contentModel = (ModelEntity) SpringUtil.getBean(IModelBiz.class)
                            .getById(columnContentModelId);
                    if (null!=contentModel){
                        // 将自定义模型编号设置为key值
                        contentModelMap.put(columnContentModelId, contentModel.getModelTableName());
                        parserParams.put(ParserUtil.TABLE_NAME, contentModel.getModelTableName());
                    }
                }
            }

            parserParams.put(ParserUtil.ID, articleId);

            // 第一篇文章没有上一篇
            if (artId > 0) {
                CategoryBean preCaBean = articleIdList.get(artId - 1);
                //判断当前文档是否与上一页文章在同一栏目下，并且不能使用父栏目字符串，因为父栏目中没有所属栏目编号
//				if( categoryParentId.contains(preCaBean.getCategoryId()+"")){
                page.setPreId(preCaBean.getArticleId());
//				}
            }

            // 最后一篇文章没有下一篇
            if (artId + 1 < articleIdList.size()) {
                CategoryBean nextCaBean = articleIdList.get(artId + 1);
                //判断当前文档是否与下一页文章在同一栏目下并且不能使用父栏目字符串，因为父栏目中没有所属栏目编号
//				if(categoryParentId.contains(nextCaBean.getCategoryId()+"")){
                page.setNextId(nextCaBean.getArticleId());
//				}
            }

            // 文章更新时间在指定时间之前 跳过
            if (datetime != null && categoryBean.getContentUpdateDate().before(datetime)){
                artId++;
                continue;
            }




            parserParams.put(ParserUtil.PAGE, page);
            String finalWritePath = writePath;
            HashMap<Object, Object> cloneMap = MapUtil.newHashMap();
            cloneMap.putAll(parserParams);
            HttpServletRequest request = SpringUtil.getRequest();
            String content = null;
            try {
                content = ParserUtil.rendering(columnUrl, cloneMap);
                FileUtil.writeString(content, finalWritePath, Const.UTF8);
            } catch (IOException e) {
                e.printStackTrace();
            }
            artId++;
        }
    }
}
