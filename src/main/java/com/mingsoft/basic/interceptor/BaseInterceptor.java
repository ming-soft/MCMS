/**
 * 
 */
package com.mingsoft.basic.interceptor;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.util.StringUtil;

/**
 * 基础拦截器
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public abstract class BaseInterceptor extends HandlerInterceptorAdapter{
	
	public Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 通过spring的webapplicationcontext上下文对象读取bean对象
	 * @param sc 上下文servletConext对象
	 * @param beanName 要读取的bean的名称
	 * @return 获取到返回对象，否则返回null
	 */
	protected Object getBean(ServletContext sc,String beanName) {
		return WebApplicationContextUtils.getWebApplicationContext(sc).getBean(beanName);
	}
	
	/**
	 * 设置session
	 * @param request HttpServletRequest对象
	 * @param key 键SessionConst里面定义
	 * @param obj 对象
	 */
	protected void setSession(HttpServletRequest request,SessionConst key,Object obj) {
		if (StringUtil.isBlank(obj.toString())) {
			return;
		}
		request.getSession().setAttribute(key.toString(), obj);
	}
	
	
	
	/**
	 * 获取session
	 * @param request HttpServletRequest对象
	 * @param key 键SessionConst里面定义
	 */
	protected Object getSession(HttpServletRequest request,SessionConst key) {
		return request.getSession().getAttribute(key.toString());
	}
}
