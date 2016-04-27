package com.mingsoft.people.servlet;

import javax.servlet.http.HttpServletRequest;

import com.mingsoft.people.constant.e.SessionConstEnum;
import com.mingsoft.people.entity.PeopleEntity;

/**
 * 铭飞会员系统
 * @author 铭飞开发团队
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2016年3月31日<br/>
 * 历史修订：<br/>
 */
public abstract class BaseServlet extends com.mingsoft.basic.servlet.BaseServlet{
 
	/**
	 * 获取用户session.没有返回null
	 */
	protected PeopleEntity getPeopleBySession(HttpServletRequest request) {
		Object obj = this.getSession(request, SessionConstEnum.PEOPLE_SESSION);
		if (obj != null) {
			return (PeopleEntity) obj;
		}
		return null;
	}
 
	/**
	 * 设置用户session
	 * 
	 * @param request
	 * @param people
	 *            用户实体
	 */
	protected void setPeopleBySession(HttpServletRequest request, PeopleEntity people) {
		this.setSession(request, SessionConstEnum.PEOPLE_SESSION, people);
	}

	/**
	 * 移除用户session
	 * 
	 * @param request
	 */
	protected void removePeopleBySession(HttpServletRequest request) {
		super.removeSession(request, SessionConstEnum.PEOPLE_SESSION);
	}

}
