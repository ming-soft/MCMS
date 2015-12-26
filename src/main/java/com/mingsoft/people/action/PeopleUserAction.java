/**
 * 
 */
package com.mingsoft.people.action;

import java.util.Date;
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
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.people.biz.IPeopleBiz;
import com.mingsoft.people.biz.IPeopleUserBiz;
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.people.entity.PeopleUserEntity;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 
 * <p>
 * <b>铭飞科技-会员系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 *
 * @author 成卫雄
 *                QQ:330216230
 *
 * <p>
 * Comments: 普通用户信息
 * </p>
 *
 * <p>
 * Create Date:2014-10-31
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */

@Controller
@RequestMapping("/manager/people/user")
public class PeopleUserAction extends BaseAction{
	
	/**
	 * 注入普通用户控制层
	 */
	@Autowired
	private IPeopleUserBiz peopleUserBiz;
	
	/**
	 * 注入用户基础信息控制层
	 */
	@Autowired
	private IPeopleBiz peopleBiz;

	/**
	 * 用户列表
	 * @param mode
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap mode,HttpServletRequest request,HttpServletResponse response){
		//获取应用ID  
		int appId = this.getAppId(request);
		//查询用户总数
		int peopleCount = this.peopleBiz.queryCountByAppId(appId);
		int pageNo = this.getInt(request, "pageNo", 1);
		//页面链接地址
		String pageUrl = getUrl(request)+"/manager/people/user/list.do";
		//分页通用类
		PageUtil page=new PageUtil(pageNo,peopleCount,pageUrl);
		//获取用户列表
		List<PeopleEntity> listPeople = this.peopleBiz.queryPageListByAppId(appId,page);
		mode.addAttribute("listPeople", listPeople);
		mode.addAttribute("page", page);
		this.setCookie(request, response,CookieConst.BACK_COOKIE, pageUrl+"?pageNo="+pageNo);
		return "/manager/people/user/people_user_list";
	}
	
	/**
	 * 新增用户信息
	 * @return 新增用户页面
	 */
	@RequestMapping("/add")
	public String add(ModelMap mode,HttpServletRequest request){
		int appId = this.getAppId(request);
		mode.addAttribute("appId", appId);
		return "/manager/people/user/people_user";
	}
	
	
	
	/**
	 * 获取用户详细信息
	 * @param peopleId 用户ID
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getEntity")
	public void getEntity(String peopleId,HttpServletRequest request,HttpServletResponse response){
		if(StringUtil.isBlank(peopleId) || !StringUtil.isInteger(peopleId)){
			this.outJson(response, ModelCode.PEOPLE_USER,false);
			return ;
		}
		PeopleUserEntity peopleUser = (PeopleUserEntity) this.peopleUserBiz.getEntity(Integer.parseInt(peopleId));
		if(peopleUser == null){
			this.outJson(response, ModelCode.PEOPLE_USER,false);
			return ;
		}
		this.outJson(response, ModelCode.PEOPLE_USER,true,null,JSONObject.toJSONString(peopleUser));
	}
	

	/**
	 * 用户更新详细信息
	 * @param peopleUser 用户信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute PeopleUserEntity peopleUser,HttpServletRequest request,HttpServletResponse response){
		//判断用户信息是否存在
		if(peopleUser == null){
			//未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER,false,this.getResString("people.user.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		//获取用户实体
		PeopleEntity people =(PeopleEntity) peopleBiz.getEntity(peopleUser.getPeopleId());
		peopleUser.setPeopleId(peopleUser.getPeopleId());
		//验证用户信息,如果验证不通过则不进行更新或保存操作
		if(!this.checkUpdatePeople(peopleUser, request, response)){
			return;
		}
		//判断peopleUser是否存在是否存在
		PeopleUserEntity oldPeopleUser = (PeopleUserEntity) peopleUserBiz.getEntity(people.getPeopleId());
		// 获取cookie
		String cookieUrl =this.getCookie(request, CookieConst.BACK_COOKIE);
		//如果不存在则进行保存操作
		if(oldPeopleUser!=null && oldPeopleUser.getPeopleUserPeopleId()==0){
			this.peopleUserBiz.saveEntity(peopleUser);
			this.outJson(response, ModelCode.PEOPLE_USER,true,cookieUrl);
			return;
		}
		//判断用户密码是否为空，如果不为空则进行密码的更新
		if(!StringUtil.isBlank(StringUtil.Md5(peopleUser.getPeoplePassword()))){
			//设置用户密码
			peopleUser.setPeoplePassword(StringUtil.Md5(peopleUser.getPeoplePassword()));
		}
		//存在则进行更新操作
		this.peopleUserBiz.updatePeopleUser(peopleUser);;
		//返回更新成功
		this.outJson(response, ModelCode.PEOPLE_USER,true,cookieUrl);
	}
	
	
	
	
	
	
	/**
	 * 批量删除用户信息
	 * @param request 
	 * @param response
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public void delete(HttpServletRequest request, HttpServletResponse response){
		//获取要删除的用户id集合
		String [] ids = request.getParameterValues("ids");
		// 获取cookie
		String cookieUrl =this.getCookie(request, CookieConst.BACK_COOKIE);
		//如果用户id不为空且传入的用户集合是数字集合
		if(!StringUtil.isBlank(ids) && StringUtil.isIntegers(ids)){
			int[] _ids = StringUtil.stringsToInts(ids);
			//批量删除用户信息
			this.peopleUserBiz.deletePeopleUsers(_ids);
		}
		this.outJson(response, ModelCode.PEOPLE_USER, true,cookieUrl);
	}
	
	/**
	 * 新增用户信息
	 * @return 新增用户页面
	 */
	@RequestMapping("/{peopleId}/edit")
	public String edit(@PathVariable int peopleId,ModelMap mode,HttpServletRequest request,HttpServletResponse response){
		PeopleUserEntity peopleUser = (PeopleUserEntity) this.peopleUserBiz.getEntity(peopleId);
		int appId = this.getAppId(request);
		mode.addAttribute("appId", appId);
		mode.addAttribute("peopleUser", peopleUser);
		return "/manager/people/user/people_user";
	}
	
	/**
	 * 保存用户信息
	 * @param peopleUser 用户信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/save")
	@ResponseBody
	public void save(@ModelAttribute PeopleUserEntity peopleUser,HttpServletRequest request,HttpServletResponse response){
		//判断用户信息是否存在
		if(peopleUser == null){
			//未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER,false,this.getResString("people.user.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		//验证用户输入的信息是否合法
		if(!this.checkPeople(peopleUser, request, response)){
			return;
		}
		//判断用户密码是否为空，如果不为空则进行密码的保存
		if(!StringUtil.isBlank(StringUtil.Md5(peopleUser.getPeoplePassword()))){
			//设置用户密码
			peopleUser.setPeoplePassword(StringUtil.Md5(peopleUser.getPeoplePassword()));
		}
		
		peopleUser.setPeopleAppId(this.getAppId(request));
		peopleUser.setPeopleDateTime(new Date());
		//保存用户信息
		this.peopleUserBiz.savePeople(peopleUser);
		// 获取cookie
		String cookieUrl =this.getCookie(request, CookieConst.BACK_COOKIE);
		//返回更新成功
		this.outJson(response, ModelCode.PEOPLE_USER,true,cookieUrl);
	}
	
	/**
	 * 验证更新用户信息是判断用户输入的信息是否合法
	 * @param peopleUser  用户实体
	 * @param request http请求对象
	 * @param response http响应对象
	 */
	public boolean checkUpdatePeople(PeopleUserEntity peopleUser,HttpServletRequest request,HttpServletResponse response){
		
		//获取更改前的用户
		PeopleUserEntity oldPeopleUser = (PeopleUserEntity) peopleUserBiz.getEntity(peopleUser.getPeopleId());
		//获取应用id
		int appId = this.getAppId(request);
		//如果填写了邮箱，则验证邮箱格式是否正确
		if (!StringUtil.isBlank(peopleUser.getPeopleMail()) && !StringUtil.isEmail(peopleUser.getPeopleMail())) {
			this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.msg.mail.format.error", com.mingsoft.people.constant.Const.RESOURCES));
			return false;
		}
		//验证用户名不能为空
		if(StringUtil.isBlank(peopleUser.getPeopleName())){
			this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.msg.name.error", com.mingsoft.people.constant.Const.RESOURCES));
			return false;
		}
		
		//如果填写了手机号码，则验证手机号码填写是否正确
		if (!StringUtil.isBlank(peopleUser.getPeoplePhone()) && !StringUtil.isMobile(peopleUser.getPeoplePhone())) {
			this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.msg.phone.format.error", com.mingsoft.people.constant.Const.RESOURCES));
			return false;
		}
		
		
		//当用户名进行修改时验证用户名是否是唯一的
		if (!StringUtil.isBlank(peopleUser.getPeopleName())) {
			// 验证手机号是否唯一
			PeopleEntity peoplePhone = this.peopleBiz.getEntityByUserName(peopleUser.getPeopleName(), appId);
			//判断之前是否已经存在用户名，如果不存在，则判断是否存在重名，如果存在,判断用户是否更改用户名如果更改则判断新更改的用户名是否已经存在
			//判断填写的用户名和之前用户名是否相同，如果不相同
			if(StringUtil.isBlank(oldPeopleUser.getPeopleName())){
				if (peoplePhone != null) {
					this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
					return false;
				}
			}else{
				if(!oldPeopleUser.getPeopleName().equals(peopleUser.getPeopleName())){
					if (peoplePhone != null) {
						this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
						return false;
					}
				}
			}
			
		}
		if(!StringUtil.isBlank(peopleUser.getPeoplePhone())){
			PeopleEntity peoplePhone = this.peopleBiz.getEntityByUserName(peopleUser.getPeoplePhone(), appId);
			//判断之前是否已经存在手机号，如果不存在，则判断是否存在重名，如果存在,判断用户是否更改手机号如果更改则判断新更改的手机号是否已经存在
			//判断填写的手机号和之前手机号是否相同，如果不相同
			if(StringUtil.isBlank(oldPeopleUser.getPeoplePhone())){
				if (peoplePhone != null) {
					this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
					return false;
				}
			}else{
				if(!oldPeopleUser.getPeoplePhone().equals(peopleUser.getPeoplePhone())){
					if (peoplePhone != null) {
						this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
						return false;
					}
				}
			}
		}
		//验证邮箱的唯一性
		if(!StringUtil.isBlank(peopleUser.getPeopleMail())){
			PeopleEntity peoplePhone = this.peopleBiz.getEntityByUserName(peopleUser.getPeopleMail(), appId);
			//判断之前是否已经存在手机号，如果不存在，则判断是否存在重名，如果存在,判断用户是否更改手机号如果更改则判断新更改的手机号是否已经存在
			//判断填写的手机号和之前手机号是否相同，如果不相同
			if(StringUtil.isBlank(oldPeopleUser.getPeopleMail())){
				if (peoplePhone != null) {
					this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
					return false;
				}
			}else{
				if(!oldPeopleUser.getPeopleMail().equals(peopleUser.getPeopleMail())){
					if (peoplePhone != null) {
						this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
						return false;
					}
				}
			}
		}
		//验证用户身份证号码
		return true;
	}
	
	/**
	 * 验证保存用户时输入的信息是否合法
	 * @param peopleUser  用户实体
	 * @param request http请求对象
	 * @param response http响应对象
	 */
	public boolean checkPeople(PeopleUserEntity peopleUser,HttpServletRequest request,HttpServletResponse response){
		//获取应用id
		int appId = this.getAppId(request);
		//如果填写了邮箱，则验证邮箱格式是否正确
		if (!StringUtil.isBlank(peopleUser.getPeopleMail()) && !StringUtil.isEmail(peopleUser.getPeopleMail())) {
			this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.msg.mail.format.error", com.mingsoft.people.constant.Const.RESOURCES));
			return false;
		}
		//验证用户名不能为空
		if(StringUtil.isBlank(peopleUser.getPeopleName())){
			this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.msg.name.error", com.mingsoft.people.constant.Const.RESOURCES));
			return false;
		}
		//如果填写了手机号码，则验证手机号码填写是否正确
		if (!StringUtil.isBlank(peopleUser.getPeoplePhone()) && !StringUtil.isMobile(peopleUser.getPeoplePhone())) {
			this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.msg.phone.format.error", com.mingsoft.people.constant.Const.RESOURCES));
			return false;
		}
		
		
		//验证用户名是否是唯一的
		if (!StringUtil.isBlank(peopleUser.getPeopleName())) {
			// 验证手机号是否唯一
			PeopleEntity peoplePhone = this.peopleBiz.getEntityByUserName(peopleUser.getPeopleName(), appId);
			if (peoplePhone != null) {
				this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return false;
			}
		}
		if (!StringUtil.isBlank(peopleUser.getPeoplePhone())) {
			// 验证手机号是否唯一
			PeopleEntity peoplePhone = this.peopleBiz.getEntityByUserName(peopleUser.getPeoplePhone(), appId);
			if (peoplePhone != null) {
				this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.phone.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return false;
			}
		}
		if (!StringUtil.isBlank(peopleUser.getPeopleMail())) {
			// 验证邮箱是否唯一
			PeopleEntity peopleMail = this.peopleBiz.getEntityByUserName(peopleUser.getPeopleMail(), appId);
			if (peopleMail != null) {
				this.outJson(response, ModelCode.PEOPLE_USER, false, this.getResString("people.register.msg.mail.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return false;
			}
		}
		
		return true;
	}
}
