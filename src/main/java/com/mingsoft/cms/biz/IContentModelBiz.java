package com.mingsoft.cms.biz;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.cms.entity.ContentModelEntity;
import com.mingsoft.util.PageUtil;
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
 * @author 姓名 史爱华
 * 
 * @version 300-001-001
 * 
 *          <p>
 *          版权所有 铭飞科技
 *          </p>
 * 
 *          <p>
 *          Comments:表单内容管理业务处理层 || 继承IBasicBiz业务处理层
 *          </p>
 * 
 *          <p>
 *          Create Date:2014-7-14
 *          </p>
 * 
 *          <p>
 *          Modification history:
 *          </p>
 */
public interface IContentModelBiz extends IBaseBiz{
	
	/**
	 * 根据内容模型的表名查找实体
	 * @param cmTableName 表名
	 * @return 内容模型实体
	 */
	public ContentModelEntity getContentModelByTableName(String cmTableName);
	
	/**
	 * 根据管理员Id查找内容模型的总数
	 * @param cmManagerId 管理员id
	 * @return 记录总数
	 */
	public int getContentModelByManagerId(int cmManagerId);
	
	/**
	 * 分页查询指定管理员的表单内容模型
	 * @param entity 实体
	 * @param page Map对象
	 * @param order 排序方式,true:asc;fales:desc
	 * @param cmManagerId 管理员id
	 * @return 表单内容模型
	 */
	List<BaseEntity> queryPageByManagerId(PageUtil page,String orderBy,boolean order, int cmManagerId);
	
	/**
	 * 根据管理员id查找内容模型实体
	 * @param cmManagerId
	 * @return 表单内容模型
	 */
	public List<BaseEntity> queryByManagerId(int cmManagerId);
}
