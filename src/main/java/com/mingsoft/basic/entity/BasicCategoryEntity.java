package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;

/**
 * 类别基础信息关联表
 * @author 成卫雄QQ:330216230
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class BasicCategoryEntity extends BaseEntity {
	/**
	 * 类别编号
	 */
	private int bcCategoryId;
	
	/**
	 * 基本信息编号
	 */
	private int bcBasicId;

	/**
	 *获取 bcCategoryId
	 * @return bcCategoryId
	 */
	public int getBcCategoryId() {
		return bcCategoryId;
	}

	/**
	 *设置bcCategoryId
	 * @param bcCategoryId
	 */
	public void setBcCategoryId(int bcCategoryId) {
		this.bcCategoryId = bcCategoryId;
	}

	/**
	 *获取 bcBasicId
	 * @return bcBasicId
	 */
	public int getBcBasicId() {
		return bcBasicId;
	}

	/**
	 *设置bcBasicId
	 * @param bcBasicId
	 */
	public void setBcBasicId(int bcBasicId) {
		this.bcBasicId = bcBasicId;
	}
}
