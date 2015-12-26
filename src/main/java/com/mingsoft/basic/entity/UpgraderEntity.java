package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;

/**
 * 上传更新实体
 * @author 杨新远
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class UpgraderEntity extends BaseEntity{
	
	/**
	 * 上传更新id
	 */
	private  int  upgraderId;
	
	/**
	 * 所属模块编号
	 */
	private int upgraderModelId;
	
	/**
	 * 版本信息
	 */
	private int upgraderVersion;
	
	/**
	 * 描述
	 */
	private String upgraderDesc;	
	
	/**
	 * 更新补丁包的位置
	 */
	private String upgraderPatch	;
	
	
		public int getUpgraderId() {
		return upgraderId;
	}

	public void setUpgraderId(int upgraderId) {
		this.upgraderId = upgraderId;
	}

	public int getUpgraderModelId() {
		return upgraderModelId;
	}

	public void setUpgraderModelId(int upgraderModelId) {
		this.upgraderModelId = upgraderModelId;
	}

	public int getUpgraderVersion() {
		return upgraderVersion;
	}

	public void setUpgraderVersion(int upgraderVersion) {
		this.upgraderVersion = upgraderVersion;
	}

	public String getUpgraderDesc() {
		return upgraderDesc;
	}

	public void setUpgraderDesc(String upgraderDesc) {
		this.upgraderDesc = upgraderDesc;
	}

	public String getUpgraderPatch() {
		return upgraderPatch;
	}

	public void setUpgraderPatch(String upgraderPatch) {
		this.upgraderPatch = upgraderPatch;
	}

}


















