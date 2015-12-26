package com.mingsoft.basic.biz.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.IBasicCategoryBiz;
import com.mingsoft.basic.dao.IBasicCategoryDao;
import com.mingsoft.basic.entity.BasicCategoryEntity;

/**
 * 类别基础信息关联业务层
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("basicCategoryBizImpl")
public class BasicCategoryBizImpl extends BaseBizImpl implements IBasicCategoryBiz{
	
	/**
	 * 注入分类关联持久化层
	 */
	@Autowired
	private IBasicCategoryDao basicCategoryDao;
	
	
	@Override
	public void updateBatch(List<BasicCategoryEntity> basicCategoryList) {
		// TODO Auto-generated method stub
		basicCategoryDao.updateBatch(basicCategoryList);
	}

	/**
	 * 获取分类关联持久化层
	 * @return basicCategoryDao 返回分类关联持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return basicCategoryDao;
	}

	@Override
	public List<BasicCategoryEntity> queryByBasicId(int bcBasicId) {
		// TODO Auto-generated method stub
		return basicCategoryDao.queryByBasicId(bcBasicId);
	}

	@Override
	public List<Integer> queryBasicIdsByCategoryId(int[] categoryIds) {
		// TODO Auto-generated method stub
		if(categoryIds==null || categoryIds.length<1){
			return null;
		}
		return basicCategoryDao.queryBasicIdsByCategoryId(categoryIds,categoryIds.length);
	}

}
