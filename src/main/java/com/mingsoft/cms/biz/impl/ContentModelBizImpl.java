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

package com.mingsoft.cms.biz.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.cms.biz.IContentModelBiz;
import com.mingsoft.cms.dao.IContentModelDao;
import com.mingsoft.cms.entity.ContentModelEntity;
import com.mingsoft.util.PageUtil;
@Service("contentModelBiz")
public class ContentModelBizImpl extends BaseBizImpl implements IContentModelBiz{
	
	/**
	 * 内容模型管理业务层
	 */
	private IContentModelDao contentModelDao;
	
	
	/**
	 * 获取内容模型业务层
	 * @return 内容模型业务层
	 */
	public IContentModelDao getContentModelDao() {
		return contentModelDao;
	}

	/**
	 * 设置内容模型业务层
	 * @param contentModelDao 内容模型业务层
	 */
	@Autowired
	public void setContentModelDao(IContentModelDao contentModelDao) {
		this.contentModelDao = contentModelDao;
	}

	
	/**
	 * 根据内容模型的表名查找实体
	 */
	@Override
	public ContentModelEntity getContentModelByTableName(String cmTableName) {
		// TODO Auto-generated method stub
		return (ContentModelEntity) contentModelDao.getContentModelByTableName(cmTableName);
	}
	
	/**
	 * 获取内容模型的dao
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return contentModelDao;
	}
	
	/**
	 * 根据管理员Id查找内容模型的总数
	 * @param cmManagerId 管理员id
	 * @return 记录总数
	 */
	@Override
	public int getContentModelByManagerId(int cmManagerId) {
		// TODO Auto-generated method stub
		return contentModelDao.getContentModelByManagerId(cmManagerId);
	}
	
	/**
	 * 分页查询指定管理员的表单内容模型
	 * @param entity 实体
	 * @param page Map对象
	 * @param order 排序方式,true:asc;fales:desc
	 * @param cmManagerId 管理员id
	 * @return
	 */
	@Override
	public List<BaseEntity> queryPageByManagerId(PageUtil page,
			String orderBy, boolean order, int cmManagerId) {
		// TODO Auto-generated method stub
		return contentModelDao.queryPageByManagerId(page.getPageNo(), page.getPageSize(), orderBy, order, cmManagerId);
	}
	
	/**
	 * 根据管理员id查找内容模型实体
	 * @param cmManagerId
	 * @return
	 */
	@Override
	public List<BaseEntity> queryByManagerId(int cmManagerId) {
		// TODO Auto-generated method stub
		return contentModelDao.queryByManagerId(cmManagerId);
	}
	
	
}