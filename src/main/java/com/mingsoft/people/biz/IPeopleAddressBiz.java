/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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