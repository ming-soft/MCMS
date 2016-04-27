package com.mingsoft.people.biz;

import java.util.List;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.people.constant.e.PeopleAddressEnum;
import com.mingsoft.people.entity.PeopleAddressEntity;
/**
 * 
 * 用户收货地址业务层
 * @author yangxy
 * @version 
 * 版本号：【100-000-000】
 * 创建日期：2015年8月23日 
 * 历史修订：
 */
public interface IPeopleAddressBiz extends IBaseBiz{
	/**
	 * 通过用户id和站点id查询用户收货地址列表
	 * @param peopleId 用户id
	 * @param appId 站点id
	 * @return 收货地址实体
	 */
	List<PeopleAddressEntity> queryListByAppIdAndPeopleId(int peopleId,int appId);
	
	/**
	 * 根据用户收货地址id和站点id删除收货地址
	 * @param peopleAddressId 用户收货地址id
	 * @param appId 站点id
	 */
	void deleteEntity(int peopleAddressId,int appId);
	
	/**
	 * 根据用户id和地址属性得到地址实体
	 * @param peopleId 用户id
	 * @param addressDefault 地址属性(默认为0，非默认为1)
	 * @return 默认用户收货地址
	 */
	PeopleAddressEntity getDefaultEntity(int peopleId,PeopleAddressEnum addressDefault);
}
