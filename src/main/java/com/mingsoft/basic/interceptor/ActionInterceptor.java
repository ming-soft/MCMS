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

package com.mingsoft.basic.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.util.StringUtil;

/**
 * 所有action的拦截器，主要是设置base与basepath
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ActionInterceptor extends  HandlerInterceptorAdapter {
    
    protected Logger logger = Logger.getLogger(this.getClass());
    
    private static String BASE = "base";
    
    private static String BASE_PATH = "basePath";
    
    private static String MODEL_ID = "modelId";
    
    private static String BASE_URL = "baseUrl";
    

    public static boolean IS_WINDOWS  = false;
    
    
    
    
    static {
    	if (System.getProperty("os.name").toLowerCase().indexOf("windows" )>0) {
    		IS_WINDOWS = true;
    	}
    }

	/**
	 * 所有action的拦截,主要拦截base与basepath
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse 对象
	 * @param handler 处理器
	 * @throws Exception 异常处理
	 * @return 处理后返回true
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	String modelId = request.getParameter(MODEL_ID); //获取模块编号
    	if (StringUtil.isInteger(modelId)) {
    		request.getSession().setAttribute(SessionConst.MODEL_ID_SESSION.toString(), modelId);
    		request.getSession().setAttribute(SessionConst.MODEL_TITLE_SESSION.toString(), request.getParameter("modelTitle"));
    		
    	}
        request.setAttribute(BASE, Const.BASE);
        request.setAttribute(BASE_PATH,request.getScheme() + "://"+ request.getServerName() + (request.getServerPort()==80?"":":"+request.getServerPort())+ Const.BASE);
        request.setAttribute(BASE_URL,request.getScheme() + "://" + request.getServerName() + (request.getServerPort()==80?"":":"+request.getServerPort())+request.getContextPath() + request.getServletPath()+ (request.getQueryString()==null?"":"?"+request.getQueryString())  );
        return true; 
	}

}