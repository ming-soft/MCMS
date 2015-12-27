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
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.BasicEntity;

/**
 * 基本信息的数据层(接口)
 * @author 荣繁奎
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IBasicDao extends IBaseDao {

	/**
	 * 更新点击次数
	 * 
	 * @param basicId 文章编号
	 * @param num null:为递增
	 */
	void updateHit(@Param("basicId") int basicId, @Param("num") Integer num);

	/**
	 * 根据分类与关键子统计总数
	 * 
	 * @param categoryId
	 *            　分类编号
	 * @param keyWord
	 *            关键字
	 * @return　返回总数
	 */
	int count(@Param("categoryId") int categoryId, @Param("keyWord") String keyWord);

	/**
	 * 根据分类与关键子统计总数
	 * @param appId 站点ID
	 * @param categoryId
	 *            　分类编号
	 * @param keyWord
	 *            　关键字
	 * @param begin 开始
	 * @param end　结束
	 * @param orderField　排序字段
	 * @param ad　排序方式true:升序 false:倒序
	 * @param modelId 模块ID
	 * @param where 查询条件
	 * @return　返回列表实体
	 */
	List<BasicEntity> query(@Param("appId") Integer appId,@Param("categoryId") Integer categoryId, @Param("keyWord") String keyWord, @Param("begin") Integer begin, @Param("end") Integer end, @Param("orderField")String orderField, @Param("ad")Boolean ad, @Param("modelId")Integer modelId,@Param("where")Map where);

    /**
     * 获取当前文章basicId的上一篇与下一篇
     * @param basicId 当前文章
     * @return 返回列表实体，list.get(0):上一篇list.get(1): 下一篇
     */
	List<BasicEntity> getPreviousAndNext(int basicId);
	

}