package com.mingsoft.parser.impl.general;

import com.mingsoft.parser.IParser;
/**
 * 网站Logo,返回logo的图片地址(单标签)
 * 网站全局标签
 *  {ms: global.logo/}
 * @author 成卫雄
 * QQ:330216230
 * 技术支持：景德镇铭飞科技
 * 官网：www.ming-soft.com
 */
public class GlobalLogoParser extends IParser {
	
	/**
	 *  网站Logo,返回logo的图片地址 网站全局标签 {ms: global.logo/}
	 */
	private final static String GLOBAL_LOGO="\\{ms:global.logo/\\}";
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public GlobalLogoParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(GLOBAL_LOGO);
	}

}
