package com.mingsoft.basic.biz;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.ManagerModelPageEntity;

/**
 * 管理员模块页面业务层，接口，继承IBaseBiz
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IManagerModelPageBiz extends IBaseBiz {
	
	/**
	 * 根据模块id和管理员id查找实体信息
	 * @param managerModelPagemanagerId 管理员id
	 * @param managerModelPageModelId 模块id
	 * @return 返回管理员实体
	 */
	ManagerModelPageEntity getByManagerIdAndModelId(int managerModelPagemanagerId,int managerModelPageModelId);
}
