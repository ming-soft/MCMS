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

package com.mingsoft.basic.biz.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.IManagerModelPageBiz;
import com.mingsoft.basic.dao.IManagerModelPageDao;
import com.mingsoft.basic.entity.ManagerModelPageEntity;

/**
 * 管理员模块页面业务层接口实现类，接口，继承IBaseBiz
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service
public class ManagerModelPageBizImpl extends BasicBizImpl implements  IManagerModelPageBiz{
	/**
	 * 声明管理员模块页面持久化层
	 */
	@Autowired
	private IManagerModelPageDao managerModelPageDao;
	
	/**
	 * 获取管理员模块页面持久化层
	 * @return managerModelPageDao 返回管理员模块页面持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return managerModelPageDao;
	}

	@Override
	public ManagerModelPageEntity getByManagerIdAndModelId(
			int managerModelPagemanagerId, int managerModelPageModelId) {
		// TODO Auto-generated method stub
		return managerModelPageDao.getByManagerIdAndModelId(managerModelPagemanagerId, managerModelPageModelId);
	}
	
	
}