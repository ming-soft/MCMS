package com.mingsoft.basic.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 后台拦截器
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ManagerInterceptor extends  HandlerInterceptorAdapter {
    
    protected Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 后台拦截器
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse 对象
	 * @param handler 处理器
	 * @throws Exception 异常处理
	 * @return 处理后返回true
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//    	String modelId = request.getParameter("modelId"); //获取模块编号
//    	if (StringUtil.isInteger(modelId)) {
//    		request.getSession().setAttribute(SessionConst.MODEL_ID_SESSION.toString(), modelId);
//    		request.getSession().setAttribute(SessionConst.MODEL_TITLE_SESSION.toString(), request.getParameter("modelTitle"));
//    	}
//        request.setAttribute(BASE, Const.BASE);
//        request.setAttribute(BASE_PATH,request.getScheme() + "://"+ request.getServerName() + (request.getServerPort()==80?"":":"+request.getServerPort())+ Const.BASE);
        return true; 
	}
	
	

}
