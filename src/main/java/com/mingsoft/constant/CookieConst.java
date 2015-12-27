/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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