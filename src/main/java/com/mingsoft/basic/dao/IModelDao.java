/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

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

package com.mingsoft.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.entity.ModelEntity;

/**
 * 模块持久化
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IModelDao extends IBaseDao{
	
	/**
	 * 根据父模块id查找子id
	 * @return 返回子模块实体
	 */
	List<BaseEntity> queryChildList(int modelModelId);
	
	/**
	 *查找顶级模块
	 * @return 返回模块实体集合
	 */
	List<BaseEntity> queryParent();
	
	/**
	 * 根据管理员ID查询模块集合
	 * @param modelManagerId 管理员ID
	 * @param modelId 模块ID
	 * @return 返回模块集合
	 */
	List<BaseEntity> queryModelByManagerId(@Param ("modelManagerId") int modelManagerId,@Param ("modelId") int modelId);
	
	/**
	 * 查找管理员Id不为-1的模块
	 * @return 返回模块集合
	 */
	List<BaseEntity> queryModelByManager();
	
	/**
	 * 根据角色ID查询模块集合
	 * @param roleId 角色ID
	 * @return 返回模块集合
	 */
	List<BaseEntity> queryModelByRoleId(int roleId);
	
	/**
	 * 根据模块枚举类查询模块集合
	 * @param modelEnum 模块枚举类的值
	 * @return 返回模块集合
	 */
	List<BaseEntity> queryModelByIsMenu(@Param("modelEnum")int modelEnum);
	
	/**
	 * 根据模块编号查询模块实体
	 * @param modelCode 模块编号
	 * @return 返回模块实体
	 */
	ModelEntity getEntityByModelCode(@Param("modelCode")String modelCode);

	/**
	 * 根据模块id获取当前项目中的分类模块id，规则根据modelcode定。**99******,只用是第３位与第４位９９
	 * @param modelCodeRegex 规则。详细见IModelBiz
	 * @see IModelBiz
	 * @param modelId 模块根id
	 * @return 返回模块集合
	 */
	ModelEntity getModel(@Param("modelCodeRegex") String modelCodeRegex,@Param("modelId") int modelId);
	
}