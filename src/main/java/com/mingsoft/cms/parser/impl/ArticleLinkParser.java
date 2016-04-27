package com.mingsoft.cms.parser.impl;


import com.mingsoft.parser.IParser;
/**
 * 当前文章内容标签（但标签）
 * 文章内容标签
 * {ms:field.link/}
 * @author 成卫雄
 * QQ:330216230
 * 技术支持：景德镇铭飞科技
 * 官网：www.ming-soft.com
 */
public class ArticleLinkParser  extends IParser{
	
	/**
	 * 文章内容连接标签
	 */
	private final static String ARTICLE_LINK_FIELD="\\{ms:field.link/\\}";
	
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public ArticleLinkParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(ARTICLE_LINK_FIELD);
	}

}
