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

package com.mingsoft.people.biz.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.people.biz.IPeopleOpenBiz;
import com.mingsoft.people.dao.IPeopleDao;
import com.mingsoft.people.dao.IPeopleOpenDao;
import com.mingsoft.people.dao.IPeopleUserDao;
import com.mingsoft.people.entity.PeopleOpenEntity;

/**
 * 开发平台用户
 * 
 * @author 王天培
 * @version 版本号：100-000-000<br/>
 *          创建日期：2016年1月25日<br/>
 *          历史修订：<br/>
 */
@Service("peopleOpenBizImpl")
public class PeopleOpenBizImpl extends PeopleUserBizImpl implements IPeopleOpenBiz {

	@Autowired
	private IPeopleOpenDao peopleOpenDao;
	
	/**
	 * 用户信息持久化层注入
	 */
	@Autowired
	private IPeopleUserDao peopleUserDao; 
	
	
	@Autowired
	private IPeopleDao peopleDao; 

	@Override
	protected IBaseDao getDao() {
		return peopleOpenDao;
	}

	@Override
	public void savePeopleOpen(PeopleOpenEntity peopleOpen) {
		// TODO Auto-generated method stub
		peopleDao.saveEntity(peopleOpen);
		peopleUserDao.saveEntity(peopleOpen);
		peopleOpenDao.saveEntity(peopleOpen);
	}

	@Override
	public PeopleOpenEntity getByOpenId(String openId) {
		// TODO Auto-generated method stub
		return  peopleOpenDao.getByOpenId(openId);
	}

}