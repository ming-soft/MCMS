package com.mingsoft.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.ModelTemplateEntity;

/**
 * 模块持久化
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IModelTemplateDao extends IBaseDao{
	/**
	 * 获取模版路径
	 * @param appId 应用编号
	 * @param modelId　模块编号
	 * @param key　对应路径地址
	 * @return　返回模块模版
	 */
	ModelTemplateEntity getEntity(@Param("appId")int appId,@Param("modelId")int modelId,@Param("key")String key);
	
	/**
	 * 获取模版路径
	 * @param appId 应用编号
	 * @param key　对应路径地址
	 * @return　返回模块模版
	 */
	ModelTemplateEntity getEntityByAppIdAndKey(@Param("appId")int appId,@Param("key")String key);
	
	/**
	 * 查询当前应用下面的所有自定义页面
	 * @param appId　应用编号
	 * @return　返回记录集合
	 */
	List queryByAppId(@Param("appId")int appId);
	
}
