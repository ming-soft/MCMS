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

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.biz.IRoleBiz;
import com.mingsoft.basic.biz.ISystemSkinBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.basic.entity.RoleEntity;
import com.mingsoft.basic.entity.SystemSkinEntity;
import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.ServerUtil;
import com.mingsoft.util.StringUtil;

/**
 * 登录的基础应用层
 * 
 * @author 王天培
 * @version 版本号：100-000-000<br/>
 *          创建日期：2015-1-10<br/>
 *          历史修订：<br/>
 */
@Controller
@RequestMapping("/ms")
public class LoginAction extends BaseAction {

	/**
	 * 管理员业务层
	 */
	@Autowired
	private IManagerBiz managerBiz;

	/**
	 * 角色业务request层
	 */
	@Autowired
	private IRoleBiz roleBiz;

	/**
	 * 站点业务层
	 */
	@Autowired
	private IAppBiz appBiz;

	/**
	 * 系统皮肤业务处理层
	 */
	@Autowired
	private ISystemSkinBiz systemSkinBiz;

	/**
	 * 加载管理员登录界面
	 * 
	 * @param request
	 *            请求对象
	 * @return 管理员登录界面地址
	 */
	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		// 根据请求地址来显示标题
		AppEntity app = this.getApp(request);
		// 判断应用实体是否存在
		if (app != null) {
			// 检测应用是否有自定义界面b
			SystemSkinEntity sse = systemSkinBiz.getByManagerId(app.getAppManagerId());
			if (sse != null && !StringUtil.isBlank(sse.getSystemSkinLoginPage())) {
				return "redirect:/" + sse.getSystemSkinLoginPage();
			}
		} else {

			File file = new File(this.getRealPath(request, "WEB-INF/ms.install"));
			if (file.exists()) {
				String defaultId = FileUtil.readFile(this.getRealPath(request, "WEB-INF/ms.install")).trim();
				if (!StringUtil.isBlank(defaultId)) {
					app = (AppEntity) appBiz.getEntity(Integer.parseInt(defaultId));
					app.setAppUrl(this.getUrl(request));
					appBiz.updateEntity(app);
					// 获取tomcat下面默认的manager文件夹
					File managerFile = new File(request.getSession().getServletContext().getRealPath("/"));
					new File(managerFile.getParent() + File.separator + "/manager").delete();
					FileUtil.writeFile(defaultId, this.getRealPath(request, "WEB-INF/ms.install.bak"), Const.UTF8);
					file.delete();
				}
			}

		}
		request.setAttribute("app", app);

		return "/manager/login";
	}

	/**
	 * 验证登录
	 * 
	 * @param manager
	 *            管理员实体
	 * @param request
	 *            请求
	 * @param response
	 *            响应
	 */
	@RequestMapping("/checkLogin")
	public void checkLogin(@ModelAttribute ManagerEntity manager, HttpServletRequest request,
			HttpServletResponse response) {
		AppEntity urlWebsite = null;
		urlWebsite = appBiz.getByUrl(this.getDomain(request)); // 根据url地址获取站点信息，主要是区分管理员对那些网站有权限
		if (urlWebsite == null) {
			this.outJson(response, ModelCode.ADMIN_LOGIN, false, this.getResString("err"));
			return;
		}
		// 根据账号获取当前管理员信息
		ManagerEntity _manager = managerBiz.queryManagerByManagerName(manager.getManagerName());
		if (_manager == null) {
			// 系统不存在此用户
			this.outJson(response, ModelCode.ADMIN_LOGIN, false, this.getResString("err.nameEmpty"));
		} else {
			// 判断当前用户输入的密码是否正确
			if (StringUtil.Md5(manager.getManagerPassword()).equals(_manager.getManagerPassword())) {
				SystemSkinEntity systemSkin = systemSkinBiz.getByManagerId(_manager.getManagerId());
				// 创建管理员session对象
				ManagerSessionEntity managerSession = new ManagerSessionEntity();
				AppEntity website = new AppEntity();
				// 获取管理员所在的角色
				RoleEntity role = (RoleEntity) roleBiz.getEntity(_manager.getManagerRoleID());
				website = (AppEntity) appBiz.getByManagerId(role.getRoleManagerId());
				// 判断当前登录管理员是否为该网站的系统管理员，如果是，如果不是则判断是否为超级管理员
				if (website != null && urlWebsite != null && urlWebsite.getAppId() == website.getAppId()
						&& _manager.getManagerRoleID() > Const.DEFAULT_SYSTEM_MANGER_ROLE_ID) {

					List<BaseEntity> childManagerList = managerBiz.queryAllChildManager(managerSession.getManagerId());
					managerSession.setBasicId(website.getAppId());
					managerSession.setManagerParentID(role.getRoleManagerId());
					managerSession.setManagerChildIDs(childManagerList);
					managerSession.setStyle(website.getAppStyle());
					// 压入管理员seesion
					setSession(request, SessionConst.MANAGER_ESSION, managerSession);
				} else {
					if (!(_manager.getManagerRoleID() == Const.DEFAULT_SYSTEM_MANGER_ROLE_ID)) {
						this.outJson(response, ModelCode.ADMIN_LOGIN, false, this.getResString("err"));
					} else {
						setSession(request, SessionConst.MANAGER_ESSION, managerSession);
					}
				}
				BeanUtils.copyProperties(_manager, managerSession);
				if (systemSkin != null) {
					managerSession.setSystemSkin(systemSkin);
				}

				Subject subject = SecurityUtils.getSubject();
				UsernamePasswordToken upt = new UsernamePasswordToken(managerSession.getManagerName(),
						managerSession.getManagerPassword());
				subject.login(upt);
				this.outJson(response, ModelCode.ADMIN_LOGIN, true, null);
			} else {
				// 密码错误
				this.outJson(response, ModelCode.ADMIN_LOGIN, false, this.getResString("err.password"));
			}
		}
	}

}