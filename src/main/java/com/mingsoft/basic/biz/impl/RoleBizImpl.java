package com.mingsoft.basic.biz.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IRoleBiz;
import com.mingsoft.basic.dao.IRoleDao;
import com.mingsoft.basic.entity.RoleEntity;
import com.mingsoft.util.PageUtil;

/**
 * 角色业务层接口实现类
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("roleBiz")
public class RoleBizImpl extends BaseBizImpl implements IRoleBiz {
	
	/**
	 * 注入角色持久化层
	 */
	@Autowired
	private IRoleDao roleDao;

	/**
	 * 获取角色持久化层
	 * @return roleDao 返回角色持久化层
	 */
	@Override
	public IBaseDao getDao() {
		return roleDao;
	}
	
	@Override
	public RoleEntity queryRoleByRoleName(String roleName,int roleManagerId){
		return roleDao.queryRoleByRoleName(roleName, roleManagerId);
	}
	
	@Override
	public List<BaseEntity> queryRoleByManagerId(int roleManagerId){
		return roleDao.queryRoleByManagerId(roleManagerId);
	}
	
	@Override
	public int countRoleName(String roleName, int roleManagerId){
		return roleDao.countRoleName(roleName,roleManagerId);
	}
	
	@Override
	public List<BaseEntity> queryByPage(int roleManagerId, PageUtil page,String orderBy,boolean order){
		return roleDao.queryByPage(roleManagerId, page.getPageNo(),page.getPageSize(), orderBy, order);
	}
	
	@Override
	public void deleteAll(String[] ids) {
		// TODO Auto-generated method stub
		roleDao.deleteAll(ids);
	}

	@Override
	public int getCountByManagerId(int managerId) {
		// TODO Auto-generated method stub
		return roleDao.getCountByManagerId(managerId);
	}
	
	
}
