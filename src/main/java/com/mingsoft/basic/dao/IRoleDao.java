package com.mingsoft.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.mingsoft.basic.entity.RoleEntity;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;

/**
 * 角色持久化层，接口
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IRoleDao extends IBaseDao{
	
	/**
	 * 根据角色名称查询角色
	 * @param roleName 角色名称
	 * @param roleManagerId 角色管理员ID
	 * @return 返回角色实体
	 */
	public RoleEntity queryRoleByRoleName(@Param("roleName")String roleName,@Param("roleManagerId")int roleManagerId);
	
	/**
	 * 根据管理员ID查询角色
	 * @param roleManagerId 管理员ID
	 * @return 返回实体
	 */
	public List<BaseEntity> queryRoleByManagerId(int roleManagerId);
	
	/**
	 * 查询该角色名称在数据库中的存在数
	 * @param roleName 角色实体
	 * @return 返回存在数量
	 */
	public int countRoleName(@Param("roleName")String roleName, @Param("roleManagerId")int roleManagerId);
	
	/**
	 * 分页查询当前管理员所创建的角色
	 * @param roleManagerId 管理员ID
	 * @param pageNo 当前页码
	 * @param pageSize 显示条数
	 * @param orderBy 排序字段
	 * @param order 排序方式,true:asc;fales:desc
	 * @return 返回当前管理员所创建的角色集合
	 */
	public List<BaseEntity> queryByPage(@Param("roleManagerId")int roleManagerId,@Param("pageNo")int pageNo,@Param("pageSize")int pageSize,@Param("orderBy")String orderBy,@Param("order") boolean order);

	/**
	 * 批量删除角色，多条或者一条
	 * @param ids  多条表单集合（id）
	 */
	public void deleteAll(@Param("ids")String[] ids);
	
	/**
	 * 根据管理员id查询角色总数
	 * @param managerId 管理员id
	 * @return 角色总数
	 */
	public int getCountByManagerId(@Param("roleManagerId")int roleManagerId);
}












