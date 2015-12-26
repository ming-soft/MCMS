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
