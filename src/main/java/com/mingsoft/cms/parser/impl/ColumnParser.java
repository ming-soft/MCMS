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

import java.io.File;

import com.mingsoft.basic.entity.ColumnEntity;
import com.mingsoft.parser.IParser;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.StringUtil;

/**
 * 获取当前栏目的信息的标签
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-12-21<br/>
 * 历史修订：<br/>
 */
public class ColumnParser  extends IParser{
	
	
	/**
	 * 当前栏目id标签
	 */
	private final static String COLUMN_LD="\\{ms:field.typeid/\\}";
	
	/**
	 * 当前栏目名称标签
	 */
	private final static String COLUMN_TITLE="\\{ms:field.typetitle/\\}";
	
	/**
	 * 当前栏目描述标签
	 */
	private final static String COLUMN_DESCRIP="\\{ms:field.typedescrip/\\}";
	
	/**
	 * 当前栏目关键字标签
	 */
	private final static String COLUMN_KEYWORD="\\{ms:field.typekeyword/\\}";
	
	/**
	 *  当前栏目链接地址标签
	 */
	private final static String COLUMN_TYPE_LINK="\\{ms:field.typelink/\\}";
	
	/**
	 * 当前栏目的缩略图
	 */
	private final static String COLUMN_TYPE_LITPIC="\\{ms:field.typelitpic/\\}";
	
	/**
	 * 当前栏目实体
	 */
	private ColumnEntity column;
	
	/**
	 * 网站路径地址
	 */
	private String path;
	
	/**
	 * 解析当前栏目标签的构造函数
	 * @param htmlContent htm模版内容
	 * @param column 栏目实体
	 * @param path 路径
	 */
	public ColumnParser(String htmlContent,ColumnEntity column,String path){
		super.htmlCotent = htmlContent;
		this.column = column;
		this.path = path;
	}
	
	
	
	@Override
	public String parse() {
		super.newCotent = column.getCategoryId()+"";
		htmlCotent = super.replaceAll(COLUMN_LD);
		super.newCotent = column.getCategoryTitle();
		htmlCotent = super.replaceAll(COLUMN_TITLE);
		super.newCotent =column.getColumnDescrip();
		htmlCotent = super.replaceAll(COLUMN_DESCRIP);
		super.newCotent = column.getColumnKeyword();
		htmlCotent = super.replaceAll(COLUMN_KEYWORD);
		String channelLink = path+StringUtil.null2String(column.getColumnPath())+File.separator+ IParserRegexConstant.HTML_INDEX;
		super.newCotent =channelLink;
		htmlCotent = super.replaceAll(COLUMN_TYPE_LINK);
		super.newCotent = column.getCategorySmallImg();
		htmlCotent = super.replaceAll(COLUMN_TYPE_LITPIC);
		return htmlCotent;
	}

}