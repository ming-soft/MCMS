package com.mingsoft.basic.aop;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.base.constant.SessionConst;

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
 * Comments:分期模块管理操作订单状态日志
 * </p>
 *
 * <p>
 * Create Date:2015-2-11
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
// @Aspect : 标记为切面类
// @Pointcut : 指定匹配切点集合
// @Before : 指定前置通知，value中指定切入点匹配
// @AfterReturning ：后置通知，具有可以指定返回值
//@AfterThrowing ：异常通知
//注意：前置/后置/异常通知的函数都没有返回值，只有环绕通知有返回值
@Component
// 首先初始化切面类
@Aspect
// 声明为切面类，底层使用动态代理实现AOP
public class DownloadAdvice {

	// 指定切入点匹配表达式，注意它是以方法的形式进行声明的。
	// 即切点集合是：aop.annotation包下所有类所有方法
	// 第一个* 代表返回值类型
	// 如果要设置多个切点可以使用 || 拼接
	// and args(com.mingsoft.order.entity.OrderEntity
	@Pointcut(" execution(*  com.mingsoft.basic.servlet.DownloadServlet.doGet(..) ) ")
	public void doGet() {}


	@Around("doGet()")
	public void doBasicProfiling(ProceedingJoinPoint pjp) throws Throwable {
	}
}
