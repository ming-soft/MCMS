package com.mingsoft.basic.dao;

import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.SystemSkinEntity;

/**
 * 系统主题持久化
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface ISystemSkinDao extends IBaseDao{

	/**
	 * 获取管理员对应的管理皮肤
	 * @param managerId　管理员编号
	 * @return　返回主题实体
	 */
	public SystemSkinEntity getByManagerId(@Param("managerId")int managerId);
	
	/**
	 *更新管理员的后台皮肤
	 * @param managerId　管理员编号
	 * @param systemSkinId　皮肤编号
	 */
	public void updateManagerSystemSkin(@Param("managerId")int managerId,@Param("systemSkinId")int systemSkinId);
	
	/**
	 *保存管理员的后台皮肤
	 * @param managerId　管理员编号
	 * @param systemSkinId　皮肤编号
	 */
	public void saveManagerSystemSkin(@Param("managerId")int managerId,@Param("systemSkinId")int systemSkinId);
}
