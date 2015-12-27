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

package com.mingsoft.cms.entity;
import com.mingsoft.base.entity.BaseEntity;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 姓名：张敏
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:搜索实体，继承BasicEntity
 * </p>
 *  
 * <p>
 * Create Date:2014-9-11
 * </p>
 *
 * <p>
 * Modification history:暂无
 * </p>
 */
public class SearchEntity extends BaseEntity{
	
	/**
	 * 自增长ID
	 */
	private int searchId;
	
	/**
	 * 搜索名称
	 */
	private String searchName;
	
	/**
	 * 搜索结果模板
	 */
	private String searchTemplets;
	
	/**
	 * 站点ID
	 */
	private int searchWebsiteId;

	/**
	 * 获取searchId
	 * @return searchId
	 */
	public int getSearchId() {
		return searchId;
	}

	/**
	 * 设置searchId
	 * @param searchId
	 */
	public void setSearchId(int searchId) {
		this.searchId = searchId;
	}

	/**
	 * 获取searchName
	 * @return searchName
	 */
	public String getSearchName() {
		return searchName;
	}

	/**
	 * 设置searchName
	 * @param searchName
	 */
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	/**
	 * 获取searchTemplets
	 * @return searchTemplets
	 */
	public String getSearchTemplets() {
		return searchTemplets;
	}

	/**
	 * 设置searchTemplets
	 * @param searchTemplets
	 */
	public void setSearchTemplets(String searchTemplets) {
		this.searchTemplets = searchTemplets;
	}

	/**
	 * 获取searchWebsiteId
	 * @return searchWebsiteId
	 */
	public int getSearchWebsiteId() {
		return searchWebsiteId;
	}

	/**
	 * 设置searchWebsiteId
	 * @param searchWebsiteId
	 */
	public void setSearchWebsiteId(int searchWebsiteId) {
		this.searchWebsiteId = searchWebsiteId;
	}
	
	
}