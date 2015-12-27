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
import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.BasicCategoryEntity;

/**
 * 类别基础信息关联业务层接口
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IBasicCategoryBiz extends IBaseBiz{
	
	/**
	 * 批量更新基础分类关联表
	 * @param basicCategoryList 基础分类列表实体
	 */
	void updateBatch(List<BasicCategoryEntity> basicCategoryList);
	
	/**
	 * 根据baiscId查询基础分类关联信息
	 * @param bcBasicId 基础basicId
	 * @return 返回基础分类关联列表信息
	 */
	List<BasicCategoryEntity> queryByBasicId(int bcBasicId);
	
	/**
	 * 根据分类id集合去查询符合条件的basicId集合
	 * @param categoryIds 分类id集合
	 * @return 返回basicId集合
	 */
	List<Integer> queryBasicIdsByCategoryId(int[] categoryIds);
}