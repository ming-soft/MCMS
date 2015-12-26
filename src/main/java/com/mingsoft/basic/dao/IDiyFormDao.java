package com.mingsoft.basic.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.DiyFormEntity;

/**
 * 自定义表单
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IDiyFormDao extends IBaseDao{
	/**
	 * 查询列表
	 * @param appId　应用编号
	 * @return 返回列表集合
	 */
	List query(@Param("diyFormAppId")int appId);
	
	/**
	 * 根据表名查找自定义表单实体
	 * @param diyFormTableName
	 * @return 返回自定义表单实体
	 */
	DiyFormEntity getByTableName(@Param("diyFormTableName")String diyFormTableName);
	
	/**
	 * 为自定义表单创建表
	 * @param table 表名
	 * @param fileds 字段集合
	 */
	void createDiyFormTable(@Param("table")String table,@Param("fileds")Map<Object,List> fileds);
	
	/**
	 * 删除自定义表单，多条或者一条
	 * @param ids  多条表单集合（id）
	 */
	public void deleteAll(@Param("ids")String[] ids);
}
