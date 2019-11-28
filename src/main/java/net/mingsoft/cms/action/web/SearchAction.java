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

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.PageUtil;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.TemplateNotFoundException;
import net.mingsoft.base.constant.Const;
import net.mingsoft.basic.action.BaseAction;
import net.mingsoft.basic.biz.ICategoryBiz;
import net.mingsoft.basic.biz.IColumnBiz;
import net.mingsoft.basic.biz.IModelBiz;
import net.mingsoft.basic.entity.ColumnEntity;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.StringUtil;
import net.mingsoft.cms.biz.IArticleBiz;
import net.mingsoft.cms.util.CmsParserUtil;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.biz.IContentModelBiz;
import net.mingsoft.mdiy.biz.IContentModelFieldBiz;
import net.mingsoft.mdiy.biz.ISearchBiz;
import net.mingsoft.mdiy.entity.ContentModelEntity;
import net.mingsoft.mdiy.entity.ContentModelFieldEntity;
import net.mingsoft.mdiy.entity.SearchEntity;
import net.mingsoft.mdiy.parser.TagParser;
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
	 * 注入分类业务层
	 */
	@Autowired
	private ICategoryBiz categoryBiz;


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
		SearchEntity _search = new SearchEntity();
		_search.setAppId(BasicUtil.getAppId());
		_search.setSearchId(searchId);
		// 获取对应搜索模型
		SearchEntity search = (SearchEntity) searchBiz.getEntity(_search); 
		//判断当前搜索是否有模板文件
		if (ObjectUtil.isNull(search)) {
			this.outJson(response, false);
		}
		Map<String, Object> map = new HashMap<>();
		// 读取请求字段
		Map<String, String[]> field =  request.getParameterMap(); 
		Map<String, String> basicField = getMapByProperties(net.mingsoft.mdiy.constant.Const.BASIC_FIELD);
		// 文章字段集合
		Map<String, Object> articleFieldName = new HashMap<String, Object>();
		// 自定义字段集合
		Map<String, String> diyFieldName = new HashMap<String, String>();
		ColumnEntity column = null; // 当前栏目
		ContentModelEntity contentModel = null; // 栏目对应模型
		List<ContentModelFieldEntity> fieldList = new ArrayList<ContentModelFieldEntity>(); // 栏目对应字段
		List<DiyModelMap> fieldValueList = new ArrayList<DiyModelMap>(); // 栏目对应字段的值
		int typeId = 0;
		String categoryIds = BasicUtil.getString("categoryId");
		//当传递了栏目编号，但不是栏目集合
		if(!StringUtil.isBlank(categoryIds) && !categoryIds.contains(",")){
			typeId = Integer.parseInt(categoryIds);
		}
		//记录自定义模型字段名
		List filedStr = new ArrayList<>();
		//根据栏目确定自定义模型
		if(typeId>0){
			column = (ColumnEntity) columnBiz.getEntity(Integer.parseInt(typeId+""));
			// 获取表单类型的id
			if (column != null) {
				contentModel = (ContentModelEntity) contentModelBiz.getEntity(column.getColumnContentModelId());
				if (contentModel != null) {
					fieldList = fieldBiz.queryListByCmid(contentModel.getCmId());
					for (ContentModelFieldEntity cmField : fieldList) {
						filedStr.add(cmField.getFieldFieldName());
					}
					map.put(ParserUtil.TABLE_NAME, contentModel.getCmTableName());
				}
			}
			map.put(ParserUtil.COLUMN, column);
			//设置栏目编号
//			map.put(ParserUtil.TYPE_ID, typeId);
		}
		
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
					} else {
						if (!StringUtil.isBlank(value)) {
							diyFieldName.put(entry.getKey(), value);
							//判断请求中的是否是自定义模型中的字段
							if(filedStr.contains(entry.getKey())){
								//设置自定义模型字段和值
								DiyModelMap diyMap = new DiyModelMap();
								diyMap.setKey(entry.getKey());
								diyMap.setValue(value);
								fieldValueList.add(diyMap);
							}
						} 
					}
				}
			}
		}
		//添加自定义模型的字段和值
		if(fieldValueList.size()>0){
			map.put("diyModel", fieldValueList);
		}
		//组织where查询条件
		Map whereMap = this.searchMap(articleFieldName, diyFieldName, fieldList);
		
		// 获取符合条件的文章总数
		int count = articleBiz.getSearchCount(contentModel, whereMap, BasicUtil.getAppId(), categoryIds);
		//设置分页类
		PageBean page = new PageBean();
		//读取模板的分页数量
		int size = BasicUtil.getInt(ParserUtil.SIZE,10);
		try {
			size = TagParser.getPageSize(ParserUtil.read(search.getSearchTemplets(),false ));
		} catch (TemplateNotFoundException e1) {
			e1.printStackTrace();
		} catch (MalformedTemplateNameException e1) {
			e1.printStackTrace();
		} catch (ParseException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		int total = PageUtil.totalPage(count, size);
		
		int pageNo = BasicUtil.getInt(ParserUtil.PAGE_NO, 1);
		if(pageNo >= total && total!=0) {
			pageNo = total;
		}
 		//获取总数
		page.setTotal(total);
		//设置页面显示数量
		page.setSize(size);
		//设置列表当前页
		
		page.setPageNo(pageNo);
		
		String str = ParserUtil.PAGE_NO+","+ParserUtil.SIZE;
		//设置分页的统一链接
		String url = BasicUtil.getUrl()+request.getServletPath() +"?" + BasicUtil.assemblyRequestUrlParams(str.split(","));
		String pageNoStr = "&"+ParserUtil.SIZE+"="+size+"&"+ParserUtil.PAGE_NO+"=";
		//下一页
		String nextUrl = url + pageNoStr+((pageNo+1 > total)?total:pageNo+1);
		//首页
		String indexUrl = url + pageNoStr + 1;
		//尾页
		String lastUrl = url + pageNoStr + total;
		//上一页 当前页为1时，上一页就是1
		String preUrl = url + pageNoStr + ((pageNo==1) ? 1:pageNo-1);
		
		page.setIndexUrl(indexUrl);
		page.setNextUrl(nextUrl);
		page.setPreUrl(preUrl);
		page.setLastUrl(lastUrl);
		map.put(ParserUtil.URL, BasicUtil.getUrl());
		Map<String, Object> searchMap = BasicUtil.assemblyRequestMap();
		searchMap.put(ParserUtil.PAGE_NO, pageNo);
		map.put(SEARCH, searchMap);
		map.put(ParserUtil.PAGE, page);
		//动态解析
		map.put(ParserUtil.IS_DO,false);
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
	/**
	 * 存储自定义模型字段和接口参数
	 * @author 铭飞开源团队
	 * @date 2019年3月5日
	 */
	public class DiyModelMap {
		String key;
		Object value;
		public String getKey() {
			return key;
		}
		public void setKey(String key) {
			this.key = key;
		}
		public Object getValue() {
			return value;
		}
		public void setValue(Object value) {
			this.value = value;
		}
	}
}
