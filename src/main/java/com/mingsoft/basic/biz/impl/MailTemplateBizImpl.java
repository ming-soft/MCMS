package com.mingsoft.basic.biz.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.IMailTemplateBiz;
import com.mingsoft.basic.dao.IMailTemplateDao;
import com.mingsoft.basic.entity.MailTemplateEntity;

/**
 * 邮件模板业务层接口实现类
 * @author 杨新远
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("mailTemplateBiz")
public class MailTemplateBizImpl extends BaseBizImpl implements IMailTemplateBiz {
	/**
	 * 注入邮件模板持久化层
	 */
	@Autowired
	private IMailTemplateDao mailTemplateDao;

	/**
	 * 获取邮件模板持久化层
	 * @return mailTemplateDao 返回邮件模板持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return mailTemplateDao;
	}

	@Override
	public List<MailTemplateEntity> queryAllByAppId(int mailTemplateAppId) {
		// TODO Auto-generated method stub
		return mailTemplateDao.queryAllByAppId(mailTemplateAppId);
	}

	
	
	@Override
	public MailTemplateEntity getByAppIdAndModelCode(int mailTemplateAppId, int modelId) {
		if (modelId<=0 ||  mailTemplateAppId <= 0) {
			return null;
		}
		// TODO Auto-generated method stub
		return mailTemplateDao.getByAppIdAndModelCode(mailTemplateAppId,modelId);
	}

	@Override
	public void deleteAll(String[] ids) {

		mailTemplateDao.deleteAll(ids);
	}

}
