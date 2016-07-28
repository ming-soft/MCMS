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
import java.util.Map;

import com.mingsoft.people.entity.PeopleStudentEntity;
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
 * @author 史爱华
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments: 学生信息业务层接口，继承IPeopleBiz接口
 * </p>
 *  
 * <p>
 * Create Date:2014-12-19
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public interface IPeopleStudentBiz  extends IPeopleBiz {
	/**
	 * 学生信息实体保存</br>
	 * 只能有子类继承时调用的</br>
	 * @param peopleStudentEntity 用户信息
	 * @return 新增成功后用户ID
	 */
	public int savePeopleStudent(PeopleStudentEntity peopleStudentEntity);
	
	/**
	 * 更新学生信息</br>
	 * 只能在有子类时调用</br>
	 * @param peopleStudentEntity 学生信息
	 */
	public void updatePeopleStudent(PeopleStudentEntity peopleStudentEntity);
	
	/**
	 * 删除学生信息</br>
	 * 只能在有子类时调用</br>
	 * @param peopleId 用户ID
	 */
	public void deletePeopleStudent(int peopleId);
	
	/**
	 * 查询学生信息
	 * @param peopleId
	 * @return 学生实体
	 */
	public PeopleStudentEntity getPeopleStudent(int peopleId);
	
	/**
	 * 查询app下学生的信息
	 * @param appId 应用id
	 * @param page 分页对象
	 * @return 学生列表信息
	 */
	public List<PeopleStudentEntity> queryListPageByAppId(Integer appId ,PageUtil page);
	
	/**
	 * 根据用户id查找学生的具体信息
	 * @param peopleId
	 * @return 学生信息
	 */
	public Map getStudentInfor(Integer peopleId);
	
	/**
	 * 根据条件查询总数
	 * @param appId 应用id
	 * @param page 分页对象
	 * @param where 查询条件
	 * 	key:依据查询字段 value:字段值
	 * @return 学生列表信息
	 */
	public List<PeopleStudentEntity> queryByMap(Integer appId ,PageUtil page,Map where);
	
	/**
	 * 根据条件查询总数
	 * @param appId 应用id
	 * @param where
	 * key:依据查询字段 value:字段值
	 * @return 符合条件的学生总数
	 */
	public int getCountByMap(Integer appId ,Map where);
}