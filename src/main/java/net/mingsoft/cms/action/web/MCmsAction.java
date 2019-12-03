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
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import net.mingsoft.base.constant.Const;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.basic.util.StringUtil;
import net.mingsoft.cms.bean.ContentBean;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.mdiy.biz.IContentModelBiz;
import net.mingsoft.mdiy.biz.IModelBiz;
import net.mingsoft.mdiy.entity.ContentModelEntity;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.parser.TagParser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.PageUtil;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.TemplateNotFoundException;
import net.mingsoft.basic.entity.ColumnEntity;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.util.CmsParserUtil;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.biz.IPageBiz;
import net.mingsoft.mdiy.entity.PageEntity;
import net.mingsoft.mdiy.util.ParserUtil;

/**
 * 动态生成页面，需要后台配置自定义页数据
 *
 * @author 铭飞开源团队
 * @date 2018年12月17日
 */
@Controller("dynamicPageAction")
@RequestMapping("/mcms")
public class MCmsAction extends net.mingsoft.cms.action.BaseAction {

	/**
	 * 自定义页面业务层
	 */
	@Autowired
	private IPageBiz pageBiz;

	/**
	 * 文章管理业务处理层
	 */
	@Autowired
	private IContentBiz contentBiz;

	/**
	 * 栏目业务层
	 */
	@Autowired
	private ICategoryBiz categoryBiz;



	/**
	 * 搜索标签;
	 */
	public static final String SEARCH = "search";

	/**
	 * 自定义模型
	 */
	@Autowired
	private IModelBiz modelBiz;
	// 如商城就为:/mall/{key}.do
	/**
	 * 前段会员中心所有页面都可以使用该方法 请求地址例如： ／{diy}.do,例如登陆界面，与注册界面都可以使用
	 *
	 * @param key
	 */
	@RequestMapping("/{diy}.do")
	@ExceptionHandler(java.lang.NullPointerException.class)
	public void diy(@PathVariable(value = "diy") String diy, HttpServletRequest req, HttpServletResponse resp) {
		Map map = BasicUtil.assemblyRequestMap();
		map.put(ParserUtil.URL, BasicUtil.getUrl());
		//动态解析
		map.put(ParserUtil.IS_DO,true);
		//设置动态请求的模块路径
		map.put(ParserUtil.MODEL_NAME, "mcms");
		//解析后的内容
		String content = "";
		PageEntity page = new PageEntity();
		page.setPageKey(diy);
		//根据请求路径查询模版文件
		PageEntity _page = (PageEntity) pageBiz.getEntity(page);
		try {
			content = CmsParserUtil.generate(_page.getPagePath(), map, isMobileDevice(req));
		} catch (TemplateNotFoundException e) {
			e.printStackTrace();
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		this.outString(resp, content);
	}

	/**
	 * 动态列表页
	 */
	@GetMapping("/index.do")
	public void index(HttpServletRequest req, HttpServletResponse resp) {
		Map map = BasicUtil.assemblyRequestMap();
		map.put(ParserUtil.URL, BasicUtil.getUrl());
		//动态解析
		map.put(ParserUtil.IS_DO,true);
		//设置动态请求的模块路径
		map.put(ParserUtil.MODEL_NAME, "mcms");
		//解析后的内容
		String content = "";
		try {
			//根据模板路径，参数生成
			content = CmsParserUtil.generate(ParserUtil.INDEX+ParserUtil.HTM_SUFFIX, map, isMobileDevice(req));
		} catch (TemplateNotFoundException e) {
			e.printStackTrace();
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		this.outString(resp, content);
	}

	/**
	 * 动态列表页
	 * @param req
	 * @param resp
	 */
	@GetMapping("/list.do")
	public void list(HttpServletRequest req, HttpServletResponse resp) {
		Map map = BasicUtil.assemblyRequestMap();
		//获取栏目编号
		int typeId = BasicUtil.getInt(ParserUtil.TYPE_ID,0);
		int size = BasicUtil.getInt(ParserUtil.SIZE,10);

		//获取文章总数
		List<ContentBean> columnArticles = contentBiz.queryIdsByCategoryIdForParser(String.valueOf(typeId), null, null);
		//判断栏目下是否有文章
		if(columnArticles.size()==0){
			this.outJson(resp, false);
		}
		//设置分页类
		PageBean page = new PageBean();
		int total = PageUtil.totalPage(columnArticles.size(), size);
		map.put(ParserUtil.COLUMN, columnArticles.get(0));
		//获取总数
		page.setTotal(total);
		//设置栏目编号
		map.put(ParserUtil.TYPE_ID, typeId);
		//设置列表当前页
		map.put(ParserUtil.PAGE_NO, BasicUtil.getInt(ParserUtil.PAGE_NO,1));

		map.put(ParserUtil.URL, BasicUtil.getUrl());
		map.put(ParserUtil.PAGE, page);
		//动态解析
		map.put(ParserUtil.IS_DO,true);
		//设置动态请求的模块路径
		map.put(ParserUtil.MODEL_NAME, "mcms");
		//解析后的内容
		String content = "";
		try {
			//根据模板路径，参数生成
			content = CmsParserUtil.generate(columnArticles.get(0).getCategoryListUrl(),map, isMobileDevice(req));
		} catch (TemplateNotFoundException e) {
			e.printStackTrace();
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		this.outString(resp, content);
	}

	/**
	 * 动态详情页
	 * @param id 文章编号
	 */
	@GetMapping("/view.do")
	public void view(String orderby,String order,HttpServletRequest req, HttpServletResponse resp) {
		//参数文章编号
		ContentEntity article = (ContentEntity) contentBiz.getEntity(BasicUtil.getInt(ParserUtil.ID));
		if(ObjectUtil.isNull(article)){
			this.outJson(resp, null,false,getResString("err.empty", this.getResString("id")));
			return;
		}
		if(StringUtils.isNotBlank(order)){
			//防注入
			if(!order.toLowerCase().equals("asc")&&!order.toLowerCase().equals("desc")){
				this.outJson(resp, null,false,getResString("err.error", this.getResString("order")));
				return;
			}
		}
		PageBean page = new PageBean();
		//根据文章编号查询栏目详情模版
		CategoryEntity column = (CategoryEntity) categoryBiz.getEntity(Integer.parseInt(article.getContentCategoryId()));
		//解析后的内容
		String content = "";
		Map map = BasicUtil.assemblyRequestMap();
		//动态解析
		map.put(ParserUtil.IS_DO,true);
		//设置动态请求的模块路径
		map.put(ParserUtil.MODEL_NAME, "mcms");
		map.put(ParserUtil.URL, BasicUtil.getUrl());
		map.put(ParserUtil.PAGE, page);
		map.put(ParserUtil.ID, article.getId());
		List<ContentBean> articleIdList = contentBiz.queryIdsByCategoryIdForParser(column.getCategoryId(), null, null,orderby,order);
		Map<Object, Object> contentModelMap = new HashMap<Object, Object>();
		ContentModelEntity contentModel = null;
		for (int artId = 0; artId < articleIdList.size();) {
			//如果不是当前文章则跳过
			if(articleIdList.get(artId).getArticleId() != Integer.parseInt(article.getId())){
				artId++;
				continue;
			}
			// 文章的栏目路径
			String articleColumnPath = articleIdList.get(artId).getCategoryPath();
			// 文章的栏目模型编号
			String columnContentModelId = articleIdList.get(artId).getMdiyModelId();
			Map<String, Object> parserParams = new HashMap<String, Object>();
			parserParams.put(ParserUtil.COLUMN, articleIdList.get(artId));
			// 判断当前栏目是否有自定义模型
			if ( StringUtils.isNotBlank(columnContentModelId)) {
				// 通过当前栏目的模型编号获取，自定义模型表名
				if (contentModelMap.containsKey(columnContentModelId)) {
					parserParams.put(ParserUtil.TABLE_NAME, contentModel.getCmTableName());
				} else {
					// 通过栏目模型编号获取自定义模型实体
					contentModel = (ContentModelEntity) SpringUtil.getBean(IContentModelBiz.class)
							.getEntity(Integer.parseInt(columnContentModelId));
					// 将自定义模型编号设置为key值
					contentModelMap.put(columnContentModelId, contentModel.getCmTableName());
					parserParams.put(ParserUtil.TABLE_NAME, contentModel.getCmTableName());
				}
			}
			// 第一篇文章没有上一篇
			if (artId > 0) {
				ContentBean preCaBean = articleIdList.get(artId - 1);
				//判断当前文档是否与上一页文章在同一栏目下，并且不能使用父栏目字符串，因为父栏目中没有所属栏目编号
				if(articleColumnPath.contains(preCaBean.getCategoryId()+"")){
					page.setPreId(preCaBean.getArticleId());
				}
			}
			// 最后一篇文章没有下一篇
			if (artId + 1 < articleIdList.size()) {
				ContentBean nextCaBean = articleIdList.get(artId + 1);
				//判断当前文档是否与下一页文章在同一栏目下并且不能使用父栏目字符串，因为父栏目中没有所属栏目编号
				if(articleColumnPath.contains(nextCaBean.getCategoryId()+"")){
					page.setNextId(nextCaBean.getArticleId());
				}
			}
			break;
		}
		try {
			//根据模板路径，参数生成
			content = CmsParserUtil.generate(column.getCategoryListUrl(), map, isMobileDevice(req));
		} catch (TemplateNotFoundException e) {
			e.printStackTrace();
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		this.outString(resp, content);
	}










	/**
	 * 实现前端页面的文章搜索
	 *
	 * @param request
	 *            搜索id
	 * @param response
	 */
	@RequestMapping(value = "search")
	@ResponseBody
	public void search(HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> map = new HashMap<>();
		// 读取请求字段
		Map<String, String[]> field =  request.getParameterMap();
		Map<String, String> basicField = getMapByProperties(net.mingsoft.mdiy.constant.Const.BASIC_FIELD);
		// 文章字段集合
		Map<String, Object> articleFieldName = new HashMap<String, Object>();
		// 自定义字段集合
		Map<String, String> diyFieldName = new HashMap<String, String>();
		CategoryEntity column = null; // 当前栏目
		ModelEntity contentModel = null; // 栏目对应模型
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
			column = (CategoryEntity) categoryBiz.getEntity(Integer.parseInt(typeId+""));
			// 获取表单类型的id
			if (column != null&&ObjectUtil.isNotNull(column.getMdiyModelId())) {
				contentModel = (ModelEntity) modelBiz.getEntity(Integer.parseInt(column.getMdiyModelId()));
				if (contentModel != null) {
					Map<String,String> fieldMap = contentModel.getFieldMap();
					for (String s : fieldMap.keySet()) {
						filedStr.add(fieldMap.get(s));
					}
					map.put(ParserUtil.TABLE_NAME, contentModel.getModelTableName());
				}
			}
			map.put(ParserUtil.COLUMN, column);
			//设置栏目编号
//			map.put(ParserUtil.TYPE_ID, typeId);
		}

		// 遍历取字段集合
		if (field != null) {
			for (Map.Entry<String, String[]> entry : field.entrySet()) {
				if (entry != null) {
					String value = entry.getValue()[0]; // 处理由get方法请求中文乱码问题
					if (ObjectUtil.isNull(value)) {
						continue;
					}
					if (request.getMethod().equals(RequestMethod.GET)) { // 如果是get方法需要将请求地址参数转吗
						try {
							value = new String(value.getBytes("ISO-8859-1"), Const.UTF8);
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
		Map whereMap = ObjectUtil.isNotNull(contentModel)?
				this.searchMap(articleFieldName, diyFieldName, JSONArray.parseArray(contentModel.getModelField())):
				new HashMap();

		// 获取符合条件的文章总数
		int count = contentBiz.getSearchCount(contentModel, whereMap, BasicUtil.getAppId(), categoryIds);
		//设置分页类
		PageBean page = new PageBean();
		//读取模板的分页数量
		int size = BasicUtil.getInt(ParserUtil.SIZE,10);
		try {
			size = TagParser.getPageSize(ParserUtil.read(ParserUtil.SEARCH+ParserUtil.HTM_SUFFIX,false ));
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
			content = CmsParserUtil.generate(ParserUtil.SEARCH+ParserUtil.HTM_SUFFIX,map, isMobileDevice(request));
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
			Map field = get(key, fields);
			if (field != null) {
				List list = new ArrayList();
				// 是否为自定义字段0
				list.add(0, true);
				List listValue = new ArrayList();
				// 字段的值
				if ("int".equals(field.get("javaType") ) || "float".equals(field.get("javaType") )|| "Double".equals(field.get("javaType")) ) {
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

	private Map get(String key, List<Map> fields) {
		for (Map field : fields) {
			if(key.equals(field.get("key"))){
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