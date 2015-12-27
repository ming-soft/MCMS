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
import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.dao.IAppDao;
import com.mingsoft.basic.entity.AppEntity; 

/**
 * 网站基本信息业务层实现类
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("appBiz")
public class AppBizImpl extends BasicBizImpl implements IAppBiz{
	
	/**
	 * 声明IAppDao持久化层
	 */
	@Autowired
	private IAppDao appDao;
	
	
	@Override
	public AppEntity getByManagerId(int managerId) {
		// TODO Auto-generated method stub
		return (AppEntity) appDao.getByManagerId(managerId);
	}

	/**
	 * 获取应用持久化层
	 * @return appDao 返回应用持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return appDao;
	}
	
	@Override
	public int countByUrl(String websiteUrl) {
		// TODO Auto-generated method stub
		return appDao.countByUrl(websiteUrl);
	}
	
	@Override
	public AppEntity getByUrl(String url) {
		// TODO Auto-generated method stub
		return (AppEntity) appDao.getByUrl(url);
	}
	
}