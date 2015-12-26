package com.mingsoft.basic.biz;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.SystemSkinEntity;

/**
 * 系统主题业务处理层接口
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface ISystemSkinBiz extends IBaseBiz{

	/**
	 * 获取管理员对应的管理皮肤
	 * @param managerId　管理员编号
	 * @return　返回主题实体
	 */
	SystemSkinEntity getByManagerId(int managerId);
	
	/**
	 *设置管理员的后台皮肤
	 * @param managerId　管理员编号
	 * @param systemSkinId　皮肤编号
	 */
	SystemSkinEntity updateManagerSystemSkin(int managerId,int systemSkinId);
	
	
}
