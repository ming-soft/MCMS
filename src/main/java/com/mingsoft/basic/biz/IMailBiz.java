package com.mingsoft.basic.biz;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.MailEntity;

/**
 * 邮件业务层接口
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IMailBiz extends IBaseBiz{

	/**
	 * 通过应用编号与模块编号获取邮件信息
	 * @param appId 应用编号 
	 * @param modelId 模块编号
	 * @return 返回邮件服务器信息
	 */
	MailEntity get(int appId,int modelId);
	
	/**
	 * 通过应用编号获取邮件信息
	 * @param appId 应用编号 
	 * @return 返回邮件服务器信息
	 */
	MailEntity getByAppId(int appId);
}
