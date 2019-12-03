/**
The MIT License (MIT) * Copyright (c) 2019 铭飞科技

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

package net.mingsoft.cms.biz.impl;

import cn.hutool.core.util.ObjectUtil;
import net.mingsoft.base.entity.BaseEntity;
import net.mingsoft.cms.entity.CategoryEntity;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import net.mingsoft.base.biz.impl.BaseBizImpl;
import net.mingsoft.base.dao.IBaseDao;

import java.io.File;
import java.util.*;

import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.dao.ICategoryDao;

/**
 * 分类管理持久化层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
 @Service("cmscategoryBizImpl")
public class CategoryBizImpl extends BaseBizImpl implements ICategoryBiz {

	
	@Autowired
	private ICategoryDao categoryDao;
	
	
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return categoryDao;
	}

	@Override
	public List<CategoryEntity> queryChilds(CategoryEntity category) {
		// TODO Auto-generated method stub
		return categoryDao.queryChildren(category);
	}
	@Override
	public int saveEntity(CategoryEntity categoryEntity) {
		// TODO Auto-generated method stub
		setParentId(categoryEntity);
		return super.saveEntity(categoryEntity);
	}

	private void setParentId(CategoryEntity categoryEntity) {
		if(StringUtils.isNotEmpty(categoryEntity.getCategoryId())&&Integer.parseInt(categoryEntity.getCategoryId())>0) {
			CategoryEntity category = (CategoryEntity)categoryDao.getEntity(Integer.parseInt(categoryEntity.getCategoryId()));
			if(StringUtils.isEmpty(category.getCategoryParentId())) {
				categoryEntity.setCategoryParentId(category.getId());
			} else {
				categoryEntity.setCategoryParentId(category.getCategoryParentId()+","+category.getId());
			}
		}else {
			categoryEntity.setCategoryParentId(null);
		}
		String path=ObjectUtil.isNotNull(categoryEntity.getCategoryParentId())?categoryEntity.getCategoryParentId():"";
		categoryEntity.setCategoryPath("/"+path.replaceAll(",","/")+"/"+categoryEntity.getId());

	}
	private void setChildParentId(CategoryEntity categoryEntity) {
		CategoryEntity category=new CategoryEntity();
		category.setCategoryId(categoryEntity.getId());
		List<CategoryEntity> list = categoryDao.query(category);
		list.forEach(x->{
			if(StringUtils.isEmpty(categoryEntity.getCategoryParentId())) {
				x.setCategoryParentId(categoryEntity.getId());
			} else {
				x.setCategoryParentId(categoryEntity.getCategoryParentId()+","+categoryEntity.getId());
			}
			String path=ObjectUtil.isNotNull(x.getCategoryParentId())?x.getCategoryParentId():"";
			x.setCategoryPath("/"+path.replaceAll(",","/")+"/"+x.getId());
			super.updateEntity(x);
			setChildParentId(x);
		});
	}

	@Override
	public void updateEntity(CategoryEntity entity) {
		setParentId(entity);
		super.updateEntity(entity);
		setChildParentId(entity);
	}
}