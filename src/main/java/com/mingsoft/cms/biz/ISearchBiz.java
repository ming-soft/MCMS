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

package com.mingsoft.cms.biz;
import java.util.List;
import java.util.Map;

import com.mingsoft.basic.biz.IBasicBiz;
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
 * Comments:搜索业务层，继承IBasicBiz
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
public interface ISearchBiz extends IBasicBiz{
	
	/**
	 * 通过数字区域来查询数据集合
	 * @param cmTableName 表名
	 * @param fieldFieldName 字段名
	 * @param preNum 第一个数
	 * @param nextNum 第二个数
	 * @return 返回数据集合
	 */
	@SuppressWarnings("rawtypes")
	public Map queryMapByNumArea(String cmTableName,String fieldFieldName,int preNum,int nextNum);
	
	/**
	 * 查询列表
	 * @param appId　应用编号
	 * @param page　分页
	 * @return 查询列表
	 */
	public List query( int appId,PageUtil page);
	
	/**
	 * 通过id与应用id获取搜索
	 * @param id　主键
	 * @param appId　应用编号
	 * @return　搜索实体
	 */
	public SearchEntity getByIdAndAppId( int  id, int appId);

	/**
	 * 根据appid查询总条数
	 * @param appId 应用id
	 * @return 总数
	 */
	public int queryCount(int appId);
}