package com.mingsoft.basic.biz.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.IRoleModelBiz;
import com.mingsoft.basic.dao.IRoleModelDao;
import com.mingsoft.basic.entity.RoleModelEntity;


/**
 * 角色模块关联业务层接口实现类
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("roleModelBiz")
public class RoleModelBizImpl extends BaseBizImpl implements IRoleModelBiz {
	
	/**
	 * 角色模块关联持久化层
	 */
	@Autowired
	private IRoleModelDao roleModelDao;

	/**
	 * 获取角色模块持久化层
	 * @return roleModelDao 返回角色模块持久化层
	 */
	@Override
	public IBaseDao getDao() {
		// TODO Auto-generated method stub
		return roleModelDao;
	}
	
	@Override
	public void saveEntity(List<RoleModelEntity> roleModelList){
		// TODO Auto-generated method stub
		roleModelDao.saveEntity(roleModelList);
	}
	
	@Override
	public void updateEntity(List<RoleModelEntity> roleModelList){
		// TODO Auto-generated method stub
		roleModelDao.updateEntity(roleModelList);
	}
}
