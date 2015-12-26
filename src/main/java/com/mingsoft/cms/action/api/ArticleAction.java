package com.mingsoft.cms.action.api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.entity.ListJson;
import com.mingsoft.cms.biz.IArticleBiz;
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
 * @author 史爱华
 *                
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
@Controller("api")
@RequestMapping("api/article")
public class ArticleAction extends BaseAction {
	
	
	/**
	 * 文章管理业务处理层
	 */
	@Autowired
	private IArticleBiz articleBiz;
	
	
	/**
	 * 查询文章列表信息，供前端ajax请求文章数据使用
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	@ResponseBody
	public void list(HttpServletRequest request, HttpServletResponse response) {
		String isHasChilds = request.getParameter("isHasChilds"); //是否取子类信息
		Integer pageNo = this.getInt(request, "pageNo",1);//分页
		Integer pageSize = this.getInt(request, "pageSize",10);//分页数量
		Integer categoryId = this.getInt(request, "categoryId");//分类
		int appId = getAppId(request);
		boolean _isHasChilds = false; //true取子栏目，false取当前栏目
		if (!StringUtil.isBlank(isHasChilds) && isHasChilds.equals("true")) {
			_isHasChilds = true;
		} 
		int count =articleBiz. coutByCategoryAndChildsId(appId,categoryId,_isHasChilds);
		PageUtil page=new PageUtil(pageNo,pageSize,count,getUrl(request)+"/list.do");
		List list = articleBiz.queryByCategoryForBean(appId,categoryId, page, _isHasChilds);
		ListJson json = new ListJson(count,list);
		this.outJson(response, JSONObject.toJSONStringWithDateFormat(json,"yyyy-MM-dd HH:mm:ss"));
	}
	
}
