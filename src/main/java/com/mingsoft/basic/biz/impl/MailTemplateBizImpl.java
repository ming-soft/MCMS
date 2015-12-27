/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

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