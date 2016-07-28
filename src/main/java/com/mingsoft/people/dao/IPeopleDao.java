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

package com.mingsoft.people.dao;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.people.entity.PeopleEntity;
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
 * Comments:用户持久化层，接口，继承IBaseDao
 * </p>
 *  
 * <p>
 * Create Date:2014-7-29
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public interface IPeopleDao extends IBaseDao {
	
	/**
	 * 根据用户用户名查询用户实体</br>
	 * @param userName 用户名(注:手机号,邮箱,用户名称都可作为用户名登录)
	 * @param appId 应用Id
	 * @return 查询到的用户实体
	 */
	public PeopleEntity getEntityByUserName(@Param("userName")String userName,@Param("appId")int appId);
	
	
	/**
	 * 根据用户用户名查询用户实体</br>
	 * @param userName 用户名(注:手机号,邮箱)
	 * @param appId 应用Id
	 * @return 查询到的用户实体
	 */
	public PeopleEntity getEntityByMailOrPhone(@Param("userName")String userName,@Param("appId")int appId);
	
	/**
	 * 根据用户信息查询对应用户
	 * @param people 用户信息
	 * @param appId 应用id
	 * @return  返回用户
	 */
	public PeopleEntity getByPeople(@Param("people")PeopleEntity people,@Param("appId")int appId);
	
	
	/**
	 * 根据AppId查询用户列表并进行分页
	 * @param appId 应用Id
	 * @param page 分页
	 * @return 用户集合
	 */
	public List<PeopleEntity> queryPageListByAppId(@Param("appId") int appId,@Param("page")PageUtil page);
	
	/**
	 * 根据应用ID查询用户总数
	 * @param appId 应用ID
	 * @return 用户总数
	 */
	public int queryCountByAppId(@Param("appId") int appId);
	
	/**
	 * 根据用户的验证码和用户名（:手机号,邮箱,用户名称都可作为用户名登录）
	 * @param userName
	 * @param peopleCode
	 * @param appId
	 * @return
	 */
	public PeopleEntity getEntityByCode(@Param("userName")String userName,@Param("peopleCode")String peopleCode,@Param("appId")int appId);
	
	/**
	 * 查找总数
	 * @param appId :应用id
	 * @param where  ：查询条件
	 */
	public int getCount(@Param("appId") Integer appId,@Param("where") Map where);
	
	/**
	 * 根据用户id集合批量删除用户
	 * @param peopleIds 用户id集合
	 */
	public void deletePeoples(@Param("peopleIds")int[] peopleIds);
	
	/**
	 * 根据应用id和其他查询条件查询用户列表信息
	 * @param appId 应用id
	 * @param whereMap 其他查询条件 key:字段属性名 value:字段属性值
	 * @return 用户列表信息
	 */
	public List<PeopleEntity> queryByAppIdAndMap(@Param("appId")int appId,@Param("whereMap")Map whereMap,@Param("page")PageUtil page);
	
	/**
	 * 根据应用id和其他查询条件查询用户总数
	 * @param appId 应用id
	 * @param whereMap 其他查询条件 key:字段属性名 value:字段属性值
	 * @return 用户总数
	 */
	int getCountByAppIdAndMap(@Param("appId")int appId,@Param("whereMap")Map whereMap);


	/**
	 * 用户查询
	 * @param appId 应用编号
	 * @param where 查询条件
	 * @return
	 */
	public List<PeopleEntity> query(@Param("appId")int appId, @Param("where")Map where);
}