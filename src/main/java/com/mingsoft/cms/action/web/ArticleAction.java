/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.entity.ListJson;
import com.mingsoft.cms.biz.IArticleBiz;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.basic.biz.IContentModelBiz;
import com.mingsoft.basic.biz.IFieldBiz;
import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.basic.entity.ContentModelEntity;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
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
 * @author 王天培
 *                QQ:78750478
 *
 * <p>
 * Comments: 前段文章控制，如果标签不能满足可以使用这个控制来满足用户的查询文章需求，主要是通过ajax返回json数据格式
 * </p>
 *
 * <p>
 * Create Date:2014-10-15
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Controller("jsonApiArticle")
@RequestMapping("/article")
public class ArticleAction extends BaseAction{

	/**
	 * 文章管理业务处理层
	 */
	@Autowired
	private IArticleBiz articleBiz;

	
	/**
	 * 自定义字段管理业务处理层
	 */
	@Autowired
	private IFieldBiz fieldBiz;
	
	/**
	 * 栏目管理业务处理层
	 */
	@Autowired
	private IColumnBiz columnBiz;
	
	/**
	 * 内容模型管理业务处理层
	 */
	@Autowired
	private IContentModelBiz contentModelBiz;
	
	
	/**
	 * 查询文章列表信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/list")
	@ResponseBody
	public void list(HttpServletRequest request, HttpServletResponse response) {
		String pageNo = request.getParameter("pageNo"); //分页
		String pageSize = request.getParameter("pageSize"); //分页数量
		String categoryId = request.getParameter("categoryId"); //分类
		String isHasChilds = request.getParameter("isHasChilds"); //是否取子类信息
		
		if (!StringUtil.isInteger(pageNo)) {
			pageNo = "1";
		}
		int _pageSize = 10;
		if (StringUtil.isInteger(pageSize)) {
			_pageSize = Integer.parseInt(pageSize);
		}
		int _categoryId = Integer.parseInt(categoryId);
		
		boolean _isHasChilds = false; //true取子栏目，false取当前栏目
		if (!StringUtil.isBlank(isHasChilds) && isHasChilds.equals("true")) {
			_isHasChilds = true;
		} 
		
		int count = articleBiz.countByCategoryId(_categoryId);
		PageUtil page=new PageUtil(Integer.parseInt(pageNo),_pageSize,count,getUrl(request)+"/list.do");
		List list = articleBiz.queryPageByCategoryId(_categoryId,this.getAppId(request), page,_isHasChilds);
		ListJson json = new ListJson(count,list);
		this.outJson(response, JSONObject.toJSONString(json));
	}
	
	
	/**
	 * 
	 * 显示文章
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{basicId}/detail")
	@ResponseBody
	public void detail(@PathVariable int basicId,HttpServletRequest request, HttpServletResponse response) {
		if (basicId<=0) {
			this.outJson(response, this.getResString("err"));
		}
		ArticleEntity map = articleBiz.getById(basicId);
		this.outJson(response, JSONObject.toJSONString(map));
	}
	
	/**
	 * 
	 * 显示文章
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{basicId}/fieldDetail")
	@ResponseBody
	public void fieldDetail(@PathVariable int basicId,HttpServletRequest request, HttpServletResponse response){
		if (basicId<=0) {
			this.outJson(response, this.getResString("err"));
		}
		//获取文章实体
		ArticleEntity article = articleBiz.getById(basicId);
		//判断文章是否存在
		if(article==null){
			this.outJson(response, this.getResString("err"));
		}
		//获取文章栏目id获取栏目实体
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(article.getBasicCategoryId());
		//判断栏目是否存在
		if(column==null){
			this.outJson(response, this.getResString("err"));
		}
		//判断该栏目是否存在类型模型
		if(column.getColumnContentModelId()==0){
			this.outJson(response, this.getResString("err"));
		}
		ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(column.getColumnContentModelId());
		
		//判断内容模型的值
		if(contentModel==null){
			this.outJson(response, this.getResString("err"));
		}
		Map where = new HashMap();
		// 压入basicId字段的值
		where.put("basicId", basicId);
		// 遍历所有的字段实体,得到字段名列表信息
		List<String> listFieldName = new ArrayList<String>();
		listFieldName.add("basicId");
		// 查询新增字段的信息
		List fieldLists = fieldBiz.queryBySQL(contentModel.getCmTableName(), listFieldName, where);
		if (fieldLists != null || fieldLists.size()>0) {
			Map map = (Map)fieldLists.get(0);
			//返回信息
			this.outJson(response, JSONObject.toJSONString(map));
		}
	
	}
	
	/**
	 * 点击量
	 * @param basicId 数据编号
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{basicId}/hit")
	@ResponseBody
	public void hit(@PathVariable int basicId,HttpServletRequest request, HttpServletResponse response) {
		if (basicId<=0) {
			this.outJson(response, this.getResString("err"));
		}
		//获取文章实体
		ArticleEntity article = articleBiz.getById(basicId);
		//判断文章是否存在
		if(article==null){
			this.outJson(response, this.getResString("err"));
		}
		//判断该文章是否是改应用下
		if (article.getArticleWebId()!=this.getAppId(request)) {
			this.outJson(response, this.getResString("err"));
		}
		//更新点击量
		articleBiz.updateHit(basicId, article.getBasicHit()+1);
		this.outJson(response, String.valueOf(article.getBasicHit()+1));
	}
	
}