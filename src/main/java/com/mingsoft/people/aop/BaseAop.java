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

package com.mingsoft.people.aop;

import javax.servlet.http.HttpServletRequest;

import com.mingsoft.base.entity.SessionEntity;
import com.mingsoft.people.constant.e.SessionConstEnum;

import net.mingsoft.basic.util.BasicUtil;

/**
 * bbs切面基础方法
 * 
 * @author 史爱华
 * @version 版本号：100-000-000<br/>
 *          创建日期：2015-12-14<br/>
 *          历史修订：<br/>
 */
public abstract class BaseAop extends com.mingsoft.basic.aop.BaseAop {


	/**
	 * 读取用户sessoin
	 * 
	 * @param request
	 *            HttpServletRequest对象
	 * @return 返回获取到的用户session,获取不到返回nul
	 */
	@Deprecated
	protected SessionEntity getPeopleBySession(HttpServletRequest request) {
		// 传入用户请求，读取用户的session || super,调用父类的protected属性的getSession方法
		Object obj = this.getSession(request, SessionConstEnum.PEOPLE_SESSION);
		if (obj != null) {
			// 返回用户的所有信息
			return (SessionEntity) obj;
		}
		return null;
	}
	
	/**
	 * 读取用户sessoin
	 * 
	 * @param request
	 *            HttpServletRequest对象
	 * @return 返回获取到的用户session,获取不到返回nul
	 */
	protected SessionEntity getPeopleBySession() {
		// 传入用户请求，读取用户的session || super,调用父类的protected属性的getSession方法
		Object obj = BasicUtil.getSession(SessionConstEnum.PEOPLE_SESSION);
		if (obj != null) {
			// 返回用户的所有信息
			return (SessionEntity) obj;
		}
		return null;
	}

}