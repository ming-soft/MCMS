package com.mingsoft.people.dao;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.people.entity.PeopleOpenEntity;

/**
 * 开发平台用户 
 * @author 肥猪
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2016年1月25日<br/>
 * 历史修订：<br/>
 */
public interface IPeopleOpenDao extends IBaseDao{

	/**
	 * 根据平台openid读取用户编号
	 * @param openId 平台openid信息
	 * @return null没有找到数据
	 */
	PeopleOpenEntity getByOpenId(String openId);
}
