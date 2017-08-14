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

package com.mingsoft.cms.action.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mingsoft.base.constant.Const;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.basic.biz.ICategoryBiz;
import com.mingsoft.basic.biz.IColumnBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.ColumnEntity;
import com.mingsoft.cms.biz.IArticleBiz;
import com.mingsoft.cms.constant.ModelCode;
import com.mingsoft.cms.parser.CmsParser;
import com.mingsoft.mdiy.biz.IContentModelBiz;
import com.mingsoft.mdiy.biz.IContentModelFieldBiz;
import com.mingsoft.mdiy.biz.ISearchBiz;
import com.mingsoft.mdiy.entity.ContentModelEntity;
import com.mingsoft.mdiy.entity.ContentModelFieldEntity;
import com.mingsoft.mdiy.entity.SearchEntity;
import com.mingsoft.mdiy.parser.ListParser;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

import net.mingsoft.basic.util.BasicUtil;

/**
 * 
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * @author killfen
 * 
 *         <p>
 *         Comments: 搜索，根据搜索结果生成html页面
 *         </p>
 * 
 *         <p>
 *         Create Date:2015-4-21
 *         </p>
 * 
 *         <p>
 *         Modification history:
 *         </p>
 */
@Controller(value = "webSearchAction")
@RequestMapping("/cms")
public class SearchAction extends BaseAction {

	private static String modelName = "cms";

	/**
	 * 注入文章业务层
	 */
	@Autowired
	private IArticleBiz articleBiz;

	/**
	 * 内容模型业务层
	 */
	@Autowired
	private IContentModelBiz contentModelBiz;

	/**
	 * 内容字段业务层
	 */
	@Autowired
	private IContentModelFieldBiz fieldBiz;


	/**
	 * 注入搜索业务层
	 */
	@Autowired
	private ISearchBiz searchBiz;

	/**
	 * 注入栏目业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;

	/**
	 * 注入分类业务层
	 */
	@Autowired
	private ICategoryBiz categoryBiz;

	/**
	 * 文章解析器
	 */
	@Autowired
	private CmsParser cmsParser;

	/**
	 * 模块管理biz
	 */
	@Autowired
	private IModelBiz modelBiz;

	/**
	 * 实现前端页面的文章搜索
	 * 
	 * @param request
	 * @param searchId
	 *            搜索id
	 * @param response
	 */
	@RequestMapping(value = "/{searchId}/search")
	@ResponseBody
	public void search(HttpServletRequest request, @PathVariable int searchId, HttpServletResponse response) {

		Map<String, String> basicField = getMapByProperties(com.mingsoft.mdiy.constant.Const.BASIC_FIELD);
		Map<String, String[]> field = new HashMap<String, String[]>();
		AppEntity app = this.getApp(request);
		SearchEntity _search = new SearchEntity();
		_search.setAppId(BasicUtil.getAppId());
		_search.setSearchId(searchId);
		SearchEntity search = (SearchEntity) searchBiz.getEntity(_search); // 获取对应搜索模型
		if (search==null) {
			this.outJson(response, false);
		}
		// 获取模版名称
		String tmpName = app.getAppStyle();
		// 获取系统模版存放物理路径
		String tmpPath = getRealPath(request, IParserRegexConstant.REGEX_SAVE_TEMPLATE);
		// 排序参数格式 字段名称-方式
		String sort = request.getParameter("sort");
		Map<String, String> sortMap = null;
		if (!StringUtil.isBlank(sort) && sort.indexOf("-") > 0) {
			sortMap = new HashMap();
			String[] tmp = sort.split("-");
			sortMap.put("order", tmp[0]);
			sortMap.put("by", tmp[1]);
		}
		field = request.getParameterMap(); // 读取请求字段
		// 获取当前页码
		Integer pageNo = this.getPageNo(request);
		// 获取栏目ID
		String basicCategoryId = request.getParameter("categoryId");
		Integer[] categoryIds = null;
		if (basicCategoryId != null) {
			if (StringUtil.isIntegers(basicCategoryId.split(","))) {
				categoryIds = StringUtil.stringsToIntegers(basicCategoryId.split(","));
				basicCategoryId = categoryIds[0] + "";
			}
		}
		ColumnEntity column = null; // 当前栏目
		ContentModelEntity contentModel = null; // 栏目对应模型
		List fieldList = null; // 栏目对应字段
		// 若栏目ID不为空，则选择了栏目
		if (StringUtil.isInteger(basicCategoryId)) {
			column = (ColumnEntity) columnBiz.getEntity(Integer.valueOf(basicCategoryId));
			// 获取表单类型的id
			if (column != null) {
				contentModel = (ContentModelEntity) contentModelBiz.getEntity(column.getColumnContentModelId());
				if (contentModel != null) {
					fieldList = fieldBiz.queryListByCmid(contentModel.getCmId());
				}
			}
		}
		// 默认显示的数量为20条
		int size = 1;
		String webSiteTmpPath = "";
		if (isMobileDevice(request) && !StringUtil.isBlank(app.getAppMobileStyle())) {
			// 根据站点id组装站点信息路径 格式：templets／站点ID/模版风格
			webSiteTmpPath = tmpPath + File.separator + app.getAppId() + File.separator + tmpName + File.separator
					+ app.getAppMobileStyle();
		} else {
			webSiteTmpPath = tmpPath + File.separator + app.getAppId() + File.separator + tmpName;
		}
		// 读取模板内容
		String htmlContent = FileUtil.readFile(webSiteTmpPath + File.separator + search.getSearchTemplets());
		// 文章字段集合
		Map<String, Object> articleFieldName = new HashMap<String, Object>();
		// 自定义字段集合
		Map<String, String> diyFieldName = new HashMap<String, String>();
		// 分页连接地址
		String pageUrl = app.getAppHostUrl() + Const.SEPARATOR + modelName + Const.SEPARATOR + searchId
				+ Const.SEPARATOR + "search.do";
		// 遍历取字段集合
		for (Entry<String, String[]> entry : field.entrySet()) {
			if (entry != null) {
				String value = entry.getValue()[0]; // 处理由get方法请求中文乱码问题
				if (StringUtil.isBlank(value)) {
					continue;
				}
				if (request.getMethod().equals(RequestMethod.GET)) { // 如果是get方法需要将请求地址参数转吗
					value = StringUtil.isoToUTF8(value);
				}
				// 若为文章字段，则保存至文章字段集合；否则保存至自定义字段集合
				if (!StringUtil.isBlank(basicField.get(entry.getKey())) && !StringUtil.isBlank(value)) {
					articleFieldName.put(entry.getKey(), value);
				} else {
					if (!StringUtil.isBlank(value)) {
						diyFieldName.put(entry.getKey(), value);
					}

				}
				htmlContent = htmlContent.replaceAll("\\{ms:search." + entry.getKey() + "/\\}", value); // 将用户请求的值返回到页面上；

			}
		}

		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		diyFieldName.put("pageNo", null);
		// 组织链接地址
		pageUrl = StringUtil.buildUrl(pageUrl, articleFieldName);
		pageUrl = StringUtil.buildUrl(pageUrl, diyFieldName);

		// 保存栏目Id
		List ids = null;
		if (StringUtil.isInteger(basicCategoryId)) {
			ids = categoryBiz.queryChildrenCategory(Integer.parseInt(basicCategoryId), this.getAppId(request), modelId);
			if (categoryIds != null && categoryIds.length > 0) {
				for (Integer id : categoryIds) {
					ids.addAll(categoryBiz.queryChildrenCategory(id, this.getAppId(request), modelId));
				}
			}
		}
		Map whereMap = this.searchMap(articleFieldName, diyFieldName, fieldList);
		// 获取符合条件的文章总数
		int count = articleBiz.getSearchCount(contentModel, whereMap, app.getAppId(), ids);
		List articleList = new ArrayList();
		// 读取列表标签中中的
		Map<String, String> property = ListParser.listProperty(htmlContent, true);
		// 列表每页显示的数量
		if (StringUtil.string2Int(property.get(ListParser.LIST_SIZE)) > 0) {
			size = StringUtil.string2Int(property.get(ListParser.LIST_SIZE));
		}
		// 页面对象
		PageUtil page = new PageUtil(pageNo, size, count, pageUrl);
		// 判断列表标签中是否存在
		String isPaging = property.get(ListParser.LIST_ISPAGING);
		// 判断是否存在分页,不存在则分页对象不存在
		if (isPaging == null || !isPaging.equals("true")) {
			page = null;
		}
		articleList = articleBiz.queryListForSearch(contentModel, whereMap, page, app.getAppId(), ids, sortMap);
		Map map = new HashMap();
		map.put(CmsParser.CUR_PAGE_NO, pageNo);
		map.put(CmsParser.SEARCH_LIST_ARTICLE, articleList);
		map.put(CmsParser.REQUEST_PARAM,this.assemblyRequestMap(request));
		// 移动端与pc端分离
		if (isMobileDevice(request) && !StringUtil.isBlank(app.getAppMobileStyle())) {
			// 对模板内容进行解析
			map.put(CmsParser.MOBILE, IParserRegexConstant.MOBILE);
			// 对模板内容进行解析
			htmlContent = cmsParser.parse(htmlContent, app, column, articleList, page, map);
		} else {
			// 对模板内容进行解析
			htmlContent = cmsParser.parse(htmlContent, app, column, articleList, page, map);
		}
		this.outString(response, htmlContent);
	}

	/**
	 * 动态组织查询where条件 获取查询条件的Map key:字段名 value:List 字段的各种判断值 list[0]:是否为自定义字段
	 * list[1]:是否为整形 list[2]:是否是等值查询 list[3]:字段的值
	 * 
	 * @param articleField
	 *            文章字段
	 * @param diyFieldName
	 *            动态字段
	 * @param fields
	 *            模型对应的字段类型
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Map<String, List> searchMap(Map<String, Object> articleField, Map<String, String> diyFieldName,
			List fields) {
		Map<String, List> map = new HashMap<String, List>();

		// 遍历文章中的字段
		for (Iterator iter = articleField.keySet().iterator(); iter.hasNext();) {
			String key = iter.next().toString();
			String fieldValue = articleField.get(key).toString();
			List list = new ArrayList();
			List listValue = new ArrayList();
			// 是否为自定义字段
			list.add(false);

			// 是否是数字类型，true:不是
			list.add(true);
			// 是否是模糊查询3
			list.add(true);
			// 字段值
			listValue.add(articleField.get(key));
			list.add(listValue);
			map.put(key, list);
		}

		// 遍历字段自定义字段
		for (Iterator iter = diyFieldName.keySet().iterator(); iter.hasNext();) {
			String key = iter.next().toString();
			String fieldValue = diyFieldName.get(key);
			// 获取字段实体
			ContentModelFieldEntity field = this.get(key, fields);
			if (field != null) {
				List list = new ArrayList();
				// 是否为自定义字段0
				list.add(0, true);
				List listValue = new ArrayList();
				// 字段的值
				if (field.getFieldType() == IContentModelFieldBiz.INT || field.getFieldType() == IContentModelFieldBiz.FLOAT) {
					// 判断是否为区间查询

					if (diyFieldName.get(key).toString().indexOf("-") > 0) {
						String[] values = fieldValue.toString().split("-");
						// 是否是数字类型，false:是
						list.add(false);
						// 是否是区间比较 false:是
						list.add(false);
						// 字段值1
						listValue.add(values[0]);
						listValue.add(values[1]);
					} else {
						// 是否是数字类型，false:是2
						list.add(false);
						// 是否是区间比较 true:不是3
						list.add(true);
						// 字段值 1
						listValue.add(fieldValue);
					}
				} else {
					// 是否是数字类型，true:不是2
					list.add(true);
					list.add(false);
					// 字段值 1
					listValue.add(fieldValue);
				}
				list.add(listValue);
				map.put(key, list);
			}
		}
		return map;
	}

	/**
	 * 根据字段名称获取字段类型
	 * 
	 * @param columnName
	 *            字段名称
	 * @return 字段实体
	 */
	private ContentModelFieldEntity get(String columnName, List<ContentModelFieldEntity> fields) {
		if (fields == null) {
			return null;
		}
		for (ContentModelFieldEntity field : fields) {
			if (field.getFieldFieldName().equals(columnName)) {
				return field;
			}
		}
		return null;
	}

}