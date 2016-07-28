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

package com.mingsoft.cms.constant;

import com.mingsoft.base.constant.e.BaseEnum;

public enum ModelCode implements BaseEnum{
	/**
	 * 内容：栏目模块编号
	 */
	CMS_COLUMN("02990000"),

	/**
	 * 内容：文章模块编号
	 */
	CMS_ARTICLE("02980100"),
	/**
	 * 内容：文章列表
	 */
	CMS_ARTICLE_BASIC("02980000"),
	/**
	 * 内容：自定义搜索
	 */
	CMS_SEARCH("02050000"),

	/**
	 * 内容：自定义模型
	 */
	CMS_CONTENT_MODEL("02060000"),

	/**
	 * 内容：一键更新
	 */
	CMS_GENERATE_ALL("02070100"),

	/**
	 * 内容：更新主页
	 */
	CMS_GENERATE_INDEX("02070200"),

	/**
	 * 内容：更新文档
	 */
	CMS_GENERATE_ARTICLE("02070300"),

	/**
	 * 内容： 更新栏目
	 */
	CMS_GENERATE_COLUMN("02070400"),

	/**
	 * 内容：模版
	 */
	CMS_TEMPLETSKIN("02080000"),
	
	
	
	/**
	 * 内容：织梦数据导入
	 */
	COM_DEDE_DATA_IMPORT("02090100"),
	
	/**
	 * 内容：栏目属性管理模块
	 */
	CMS_COLUMN_TYPE("02090200");
	/**
	 * 设置modelCode的常量
	 * @param code 常量
	 */
	ModelCode(String code) {
		this.code = code;
	}

	private String code;

	/**
	 * 返回该modelCode常量的字符串表示
	 * @return 字符串
	 */
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return code;
	}

	/**
	 * 返回该modelCode常量的整型表示
	 * @return 整型
	 */
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.parseInt(code);
	}

}