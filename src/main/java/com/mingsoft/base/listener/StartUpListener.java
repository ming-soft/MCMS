package com.mingsoft.base.listener;

import java.io.File;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.mingsoft.base.constant.Const;
import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.StringUtil;

/**
 * 启动监听
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@WebListener("startUpListener")
public class StartUpListener implements ServletContextListener {

	/*
	 * log4j日志记录
	 */
	protected final Logger LOG = Logger.getLogger(this.getClass());
	
	
	/**
	 *  
	 *  监听项目启动，进行初始化
	 *  @param sce ServletContextEvent对象
	 */
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		LOG.debug("MS启动初始化开始");
		Const.PROJECT_PATH = sce.getServletContext().getRealPath(File.separator);
		Const.CONTEXT =  WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
		LOG.debug("MS启动初始化结束");

	}

	/**
	 * 监听项目终止，进行销毁
	 * @param sce  ServletContextEvent对象
	 */
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		LOG.debug("-=====");
	}

}
