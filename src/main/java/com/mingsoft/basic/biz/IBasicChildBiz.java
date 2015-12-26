package com.mingsoft.basic.biz;

import java.util.List;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.BasicChildEntity;

/**

 * 基础表之间的子父关联关系业务层接口

 * @author 史爱华 QQ:924690193

 * @version

 * 版本号：100-000-000<br/>

 * 创建日期：2015-08-21<br/>

 * 历史修订：<br/>

 */
public interface IBasicChildBiz extends IBaseBiz{
	
	/**
	 * 根据基础表id删除数据
	 * @param basicId 基础表id
	 */
	void delete(int basicId);
	
	/**
	 * 根据基础表id查询基础表关联数据集合
	 * @param basicId  基础表id
	 * @return  基础表关联数据集合
	 */
	List<BasicChildEntity> queryByBasicId(int basicId);
}
