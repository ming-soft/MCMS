package com.mingsoft.people.dao;


import org.apache.ibatis.annotations.Param;

import com.mingsoft.base.dao.IBaseDao;

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
 * Comments:用户信息持久化层接口，继承IBaseDao
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
public interface IPeopleUserDao extends IBaseDao {
	
	/**
	 * 根据用户id集合批量删除用户
	 * @param peopleIds 用户id集合
	 */
	public void deletePeopleUsers(@Param("peopleIds")int[] peopleIds);
}
