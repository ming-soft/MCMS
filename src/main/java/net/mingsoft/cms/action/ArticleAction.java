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

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;

import net.mingsoft.base.entity.BaseEntity;
import net.mingsoft.base.filter.DateValueFilter;
import net.mingsoft.base.filter.DoubleValueFilter;
import net.mingsoft.basic.action.BaseAction;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.biz.IColumnBiz;
import net.mingsoft.basic.entity.ColumnEntity;
import net.mingsoft.basic.util.ArrysUtil;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.FileUtil;
import net.mingsoft.basic.util.StringUtil;
import net.mingsoft.cms.biz.IArticleBiz;
import net.mingsoft.cms.constant.ModelCode;
import net.mingsoft.cms.constant.e.ColumnTypeEnum;
import net.mingsoft.cms.entity.ArticleEntity;
import net.mingsoft.mdiy.biz.IContentModelBiz;
import net.mingsoft.mdiy.biz.IContentModelFieldBiz;
import net.mingsoft.mdiy.entity.ContentModelEntity;
import net.mingsoft.mdiy.entity.ContentModelFieldEntity;
import net.mingsoft.mdiy.util.DictUtil;
import net.mingsoft.mdiy.util.ParserUtil;

/**
 * @ClassName:  ArticleAction   
 * @Description:TODO 文章管理   
 * @author: 铭飞开发团队
 * @date:   2018年1月31日 下午2:51:39   
 *     
 * @Copyright: 2018 www.mingsoft.net Inc. All rights reserved.
 */
@Controller
@RequestMapping("/${ms.manager.path}/cms/article")
public class ArticleAction extends BaseAction {
	
	/**
	 * 上传路径
	 */
	@Value("${ms.upload.path}")
	private String uploadFloderPath;
	
	/**
	 * 业务层的注入
	 */
	@Autowired
	private IColumnBiz columnBiz;

	/**
	 * 文章管理业务处理层
	 */
	@Autowired
	private IArticleBiz articleBiz;

	/**
	 * 字段管理业务层
	 */
	@Autowired
	private IContentModelFieldBiz fieldBiz;

	/**
	 * 内容管理业务层
	 */
	@Autowired
	private IContentModelBiz contentBiz;

	/**
	 * 判断是否为checkbox类型
	 */
	private static final int checkBox = 11;


	/**
	 * 加载页面显示所有文章信息
	 * 
	 * @param request
	 * @return 返回文章页面显示地址
	 */
	@SuppressWarnings("static-access")
	@RequestMapping("/index")
	public String index(HttpServletRequest request, ModelMap mode, HttpServletResponse response) {
		// 获取站点id
		int appId = BasicUtil.getAppId();
		List<ColumnEntity> list = columnBiz.queryAll(appId, this.getModelCodeId(request, ModelCode.CMS_COLUMN));
		request.setAttribute("listColumn", JSONArray.toJSONString(list));
		// 返回路径
		return "/cms/article/index"; // 这里表示显示/manager/cms/article/article_list.ftl
	}

	/**
	 * 返回一个文章列表框架和一些基础数据
	 * @param article
	 * @param request
	 * @param mode
	 * @param response
	 * @param categoryId
	 * @return 返回一个文章列表界面
	 */
	@RequestMapping("/{categoryId}/main")
	public String main(@ModelAttribute ArticleEntity article, HttpServletRequest request, ModelMap mode,
			HttpServletResponse response, @PathVariable int categoryId) {
		String articleType = request.getParameter("articleType");
		String isParent = BasicUtil.getString("isParent", "false");
		mode.addAttribute("isParent", isParent);
		//使用糊涂工具排序使全部属性排在第一个
		mode.addAttribute("articleTypeList", DictUtil.list("文章属性"));
		mode.addAttribute("articleType", articleType);
 		mode.addAttribute("categoryId", categoryId);
		//返回文章页面显示地址
		return "/cms/article/article_main";
	}
	
	/**
	 * 加载页面显示所有文章信息
	 * 
	 * @param request
	 * @return 返回文章页面显示数据
	 */
	@RequestMapping("/{categoryId}/list")
	public void list(@ModelAttribute ArticleEntity article, HttpServletRequest request, ModelMap mode,
			HttpServletResponse response, @PathVariable int categoryId) {
		int[] basicCategoryIds = null;
		String articleType = article.getArticleType();
		if(StringUtils.isEmpty(articleType)){
			articleType = BasicUtil.getString("articleTypeStr");
		}
		if(!StringUtils.isEmpty(articleType) && articleType.equals("a")){
			articleType = null;
		}
		if(categoryId > 0){
			 basicCategoryIds = columnBiz.queryChildrenCategoryIds(categoryId, BasicUtil.getAppId(),
					BasicUtil.getModelCodeId(ModelCode.CMS_COLUMN));
		}
		int appId = BasicUtil.getAppId();
		BasicUtil.startPage();
		article.setBasicDisplay(-1);
		//查询文章列表
		List<ArticleEntity> articleList = articleBiz.query(appId, basicCategoryIds, articleType, null, null, true, null, null, article);
		EUListBean _list = new EUListBean(articleList, (int) BasicUtil.endPage(articleList).getTotal());
		//将数据以json数据的形式返回
		this.outJson(response, net.mingsoft.base.util.JSONArray.toJSONString(_list, new DoubleValueFilter(),new DateValueFilter("yyyy-MM-dd")));
		
	}

	/**
	 * 添加文章页面
	 * 
	 * @return 保存文章的页面地址
	 */
	@SuppressWarnings("static-access")
	@RequestMapping("/add")
	public String add(ModelMap mode, HttpServletRequest request) {
		int categoryId = BasicUtil.getInt("categoryId", 0);
		String categoryTitle = request.getParameter("categoryTitle");
		// 文章属性
		mode.addAttribute("articleType", DictUtil.list("文章属性"));
		// 站点ID
		int appId = BasicUtil.getAppId();
		List<ColumnEntity> list = columnBiz.queryAll(appId, this.getModelCodeId(request, ModelCode.CMS_COLUMN));
		mode.addAttribute("appId", appId);
		mode.addAttribute("listColumn", JSONArray.toJSONString(list));
		boolean isEditCategory = false; // 新增，不是单篇
		int columnType=1;//新增，不是单篇
		if(categoryId != 0){
			// 获取栏目id
			ColumnEntity column = (ColumnEntity) columnBiz.getEntity(categoryId);
			columnType = column.getColumnType();
			// 判断栏目是否为"",如果是"",就重新赋值
			if (StringUtils.isBlank(categoryTitle)) {
				categoryTitle = column.getCategoryTitle();
			}
			// 判断栏目是否是单篇
			if (column != null && column.getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {
				isEditCategory = true; // 是单页
				columnType = column.getColumnType();;
			}
		}
		mode.addAttribute("categoryTitle", categoryTitle);
		mode.addAttribute("isEditCategory", isEditCategory); // 新增状态
		mode.addAttribute("columnType", columnType);
		mode.addAttribute("categoryId", categoryId);
		mode.addAttribute("articleImagesUrl", uploadFloderPath+net.mingsoft.base.constant.Const.SEPARATOR
				+BasicUtil.getAppId()+net.mingsoft.base.constant.Const.SEPARATOR);
		// 添加一个空的article实体
		ArticleEntity article = new ArticleEntity();
		mode.addAttribute("article", article);
		mode.addAttribute("action", "save");
		// 返回路径
		return "/cms/article/article_form"; // 这里表示显示/manager/cms/article/article_save.ftl
	}

	/**
	 * 获取表单信息进行保存
	 * 
	 * @param article
	 *            文章对象
	 */
	@RequestMapping("/save")
	@RequiresPermissions("article:save")
	public void save(@ModelAttribute ArticleEntity article, HttpServletRequest request, HttpServletResponse response) {
		// 获取站点id
		int appId = BasicUtil.getAppId();
		// 验证文章，文章自由排序，栏目id
		if (!validateForm(article, response)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false);

		}
		 
		article.setBasicUpdateTime(new Timestamp(System.currentTimeMillis()));
		// 文章类型
		String langtyp[] = request.getParameterValues("articleType");
		if (langtyp != null) {
			StringBuffer sb = new StringBuffer();
			for (int j = 0; j < langtyp.length; j++) {
				sb.append(langtyp[j] + ",");
			}
		}
		String checkboxType = BasicUtil.getString("checkboxType");
		//如果选择一个属性不做排序操作
		if(!StringUtils.isEmpty(checkboxType) && checkboxType.length()>2){
			// 文章类型排序
			article.setArticleType(ArrysUtil.sort(checkboxType, ",")+",");
		}else{
			article.setArticleType(checkboxType);
		}
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(article.getBasicCategoryId());
		article.setColumn(column);
		
		// 添加文章所属的站点id
		article.setArticleWebId(appId);
		// 绑定模块编号
		article.setBasicModelId(BasicUtil.getInt("modelId"));
		// 保存文章实体

		articleBiz.saveBasic(article);
		if (column.getColumnType() == ColumnTypeEnum.COLUMN_TYPE_LIST.toInt()) {// 列表
			article.setArticleUrl(column.getColumnPath() + File.separator + article.getBasicId() + ParserUtil.HTML_SUFFIX);
		} else if (column.getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {// 单篇
			article.setArticleUrl(column.getColumnPath() + File.separator + ParserUtil.INDEX+ParserUtil.HTML_SUFFIX);
		}
		articleBiz.updateBasic(article);

		// 判断栏目是否存在新增字段
		if (column.getColumnContentModelId() != 0) {
			// 保存所有的字段信息
			List<ContentModelFieldEntity> listField = fieldBiz.queryListByCmid(column.getColumnContentModelId());
			// 获取内容模型实体
			ContentModelEntity contentModel = (ContentModelEntity) contentBiz
					.getEntity(column.getColumnContentModelId());
			if (contentModel != null) {
				// 保存新增字段的信息
				Map<String, Object> param = this.checkField(listField, request, article.getBasicId());
				fieldBiz.insertBySQL(contentModel.getCmTableName(), param);
			}

		}

		//

		if (article.getColumn().getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {
			this.outJson(response, ModelCode.CMS_ARTICLE, true, "" + article.getColumn().getCategoryId(), article.getBasicId());
		} else {
			this.outJson(response, ModelCode.CMS_ARTICLE, true, article.getColumn().getCategoryId()+"", "");
		}
	}

	/**
	 * 验证表单
	 * 
	 * @param article
	 * @param response
	 * @return 返回Boolean类型 true：通过，false:有错
	 */
	public boolean validateForm(ArticleEntity article, HttpServletResponse response) {
		// 对表单数据进行再次验证
		// 验证文章标题是否为空
		if (StringUtils.isBlank(article.getBasicTitle())) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.empty", this.getResString("basicTitle")));
			return false;
		}
		// 验证文章所属是否为0
		if (article.getBasicCategoryId() == 0) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.empty", this.getResString("basicCategoryId")));
			return false;
		}
		// 验证文章标题长度,若超过定义长度则截取
		if (!StringUtil.checkLength(article.getBasicTitle(), 1, 300)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.length", this.getResString("basicTitle"), "1", "300"));
			return false;
		}
		// 验证文章来源长度,若超过定义长度则截取
		if (!StringUtils.isBlank(article.getArticleSource())
				&& !StringUtil.checkLength(article.getArticleSource(), 1, 300)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.length", this.getResString("articleSource"), "1", "300"));
			return false;
		}
		// 验证文章作者长度,若超过定义长度则截取
		if (!StringUtils.isBlank(article.getArticleAuthor())
				&& !StringUtil.checkLength(article.getArticleAuthor(), 1, 12)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.length", this.getResString("articleAuthor"), "1", "12"));
			return false;
		}
		// 验证文章描述长度,若超过定义长度则截取
		if (!StringUtils.isBlank(article.getBasicDescription())
				&& !StringUtil.checkLength(article.getBasicDescription(), 1, 400)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.length", this.getResString("basicDescription"), "1", "400"));
			return false;
		}
		// 验证文章关键字长度,若超过定义长度则截取
		if (!StringUtils.isBlank(article.getArticleKeyword())
				&& !StringUtil.checkLength(article.getArticleKeyword(), 1, 155)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.length", this.getResString("articleKeyword"), "1", "155"));
			return false;
		}
		return true;
	}

	/**
	 * 更新文章
	 * 
	 * @param basicId
	 *            文章id
	 * @param article
	 *            文章实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{basicId}/update")
	@RequiresPermissions("article:update")
	public void update(@PathVariable int basicId, @ModelAttribute ArticleEntity article, HttpServletRequest request,
			HttpServletResponse response) {
		// 获取站点id
		int appId = BasicUtil.getAppId();
		article.setBasicUpdateTime(new Timestamp(System.currentTimeMillis()));
		// 文章类型
		String checkboxType = BasicUtil.getString("checkboxType");
		//如果选择一个属性不做排序操作
		if(!StringUtils.isEmpty(checkboxType) && checkboxType.length()>2){
			// 文章类型排序
			article.setArticleType(ArrysUtil.sort(checkboxType, ",")+",");
		}else{
			article.setArticleType(checkboxType);
		}
		// 获取更改前的文章实体
		ArticleEntity oldArticle = (ArticleEntity) articleBiz.getEntity(basicId);
		// 获取栏目实体
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(article.getBasicCategoryId());
		if (oldArticle != null) {
			// 获取更改前的文章所属栏目实体
			ColumnEntity oldColumn = (ColumnEntity) columnBiz.getEntity(oldArticle.getBasicCategoryId());

			// 通过表单类型id判断是否更改了表单类型,如果更改则先删除记录
			if (oldColumn.getColumnContentModelId() != column.getColumnContentModelId()) {
				// 获取旧的内容模型id
				ContentModelEntity contentModel = (ContentModelEntity) contentBiz
						.getEntity(oldColumn.getColumnContentModelId());
				// 删除旧的内容模型中保存的值
				Map<String, Integer> wheres = new HashMap<String, Integer>();
				wheres.put("basicId", article.getBasicId());
				if (contentModel != null) {
					fieldBiz.deleteBySQL(contentModel.getCmTableName(), wheres);
				}
				// 判断栏目是否存在新增字段
				if (column.getColumnContentModelId() != 0) {
					// 保存所有的字段信息
					List<ContentModelFieldEntity> listField = fieldBiz.queryListByCmid(column.getColumnContentModelId());
					ContentModelEntity newContentModel = (ContentModelEntity) contentBiz
							.getEntity(column.getColumnContentModelId());
					if (newContentModel != null) {
						Map<String, Object> param = this.checkField(listField, request, article.getBasicId());
						fieldBiz.insertBySQL(newContentModel.getCmTableName(), param);
					}
				}
			}
		}
		//判断是否修改了所属栏目
		if(oldArticle.getBasicCategoryId()!=article.getBasicCategoryId()){
			//拼接栏目路径和文章编号及文件后缀
			article.setArticleUrl(column.getColumnPath() + File.separator + article.getBasicId() + ParserUtil.HTML_SUFFIX);
		}
		// 添加文章所属的站点id
		article.setArticleWebId(appId);
		// 设置文章所属的栏目实体
		article.setColumn(column);

		article.setBasicUpdateTime(new Date());

		String articleType = request.getParameter("articleTypeJson");
		articleBiz.updateBasic(article);

		// 判断该文章是否存在新增字段
		if (column.getColumnContentModelId() != 0) {
			// 保存所有的字段信息
			List<ContentModelFieldEntity> listField = fieldBiz.queryListByCmid(column.getColumnContentModelId());
			// // update中的where条件
			Map<String, Integer> where = new HashMap<String, Integer>();
			// 压入默认的basicId字段
			where.put("basicId", article.getBasicId());
			// 遍历字段的信息
			Map<String, Object> param = this.checkField(listField, request, article.getBasicId());
			ContentModelEntity contentModel = (ContentModelEntity) contentBiz
					.getEntity(column.getColumnContentModelId());
			if (contentModel != null) {
				// 遍历所有的字段实体,得到字段名列表信息
				List<String> listFieldName = new ArrayList<String>();
				listFieldName.add("basicId");
				// 查询新增字段的信息
				List fieldLists = fieldBiz.queryBySQL(contentModel.getCmTableName(), listFieldName, where);

				// 判断新增字段表中是否存在该文章，不存在则保存，否则更新
				if (fieldLists == null || fieldLists.size() == 0) {
					fieldBiz.insertBySQL(contentModel.getCmTableName(), param);
				} else {
					fieldBiz.updateBySQL(contentModel.getCmTableName(), param, where);
				}

			}
		}

		switch (column.getColumnType()) {
		case ColumnEntity.COLUMN_TYPE_COVER:
			this.outJson(response, ModelCode.CMS_ARTICLE, true, column.getCategoryId() + "", "");
			break;
		case ColumnEntity.COLUMN_TYPE_LIST:
			this.outJson(response, ModelCode.CMS_ARTICLE, true, column.getCategoryId() + "",
					this.redirectBack(request, false));
		}

	}

	/**
	 * 显示更新内容
	 * 
	 * @param request
	 * @return 修改文章的页面地址
	 */
	@RequestMapping("/{id}/edit")
	public String edit(@PathVariable int id, ModelMap model, HttpServletRequest request) {

		// 如果_categoryId大于0表示是编辑封面栏目，应该先查询分类下面的唯一一篇文章
		String categoryTitle = request.getParameter("categoryTitle");
		// 板块id
		int categoryId = BasicUtil.getInt("categoryId", 0);
		ArticleEntity articleEntity = null;
		int appId = BasicUtil.getAppId();
		model.addAttribute("appId", appId);
		model.addAttribute("articleImagesUrl", "/upload/"+BasicUtil.getAppId()+"/");
		model.addAttribute("action", "update");

		if (categoryId > 0) { // 分类获取文章
			articleEntity = articleBiz.getByCategoryId(categoryId);
			ColumnEntity column = articleEntity.getColumn();
			int columnType = column.getColumnType();
			model.addAttribute("article", articleEntity);
			// 文章属性
			model.addAttribute("articleType", DictUtil.list("文章属性"));
			model.addAttribute("categoryTitle", categoryTitle);
			model.addAttribute("categoryId", categoryId);// 编辑封面
			model.addAttribute("isEditCategory", true);// 编辑封面
			model.addAttribute("columnType", columnType);
			return "/cms/article/article_form";
		} else if (id > 0) { // 文章id获取
			// 允许编辑文章时更改分类
			List<ColumnEntity> list = columnBiz.queryAll(appId, this.getModelCodeId(request, ModelCode.CMS_COLUMN));
			@SuppressWarnings("static-access")
			String listJsonString = JSONArray.toJSONString(list);
			request.setAttribute("listColumn", listJsonString);
			// 文章属性
			model.addAttribute("articleType", DictUtil.list("文章属性"));

			articleEntity = (ArticleEntity) articleBiz.getEntity(id);
			model.addAttribute("article", articleEntity);
			// 判断是否是封面类型的栏目，如果是封面类型的栏目有些信息需要屏蔽，例如分类
			ColumnEntity column = articleEntity.getColumn();
			int columnType = column.getColumnType();
			if (column.getColumnType() == ColumnEntity.ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {
				model.addAttribute("categoryTitle", categoryTitle);
				model.addAttribute("categoryId", column.getCategoryId());// 编辑封面
				model.addAttribute("isEditCategory", true);// 编辑封面
			} else {
				model.addAttribute("categoryTitle", articleEntity.getColumn().getCategoryTitle());
				model.addAttribute("isEditCategory", false);// 编辑文章
			}
			model.addAttribute("columnType", columnType);
			model.addAttribute("categoryId", column.getCategoryId());// 编辑封面
			return "/cms/article/article_form";
		} else {// 非法
			// return "/cms/article/article_form");
			return this.redirectBack(request, true);
		}
	}

	/**
	 * 删除文章
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/delete")
	@RequiresPermissions("article:del")
	public void delete(@RequestBody List<ArticleEntity> articles, HttpServletRequest request, HttpServletResponse response) {
		int appId = BasicUtil.getAppId();
		int[] ids = new int[articles.size()];
		//循环获取id数据
		for(int i=0;i<articles.size();i++){
			ids[i] = articles.get(i).getArticleID();
		}
		
		if (ids.length == 0 || ids == null) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false, "", this.redirectBack(request, false));
			return;
		}
		// 删除多个帖子
		articleBiz.deleteBasic(ids);
		FileUtil.del(articles);
		this.outJson(response, ModelCode.CMS_ARTICLE, true, "", this.redirectBack(request, false));
	}

	/**
	 * 遍历出所有文章新增字段的信息
	 * 
	 * @param listField
	 *            :字段列表
	 * @param request
	 * @param articleId
	 *            文章id
	 * @return 字段信息
	 */
	private Map checkField(List<ContentModelFieldEntity> listField, HttpServletRequest request, int articleId) {
		Map<String, Object> mapParams = new HashMap();
		// 压入默认的basicId字段
		mapParams.put("basicId", articleId);
		// 遍历字段名
		for (int i = 0; i < listField.size(); i++) {
			ContentModelFieldEntity field = (ContentModelFieldEntity) listField.get(i);
			String fieldName = field.getFieldFieldName();
			// 判断字段类型是否为checkbox类型
			if (field.getFieldType() == checkBox) {
				String langtyp[] = request.getParameterValues(field.getFieldFieldName());
				if (langtyp != null) {
					StringBuffer sb = new StringBuffer();
					for (int j = 0; j < langtyp.length; j++) {
						sb.append(langtyp[j] + ",");
					}
					mapParams.put(field.getFieldFieldName(), sb.toString());
				} else {
					mapParams.put(field.getFieldFieldName(), langtyp);
				}
			} else {
				if (StringUtils.isBlank(request.getParameter(field.getFieldFieldName()))) {
					mapParams.put(field.getFieldFieldName(), null);
				} else {
					mapParams.put(field.getFieldFieldName(), request.getParameter(field.getFieldFieldName()));
				}
			}
		}
		return mapParams;
	}

	/**
	 * 查询单页栏目是否绑定了文章
	 * 
	 * @param article
	 *            文章对象
	 */
	@RequestMapping("/{id}/queryColumnArticle")
	public void queryColumnArticle(@PathVariable int id, HttpServletResponse response) {
		List articls = articleBiz.queryListByColumnId(id);
		if (articls == null || articls.size() == 0) {
			this.outJson(response, ModelCode.CMS_ARTICLE, true, null);
		} else {
			this.outJson(response, ModelCode.CMS_ARTICLE, false, null);
		}
	}

	
}