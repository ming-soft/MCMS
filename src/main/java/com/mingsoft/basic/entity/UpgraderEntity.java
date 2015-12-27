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