package com.mingsoft.people.dao;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.people.entity.PeopleWebsiteModelEntity;

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
 * Comments: 用户站点模块持久化层接口，继承IBaseDao接口
 * </p>
 *  
 * <p>
 * Create Date:2014-9-11
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public interface IPeopleWebsiteModelDao extends IBaseDao {

	/**
	 * 根据用户站点模块实体删除据用户站点模块字段
	 * @param peopleWebsiteModel
	 */
	public void deleteEntity(PeopleWebsiteModelEntity peopleWebsiteModel );
	
	/**
	 * 根据用户Id删除用户站点模块中间表数据集合
	 * @param peopleId
	 */
	public void deleteByPeopleId(int peopleId);
	
}
