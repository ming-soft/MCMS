package com.mingsoft.basic.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 自定义表单类型
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public enum DiyFormFieldEnum implements BaseEnum {
	/**
	 * 单行文本
	 */
	TEXT(1),
	/**
	 * 多行文本
	 */
	TEXTAREA(2),

	/**
	 * HTML
	 */
	HTML(3),

	/**
	 * 整型
	 */
	INT(4),

	/**
	 *  小數
	 */
	DOUBLE(5),

	/**
	 * 時間
	 */
	DATE(6),
	/**
	 * 图片
	 */
	IMAGE(7), 
	/**
	 *  附件
	 */
	ATTACHMENT(8), 
	/**
	 * 下拉框
	 */
	SELECT(9), 
	/**
	 * 單選
	 */
	RADIO(10), 
	/**
	 * 多選
	 */
	CHECKBOX(11),
	/**
	 * 许为空
	 */
	IS_NULL(1);

	/**
	 * 构造方法
	 * @param code 传入的枚举类型
	 */
	DiyFormFieldEnum(Object code) {
		this.code = code;
	}

	/**
	 * 枚举类型
	 */
	private Object code;

	@Override
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.valueOf(code.toString());
	}

}
