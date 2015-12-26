package com.mingsoft.basic.biz;

import java.util.List;
import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.RoleModelEntity;

/**
 * 角色模块关联业务层接口
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IRoleModelBiz extends IBaseBiz{
	
	/**
	 * 保存该角色对应的模块集合
	 * @param roleModelList 集合
	 */
	public void saveEntity(List<RoleModelEntity> roleModelList);
	
	/**
	 * 更新该角色对应的模块集合
	 * @param roleModelList 集合
	 */
	public void updateEntity(List<RoleModelEntity> roleModelList);
}
