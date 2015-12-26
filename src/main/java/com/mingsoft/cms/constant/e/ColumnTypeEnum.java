package com.mingsoft.cms.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 *
 * @author 王天培
 *                QQ:78750478
 *
 * <p>
 * Comments:文章栏目分类类型
 * </p>
 *
 * <p>
 * Create Date:2015-1-18
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public enum ColumnTypeEnum implements BaseEnum {
	/**
	 * 列表
	 */
	COLUMN_TYPE_LIST(1),
	/**
	 * 单页
	 */
	COLUMN_TYPE_COVER(2),
	/**
	 * 跳转地址
	 */
	COLUMN_TYPE_URL(3);

	ColumnTypeEnum(Object code) {
		this.code = code;
	}
	
	private Object code;
	@Override
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.valueOf(code+"");
	}
	
}
