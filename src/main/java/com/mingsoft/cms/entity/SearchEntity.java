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
