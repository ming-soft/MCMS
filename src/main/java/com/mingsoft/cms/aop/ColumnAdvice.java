/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.mingsoft.cms.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mingsoft.cms.biz.IArticleBiz;

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
 * @author 史爱华
 * 
 *         <p>
 *         Comments:栏目管理切面
 *         </p>
 * 
 *         <p>
 *         Create Date:2015-2-11
 *         </p>
 * 
 *         <p>
 *         Modification history:
 *         </p>
 */
// @Aspect : 标记为切面类
// @Pointcut : 指定匹配切点集合
// @Before : 指定前置通知，value中指定切入点匹配
// @AfterReturning ：后置通知，具有可以指定返回值
// @AfterThrowing ：异常通知
// 注意：前置/后置/异常通知的函数都没有返回值，只有环绕通知有返回值
@Component
// 首先初始化切面类
@Aspect
// 声明为切面类，底层使用动态代理实现AOP
public class ColumnAdvice {
	
	@Autowired
	private IArticleBiz articleBiz;
	
	// 指定切入点匹配表达式，注意它是以方法的形式进行声明的。
		// 即切点集合是：aop.annotation包下所有类所有方法
		// 第一个* 代表返回值类型
		// 如果要设置多个切点可以使用 || 拼接
		// and args(com.mingsoft.order.entity.OrderEntity
		@Pointcut(" execution(*  com.mingsoft.basic.biz.impl.ColumnBizImpl.deleteCategory(..) ) ")
		public void deleteCategory() {
		}
		
		/**
		 * 
		 * @param jp
		 * @throws Throwable
		 */
		@After("deleteCategory()")
		public void deleteArticle(JoinPoint jp)throws Throwable{
			Object[] obj = jp.getArgs();
			if (obj[0] instanceof Integer) {
				//删除该栏目下的所有文章
				//
			}
		}
}