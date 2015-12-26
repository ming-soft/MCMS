package com.mingsoft.basic.configurer;

import java.io.IOException;

import com.jagregory.shiro.freemarker.ShiroTags;

import freemarker.template.TemplateException;

/**
 * shiro,freemarker标签设置
 * @author killfen
 * @version 
 * 项目名：ms-basic<br/>
 * 创建日期：:2015年9月9日 <br/>
 * 历史修订：<br/>
 */
public class ShiroTagFreeMarkderConfigurer extends org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer {
	 @Override
	    public void afterPropertiesSet() throws IOException, TemplateException {
	        super.afterPropertiesSet();
	        this.getConfiguration().setSharedVariable("shiro", new ShiroTags());
	    }
}
