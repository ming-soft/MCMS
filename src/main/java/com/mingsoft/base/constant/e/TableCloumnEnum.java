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

package com.mingsoft.base.constant.e;

/**
 * 表字段类型常规定义
 * 
 * @author 会飞的猪
 * @version 版本号：100-000-000<br/>
 *          创建日期：2016年1月17日<br/>
 *          历史修订：<br/>
 */
public enum TableCloumnEnum implements BaseEnum {
	VARCHAR(1, "varchar"), TEXT(3, "text"), INT(4, "int"), DATETIME(2, "datetime"), FLOAT(5, "float");
	private String obj;
	private int id;

	TableCloumnEnum(int id, String obj) {
		this.obj = obj;
		this.id = id;
	}

	@Override
	public int toInt() {
		// TODO Auto-generated method stub
		return id;
	}

	public String toString() {
		return this.obj.toString();
	}

}