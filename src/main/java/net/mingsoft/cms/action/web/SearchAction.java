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

package net.mingsoft.cms.action.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
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

import net.mingsoft.basic.action.BaseAction;
import net.mingsoft.basic.biz.IColumnBiz;
import net.mingsoft.basic.entity.ColumnEntity;
import net.mingsoft.cms.biz.IArticleBiz;
import net.mingsoft.cms.util.CmsParserUtil;
import net.mingsoft.mdiy.biz.ISearchBiz;
import net.mingsoft.mdiy.entity.ContentModelFieldEntity;
import net.mingsoft.mdiy.entity.SearchEntity;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.PageUtil;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.TemplateNotFoundException;
import net.mingsoft.base.constant.Const;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.mdiy.util.ParserUtil;

/**
 * 根据搜索结果动态解析模版内容
 * @author 铭飞开源团队-Administrator  
 * @date 2018年12月18日
 */
@Controller(value = "webSearchAction")
@RequestMapping("/cms")
public class SearchAction extends BaseAction {

	/**
	 * 搜索标签;
	 */
	public static final String SEARCH = "search";
	
	/**
	 * 搜索的标题;
	 */
	public static final String BASIC_TITLE = "basic_title";
	
	/**
	 * 注入文章业务层
	 */
	@Autowired
	private IArticleBiz articleBiz;

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
		SearchEntity _search = new SearchEntity();
		_search.setAppId(BasicUtil.getAppId());
		_search.setSearchId(searchId);
		// 获取对应搜索模型
		SearchEntity search = (SearchEntity) searchBiz.getEntity(_search); 
		//判断当前搜索是否有模板文件
		if (ObjectUtil.isNull(search)) {
			this.outJson(response, false);
		}
		Map map = BasicUtil.assemblyRequestMap();
		// 读取请求字段
		Map<String, String[]> field =  request.getParameterMap(); 
		Map<String, String> basicField = getMapByProperties(net.mingsoft.mdiy.constant.Const.BASIC_FIELD);
		// 文章字段集合
		Map<String, Object> articleFieldName = new HashMap<String, Object>();
		// 遍历取字段集合
		if (field != null) {
			for (Entry<String, String[]> entry : field.entrySet()) {
				if (entry != null) {
					String value = entry.getValue()[0]; // 处理由get方法请求中文乱码问题
					if (ObjectUtil.isNull(value)) {
						continue;
					}
					if (request.getMethod().equals(RequestMethod.GET)) { // 如果是get方法需要将请求地址参数转吗
						try {
							value = new String(value.getBytes("ISO-8859-1"),Const.UTF8);
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}
					// 若为文章字段，则保存至文章字段集合；否则保存至自定义字段集合
					if (ObjectUtil.isNotNull(basicField.get(entry.getKey())) && ObjectUtil.isNotNull(value)) {
						articleFieldName.put(entry.getKey(), value);
					} 
				}
			}
		}
		Map whereMap = this.searchMap(articleFieldName, null, null);
		// 获取符合条件的文章总数
		int count = articleBiz.getSearchCount(null, whereMap, BasicUtil.getAppId(), null);
		int typeId = BasicUtil.getInt("categoryId",0);
		//根据栏目确定模版
		if(typeId>0){
			ColumnEntity column = (ColumnEntity) columnBiz.getEntity(Integer.parseInt(map.get("typeid")+""));
			map.put(ParserUtil.COLUMN, column);
			//设置栏目编号
			map.put(ParserUtil.TYPE_ID, typeId);
		}
		int size = BasicUtil.getInt(ParserUtil.SIZE,10);
		//获取总数
		map.put(ParserUtil.TOTAL, PageUtil.totalPage(count, size));
		//设置页面显示数量
		map.put(ParserUtil.RCOUNT, size);
		//设置列表当前页
		map.put(ParserUtil.PAGE_NO, BasicUtil.getInt(ParserUtil.PAGE_NO,1));
		
		map.put(ParserUtil.URL, BasicUtil.getUrl());
		Map searchMap = new HashMap<>();
		searchMap.put(BASIC_TITLE, BasicUtil.getString(BASIC_TITLE));
		map.put(SEARCH, searchMap);
		//动态解析
		map.put(ParserUtil.IS_DO,true);
		//设置动态请求的模块路径
		map.put(ParserUtil.MODEL_NAME, "mcms");
		//解析后的内容
		String content = "";
		try {
			//根据模板路径，参数生成
			content = CmsParserUtil.generate(search.getSearchTemplets(),map, isMobileDevice(request));
		} catch (TemplateNotFoundException e) {
			e.printStackTrace();
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		this.outString(response, content);
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
//		for (Iterator iter = diyFieldName.keySet().iterator(); iter.hasNext();) {
//			String key = iter.next().toString();
//			String fieldValue = diyFieldName.get(key);
//			// 获取字段实体
//			ContentModelFieldEntity field = this.get(key, fields);
//			if (field != null) {
//				List list = new ArrayList();
//				// 是否为自定义字段0
//				list.add(0, true);
//				List listValue = new ArrayList();
//				// 字段的值
//				if (field.getFieldType() == IContentModelFieldBiz.INT || field.getFieldType() == IContentModelFieldBiz.FLOAT) {
//					// 判断是否为区间查询
//
//					if (diyFieldName.get(key).toString().indexOf("-") > 0) {
//						String[] values = fieldValue.toString().split("-");
//						// 是否是数字类型，false:是
//						list.add(false);
//						// 是否是区间比较 false:是
//						list.add(false);
//						// 字段值1
//						listValue.add(values[0]);
//						listValue.add(values[1]);
//					} else {
//						// 是否是数字类型，false:是2
//						list.add(false);
//						// 是否是区间比较 true:不是3
//						list.add(true);
//						// 字段值 1
//						listValue.add(fieldValue);
//					}
//				} else {
//					// 是否是数字类型，true:不是2
//					list.add(true);
//					list.add(false);
//					// 字段值 1
//					listValue.add(fieldValue);
//				}
//				list.add(listValue);
//				map.put(key, list);
//			}
//		}
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