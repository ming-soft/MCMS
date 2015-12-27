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

package com.mingsoft.basic.entity;

import java.sql.Timestamp;
import com.mingsoft.base.entity.BaseEntity;

/**
 * 类别实体
 * @author 荣繁奎
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class CategoryEntity extends BaseEntity {

	/**
	 * 类别的编号自增长id
	 */
	private int categoryId;
	
	/**
	 * 类别的标题
	 */
	private String categoryTitle;
	
	/**
	 * 类别的排序
	 */
	private int categorySort;
	
	/**
	 * 类别发布时间
	 */
	private Timestamp categoryDateTime;
	
	/**
	 * 发布用户编号(发布者编号)
	 */
	private int categoryManagerId;
	
	/**
	 * 所属模块编号
	 */
	private int categoryModelId;



	/**
	 * 父类别的编号
	 */
	private int categoryCategoryId;
	
	/**
	 * 缩略图
	 */
	private String categorySmallImg;
	
	/**
	 * 分类所属应用编号
	 */
	private int categoryAppId;
	
	/**
	 * 栏目描述
	 */
	private String categoryDescription;
	
	

	public String getCategoryDescription() {
		return categoryDescription;
	}

	public void setCategoryDescription(String categoryDescription) {
		this.categoryDescription = categoryDescription;
	}

	public CategoryEntity() {
		super();
	}
	
	public CategoryEntity(int categoryId,String categoryTitle) {
		this.categoryId = categoryId;
		this.categoryTitle = categoryTitle;
	}

	public int getCategoryAppId() {
		return categoryAppId;
	}

	public void setCategoryAppId(int categoryAppId) {
		this.categoryAppId = categoryAppId;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryTitle() {
		return categoryTitle;
	}

	public void setCategoryTitle(String categoryTitle) {
		this.categoryTitle = categoryTitle;
	}

	public int getCategorySort() {
		return categorySort;
	}

	public void setCategorySort(int categorySort) {
		this.categorySort = categorySort;
	}

	public Timestamp getCategoryDateTime() {
		return categoryDateTime;
	}

	public void setCategoryDateTime(Timestamp categoryDateTime) {
		this.categoryDateTime = categoryDateTime;
	}


	public int getCategoryManagerId() {
		return categoryManagerId;
	}

	public void setCategoryManagerId(int categoryManagerId) {
		this.categoryManagerId = categoryManagerId;
	}

	public int getCategoryModelId() {
		return categoryModelId;
	}

	public void setCategoryModelId(int categoryModelId) {
		this.categoryModelId = categoryModelId;
	}

	public int getCategoryCategoryId() {
		return categoryCategoryId;
	}

	public void setCategoryCategoryId(int categoryCategoryId) {
		this.categoryCategoryId = categoryCategoryId;
	}

	public String getCategorySmallImg() {
		return categorySmallImg;
	}

	public void setCategorySmallImg(String categorySmallImg) {
		this.categorySmallImg = categorySmallImg;
	}

	
	
}