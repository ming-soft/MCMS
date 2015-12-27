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

package com.mingsoft.basic.security;

import javax.servlet.Filter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;

import org.springframework.web.context.WebApplicationContext;

import com.mingsoft.base.constant.Const;

/**
 * 
 * 权限过滤器
 * @author killfen QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015年9月8日<br/>
 * 历史修订：<br/>
 */
@WebFilter(filterName = "baseAuthFilter", urlPatterns = "/*")
public class BaseAuthFilter extends org.springframework.web.filter.DelegatingFilterProxy {

	@Override
	protected Filter initDelegate(WebApplicationContext wac) throws ServletException {
		// TODO Auto-generated method stub
		Const.BASE = wac.getServletContext().getContextPath();
		Const.PROJECT_PATH = wac.getServletContext().getRealPath("/");
		return super.initDelegate(wac);
	}

}