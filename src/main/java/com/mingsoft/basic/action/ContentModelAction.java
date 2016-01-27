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

package com.mingsoft.basic.action;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.basic.biz.IContentModelBiz;
import com.mingsoft.basic.biz.IFieldBiz;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.basic.entity.ContentModelEntity;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;
/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
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
 * @author 姓名：张敏
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:内容模型控制层，继承BasicAction
 * </p>
 *  
 * <p>
 * Create Date:2014-9-12
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Controller
@RequestMapping("/manager/contentModel/")
public class ContentModelAction extends com.mingsoft.basic.action.BaseAction{
	
	/**
	 * 自定义表前缀
	 */
	private static final String TABLE_NAME_PREFIX = "cms_";
	/**
	 * 表名分隔符
	 */
	private static final String TABLE_NAME_SPLIT= "_";
	/**
	 * 表单管理业务层
	 */
	@Autowired
	private IContentModelBiz contentModelBiz;
	
	/**
	 * 注入字段业务层
	 */
	@Autowired
	private IFieldBiz fieldBiz;
	
	/**
	 * 表单列表
	 * @return 返回表单列表页面
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
		// 获取当前管理员实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		//获取当前管理员Id
		int managerId = managerSession.getManagerId();
		String pageNo = request.getParameter("pageNo");
		if (!StringUtil.isInteger(pageNo)) {
			pageNo = "1";
		}
		int recordCount = contentModelBiz.getContentModelByManagerId(managerId);
		PageUtil page = new PageUtil(1000);
		this.setCookie(request, response, CookieConst.PAGENO_COOKIE, pageNo);
		List<BaseEntity> listContentModel = contentModelBiz.queryPageByManagerId(page, "CM_ID", false,managerId);
		model.addAttribute("listContentModel", listContentModel);
		model.addAttribute("page", page);
		return "/manager/content_model/content_model_list";
	}
	
	/**
	 * 删除表单类型
	 * @param cmId 表单ID
	 * @param request 请求
	 * @param response 响应
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public void delete(HttpServletRequest request,HttpServletResponse response) {
		String cmIds = request.getParameter("cmId");
		if (!StringUtil.isBlank(cmIds) && StringUtil.isIntegers(cmIds.split(","))) {
			Integer[] ids = StringUtil.stringsToIntegers(cmIds.split(","));
			for (int i=0;i<ids.length;i++) {
				ContentModelEntity cme =  (ContentModelEntity)contentModelBiz.getEntity(ids[i]);
				contentModelBiz.dropTable(cme.getCmTableName());
				contentModelBiz.deleteEntity(ids[i]);
			}
			this.outJson(response, true); 
		}
	}
	
	/**
	 * 增加表单 
	 * @param request 请求
	 * @return 增加表单页面
	 */
	@RequestMapping("/add")
	public String add(ModelMap model) {
		model.addAttribute("contentModel",new ContentModelEntity());
		return "/manager/content_model/content_model";
	}
	
	/**
	 * 编辑表单
	 * @param cmId 表单ID
	 * @return 编辑表单页面
	 */
	@RequestMapping("/{cmId}/edit")
	@ResponseBody
	public void edit(@PathVariable int cmId, HttpServletResponse response) {
		//获取表单实体
		ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(cmId);
		this.outJson(response, JSONObject.toJSONString(contentModel));
	}
	
	
	
	/**
	 * 保存内容模型实体
	 * @param contentModel
	 * @param response 
	 */
	@RequestMapping("/save")
	@ResponseBody
	public void save(@ModelAttribute ContentModelEntity contentModel,HttpServletRequest request, HttpServletResponse response){
		// 保存前判断数据是否合法
		if(!StringUtil.checkLength(contentModel.getCmTipsName(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("content.model.tips.name"),"1","30"));
			return;
		}
		if (!StringUtil.checkLength(contentModel.getCmTableName(), 1,20)) {
			this.outJson(response, null, false,getResString("err.length",this.getResString("content.model.table.name"),"1","20"));
			return;
		}
		
		// 获取当前管理员实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		//获取当前管理员Id
		int managerId = managerSession.getManagerId();
		if (contentModelBiz.getContentModelByTableName(TABLE_NAME_PREFIX+contentModel.getCmTableName()+TABLE_NAME_SPLIT+managerId)!=null) {
			this.outJson(response, null, false,getResString("err.exist",this.getResString("content.model")));
			return;
		}
		
		
		contentModel.setCmManagerId(managerId);
		// 新增表名为"cms_"+用户填写的表名+"_"+站点id
		contentModel.setCmTableName(TABLE_NAME_PREFIX+contentModel.getCmTableName()+TABLE_NAME_SPLIT+managerId);
		// 新增表
		contentModelBiz.createTable(contentModel.getCmTableName(),null);
		contentModelBiz.saveEntity(contentModel);
		int cmId= contentModelBiz.getContentModelByTableName(contentModel.getCmTableName()).getCmId();
		
		this.outJson(response, null, true,String.valueOf(cmId));
	}
	
	/**
	 * 更新内容模型实体
	 * @param contentModel 内容模型实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute ContentModelEntity contentModel,HttpServletRequest request, HttpServletResponse response){
		// 保存前判断数据是否合法
		if(!StringUtil.checkLength(contentModel.getCmTipsName(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("content.model.tips.name"),"1","30"));
			return;
		}
		// 获取当前管理员实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		//获取当前管理员Id
		int managerId = managerSession.getManagerId();
		contentModel.setCmManagerId(managerId);
		contentModelBiz.updateEntity(contentModel);
		this.outJson(response, null, true,null);
	}
	
	/**
	 * 判断自定义模型表名是否重复
	 * @param cmTableName 表明
	 * @param request
	 * @return true:存在重复,false:不存在重复
	 */
	@RequestMapping("/{cmTableName}/checkcmTableNameExist")
	@ResponseBody
	public boolean checkcmTableNameExist(@PathVariable String cmTableName, HttpServletRequest request) {
		// 获取当前管理员实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		//获取当前管理员Id
		int managerId = managerSession.getManagerId();
		cmTableName =TABLE_NAME_PREFIX+cmTableName+TABLE_NAME_SPLIT+managerId;
		// 判断表名是否重复
		if(contentModelBiz.getContentModelByTableName(cmTableName)!=null){
			return true;
		}else{
			return false;
		}
		
	}
}