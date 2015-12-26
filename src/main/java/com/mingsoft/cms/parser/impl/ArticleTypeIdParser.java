package com.mingsoft.cms.parser.impl;

import java.util.Map;


import com.mingsoft.parser.IParser;
import com.mingsoft.util.StringUtil;
/**
 * 文章所在的栏目名称(单标签)	
 * 文章内容标签
 * {ms:field.typetitle/}
 * @author 成卫雄
 * QQ:330216230
 * 技术支持：景德镇铭飞科技
 * 官网：www.ming-soft.com
 */
public class ArticleTypeIdParser extends IParser{
	
	/**
	 * 文章所属栏目标题标签
	 */
	private final static String ARTICLE_TYPEID ="\\{ms:field.typeid(.*)?/\\}";
	
	private  final static String TYPE = "type";
	
	private final static String TYPE_TOP = "top";
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public ArticleTypeIdParser(String htmlContent,String newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = newContent;
	}
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(ARTICLE_TYPEID);
	}
	
	/**
	 *  是否存在type=top的属性
	 * @return　true:存在 false:不存在
	 */
	public boolean  isTop() {
		String temp  = super.getProperty(ARTICLE_TYPEID).get(TYPE);
		if (StringUtil.isBlank(temp)) {
			return false;
		} else {
			return temp.equalsIgnoreCase(TYPE_TOP) ;
		}
	}
	

}
