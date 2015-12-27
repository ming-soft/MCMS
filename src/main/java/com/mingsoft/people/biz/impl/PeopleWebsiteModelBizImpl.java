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

package com.mingsoft.people.biz.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.people.biz.IPeopleWebsiteModelBiz;
import com.mingsoft.people.dao.IPeopleWebsiteModelDao;
import com.mingsoft.people.entity.PeopleWebsiteModelEntity;

@Service("peopleWebsiteModelBiz")
public class PeopleWebsiteModelBizImpl extends BaseBizImpl implements IPeopleWebsiteModelBiz {

	/**
	 * 用户站点模块持久化层注入
	 */
	@Autowired
	private IPeopleWebsiteModelDao peopleWebsiteModelDao;
	
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return peopleWebsiteModelDao;
	}

	/**
	 * 根据用户站点模块实体删除据用户站点模块字段
	 * @param peopleWebsiteModel
	 */
	public void deleteEntity(PeopleWebsiteModelEntity peopleWebsiteModel ){
		peopleWebsiteModelDao.deleteEntity(peopleWebsiteModel);
	}
	
}