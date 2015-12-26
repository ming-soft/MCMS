/**
 * 
 */
package com.mingsoft.cms.action.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mingsoft.cms.parser.CmsParser;
import com.mingsoft.util.StringUtil;

/** 
 * 动态生成页面，需要后台配置自定义页数据
 * @author killfen
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015-4-20<br/>
 * 历史修订：<br/>
 */
@Deprecated
@Controller("dynamicPageAction")
@RequestMapping("/")
public class DynamicPageAction extends com.mingsoft.base.action.BaseAction{
	
	/**
	 * 替换时间的字符
	 */
	private String date = "{date/}";
	/**
	 * 替换主机地址
	 */
	private String host = "{host/}";
	/**
	 *文章解析器
	 */
	@Autowired
	private CmsParser cmsParser;
	
	
	//该类作废，自定义页面路径请填写对应模块下面的DynamicPageAction的路径
	//如商城就为:/mall/{key}.do
	/**
	 * 前段会员中心所有页面都可以使用该方法 请求地址例如：　／{key}.do,例如登陆界面，与注册界面都可以使用
	 * 
	 * @param key
	 */
	@Deprecated
	@RequestMapping("/{key}.do")
	@ExceptionHandler(java.lang.NullPointerException.class) 
	public void model(@PathVariable(value = "key") String key, HttpServletRequest req, HttpServletResponse resp) {
		String content = this.generaterPage(key,cmsParser,req);
		if (StringUtil.isBlank(content)) {
			this.outString(resp, this.getResString("err"));
			return;
		}
		//增加时间
		content =  content.replace(date, StringUtil.getDateSimpleStr());
		content =  content.replace(host, this.getApp(req).getAppHostUrl());
		this.outString(resp, content);
	}
	
}
