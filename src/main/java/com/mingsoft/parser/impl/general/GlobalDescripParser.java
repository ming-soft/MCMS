package com.mingsoft.parser.impl.general;

import com.mingsoft.parser.IParser;
/**
 * 网站描述,网站标签(单标签)
 * 网站全局标签
 *  {ms: global.descrip/}
 * @author 成卫雄
 * QQ:330216230
 * 技术支持：景德镇铭飞科技
 * 官网：www.ming-soft.com
 */
public class GlobalDescripParser extends IParser {
	
	/**
	 * 网站描述,网站标签 网站全局标签 {ms: global.descrip/}
	 */
	private final static String GLOBAL_DESCRIP="\\{ms:global.descrip/\\}";
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public GlobalDescripParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(GLOBAL_DESCRIP);
	}

}
