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
