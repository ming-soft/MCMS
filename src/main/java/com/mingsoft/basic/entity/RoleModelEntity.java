package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;

/**
 * 角色与模块关联表
 * @author 成卫雄QQ:330216230
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class RoleModelEntity extends BaseEntity {

	/**
	 * 模块编号
	 */
	private int modelId;
	
	/**
	 * 角色编号
	 */
	private int roleId;

	/**
	 *获取 modelId
	 * @return modelId
	 */
	public int getModelId() {
		return modelId;
	}

	/**
	 *设置modelId
	 * @param modelId
	 */
	public void setModelId(int modelId) {
		this.modelId = modelId;
	}

	/**
	 *获取 roleId
	 * @return roleId
	 */
	public int getRoleId() {
		return roleId;
	}

	/**
	 *设置roleId
	 * @param roleId
	 */
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
}
