package com.mingsoft.people.entity;

import com.mingsoft.base.entity.BaseEntity;

/**
 *  开发平台用户 
 * @author 肥猪
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2016年1月25日<br/>
 * 历史修订：<br/>
 */
public class PeopleOpenEntity extends PeopleUserEntity{
 
	private int peopleOpenPeopleId;
	
	private String peopleOpenId;
	
	private int peopleOpenPlatform;

	public int getPeopleOpenPeopleId() {
		return peopleOpenPeopleId;
	}

	public void setPeopleOpenPeopleId(int peopleOpenPeopleId) {
		this.peopleOpenPeopleId = peopleOpenPeopleId;
	}

	public String getPeopleOpenId() {
		return peopleOpenId;
	}

	public void setPeopleOpenId(String peopleOpenId) {
		this.peopleOpenId = peopleOpenId;
	}

	public int getPeopleOpenPlatform() {
		return peopleOpenPlatform;
	}

	public void setPeopleOpenPlatform(int peopleOpenPlatform) {
		this.peopleOpenPlatform = peopleOpenPlatform;
	}
	
}
