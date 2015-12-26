package com.mingsoft.parser.impl.general;

import com.mingsoft.parser.IParser;

/**
 * 网站路径标签，单标签，主要用于提交列表等HTML的路径到相应的Servlet中
 * 网站全局标签
 *  {ms: global.url /}
 * @author 成卫雄
 * QQ:330216230
 * 技术支持：景德镇铭飞科技
 * 官网：www.ming-soft.com
 */
public class GlobalUrlParser extends IParser {
	
	/**
	 * 网站路径标签，单标签，主要用于提交列表等HTML的路径到相应的action中 网站全局标签 {ms:global.url/}
	 */
	private final static String GLOBAL_URL="\\{ms:global.url/\\}";
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public GlobalUrlParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(GLOBAL_URL);
	}

}
