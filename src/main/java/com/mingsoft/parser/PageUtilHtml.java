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
