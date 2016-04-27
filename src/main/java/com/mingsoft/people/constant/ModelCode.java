package com.mingsoft.people.constant;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 
 * 铭飞会员系统 会员模块编码
 * @author 铭飞开发团队
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2016年3月30日<br/>
 * 历史修订：<br/>
 */
public enum ModelCode implements BaseEnum{

	/**
	 * 用户信息模块
	 */
	PEOPLE("07000000"),
	
	/**
	 * 用户注册
	 */
	PEOPLE_REGISTER("07010100"),
	
	/**
	 * 用户登录
	 */
	PEOPLE_LOGIN("07010200"),
	
	/**
	 * 普通用户管理
	 */
	PEOPLE_USER("07020100");
	

	
	/**
	 * 设置modelCode的常量
	 * @param code 常量
	 */
	ModelCode(String code) {
		this.code = code;
	}

	private String code;

	/**
	 * 返回该modelCode常量的字符串表示
	 * @return 字符串
	 */
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return code;
	}

	/**
	 * 返回该modelCode常量的整型表示
	 * @return 整型
	 */
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.parseInt(code);
	}
}
