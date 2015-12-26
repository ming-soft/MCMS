package com.mingsoft.cms.parser.impl;

import com.mingsoft.parser.IParser;

/**

 * 解析文章关键字标签{ms:field.keyword/}

 * @author 史爱华 QQ:924690193

 * @version

 * 版本号：100-000-000<br/>

 * 创建日期：2015-08-26<br/>

 * 历史修订：<br/>

 */
public class ArticleKeywordParser extends IParser{
	
	/**
	 * 文章关键字标签
	 */
	private final static String ARTICLE_KEYWORD_FIELD="\\{ms:field.keyword/\\}";
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public ArticleKeywordParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(ARTICLE_KEYWORD_FIELD);
	}
}
