package com.mingsoft.basic.constant.e;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 邮箱枚举类
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public enum MailEnum implements BaseEnum {
	TEXT(1), HTML(2);
	
	/**
	 * 枚举类型
	 */
	Object code;

	/**
	 * 构造方法
	 * @param code 传入的枚举类型
	 */
	MailEnum(Object code) {
		this.code = code;
	}

	@Override
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.parseInt(this.code.toString());
	}

}
