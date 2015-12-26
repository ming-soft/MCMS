package com.mingsoft.people.action.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mingsoft.people.biz.IPeopleBiz;
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.people.constant.e.PeopleEnum;
import com.mingsoft.people.action.BaseAction;
import com.mingsoft.util.DateUtil;
import com.mingsoft.util.StringUtil;

/**
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * @author 杨新远
 * 
 * <p>
 * Comments:用户模块的邮件调用模块
 * </p>
 * 
 * <p>
 * Create Date:2015-6-15
 * </p>
 * 
 * <p>
 * Modification history:
 * </p>
 */
@Controller("webPeopleMail")
@RequestMapping("/people/mail")
public class MailAction extends BaseAction{
	
	//注入用户业务层
	@Autowired
	private IPeopleBiz peopleBiz;
	
	/**
	 * 用户发送邮箱验证码
	 * 需要根据modelCode获取相应的邮件模板，同时该modelCode经过AES加密
	 * @param peopleMail 邮箱地址
	 * @param modelCode  模块编码
	 * @param request 
	 * @param response
	 */
	@RequestMapping("/peopleSendCode")
	public void peopleSendCode(String peopleMail,String modelCode,HttpServletRequest request, HttpServletResponse response)  {
		//通过邮箱地址和应用id得到用户实体
		PeopleEntity people = peopleBiz.getEntityByUserName(peopleMail, this.getAppId(request));
		if (people == null) {
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("err.not.exist", this.getResString("people.mail")));
			return;
		}
		
		String peopleCode = StringUtil.randomNumber(6);
		// 将生成的验证码加入用户实体
		people.setPeopleCode(peopleCode);

		//将当前时间转换为时间戳格式保存进people表
		people.setPeopleCodeSendDate(DateUtil.dateToTimestamp(new Date()));
		// 更新该实体
		this.peopleBiz.updateEntity(people);
		
		//解密得到的模块编码
		String _modelCode = this.decryptByAES(request, modelCode); 
		String[] user = { peopleMail };
		//先随机6位编码
		//保存对应的用户表里面
		//将短信的content赋值为6位对应编码
		this.sendMail(request, _modelCode, user,peopleCode);

		this.outJson(response, ModelCode.PEOPLE, true);
	}
	
	/**
	 * 对比邮箱验证码和数据库中的验证码是否相同
	 * @param peopleCode 验证码
	 * @param peopleMail 邮箱地址
	 * @param request
	 * @param response
	 */
	@RequestMapping("/peopleCheckCode")
	public void peopleCheckCode(String peopleCode,String peopleMail,HttpServletRequest request, HttpServletResponse response)  {
		//验证码
		if(StringUtil.isBlank(peopleCode)){
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("err.error", this.getResString("peopleCode")));
			return;
		}
		
		//根据邮箱地址查找用户实体
		PeopleEntity peopleEntity = this.peopleBiz.getEntityByUserName(peopleMail, this.getAppId(request));
		
		//得到发送验证码时间，并转换为String类型
		String date = peopleEntity.getPeopleCodeSendDate().toString();
	
		//如果发送时间和当前时间只差大于30分钟，则返回false
		if(DateUtil.secondBetween(date)>60*60*24){
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("people.msg.code.error"));
			return;
		}
		// 判断用户输入的随机码是否正确
		if (!peopleEntity.getPeopleCode().equals(peopleCode)) {
			this.outJson(response, ModelCode.PEOPLE, false, this.getResString("err.error", this.getResString("peopleCode")));
			return;
		}
		// 将随机码在数据库中清空
			peopleEntity.setPeopleCode("");
			peopleEntity.setPeopleMailCheck(PeopleEnum.MAIL_CHECK);
			peopleBiz.updateEntity(peopleEntity);
			this.outJson(response, ModelCode.PEOPLE, true);
	}
}
