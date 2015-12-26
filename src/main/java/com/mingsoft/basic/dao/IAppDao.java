package com.mingsoft.basic.dao;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;

/**
 * 网站基本信息持久化层
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IAppDao extends IBaseDao{
	
	/**
	 * 根据域名查找相同域名的个数
	 * @param websiteUrl 域名
	 * @return 返回相同域名的个数
	 */
	int countByUrl(String websiteUrl);
	
	/**
	 * 根据域名查找站点实体
	 * @param websiteUrl 域名
	 * @return 返回站点实体
	 */
	BaseEntity getByUrl(String websiteUrl);
	
	/**
	 * 更据站点管理员id查找站点
	 * @param managerId 管理员id
	 * @return 返回站点实体
	 */
	BaseEntity getByManagerId(int managerId);
}
