package com.mingsoft.basic.biz;
import java.util.List;


import com.mingsoft.basic.entity.RoleEntity;
import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.util.PageUtil;

/**
 * 角色业务层，接口，继承IBaseBiz
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IRoleBiz extends IBaseBiz{
	
	/**
	 * 根据角色名称查询角色
	 * @param roleName 角色名称
	 * @param roleManagerId 角色管理员ID
	 * @return 返回角色实体
	 */
	public RoleEntity queryRoleByRoleName(String roleName,int roleManagerId);
	
	/**
	 * 根据管理员ID查询角色
	 * @param roleManagerId 管理员ID
	 * @return 返回角色实体集合
	 */
	public List<BaseEntity> queryRoleByManagerId(int roleManagerId);
	
	/**
	 * 统计该角色名称在数据库中的存在数
	 * @param roleName 角色实体
	 * @param roleManagerId 管理员ID
	 * @return 返回存在数量
	 */
	public int countRoleName(String roleName, int roleManagerId);

	/**
	 * 分页查询当前管理员所创建的角色
	 * @param roleManagerId 管理员ID
	 * @param page PageUtil实体
	 * @param orderBy 排序字段
	 * @param order 排序方式,true:asc;fales:desc
	 * @return 返回返回角色实体集合
	 */
	public List<BaseEntity> queryByPage(int roleManagerId, PageUtil page,String orderBy,boolean order);
	
	/**
	 * 多选删除
	 * @param ids 前端传来的勾选的checkbox的序列化id值
	 */
	public void deleteAll(String[] ids);
	
	/**
	 * 根据管理员id查询角色总数
	 * @param managerId 管理员id
	 * @return 角色总数
	 */
	public int getCountByManagerId(int managerId);
}
