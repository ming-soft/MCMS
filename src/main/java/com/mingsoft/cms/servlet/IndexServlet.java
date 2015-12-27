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

package com.mingsoft.cms.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.servlet.BaseServlet;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.StringUtil;

/**
 * CMS系统分发serlvet,根据地址栏判断网站来源,
 * 注意：每个网站的静态文件必须加上网站绝对地址。例如：http://www.abc.com/html/abc.html
 */

@WebServlet("/index")
public class IndexServlet extends BaseServlet{
	/**
	 * 版本信息
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 手机端访问路径前缀名
	 */
	private static String MOBILE_PATH = "m";
	
	private static boolean isFirst = true;
	
	/**
	 * 注入站点业务层
	 */
	private IAppBiz appBiz;
	
	/**
	 * 根据地址栏判断网站来源,跳转到对应的网站首页
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取用户所请求的域名地址

		appBiz = (IAppBiz) getBean(request.getServletContext(), "appBiz");
		//查询数据库获取域名对应Id
		int websiteId = 0;
		AppEntity website = appBiz.getByUrl(getDomain(request));
		if(website!=null){
			websiteId = website.getAppId();
		} else {
			this.outString(response, this.getResString("err"));
			return ;
		}
		String path = "";
		
		if (!StringUtil.isBlank(website.getAppMobileStyle())) {
			path = isMobileDevice(request)?MOBILE_PATH:""; //如果是手机访问就跳转到相应页面	
		}
		
		String defaultHtmlPath = this.getRealPath(request, IParserRegexConstant.HTML_SAVE_PATH+File.separator+websiteId+File.separator+path+File.separator+"default.html");
		File file = new File(defaultHtmlPath);
		String indexPosition =IParserRegexConstant.HTML_SAVE_PATH+File.separator+websiteId+File.separator+path+File.separator+"index.html";
		if (file.exists()) {
			 indexPosition =IParserRegexConstant.HTML_SAVE_PATH+File.separator+websiteId+File.separator+path+File.separator+"default.html";
		}
		
		//转发到网站首页
		request.getRequestDispatcher(indexPosition).forward(request, response);
		
	}

	
		
}