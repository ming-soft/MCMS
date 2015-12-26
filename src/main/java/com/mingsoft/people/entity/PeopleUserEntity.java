package com.mingsoft.people.entity;

import java.util.Date;

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
 * @author 刘继平
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:用户基础信息
 * </p>
 *  
 * <p>
 * Create Date:2014-9-4
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public class PeopleUserEntity extends PeopleEntity {
	
	/**
	 * 关联用户编号
	 */
	private int peopleUserPeopleId;
	
	/**
	 * 用户的真实名称
	 */
	private String peopleUserRealName;
	
	/**
	 * 用户地址
	 */
	private String peopleUserAddress;
	
	/**
	 * 用户头像
	 */
	private String peopleUserIcon;
	
	/**
	 * 用户昵称
	 */
	private String peopleUserNickName;

	/**
	 * 用户性别</br>
	 * 0.未知</br>
	 * 1.男</br>
	 * 2.女</br>
	 */
	private int peopleUserSex = 1; 
	
	/**
	 * 用户生日
	 */
	private Date peopleUserBirthday;
	
	/**
	 * 用户身份证号码
	 */
	private String peopleUserCard;
	

	
	/**
	 * 用户所属应用ID
	 */
	private int peopleUserAppId;
	
	/**
	 * 获取peopleUserRealName
	 * @return  peopleUserRealName
	 */
	public String getPeopleUserRealName() {
		return peopleUserRealName;
	}

	/**
	 * 设置peopleUserRealName
	 * @param peopleUserRealName
	 */
	public void setPeopleUserRealName(String peopleUserRealName) {
		this.peopleUserRealName = peopleUserRealName;
	}

	/**
	 * 获取peopleUserAddress
	 * @return  peopleUserAddress
	 */
	public String getPeopleUserAddress() {
		return peopleUserAddress;
	}

	/**
	 * 设置peopleUserAddress
	 * @param peopleUserAddress
	 */
	public void setPeopleUserAddress(String peopleUserAddress) {
		this.peopleUserAddress = peopleUserAddress;
	}

	/**
	 * 获取peopleUserIcon
	 * @return  peopleUserIcon
	 */
	public String getPeopleUserIcon() {
		return peopleUserIcon;
	}

	/**
	 * 设置peopleUserIcon
	 * @param peopleUserIcon
	 */
	public void setPeopleUserIcon(String peopleUserIcon) {
		this.peopleUserIcon = peopleUserIcon;
	}

	/**
	 * 获取peopleUserNickName
	 * @return  peopleUserNickName
	 */
	public String getPeopleUserNickName() {
		return peopleUserNickName;
	}

	/**
	 * 设置peopleUserNickName
	 * @param peopleUserNickName
	 */
	public void setPeopleUserNickName(String peopleUserNickName) {
		this.peopleUserNickName = peopleUserNickName;
	}

	/**
	 * 获取peopleUserSex
	 * @return  peopleUserSex
	 */
	public int getPeopleUserSex() {
		return peopleUserSex;
	}

	/**
	 * 设置peopleUserSex
	 * @param peopleUserSex
	 */
	public void setPeopleUserSex(int peopleUserSex) {
		if (peopleUserSex%2==0) {
			this.peopleUserSex = 2;
		} else {
			this.peopleUserSex = 1;
		}
		
	}

	/**
	 * 获取peopleUserBirthday
	 * @return  peopleUserBirthday
	 */
	public Date getPeopleUserBirthday() {
		return peopleUserBirthday;
	}

	/**
	 * 设置peopleUserBirthday
	 * @param peopleUserBirthday
	 */
	public void setPeopleUserBirthday(Date peopleUserBirthday) {
		this.peopleUserBirthday = peopleUserBirthday;
	}

	/**
	 * 获取peopleUserAppId
	 * @return  peopleUserAppId
	 */
	public int getPeopleUserAppId() {
		return peopleUserAppId;
	}

	/**
	 * 设置peopleUserAppId
	 * @param peopleUserAppId
	 */
	public void setPeopleUserAppId(int peopleUserAppId) {
		this.peopleUserAppId = peopleUserAppId;
	}
	
	/**
	 * 设置xu
	 * @return
	 */
	public int getPeopleUserPeopleId() {
		return peopleUserPeopleId;
	}

	public void setPeopleUserPeopleId(int peopleUserPeopleId) {
		this.peopleUserPeopleId = peopleUserPeopleId;
	}
	
	/**
	 * 获取用户身份证号码
	 * @return
	 */
	public String getPeopleUserCard() {
		return peopleUserCard;
	}
	
	/**
	 *设置用户身份证号码
	 * @param peopleUserCard
	 */
	public void setPeopleUserCard(String peopleUserCard) {
		this.peopleUserCard = peopleUserCard;
	}

	
	
}
