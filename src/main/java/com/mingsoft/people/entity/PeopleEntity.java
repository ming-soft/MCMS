package com.mingsoft.people.entity;

import java.sql.Timestamp;
import java.util.Date;

import com.mingsoft.base.entity.SessionEntity;
import com.mingsoft.base.constant.e.BaseEnum;

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
 * Comments:用户基础表
 * </p>
 *  
 * <p>
 * Create Date:2014-7-29
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public class PeopleEntity extends SessionEntity {

	/**
	 * 自增长ID
	 */
	private int peopleId;
	
	/**
	 * 用户电话</br>
	 * 可用作登录</br>
	 */
	private String peoplePhone;

	/**
	 * 用户邮箱</br>
	 * 可用作登录</br>
	 */
	private String peopleMail;
	
	/**
	 * 登录帐号
	 */
	private String peopleName;
	
	/**
	 * 登录密码
	 */
	private String peoplePassword;
	
	/**
	 * 用户所属的应用ID
	 */
	private int peopleAppId;
	
	/**
	 * 注册时间  
	 */
	private Date peopleDateTime;

	/**
	 * 用户状态
	 * 1.已审核
	 * 0.未审核
	 */
	private int peopleState;
	
	/**
	 * 用户随机验证码
	 */
	private String peopleCode;
	
	/**
	 * 发送验证码的时间
	 */
	private Timestamp peopleCodeSendDate;
	
	/**
	 * 是否通过邮箱验证
	 */
	private int peopleMailCheck;
	
	/**
	 * 是否通过手机验证
	 */
	private int peoplePhoneCheck;
	
	/**
	 * 用户真信息
	 */
	private PeopleUserEntity peopleUser;

	public PeopleUserEntity getPeopleUser() {
		return peopleUser;
	}


	public void setPeopleUser(PeopleUserEntity peopleUser) {
		this.peopleUser = peopleUser;
	}


	/**
	 * 获取peopleState
	 * @return  peopleState
	 */
	public int getPeopleState() {
		return peopleState;
	}


	/**
	 * 设置peopleState，控制层推荐使用setPeopleState(BaseEnum e) 方法
	 * @see setPeopleState(BaseEnum e) 
	 * @param peopleState
	 */
	public void setPeopleState(int peopleState) {
		this.peopleState = peopleState;
	}
	/**
	 * 设置peopleState
	 * @param peopleState
	 */
	public void setPeopleState(BaseEnum e) {
		this.peopleState = e.toInt();
	}


	/**
	 * 获取peopleId
	 * @return  peopleId
	 */
	public int getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置peopleId
	 * @param peopleId
	 */
	public void setPeopleId(int peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取peoplePhone
	 * @return  peoplePhone
	 */
	public String getPeoplePhone() {
		return peoplePhone;
	}

	/**
	 * 设置peoplePhone
	 * @param peoplePhone
	 */
	public void setPeoplePhone(String peoplePhone) {
		this.peoplePhone = peoplePhone;
	}

	/**
	 * 获取peopleMail
	 * @return  peopleMail
	 */
	public String getPeopleMail() {
		return peopleMail;
	}

	/**
	 * 设置peopleMail
	 * @param peopleMail
	 */
	public void setPeopleMail(String peopleMail) {
		this.peopleMail = peopleMail;
	}

	/**
	 * 获取peopleName
	 * @return  peopleName
	 */
	public String getPeopleName() {
		return peopleName;
	}

	/**
	 * 设置peopleName
	 * @param peopleName
	 */
	public void setPeopleName(String peopleName) {
		this.peopleName = peopleName;
	}

	/**
	 * 获取peoplePassword
	 * @return  peoplePassword
	 */
	public String getPeoplePassword() {
		return peoplePassword;
	}

	/**
	 * 设置peoplePwd
	 * @param peoplePassword
	 */
	public void setPeoplePassword(String peoplePassword) {
		this.peoplePassword = peoplePassword;
	}

	/**
	 * 获取peopleAppId
	 * @return  peopleAppId
	 */
	public int getPeopleAppId() {
		return peopleAppId;
	}

	/**
	 * 设置peopleAppId
	 * @param peopleAppId
	 */
	public void setPeopleAppId(int peopleAppId) {
		this.peopleAppId = peopleAppId;
	}

	/**
	 * 获取peopleDateTime
	 * @return  peopleDateTime
	 */
	public Date getPeopleDateTime() {
		return peopleDateTime;
	}

	/**
	 * 设置peopleDateTime
	 * @param peopleDateTime
	 */
	public void setPeopleDateTime(Date peopleDateTime) {
		this.peopleDateTime = peopleDateTime;
	}
	
	/**
	 * 获取用户随机码
	 * @return
	 */
	public String getPeopleCode() {
		return peopleCode;
	}
	
	/**
	 * 设置用户随机码
	 * @param peopleCode
	 */
	public void setPeopleCode(String peopleCode) {
		this.peopleCode = peopleCode;
	}


	public Timestamp getPeopleCodeSendDate() {
		return peopleCodeSendDate;
	}

	
	public void setPeopleCodeSendDate(Timestamp peopleCodeSendDate) {
		this.peopleCodeSendDate = peopleCodeSendDate;
	}


	public int getPeopleMailCheck() {
		return peopleMailCheck;
	}


	/**
	 * 推荐使用枚举类形参方法
	 * @param peopleMailCheck
	 */
	@Deprecated
	public void setPeopleMailCheck(int peopleMailCheck) {
		this.peopleMailCheck = peopleMailCheck;
	}
	public void setPeopleMailCheck(BaseEnum check)  {
		this.peopleMailCheck = check.toInt();
	}

	public int getPeoplePhoneCheck() {
		return peoplePhoneCheck;
	}

	/**
	 * 推荐使用枚举类形参方法
	 * @param peoplePhoneCheck
	 */
	@Deprecated
	public void setPeoplePhoneCheck(int peoplePhoneCheck) {
		this.peoplePhoneCheck = peoplePhoneCheck;
	}
	
	public void setPeoplePhoneCheck(BaseEnum check) {
		this.peoplePhoneCheck = check.toInt();
	}
	
	
}
