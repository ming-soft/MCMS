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

package com.mingsoft.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.entity.ManagerEntity;

/**
 * 管理员持久化
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IManagerDao extends IBaseDao {

	/**
     * 通过账号查询管理员，主要用于登陆模块
     * @param managerName 帐号
     * @return 返回管理员实体
     */
	public ManagerEntity queryManagerByManagerName(String managerName);
	
	/**
	 * 根据用户名修改用户密码
	 * @param manager 管理员实体
	 */
	public void updateUserPasswordByUserName(ManagerEntity manager);	
	
	/**
	 * 统计该管理员帐号在数据库中的存在数
	 * @param managerName 管理员帐号
	 * @return 返回存在数量
	 */
	public String countManagerName(String managerName);
	
	/**
	 * 查询当前登录的管理员的所有子管理员
	 * @return 返回管理员集合
	 */
	public List<BaseEntity> queryAllChildManager(int managerId);
	
	/**
	 * 通过角色ID删除管理员实体
	 * @param managerRoleID 角色ID
	 */
	public void deleteManagerByRoleId(int managerRoleID);
	
	/**
	 * 分页查询当前管理员所创建的角色
	 * @param managerId 管理员ID
	 * @param pageNo 当前页数
	 * @param pageSize 显示条数
	 * @param orderBy 排序字段
	 * @param order 排序方式,true:asc;fales:desc
	 * @return 返回角色集合
	 */
	public List<BaseEntity> queryByPage(@Param("managerId")int managerId,@Param("pageNo")int pageNo,@Param("pageSize")int pageSize,@Param("orderBy")String orderBy,@Param("order") boolean order);


	
}