package com.mingsoft.people.action.people;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.cms.parser.CmsParser;
import com.mingsoft.people.action.BaseAction;
import com.mingsoft.people.biz.IPeopleBiz;
import com.mingsoft.people.constant.e.PeopleEnum;
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.util.DateUtil;
import com.mingsoft.util.StringUtil;

/**
 * 
 * 后台会员控制层
 * @author 王天培(qq:78750478)
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-11-10<br/>
 * 历史修订：<br/>
 */
@Controller("webPeopleMain")
@RequestMapping("/people")
public class PeopleAction extends BaseAction{
	/**
	 * 注入用户基础业务层
	 */
	@Autowired
	private IPeopleBiz peopleBiz;

	/**
	 * 便于页面随机与时间控制
	 */
	private String date = "{date/}"; 
	
	/**
	 * 用户编号
	 */
	private static final String PEOPLEID = "{peopleId/}";
	private static final String HOST = "{host/}";
	
	/**
	 *文章解析器
	 */
	@Autowired
	private CmsParser cmsParser;
	/**
	 * 前段会员中心所有页面都可以使用该方法
	 * 支持参数传递与解析，例如页面中有参数id=10 传递过来，调整页面可以使用{id/}获取该参数
	 * 请求地址例如：　／people/info.do;people/password.do
	 * @param key
	 */
	@RequestMapping("/{key}")
	public void model(@PathVariable(value="key")String key,HttpServletRequest req,HttpServletResponse resp) {
		String content=  this.generaterPage("people/"+key, cmsParser,req);
		//增加时间
		content =  content.replace(date, StringUtil.getDateSimpleStr());
		try {
			if(this.getPeopleBySession(req)!=null){
				content =  content.replace(PEOPLEID,this.getPeopleBySession(req).getPeopleId()+"");
			}
			
		} catch(NullPointerException e) {
			LOG.error("user is not login", e);
		}
		content =  content.replace(HOST, this.getApp(req).getAppHostUrl());
		this.outString(resp, content);
	}
	
	
	
//	/**
//	 * 获取手机验证码
//	 * @param request
//	 * @param response
//	 */
//	@RequestMapping("/getPhoneCode")
//	public void getPhoneCode(HttpServletRequest request, HttpServletResponse response){
//		// 获取appID
//		int appId = this.getAppId(request);
//		//获取用户session
//	    PeopleEntity people =this.getPeopleBySession(request);
//	    //如果用户还没有登录
//		if(people==null){
//				this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
//				return;
//		}
//		//获取手机6位验证码
//		String peopelCode = StringUtil.randomNumber(6);
//		people.setPeopleCode(peopelCode);
//		people.setPeoplePhoneCheck(PeopleEnum.PHONE_NO_CHECK);
//		peopleBiz.updateEntity(people);
//		//给手机发送验证码
//		smsBiz.sendSms(appId,SmsModelEnum.PHONE_BIND, people.getPeoplePhone(), peopelCode);
//		this.outJson(response, ModelCode.PEOPLE,true);
//	}
	
	
	/**
	 * 发送邮箱验证码
	 * @param request
	 * @param response
	 * @param peopleMail  用户的邮箱号
	 * @param modelCode 模块编码（加密）
	 */
	@RequestMapping("/sendMailCode")
	public void sendMailCode(String peopleMail,String modelCode,HttpServletRequest request,HttpServletResponse response){
		//后台验证传来的用户邮箱地址是否合法
		if(!StringUtil.isEmail(peopleMail)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.msg.mail.error"));
			return;
		}
		if(StringUtil.isBlank(modelCode)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.dataType"));
			return;
		}
		//获取session中的用户实体
		PeopleEntity entity = this.getPeopleBySession(request) ;
		if(entity==null){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.session.msg.null.error"));
			return;
		}
		//获取站点id
		int appId = this.getAppId(request);
		
		//根据邮箱获取用户实体
		PeopleEntity people = this.peopleBiz.getEntityByUserName(peopleMail, appId);
		if(people==null){
			//获取验证码
			String peopleCode= StringUtil.randomNumber(6);
			// 将生成的验证码加入用户实体
			entity.setPeopleCode(peopleCode);

			//将当前时间转换为时间戳格式保存进people表
			entity.setPeopleCodeSendDate(DateUtil.dateToTimestamp(new Date()));
			//更新该实体
			this.peopleBiz.updateEntity(entity);
			//解密
			String _modelCode = this.decryptByAES(request, modelCode); 
			//发送邮箱
			this.sendMailCode(peopleMail, _modelCode, request, response);
			
			this.outJson(response, ModelCode.PEOPLE,true);
		}else{
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.register.msg.mail.repeat.error"));
		}
	}
	
	
	
	/**
	 * 验证用户填写的验证码是否和邮箱发送的验证码相同
	 * @param peopleMail 用户的邮箱地址
	 * @param mailCode 页面上用户所填写的邮箱验证码
	 * @param request
	 * @param response
	 */
	@RequestMapping("/checkMailCode")
	public void checkMailCode(String peopleMail, String mailCode,HttpServletRequest request,HttpServletResponse response){
		
		//后台验证传来的用户邮箱地址是否合法
		if(!StringUtil.isEmail(peopleMail)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.msg.mail.error"));
			return;
		}
		if(StringUtil.isBlank(mailCode)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.empty",this.getResString("peopleCode")));
			return;
		}
		//获取session中的用户实体
		PeopleEntity entity = this.getPeopleBySession(request) ;
		if(entity==null){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.session.msg.null.error"));
			return;
		}
		
		//得到发送验证码时间，并转换为String类型
		String date = entity.getPeopleCodeSendDate().toString();
		//如果发送时间和当前时间只差大于30分钟，则返回false
		if(DateUtil.secondBetween(date)>60*30){
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.code.error"));
			return;
		}
		
		if(entity.getPeopleCode().equals(mailCode)){
			
			entity.setPeopleMail(peopleMail);
			//清空随机码
			entity.setPeopleCode("");
			entity.setPeopleMailCheck(PeopleEnum.MAIL_CHECK);
			this.peopleBiz.updateEntity(entity);
			this.outJson(response,ModelCode.PEOPLE,true);
		}else{
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.error",this.getResString("peopleCode")));
		}
	}
	
	
	/**
	 * 绑定手机时判断用户手机是否存在且验证码输入正确
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getPeopleByCode")
	public void getPeopleByCode(HttpServletRequest request, HttpServletResponse response) {
		//获取用户session并判断
	    PeopleEntity peopleEntity =this.getPeopleBySession(request);
	    //如果用户还没有登录
 		if(peopleEntity==null){
 				this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
 				return;
 		}
		//获得用户填写的验证码
		String peopleCode = request.getParameter("peopleCode");
		if(StringUtil.isBlank(peopleCode)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.error",this.getResString("peopleCode")));
			return;
		}
		//获取用户填写的手机号
		String peoplePhone = request.getParameter("peoplePhone");
		if(!StringUtil.isMobile(peoplePhone)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.error",this.getResString("orderPhone")));
			return;
		}
		int appId = this.getAppId(request);
		PeopleEntity people = this.peopleBiz.getEntityByUserName(peoplePhone, appId);

		//判断用户输入的随机码是否正确
		if(!people.getPeopleCode().equals(peopleCode)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.error",this.getResString("peopleCode")));
			return;
		}
		this.outJson(response, ModelCode.PEOPLE, true);
	}
	
	
	/**
	 * 更改密码
	 * @param request
	 * @param response
	 */
	@RequestMapping("/changePassWord")
	public void changePassword(  HttpServletRequest request, HttpServletResponse response) {
		String passWord = request.getParameter("passWord");
		String newPassWord = request.getParameter("newPassWord");
		if (StringUtil.isBlank(passWord) || StringUtil.isBlank(newPassWord)) {
			// 用户或密码不能为空
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
 
		// 验证新密码的长度
		if (newPassWord.length() < 6 || newPassWord.length() > 30) {
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.password.error",com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		//获取用户session
		PeopleEntity people =this.getPeopleBySession(request);
		if (people == null) {
			// 用户名或密码错误
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
		// 将用户输入的原始密码用MD5加密再和数据库中的进行比对
		String peoplePassWord = StringUtil.Md5(passWord);
		if (people.getPeoplePassword().equals(peoplePassWord)) {// 验证通过执行修改
			// 将新密码用MD5加密
			newPassWord = StringUtil.Md5(newPassWord);
			// 执行修改
			people.setPeoplePassword(newPassWord);
			this.peopleBiz.updateEntity(people);
			this.outJson(response, ModelCode.PEOPLE, true, this.getResString("people.change.password.msg.success",com.mingsoft.people.constant.Const.RESOURCES));
		} else {
			// 提示当前密码输入错误
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.current.password.error",com.mingsoft.people.constant.Const.RESOURCES));
		}
	}
	
	/**
	 * 通过用户输入的验证码和手机号码判断是否绑定当前输入手机号
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/validatePhoneByCode")
	public void validatePhoneByCode(HttpServletRequest request, HttpServletResponse response) {
		//获得用户填写的验证码
		String peopleCode = request.getParameter("peopleCode");
		if(StringUtil.isBlank(peopleCode)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.error",this.getResString("peopleCode")));
			return;
		}
		//获取用户填写的手机号
		String peoplePhone = request.getParameter("peoplePhone");
		if(!StringUtil.isMobile(peoplePhone)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.error",this.getResString("orderPhone")));
			return;
		}
		//获取用户session并判断
	    PeopleEntity peopleEntity =this.getPeopleBySession(request);
	    //如果用户还没有登录
 		if(peopleEntity==null){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return;
 		}
		int appId = this.getAppId(request);
		PeopleEntity people = this.peopleBiz.getEntityByUserName(peoplePhone, appId);
		//判断手机号是否被绑定过，如果绑定过，弹出报错返回
		if (people != null) {
			this.outJson(response, ModelCode.PEOPLE, false,this.getResString("err.exist",this.getResString("people")));
			return;
		} 
		
		//得到发送验证码时间，并转换为String类型
		String date = peopleEntity.getPeopleCodeSendDate().toString();
		//如果发送时间和当前时间只差大于30分钟，则返回false
		if(DateUtil.secondBetween(date)>60*30){
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.code.error"));
			return;
		}

		//判断用户输入的随机码是否正确
		if(!peopleEntity.getPeopleCode().equals(peopleCode)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.error",this.getResString("peopleCode")));
			return;
		}
		//手机验证通过
		peopleEntity.setPeoplePhoneCheck(PeopleEnum.PHONE_CHECK);
		peopleEntity.setPeoplePhone(peoplePhone);
		//将随机码在数据库中清空
		peopleEntity.setPeopleCode("");
		peopleBiz.updateEntity(peopleEntity);
		this.outJson(response, ModelCode.PEOPLE, true);
	}
	
	
	/**
	 * 添加手机号码
	 * @param request
	 * @param response
	 */
	@RequestMapping("/changePhone")
	public void changePhone(HttpServletRequest request,HttpServletResponse response){
		String newPhone = request.getParameter("newPhone");
		String peopleCode = request.getParameter("peopleCode");
		//验证原始帐号密码
		int appId = this.getAppId(request);
		//获取用户session
		PeopleEntity people =this.getPeopleBySession(request);
		//如果用户还没有登录
		if(people==null){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
		//验证用户输入的验证码是否正确
		String imgCode = request.getParameter("imgCode");
		if(!imgCode.equalsIgnoreCase(this.getCodeBySession(request))){
			this.outJson(response, ModelCode.PEOPLE_REGISTER,false,this.getResString("err.error",getResString("peopleImageCode")));
			return;
		}
		//判断手机是否已经存在
		if(!StringUtil.isBlank(people.getPeoplePhone()) && !people.getPeoplePhone().equals(newPhone)){
			//根据手机号码查找实体
			PeopleEntity newPeople = this.peopleBiz.getEntityByUserName(newPhone,appId);
			if(newPeople != null){
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.register.msg.phone.repeat.error",com.mingsoft.people.constant.Const.RESOURCES));
				return ;
			}	
		}
		//判断用户输入的验证是否正确
		if(!people.getPeopleCode().equals(peopleCode)){
			//返回错误信息
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false,this.getResString("err.error", this.getResString("peopleCode")));
			return ;
		}
		people.setPeoplePhone(newPhone);
		peopleBiz.updateEntity(people);
		this.outJson(response, ModelCode.PEOPLE,true);
	}
	
	
	/**
	 * 通过session中的用户名得到用户实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getPeopleEntity")
	public void getPeopleEntity(HttpServletRequest request,HttpServletResponse response){
		//得到登录后session中的用户实体值
		PeopleEntity peopleEntity = (PeopleEntity) this.getSession(request, SessionConst.PEOPLE_SESSION);
		if(peopleEntity == null){
			this.outJson(response, null,false,this.getResString("people.session.msg.null.error"));
			return;
		}
		//用户帐号
		String peopleName = peopleEntity.getPeopleName();
		//应用id
		int appId = this.getAppId(request);

		// 验证用户名
		if(StringUtil.isBlank(peopleName) || peopleName.length()<3 || peopleName.length() >12){
			this.outJson(response, null,false,this.getResString("people.msg.name.error",com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
		
		//根据帐号查找实体
		PeopleEntity people = this.peopleBiz.getEntityByUserName(peopleName,appId);
		//如果用户不存在
		if(people == null){
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("err.not.exist",this.getResString("people")));
		}else{
			//返回用户信息
			this.outJson(response, null, true,JSON.toJSONString(people));
		}
	}
	
	
	/**
	 * 判断用户的验证码和填写用户名是否正确
	 * @param request
	 * @param response
	 */                      
	@RequestMapping("/validatePeopleByName")
	public void validatePeopleByName(HttpServletRequest request,HttpServletResponse response){
			//用户帐号
			String peopleName = request.getParameter("peopleName");
			String imgCode = request.getParameter("imgCode");
	
			// 验证用户名
			if(StringUtil.isBlank(peopleName) || peopleName.length()<3 || peopleName.length() >12){
				this.outJson(response, null,false,this.getResString("people.msg.name.error",com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
			//获取session中的用户实体
			 PeopleEntity peopleEntity =this.getPeopleBySession(request);
			 
			//根据帐号查找实体
			if(!peopleEntity.getPeopleName().equals(peopleName)){
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.session.name.mismatch.error"));
				return;
			}
			
			//验证用户输入的验证码是否正确
			if(StringUtil.isBlank(imgCode) || !imgCode.equalsIgnoreCase(this.getCodeBySession(request))){
				this.outJson(response, null,false,this.getResString("err.error",getResString("peopleImageCode")));
				return;
			}
			//返回用户信息
			this.outJson(response, null, true);
	}
	
	
	/**
	 * 自动登录
	 * @param request
	 * @param response
	 */
	@RequestMapping("/checkAutoLogin")
	public void checkAutoLogin(HttpServletRequest request,HttpServletResponse response){
		// 获取用户名
		String userName = request.getParameter("userName");
		// 获取密码(MD5加密过的密码)
		String peoplePassWord = request.getParameter("peoplePassWord");
		
		if (StringUtil.isBlank(userName) || StringUtil.isBlank(peoplePassWord)) {
			this.outJson(response, ModelCode.PEOPLE_LOGIN, false, this.getResString("people.msg.null.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
		
		//获取页面上标记为PEOPLE_COOKIE的cookies值
		String  peopleCookies = this.getCookie(request, CookieConst.PEOPLE_COOKIE) ;
		//默认不存在
		 int exsit = -1;
		 if(peopleCookies!=null){
			 //cookies中存在autoLoginInCookies字段的话exsit！= -1
			 exsit = peopleCookies.indexOf("autoLoginInCookies");
		 }
		 //查找到cookies里用户名对应的用户实体
		 PeopleEntity peopleEntity = this.peopleBiz.getEntityByUserName(userName, this.getAppId(request));
		 //判断自动登录字段是否存在，密码是否正确
		 if(exsit != -1 && peoplePassWord.equals(peopleEntity.getPeoplePassword())){
				// 登录成功,压入用户session
				this.setSession(request, SessionConst.PEOPLE_SESSION, peopleEntity);
				this.outJson(response, ModelCode.PEOPLE_LOGIN, true);
		}else{
				 this.outJson(response, ModelCode.PEOPLE_LOGIN, false);
		} 
		 
	}
}










