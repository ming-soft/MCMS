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
