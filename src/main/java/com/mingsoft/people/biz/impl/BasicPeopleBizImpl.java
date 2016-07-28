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
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.util.*;
import java.util.*;
import com.mingsoft.people.entity.BasicPeopleEntity;
import com.mingsoft.people.biz.IBasicPeopleBiz;
import com.mingsoft.people.dao.IBasicPeopleDao;

/**
 * 通用用户与信息一对多表管理持久化层
 * @author 铭飞开发团队
 * @version 
 * 版本号：1.0.0<br/>
 * 创建日期：<br/>
 * 历史修订：<br/>
 */
 @Service("basicPeopleBizImpl")
public class BasicPeopleBizImpl extends BaseBizImpl implements IBasicPeopleBiz {

	
	@Autowired
	private IBasicPeopleDao basicPeopleDao;
	
	
		@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return basicPeopleDao;
	} 
	
	@Override
	public List query(BasicPeopleEntity basicPeople) {
		return basicPeopleDao.query(basicPeople);
	}

	@Override
	public void saveBasicPeople(BasicPeopleEntity basicPeople) {
		// TODO Auto-generated method stub
		basicPeople.setBpDatetime(new Date());
		basicPeopleDao.saveEntity(basicPeople);
		saveEntity(basicPeople);
	}

	@Override
	public void deleteBasicPeople(BasicPeopleEntity basicPeople) {
		// TODO Auto-generated method stub
		basicPeopleDao.deleteByEntity(basicPeople);
		deleteEntity(basicPeople);
		
	}	
}