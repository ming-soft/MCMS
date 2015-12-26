package com.mingsoft.parser.impl.general;

import com.mingsoft.parser.IParser;

/**
 * 网站关键字,网站标签(单标签)
 * 网站全局标签
 *  {ms: global.keyword/}
 * @author 成卫雄
 * QQ:330216230
 * 技术支持：景德镇铭飞科技
 * 官网：www.ming-soft.com
 */
public class GlobalKeywordParser extends IParser {
	
	/**
	 * 网站关键字,网站标签 网站全局标签 {ms: global.keyword/}
	 */
	private final static String GLOBAL_KEYWORD="\\{ms:global.keyword/\\}";
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public GlobalKeywordParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(GLOBAL_KEYWORD);
	}

}
