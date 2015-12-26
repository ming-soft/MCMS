package com.mingsoft.people.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

public enum PeopleEnum implements BaseEnum {
	/**
	 * 用户为已审核状态
	 */
	STATE_CHECK(1),
	/**
	 *根据用户名注册
	 */
	REGISTER_NAME(1),
	/**
	 *根据手机号注册
	 */
	REGISTER_PHONE(2),
	/**
	 *根据邮箱注册
	 */
	REGISTER_EMAIL(3),
	
	/**
	 * 手机验证通过
	 */
	PHONE_CHECK(1),
	
	/**
	 * 手机验证不通过
	 */
	PHONE_NO_CHECK(0),
	/**
	 * 邮箱验证通过
	 */
	MAIL_CHECK(1),
	/**
	 * 邮箱验证不通过
	 */
	MAIL_NO_CHECK(0),
	/**
	 * 用户为未审核状态
	 */
	STATE_NOT_CHECK(0);
	
	PeopleEnum(Object code) {
		this.code = code;
	}

	private Object code;

	@Override
	public String toString() {
		return code.toString();
	}

	public int toInt() {
		return Integer.parseInt(code.toString());
	}
}
