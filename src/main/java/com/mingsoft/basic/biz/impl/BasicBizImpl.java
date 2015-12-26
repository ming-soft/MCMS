package com.mingsoft.basic.biz.impl;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.IBasicBiz;
import com.mingsoft.basic.dao.IBasicDao;
import com.mingsoft.basic.entity.BasicEntity;
import com.mingsoft.util.PageUtil;

/**
 * 基本信息的业务层实现类
 * @author 荣繁奎
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("basicBiz")
public  class BasicBizImpl extends BaseBizImpl implements IBasicBiz {
	
	/**
	 * 注入基本信息持久化层
	 */
	@Autowired
	private IBasicDao basicDao;

	/**
	 * 获取基本信息持久化层
	 * @return basicDao 返回基本信息持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return basicDao;
	}

    @Override
    public int saveBasic(BasicEntity basic) {
        basicDao.saveEntity(basic);
        return saveEntity(basic);
    }
    
    @Override
    public void updateBasic(BasicEntity basic) {
        basicDao.updateEntity(basic);
        updateEntity(basic);
    }
    
    @Override
    public void deleteBasic(int basicId) {
        basicDao.deleteEntity(basicId);
        deleteEntity(basicId);
    }
    
    @Override
    public BasicEntity getBasicEntity(int basicId){
    	return (BasicEntity) basicDao.getEntity(basicId);
    }
    
    @Override
	public void deletes(String[] basicIds) {
		// TODO Auto-generated method stub
		basicDao.delete(basicIds);
		delete(basicIds);
	}

	@Override
	public void updateHit(int basicId, Integer num) {
		// TODO Auto-generated method stub
		  basicDao.updateHit(basicId, num);
	}

	@Override
	public int count(int categoryId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int count(int categoryId, String keyWord) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BasicEntity> query(int categoryId) {
		// TODO Auto-generated method stub
		return basicDao.query(null,categoryId, null, null, null, null, null,null,null);
	}

	@Override
	public List<BasicEntity> query(int categoryId, String keyWord) {
		// TODO Auto-generated method stub
		return basicDao.query(null,categoryId, keyWord, null, null, null, null,null,null);
	}

	@Override
	public List<BasicEntity> query(Integer appId,Integer categoryId, String keyWord, PageUtil page,Integer modelId,Map where) {
		// TODO Auto-generated method stub
		if (page==null) {
			return basicDao.query(appId,categoryId, keyWord, null, null, null, null,modelId,where);
		}
		return basicDao.query(appId,categoryId, keyWord, page.getPageSize()*page.getPageNo(), page.getPageSize(), null, null,modelId,where);
	}

	@Override
	public List<BasicEntity> getPreviousAndNext(int basicId) {
		// TODO Auto-generated method stub
		return basicDao.getPreviousAndNext(basicId);
	}

    
}
