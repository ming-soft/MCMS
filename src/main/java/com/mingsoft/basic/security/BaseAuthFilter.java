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
