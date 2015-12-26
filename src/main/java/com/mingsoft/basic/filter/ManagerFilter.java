package com.mingsoft.basic.filter;

import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.mingsoft.base.filter.BaseFilter;
import com.mingsoft.base.constant.SessionConst;


/**
 * 后台过滤器
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
//@WebFilter(filterName="managerFilter",urlPatterns="/manager/*")
public class ManagerFilter extends BaseFilter {

	/**
	 * 过滤
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse 对象
	 * @param chain 过滤器链
	 * @throws ServletException Servlet异常处理
	 * @throws IOException IO异常处理
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		Object mangerObj = httpRequest.getSession().getAttribute(SessionConst.MANAGER_ESSION.toString());
		try {
			if (mangerObj!=null) {
				chain.doFilter(request, response);
			} else {
				httpResponse.sendRedirect(request.getScheme() + "://"+ request.getServerName() + (request.getServerPort()==80?"":":"+request.getServerPort())+ httpRequest.getContextPath() + "/ms/login.do");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}


}
