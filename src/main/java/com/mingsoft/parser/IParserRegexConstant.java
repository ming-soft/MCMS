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


/**
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * @author killfen
 * 
 * <p>
 * Comments:解析器的通用提示信息，通用命名声明
 * </p>
 * 
 * <p>
 * Create Date:2015-4-18
 * </p>
 * 
 * <p>
 * Modification history:
 * </p>
 */
public interface IParserRegexConstant {

	/**
	 * 存放模版的文件夹
	 */
	final String REGEX_SAVE_TEMPLATE = "templets";

	/**
	 * 模版主页
	 */
	final String REGEX_INDEX_HTML = "index.htm";


	/**
	 * 没有找到相应的栏目后报错
	 */
	final String REGEX_CHANNEL_ERRO = "<!--未找到栏目-->";

	/**
	 * 时间读取错误后报错
	 */
	final String REGEX_DATE_ERRO = "时间读取失败";
	
	/**
	 * 时间的默认格式
	 */
	final String REGEX_DATE = "yyyy-MM-dd hh:mm:ss";

	/**
	 * 移动端生成的目录
	 */
	String MOBILE = "m";

	/**
	 * 提示用户：标签错误
	 */
	final String REGEX_ERRO = "<!--未找到该标签内容-->";

	/**
	 * 生成的静态列表页面名
	 */
	final String PAGE_LIST = "list";
	/**
	 * 文件夹路径名
	 */
	final String HTML_SUFFIX = ".html";

	/**
	 * 默认页
	 */
	String HTML_INDEX = "index.html";

	/**
	 * 静态文件生成路径
	 */
	final String HTML_SAVE_PATH = "html";
}