package com.mingsoft.cms.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 字段是否支持搜索
 * @author Administrator
 *
 */
public enum FieldSearchEnum  implements BaseEnum {
		/**
		 * 不支持搜索
		 */
		NOT("0"),
		/**
		 * 支持搜索
		 */
		IS("1");

	FieldSearchEnum(Object code) {
		this.code = code;
	}
	
	private Object code;
	@Override
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.valueOf(code+"");
	}

}
