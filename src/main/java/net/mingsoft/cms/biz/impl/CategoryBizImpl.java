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
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.util.PinYinUtil;
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
	public void saveEntity(CategoryEntity categoryEntity) {
		// TODO Auto-generated method stub
		String pingYin = PinYinUtil.getPingYin(categoryEntity.getCategoryTitle());
		CategoryEntity category=new CategoryEntity();
		category.setCategoryPinyin(pingYin);
		category.setAppId(BasicUtil.getAppId());
		Object categoryBizEntity = getEntity(category);
		setParentId(categoryEntity);
		categoryEntity.setCategoryPinyin(pingYin);
		super.saveEntity(categoryEntity);
		//拼音存在则拼接id
		if(categoryBizEntity!=null){
			categoryEntity.setCategoryPinyin(pingYin+categoryEntity.getId());
		}
		CategoryEntity parentCategory = (CategoryEntity)categoryDao.getEntity(Integer.parseInt(categoryEntity.getCategoryId()));
		//保存链接地址
		String path=ObjectUtil.isNotNull(parentCategory)?categoryEntity.getCategoryPath():"";
		categoryEntity.setCategoryPath( path+"/" + categoryEntity.getCategoryPinyin());
		super.updateEntity(categoryEntity);
	}

	private void setParentId(CategoryEntity categoryEntity) {
		String path = "";
		if(StringUtils.isNotEmpty(categoryEntity.getCategoryId())&&Integer.parseInt(categoryEntity.getCategoryId())>0) {
			CategoryEntity category = (CategoryEntity)categoryDao.getEntity(Integer.parseInt(categoryEntity.getCategoryId()));
			path = category.getCategoryPath();
			if(StringUtils.isEmpty(category.getCategoryParentId())) {
				categoryEntity.setCategoryParentId(category.getId());
			} else {
				categoryEntity.setCategoryParentId(category.getCategoryParentId()+","+category.getId());
			}
		}else {
			categoryEntity.setCategoryParentId(null);
		}
		//保存时先保存再修改链接地址，修改时直接修改
		if(StringUtils.isNotBlank(categoryEntity.getId())) {
			categoryEntity.setCategoryPath(path+ "/" + categoryEntity.getCategoryPinyin());
		}

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
			String path=categoryEntity.getCategoryPath();
			//判断是否有parentIds
			x.setCategoryPath(path+"/"+x.getCategoryPinyin());
			super.updateEntity(x);
			setChildParentId(x);
		});
	}

	@Override
	public void updateEntity(CategoryEntity entity) {
		setParentId(entity);
		String pingYin = PinYinUtil.getPingYin(entity.getCategoryTitle());
		CategoryEntity category=new CategoryEntity();
		category.setCategoryPinyin(pingYin);
		category.setAppId(BasicUtil.getAppId());
		CategoryEntity categoryBizEntity = (CategoryEntity)getEntity(category);
		//拼音存在则拼接id
		if(categoryBizEntity!=null&&!categoryBizEntity.getId().equals(entity.getId())){
			entity.setCategoryPinyin(pingYin+entity.getId());
		}
		super.updateEntity(entity);
		setChildParentId(entity);
	}

	@Override
	public void update(CategoryEntity entity) {
		super.updateEntity(entity);
	}

	@Override
	public void delete(int categoryId) {
		// TODO Auto-generated method stub
		CategoryEntity category = (CategoryEntity) categoryDao.getEntity(categoryId);
		//删除父类
		if(category != null){
			category.setCategoryParentId(null);
			List<CategoryEntity> childrenList = categoryDao.queryChildren(category);
			int[] ids = new int[childrenList.size()];
			for(int i = 0; i < childrenList.size(); i++){
				//删除子类
				ids[i] = Integer.parseInt(childrenList.get(i).getId());
			}
			categoryDao.delete(ids);
			deleteEntity(categoryId);
		}
	}
}
