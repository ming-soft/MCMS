package com.mingsoft.people.biz.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.people.biz.IPeopleBiz;
import com.mingsoft.people.dao.IPeopleDao;
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.util.PageUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 姓名：张敏
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:用户业务层实现类，继承BaseBizImpl，实现IPeopleBiz
 * </p>
 *  
 * <p>
 * Create Date:2014-7-29
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Service("peopleBiz")
public class PeopleBizImpl  extends BaseBizImpl implements IPeopleBiz{

	/**
	 * 用户持久化层
	 */
	@Autowired
	private IPeopleDao peopleDao;
	
	/**
	 * 获取peopleDao
	 */
	@Override
	protected IBaseDao getDao() {
		return peopleDao;
	}

	/**
	 * 用户有子类增加
	 */
	@Override
	public int savePeople(PeopleEntity people) {
		peopleDao.saveEntity(people);
	    return saveEntity(people);
	}
	
	/**
	 * 根据用户ID进行用户实体的更新，用于有子类的更新操作
	 * @param entity
	 */	
	@Override
	public void updatePeople(PeopleEntity people) {
		peopleDao.updateEntity(people);
		updateEntity(people);
	}	
	
	/**
	 * 用户删除
	 */
	@Override
	public void deletePeople(int id) {
		peopleDao.deleteEntity(id);
		deleteEntity(id);
	}	
	
	/**
	 * 根据用户用户名查询用户实体</br>
	 * @param userName 用户名(注:手机号,邮箱,用户名称都可作为用户名登录)
	 * @param appId 应用Id
	 * @return 查询到的用户实体
	 */
	public PeopleEntity getEntityByUserName(String userName,int appId){
		return this.peopleDao.getEntityByUserName(userName,appId);
	}	
	
	/**
	 * 根据AppId查询用户列表并进行分页
	 * @param appId 应用Id
	 * @param page 分页
	 * @return 用户集合
	 */
	public List<PeopleEntity> queryPageListByAppId(int appId,PageUtil page){
		return this.peopleDao.queryPageListByAppId(appId,page);
	}
	
	/**
	 * 根据应用ID查询用户总数
	 * @param appId 应用ID
	 * @return 用户总数
	 */
	public int queryCountByAppId(int appId){
		return this.peopleDao.getCount(appId,null);
	}

	@Override
	public PeopleEntity getEntityByCode(String userName, String peopleCode,int appId) {
		// TODO Auto-generated method stub
		return this.peopleDao.getEntityByCode(userName, peopleCode, appId);
	}

	@Override
	public int getCountByDate(String peopleDateTime, Integer appId) {
		// TODO Auto-generated method stub
		Map where = new HashMap();
		where.put("peopleDateTime", peopleDateTime);
		return this.peopleDao.getCount(appId, where);
	}

	@Override
	public void deletePeople(int[] peopleIds) {
		if(peopleIds==null){
			return;
		}
		this.peopleDao.deletePeoples(peopleIds);
	}
	
	
}
