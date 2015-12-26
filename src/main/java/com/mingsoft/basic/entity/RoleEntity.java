package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;

/**
 * 管理员角色表
 * @author 成卫雄QQ:330216230
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class RoleEntity extends BaseEntity {

	/**
	 * 管理员角色自增长Id
	 */
	private int roleId;
	
	/**
	 * 角色名称
	 */
	private String roleName;
	
	/**
	 * 该角色的创建者ID
	 */
	private int roleManagerId;


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

	/**
	 *获取 roleName
	 * @return roleName
	 */
	public String getRoleName() {
		return roleName;
	}

	/**
	 *设置roleName
	 * @param roleName
	 */
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
	/**
	 * 获取rolePeopleId
	 * @return rolePeopleId
	 */
	public int getRoleManagerId() {
		return roleManagerId;
	}

	/**
	 * 设置rolePeopleId
	 * @param rolePeopleId
	 */
	public void setRoleManagerId(int rolePeopleId) {
		this.roleManagerId = rolePeopleId;
	}

}
