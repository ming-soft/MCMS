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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.biz.IManagerModelPageBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.basic.entity.ManagerModelPageEntity;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.basic.entity.ModelEntity;
import com.mingsoft.util.StringUtil;
/**
 * 主界面控制层
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-7-14<br/>
 * 历史修订：<br/>
 */
@Controller
@RequestMapping("/manager")
public class MainAction extends BaseAction {

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
	 * 管理员模块页面业务层
	 */
	@Autowired
	private IManagerModelPageBiz managerModelPageBiz;

	/**
	 * 加载后台主界面，并查询数据
	 * @param request 请求对象
	 * @return  主界面地址
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		ManagerSessionEntity managerSession = (ManagerSessionEntity) getManagerBySession(request);
		List<BaseEntity> modelList = new ArrayList<BaseEntity>();
		modelList = modelBiz.queryModelByRoleId(managerSession.getManagerRoleID());
		request.setAttribute("managerSession", managerSession);
		request.setAttribute("modelList", JSONObject.toJSONString(modelList));
		int managerId = managerSession.getManagerId();
		//根据管理员id查找管理员模块页面实体对象
		ManagerModelPageEntity managerModelPage =(ManagerModelPageEntity) managerModelPageBiz.getByManagerIdAndModelId(managerId,0);
		//如果存在管理员模块页面实体对象，则返回到页面
		if(managerModelPage!=null){
			request.setAttribute("managerModelPage", managerModelPage);
		}
		return "/manager/index";
	}

	/**
	 * 查询该父模块下的子模块
	 * @param modelId 模块ID
	 * @param request 请求对象
	 * @return 子模块列表map集合
	 */
	@RequestMapping(value = "/{modelId}/queryListByModelId", method = RequestMethod.POST)
	@ResponseBody
	public Map queryListByModelId(@PathVariable int modelId, HttpServletRequest request) {
		Map modelMap = new HashMap();
		List<BaseEntity> modelList = null;
		ManagerSessionEntity managerSession = (ManagerSessionEntity) getManagerBySession(request);
		if (isSystemManager(request) && modelId == Const.DEFAULT_CMS_MODEL_ID) { // 若为系统管理员且操作CMS模块
			modelList = modelBiz.queryModelByManagerId(Const.DEFAULT_SYSTEM_MANGER_ROLE_ID, modelId);
		} else if (isSystemManager(request)) { // 若为系统管理员且非操作CMS模块
			modelList = modelBiz.queryChildList(modelId);
		} else { // 其他管理员
			modelList = modelBiz.queryModelByRoleId(managerSession.getManagerRoleID());
			for (int i = 0; i < modelList.size(); i++) {
				ModelEntity model = (ModelEntity) modelList.get(i);
				if (model.getModelModelId() != modelId) {
					modelList.remove(i);
					i--;
				}
			}
		}
		modelMap.put("modelList", modelList);
		return modelMap;
	}

	/**
	 * 修改登录密码
	 * @param response 响应对象
	 * @param request 请求对象
	 */
	@RequestMapping("/editPassword")
	@ResponseBody
	public void editPassword(HttpServletResponse response, HttpServletRequest request) {
		//获取管理员信息
		ManagerEntity manager = (ManagerEntity) this.getManagerBySession(request);
		this.outJson(response, ModelCode.ROLE, false,  JSONObject.toJSONString(manager.getManagerName()));
	}

	/**
	 * 修改登录密码，若不填写密码则表示不修改
	 * 
	 * @param request
	 *            请求
	 * @param response
	 *            响应
	 */
	@RequestMapping("/updatePassword")
	@ResponseBody
	public void updatePassword( HttpServletResponse response,HttpServletRequest request) {
		//获取旧的密码,MD5加密
		String oldManagerPassword = StringUtil.Md5(request.getParameter("oldManagerPassword"));
		//获取新的密码
		String newManagerPassword = request.getParameter("newManagerPassword");
		//获取管理员信息
		ManagerEntity manager = (ManagerEntity) this.getManagerBySession(request);
		// 判断新密码和旧密码是否为空
		if (StringUtil.isBlank(newManagerPassword) || StringUtil.isBlank(oldManagerPassword)) {
			this.outJson(response, ModelCode.ROLE, false, getResString("err.empty", this.getResString("managerPassword")));
			return;
		}
		
		//判断旧的密码是否正确
		if(!oldManagerPassword.equals(manager.getManagerPassword())){
			this.outJson(response, ModelCode.ROLE, false, getResString("err.password", this.getResString("managerPassword")));
			return;
		}
		// 判断新密码长度
		if (!StringUtil.checkLength(newManagerPassword, 1, 16)) {
			this.outJson(response, ModelCode.ROLE, false, getResString("err.length", this.getResString("managerPassword"), "1", "16"));
			return;
		}
		//更改密码
		manager.setManagerPassword(StringUtil.Md5(newManagerPassword));
		//更新
		managerBiz.updateUserPasswordByUserName(manager);
		this.outJson(response, ModelCode.ROLE, true, null);
	}

	/**
	 * 退出系统
	 * @param request 请求对象
	 * @return true退出成功
	 */
	@RequestMapping("/loginOut")
	@ResponseBody
	public boolean loginOut(HttpServletRequest request) {
		removeSession(request, SessionConst.MANAGER_ESSION);
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return true;
	}
	
	/**
	 * 加载UI页面
	 * @param request
	 * @return UI页面地址
	 */
	@RequestMapping("/ui")
	public String ui(HttpServletRequest request) {
		return "/manager/ui";
	}
	
	/**
	 * 加载UI列表界面
	 * @param request
	 * @return 列表界面地址
	 */
	@RequestMapping("/ui/list")
	public String list(HttpServletRequest request) {
		return "/manager/ui/list";
	}	
	
	/**
	 * 加载UI的表单页面
	 * @param request
	 * @return 表单页面地址
	 */
	@RequestMapping("/ui/form")
	public String form(HttpServletRequest request) {
		return "/manager/ui/from";
	}	
}