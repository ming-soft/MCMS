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

package com.mingsoft.basic.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 自定义表单类型
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public enum DiyFormFieldEnum implements BaseEnum {
	/**
	 * 单行文本
	 */
	TEXT(1),
	/**
	 * 多行文本
	 */
	TEXTAREA(2),

	/**
	 * HTML
	 */
	HTML(3),

	/**
	 * 整型
	 */
	INT(4),

	/**
	 *  小數
	 */
	DOUBLE(5),

	/**
	 * 時間
	 */
	DATE(6),
	/**
	 * 图片
	 */
	IMAGE(7), 
	/**
	 *  附件
	 */
	ATTACHMENT(8), 
	/**
	 * 下拉框
	 */
	SELECT(9), 
	/**
	 * 單選
	 */
	RADIO(10), 
	/**
	 * 多選
	 */
	CHECKBOX(11),
	/**
	 * 许为空
	 */
	IS_NULL(1);

	/**
	 * 构造方法
	 * @param code 传入的枚举类型
	 */
	DiyFormFieldEnum(Object code) {
		this.code = code;
	}

	/**
	 * 枚举类型
	 */
	private Object code;

	@Override
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.valueOf(code.toString());
	}

}