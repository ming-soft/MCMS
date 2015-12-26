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
 * Comments:内容模型实体，指表单类型，继承BaseEntity
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
public class ContentModelEntity extends BaseEntity{
 
	/**
	 * 自增长ID
	 */
	private int cmId;
	
	/**
	 * 表名提示文字
	 */
	private String cmTipsName;
	
	/**
	 * 表单名称
	 */
	private String cmTableName;
	
	/**
	 * 表单所属的管理员id
	 */
	private int cmManagerId;

	/**
	 * 获取cmId
	 * @return cmId
	 */
	public int getCmId() {
		return cmId;
	}

	/**
	 * 设置cmId
	 * @param cmId
	 */
	public void setCmId(int cmId) {
		this.cmId = cmId;
	}

	/**
	 * 获取cmTipsName
	 * @return cmTipsName
	 */
	public String getCmTipsName() {
		return cmTipsName;
	}

	/**
	 * 设置cmTipsName
	 * @param cmTipsName
	 */
	public void setCmTipsName(String cmTipsName) {
		this.cmTipsName = cmTipsName;
	}

	/**
	 * 获取cmTableName
	 * @return cmTableName
	 */
	public String getCmTableName() {
		return cmTableName;
	}

	/**
	 * 设置cmTableName
	 * @param cmTableName
	 */
	public void setCmTableName(String cmTableName) {
		this.cmTableName = cmTableName;
	}
	
	/**
	 * 获取该表单所属的管理员id
	 * @return
	 */
	public int getCmManagerId() {
		return cmManagerId;
	}
	
	/**
	 * 设置该表单所属的管理员id
	 * @param cmManagerId
	 */
	public void setCmManagerId(int cmManagerId) {
		this.cmManagerId = cmManagerId;
	}
	
	
}
