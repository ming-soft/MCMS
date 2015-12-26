package com.mingsoft.basic.biz.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.basic.dao.IModelTemplateDao;
import com.mingsoft.basic.entity.ModelTemplateEntity;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.biz.IModelTemplateBiz;

/**
 * 模块模版业务接口实现类
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("modelTemplateBiz")
public class ModelTemplateBizImpl extends BaseBizImpl implements IModelTemplateBiz{
	
	/**
	 * 注入模块模版持久化层
	 */
	@Autowired
	private IModelTemplateDao modelTemplateDao;
	
	@Override
	public ModelTemplateEntity getEntity(int appId, int modelId,String key) {
		return modelTemplateDao.getEntity(appId, modelId,key);
	}

	@Override
	public ModelTemplateEntity getEntity(int appId, String key) {
		return modelTemplateDao.getEntityByAppIdAndKey(appId, key);
	}

	/**
	 * 获取模块模版持久化层
	 * @return modelTemplateDao 返回模块模版持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		return modelTemplateDao;
	}

	@Override
	public List queryByAppId(int appId) {
		// TODO Auto-generated method stub
		return modelTemplateDao.queryByAppId(appId);
	}

	
}
