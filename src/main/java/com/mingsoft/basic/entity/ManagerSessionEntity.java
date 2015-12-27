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

import java.util.List;
import com.mingsoft.base.entity.BaseEntity;

/**
 * Session管理员实体，继承ManagerEntity
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ManagerSessionEntity extends ManagerEntity {
	
    /**
     * 父管理员ID
     */
    private int managerParentID;
    
    /**
     * 子管理员集合
     */
    private List<BaseEntity> managerChildIDs;
    
    /**
     * 站点ID
     */
    private int basicId;
    
    /**
     * 当前应用使用的默认风格
     */
    private String style;
    
    
    public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	/**
     * 管理员的后台皮肤
     */
    private SystemSkinEntity systemSkin;

	/**
     * 获取managerParentID
     * @return managerParentID
     */
	public int getManagerParentID() {
		return managerParentID;
	}

	/**
	 * 设置managerParentID
	 * @param managerParentID
	 */
	public void setManagerParentID(int managerParentID) {
		this.managerParentID = managerParentID;
	}

	/**
	 * 获取managerChildIDs
	 * @return managerChildIDs
	 */
	public List<BaseEntity> getManagerChildIDs() {
		return managerChildIDs;
	}

	/**
	 * 设置managerChildIDs
	 * @param managerChildIDs
	 */
	public void setManagerChildIDs(List<BaseEntity> managerChildIDs) {
		this.managerChildIDs = managerChildIDs;
	}

	/**
	 * 获取basicId
	 * @return basicId
	 */
	public int getBasicId() {
		return basicId;
	}

	/**
	 * 设置basicId
	 * @param basicId
	 */
	public void setBasicId(int basicId) {
		this.basicId = basicId;
	}
	
    public SystemSkinEntity getSystemSkin() {
		return systemSkin;
	}

	public void setSystemSkin(SystemSkinEntity systemSkin) {
		this.systemSkin = systemSkin;
	}
    
    
}