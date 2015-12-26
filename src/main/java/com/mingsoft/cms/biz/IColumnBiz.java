package com.mingsoft.cms.biz;
import java.util.List;

import com.mingsoft.basic.biz.ICategoryBiz;
import com.mingsoft.basic.entity.BasicEntity;
import com.mingsoft.cms.entity.ColumnEntity;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 刘继平
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:栏目业务层接口，继承ICategoryBiz接口
 * </p>
 *  
 * <p>
 * Create Date:2014-7-14
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public interface IColumnBiz extends ICategoryBiz {

	
	
	/**
	 * 根据站点ID查询该站点下的栏目集合
	 * @param columnWebsiteId 站点Id
	 * @return 栏目集合
	 */
	public List<ColumnEntity> queryColumnListByWebsiteId(int columnWebsiteId);
	
	
	
	/**
	 * 根据站点Id查询该站点下的栏目的父栏目Id为categoryCategoryId的子栏目集合
	 * @param categoryCategoryId 父栏目ID
	 * @param columnWebsiteId 站点Id
	 * @param modelId 模块编号
	 * @return 栏目集合
	 */
	public List<ColumnEntity> queryChild(int categoryCategoryId,int columnWebsiteId,Integer modelId);

	/**
	 * 获取当前应用下面对应模块的所以栏目分类
	 * @param appId 站点信息
	 * @param modelId 模块信息
	 * @return 记录集合
	 */
	public List<ColumnEntity> queryAll(int appId,int modelId);
	
	/**
	 * 通过站点Id查询栏目的同级栏目和他的父级栏目（包括他的间接父栏目知道顶级栏目）的同级栏目集合
	 * @param categoryId 栏目ID
	 * @param columnWebsiteId 站点Id
 	 * @return 栏目集合
	 */
	public List<ColumnEntity> queryColumnChildListRecursionByWebsiteId(int categoryId,int columnWebsiteId );
	
	/**
	 * 通过栏目ID查询该栏目同级栏目
	 * @param columnId 栏目ID
	 * @return 同级栏目集合
	 */
	public List<ColumnEntity> querySibling(int columnId);
	
	/**
	 * 通过栏目ID查询顶级栏目的同级栏目
	 * @param columnId 栏目ID
	 * @return 顶级同级栏目集合
	 */
	public List<ColumnEntity> queryTopSiblingListByColumnId(int columnId);
	
	/**
	 * 根据栏目Id查询栏目的子栏目集
	 * @param columnId 栏目ID
	 * @return 子栏目集合
	 */
	public List<ColumnEntity> queryChildListByColumnId(int columnId);
	
	
	/**
	 * 根据栏目ID查询其子栏目ID集合
	 * @param columnId 栏目ID
	 * @param appId 应用ID
	 * @return 子栏目ID集合
	 */
	public List<Integer> queryChildIdsByColumnId(int columnId,int appId);
	
	/**
	 * 根据栏目属性查询栏目站点id为columnWebsiteId的栏目集合
	 * @param columnType 栏目属性
	 * @param columnWebsiteId 栏目所属站点ID
	 * @return 栏目集合
	 */
	public List <ColumnEntity> queryColumnListBycolumnType(int columnType,int columnWebsiteId);
	
	/**
	 * 通过栏目ID查询栏目对应节点路径上的父级栏目集合
	 * @param columnId 栏目ID
	 * @return 栏目及其父级栏目集合
	 */
	public List<ColumnEntity> queryParentColumnByColumnId(int columnId);
	
	/**
	 * 根据站点Id查询该站点下的栏目的父栏目Id为categoryCategoryId的子栏目集合数目统计
	 * @param categoryCategoryId 父栏目ID
	 * @param columnWebsiteId 站点ID
	 * @return 子栏目统计数目
	 */
	public int queryColumnChildListCountByWebsiteId(int categoryCategoryId,int columnWebsiteId);
	
	/**
	 * 通过管理员ID和模块ID查询订单类型集合
	 * @param categoryManagerId 管理员ID
	 * @param categoryModelId 模块ID
	 * @return 订单集合
	 */
	public List<BasicEntity> queryCategoryByManagerIdAndModelId(int categoryManagerId, int categoryModelId);
	
	/**
	 * 查询同级栏目
	 * @param columnId
	 * @return 订单集合
	 */
	public List<ColumnEntity> querSibListByColumnId(int columnId);

}
