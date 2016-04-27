package com.mingsoft.people.aop;

import javax.servlet.http.HttpServletRequest;


import com.mingsoft.base.entity.SessionEntity;
import com.mingsoft.people.constant.e.SessionConstEnum;

/**
 * bbs切面基础方法
 * 
 * @author 史爱华
 * @version 版本号：100-000-000<br/>
 *          创建日期：2015-12-14<br/>
 *          历史修订：<br/>
 */
public abstract class BaseAop extends com.mingsoft.basic.aop.BaseAop {


	/**
	 * 读取用户sessoin
	 * 
	 * @param request
	 *            HttpServletRequest对象
	 * @return 返回获取到的用户session,获取不到返回nul
	 */
	protected SessionEntity getPeopleBySession(HttpServletRequest request) {
		// 传入用户请求，读取用户的session || super,调用父类的protected属性的getSession方法
		Object obj = this.getSession(request, SessionConstEnum.PEOPLE_SESSION);
		if (obj != null) {
			// 返回用户的所有信息
			return (SessionEntity) obj;
		}
		return null;
	}

}
