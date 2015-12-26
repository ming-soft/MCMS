package com.mingsoft.people.action;

import javax.servlet.http.HttpServletRequest;

import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.people.entity.PeopleEntity;

/***
 * 
 * 用户模块基础控制层
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015-1-31<br/>
 * 历史修订：<br/>
 */
public class BaseAction extends com.mingsoft.basic.action.BaseAction{
	/**
	 * 读取国际化资源文件
	 * 
	 * @param key 键值
	 * @return字符串
	 */
	protected String getResString(String key) {
		return super.getResString(key, com.mingsoft.people.constant.Const.RESOURCES);
	}
	
	/**
	 * 读取国际化资源文件
	 * 
	 * @param key 键值
	 * @param fullStrs  需填充的值
	 * @return 字符串
	 */
	protected String getResString(String key, String... fullStrs) {
		return super.getResString(key, com.mingsoft.people.constant.Const.RESOURCES,fullStrs);
	}
	
	/**
	 * 获取用户session.没有返回null
	 */
	protected PeopleEntity getPeopleBySession(HttpServletRequest request) {
		Object obj = this.getSession(request, SessionConst.PEOPLE_SESSION);
		if (obj!=null) {
			return (PeopleEntity)obj;
		} 
		return null;
	}
}
