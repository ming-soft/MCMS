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
