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
