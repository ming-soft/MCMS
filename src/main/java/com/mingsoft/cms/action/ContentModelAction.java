package com.mingsoft.cms.action;
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

import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.cms.biz.IContentModelBiz;
import com.mingsoft.cms.entity.ContentModelEntity;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.SessionConst;
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
@RequestMapping("/manager/cms/contentModel/")
public class ContentModelAction extends BaseAction{
	
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
	 * 表单列表路径
	 */
	private final static String PAGE_URL="/manager/cms/contentModel/list.do";
	
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
		PageUtil page = new PageUtil(StringUtil.string2Int(pageNo), recordCount, getUrl(request)+ PAGE_URL);
		this.setCookie(request, response, CookieConst.PAGENO_COOKIE, pageNo);
		List<BaseEntity> listContentModel = contentModelBiz.queryPageByManagerId(page, "CM_ID", false,managerId);
		model.addAttribute("listContentModel", listContentModel);
		model.addAttribute("page", page);
		return "/manager/cms/form/form_list";
	}
	
	/**
	 * 删除表单类型
	 * @param cmId 表单ID
	 * @param request 请求
	 * @param response 响应
	 */
	@RequestMapping("/{cmId}/delete")
	@ResponseBody
	public int delete(@PathVariable int cmId, HttpServletRequest request) {
		int pageNo = 1;
		if (cmId != 0) {
			ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(cmId);
			contentModelBiz.dropTable(contentModel.getCmTableName());
			contentModelBiz.deleteEntity(cmId);
			//判断当前页码
			this.getHistoryPageNoByCookie(request);
		}
		return pageNo;
	}
	
	/**
	 * 增加表单 
	 * @param request 请求
	 * @return 增加表单页面
	 */
	@RequestMapping("/add")
	public String add(ModelMap model) {
		model.addAttribute("cmId", 0);
		model.addAttribute("flag", true);
		return "/manager/cms/form/form";
	}
	
	/**
	 * 编辑表单
	 * @param cmId 表单ID
	 * @return 编辑表单页面
	 */
	@RequestMapping("/{cmId}/edit")
	public String edit(@PathVariable int cmId, ModelMap model) {
		//获取表单实体
		ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(cmId);
		model.addAttribute("contentModel", contentModel);
		model.addAttribute("cmId", cmId);
		model.addAttribute("flag", false);
		return "/manager/cms/form/form";
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
			this.outJson(response, null, false,getResString("err.length",this.getResString("cmTipsName"),"1","30"));
			return;
		}
		if(!StringUtil.checkLength(contentModel.getCmTableName(), 1,20)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("cmTableName"),"1","20"));
			return;
		}
		// 获取当前管理员实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		//获取当前管理员Id
		int managerId = managerSession.getManagerId();
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
			this.outJson(response, null, false,getResString("err.length",this.getResString("cmTipsName"),"1","30"));
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
	 * 判断字段名是否存在重复
	 * @param fieldFieldName :字段名
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
