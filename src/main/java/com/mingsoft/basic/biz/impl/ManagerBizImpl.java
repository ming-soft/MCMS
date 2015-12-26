package com.mingsoft.basic.biz.impl;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.dao.IManagerDao;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.util.PageUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 姓名：张敏
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:管理员业务层实现类，继承BaseBizImpl，实现IManagerBiz
 * </p>
 *  
 * <p>
 * Create Date:2014-7-14
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Service("managerBiz")
public class ManagerBizImpl extends BaseBizImpl implements IManagerBiz {

	/**
	 * 注入管理员持久化层
	 */
    private IManagerDao managerDao;
    
    /**
	 * 获取管理员持久化层
	 * @return managerDao 返回管理员持久化层
	 */
    public IManagerDao getManagerDao() {
        return managerDao;
    }

    /**
	 * 设置managerDao
	 * @param managerDao 管理员持久化层
	 */
    @Autowired
    public void setManagerDao(IManagerDao managerDao) {
    	// TODO Auto-generated method stub
       this.managerDao = managerDao;
    }

	/**
	 * 获取管理员持久化层
	 * @return managerDao 返回管理员持久化层
	 */
    @Override
    public IBaseDao getDao() {
    	// TODO Auto-generated method stub
       return managerDao;
    }

    @Override
    public ManagerEntity queryManagerByManagerName(String managerName) {
    	// TODO Auto-generated method stub
        return managerDao.queryManagerByManagerName(managerName);
    }
    
	@Override
	public void updateUserPasswordByUserName(ManagerEntity manager) {
		// TODO Auto-generated method stub
		managerDao.updateUserPasswordByUserName(manager);
	}
	
	@Override
	public String countManagerName(String managerName){
		// TODO Auto-generated method stub
		return managerDao.countManagerName(managerName);
	}
	
	@Override
	public List<BaseEntity> queryAllChildManager(int managerId){
		// TODO Auto-generated method stub
		return managerDao.queryAllChildManager(managerId);
	}
	
	@Override
	public void deleteManagerByRoleId(int managerRoleID){
		// TODO Auto-generated method stub
		managerDao.deleteManagerByRoleId(managerRoleID);
	}
	
	@Override
	public List<BaseEntity> queryByPage(int managerId, PageUtil page,String orderBy,boolean order){
		// TODO Auto-generated method stub
		return managerDao.queryByPage(managerId, page.getPageNo(),page.getPageSize(), orderBy, order);
	}

	
	
}
