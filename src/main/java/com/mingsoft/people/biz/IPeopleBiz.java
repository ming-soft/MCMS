package com.mingsoft.people.biz;

import java.util.List;

import com.mingsoft.base.biz.IBaseBiz;
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
 * Comments:用户业务层，继承IBaseBiz
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
public interface IPeopleBiz  extends IBaseBiz{

	/**
	 * 用户有子类添加
	 * @param entity 用户实体
	 * @return 用户ID
	 */
	public int savePeople(PeopleEntity people);	
	
	
	/**
	 * 根据用户ID进行用户实体的更新，用于有子类的更新操作
	 * @param entity 用户实体
	 */
	public void updatePeople(PeopleEntity people);	
	
	/**
	 * 根据用户ID删除用户实体，用于有子类的删除操作
	 * @param id 用户ID
	 */
	public void deletePeople(int id);	
	
	/**
	 * 根据用户用户名查询用户实体</br>
	 * @param userName 用户名(注:手机号,邮箱,用户名称都可作为用户名登录)
	 * @param appId 应用Id
	 * @return 查询到的用户实体
	 */
	public PeopleEntity getEntityByUserName(String userName,int appId);
	
	/**
	 * 根据AppId查询用户列表并进行分页
	 * @param appId 应用Id
	 * @param page 分页
	 * @return 用户集合
	 */
	public List<PeopleEntity> queryPageListByAppId(int appId,PageUtil page);
	
	/**
	 * 根据应用ID查询用户总数
	 * @param appId 应用ID
	 * @return 用户总数
	 */
	public int queryCountByAppId(int appId);
	
	/**
	 * 根据用户名(帐号,手机,邮箱)和验证码查询用户信息开始
	 * @param userName 用户名
	 * @param peopleCode 验证码
	 * @param appId 应用id
	 * @return 用户实体
	 */
	public PeopleEntity getEntityByCode(String userName,String peopleCode,int appId);
	
	/**
	 * 根据注册时间和应用id查询总数
	 * @param peopleDateTime
	 * @param appId 应用id
	 * @return 用户总数
	 */
	public int getCountByDate(String peopleDateTime,Integer appId);
	
	/**
	 * 批量删除用户
	 * @param peopleIds 用户id集合
	 */
	public void deletePeople(int[] peopleIds);
}
