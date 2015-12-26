package com.mingsoft.basic.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 收藏类型枚举类
 * @author 刘越卫
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public enum AttentionTypeEnum implements BaseEnum {
	
	/**
	 * 收藏
	 */
	COLLECT(1),

	/**
	 * 顶
	 */
	TOP(2);
	
	/**
	 * 构造方法
	 * @param code 传入的枚举类型
	 */
	AttentionTypeEnum(Object code) {
		this.code = code;
	}

	/**
	 * 枚举类型
	 */
	private Object code;

	
	/**
	 * 实现父类方法转换为整形
	 */
	@Override
	public int toInt() {
		return Integer.valueOf(code.toString());
	}

}
