package com.mingsoft.cms.biz.impl;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.impl.BasicBizImpl;
import com.mingsoft.cms.biz.ISearchBiz;
import com.mingsoft.cms.dao.ISearchDao;
import com.mingsoft.cms.entity.SearchEntity;
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
 * Comments:搜索业务层实现类，继承BasicBizImpl，实现ISearchBiz
 * </p>
 *  
 * <p>
 * Create Date:2014-9-11
 * </p>
 *
 * <p>
 * Modification history:暂无
 * </p>
 */
@Service("searchBiz")
public class SearchBizImpl extends BasicBizImpl implements ISearchBiz{

	/**
	 * 搜索持久化层
	 */
	@Autowired
	private ISearchDao searchDao;
	
	/**
	 * 获取searchDao
	 */
	@Override
	protected IBaseDao getDao() {
		return searchDao;
	}
	
	/**
	 * 通过数字区域来查询数据集合
	 * @param cmTableName 表名
	 * @param fieldFieldName 字段名
	 * @param preNum 第一个数
	 * @param nextNum 第二个数
	 * @return 返回数据集合
	 */
	@SuppressWarnings("rawtypes")
	public Map queryMapByNumArea(String cmTableName,String fieldFieldName,int preNum,int nextNum){
		return searchDao.queryMapByNumArea(cmTableName, fieldFieldName, preNum, nextNum);
	}
	
	/**
	 * 查询列表
	 * @param appId　应用编号
	 * @param page　分页
	 */
	@Override
	public List query( int appId,PageUtil page) {
		return searchDao.query(appId,page.getPageNo()*page.getPageSize(),page.getPageSize());
	}
	
	
	/**
	 * 
	 */
	@Override
	public SearchEntity getByIdAndAppId(int id, int appId) {
		return searchDao.getByIdAndAppId(id, appId);
	}

	@Override
	public int queryCount(int appId) {
		return searchDao.queryCount(appId);
	}
}
