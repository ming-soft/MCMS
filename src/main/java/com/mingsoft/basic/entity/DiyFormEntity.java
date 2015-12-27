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

package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.util.AESUtil;
import com.mingsoft.util.StringUtil;

/**
 * 自定义表单实体
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class DiyFormEntity extends BaseEntity{
	/**
	 * 自增长ID
	 */
	private int diyFormId;
	
	/**
	 * 表名提示文字
	 */
	private String diyFormTipsName;
	
	/**
	 * 表单名称
	 */
	private String diyFormTableName;
	
	/**
	 * 表单所属的管理员id
	 */
	private int diyFormManagerId;
	
	/**
	 * 表单所属的管理员id
	 */
	private int diyFormAppId;
	
	/**
	 * 表单的访问地址
	 */
	private String diyFormUrl;

	public int getDiyFormId() {
		return diyFormId;
	}

	public void setDiyFormId(int diyFormId) {
		this.diyFormId = diyFormId;
	}

	public String getDiyFormTipsName() {
		return diyFormTipsName;
	}

	public void setDiyFormTipsName(String diyFormTipsName) {
		this.diyFormTipsName = diyFormTipsName;
	}

	public String getDiyFormTableName() {
		return diyFormTableName;
	}

	public void setDiyFormTableName(String diyFormTableName) {
		this.diyFormTableName = diyFormTableName;
	}

	public int getDiyFormManagerId() {
		return diyFormManagerId;
	}

	public void setDiyFormManagerId(int diyFormManagerId) {
		this.diyFormManagerId = diyFormManagerId;
	}

	public int getDiyFormAppId() {
		return diyFormAppId;
	}

	public void setDiyFormAppId(int diyFormAppId) {
		this.diyFormAppId = diyFormAppId;
		
	}

	public String getDiyFormUrl() {
		diyFormUrl=AESUtil.encrypt(this.diyFormId+"", StringUtil.Md5(this.diyFormAppId+"").substring(16));
		return diyFormUrl;
	}

	public void setDiyFormUrl(String diyFormUrl) {
		this.diyFormUrl = diyFormUrl;
	}
	
	
}