package com.mingsoft.basic.dao;

import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.MailEntity;

/**
 * 邮件持久化层
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IMailDao  extends IBaseDao{
	/**
	 * 通过应用编号与模块编号获取邮件信息
	 * @param appId 应用编号 
	 * @param modelId 模块编号
	 * @return 返回邮件服务器信息
	 */
	MailEntity get(@Param(value="appId")int appId, @Param(value="modelId")Integer modelId);

}
