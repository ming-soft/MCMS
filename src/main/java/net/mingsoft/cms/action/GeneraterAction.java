/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

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
import cn.hutool.core.io.FileUtil;
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
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.util.CmsParserUtil;
import net.mingsoft.mdiy.bean.AttributeBean;
import net.mingsoft.mdiy.bean.PageBean;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @ClassName: GeneraterAction
 * @Description:TODO 生成器
 * @author: 铭飞开发团队
 * @date: 2018年1月31日 下午2:52:07
 *
 * @Copyright: 2018 www.mingsoft.net Inc. All rights reserved.
 */
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

	/**



	/**
	 * 更新主页
	 *
	 * @return
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest request, ModelMap model) {
		return "/cms/generate/index";
	}

	/**
	 * 生成主页
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping("/generateIndex")
	@RequiresPermissions("cms:generate:index")
    @LogAnn(title = "生成主页", businessType = BusinessTypeEnum.UPDATE)
	@ResponseBody
	public ResultData generateIndex(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 模版文件名称
		String tmpFileName = request.getParameter("url");
		// 生成后的文件名称
		String generateFileName = request.getParameter("position");

		// 获取文件所在路径 首先判断用户输入的模版文件是否存在
		if (!FileUtil.exist(ParserUtil.buildTempletPath())) {
		    return ResultData.build().error(getResString("templet.file"));
		} else {
            CmsParserUtil.generate(tmpFileName, generateFileName);
            return ResultData.build().success();
		}
	}



	/**
	 * 生成列表的静态页面
	 *
	 * @param request
	 * @param response
	 * @param CategoryId
	 */
	@RequestMapping("/{CategoryId}/genernateColumn")
    @LogAnn(title = "生成栏目", businessType = BusinessTypeEnum.UPDATE)
	@RequiresPermissions("cms:generate:column")
	@ResponseBody
	public ResultData genernateColumn(HttpServletRequest request, HttpServletResponse response, @PathVariable int CategoryId) throws IOException {
		// 获取站点id
		AppEntity app = BasicUtil.getApp();
		List<CategoryEntity> columns = new ArrayList<CategoryEntity>();
		// 如果栏目id小于0则更新所有的栏目，否则只更新选中的栏目
		if (CategoryId>0) {
			CategoryEntity categoryEntity = new CategoryEntity();
			categoryEntity.setId(CategoryId+"");
			columns = categoryBiz.queryChilds(categoryEntity);
		} else {
			// 获取所有的内容管理栏目
            CategoryEntity categoryEntity=new CategoryEntity();
			columns = categoryBiz.query(categoryEntity);
		}
		List<CategoryBean> articleIdList = null;
			// 1、设置模板文件夹路径
			// 获取栏目列表模版
			for (CategoryEntity column : columns) {
				ContentBean contentBean = new ContentBean();
				contentBean.setContentCategoryId(column.getId());
				// 分类是列表
				if(column.getCategoryType().equals("1")) {
					// 判断模板文件是否存在
					if (!FileUtil.exist(ParserUtil.buildTempletPath(column.getCategoryListUrl()))) {
						LOG.error("模板不存在：{}", column.getCategoryUrl());
						continue;
					}
					//获取模板中列表标签中的条件
					Map<String, Object> map = new HashMap<>();
					map.put(ParserUtil.APP_ID, BasicUtil.getAppId());
					PageBean page = new PageBean();
					map.put(ParserUtil.HTML, ParserUtil.HTML);
					map.put(ParserUtil.URL, BasicUtil.getUrl());
					map.put(ParserUtil.PAGE, page);
					AttributeBean attributeBean = new AttributeBean();
					// 获取文章列表模板标签属性
					ParserUtil.read(column.getCategoryListUrl(), map, page, attributeBean);
					contentBean.setFlag(attributeBean.getFlag());
					contentBean.setNoflag(attributeBean.getNoflag());
					contentBean.setOrder(attributeBean.getOrder());
					contentBean.setOrderBy(attributeBean.getOrderby());
				}
				articleIdList = contentBiz.queryIdsByCategoryIdForParser(contentBean);
				// 判断列表类型
				switch (column.getCategoryType()) {
					//TODO 暂时先用字符串代替
				case "1": // 列表
					CmsParserUtil.generateList(column, articleIdList.size());
					break;
				case "2":// 单页
					if(articleIdList.size()==0){
						CategoryBean columnArticleIdBean=new CategoryBean();
						CopyOptions copyOptions=CopyOptions.create();
						copyOptions.setIgnoreError(true);
						BeanUtil.copyProperties(column,columnArticleIdBean,copyOptions);
						articleIdList.add(columnArticleIdBean);
					}
					CmsParserUtil.generateBasic(articleIdList);
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
	@RequestMapping("/{columnId}/generateArticle")
	@RequiresPermissions("cms:generate:article")
    @LogAnn(title = "生成文章", businessType = BusinessTypeEnum.UPDATE)
	@ResponseBody
	public ResultData generateArticle(HttpServletRequest request, HttpServletResponse response, @PathVariable String columnId) throws IOException {
		String dateTime = request.getParameter("dateTime");
		// 网站风格物理路径
		List<CategoryBean> articleIdList = null;
		List<CategoryEntity> categoryList = null;
		AttributeBean attributeBean = new AttributeBean();
		ContentBean contentBean = new ContentBean();
		contentBean.setBeginTime(dateTime);
		Map<String, Object> map = new HashMap<>();
		map.put(ParserUtil.APP_ID, BasicUtil.getAppId());
		PageBean page = new PageBean();
		map.put(ParserUtil.HTML, ParserUtil.HTML);
		map.put(ParserUtil.URL, BasicUtil.getUrl());
		map.put(ParserUtil.PAGE, page);
		if(StringUtils.isNotEmpty(columnId)){
			CategoryEntity categoryEntity = new CategoryEntity();
			categoryList = categoryBiz.query(categoryEntity);
			for(CategoryEntity category : categoryList){
				contentBean.setContentCategoryId(category.getId());
				// 分类是列表
				if(category.getCategoryType().equals("1")){
					// 判断模板文件是否存在
					if (!FileUtil.exist(ParserUtil.buildTempletPath(category.getCategoryListUrl())) || StringUtils.isEmpty(category.getCategoryListUrl())) {
						LOG.error("模板不存在：{}",category.getCategoryUrl());
						continue;
					}
					// 获取文章列表表属性
					ParserUtil.read(category.getCategoryListUrl(),map, page,attributeBean);
					contentBean.setFlag(attributeBean.getFlag());
					contentBean.setNoflag(attributeBean.getNoflag());
					contentBean.setOrder(attributeBean.getOrder());
					contentBean.setOrderBy(attributeBean.getOrderby());
				}
				articleIdList = contentBiz.queryIdsByCategoryIdForParser(contentBean);
				// 有符合条件的就更新
				if (articleIdList.size() > 0) {
					CmsParserUtil.generateBasic(articleIdList);
				}
			}
		}else {
			CategoryEntity category = (CategoryEntity) categoryBiz.getEntity(Integer.parseInt(columnId));
			contentBean.setContentCategoryId(columnId);
			// 分类是列表
			if(category.getCategoryType().equals("1")){
				// 获取文章列表表属性
				// 判断模板文件是否存在
				if (!FileUtil.exist(ParserUtil.buildTempletPath(category.getCategoryUrl()))) {
					LOG.error("模板不存在：{}",category.getCategoryUrl());
                    return ResultData.build().error(getResString("templet.file"));
				}
				ParserUtil.read(category.getCategoryListUrl(),map, page,attributeBean);
				contentBean.setFlag(attributeBean.getFlag());
				contentBean.setNoflag(attributeBean.getNoflag());
				contentBean.setOrder(attributeBean.getOrder());
				contentBean.setOrderBy(attributeBean.getOrderby());
			}
			articleIdList = contentBiz.queryIdsByCategoryIdForParser(contentBean);
			// 有符合条件的就更新
			if (articleIdList.size() > 0) {
				CmsParserUtil.generateBasic(articleIdList);
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
	@RequestMapping("/{position}/viewIndex")
	public String viewIndex(HttpServletRequest request, @PathVariable String position, HttpServletResponse response) {
		AppEntity app = BasicUtil.getApp();
		// 组织主页预览地址
		String indexPosition = app.getAppHostUrl() + File.separator + ParserUtil.HTML + File.separator + app.getAppId()
				+ File.separator + position + ParserUtil.HTML_SUFFIX;
		return "redirect:" + indexPosition;
	}
}
