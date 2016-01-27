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
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.biz.IRoleBiz;
import com.mingsoft.basic.biz.IRoleModelBiz;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.basic.entity.RoleEntity;
import com.mingsoft.basic.entity.RoleModelEntity;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 角色控制层
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-7-14<br/>
 * 历史修订：<br/>
 */
@Controller
@RequestMapping("/manager/role")
public class RoleAction extends BaseAction{
	
	/**
	 * 角色业务层
	 */
	@Autowired
	private IRoleBiz roleBiz;
	
	/**
	 * 模块业务层
	 */
	@Autowired
	private IModelBiz modelBiz;
	
	/**
	 * 管理员业务层
	 */
	@Autowired
	private IManagerBiz managerBiz;
	
	/**
	 * 角色模块关联业务层
	 */
	@Autowired
	private IRoleModelBiz roleModelBiz;
	
	/**
	 * 普通管理员角色列表路径
	 */
	private final static String PAGE_URL = "/manager/role/queryList.do";
	
	/**
	 * 加载角色列表页面并查询角色查询
	 * @param request 请求对象
	 * @param mode ModelMap实体对象
	 * @param response 响应对象
	 * @return 角色列表页面地址
	 */
	@RequestMapping("/queryList")
	public String queryList(HttpServletRequest request, ModelMap mode, HttpServletResponse response){
		List<BaseEntity> listRole = new ArrayList<BaseEntity>();
		ManagerSessionEntity managerSession = getManagerBySession(request);
		String pageNo = request.getParameter("pageNo");
		if (!StringUtil.isInteger(pageNo)) {
			pageNo = "1";
		}
		int recordCount = roleBiz.getCountByManagerId(managerSession.getManagerId());
		PageUtil page = new PageUtil(StringUtil.string2Int(pageNo),recordCount, getUrl(request) + PAGE_URL);
		this.setCookie(request, response, CookieConst.PAGENO_COOKIE, pageNo);
		String url =  "/manager/role/queryList.do";
		//压入返回的url地址
		this.setCookie(request, response, CookieConst.BACK_COOKIE,url+"?pageNo="+pageNo);
		listRole = roleBiz.queryByPage(managerSession.getManagerId(), page, "ROLE_ID", false);
		mode.addAttribute("listRole",listRole);
		mode.addAttribute("page", page);
		mode.addAttribute("managerRoleId", managerSession.getManagerRoleID());
		return "/manager/role/role_list";
	}
	
	/**
	 * 增加/更新角色时查询的模块列表
	 * @param model ModelMap实体对象
	 * @param request 请求
	 */
	public void queryModelList(HttpServletRequest request,ModelMap model){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		List<BaseEntity> listModel = modelBiz.queryModelByRoleId(managerSession.getManagerRoleID());
		if(!StringUtil.isBlank(listModel)){
			model.addAttribute("listModel", JSONObject.toJSONString(listModel));
		}
	}
	
	
	@RequestMapping("/{roleId}/queryByRole")
	@ResponseBody
	public void queryByRole(@PathVariable int roleId, HttpServletResponse response){
		List models = modelBiz.queryModelByRoleId(roleId);
		this.outJson(response, JSONObject.toJSONString(models));
	}
	
	
	/**
	 * 加载添加角色界面
	 * @param request 请求对象
	 * @param model ModelMap实体对象
 	 * @return 添加角色界面地址
	 */
	@RequestMapping("/add")
	public String add(HttpServletRequest request, ModelMap model){
	     //查询的模块列表
		 this.queryModelList(request,model);
		 model.addAttribute("flag", true);
		 return "/manager/role/role";
	}
	
	/**
	 * 更新角色
	 * @param roleId 角色id
	 * @param model ModelMap实体对象
	 * @param request 请求对象
	 * @return 角色编辑页面地址
	 */
	@RequestMapping("/{roleId}/edit")
	public String edit(@PathVariable int roleId,ModelMap model,HttpServletRequest request){
		if(roleId == 0){
			return "/manager/role/list";
		}
		//查询的模块列表
		this.queryModelList(request,model);
		RoleEntity role = (RoleEntity)roleBiz.getEntity(roleId);
		List<BaseEntity> listSelModel = modelBiz.queryModelByRoleId(roleId);
		model.addAttribute("role",role);
		if(!StringUtil.isBlank(listSelModel)){
			model.addAttribute("listSelModel", listSelModel);
		}
		model.addAttribute("flag", false);
		return "/manager/role/role";
				
	}
	
	/**
	 * 表单验证
	 * @param role 角色实体
	 * @param response 响应
	 * @return 返回验证结果
	 */
	public boolean validateForm(RoleEntity role, HttpServletResponse response) {
		//判断角色名称的长度
		if(!StringUtil.checkLength(role.getRoleName(), 2, 8)){
			this.outJson(response, ModelCode.ROLE, false, getResString("err.length", this.getResString("rolrName"), "2", "8"));	
			return false;
		} 
		//验证该角色名称是否已存在
		if(roleBiz.countRoleName(role.getRoleName(),role.getRoleManagerId()) != 0){
			this.outJson(response, ModelCode.ROLE, false, getResString("err.exist",this.getResString("rolrName")));	
			return false;
		}
		return true;
	}
	
	/**
	 * 增加/更新角色
	 * @param role 角色实体
	 * @param request 请求
	 * @param response 响应
	 * @param flag 判断是增加还是更新 true:增加 false:更新
	 */
	public void saveOrUpdateRole(RoleEntity role,HttpServletRequest request, HttpServletResponse response, boolean flag){
		//验证表单
		if (!this.validateForm(role, response)) {
			return;
		}
		//若为更新角色，数据库中存在该角色名称且当前名称不为更改前的名称，则属于重名
		if(!flag && roleBiz.countRoleName(role.getRoleName(),role.getRoleManagerId()) != 0  && !role.getRoleName().equals(request.getParameter("oldRoleName"))){
			this.outJson(response, ModelCode.ROLE, false, getResString("roleName.exist"));	
			return;
		}
		ManagerSessionEntity managerSession = getManagerBySession(request);
		//设置该角色创建者ID
		role.setRoleManagerId(managerSession.getManagerId());
		if(flag){
			//增加角色
			roleBiz.saveEntity(role);
		} else {
			//更新角色
			roleBiz.updateEntity(role);
		}
		//为该角色增加/更新功能模块
		List<RoleModelEntity> roleModelList = null;
		String modelId[] = request.getParameterValues("modelId");
		if(!StringUtil.isBlank(modelId)){
			//将获取的模块ID分割成数组
			modelId = modelId[0].split(","); 
		} 
		//若没有选择功能模块，则提示错误，并将其数据库中该已存在的模块删除
		if(StringUtil.isBlank(modelId[0])){
			roleModelBiz.deleteEntity(role.getRoleId());
			this.outJson(response, ModelCode.ROLE, false, getResString("err.modelNoSelected"));	
			return;
		} 
		roleModelList = new ArrayList<RoleModelEntity>();
		for(int i=0; i<modelId.length; i++){
			RoleModelEntity roleModel = new RoleModelEntity();
			roleModel.setModelId(Integer.parseInt(modelId[i]));
			roleModel.setRoleId(roleBiz.queryRoleByRoleName(role.getRoleName(),role.getRoleManagerId()).getRoleId());
			roleModelList.add(roleModel);
		}
		if(flag){
			//在角色模块表中添加数据
			roleModelBiz.saveEntity(roleModelList);
		} else {
			//修改该角色所拥有的模块数据
			roleModelBiz.deleteEntity(role.getRoleId());
			roleModelBiz.updateEntity(roleModelList);
		}
		String url = this.getCookie(request, CookieConst.BACK_COOKIE);
		this.outJson(response, ModelCode.ROLE, true, url);
	}
	
	/**
	 * 增加/更新角色
	 * @param role 角色实体
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute RoleEntity role,HttpServletRequest request, HttpServletResponse response){
		//增加角色
		this.saveOrUpdateRole(role, request, response, true);
	}
	
	/**
	 * 更新角色
	 * @param role 角色实体
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/update")
	public void update(@ModelAttribute RoleEntity role, HttpServletRequest request, HttpServletResponse response){
		//更新角色
		this.saveOrUpdateRole(role, request, response, false);
	}
		
	/**
	 * 判断角色名称是否存在
	 * @param roleName 角色名称
	 * @param response 响应
	 */
	/**
	 * 判断角色名称是否存在
	 * @param roleName 角色名称
	 * @param request 请求对象
	 * @return true：名称存在，false角色不存在
	 */
	@RequestMapping("/judgeRoleNameExist")
	@ResponseBody
	public boolean judgeRoleNameExist(@RequestParam("roleName") String roleName,HttpServletRequest request){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		if(roleBiz.countRoleName(roleName,managerSession.getManagerId()) != 0){
			 return true;
		} else {
			return false;
		}
	}
	 
	/**
	 * 根据角色id删除角色
	 * @param roleId 角色id
	 * @param request 请求对象
	 * @return 当前页码数
	 */
	@RequestMapping("/{roleId}/delete")
	@ResponseBody
	public int delete(@PathVariable int roleId, HttpServletRequest request){
		int pageNo = 1;
		if(roleId != 0){
			managerBiz.deleteManagerByRoleId(roleId);
			roleBiz.deleteEntity(roleId);
			//判断当前页码
			this.getHistoryPageNoByCookie(request);
		}
		return pageNo;
	}
	
	/**
	 * 批量删除角色
	 * @param request 请求对象
	 * @return 返回当前页码数
	 */
	@RequestMapping("/allDelete")
	@ResponseBody
	public int allDelete(HttpServletRequest request){
		int pageNo = 1;
		//获取所选的复选框
		String ids[] = request.getParameterValues("ids");
		if(!StringUtil.isBlank(ids)){
			roleBiz.deleteAll(ids);
			//判断当前页码
			this.getHistoryPageNoByCookie(request);
		}
		return pageNo;
	}
	
}