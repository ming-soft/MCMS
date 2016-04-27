package com.mingsoft.people.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

/** 
 * 用户收货地址状态枚举类
 * @author yangxy
 * @version 
 * 版本号：【100-000-000】
 * 创建日期：2015年8月24日 
 * 历史修订：
 */
public enum PeopleAddressEnum implements BaseEnum{
	/**
	 * 默认收货地址
	 */
	ADDRESS_DEFAULT(0),
	
	/**
	 * 非默认收货地址
	 */
	ADDRESS_NOT_DEFAULT(1);
	
	PeopleAddressEnum(Object code) {
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
