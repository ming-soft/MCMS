package com.mingsoft.cms.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONArray;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.CategoryEntity;
import com.mingsoft.cms.biz.IArticleBiz;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.cms.constant.e.ColumnTypeEnum;
import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.cms.parser.CmsParser;
import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.StringUtil;
import com.mingsoft.util.proxy.Header;
import com.mingsoft.util.proxy.Proxy;
import com.mingsoft.util.proxy.Result;

/**
 * 
 * <p>
 * <b>mswx-铭飞微信酒店预订平台</b>
 * </p>
 * 
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 成卫雄
 * 
 * @version 300-001-001
 * 
 *          <p>
 *          版权所有 铭飞科技
 *          </p>
 * 
 *          <p>
 *          Comments:应用静态生成，适用于静态信息的应用，例如网站、商城、，但是像论坛这些就不需要这些生成功能；
 *          </p>
 * 
 *          <p>
 *          Create Date:2014-8-6
 *          </p>
 * 
 *          <p>
 *          Modification history:
 *          </p>
 */
@Controller("cmsGenerater")
@RequestMapping("/manager/cms/generate")
@Scope("request")
public class GeneraterAction extends BaseAction {

	/**
	 * 文章管理业务层
	 */
	@Autowired
	private IArticleBiz articleBiz;

	/**
	 * 栏目管理业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;

	/**
	 * 站点管理业务层
	 */
	@Autowired
	private IAppBiz appBiz;
	
	/**
	 * 模块管理业务层
	 */
	@Autowired
	private IModelBiz modelBiz;

	/**
	 * 文章解析器
	 */
	@Autowired
	private CmsParser cmsParser;

	/**
	 * 一键更新所有
	 * 
	 * @return
	 */
	@RequestMapping("/all")
	public String all() {
		return "/manager/cms/generate/generate_all";
	}
	
	/**
	 * 手机端模板前缀
	 */
	public static final String MOBILE = "m";

	/**
	 * 更新主页
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "/manager/cms/generate/generate_index";
	}

	/**
	 * 生成主页
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/generateIndex")
	@ResponseBody
	public boolean generateIndex(HttpServletRequest request, HttpServletResponse response) {
		String tmpFileName = request.getParameter("url"); // 模版文件名称
		String generateFileName = request.getParameter("position");// 生成后的文件名称

		// 获取站点信息
		int websiteId = getManagerBySession(request).getBasicId();
		AppEntity app = (AppEntity) appBiz.getEntity(websiteId);
		String tmpName = app.getAppStyle();// 获取模版名称
		String tmpPath = getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE); // 获取系统模版存放物理路径
		String webSiteTmpPath = tmpPath + File.separator + app.getAppId() + File.separator + tmpName;// 根据站点id组装站点信息路径　格式：templets／站点ID/模版风格
		// 模版路径加上(用户选择的主页的模版的路径)default/index.html
		String tmpFilePath = webSiteTmpPath + File.separator + tmpFileName;
		//读取手机端的模板
		String tmpMobileFilePath = webSiteTmpPath + File.separator + MOBILE + File.separator + tmpFileName;// 手机端

		// 生成地址
		String generatePath = getRealPath(request, IParserRegexConstant.HTML_SAVE_PATH) + File.separator + websiteId + File.separator + generateFileName;
		String generateMobilePath = getRealPath(request, IParserRegexConstant.HTML_SAVE_PATH) + File.separator + websiteId + File.separator + MOBILE + File.separator + generateFileName;
		//生成保存htm页面的文件夹
		FileUtil.createFolder(getRealPath(request, IParserRegexConstant.HTML_SAVE_PATH) + File.separator + websiteId);
		FileUtil.createFolder(getRealPath(request, IParserRegexConstant.HTML_SAVE_PATH) + File.separator + websiteId + File.separator + MOBILE); // 手机端
		// 获取文件所在路径 首先判断用户输入的模版文件是否存在
		File file = new File(tmpFilePath);

		// 判断文件是否存在，若不存在弹出返回信息
		if (!file.exists()) {
			return false;
		} else {
			// 当前模版的物理路径
			String htmlContent = FileUtil.readFile(tmpFilePath); // 读取模版文件内容
			String mobileHtmlContent = FileUtil.readFile(tmpMobileFilePath); // 读取手机端模版文件内容
			if (!StringUtil.isBlank(htmlContent)) {
				//进行html的解析
				htmlContent = cmsParser.parse(htmlContent,app);
				Map map = new HashMap();
				map.put(CmsParser.MOBILE,this.MOBILE);
				mobileHtmlContent = cmsParser.parse(mobileHtmlContent,app,map);
				// 解析HTML上的标签
				FileUtil.writeFile(htmlContent, generatePath, FileUtil.URF8);
				FileUtil.writeFile(mobileHtmlContent, generateMobilePath, FileUtil.URF8);
				return true;
			} else {
				// 提示错误：未找到模版
				htmlContent = webSiteTmpPath + File.separator + tmpFileName ;
			}
			return false;
		}
	}

	/**
	 * 生成列表的静态页面
	 * 
	 * @param request
	 * @param response
	 * @param columnId
	 */
	@RequestMapping("/{columnId}/genernateColumn")
	@ResponseBody
	public boolean genernateColumn(HttpServletRequest request, HttpServletResponse response, @PathVariable int columnId) {
		// 获取站点id
		int appId = getManagerBySession(request).getBasicId();
		AppEntity app = (AppEntity) appBiz.getEntity(appId);
		String mobileStyle = app.getAppMobileStyle(); // 手机端模版
		String url = app.getAppHostUrl() + File.separator + IParserRegexConstant.HTML_SAVE_PATH + File.separator + app.getAppId();
		// 站点生成后保存的html地址
		String generatePath = getRealPath(request, IParserRegexConstant.HTML_SAVE_PATH) + File.separator + appId + File.separator;
		FileUtil.createFolder(generatePath);
		// 网站风格物理路径
		String tmpPath = getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE) + File.separator + appId + File.separator + app.getAppStyle();
		List<ColumnEntity> columns = new ArrayList<ColumnEntity>();
		// 如果栏目id小于0则更新所有的栏目，否则只更新选中的栏目
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		if (columnId > 0) {
			List<CategoryEntity> categorys = columnBiz.queryChildrenCategory(columnId, app.getAppId(),modelId);
			for (CategoryEntity c : categorys) {
				columns.add((ColumnEntity) columnBiz.getEntity(c.getCategoryId()));
			}
		} else {
			
			//获取所有的内容管理栏目
			columns = columnBiz.queryAll(app.getAppId(),modelId);
		}
		// 获取栏目列表模版
		for (ColumnEntity column : columns) {
			String columnPath = null;// pc端
			String mobilePath = null;// 手机端

			// 生成列表保存路径
			FileUtil.createFolder(generatePath + column.getColumnPath());
			// 判断是否为顶级栏目，进行栏目路径的组合
			if (column.getCategoryCategoryId() == 0) {
				FileUtil.createFolder(generatePath + column.getCategoryId());
				columnPath = generatePath + File.separator + column.getCategoryId();
				if (!StringUtil.isBlank(mobileStyle)) {
					FileUtil.createFolder(generatePath + mobileStyle + File.separator + column.getCategoryId());
					mobilePath = generatePath + mobileStyle + File.separator + column.getCategoryId();
				}
			} else {
				if (!StringUtil.isBlank(mobileStyle)) {
					mobilePath = generatePath + mobileStyle + File.separator + column.getColumnPath();
					FileUtil.createFolder(mobilePath);
				}
				columnPath = generatePath + column.getColumnPath();
			}
			// 判断列表类型
			switch (column.getColumnType()) {
			case ColumnEntity.COLUMN_TYPE_LIST: // 列表
				// 手机列表模版
				if (!StringUtil.isBlank(mobileStyle)) {
					FileUtil.createFolder(mobilePath);
					String mobileListTtmpContent = FileUtil.readFile(tmpPath + File.separator + mobileStyle + File.separator + column.getColumnListUrl());
					// 如果模版不为空就进行标签替换
					if (!StringUtil.isBlank(mobileListTtmpContent)) {
						// 生成手机端模版
						// 要生成手机的静态页面数
						int mobilePageSize = cmsParser.getPageSize(app, mobileListTtmpContent, column);
						// 根据页面数,循环生成静态页面个数在
						Map map = new HashMap();
						for (int i = 0; i < mobilePageSize; i++) {
							String writePath = mobilePath + File.separator + IParserRegexConstant.PAGE_LIST + (i + 1) + IParserRegexConstant.HTML_SUFFIX;
							if (i == 0) {
								writePath = mobilePath + File.separator + IParserRegexConstant.HTML_INDEX;
							}
							String pagePath = url + File.separator + mobileStyle + File.separator + column.getColumnPath() + File.separator + IParserRegexConstant.PAGE_LIST ;
							map.put(CmsParser.LIST_LINK_PATH, pagePath);
							map.put(CmsParser.CUR_PAGE_NO, i + 1);
							map.put(CmsParser.MOBILE,this.MOBILE);
							String pageContent = cmsParser.parse(mobileListTtmpContent,app,column,map);
							FileUtil.writeFile(pageContent, writePath, FileUtil.URF8);// 写文件
						}
					}

				}

				// 读取列表模版地址
				String listTtmpContent = FileUtil.readFile(tmpPath + File.separator + column.getColumnListUrl());
				// 要生成的静态页面数
				int pageSize = cmsParser.getPageSize(app, listTtmpContent, column);// generaterFactory.getPageSize(app, listTtmpContent, column);
				// 根据页面数,循环生成静态页面个数在
				Map map = new HashMap();
				for (int i = 0; i < pageSize; i++) {
					String writePath = columnPath + File.separator + IParserRegexConstant.PAGE_LIST + (i + 1) + IParserRegexConstant.HTML_SUFFIX;
					if (i == 0) {
						writePath = columnPath + File.separator + IParserRegexConstant.HTML_INDEX;
					}
					String pagePath = app.getAppHostUrl() + File.separator + IParserRegexConstant.HTML_SAVE_PATH + File.separator + app.getAppId() + File.separator + column.getColumnPath() + File.separator + "list";
					map.put(CmsParser.LIST_LINK_PATH, pagePath);
					map.put(CmsParser.CUR_PAGE_NO, i + 1);
					String pageContent = cmsParser.parse(listTtmpContent,app, column,map);
					FileUtil.writeFile(pageContent, writePath, FileUtil.URF8);// 写文件
				}
				break;
			case ColumnEntity.COLUMN_TYPE_COVER:// 单页
				// 取该栏目的最后一篇新闻作为显示内容
				List<ArticleEntity> list = articleBiz.queryListByColumnId(column.getCategoryId());
				// 手机端
				if (!StringUtil.isBlank(mobileStyle)) {
					String writePath = "";
					// 读取封面模板内容
					String coverTtmpContent = FileUtil.readFile(tmpPath + File.separator + mobileStyle + File.separator + column.getColumnUrl());
					// 如果模版不为空就进行标签替换
					if (!StringUtil.isBlank(coverTtmpContent)) {
						map = new HashMap();
						map.put(CmsParser.MOBILE,this.MOBILE);
						// 文章地址前缀
						// 表示该栏目下面没有文章
						if (list == null || list.size() == 0) {
							FileUtil.createFolder(mobilePath);
							writePath = mobilePath + File.separator + IParserRegexConstant.HTML_INDEX;
							
							String coverContent = cmsParser.parse(coverTtmpContent,app,column,map); //generaterFactory.builder(app, column, coverTtmpContent, tmpPath, mobileStyle); // 解析标签
							// 取最后一篇文章作为栏目内容
							FileUtil.writeFile(coverContent, writePath, FileUtil.URF8);// 写文件
							break;
						}
						ArticleEntity article = list.get(0);// 取一篇文章作为封面栏目的内容
						// 判断是否为顶级栏目
						if (column.getCategoryCategoryId() == 0) {
							String path = mobilePath + File.separator;
							FileUtil.createFolder(path);
							writePath = path + File.separator + IParserRegexConstant.HTML_INDEX;
							// 设置文章连接地址
							article.setArticleLinkURL(url + File.separator + mobileStyle + File.separator + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
						} else {// 子栏目，子栏目需要获取父级栏目的编号
							writePath = mobilePath + File.separator + IParserRegexConstant.HTML_INDEX;
							article.setArticleLinkURL(url + File.separator + mobileStyle + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
						}
						String coverContent =  cmsParser.parse(coverTtmpContent,app,column,article,map);//generaterFactory.builderArticle(app, column, article, coverTtmpContent, tmpPath, null, null, mobileStyle); // 解析标签
						// 取最后一篇文章作为栏目内容
						FileUtil.writeFile(coverContent, writePath, FileUtil.URF8);// 写文件
					}

				}

				String writePath = "";
				// 读取封面模板内容
				String coverTtmpContent = FileUtil.readFile(tmpPath + File.separator + column.getColumnUrl());
				// 文章地址前缀
				// 表示该栏目下面没有文章
				if (list == null || list.size() == 0) {
					writePath = generatePath + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX;
					String coverContent = cmsParser.parse(coverTtmpContent,app,column);//generaterFactory.builder(app, column, coverTtmpContent, tmpPath); // 解析标签
																											// 取最后一篇文章作为栏目内容
					FileUtil.writeFile(coverContent, writePath, FileUtil.URF8);// 写文件
					break;
				}
				ArticleEntity article = list.get(0);// 取一篇文章作为封面栏目的内容
				// 判断是否为顶级栏目
				if (column.getCategoryCategoryId() == 0) {
					FileUtil.createFolder(generatePath + column.getCategoryId());
					writePath = generatePath + String.valueOf(column.getCategoryId()) + File.separator + IParserRegexConstant.HTML_INDEX;
					// 设置文章连接地址
					article.setArticleLinkURL(url + File.separator + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
				} else {// 子栏目，子栏目需要获取父级栏目的编号
					writePath = generatePath + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX;
					article.setArticleLinkURL(url + File.separator + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
				}
				String coverContent = cmsParser.parse(coverTtmpContent,app,column,article);//generaterFactory.builderArticle(app, column, article, coverTtmpContent, tmpPath, null, null); // 解析标签
																																	// 取最后一篇文章作为栏目内容
				FileUtil.writeFile(coverContent, writePath, FileUtil.URF8);// 写文件
				break;
			}
		}
		return true;
	}

	/**
	 * 更新文档
	 * 
	 * @return
	 */
	@RequestMapping("/article")
	public String article(HttpServletRequest request,ModelMap model) {
		
		// 获取站点ID和模块ID
		int websiteId =  this.getAppId(request);
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId();
		
		//获取所有的内容管理栏目
		List<ColumnEntity> list  = columnBiz.queryAll(websiteId,modelId);
		
		model.addAttribute("now", new Date());
		model.addAttribute("list",  JSONArray.toJSONString(list));
		return "/manager/cms/generate/generate_article";
	}

	/**
	 * 更新商品
	 * 
	 * @return
	 */
	@RequestMapping("/product")
	public String product(HttpServletRequest request) {
		request.setAttribute("now", new Date());
		return "/manager/cms/generate/generate_product";
	}

	/**
	 * 根据栏目id更新所有的文章
	 * 
	 * @param request
	 * @param response
	 * @param columnId
	 */
	@RequestMapping("/{columnId}/generateArticle")
	@ResponseBody
	public boolean generateArticle(HttpServletRequest request, HttpServletResponse response, @PathVariable int columnId) {
		String dateTime = request.getParameter("dateTime");
		AppEntity app = this.getApp(request);
		String mobileStyle = null;
		if (app != null) {
			mobileStyle = app.getAppMobileStyle(); // 手机端模版
		}

		String generatePath = getRealPath(request, IParserRegexConstant.HTML_SAVE_PATH) + File.separator + app.getAppId() + File.separator;// 站点生成后保存的html地址
		FileUtil.createFolder(generatePath);
		String tmpPath = getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE) + File.separator + app.getAppId() + File.separator + app.getAppStyle(); // 网站风格物理路径
		List<ArticleEntity> articleList = null;
		List<ColumnEntity> columns = new ArrayList<ColumnEntity>();
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		if (columnId > 0) {
			List<CategoryEntity> categorys = columnBiz.queryChildrenCategory(columnId, app.getAppId(),modelId);
			for (CategoryEntity c : categorys) {
				columns.add((ColumnEntity) columnBiz.getEntity(c.getCategoryId()));
			}
		} else {
			columns = columnBiz.queryColumnListByWebsiteId(app.getAppId()); // 读取所有栏目
		}
		String url = app.getAppHostUrl() + File.separator + IParserRegexConstant.HTML_SAVE_PATH + File.separator + app.getAppId() + File.separator; // 文章地址前缀
		// 如果没有选择栏目，生成规则
		// 1先读取所有的栏目,从最低级的分类取
		for (ColumnEntity tempColumn : columns) {// 循环分类
			FileUtil.createFolder(generatePath + tempColumn.getColumnPath());
			String writePath = null;
			articleList = articleBiz.query(tempColumn.getCategoryId(), dateTime, app.getAppId());// .queryListByColumnId(tempColumn.getCategoryId());
			// 有符合条件的新闻就更新
			if (articleList.size() > 0) {
				// 生成文档
				switch (tempColumn.getColumnType()) {
				case ColumnEntity.COLUMN_TYPE_LIST: // 列表
					String tmpContent = FileUtil.readFile(tmpPath + File.separator + tempColumn.getColumnUrl());// 读取文章模版地址
					String mobileTmpContent = null;
					if (!StringUtil.isBlank(mobileStyle)) {
						mobileTmpContent = FileUtil.readFile(tmpPath + File.separator + mobileStyle + File.separator + tempColumn.getColumnUrl());// 读取手机端文章模版地址
					}
					for (int ai = 0; ai < articleList.size();) {
						ArticleEntity article = articleList.get(ai);
						if (tempColumn.getCategoryCategoryId() == 0) { // 如果是顶级下面有文章，那么文章的生成地址就是　分类id/文章编号
							FileUtil.createFolder(generatePath + tempColumn.getCategoryId());
							// 组合文章路径如:html/站点id/栏目id/文章id.html
							writePath = generatePath + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX;
							article.setArticleLinkURL(url + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
						} else { // 如果有父级别编号，需要组合路径。格式如:父ID/子id/文章id.html
							String path = File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX;
							writePath = generatePath + tempColumn.getColumnPath() + File.separator + path;
							article.setArticleLinkURL(url + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
						}
						ArticleEntity previous = articleBiz.getPrevious(app.getAppId(), article.getArticleID(),article.getBasicCategoryId());// 上一篇文章
						ArticleEntity next = articleBiz.getNext(app.getAppId(), article.getArticleID(),article.getBasicCategoryId());// 下一篇文章
						if(article.getColumn()!=null){
							if (previous != null) {
								previous.setArticleLinkURL(url + article.getColumn().getColumnPath() + File.separator + previous.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
							}
							if (next != null) {
								next.setArticleLinkURL(url +  article.getColumn().getColumnPath() + File.separator + next.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
							}
						}
						
						Map map = new HashMap();
						map.put(CmsParser.PREVIOUS, previous);
						map.put(CmsParser.NEXT, next);
						
						String content =  cmsParser.parse(tmpContent,app,tempColumn,article,map);
						FileUtil.writeFile(content, writePath, FileUtil.URF8);// 写文件

						// 手机端
						if (!StringUtil.isBlank(mobileTmpContent)) {
							FileUtil.createFolder(generatePath + mobileStyle + File.separator + tempColumn.getColumnPath());
							if (tempColumn.getCategoryCategoryId() == 0) { // 如果是顶级下面有文章，那么文章的生成地址就是　分类id/文章编号

								// 组合文章路径如:html/站点id/栏目id/文章id.html
								writePath = generatePath + mobileStyle + File.separator + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX;
								article.setArticleLinkURL(url + mobileStyle + File.separator + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
							} else { // 如果有父级别编号，需要组合路径。格式如:父ID/子id/文章id.html
								String path = File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX;
								writePath = generatePath + mobileStyle + File.separator + tempColumn.getColumnPath() + File.separator + path;
								article.setArticleLinkURL(url + mobileStyle + File.separator + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
							}
							if(article.getColumn()!=null){
								if (previous != null) {
									previous.setArticleLinkURL(url + mobileStyle + File.separator + article.getColumn().getColumnPath() + File.separator + previous.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
								}
								if (next != null) {
									next.setArticleLinkURL(url + mobileStyle + File.separator + article.getColumn().getColumnPath() + File.separator + next.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
								}
							}
							
							map.put(CmsParser.MOBILE,this.MOBILE);
							String tmp = cmsParser.parse(mobileTmpContent,app,tempColumn,article,map);//;generaterFactory.builderArticle(app, tempColumn, article, mobileTmpContent, tmpPath, previous, next, mobileStyle); // 解析标签
							FileUtil.writeFile(tmp, writePath, FileUtil.URF8);// 写文件
						}

						ai++;

					}
					break;
				// case ColumnEntity.COLUMN_TYPE_COVER:// 单页
				// writePath = null;
				// // 取该栏目的最后一篇新闻作为显示内容
				// List<ArticleEntity> list =
				// articleBiz.queryListByColumnId(tempColumn.getCategoryId());
				//
				// String coverTtmpContent = FileUtil.readFile(tmpPath +
				// File.separator + tempColumn.getColumnUrl());// 读取文章模版地址
				// if (list == null || list.size() == 0) { // 表示该栏目下面没有文章
				// break;
				// }
				// ArticleEntity article = list.get(0);// 取一篇文章作为封面栏目的内容
				// // 判断是否 顶级栏目
				// if (tempColumn.getCategoryCategoryId() == 0) {
				// FileUtil.createFolder(generatePath +
				// tempColumn.getCategoryId());
				// writePath = generatePath +
				// String.valueOf(tempColumn.getCategoryId()) + File.separator +
				// RegexConstant.HTML_INDEX;
				// // 设置文章连接地址
				// article.setArticleLinkURL(url + tempColumn.getColumnPath() +
				// File.separator + RegexConstant.HTML_INDEX);
				// } else {// 子栏目，子栏目需要获取父级栏目的编号
				// writePath = generatePath + tempColumn.getColumnPath() +
				// File.separator + RegexConstant.HTML_INDEX;
				// article.setArticleLinkURL(url + tempColumn.getColumnPath() +
				// File.separator + RegexConstant.HTML_INDEX);
				// }
				//
				// String coverContent = generaterFactory.builderArticle(app,
				// tempColumn, article, coverTtmpContent, tmpPath, null, null);
				// // 解析标签
				//
				// FileUtil.writeFile(coverContent, writePath, FileUtil.URF8);//
				// 写文件
				//
				// //移动端
				// if (!StringUtil.isBlank(mobileStyle)) {
				// String temContent = FileUtil.readFile(tmpPath +
				// File.separator + mobileStyle + File.separator +
				// tempColumn.getColumnUrl());// 读取文章模版地址
				// if (list == null || list.size() == 0) { // 表示该栏目下面没有文章
				// break;
				// }
				// // 判断是否 顶级栏目
				// if (tempColumn.getCategoryCategoryId() == 0) {
				// FileUtil.createFolder(generatePath + mobileStyle +
				// File.separator + tempColumn.getCategoryId());
				// writePath = generatePath +mobileStyle+ File.separator +
				// String.valueOf(tempColumn.getCategoryId()) + File.separator +
				// RegexConstant.HTML_INDEX;
				// // 设置文章连接地址
				// article.setArticleLinkURL(url + File.separator + mobileStyle
				// + tempColumn.getColumnPath() + File.separator +
				// RegexConstant.HTML_INDEX);
				// } else {// 子栏目，子栏目需要获取父级栏目的编号
				// writePath = generatePath +mobileStyle+ File.separator +
				// tempColumn.getColumnPath() + File.separator +
				// RegexConstant.HTML_INDEX;
				// FileUtil.createFolder(generatePath + mobileStyle +
				// File.separator + tempColumn.getColumnPath());
				// article.setArticleLinkURL(url + File.separator + mobileStyle
				// + tempColumn.getColumnPath() + File.separator +
				// RegexConstant.HTML_INDEX);
				// }
				//
				// String temp = generaterFactory.builderArticle(app,
				// tempColumn, article, coverTtmpContent, tmpPath, null,
				// null,mobileStyle); // 解析标签
				//
				// FileUtil.writeFile(temp, writePath, FileUtil.URF8);// 写文件
				// }
				//
				//
				// break;
				}
			}

			/*
			 * else { switch (tempColumn.getColumnType()) { case
			 * ColumnEntity.COLUMN_TYPE_COVER: String coverTtmpContent =
			 * FileUtil.readFile(tmpPath + File.separator +
			 * tempColumn.getColumnUrl()); if
			 * (tempColumn.getCategoryCategoryId() == 0) { // 顶级栏目
			 * FileUtil.createFolder(generatePath + tempColumn.getCategoryId());
			 * } writePath = generatePath + tempColumn.getColumnPath() +
			 * File.separator + RegexConstant.HTML_INDEX; String coverContent =
			 * generaterFactory.builderIndex(app, tempColumn, coverTtmpContent,
			 * tmpPath); // 解析标签 // 取最后一篇文章作为栏目内容
			 * FileUtil.writeFile(coverContent, writePath, FileUtil.URF8);// 写文件
			 * break; } }
			 */
		}
		return true;
	}

	/**
	 * 提供给保存与编辑文章时使用
	 * 
	 * @param request
	 * @param response
	 * @param columnId
	 *            　栏目编号
	 */
	@RequestMapping("/{columnId}/genernateForArticle")
	@ResponseBody
	public void genernateForArticle(HttpServletResponse response, HttpServletRequest request, @PathVariable int columnId) {
		// 生成html
		// 1、更新文章
		Map parms = new HashMap();
		parms.put("dateTime", StringUtil.getSimpleDateStr(new Date(), "yyyy-MM-dd"));
		Header header = new Header(this.getHost(request), Const.UTF8);
		String cookie = "";
		for (Cookie c : request.getCookies()) {
			cookie += c.getName() + "=" + c.getValue() + ";";
		}
		header.setCookie(cookie);
		Result re = Proxy.get(this.getUrl(request) + "/manager/cms/generate/" + columnId + "/generateArticle.do", header, parms, Const.UTF8);
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(columnId);
		if (column != null && column.getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {
			Proxy.get(this.getUrl(request) + "/manager/cms/generate/" + columnId + "/genernateColumn.do", header, null, Const.UTF8);
		}
		// 2、更新栏目
		// Proxy.get(this.getUrl(request)+"/manager/cms/generate/"+columnId+"/genernateColumn.do",
		// header, null, Const.UTF8);

		// 3主
		Map map = new HashMap();
		map.put("url", IParserRegexConstant.REGEX_INDEX_HTML);
		map.put("position", IParserRegexConstant.HTML_INDEX);
		Proxy.get(this.getUrl(request) + "/manager/cms/generate/generateIndex.do", header, map, Const.UTF8);

		this.outJson(response, ModelCode.CMS_GENERATE_ARTICLE, true);
	}

	/**
	 * 根据栏目id更新所有的文章
	 * 
	 * @param request
	 * @param response
	 * @param columnId
	 */
	@RequestMapping("/{articleId}/generateArticleByArticleId")
	@ResponseBody
	public boolean generateArticleByArticleId(HttpServletRequest request, HttpServletResponse response, @PathVariable int articleId) {
		AppEntity app = this.getApp(request);
		String generatePath = getRealPath(request, IParserRegexConstant.HTML_SAVE_PATH) + File.separator + app.getAppId() + File.separator;// 站点生成后保存的html地址
		FileUtil.createFolder(generatePath);
		String tmpPath = getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE) + File.separator + app.getAppId() + File.separator + app.getAppStyle(); // 网站风格物理路径
		String url = app.getAppHostUrl() + File.separator + IParserRegexConstant.HTML_SAVE_PATH + File.separator + app.getAppId() + File.separator; // 文章地址前缀
		ArticleEntity article = (ArticleEntity) articleBiz.getBasicEntity(articleId);
		ColumnEntity tempColumn = article.getColumn();
		FileUtil.createFolder(generatePath + tempColumn.getColumnPath());
		String writePath = null;
		
		// //
		// 根据栏目获取文章列表
		// 生成文档
		switch (tempColumn.getColumnType()) {
		case ColumnEntity.COLUMN_TYPE_LIST: // 列表
			String tmpContent = FileUtil.readFile(tmpPath + File.separator + tempColumn.getColumnUrl());// 读取文章模版地址
			ArticleEntity previous = articleBiz.getPrevious(tempColumn.getCategoryAppId(), articleId,article.getBasicCategoryId());
			if (previous != null) {
				previous.setArticleLinkURL(url + tempColumn.getColumnPath() + File.separator + previous.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
			}
			ArticleEntity next = articleBiz.getNext(tempColumn.getCategoryAppId(), articleId,article.getBasicCategoryId());
			if (next != null) {
				next.setArticleLinkURL(url + tempColumn.getColumnPath() + File.separator + next.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
			}
			
			//生成页面
			Map map = new HashMap();
			map.put(CmsParser.PREVIOUS, previous);
			map.put(CmsParser.NEXT, next);
			String content = cmsParser.parse(tmpContent,app,tempColumn,article,map);
			
			if (tempColumn.getCategoryCategoryId() == 0) { // 如果是顶级下面有文章，那么文章的生成地址就是　分类id/文章编号
				FileUtil.createFolder(generatePath + tempColumn.getCategoryId());
				// 组合文章路径如:html/站点id/栏目id/文章id.html
				writePath = generatePath + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX;
				article.setArticleLinkURL(url + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
			} else { // 如果有父级别编号，需要组合路径。格式如:父ID/子id/文章id.html
				String path = File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX;
				writePath = generatePath + tempColumn.getColumnPath() + File.separator + path;
				article.setArticleLinkURL(url + tempColumn.getColumnPath() + File.separator + article.getArticleID() + IParserRegexConstant.HTML_SUFFIX);
			}
			FileUtil.writeFile(content, writePath, FileUtil.URF8);// 写文件
			break;
		case ColumnEntity.COLUMN_TYPE_COVER:// 单页
			writePath = null;
			// 取该栏目的最后一篇新闻作为显示内容
			List<ArticleEntity> list = articleBiz.queryListByColumnId(tempColumn.getCategoryId());

			String coverTtmpContent = FileUtil.readFile(tmpPath + File.separator + tempColumn.getColumnUrl());// 读取文章模版地址
			if (list == null || list.size() == 0) { // 表示该栏目下面没有文章
				break;
			}
			// 判断是否 顶级栏目
			if (tempColumn.getCategoryCategoryId() == 0) {
				FileUtil.createFolder(generatePath + tempColumn.getCategoryId());
				writePath = generatePath + String.valueOf(tempColumn.getCategoryId()) + File.separator + IParserRegexConstant.HTML_INDEX;
				// 设置文章连接地址
				article.setArticleLinkURL(url + tempColumn.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
			} else {// 子栏目，子栏目需要获取父级栏目的编号
				writePath = generatePath + tempColumn.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX;
				article.setArticleLinkURL(url + tempColumn.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
			}
			
			//生成页面
			String coverContent = cmsParser.parse(coverTtmpContent,app,tempColumn,article);
																																	// 取最后一篇文章作为栏目内容
			FileUtil.writeFile(coverContent, writePath, FileUtil.URF8);// 写文件
			break;
		}
		return true;
	}

	/**
	 * 更新栏目
	 * 
	 * @return
	 */
	@RequestMapping("/column")
	public String column(HttpServletRequest request,ModelMap model) {
		// 该站点ID有session提供
		int websiteId =  this.getAppId(request);
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		//获取所有的内容管理栏目
		List<ColumnEntity> list  = columnBiz.queryAll(websiteId,modelId);
		model.addAttribute("list",  JSONArray.toJSONString(list));
		return "/manager/cms/generate/generate_column";
	}

	/**
	 * 用户预览主页
	 * @param request 
	 * @return
	 */
	@RequestMapping("/{position}/viewIndex")
	public String viewIndex(HttpServletRequest request, @PathVariable String position) {
		//获取应用实体信息
		AppEntity app = this.getApp(request);
		//组织主页预览地址
		String indexPosition = app.getAppHostUrl() + File.separator + IParserRegexConstant.HTML_SAVE_PATH + File.separator + app.getAppId() + File.separator + position;
		return "redirect:" + indexPosition;
	}

}
