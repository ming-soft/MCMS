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

package com.mingsoft.cms.action;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.base.entity.ListJson;
import com.mingsoft.basic.entity.BasicCategoryEntity;
import com.mingsoft.cms.biz.IArticleBiz;
import com.mingsoft.basic.biz.IColumnBiz;
import com.mingsoft.basic.biz.impl.CategoryBizImpl;
import com.mingsoft.basic.constant.Const;
import com.mingsoft.cms.constant.e.ColumnTypeEnum;
import com.mingsoft.mdiy.biz.IContentModelBiz;
import com.mingsoft.mdiy.biz.IContentModelFieldBiz;
import com.mingsoft.basic.constant.e.CookieConstEnum;
import com.mingsoft.cms.constant.ModelCode;
import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.basic.entity.ColumnEntity;
import com.mingsoft.mdiy.entity.ContentModelEntity;
import com.mingsoft.mdiy.entity.ContentModelFieldEntity;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

import net.mingsoft.basic.util.BasicUtil;

/**
 * 
 * 
 * <b>铭飞MS平台</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 姓名 郭鹏辉
 * 
 * @version 300-001-001
 * 
 *          <p>
 *          版权所有 铭飞科技
 *          </p>
 * 
 *          <p>
 *          Comments:文章控制层 ， 继承BasicAction
 *          </p>
 * 
 *          <p>
 *          Create Date:2014-7-5
 *          </p>
 * 
 *          <p>
 *          Modification history:
 *          </p>
 */
@Controller
@RequestMapping("/${managerPath}/cms/article")
public class ArticleAction extends BaseAction {
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
	 * 获取文章属性
	 * 
	 * @return
	 */
	public List<Map.Entry<String, String>> articleType() {
		Map<String, String> map = getMapByProperties(com.mingsoft.cms.constant.Const.ARTICLE_ATTRIBUTE_RESOURCE);
		Set<Entry<String, String>> set = map.entrySet();
		List<Map.Entry<String, String>> articleType = new ArrayList<Map.Entry<String, String>>();
		for (Iterator<Entry<String, String>> it = set.iterator(); it.hasNext();) {
			Map.Entry<String, String> entry = (Map.Entry<String, String>) it.next();
			articleType.add(entry);
		}
		return articleType;
	}

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
		int appId = this.getAppId(request);
		List<ColumnEntity> list = columnBiz.queryAll(appId, this.getModelCodeId(request, ModelCode.CMS_COLUMN));
		JSONObject ja = new JSONObject();
		request.setAttribute("listColumn", ja.toJSON(list).toString());
		// 返回路径
		return view("/cms/article/index"); // 这里表示显示/manager/cms/article/article_list.ftl
	}

	/**
	 * 加载页面显示所有文章信息
	 * 
	 * @param request
	 * @return 返回文章页面显示地址
	 */
	@RequestMapping("/{categoryId}/list")
	public String list(@ModelAttribute ArticleEntity article, HttpServletRequest request, ModelMap mode,
			HttpServletResponse response, @PathVariable int categoryId) {
		String categoryTitle = request.getParameter("categoryTitle");
		String articleType = request.getParameter("articleType");
		int[] basicCategoryIds = columnBiz.queryChildrenCategoryIds(categoryId, BasicUtil.getAppId(),
				BasicUtil.getModelCodeId(ModelCode.CMS_COLUMN));

		int appId = BasicUtil.getAppId();
		BasicUtil.startPage();
		List<ArticleEntity> listArticle = articleBiz.query(appId, basicCategoryIds, null, null, null, true, article);
		BasicUtil.endPage(listArticle);

		// 返回文章类型
		// 文章属性
		mode.addAttribute("articleTypeList", articleType());
		// 实例化对象
		mode.addAttribute("listArticle", listArticle);
		mode.addAttribute("articleShow", "");
		// 将搜索的参数再传回页面
		mode.addAttribute("articleType", articleType);
		mode.addAttribute("categoryTitle", categoryTitle);
		mode.addAttribute("categoryId", categoryId);
		BasicUtil.removeUrlParams(new String[]{"pageNo"});
		return view("/cms/article/article_list");
	}

	/**
	 * 添加文章页面
	 * 
	 * @return 保存文章的页面地址
	 */
	@SuppressWarnings("static-access")
	@RequestMapping("/add")
	public String add(ModelMap mode, HttpServletRequest request) {
		int categoryId = this.getInt(request, "categoryId", 0);
		String categoryTitle = request.getParameter("categoryTitle");
		// 判断栏目是否为""
		if (StringUtil.isBlank(categoryTitle)) {
			categoryTitle = null;
		}
		// 文章属性
		mode.addAttribute("articleType", articleType());

		// 站点ID
		int appId = this.getAppId(request);
		List<ColumnEntity> list = columnBiz.queryAll(appId, this.getModelCodeId(request, ModelCode.CMS_COLUMN));
		JSONObject ja = new JSONObject();
		mode.addAttribute("appId", appId);
		mode.addAttribute("listColumn", ja.toJSON(list).toString());
		boolean isEditCategory = false; // 新增，不是单篇
		// 获取栏目id
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(categoryId);
		// 判断栏目是否是单篇
		if (column != null && column.getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {
			isEditCategory = true; // 是单页
		}
		;
		mode.addAttribute("categoryTitle", categoryTitle);

		mode.addAttribute("isEditCategory", isEditCategory); // 新增状态
		mode.addAttribute("categoryId", categoryId);

		// 添加一个空的article实体
		ArticleEntity article = new ArticleEntity();
		mode.addAttribute("article", article);
		// 返回路径
		return view("/cms/article/article"); // 这里表示显示/manager/cms/article/article_save.ftl
	}

	/**
	 * 获取表单信息进行保存
	 * 
	 * @param article
	 *            文章对象
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute ArticleEntity article, HttpServletRequest request, HttpServletResponse response) {
		// 获取站点id
		int appId = this.getAppId(request);
		// 验证文章，文章自由排序，栏目id

		if (!validateForm(article, response)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false);

		}
		// 设置发布时间
		article.setBasicDateTime(new Timestamp(System.currentTimeMillis()));
		article.setBasicUpdateTime(new Timestamp(System.currentTimeMillis()));
		// 文章类型
		String langtyp[] = request.getParameterValues("articleType");
		if (langtyp != null) {
			StringBuffer sb = new StringBuffer();
			for (int j = 0; j < langtyp.length; j++) {
				sb.append(langtyp[j] + ",");
			}
		}
		article.setArticleType(request.getParameter("checkboxType"));
		// 问题:由于上传的图片路径后面可能带有｜符合。所以要进行将“｜”替换空
		// 空值判断
		if (!StringUtil.isBlank(article.getBasicThumbnails())) {
			article.setBasicThumbnails(article.getBasicThumbnails().replace("|", ""));
		}
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(article.getBasicCategoryId());
		article.setColumn(column);
		// 添加文章所属的站点id
		article.setArticleWebId(appId);
		// 绑定模块编号
		article.setBasicModelId(this.getModelCodeId(request));
		// 保存文章实体

		String articleType = request.getParameter("articleTypeJson");
		if (!StringUtil.isBlank(articleType)) {
			// 将JSON字符串转换为数组
			List<BasicCategoryEntity> basicCategoryList = JSONArray.parseArray(articleType, BasicCategoryEntity.class);
			articleBiz.saveArticle(article, basicCategoryList);
		} else {
			// 更新文章信息
			articleBiz.saveBasic(article);
		}
		if (column.getColumnType() == ColumnTypeEnum.COLUMN_TYPE_LIST.toInt()) {// 列表
			article.setArticleUrl(column.getColumnPath() + File.separator + article.getBasicId() + ".html");
		} else if (column.getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {// 单篇
			article.setArticleUrl(column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
		}
		articleBiz.updateBasic(article);

		// 判断栏目是否存在新增字段
		if (column.getColumnContentModelId() != 0) {
			// 保存所有的字段信息
			List<BaseEntity> listField = fieldBiz.queryListByCmid(column.getColumnContentModelId());
			// 获取内容模型实体
			ContentModelEntity contentModel = (ContentModelEntity) contentBiz
					.getEntity(column.getColumnContentModelId());
			if (contentModel != null) {
				// 保存新增字段的信息
				Map param = this.checkField(listField, request, article.getBasicId());
				fieldBiz.insertBySQL(contentModel.getCmTableName(), param);
			}

		}

		//

		if (article.getColumn().getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {
			this.outJson(response, ModelCode.CMS_ARTICLE, true, "" + article.getColumn().getCategoryId(), "");
		} else {
			this.outJson(response, ModelCode.CMS_ARTICLE, true, "",article.getColumn().getCategoryId()+"");
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
		if (StringUtil.isBlank(article.getBasicTitle())) {
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
		if (!StringUtil.isBlank(article.getArticleSource())
				&& !StringUtil.checkLength(article.getArticleSource(), 1, 300)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.length", this.getResString("articleSource"), "1", "300"));
			return false;
		}
		// 验证文章作者长度,若超过定义长度则截取
		if (!StringUtil.isBlank(article.getArticleAuthor())
				&& !StringUtil.checkLength(article.getArticleAuthor(), 1, 12)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.length", this.getResString("articleAuthor"), "1", "12"));
			return false;
		}
		// 验证文章描述长度,若超过定义长度则截取
		if (!StringUtil.isBlank(article.getBasicDescription())
				&& !StringUtil.checkLength(article.getBasicDescription(), 1, 400)) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false,
					getResString("err.length", this.getResString("basicDescription"), "1", "400"));
			return false;
		}
		// 验证文章关键字长度,若超过定义长度则截取
		if (!StringUtil.isBlank(article.getArticleKeyword())
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
	public void update(@PathVariable int basicId, @ModelAttribute ArticleEntity article, HttpServletRequest request,
			HttpServletResponse response) {
		// 获取站点id
		int appId = this.getAppId(request);
		article.setBasicUpdateTime(new Timestamp(System.currentTimeMillis()));
		// 文章类型
		article.setArticleType(request.getParameter("checkboxType"));
		// 问题:由于上传的图片路径后面可能带有｜符合。所以要进行将“｜”替换空
		// 空值判断
		if (!StringUtil.isBlank(article.getBasicThumbnails())) {
			article.setBasicThumbnails(article.getBasicThumbnails().replace("|", ""));
		}
		// 获取更改前的文章实体
		ArticleEntity oldArticle = (ArticleEntity) articleBiz.getEntity(basicId);
		// 获取栏目实体
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(article.getBasicCategoryId());
		if (!StringUtil.isBlank(oldArticle)) {
			// 获取更改前的文章所属栏目实体
			ColumnEntity oldColumn = (ColumnEntity) columnBiz.getEntity(oldArticle.getBasicCategoryId());

			// 通过表单类型id判断是否更改了表单类型,如果更改则先删除记录
			if (oldColumn.getColumnContentModelId() != column.getColumnContentModelId()) {
				// 获取旧的内容模型id
				ContentModelEntity contentModel = (ContentModelEntity) contentBiz
						.getEntity(oldColumn.getColumnContentModelId());
				// 删除旧的内容模型中保存的值
				Map wheres = new HashMap();
				wheres.put("basicId", article.getBasicId());
				if (contentModel != null) {
					fieldBiz.deleteBySQL(contentModel.getCmTableName(), wheres);
				}
				// 判断栏目是否存在新增字段
				if (column.getColumnContentModelId() != 0) {
					// 保存所有的字段信息
					List<BaseEntity> listField = fieldBiz.queryListByCmid(column.getColumnContentModelId());
					ContentModelEntity newContentModel = (ContentModelEntity) contentBiz
							.getEntity(column.getColumnContentModelId());
					if (newContentModel != null) {
						Map param = this.checkField(listField, request, article.getBasicId());
						fieldBiz.insertBySQL(newContentModel.getCmTableName(), param);
					}
				}
			}
		}

		// 添加文章所属的站点id
		article.setArticleWebId(appId);
		// 设置文章所属的栏目实体
		article.setColumn(column);

		article.setBasicUpdateTime(new Date());

		String articleType = request.getParameter("articleTypeJson");
		if (!StringUtil.isBlank(articleType)) {
			// 将JSON字符串转换为数组
			List<BasicCategoryEntity> basicCategoryList = JSONArray.parseArray(articleType, BasicCategoryEntity.class);
			articleBiz.updateArticle(article, basicCategoryList);
		} else {
			// 更新文章信息
			articleBiz.updateBasic(article);
		}

		// 判断该文章是否存在新增字段
		if (column.getColumnContentModelId() != 0) {
			// 保存所有的字段信息
			List<BaseEntity> listField = fieldBiz.queryListByCmid(column.getColumnContentModelId());
			// // update中的where条件
			Map where = new HashMap();
			// 压入默认的basicId字段
			where.put("basicId", article.getBasicId());
			// 遍历字段的信息
			Map param = this.checkField(listField, request, article.getBasicId());
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
		int categoryId = this.getInt(request, "categoryId", 0);

		ArticleEntity articleEntity = null;
		int appId = this.getAppId(request);
		model.addAttribute("appId", appId);
		if (categoryId > 0) { // 分类获取文章
			articleEntity = articleBiz.getByCategoryId(categoryId);
			model.addAttribute("article", articleEntity);
			// 文章属性
			model.addAttribute("articleType", articleType());

			model.addAttribute("categoryTitle", categoryTitle);
			model.addAttribute("categoryId", categoryId);// 编辑封面
			model.addAttribute("isEditCategory", true);// 编辑封面
			return view("/cms/article/article");
		} else if (id > 0) { // 文章id获取
			// 允许编辑文章时更改分类
			List<ColumnEntity> list = columnBiz.queryAll(appId, this.getModelCodeId(request, ModelCode.CMS_COLUMN));
			JSONObject ja = new JSONObject();
			@SuppressWarnings("static-access")
			String listJsonString = ja.toJSON(list).toString();
			request.setAttribute("listColumn", listJsonString);
			// 文章属性
			model.addAttribute("articleType", articleType());

			articleEntity = (ArticleEntity) articleBiz.getEntity(id);
			model.addAttribute("article", articleEntity);
			// 判断是否是封面类型的栏目，如果是封面类型的栏目有些信息需要屏蔽，例如分类
			ColumnEntity column = articleEntity.getColumn();
			if (column.getColumnType() == ColumnEntity.COLUMN_TYPE_COVER) {
				model.addAttribute("categoryTitle", categoryTitle);
				model.addAttribute("categoryId", column.getCategoryId());// 编辑封面
				model.addAttribute("isEditCategory", true);// 编辑封面
			} else {
				model.addAttribute("categoryTitle", articleEntity.getColumn().getCategoryTitle());
				model.addAttribute("isEditCategory", false);// 编辑文章
			}
			model.addAttribute("categoryId", column.getCategoryId());// 编辑封面
			return view("/cms/article/article");
		} else {// 非法
			// return view("/cms/article/article");
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
	public void delete(HttpServletRequest request, HttpServletResponse response) {
		int appId = this.getAppId(request);
		String[] ids = request.getParameterValues("ids");
		if (ids.length == 0 || ids == null) {
			this.outJson(response, ModelCode.CMS_ARTICLE, false, "", this.redirectBack(request, false));
			return;
		}
		// 删除多个帖子
		articleBiz.delete(StringUtil.stringsToInts(ids));
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
	private Map checkField(List<BaseEntity> listField, HttpServletRequest request, int articleId) {
		Map mapParams = new HashMap();
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
				if (StringUtil.isBlank(request.getParameter(field.getFieldFieldName()))) {
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