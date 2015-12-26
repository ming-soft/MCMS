package com.mingsoft.basic.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 模块枚举类
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public enum ModelEnum implements BaseEnum {
	
	/**
	 * 模块类型是菜单
	 */
	MENU(0),
	
	/**
	*模块类型是非菜单
	*/
	NOTMENU(1);
	
	
	/**
	 * 枚举类型
	 */
	private Object code;
	
	/**
	 * 构造方法
	 * @param code 传入的枚举类型
	 */
	ModelEnum(Object code) {
		this.code = code;
	}
	
	/**
	 * 实现父类方法转换为整形
	 */
	@Override
	public int toInt() {
		return Integer.valueOf(code.toString());
	}

}
