package com.mingsoft.basic.biz.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.basic.dao.IMailDao;
import com.mingsoft.basic.entity.MailEntity;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.IMailBiz;

/**
 * 邮件业务层接口实现类
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service(value="mailBiz")
public class MailBIzImpl extends BaseBizImpl implements IMailBiz {

	/**
	 * 注入邮件持久化层
	 */
	@Autowired
	private IMailDao mailDao;
	
	/**
	 * 获取邮件持久化层
	 * @return mailDao 返回邮件持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		return mailDao;
	}

	@Override
	public MailEntity get(int appId, int modelId) {
		// TODO Auto-generated method stub
		return mailDao.get(appId, modelId) ;
	}
	
	@Override
	public MailEntity getByAppId(int appId) {
		// TODO Auto-generated method stub
		return mailDao.get(appId, null) ;
	}
	

}
