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

import java.util.HashMap;
import java.util.Map;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 自定义模型类型
 * 
 * @author 猪
 * @version 版本号：100-000-000<br/>
 *          创建日期：2012-03-15<br/>
 *          历史修订：<br/>
 */
public enum ContentModelFieldEnum implements BaseEnum {
	TEXT(1, "单行"), TEXTAREA(2, "多行"), HTML(3, "html"), INT(4, "整型"), FLOAT(5, "小数"), DATE(6, "日期"), IMAGE(7,
			"图片"), ATTACH(8, "附件"), OPTION(9, "下拉框"), RADIO(10, "单选"), CHECKBOX(11, "多选");

	/**
	 * 构造方法
	 * 
	 * @param code
	 *            传入的枚举类型
	 */
	ContentModelFieldEnum(int id, String text) {
		this.id = id;
		this.text = text;
	}

	/**
	 * 枚举类型
	 */
	private int id;

	private String text;

	@Override
	public int toInt() {
		// TODO Auto-generated method stub
		return id;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return text;
	}

	public static Map toMap() {
		Map<String, String> map = new HashMap<String, String>();
		for (ContentModelFieldEnum e : ContentModelFieldEnum.values()) {
			map.put(e.toInt() + "", e.toString());
		}
		return map;
	}

	public static ContentModelFieldEnum get(int id) {
		for (ContentModelFieldEnum e : ContentModelFieldEnum.values()) {
			if (e.toInt() == id) {
				return e;
			}
		}
		return null;
	}

	public static ContentModelFieldEnum get(String str) {
		for (ContentModelFieldEnum e : ContentModelFieldEnum.values()) {
			if (e.toString().equals(str)) {
				return e;
			}
		}
		return null;
	}
}