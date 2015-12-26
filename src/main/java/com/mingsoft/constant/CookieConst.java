package com.mingsoft.constant;

/**
 * 
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技MS-MMS</b>
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
 * @author killfen
 * 
 * @version 100-000-000
 * 
 * <p>
 * 版权所有
 * </p>
 *  
 * <p>
 * Comments:cookie枚举类
 * </p>
 *  
 * <p>
 * Create Date:2014-6-15
 * </p>
 *
 * <p>
 * Modification history:暂无
 * </p>
 */
public enum CookieConst{
	/**
	 * 用户的cookie
	 */
	PEOPLE_COOKIE("people_cookie"),
	
	/**
	 * 分页cookie
	 */
	PAGENO_COOKIE("pageno_cookie"),
	
	/**
	 *上次访问地址
	 */
	BACK_COOKIE("back_cookie"),


	/**
	 * 保存用户QQ登录cookie</br>
	 * cookie为openId
	 */
	API_LOGIN_QQ_COOKIE("api_login_qq_cookie"),
	
	/**
	 * 课表cookie
	 * 保存用户所在的班级
	 */
	CURRICULUM_COOKIE("curriculum_cookie"),
	
	/**
	 * QQ登录保存当前用户点击地址的session
	 */
	API_LOGIN_QQ_URL("api_login_qq_url");
	
	CookieConst(String attr) {
		this.attr = attr;
	}
	
	private String attr;

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return attr;
	}
}
