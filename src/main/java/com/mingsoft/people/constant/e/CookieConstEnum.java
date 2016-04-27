package com.mingsoft.people.constant.e;

import com.mingsoft.base.constant.e.BaseCookieEnum;

public enum CookieConstEnum implements BaseCookieEnum {
	/**
	 * 用户的cookie
	 */
	PEOPLE_COOKIE("people_cookie");

	/**
	 * 设置session常量
	 * 
	 * @param attr
	 *            常量
	 */
	CookieConstEnum(String attr) {
		this.attr = attr;
	}

	private String attr;

	/**
	 * 返回SessionConst常量的字符串表示
	 * 
	 * @return 字符串
	 */
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return attr;
	}

}
