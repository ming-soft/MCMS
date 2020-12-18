/**
 * The MIT License (MIT)
 * Copyright (c) 2020 铭软科技(mingsoft.net)
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

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import net.mingsoft.base.biz.impl.BaseBizImpl;
import net.mingsoft.base.dao.IBaseDao;
import net.mingsoft.basic.util.PinYinUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.dao.ICategoryDao;
import net.mingsoft.cms.dao.IContentDao;
import net.mingsoft.cms.entity.CategoryEntity;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 分类管理持久化层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
 @Service("cmscategoryBizImpl")
 @Transactional(rollbackFor = RuntimeException.class)
public class CategoryBizImpl extends BaseBizImpl<ICategoryDao, CategoryEntity> implements ICategoryBiz {


	@Autowired
	private ICategoryDao categoryDao;

	@Autowired
	private IContentDao contentDao;


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
		//如果用户自己填入了拼音则使用用户的
		if (StrUtil.isNotBlank(categoryEntity.getCategoryPinyin())) {
			pingYin = categoryEntity.getCategoryPinyin();
		}
		CategoryEntity category=new CategoryEntity();
		category.setCategoryPinyin(pingYin);
		Object categoryBizEntity = getEntity(category);
		setParentId(categoryEntity);
		categoryEntity.setCategoryPinyin(pingYin);
		//更新新的父级
		if(StrUtil.isNotBlank(categoryEntity.getCategoryId())&&!"0".equals(categoryEntity.getCategoryId())){
			CategoryEntity parent = getById(categoryEntity.getCategoryId());
			//如果之前是叶子节点就更新
			if(parent.getLeaf()){
				parent.setLeaf(false);
				updateById(parent);
			}
		}
		categoryEntity.setLeaf(false);
		//如果是新增栏目一定是叶子节点
		if (StrUtil.isEmpty(categoryEntity.getId())) {
			categoryEntity.setLeaf(true);
		}
		super.save(categoryEntity);
		//拼音存在则拼接id
		if(categoryBizEntity!=null){
			categoryEntity.setCategoryPinyin(pingYin+categoryEntity.getId());
		}
		CategoryEntity parentCategory = null;
		if (StringUtils.isNotBlank(categoryEntity.getCategoryId())) {
			parentCategory = (CategoryEntity)getById(categoryEntity.getCategoryId());
		}
		//保存链接地址
		String path=ObjectUtil.isNotNull(parentCategory)?parentCategory.getCategoryPath():"";
		categoryEntity.setCategoryPath( path+"/" + categoryEntity.getCategoryPinyin());
		setTopId(categoryEntity);
		super.updateById(categoryEntity);
	}

	private void setParentId(CategoryEntity categoryEntity) {
		String path = "";
		if(StringUtils.isNotEmpty(categoryEntity.getCategoryId())&&Long.parseLong(categoryEntity.getCategoryId())>0) {
			CategoryEntity category = (CategoryEntity)getById(categoryEntity.getCategoryId());
			path = category.getCategoryPath();
			if(StringUtils.isEmpty(category.getCategoryParentIds())) {
				categoryEntity.setCategoryParentIds(category.getId());
			} else {
				categoryEntity.setCategoryParentIds(category.getCategoryParentIds()+","+category.getId());
			}
		}else {
			categoryEntity.setCategoryParentIds(null);
		}
		//保存时先保存再修改链接地址，修改时直接修改
		if(StringUtils.isNotBlank(categoryEntity.getId())) {
			categoryEntity.setCategoryPath(path+ "/" + categoryEntity.getCategoryPinyin());
		}

	}
	private void setChildParentId(CategoryEntity categoryEntity, String topId) {
		CategoryEntity category=new CategoryEntity();
		category.setCategoryId(categoryEntity.getId());
		List<CategoryEntity> list = categoryDao.query(category);
		list.forEach(x->{
			if(StringUtils.isEmpty(categoryEntity.getCategoryParentIds())) {
				x.setCategoryParentIds(categoryEntity.getId());
			} else {
				x.setCategoryParentIds(categoryEntity.getCategoryParentIds()+","+categoryEntity.getId());
			}
			//更新topid
			x.setTopId(topId);
			String path=categoryEntity.getCategoryPath();
			//判断是否有parentIds
			x.setCategoryPath(path+"/"+x.getCategoryPinyin());
			//去除多余的/符号
			super.updateEntity(x);
			setChildParentId(x, topId);
		});
	}

	@Override
	public void updateEntity(CategoryEntity entity) {
		setParentId(entity);
		String pingYin =entity.getCategoryPinyin();
	if(StrUtil.isNotBlank(pingYin)){
		CategoryEntity category=new CategoryEntity();
		category.setCategoryPinyin(pingYin);
		CategoryEntity categoryBizEntity = (CategoryEntity)getEntity(category);
		//拼音存在则拼接id
		if(categoryBizEntity!=null&&!categoryBizEntity.getId().equals(entity.getId())){
			entity.setCategoryPinyin(pingYin+entity.getId());
		}
	}
		setParentLeaf(entity);
		setTopId(entity);
		//如果父级栏目和父级id为空字符串则转化成null
		if (StringUtils.isEmpty(entity.getCategoryId())) {
			entity.setCategoryId(null);
		}
		if (StringUtils.isEmpty(entity.getCategoryParentIds())) {
			entity.setCategoryParentIds(null);
		}
		categoryDao.updateEntity(entity);
		//更新子节点所有父节点id和topid
		//如果本节点的topid为0（顶级栏目）,则把自身的id作为子栏目的topid，非0所有的子栏目和本栏目使用同一个topid
		String topId = entity.getTopId();
		if (topId.equals("0")) {
			topId = entity.getId();
		}
		setChildParentId(entity, topId);
	}


	@Override
	public void update(CategoryEntity entity) {
		super.updateEntity(entity);
	}

	@Override
	public void delete(String categoryId) {
		// TODO Auto-generated method stub
		CategoryEntity category = (CategoryEntity) categoryDao.selectById(categoryId);
		//删除父类
		if(category != null){
			category.setCategoryParentIds(null);
			List<CategoryEntity> childrenList = categoryDao.queryChildren(category);
			List<String> ids = new ArrayList<>();
			for(int i = 0; i < childrenList.size(); i++){
				//删除子类
				ids.add(childrenList.get(i).getId());
			}
			categoryDao.deleteBatchIds(ids);
			// 删除文章
			contentDao.deleteEntityByCategoryIds(ids.toArray(new String[ids.size()]));
		}
	}

	/**
	 * 设置父级叶子节点
	 * @param entity
	 */
	private void setParentLeaf(CategoryEntity entity){
		CategoryEntity categoryEntity = getById(entity.getId());
		//如果父级不为空并且修改了父级则需要更新父级
		if(entity.getCategoryId() != null && !entity.getCategoryId().equals(categoryEntity.getCategoryId())){
			//更新旧的父级
			if(StrUtil.isNotBlank(categoryEntity.getCategoryId())&&!"0".equals(categoryEntity.getCategoryId())){
				CategoryEntity parent = getById(categoryEntity.getCategoryId());
				//如果修改了父级则需要判断父级是否还有子节点
				boolean leaf = parent.getLeaf();
				//查找不等于当前更新的分类子集，有则不是叶子节点
				QueryWrapper<CategoryEntity> queryWrapper = new QueryWrapper<>();
				parent.setLeaf(count(queryWrapper.eq("category_id",parent.getId()).ne("id",entity.getId()))==0);
				if(leaf!=parent.getLeaf()){
					updateById(parent);
				}

			}
			//更新新的父级
			if(StrUtil.isNotBlank(entity.getCategoryId())&&!"0".equals(entity.getCategoryId())){
				CategoryEntity parent = getById(entity.getCategoryId());
				//如果之前是叶子节点就更新
				if(parent.getLeaf()){
					parent.setLeaf(false);
					updateById(parent);
				}
			}
		}
	}

	/**
	 * 设置顶级id
	 * @param entity
	 */
	private void setTopId(CategoryEntity entity){
		String categoryParentId = entity.getCategoryParentIds();
		if(StrUtil.isNotBlank(categoryParentId)){
			String[] ids = categoryParentId.split(",");
			//如果有ParentId就取第一个
			if(ids.length>0){
				entity.setTopId(ids[0]);
				return;
			}
		}
		entity.setTopId("0");
	}

	@Override
	public void copyCategory(CategoryEntity category) {
		String oldId = category.getId();
		//先保存被复制第一层栏目，因为第一层栏目不需要变更父级栏目
		category = getById(oldId);
		//id、拼音和路径按照原来的业务逻辑生成
		category.setId(null);
		category.setCategoryPinyin(null);
		category.setCategoryPath(null);
		saveEntity(category);
		//传入简要被复制子栏目的id和复制后的生成的id，复制的子栏目全部使用
		recursionCopyChilds(oldId, category.getId());
	}

	/*
	* 递归复制子栏目
	* @param oldParentId：被复制的父级栏目id（需要数据库原来存在该数据）
	* @param newParentId：复制栏目后新父级的id（新插入数据的id）
	* */
	private void recursionCopyChilds(String oldParentId, String newParentId) {
		CategoryEntity _category = new CategoryEntity();
		_category.setCategoryId(oldParentId);
		List<CategoryEntity> childs = query(_category);
		for (CategoryEntity child : childs) {
			String childId = child.getId();
			//id、拼音和路径按照原来的业务逻辑生成
			child.setId(null);
			child.setCategoryPinyin(null);
			child.setCategoryPath(null);
			child.setCategoryId(newParentId);
			saveEntity(child);
			//如果该栏目下还有子栏目则继续复制该栏目里的子栏目
			recursionCopyChilds(childId, child.getId());
		}
	}

}
