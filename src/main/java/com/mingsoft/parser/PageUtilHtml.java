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

package com.mingsoft.parser;

import com.mingsoft.util.PageUtil;

public class PageUtilHtml extends PageUtil{

	public PageUtilHtml(int pageNo, int pageSize, int recordCount,
			String linkUrl) {
		super(pageNo, pageSize, recordCount, linkUrl);
	}
	
	
	/**
	 * 获取首页链接地址
	 * @return
	 */
	public String getIndexUrl() {
		if (pageNo == 0) {
			indexUrl = "#";
		} else {
			indexUrl = this.linkUrl.replace("list", "") + IParserRegexConstant.HTML_INDEX;
		}
		return indexUrl;
	}
	
	
	/**
	 * 获取列表的上一页连接地址
	 */
	public String getPreviousUrl(){
		if (pageNo == 0) {
			previousUrl = "#";
		} else {
			if(pageNo==1){
				previousUrl = this.linkUrl.replace("list", "")  + IParserRegexConstant.HTML_INDEX;
			}else{
				previousUrl = this.linkUrl  + (pageNo)+IParserRegexConstant.HTML_SUFFIX;
			}
			
		}
		return previousUrl;
	}
	
	/**
	 * 获取下一页连接地址
	 */
	public String getNextUrl(){
		if (pageNo == pageCount) {
			nextUrl = "#";
		} else {
			if (pageNo+2>pageCount) {
				if(pageCount==1){
					nextUrl = this.linkUrl.replace("list", "")  + IParserRegexConstant.HTML_INDEX;
				}else{
					nextUrl = this.linkUrl + pageCount+IParserRegexConstant.HTML_SUFFIX;
				}
				
			} else {
				nextUrl = this.linkUrl + (pageNo+2)+IParserRegexConstant.HTML_SUFFIX;
			}
		}
		return nextUrl;
		
	}
	
	/**
	 * 获取末页的连接地址
	 */
	public String getLastUrl(){
		if (pageNo == pageCount) {
			lastUrl = "#";
		} else {
			if(pageCount==1){
				lastUrl = this.linkUrl.replace("list", "")  + IParserRegexConstant.HTML_INDEX;
			}else{
				lastUrl = this.linkUrl + pageCount+IParserRegexConstant.HTML_SUFFIX;
			}
		}
		return lastUrl;
	}

}