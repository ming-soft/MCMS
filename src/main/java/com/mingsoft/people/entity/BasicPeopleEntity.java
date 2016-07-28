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

package com.mingsoft.people.entity;

import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.util.*;
import java.util.*;

 /**
 * 通用用户与信息一对多表实体
 * @author 铭飞开发团队
 * @version 
 * 版本号：1.0.0<br/>
 * 创建日期：<br/>
 * 历史修订：<br/>
 */
public class BasicPeopleEntity extends BaseEntity {

	private static final long serialVersionUID = 1464746805910L;

	private int bpId; 
	/**
	 * 信息编号
	 */
	private java.lang.Integer bpBasicId; 
	/**
	 * 用户编号
	 */
	private java.lang.Integer bpPeopleId; 
	
	
	/**
	 * 用户信息
	 */
	private PeopleUserEntity peopleUser;
	
	/**
	 * 创建时间
	 */
	private java.util.Date bpDatetime; 
	
	/**
	 * 设置信息编号
	 */
	public void setBpBasicId(java.lang.Integer bpBasicId) {
		this.bpBasicId = bpBasicId;
	}

	/**
	 * 获取信息编号
	 */
	public java.lang.Integer getBpBasicId() {
		return this.bpBasicId;
	}
	
	/**
	 * 设置用户编号
	 */
	public void setBpPeopleId(java.lang.Integer bpPeopleId) {
		this.bpPeopleId = bpPeopleId;
	}

	/**
	 * 获取用户编号
	 */
	public java.lang.Integer getBpPeopleId() {
		return this.bpPeopleId;
	}
	
	/**
	 * 设置创建时间
	 */
	public void setBpDatetime(java.util.Date bpDatetime) {
		this.bpDatetime = bpDatetime;
	}

	/**
	 * 获取创建时间
	 */
	public java.util.Date getBpDatetime() {
		return this.bpDatetime;
	}

	public PeopleUserEntity getPeopleUser() {
		return peopleUser;
	}

	public void setPeopleUser(PeopleUserEntity peopleUser) {
		this.peopleUser = peopleUser;
	}
	
	
	
}