package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;

/**

 * 基础表之间的子父关联关系

 * @author 史爱华 QQ:924690193

 * @version

 * 版本号：100-000-000<br/>

 * 创建日期：2015-08-21<br/>

 * 历史修订：<br/>

 */
public class BasicChildEntity extends BaseEntity{
	
	/**
	 * 基础basicId
	 */
	private int basicId;
	
	/**
	 * 基础basicId关联的子id
	 */
	private int basicChildId;
	
	

	public int getBasicId() {
		return basicId;
	}

	public void setBasicId(int basicId) {
		this.basicId = basicId;
	}

	public int getBasicChildId() {
		return basicChildId;
	}

	public void setBasicChildId(int basicChildId) {
		this.basicChildId = basicChildId;
	}


	
	
}
