/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

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

package com.mingsoft.people.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

public enum PeopleEnum implements BaseEnum {
	/**
	 * 用户为已审核状态
	 */
	STATE_CHECK(1),
	/**
	 * 用户为未审核状态
	 */
	STATE_NOT_CHECK(0),
	
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
	REGISTER_EMAIL(3);
	
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