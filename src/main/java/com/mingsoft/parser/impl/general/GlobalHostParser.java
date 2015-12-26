package com.mingsoft.parser.impl.general;

import com.mingsoft.parser.IParser;

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
 * @author 王天培
 *                QQ:78750478
 *
 * <p>
 * Comments:网站主机地址
 * </p>
 *
 * <p>
 * Create Date:2014-10-22
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public class GlobalHostParser extends IParser {
	
	/**
	 * 网站路径标签，单标签，主要用于提交列表等HTML的路径到相应的action中 网站全局标签 {ms:global.url/}
	 */
	private final static String GLOBAL_HOST="\\{ms:global.host/\\}";
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public GlobalHostParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	
	@Override
	public String parse() {
		return super.replaceAll(GLOBAL_HOST);
	}

}
