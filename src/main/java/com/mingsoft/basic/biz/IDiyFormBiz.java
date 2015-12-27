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

package com.mingsoft.basic.biz;

import java.util.List;
import java.util.Map;
import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.DiyFormEntity;
import com.mingsoft.util.PageUtil;

/**
 * 自定义表单接口
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IDiyFormBiz extends IBaseBiz{

	/**
	 * 保存自定义表单的数据
	 * @param formId 表单编号
	 * @param params　参数值集合
	 */
	void saveDiyFormData( int formId,Map params);
	
	/**
	 * 查询自定义表单的数据
	 * @param diyFormId　自定义表单ID
	 * @param appId　站点ID
	 * @param page PageUtil实体
	 * @return 返回map fileds:字段列表 list:记录集合
	 */
	Map queryDiyFormData(int diyFormId,int appId,PageUtil page);
	
	/**
	 * 删除记录
	 * @param id　记录编号
	 * @param diyFormId 表单编号
	 */
	void deleteQueryDiyFormData(int id,int diyFormId);
	
	/**
	 * 查询总数
	 * @param diyFormId 表单ID
	 * @param appId 站点ID
	 * @return 返回查询总数
	 */
	int countDiyFormData(int diyFormId,int appId);
	
	/**
	 * 查询列表
	 * @param appId　应用编号
	 * @return 返回列表集合
	 */
	List query(int appId);
	
	/**
	 * 根据表单名称获取表单实体
	 * @param diyFormTableName 表单名称
	 * @return 返回表单实体
	 */
	DiyFormEntity  getByTableName(String diyFormTableName);
	
	/**
	 * 创建表
	 * @param table 表名称
	 * @param fileds Map,key:字段名称  list[0] 类型  list[1]长度 list[2]默认值 list[3]是否不填
	 */
	@SuppressWarnings("rawtypes")
	void createDiyFormTable(String table,Map<Object,List> fileds);
	
	/**
	 * 多选删除
	 * @param ids 前端传来的勾选的checkbox的序列化id值
	 */
	void deleteAll(String[] ids);
}