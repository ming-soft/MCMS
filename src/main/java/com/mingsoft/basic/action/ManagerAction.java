package com.mingsoft.basic.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.biz.IRoleBiz;
import com.mingsoft.basic.biz.IRoleModelBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.basic.entity.RoleEntity;
import com.mingsoft.basic.entity.RoleModelEntity;
import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 管理员控制层
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-7-14<br/>
 * 历史修订：<br/>
 */
@Controller
@RequestMapping("/manager/manager")
public class ManagerAction extends BaseAction {

	/**
	 * 管理员业务层
	 */
	@Autowired
	private IManagerBiz managerBiz;

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
	 * 角色模块关联业务层
	 */
	@Autowired
	private IRoleModelBiz roleModelBiz;

	/**
	 * 站点业务层
	 */
	@Autowired
	private IAppBiz appBiz;

	/**
	 * 普通管理员列表路径
	 */
	private final static String PAGE_URL = "/manager/manager/queryList.do";

	/**
	 * 加载管理员列表页面并查询管理员列表
	 * @param request 请求对象
	 * @param model ModelMap实体对象
	 * @param response 响应对象
	 * @return 管理员列表地址
	 */
	@RequestMapping("/queryList")
	public String queryList(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
		List<BaseEntity> listManager = new ArrayList<BaseEntity>();
		ManagerSessionEntity managerSession = getManagerBySession(request);
		//若为网站管理员，则显示自己和其创建的子管理员
		if (managerSession.getManagerRoleID() == Const.DEFAULT_WEBSITE_MANGER_ROLE_ID) {
			listManager = managerBiz.queryAllChildManager(managerSession.getManagerId());
			listManager.add(managerSession);
		} 
		//若为子管理员，则显示其父管理员下的所有子管理员
		else {
			listManager = managerBiz.queryAllChildManager(managerSession.getManagerParentID());
		}
		String pageNo = request.getParameter("pageNo");
		if (!StringUtil.isInteger(pageNo)) {
			pageNo = "1";
		}
		int recordCount = listManager.size();
		PageUtil page = new PageUtil(StringUtil.string2Int(pageNo), recordCount, getUrl(request)+ PAGE_URL);
		this.setCookie(request, response, CookieConst.PAGENO_COOKIE, pageNo);
		listManager = managerBiz.queryByPage(managerSession.getManagerId(), page, "m.MANAGER_ID", false);
		request.setAttribute("managerSession", managerSession);
		
		List<BaseEntity> listRole = roleBiz.queryRoleByManagerId(managerSession.getManagerId());
		if(listRole != null){
			model.addAttribute("listRole", listRole);
		}
		model.addAttribute("listManager", listManager);
		model.addAttribute("page", page);
		return "/manager/manager/manager";
	}
	
	/**
	 * 增加/更新管理员时查询的角色列表
	 * @param model Map集合（存放角色的集合）
	 * @param request 请求
	 */
	public void queryRoleList(Map model, HttpServletRequest request){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		List<BaseEntity> listRole = roleBiz.queryRoleByManagerId(managerSession.getManagerId());
		if(listRole != null){
			model.put("listRole", listRole);
		}
	}
	
	/**
	 * 增加/更新管理员时查询的模块列表
	 * @param request 请求对象
	 * @param model Map集合（存放模块的集合）
	 */
	public void queryModelList(HttpServletRequest request, Map model){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		List<BaseEntity> listModel = null;
		if(managerSession.getManagerRoleID() == Const.DEFAULT_SYSTEM_MANGER_ROLE_ID){
			listModel = modelBiz.queryModelByManager();
		} else {
			listModel = modelBiz.queryModelByRoleId(managerSession.getManagerRoleID());
		}
		if(!StringUtil.isBlank(listModel)){
			model.put("listModel", listModel);
		}
	}

	/**
	 * 增加管理员 返回模块列表以供选择
	 * @param request
	 * @return 模块列表集合
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Map add(HttpServletRequest request) {
		Map model = new HashMap();
		//查询的角色列表
		this.queryRoleList(model,request);
		//查询的模块列表
		this.queryModelList(request,model);
		model.put("flag", true);
		model.put("listSelModel", "");
		return model;
	}
	
	/**
	 * 更新管理员 返回模块列表以供选择和管理员自身信息到更新页面：帐号、昵称、密码、角色
	 * @param managerId 管理员id
	 * @param request 请求对象
	 * @return 模块列表集合
	 */
	@RequestMapping("/{managerId}/edit")
	@ResponseBody
	public Map edit(@PathVariable int managerId, HttpServletRequest request) {
		Map model = new HashMap();
		//查询的角色列表
		this.queryRoleList(model,request);
		//查询的模块列表
		this.queryModelList(request,model);
		ManagerEntity manager = (ManagerEntity) managerBiz.getEntity(managerId);
		//返回已拥有的模块列表
		List<BaseEntity> listSelModel = modelBiz.queryModelByRoleId(manager.getManagerRoleID());
		manager.setManagerPassword(null);
		model.put("manager", manager);
		if(!StringUtil.isBlank(listSelModel)){
			model.put("listSelModel", listSelModel);
		}
		model.put("flag", false);
		return model;
	}

	/**
	 * 表单验证
	 * @param manager 管理员实体
	 * @param response 响应
	 * @return 返回验证结果true：通过，false不通过
	 */
	public boolean checkForm(ManagerEntity manager, HttpServletResponse response) {
		//验证帐号长度
		if (!StringUtil.checkLength(manager.getManagerName(), 1, 12)) {
			this.outJson( response, ModelCode.ROLE, false, getResString("err.length", this.getResString("managerName"), "1", "12"));
			return false;
		}
		//验证昵称长度
		if (!StringUtil.checkLength(manager.getManagerNickName(), 2, 15)) {
			this.outJson( response, ModelCode.ROLE, false, getResString("err.length", this.getResString("managerNickName"), "2", "15"));
			return false;
		}
		//若密码为空则表示是从更新模态框传递过来的数据，并且表示不更新管理员，若密码不为空，一定要进行验证
		if(!StringUtil.isBlank(manager.getManagerPassword())){
			//验证密码长度
			if (!StringUtil.checkLength(manager.getManagerPassword(), 1, 16)) {
				this.outJson( response, ModelCode.ROLE, false, getResString("err.length", this.getResString("managerPassword"), "1", "16"));
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 保存或修改角色
	 * @param role 角色实体
	 * @param request
	 * @param response
	 * @param flag true:保存   false:更新
	 */
	public void saveOrUpdateRole(RoleEntity role,HttpServletRequest request, HttpServletResponse response, boolean flag){
		String oldRoleName = request.getParameter("oldRoleName");
		//若为更新角色，数据库中存在该角色名称且当前名称不为更改前的名称，则属于重名
		if(!flag && roleBiz.countRoleName(role.getRoleName(),role.getRoleManagerId()) != 0  && !role.getRoleName().equals(oldRoleName)){
			this.outJson(response, ModelCode.ROLE, false, getResString("roleName.exist"));	
			return;
		}
		if(flag){
			//增加角色
			roleBiz.saveEntity(role);
		} else {
			//更新角色
			roleBiz.updateEntity(role);
		}
		int roleId = roleBiz.queryRoleByRoleName(role.getRoleName(), role.getRoleManagerId()).getRoleId();
		//为该角色增加/更新功能模块
		List<RoleModelEntity> roleModelList = null;
		String modelId[] = request.getParameterValues("modelIds");
		if(!StringUtil.isBlank(modelId)){
			//将获取的模块ID分割成数组
			modelId = modelId[0].split(","); 
		} 
		//若没有选择功能模块，则提示错误，并将其数据库中该已存在的模块删除
		if(StringUtil.isBlank(modelId[0])){
			roleModelBiz.deleteEntity(roleId);
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
			roleModelBiz.deleteEntity(roleId);
			roleModelBiz.updateEntity(roleModelList);
		}
	}
	
	/**
	 * 保存或更新管理员
	 * @param flag true:保存   false:更新
	 * @param manager 管理员实体
	 * @param request
	 * @param response
	 */
	public void saveOrUpdateManager(boolean flag, ManagerEntity manager, HttpServletRequest request, HttpServletResponse response){
		int pageNo = 1;
		String oldManagerName = request.getParameter("oldManagerName");
		String oldPassword = manager.getManagerPassword();
		//判断是否帐号已存在
		if (!StringUtil.isBlank(managerBiz.countManagerName(manager.getManagerName())) && flag) {
			this.outJson(response, ModelCode.ROLE, false, getResString("err.exist",this.getResString("managerName")));
			return;
		}
		//若数据库中存在该名称且当前名称不为更改前的名称，则属于重名
		if (!StringUtil.isBlank(managerBiz.countManagerName(manager.getManagerName())) && !manager.getManagerName().equals(oldManagerName)) {
			this.outJson(response, ModelCode.ROLE, false, getResString("err.exist",this.getResString("managerName")));
			return;
		}		
		//验证表单
		if (!this.checkForm(manager, response)) {
			return;
		}
		int websiteID = 0;int managerId = 0;
		String basicId = request.getParameter("basicId");
		//加密密码
		// 新增网站时添加管理员
		if (!StringUtil.isBlank(basicId)) {
			RoleEntity role = new RoleEntity();
			if(flag){
				manager.setManagerPassword(StringUtil.Md5(manager.getManagerPassword()));
				//保存站点管理员
				websiteID = Integer.parseInt(basicId);
				managerBiz.saveEntity(manager);
				role.setRoleName(manager.getManagerName());
				managerId = managerBiz.queryManagerByManagerName(manager.getManagerName()).getManagerId();
				role.setRoleManagerId(managerId);
				//保存角色
				this.saveOrUpdateRole(role, request, response, true);
				//更新网站管理员编号
				AppEntity website = (AppEntity) appBiz.getEntity(websiteID);
				website.setAppManagerId(managerId);
				appBiz.updateEntity(website);
			} else {
				role.setRoleName(manager.getManagerName());
				managerId = managerBiz.queryManagerByManagerName(manager.getManagerName()).getManagerId();
				role.setRoleManagerId(managerId);
				//更新角色
				this.saveOrUpdateRole(role, request, response, false);
			}
			//设置管理员角色ID为自身角色ID
			manager.setManagerRoleID(roleBiz.queryRoleByRoleName(role.getRoleName(), role.getRoleManagerId()).getRoleId());
			manager.setManagerId(managerId);
			if(!StringUtil.isBlank(manager.getManagerPassword())){
				manager.setManagerPassword(StringUtil.Md5(oldPassword));
				//更新管理员
				managerBiz.updateEntity(manager);
			}
		} else {
			manager.setManagerPassword(StringUtil.Md5(manager.getManagerPassword()));
			if(flag){
					managerBiz.saveEntity(manager);					
			} else {
				if(!StringUtil.isBlank(manager.getManagerPassword())){
					managerBiz.updateEntity(manager);
				}
			}
		}
		if(flag){
			//"1"：保存管理员后跳到第一页
			this.outJson(response, ModelCode.ROLE, true, "1");
		} else {
			//判断当前页码
			this.getHistoryPageNoByCookie(request);
			this.outJson(response, ModelCode.ROLE, true, String.valueOf(pageNo));
		}
	}
	
	/**
	 * 增加管理员
	 * @param manager 管理员实体
	 * @param request 请求
	 * @param response 响应
	 */
	@RequestMapping("/save")
	@ResponseBody
	public void save(@ModelAttribute ManagerEntity manager, HttpServletRequest request, HttpServletResponse response) {
		this.saveOrUpdateManager(true, manager, request, response);
	}
		
	/**
	 * 更新管理员
	 * @param manager 管理员实体
	 * @param request 请求
	 * @param response 响应
	 */
	@RequestMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute ManagerEntity manager, HttpServletRequest request, HttpServletResponse response) {
		this.saveOrUpdateManager(false, manager, request, response);
	}

	/**
	 * 判断管理员帐号是否存在
	 * @param managerName 管理员账号
	 * @return true：存在，false：不存在
	 */
	@RequestMapping("/judgeManagerNameExist")
	@ResponseBody
	public boolean judgeManagerNameExist( @RequestParam("managerName") String managerName) {
		if (!StringUtil.isBlank(managerBiz.countManagerName(managerName))) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 根据管理员id删除管理员
	 * @param managerId 管理员id
	 * @param request 请求对象
	 * @return 返回当前页码
	 */
	@RequestMapping("/{managerId}/delete")
	@ResponseBody
	public int delete(@PathVariable int managerId, HttpServletRequest request) {
		int pageNo = 1;
		if (managerId != 0) {
			managerBiz.deleteEntity(managerId);
			//判断当前页码
			this.getHistoryPageNoByCookie(request);
		}
		return pageNo;
	}

	/**
	 * 批量删除管理员
	 * @param request 请求
	 * @return 返回当前页码
	 */
	@RequestMapping("/allDelete")
	@ResponseBody
	public int allDelete(HttpServletRequest request) {
		int pageNo = 1;
		//获取所选的复选框
		String checkboxData[] = request.getParameterValues("checkbox");
		if (!StringUtil.isBlank(checkboxData)) {
			for (int i = 0; i < checkboxData.length; i++) {
				managerBiz.deleteEntity(Integer.parseInt(checkboxData[i]));
			}
			//判断当前页码
			this.getHistoryPageNoByCookie(request);
		}
		return pageNo;
	}


}
