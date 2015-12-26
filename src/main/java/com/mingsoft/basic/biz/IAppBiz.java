package com.mingsoft.basic.biz;

import com.mingsoft.basic.entity.AppEntity;

/**
 * 网站基本信息业务层接口
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IAppBiz extends IBasicBiz{
	
	/**
	 * 查找域名相同站点的个数
	 * @param websiteUrl 域名
	 * @return 返回站点个数
	 */
	int countByUrl(String websiteUrl);
	
	/**
	 * 根据站点管理员id查找站点
	 * @param managerId 站点管理员id
	 * @return 返回站点实体
	 */
	AppEntity getByManagerId(int managerId);
	/**
	 * 根据站点域名获取站点实体
	 * @param websiteUrl 域名
	 * @return 返回站点实体
	 */
	AppEntity getByUrl(String websiteUrl);
}
