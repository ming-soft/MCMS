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

package com.mingsoft.cms.action.web;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.cms.parser.CmsParser;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.StringUtil;
import com.mingsoft.base.action.BaseAction;

/**
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * @author killfen
 * 
 * <p>
 * Comments:错误页面定义
 * </p>
 * 
 * <p>
 * Create Date:2015-4-26
 * </p>
 * 
 * <p>
 * Modification history:
 * </p>
 */
@Controller("errorAction")
@RequestMapping("/error")
public class ErrorAction extends  BaseAction{
	
	/**
	 * 404页面地址
	 */
	private final static String  ERR_404 = "/errors/404.html";
	
	/**
	 * 500页面地址
	 */
	private final static String  ERR_500 = "/errors/500.html";
	
	/**
	 *文章解析器
	 */
	@Autowired
	private CmsParser cmsParser;

	/**
	 * 返回404页面
	 */
	@RequestMapping("/404")
	@ResponseBody
	public void _404(HttpServletRequest req, HttpServletResponse resp){
		String content = FileUtil.readFile(this.getRealPath(req,ERR_404));
		this.outString(resp, content);
	}
	
	/**
	 * 返回500页面
	 * @param req
	 * @param resp
	 */
	@RequestMapping("/500")
	@ResponseBody
	public void _500(HttpServletRequest req, HttpServletResponse resp){
		//先判断当前因为是否有设置错误页面,错误页面的文件名称必须为500.htm
		// 模版路径加上(用户选择的主页的模版的路径)default/index.html
		String tmpFilePath = this.getTemplatePath(req) + "/500.html";
		String content = 	FileUtil.readFile(tmpFilePath);
		if (StringUtil.isBlank(content)) {
			 content = FileUtil.readFile(this.getRealPath(req,ERR_500));
		} else {
			content = this.parserMsTag(content,cmsParser, req);
		}
		this.outString(resp, content);
	}	
}