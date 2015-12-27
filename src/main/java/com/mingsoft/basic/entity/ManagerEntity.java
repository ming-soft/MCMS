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
import java.util.Date;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.base.entity.SessionEntity;

/**
 * 管理员实体类
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ManagerEntity extends SessionEntity {

    /**
     * 自增长编号
     */
    private int managerId;

    /**
     * 帐号
     */
    private String managerName;

    /**
     * 昵称
     */
    private String managerNickName;

    /**
     * 密码
     */
    private String managerPassword;

    /**
     * 角色ID
     */
    private int managerRoleID;

    /**
     * 用户ID
     */
    private int managerPeopleID;

    /**
     * 添加时间
     */
    private Date managerTime = new Date();

    /**
     * 获取managerTime
     * @return managerTime
     */
    public Date getManagerTime() {
        return managerTime;
    }

    /**
     * 设置managerTime
     * @param managerTime
     */
    public void setManagerTime(Date managerTime) {
        this.managerTime = managerTime;
    }

    /**
     * 获取managerId
     * @return managerId
     */
    public int getManagerId() {
        return managerId;
    }

    /**
     * 设置managerId
     * @param managerId
     */
    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    /**
     * 获取managerName
     * @return managerName
     */
    public String getManagerName() {
        return managerName;
    }

    /**
     * 设置managerName
     * @param managerName
     */
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    /**
     * 获取managerPassword
     * @return managerPassword
     */
    public String getManagerPassword() {
        return managerPassword;
    }

    /**
     * 设置managerPassword
     * @param managerPassword
     */
    public void setManagerPassword(String managerPassword) {
        this.managerPassword = managerPassword;
    }

    /**
     * 获取managerPeopleID
     * @return managerPeopleID
     */
    public int getManagerPeopleID() {
        return managerPeopleID;
    }

    /**
     * 设置managerPeopleID
     * @param managerPeopleID
     */
    public void setManagerPeopleID(int managerPeopleID) {
        this.managerPeopleID = managerPeopleID;
    }

    /**
     * 获取managerNickName
     * @return managerNickName
     */
    public String getManagerNickName() {
        return managerNickName;
    }

    /**
     * 设置managerNickName
     * @param managerNickName
     */
    public void setManagerNickName(String managerNickName) {
        this.managerNickName = managerNickName;
    }

    /**
     * 获取managerRoleID
     * @return managerRoleID
     */
	public int getManagerRoleID() {
		return managerRoleID;
	}

	/**
	 * 设置managerRoleID
	 * @param managerRoleID
	 */
	public void setManagerRoleID(int managerRoleID) {
		this.managerRoleID = managerRoleID;
	}	
	
}