package com.mingsoft.cms.parser.impl;

import com.mingsoft.parser.IParser;

/**
 * 文章内容(单标签)
 * 文章内容标签
 * {ms:field.content/}
 * @author 成卫雄
 * QQ:330216230
 * 技术支持：景德镇铭飞科技
 * 官网：www.ming-soft.com
 */
public class ArticleContentParser extends IParser {
	
	/**
	 * 文章内容标签
	 */
	private final static String ARTICLE_CONTENT_FIELD="\\{ms:field.content/\\}";
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public ArticleContentParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(ARTICLE_CONTENT_FIELD);
	}

}
