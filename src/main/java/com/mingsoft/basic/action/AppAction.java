package com.mingsoft.basic.action;

import java.io.File;
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
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 网站基本信息控制层
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-07-14<br/>
 * 历史修订：<br/>
 */
@Controller
@RequestMapping("/manager/app/")
public class AppAction extends BaseAction{
	
	/**
	 * appBiz业务层的注入
	 */
	@Autowired
	private IAppBiz appBiz;
	
	/**
	 * managerBiz业务层的注入
	 */
	@Autowired
	private IManagerBiz managerBiz;
	
	
	
	/**
	 * 根据id删除站点信息
	 * @param basicId 要删除的站点Id
	 * @param request 请求对象
	 * @return 返回当前页数
	 */
	@RequestMapping("/{basicId}/delete")
	@ResponseBody
	public int delete(@PathVariable int basicId, HttpServletRequest request){
		AppEntity app = (AppEntity) appBiz.getEntity(basicId);
		/*
		 * 删除对应的站点管理员
		 */
		if(app!=null){
			int managerId = app.getAppManagerId();
			managerBiz.deleteEntity(managerId);
			appBiz.deleteBasic(basicId);
		}
		int pageNo = 2;
		//保存页面cookie值
		int cookie = Integer.valueOf(this.getCookie(request, CookieConst.PAGENO_COOKIE));
		if(cookie>=1){
			pageNo=cookie;
		}
		return pageNo;
	}
	
	/**
	 * 跳转到站点保存页面
	 * @param request 请求对象
	 * @param mode ModelMap实体对象
	 * @return 站点保存页面
	 */
	@RequestMapping("/add")
	public String add(HttpServletRequest request,ModelMap mode){
		//超级管理员识别
		mode.addAttribute("SystemManager",true);
		AppEntity app = new AppEntity();
		//传入一个空的app
		mode.addAttribute("app",app);
		return "/manager/app/app";
	}
	
	/**
	 * 跳转到修改页面
	 * @param mode ModelMap实体对象
	 * @param appId 站点id
	 * @param request 请求对象
	 * @return 站点修改页面
	 */
	@RequestMapping(value="/{appId}/edit")
	public String edit(ModelMap mode,@PathVariable int appId, HttpServletRequest request) {
		AppEntity app = null;
		if (appId<0) {
			app = this.getApp(request);
		} else {
			app = (AppEntity) appBiz.getEntity(appId);
		}

		//判断否是超级管理员,是的话不显示站点风格
		if(this.isSystemManager(request)){
			mode.addAttribute("SystemManager",true);
		}else{
			mode.addAttribute("SystemManager",false);
		}
		
		mode.addAttribute("app",app);
		return "/manager/app/app";
	}

	/**
	 * 更新站点信息
	 * @param mode ModelMap实体对象
	 * @param app	站点对象
	 * @param request 请求对象
	 * @param response 相应对象
	 */
	@RequestMapping("/update")
	public void update(ModelMap mode,@ModelAttribute AppEntity app, HttpServletRequest request, HttpServletResponse response){
		mode.clear();
		// 获取Session值
		ManagerEntity managerSession = (ManagerEntity) getManagerBySession(request);
		if(managerSession==null){
			return ;
		}
		mode.addAttribute("managerSession",managerSession);
		
		//判断否是超级管理员,不是则不修改应用续费时间和清单
		if(!this.isSystemManager(request)){
			app.setAppPayDate(null);
			app.setAppPay(null);
			// 设置当前的站点id
			app.setAppId(this.getAppId(request));
		}
		int managerRoleID = managerSession.getManagerRoleID();
		//判断站点数据的合法性
		// 获取cookie
		String cookie =this.getCookie(request, CookieConst.PAGENO_COOKIE);
		int pageNo = 1;
		//判断cookies是否为空
		if(!StringUtil.isBlank(cookie) && Integer.valueOf(cookie)>0){
			pageNo=Integer.valueOf(cookie);
		}
		mode.addAttribute("pageNo", pageNo);
		if(!checkForm(app,response)){
			return;
		}
		if(!StringUtil.isBlank(app.getAppLogo())) {
			app.setAppLogo( app.getAppLogo().replace("|", ""));
		}
		//更新站点信息
		appBiz.updateEntity(app);
		this.outJson(response, ModelCode.APP, true, String.valueOf(pageNo), String.valueOf(managerRoleID));
	}
	
	/**
	 * 保存站点信息
	 * @param app 站点实体对象
	 * @param request 请求对象
	 * @param response 相应对象
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute AppEntity app, HttpServletRequest request, HttpServletResponse response){
		//验证站点数据的合法性
		if(!checkForm(app,response)){
			return;
		}
		//问题:由于上传的图片路径后面可能带有｜符合。所以要进行将“｜”替换空
		//空值判断
		if(!StringUtil.isBlank(app.getAppLogo())) {
			app.setAppLogo( app.getAppLogo().replace("|", ""));
		}
		//问题:去掉域名后面的"/"
		String appUrl = app.getAppHostUrl();
		app.setAppUrl(appUrl);
		appBiz.saveEntity(app);
		if(isSystemManager(request)) {
			String file = this.getRealPath(request,IParserRegexConstant.REGEX_SAVE_TEMPLATE+File.separator+ app.getAppId());
			File fileName = new File(file);
	        fileName.mkdir();
		}
		this.outJson(response, ModelCode.APP, true,null);
	}
	
	/**
	 * 判断站点域名的合法性
	 * @param app 要验证的站点信息
	 * @param response response对象
	 */
	public boolean checkForm(AppEntity app, HttpServletResponse response){
		
		/*
		 * 判断数据的合法性
		 */
		if(!StringUtil.checkLength(app.getAppKeyword(), 0,1000)){
			this.outJson(response, ModelCode.APP, false,getResString("err.length",this.getResString("appKeyword"),"0","1000"));
			return false;
		}
		if(!StringUtil.checkLength(app.getAppCopyright(), 0,1000)){
			this.outJson(response, ModelCode.APP, false,getResString("err.length",this.getResString("appCopyright"),"0","1000"));
			return false;
		}
		if(!StringUtil.checkLength(app.getAppDescription(), 0,1000)){
			this.outJson(response, ModelCode.APP, false,getResString("err.length",this.getResString("appDescrip"),"0","1000"));
			return false;
		}
		if(!StringUtil.checkLength(app.getAppName(),1,50)){
			this.outJson(response, ModelCode.APP, false,getResString("err.length",this.getResString("appTitle"),"1","50"));
			return false;
		}
		if(!StringUtil.isBlank(app.getAppStyle()) && !StringUtil.checkLength(app.getAppStyle(),1,30)){
			this.outJson(response, ModelCode.APP, false,getResString("err.length",this.getResString("appStyle"),"1","30"));
			return false;
		}
		if(!StringUtil.checkLength(app.getAppHostUrl(),10,150)){
			this.outJson(response, ModelCode.APP, false,getResString("err.length",this.getResString("appUrl"),"10","150"));
			return false;
		}
		return true;
	}
	
	/**
	 * 判断是否有重复的域名
	 * @param request 请求对象
	 * @return true:重复,false:不重复
	 */
	@RequestMapping("/checkUrl")
	@ResponseBody
	public boolean checkUrl(HttpServletRequest request){
		if(request.getParameter("appUrl")!=null){
			if(appBiz.countByUrl(request.getParameter("appUrl"))>0){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
		
	}
}
