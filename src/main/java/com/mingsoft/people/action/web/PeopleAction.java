/**
 * 
 */
package com.mingsoft.people.action.web;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.people.biz.IPeopleBiz;
import com.mingsoft.basic.constant.e.MailEnum;
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.people.action.BaseAction;
import com.mingsoft.people.constant.e.PeopleEnum;
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
 * @author 成卫雄 QQ:330216230
 * 
 *         <p>
 *         Comments:外部会员接口控制层
 *         </p>
 * 
 *         <p>
 *         Create Date:2014-10-31
 *         </p>
 * 
 *         <p>
 *         Modification history:
 *         </p>
 */
@Controller("webPeople")
@RequestMapping("/")
public class PeopleAction extends BaseAction {

	/**
	 * 注入用户基础业务层
	 */
	@Autowired
	private IPeopleBiz peopleBiz;
	
	/**
	 * 用户注册
	 * 
	 * @param people
	 *            用户信息
	 * @param type
	 *            注册类型:</br> 1:根据用户名注册</br> 2:根据手机号注册</br> 3:根据邮箱注册</br>
	 * @seee PeopleEnum
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{type}/register")
	public void register(@ModelAttribute PeopleEntity people, @PathVariable int type, HttpServletRequest request, HttpServletResponse response) {

		// 判断注册类型是否正确
		if (type < PeopleEnum.REGISTER_NAME.toInt() || type > PeopleEnum.REGISTER_EMAIL.toInt()) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.type.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		// 验证码验证 验证码不为null 或 验证码不相等
		if (StringUtil.isBlank(this.getRandCode(request)) || !this.checkRandCode(request)) {
			this.outJson(response, null, false, this.getResString("err.error", this.getResString("rand.code")));
			return;
		}

		// 判断用户信息是否为空
		if (people == null) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.null.error"), this.getResString("people.msg.null.error"));
			return;
		}

		if (type == PeopleEnum.REGISTER_NAME.toInt()) {// 用户根据用户名注册
			// 验证用户名
			if (StringUtil.isBlank(people.getPeopleName()) || people.getPeopleName().length() < 3 || people.getPeopleName().length() > 12) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.name.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}

		} else if (type == PeopleEnum.REGISTER_PHONE.toInt()) {// 用户根据手机号注册
			// 验证手机号
			if (StringUtil.isBlank(people.getPeoplePhone()) || !StringUtil.isMobile(people.getPeoplePhone())) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.phone.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}

		} else if (type == PeopleEnum.REGISTER_EMAIL.toInt()) {// 用户根据邮箱注册
			// 验证邮箱
			if (StringUtil.isBlank(people.getPeopleMail()) || !StringUtil.isEmail(people.getPeopleMail())) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.mail.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}

		// 获取应用ID
		int appId = this.getAppId(request);

		// 验证用户信息,用户可使用:用户名,邮箱,手机号登录则必须保证这三个值在数据库中的唯一性
		if (!StringUtil.isBlank(people.getPeopleName())) {// 验证用户名
			PeopleEntity peopleName = this.peopleBiz.getEntityByUserName(people.getPeopleName(), appId);
			if (peopleName != null) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}
		if (!StringUtil.isBlank(people.getPeoplePhone())) {// 验证手机号
			PeopleEntity peoplePhone = this.peopleBiz.getEntityByUserName(people.getPeoplePhone(), appId);
			if (peoplePhone != null) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.phone.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}
		if (!StringUtil.isBlank(people.getPeopleMail())) {// 验证邮箱
			PeopleEntity peopleMail = this.peopleBiz.getEntityByUserName(people.getPeopleMail(), appId);
			if (peopleMail != null) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.mail.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}

		// 验证密码
		if (StringUtil.isBlank(people.getPeoplePassword()) || people.getPeoplePassword().length() < 6 || people.getPeoplePassword().length() > 30) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.password.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		// 将密码使用MD5加密
		people.setPeoplePassword(StringUtil.Md5(people.getPeoplePassword()));
		people.setPeopleAppId(appId);
		people.setPeopleDateTime(new Date());
		this.peopleBiz.saveEntity(people);
		this.outJson(response, ModelCode.PEOPLE_REGISTER, true, this.getResString("people.register.msg.success", com.mingsoft.people.constant.Const.RESOURCES));
	}

	/**
	 * 功能：通过用户注册类型，验证用户名是否可用
	 * 
	 * @param userName
	 *            用户名(可为:用户名称,手机,邮箱)
	 * 
	 * @param type
	 *            注册类型:</br> 1:根据用户名注册</br> 2:根据手机号注册</br> 3:根据邮箱注册</br>
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{type}/checkPeopleName")
	public void checkPeopleName(String userName, @PathVariable int type, HttpServletRequest request, HttpServletResponse response) {
		
		// 判断注册类型是否正确
		if (type < PeopleEnum.REGISTER_NAME.toInt() || type > PeopleEnum.REGISTER_EMAIL.toInt()) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.type.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		if (type == PeopleEnum.REGISTER_NAME.toInt()) {// 用户根据用户名注册
			// 验证用户名
			if (StringUtil.isBlank(userName) || userName.length() < 3 || userName.length() > 12) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.name.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}

		} else if (type == PeopleEnum.REGISTER_PHONE.toInt()) {// 用户根据手机号注册
			// 验证手机号
			if (StringUtil.isBlank(userName) || !StringUtil.isMobile(userName)) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.phone.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}

		} else if (type == PeopleEnum.REGISTER_EMAIL.toInt()) {// 用户根据邮箱注册
			// 验证邮箱
			if (StringUtil.isBlank(userName) || !StringUtil.isEmail(userName)) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.mail.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}

		// 获取应用ID
		int appId = this.getAppId(request);

		// 验证用户信息,用户可使用:用户名,邮箱,手机号登录则必须保证这三个值在数据库中的唯一性
		if (!StringUtil.isBlank(userName)) {// 验证用户名
			PeopleEntity peopleName = this.peopleBiz.getEntityByUserName(userName, appId);
			if (peopleName != null) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.name.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}
		if (!StringUtil.isBlank(userName)) {// 验证手机号
			PeopleEntity peoplePhone = this.peopleBiz.getEntityByUserName(userName, appId);
			if (peoplePhone != null) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.phone.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}
		if (!StringUtil.isBlank(userName)) {// 验证邮箱
			PeopleEntity peopleMail = this.peopleBiz.getEntityByUserName(userName, appId);
			if (peopleMail != null) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.mail.repeat.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}
		this.outJson(response, ModelCode.PEOPLE_REGISTER, true);
	}

	/**
	 * 验证用户的登录信息
	 * 
	 * @param userName
	 *            用户名(可为:用户名称,手机,邮箱)
	 * @param passWord
	 *            密码
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/checkLogin")
	public void checkLogin(HttpServletRequest request, HttpServletResponse response) {
		// 获取用户名
		String userName = request.getParameter("userName");
		// 获取密码
		String passWord = request.getParameter("passWord");
		// 获取是否自动登录
		String autoLogin = request.getParameter("autoLogin");
		//判断登录时是否要进行图片验证码的验证，true表示需要
		String isImgCode = request.getParameter("isImgCode");
				
		if(!StringUtil.isBlank(isImgCode) && isImgCode.equals("true")){
				// 验证码验证 验证码不为null 或 验证码不相等
			if (StringUtil.isBlank(this.getRandCode(request)) || !this.checkRandCode(request)) {
				this.outJson(response, null, false, this.getResString("err.error", this.getResString("rand.code")));
				return;
			}
		}
		// 用户名和密码不能为空
		if (StringUtil.isBlank(userName) || StringUtil.isBlank(passWord)) {
			this.outJson(response, ModelCode.PEOPLE_LOGIN, false, this.getResString("people.msg.null.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		// 根据应用ID和用户名查询用户密码
		int appId = this.getAppId(request);
		PeopleEntity peopleEntity = this.peopleBiz.getEntityByUserName(userName, appId);
		if (peopleEntity == null) {
			// 用户名或密码错误
			this.outJson(response, ModelCode.PEOPLE_LOGIN, false, this.getResString("people.msg.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
		
		// 将用户输入的密码用MD5加密再和数据库中的进行比对
		String peoplePassWord = StringUtil.Md5(passWord);
		if (peoplePassWord.equals(peopleEntity.getPeoplePassword())) {
			// 登录成功,压入用户session
			this.setSession(request, SessionConst.PEOPLE_SESSION, peopleEntity);
			// 构建返回给页面的json
			Map<String, String> mapJson = new HashMap<String, String>();	 
			 
			//判断用户是否点击了自动登录
			if (autoLogin != null) {
				mapJson.put("peoplePassWord", peoplePassWord);
				mapJson.put("autoLoginInCookies", autoLogin);
			}
			mapJson.put("userName", StringUtil.encodeStringByUTF8(peopleEntity.getPeopleName()));
			mapJson.put("phone", peopleEntity.getPeoplePhone());
			mapJson.put("mail", peopleEntity.getPeopleMail());
			//将用户审核状态压入
			mapJson.put("peopleState", peopleEntity.getPeopleState()+"");
			// 将用户信息压入到cookie中
			
			this.setCookie(request, response, CookieConst.PEOPLE_COOKIE, JSONObject.toJSONString(mapJson),60*60*24*7);
			this.outJson(response, ModelCode.PEOPLE_LOGIN, true, JSONObject.toJSONString(mapJson));

		} else {
			// 用户名或密码错误
			this.outJson(response, ModelCode.PEOPLE_LOGIN, false, this.getResString("people.msg.error", com.mingsoft.people.constant.Const.RESOURCES));
		}
		
		
	}

	/**
	 * 退出登录
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/quit")
	public void quit(HttpServletRequest request, HttpServletResponse response) {
		// 移除当前用户session
		this.removeSession(request, SessionConst.PEOPLE_SESSION);
		this.setCookie(request, response, CookieConst.PEOPLE_COOKIE, null);
		this.outJson(response, ModelCode.PEOPLE, true, this.getResString("people.quit.msg.success", com.mingsoft.people.constant.Const.RESOURCES));
	}

	/**
	 * 用户通过手机找回密码时，修改密码
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/setPasswordByPhone")
	@ResponseBody
	public void setPasswordByPhone(HttpServletRequest request, HttpServletResponse response) {
		// 手机
		String peoplePhone = request.getParameter("peoplePhone");
		// 新密码
		String passWord = request.getParameter("password");
	
		// 根据邮箱获取用户实体
		int appId = this.getAppId(request);
		PeopleEntity people = this.peopleBiz.getEntityByUserName(peoplePhone, appId);
		// 验证新密码的长度
		if (passWord.length() < 6 || passWord.length() > 30) {
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.password.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
	
		// 将新密码用MD5加密
		passWord = StringUtil.Md5(passWord);
		// 判断用户名不为null
		if (people != null) {
			// 判断用户验证是否通过
			if (people.getPeoplePhoneCheck() != PeopleEnum.PHONE_CHECK.toInt()) {
				// 用户验证未通过
				this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.reset.msg.name.phone.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
	
			// 设置用户新密码
			people.setPeoplePassword(passWord);
			peopleBiz.updateEntity(people);
			this.outJson(response, ModelCode.PEOPLE, true, this.getResString("people.change.password.msg.success", com.mingsoft.people.constant.Const.RESOURCES));
		} else {
			// 用户不存在
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("err.not.exist", this.getResString("people")));
			return;
		}
	}

	/**
	 * 通过邮箱设置新密码
	 * @param request
	 * @param response
	 */
	@RequestMapping("/setPasswordByMail")
	@ResponseBody
	public void setPasswordByMail(HttpServletRequest request, HttpServletResponse response) {
		// 邮箱
		String peopleMail = request.getParameter("peopleMail");
		// 新密码
		String passWord = request.getParameter("passWord");
	
		// 根据邮箱获取用户实体
		int appId = this.getAppId(request);
		PeopleEntity people = this.peopleBiz.getEntityByUserName(peopleMail, appId);
		// 验证新密码的长度
		if (passWord.length() < 6 || passWord.length() > 30) {
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.password.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
	
		// 将新密码用MD5加密
		passWord = StringUtil.Md5(passWord);
		// 判断用户名不为null
		if (people != null) {
			// 判断用户验证是否通过
			if (people.getPeopleMailCheck() != PeopleEnum.MAIL_CHECK.toInt()) {
				// 用户验证未通过
				this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.reset.msg.name.mail.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
	
			// 设置用户新密码
			people.setPeoplePassword(passWord);
			peopleBiz.updateEntity(people);
			this.outJson(response, ModelCode.PEOPLE, true, this.getResString("people.change.password.msg.success", com.mingsoft.people.constant.Const.RESOURCES));
		} else {
			// 用户不存在
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("err.not.exist", this.getResString("people")));
			return;
		}
	}
	
	/**
	 * 根据用户名和验证码判断是否存在用户实体，
	 * 可应用场景：用户忘记了密码，用户可以输入用户名称与验证码，进行下一步操作
	 * 流程：如果用户存在->取出用户的手机（邮箱）->发送验证->用户输入验证信息->正确->输入新密码->成功
	 *  @param peopleName 用户名
 	 *  @param request
	 * @param response
	 */
	@RequestMapping("/getPeopleByName")
	public void getPeopleByName(String peopleName,HttpServletRequest request, HttpServletResponse response) {
	
		// 应用id
		int appId = this.getAppId(request);
		// 验证用户输入的验证码是否正确
		String imgCode = request.getParameter("imgCode");
		if (StringUtil.isBlank(imgCode) || !imgCode.equalsIgnoreCase(this.getCodeBySession(request))) {
			this.outJson(response, null, false, this.getResString("err.error", getResString("peopleImageCode")));
			return;
		}
	
		// 验证用户名
		if (StringUtil.isBlank(peopleName) || peopleName.length() < 3 || peopleName.length() > 12) {
			this.outJson(response, null, false, this.getResString("people.msg.name.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
	
		// 根据帐号查找实体
		PeopleEntity people = this.peopleBiz.getEntityByUserName(peopleName, appId);
		if (people == null) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("err.not.exist", this.getResString("people")));
		} else {
			// 返回用户信息
			this.outJson(response, null, true, JSON.toJSONString(people));
		}
	}
	
	

	/**
	 * 发送取回密码的连接地址(已过时不能使用)
	 * 
	 * @param request
	 * @param peopleMail
	 *            用户接收邮箱地址
	 * @param url
	 *            取回密码的页面连接地址，
	 * @deprecated
	 */
	@RequestMapping("/sendGetPasswordUrl")
	public void sendGetPasswordUrl(HttpServletRequest request, HttpServletResponse response) {
		String peopleMail = request.getParameter("peopleMail");
		String url = request.getParameter("url");
		String imgCode = request.getParameter("imgCode");
		// 根据appId
		int appId = this.getAppId(request);
		// 验证用户输入的验证码是否正确
		
		if (StringUtil.isBlank(imgCode) && !imgCode.equalsIgnoreCase(this.getCodeBySession(request))) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("err.error", getResString("peopleImageCode")));
			return;
		}
		// 判断该邮箱是否注册过
		PeopleEntity people = peopleBiz.getEntityByUserName(peopleMail, appId);
		if (people == null) {
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("err.not.exist", this.getResString("people")));
			return;
		}

		// 1生成session 值，
		String code = StringUtil.getDateSimpleStr();
		this.setSession(request, SessionConst.PEOPLE_GET_PASSWORD_SESSION, code);
		String content = StringUtil.buildUrl(url, "code=" + code);
		this.sendMail(request, MailEnum.TEXT, this.getResString("people.get.password"), StringUtil.buildUrl(content, "mail=" + peopleMail), new String[] { peopleMail });
		this.outJson(response, ModelCode.PEOPLE, true);
	}

	/**
	 * 用户通过邮箱找回密码时，修改密码,与sendGetPasswordUrl配合使用(已过时不能使用)
	 * 
	 * @param request
	 * @param response
	 *  @deprecated
	 */
	@RequestMapping("/setPassword")
	@ResponseBody
	public void setPassword(HttpServletRequest request, HttpServletResponse response) {
		// 邮箱
		String peopleMail = request.getParameter("peopleMail");
		String passWord = request.getParameter("passWord");
		// 验证码
		String code = request.getParameter("code");
		String errUrl = request.getParameter("errUrl"); // 错误返回地址
		Object scode = this.getSession(request, SessionConst.PEOPLE_GET_PASSWORD_SESSION);
		if (scode == null || !code.equals(scode.toString())) {
			this.outJson(response, ModelCode.PEOPLE, false, null, errUrl);
			return;
		}
		// 根据邮箱获取用户实体
		int appId = this.getAppId(request);
		PeopleEntity people = this.peopleBiz.getEntityByUserName(peopleMail, appId);
		// 验证新密码的长度
		if (passWord.length() < 6 || passWord.length() > 30) {
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.password.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
	
		// 将新密码用MD5加密
		passWord = StringUtil.Md5(passWord);
		if (people != null) {
			// 设置用户新密码
			people.setPeoplePassword(passWord);
			peopleBiz.updateEntity(people);
			this.outJson(response, ModelCode.PEOPLE, true, this.getResString("people.change.password.msg.success", com.mingsoft.people.constant.Const.RESOURCES));
		} else {
			// 用户不存在
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("err.not.exist", this.getResString("people")));
			return;
		}
	}


}
