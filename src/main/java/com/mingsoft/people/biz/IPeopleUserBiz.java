package com.mingsoft.people.biz;

import com.mingsoft.people.entity.PeopleUserEntity;


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
 * @author 刘继平
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments: 用户信息业务层接口，继承IPeopleBiz接口
 * </p>
 *  
 * <p>
 * Create Date:2014-9-4
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public interface IPeopleUserBiz extends IPeopleBiz {

	/**
	 * 用户信息实体保存</br>
	 * 只能有子类继承时调用的</br>
	 * @param peopleEntity 用户信息
	 * @return 新增成功后用户ID
	 */
	public int savePeopleUser(PeopleUserEntity peopleEntity);
	
	/**
	 * 更新用户信息</br>
	 * 只能在有子类时调用</br>
	 * @param peopleEntity 用户信息
	 */
	public void updatePeopleUser(PeopleUserEntity peopleEntity);
	
	/**
	 * 删除用户信息</br>
	 * 只能在有子类时调用</br>
	 * @param peopleId 用户ID
	 */
	public void deletePeopleUser(int peopleId);
	
	/**
	 * 批量删除用户
	 * @param peopleIds 用户id集合
	 */
	public void deletePeopleUsers(int[] peopleIds);
}
