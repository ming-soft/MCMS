/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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