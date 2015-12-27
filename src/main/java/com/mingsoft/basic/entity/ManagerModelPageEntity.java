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

/**
 * 管理页面实体类
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ManagerModelPageEntity extends BaseEntity {
	
	/**
	 * 管理员id
	 */
	private int managerModelPagemanagerId;
	
	/**
	 * 后台显示界面地址
	 */
	private String managerModelPageUrl;
	
	/**
	 * 模块编号
	 */
	private int managerModelPageModelId;

	public int getManagerModelPagemanagerId() {
		return managerModelPagemanagerId;
	}

	public void setManagerModelPagemanagerId(int managerModelPagemanagerId) {
		this.managerModelPagemanagerId = managerModelPagemanagerId;
	}

	public String getManagerModelPageUrl() {
		return managerModelPageUrl;
	}

	public void setManagerModelPageUrl(String managerModelPageUrl) {
		this.managerModelPageUrl = managerModelPageUrl;
	}

	public int getManagerModelPageModelId() {
		return managerModelPageModelId;
	}

	public void setManagerModelPageModelId(int managerModelPageModelId) {
		this.managerModelPageModelId = managerModelPageModelId;
	}
	
	
}