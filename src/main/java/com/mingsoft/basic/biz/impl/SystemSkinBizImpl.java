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
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.ISystemSkinBiz;
import com.mingsoft.basic.dao.ISystemSkinDao;
import com.mingsoft.basic.entity.SystemSkinEntity;

/**
 * 系统主题业务处理层接口实现
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("systemSkinBiz")
public class SystemSkinBizImpl extends BaseBizImpl implements ISystemSkinBiz{
	/**
	 * 系统主题持久化层
	 */
	@Autowired
	private ISystemSkinDao systemSkinDao;
	
	@Override
	public SystemSkinEntity getByManagerId(int managerId) {
		// TODO Auto-generated method stub
		return systemSkinDao.getByManagerId(managerId);
	}
	
	@Override
	public SystemSkinEntity updateManagerSystemSkin(int managerId,int systemSkinId) {
		// TODO Auto-generated method stub
		SystemSkinEntity sse = systemSkinDao.getByManagerId(managerId);
		if (sse!=null) {
			systemSkinDao.updateManagerSystemSkin(managerId, systemSkinId);
		} else {
			systemSkinDao.saveManagerSystemSkin(managerId, systemSkinId);
		}
		return (SystemSkinEntity)systemSkinDao.getEntity(systemSkinId);
	
	}
	
	/**
	 * 获取系统主题持久化层
	 * @return systemSkinDao 返回系统主题持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return systemSkinDao;
	}

}