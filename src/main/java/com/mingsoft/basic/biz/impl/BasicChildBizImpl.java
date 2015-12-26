package com.mingsoft.basic.biz.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.IBasicChildBiz;
import com.mingsoft.basic.dao.IBasicChildDao;
import com.mingsoft.basic.entity.BasicChildEntity;

/**

 * 基础表之间的子父关联关系业务层实现类

 * @author 史爱华 QQ:924690193

 * @version

 * 版本号：100-000-000<br/>

 * 创建日期：2015-08-21<br/>

 * 历史修订：<br/>

 */
@Service("basicChildBiz")
public class BasicChildBizImpl  extends BaseBizImpl implements IBasicChildBiz{
	
	/**
	 * 基础表之间的子父关联关系持久层
	 */
	@Autowired
	private IBasicChildDao basicChildDao;
	
	@Override
	public void delete(int basicId) {
		// TODO Auto-generated method stub
		basicChildDao.delete(basicId);
	}

	@Override
	public List<BasicChildEntity> queryByBasicId(int basicId) {
		// TODO Auto-generated method stub
		return basicChildDao.queryByBasicId(basicId);
	}

	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return basicChildDao;
	}

}
