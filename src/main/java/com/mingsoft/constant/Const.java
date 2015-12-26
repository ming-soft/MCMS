package com.mingsoft.constant;

import java.util.ResourceBundle;

import org.springframework.context.ApplicationContext;

/**
 * 
 * 
 * <p>
 * <b>铭飞基础框架</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author wangtp
 * 
 * @version 300-001-001
 * 
 *          <p>
 *          版权所有 铭飞科技
 *          </p>
 * 
 *          <p>
 *          Comments:
 *          </p>
 * 
 *          <p>
 *          Create Date:2014-1-4
 *          </p>
 * 
 *          <p>
 *          Modification history:
 *          </p>
 */
public final class Const {

	/**
	 * 当前请求路径,BaseFilter赋值
	 */
	public static String BASE_URL;

	/**
	 * 项目名称,BaseFilter赋值
	 */
	public static String BASE;

	/**
	 * 项目物理路径,BaseFilter赋值
	 */
	public static String PROJECT_PATH;

	/**
	 * spring资源文件加载上下文对象
	 */
	public static ApplicationContext CONTEXT;

	/**
	 * action层对应的国际化资源文件
	 */
	public final static ResourceBundle RESOURCES = ResourceBundle
			.getBundle("com.mingsoft.base.action.resources");

	/**
	 * 默认系统管理员所对应的角色ID为1
	 */
	public final static int DEFAULT_SYSTEM_MANGER_ROLE_ID = 1;

	/**
	 * 默认站点管理员所对应的角色ID为2
	 */
	public final static int DEFAULT_WEBSITE_MANGER_ROLE_ID = 2;

	/**
	 * 默认CMS所对应的模块ID为1
	 */
	public final static int DEFAULT_CMS_MODEL_ID = 1;

	/**
	 * 顶级栏目的父栏目ID为0
	 */
	public final static int COLUMN_TOP_CATEGORY_ID = 0;

	/** 微信相关开始 */

	/**
	 * 服务器发布地址,带有http:// 在StrutsFilter类里面设置
	 */
	public static String HOST_URL = "";


	/** 微信相关结束 */

	public final static String UTF8 = "utf-8";
	

}
