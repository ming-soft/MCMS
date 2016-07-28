/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.mingsoft.cms.parser.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import com.mingsoft.parser.IParser;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.RegexUtil;
import com.mingsoft.util.StringUtil;
/**
 * 不解析标签类，当前端使用该标签后。被该标签包裹的内容的标签将不会被解析
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015-11-19<br/>
 * 历史修订：<br/>
 */
public class NoParser  extends IParser{
	
	/**
	 * 不解析标签开始正则表达式
	 */
	protected final static String LIST_NOPARSER="\\{ms:noparser\\}";
	
	
	/**
	 * 不解析标签临时标记标签
	 */
	protected final static String TAB_BODY="\\{ms:noparser\\}([\\s\\S]*?)\\{/ms:noparser}";
	
	/**
	 * 临时标签开始标记
	 */
	protected final static String TAB_BEGIN_LIST="{MS:NOTAB}";
	
	/**
	 * 临时标签结束标签
	 */
	protected final static String LIST_TEMP_TAB_END="\\{MS:NOTAB}([\\s\\S]*?)(\\{\\/ms:noparser})";
	
	/**
	 * 不解析标签结束正则表达式
	 */
	protected final static String LIST_END="\\{/ms:noparser\\}";
	
	/**
	 * 不解析标签结束标签的临时结束标签
	 */
	protected final static String TAB_END_LIST="\\{/MS:NOTAB\\}";
	
	/**
	 *标记标签
	 */
	protected final static String TAB_CONTENT="{MS:NOPARSER}";
	
	/**
	 * 标记标签对应的正则表达式
	 */
	protected final static String TAB_REG_CONTENT="\\{MS:NOPARSER\\}";
	
	/**
	 * 用来暂时存放不解析标签包着的htm代码
	 */
	private List<String> noParserHtml = new ArrayList<String>();
	
	/**
	 * 不解析标签的个数
	 */
	int noParserCount ;
	/**
	 * 
	 * @param htmlCotent html模版内容
	 */
	public NoParser(String htmlCotent){
		
		this.htmlCotent = htmlCotent;
	}
	
	
	
	/**
	 * 计算不解析标签的个数
	 * @param html htm模版
	 * @return 个数
	 */
	public static int countParser(String html) {
		int listNumBegin = count(html,LIST_NOPARSER);
		return listNumBegin;
	}
	
	/**
	 * 将不解析的标签替换成中间标签
	 */
	@Override
	public String parse() {
//		//获取模版中不解析标签的个数
//		this.noParserCount = countParser(htmlCotent);
//		for(int i=0;i<noParserCount;i++){
//			htmlCotent = replaceStartAndEnd(htmlCotent,LIST_NOPARSER);
//		}
//		noParserHtml =this.getNoParserHtml(noParserCount);
		return htmlCotent;
	}
	
	/**
	 * 将本来在不解析标签处的代码替换掉标记标签，恢复html模版原来的代码
	 * @param htmlCotent html模版
	 * @return
	 */
	public String parse(String htmlCotent,List<String> noParserHtml){
		if(noParserHtml!=null && noParserHtml.size()<=0){
			return htmlCotent;
		}
		for(int i=0;i<noParserHtml.size();i++){
			htmlCotent =RegexUtil.replaceFirst(htmlCotent, TAB_REG_CONTENT, noParserHtml.get(i)); 
		}
		return htmlCotent;
	}
	
	
	/**
	 * 获取所有不解析标签的代码集合
	 * @param count 不解析标签的
	 * @param html html代码
	 * @return 代码集合
	 */
	public List<String> getNoParserHtml(int count,List<String> noParserHtml){
		for(int i=0;i<count;i++){
			String tabHtml = "";
			//查找出第i+1个不解析标签的代码
			tabHtml = tabHtml(this.htmlCotent);
			
			Pattern pattern = Pattern.compile(TAB_BODY);
			Matcher matcher = pattern.matcher(this.htmlCotent);
			if (matcher.find()) {
				this.htmlCotent = this.htmlCotent.replace(matcher.group(),TAB_CONTENT);
			}
			if(!StringUtil.isBlank(tabHtml)){
				//将需要替换的代码保存到
				noParserHtml.add(tabHtml);
			}
		}
		return noParserHtml;
	}
	
	
	/**
	 * 
	 * @param htmlCotent
	 * @return
	 */
	protected String tabHtml(String htmlCotent) {
		return RegexUtil.parseFirst(htmlCotent,TAB_BODY,1);
	}
	
	/**
	 * 将标签替换成临时标签
	 * @param htmlCotent
	 * @param regex
	 * @return
	 */
	protected String replaceStartAndEnd(String htmlCotent,String regex) {
		super.htmlCotent = htmlCotent;
		super.newCotent = TAB_BEGIN_LIST;
		htmlCotent = super.replaceFirst(regex);
		if (htmlCotent.equals("")) {
			htmlCotent = IParserRegexConstant.REGEX_ERRO;
		}
		Pattern pattern = Pattern.compile(LIST_TEMP_TAB_END);
		Matcher matcher = pattern.matcher(htmlCotent);
		if (matcher.find()) {
			String tmp = matcher.group();
			String tmp2 = tmp;
			tmp = tmp.replaceAll(LIST_END,TAB_END_LIST);
			htmlCotent = htmlCotent.replace(tmp2, tmp);
		}
		if (htmlCotent.equals("")) {
			htmlCotent = IParserRegexConstant.REGEX_ERRO;
		}
		return htmlCotent;
	}


}