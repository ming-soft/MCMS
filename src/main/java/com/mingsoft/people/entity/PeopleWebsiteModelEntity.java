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

package com.mingsoft.people.entity;

import com.mingsoft.base.entity.BaseEntity;

/**
 * 
 * 用户站点模块实体类，继承BaseEntity实体
 * @author 刘继平
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-9-11<br/>
 * 历史修订：<br/>
 */
public class PeopleWebsiteModelEntity extends BaseEntity {

	/**
	 * 用户站点模块的用户ID
	 */
	private int peopleWebsiteModelPeopleId;
	
	/**
	 * 用户站点模块的站点ID
	 */
	private int peopleWebsiteModelWebsiteId;
	
	/**
	 * 用户站点模块的模块ID
	 */
	private int peopleWebsiteModelModelId;

	public int getPeopleWebsiteModelPeopleId() {
		return peopleWebsiteModelPeopleId;
	}

	public void setPeopleWebsiteModelPeopleId(int peopleWebsiteModelPeopleId) {
		this.peopleWebsiteModelPeopleId = peopleWebsiteModelPeopleId;
	}

	public int getPeopleWebsiteModelWebsiteId() {
		return peopleWebsiteModelWebsiteId;
	}

	public void setPeopleWebsiteModelWebsiteId(int peopleWebsiteModelWebsiteId) {
		this.peopleWebsiteModelWebsiteId = peopleWebsiteModelWebsiteId;
	}

	public int getPeopleWebsiteModelModelId() {
		return peopleWebsiteModelModelId;
	}

	public void setPeopleWebsiteModelModelId(int peopleWebsiteModelModelId) {
		this.peopleWebsiteModelModelId = peopleWebsiteModelModelId;
	}


}