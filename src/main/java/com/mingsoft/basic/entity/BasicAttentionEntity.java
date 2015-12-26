/**
 * 
 */
package com.mingsoft.basic.entity;

import java.util.Date;

import com.mingsoft.base.entity.BaseEntity;

/**
 * 
 * <p>
 * <b>铭飞科技-基础</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 *
 * @author 成卫雄
 *                QQ:330216230
 *
 * <p>
 * Comments:关注实体
 * </p>
 *
 * <p>
 * Create Date:2014-11-12
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public class BasicAttentionEntity extends BaseEntity{
	
	/**
	 * 关注类型 1.收藏
	 */
	public final static int TYPE_COLLECT = 1;
	
	/**
	 * 关注类型 2.顶
	 */
	public final static int TYPE_TOP = 2;
	
	/**
	 * 自增长ID
	 */
	private int basicAttentionId;
	
	/**
	 * 关联用户Id
	 */
	private int basicAttentionPeopleId;
	
	/**
	 * 关联关注内容Id
	 */
	private int basicAttentionBasicId;
	
	/**
	 * 关联应用Id
	 */
	private int basicAttentionAppId;
	
	/**
	 * 关注类型
	 * 1.收藏
	 * 2.顶
	 */
	private int basicAttentionType;
	
	
	/**
	 * 关注时间
	 */
	private 	Date basicAttentionTime = new Date();
	


	/**
	 * 收藏内容的标题
	 */
	private BasicEntity basicEntity;
	
	
	/**
	 * 收藏内容的链接地址
	 */
	private String basicAttentionUrl;
	
	
	
	public String getBasicAttentionUrl() {
		return basicAttentionUrl;
	}

	public void setBasicAttentionUrl(String basicAttentionUrl) {
		this.basicAttentionUrl = basicAttentionUrl;
	}

	/**
	 * 获取basicEntity
	 * @return  basicEntity
	 */
	public BasicEntity getBasicEntity() {
		return basicEntity;
	}

	/**
	 * 设置basicEntity
	 * @param basicEntity
	 */
	public void setBasicEntity(BasicEntity basicEntity) {
		this.basicEntity = basicEntity;
	}

	/**
	 * 获取basicAttentionId
	 * @return  basicAttentionId
	 */
	public int getBasicAttentionId() {
		return basicAttentionId;
	}

	/**
	 * 设置basicAttentionId
	 * @param basicAttentionId
	 */
	public void setBasicAttentionId(int basicAttentionId) {
		this.basicAttentionId = basicAttentionId;
	}

	/**
	 * 获取basicAttentionPeopleId
	 * @return  basicAttentionPeopleId
	 */
	public int getBasicAttentionPeopleId() {
		return basicAttentionPeopleId;
	}

	/**
	 * 设置basicAttentionPeopleId
	 * @param basicAttentionPeopleId
	 */
	public void setBasicAttentionPeopleId(int basicAttentionPeopleId) {
		this.basicAttentionPeopleId = basicAttentionPeopleId;
	}

	/**
	 * 获取basicAttentionBasicId
	 * @return  basicAttentionBasicId
	 */
	public int getBasicAttentionBasicId() {
		return basicAttentionBasicId;
	}

	/**
	 * 设置basicAttentionBasicId
	 * @param basicAttentionBasicId
	 */
	public void setBasicAttentionBasicId(int basicAttentionBasicId) {
		this.basicAttentionBasicId = basicAttentionBasicId;
	}

	/**
	 * 获取basicAttentionAppId
	 * @return  basicAttentionAppId
	 */
	public int getBasicAttentionAppId() {
		return basicAttentionAppId;
	}

	/**
	 * 设置basicAttentionAppId
	 * @param basicAttentionAppId
	 */
	public void setBasicAttentionAppId(int basicAttentionAppId) {
		this.basicAttentionAppId = basicAttentionAppId;
	}

	/**
	 * 获取basicAttentionType
	 * @return  basicAttentionType
	 */
	public int getBasicAttentionType() {
		return basicAttentionType;
	}

	/**
	 * 设置basicAttentionType
	 * @param basicAttentionType
	 */
	public void setBasicAttentionType(int basicAttentionType) {
		this.basicAttentionType = basicAttentionType;
	}

	/**
	 * 获取basicAttentionTime
	 * @return  basicAttentionTime
	 */
	public Date getBasicAttentionTime() {
		return basicAttentionTime;
	}

	/**
	 * 设置basicAttentionTime
	 * @param basicAttentionTime
	 */
	public void setBasicAttentionTime(Date basicAttentionTime) {
		this.basicAttentionTime = basicAttentionTime;
	}
	
	
}
