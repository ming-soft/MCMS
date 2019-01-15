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

package net.mingsoft.cms.constant.e;

import net.mingsoft.base.constant.e.BaseEnum;

/**
 * 
 * @ClassName:  ColumnTypeEnum   
 * @Description:TODO(文章栏目分类类型)   
 * @author: 铭飞开发团队
 * @date:   2018年1月31日 下午2:55:18   
 *     
 * @Copyright: 2018 www.mingsoft.net Inc. All rights reserved.
 */
public enum ColumnTypeEnum implements BaseEnum {
	/**
	 * 列表
	 */
	COLUMN_TYPE_LIST(1),
	/**
	 * 单页
	 */
	COLUMN_TYPE_COVER(2),
	/**
	 * 跳转地址
	 */
	COLUMN_TYPE_URL(3);
	ColumnTypeEnum(Object code) {
		this.code = code;
	}
	
	private Object code;
	@Override
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.valueOf(code+"");
	}
	
}