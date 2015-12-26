package com.mingsoft.basic.biz;

import java.util.List;
import com.mingsoft.basic.entity.ModelTemplateEntity;
import com.mingsoft.base.biz.IBaseBiz;

/**
 * 模块模版业务接口
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IModelTemplateBiz extends IBaseBiz {

	/**
	 * 获取模版路径
	 * @param appId 应用编号
	 * @param modelId　模块编号
	 * @param key　模块关键字
	 * @return　返回模块模版
	 */
	ModelTemplateEntity getEntity(int appId,int modelId,String key);	
	
	/**
	 * 获取模版路径
	 * @param appId 应用编号
	 * @param key　模块关键字
	 * @return　返回模块模版
	 */
	ModelTemplateEntity getEntity(int appId,String key);
	
	
	/**
	 * 查询当前应用下面的所有自定义页面
	 * @param appId　应用编号
	 * @return　返回记录集合
	 */
	List queryByAppId(int appId);
}
