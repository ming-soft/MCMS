/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

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

package com.mingsoft.parser.impl.general;

import com.mingsoft.parser.IParser;
import com.mingsoft.util.PageUtil;

/**
 * 解析分页标签中的，页面总数，当前第几页，列表文章总数标签 分页标签 页面总数：{ms:page.total/} 当前第几页：{ms:page.cur/} 列表文章总数：{ms:page.articletotal/}
 * 
 * @author 成卫雄 QQ:330216230 技术支持：景德镇铭飞科技 官网：www.ming-soft.com
 */
public class PageNumParser extends IParser {

	private PageUtil page;
	
	/**
	 *  页面总数 列表分页标签 {ms:page.total/}
	 */
	private final static String PAGE_TOTAL="\\{ms:page.total/\\}";
	
	/**
	 * 当前处于第几页 列表分页标签 {ms:page.cur/}
	 */
	private final static String PAGE_CUR="\\{ms:page.cur/\\}";
	
	/**
	 * 列表文章的总数 列表分页标签 {ms:page.rcount}
	 */
	private final static String PAGE_RCOUNT="\\{ms:page.rcount/\\}";
	/**
	 * 构造替换标签必须的参数
	 * 
	 * @param htmlContent
	 *            原HTML代码
	 * @param pageSize
	 *            每页显示文章的数量
	 * @param cur
	 *            当前文章处于第几页
	 * @param articletotal
	 *            列表文章的总数
	 */
	public PageNumParser(String htmlContent, PageUtil page) {
		super.htmlCotent = htmlContent;
		this.page = page;
	}

	@Override
	public String parse() {
		if (this.page != null) {
			// TODO Auto-generated method stub
			// 替换页面总数标签
			super.htmlCotent = replaceRegex(PAGE_TOTAL, page.getPageCount());
			// 替换当前处于第几页标签
			super.htmlCotent = replaceRegex(PAGE_CUR, page.getPageNo()+1);
			// 替换当前列表下文章的总数
			super.htmlCotent = replaceRegex(PAGE_RCOUNT, page.getRecordCound());
			return super.htmlCotent;
		} else {
			return super.htmlCotent;
		}
	}

	public String replaceRegex(String regex, int num) {
		super.newCotent = Integer.toString(num);
		String html = super.replaceAll(regex);
		return html;
	}
}