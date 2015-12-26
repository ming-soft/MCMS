package com.mingsoft.basic.dao;

import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.ManagerModelPageEntity;

/**
 * 管理员持久化
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IManagerModelPageDao extends IBaseDao {
		/**
		 * 根据模块id和管理员id查找实体信息
		 * @param managerModelPagemanagerId 管理员id
		 * @param managerModelPageModelId 模块id
		 * @return 返回管理员实体
		 */
		ManagerModelPageEntity getByManagerIdAndModelId(@Param("managerModelPagemanagerId")int managerModelPagemanagerId,@Param("managerModelPageModelId")int managerModelPageModelId);
}
