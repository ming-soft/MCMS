package com.mingsoft.cms.parser.impl;

import java.util.Date;

import com.mingsoft.parser.IParser;
import com.mingsoft.parser.IParserRegexConstant;
/**
 * 内容发布时间(单标签)
 * 文章内容标签
 * {ms:field.date  fmt="yyyy-mm-dd"/}
 * @author 成卫雄
 * QQ:330216230
 * 技术支持：景德镇铭飞科技
 * 官网：www.ming-soft.com
 */
public class ArticleDateParser extends IParser {
	
	/**
	 * 文章发布时间标签
	 */
	private final static String ARTICLE_DATE_FIELD="\\{ms:field.date\\s{0,}(fmt=(.*?))?/}";
	
	
	/**
	 * 构造标签的属性
	 * @param htmlContent原HTML代码
	 * @param newContent替换的内容
	 */
	public ArticleDateParser(String htmlContent,Date newContent){
		super.htmlCotent = htmlContent;
		super.newCotent = date(newContent, htmlContent);
	}
	
	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return super.replaceAll(ARTICLE_DATE_FIELD);
	}
	
	/**
	 * 将时间格式转换成字符串型并改变时间的显示格式
	 * @param date 数据库中的时间
	 * @param htmlCotent 读取时间格式的HTML代码
	 * @return 时间
	 */
	private String date(Date date,String htmlCotent){
		//从HTML代码中取出时间的显示格式，默认为yyyy-MM-dd hh:mm:ss形式
		String typeDate = IParserRegexConstant.REGEX_DATE;
		String fmt = parseFirst(htmlCotent,ARTICLE_DATE_FIELD, 2);
		if(fmt!= null){
			typeDate = fmt;
		}
		//将时间转换成String型
		String srtDate = IParserRegexConstant.REGEX_DATE_ERRO;
		if(date != null){
			try{
				java.text.SimpleDateFormat forDate = new java.text.SimpleDateFormat(typeDate);
				srtDate = forDate.format(date);
			}catch (Exception e) {
				// TODO: handle exception
			}
		}
		return srtDate;
	}

}
