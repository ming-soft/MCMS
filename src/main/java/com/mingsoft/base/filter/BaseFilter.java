package com.mingsoft.base.filter;


import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import com.mingsoft.base.constant.Const;


/**
 * 基础filer类，任何一个请求都能在页面获取base变量。子类调用的时候必须使用super();
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public abstract class BaseFilter implements Filter {

	/*
	 * log4j日志记录
	 */
	protected Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 过滤
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse 对象
	 * @param chain 过滤器链
	 * @throws Exception 异常处理
	 */
	public abstract void doFilter(ServletRequest request,
			ServletResponse response, FilterChain chain) throws IOException,
			ServletException;

	/**
	 * log4j日志输出
	 * 
	 * @param request
	 *            ServletRequest对象<br>
	 * @param response
	 *            ServletResponse对象
	 */
	public void log4jPrintOut(ServletRequest request, ServletResponse response) {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		// log4j debug开启状态
		if (logger.isDebugEnabled()) {
			StringBuffer sb = new StringBuffer();
			Enumeration<String> names;
			sb.append("Logging : \n");
			sb.append("--- Request URL: ---\n").append("\t").append(
					((HttpServletRequest) httpRequest).getRequestURL()).append(
					"\n");
			names = httpRequest.getParameterNames();
			sb.append("--- Request Parameters: ---\n");
			while (names.hasMoreElements()) {
				String name = names.nextElement();
				sb.append("\t").append(name).append(":").append(
						httpRequest.getParameter(name)).append("\n");
			}
			names = httpRequest.getAttributeNames();
			sb.append("--- Request Attributes: ---\n");
			while (names.hasMoreElements()) {
				String name = names.nextElement();
				sb.append("\t").append(name).append(":").append(
						httpRequest.getAttribute(name)).append("\n");
			}
			names = httpRequest.getHeaderNames();
			sb.append("--- Request Heards: ---\n");
			while (names.hasMoreElements()) {
				String name = names.nextElement();
				sb.append("\t").append(name).append(":").append(
						httpRequest.getHeader(name)).append("\n");
			}

			names = httpRequest.getSession().getAttributeNames();
			sb.append("--- Request Sessions: ---\n");
			while (names.hasMoreElements()) {
				String name = names.nextElement();
				sb.append("\t").append(name).append(":").append(
						httpRequest.getSession().getAttribute(name)).append(
						"\n");
			}

			Cookie[] cookies = httpRequest.getCookies();
			sb.append("--- Request Cookies: ---\n");
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					Cookie thisCookie = cookies[i];
					sb.append("\t").append(thisCookie.getName()).append(":")
							.append(thisCookie.getValue()).append("\n");
				}
			}
			logger.debug(sb.toString());
		}

	}

	/**
	 * 使过滤器为处理做准备
	 * @param filterConfig 过滤器初始化参数
	 */
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
        Const.BASE = filterConfig.getServletContext().getContextPath();
	    Const.PROJECT_PATH =  filterConfig.getServletContext().getRealPath("/");
	}

	/**
	 * 执行清理操作
	 */
    @Override
    public void destroy() {}
}
