/**
 * 
 */
package com.mingsoft.basic.biz;

import java.util.List;


import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.BasicAttentionEntity;
import com.mingsoft.util.PageUtil;

/**
 * 
 * <p>
 * <b><铭飞科技-基础/b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 *
 * @author 成卫雄
 *                QQ:330216230
 *
 * <p>
 * Comments:关注业务层接口
 * </p>
 *
 * <p>
 * Create Date:2014-11-12
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public interface IBasicAttentionBiz extends IBaseBiz{
	
	/**
	 * 根据basicId,关注类型,用户ID,AppId查询</br>
	 * 查询用户是否关注过该商品</br>
	 * @param basicAttention 保存basicId,关注类型,用户ID,AppId查询的关注实体
	 * @return
	 */
	public BasicAttentionEntity getEntityByPeopleAttention(BasicAttentionEntity basicAttention);
	
	/**
	 * 根据用户ID和APPID查询用户关注内容列表开始(带分页)
	 * @param peopleId 用户ID
	 * @param appId 应用ID
	 * @param attentionType 类型
	 * @param page 分页
	 * @return 用户关注列表
	 */
	public List<BasicAttentionEntity> queryPageByPeopleIdAndAppId(int peopleId,int appId,int attentionType,PageUtil page);
	
	/**
	 * 根据用户ID和APPID查询用户关注内容列表开始(带分页)
	 * @param peopleId 用户ID
	 * @param appId 应用ID
	 * @param attentionType 类型
	 * @param modelId 模块编号，主要区分文章的收藏与商品的收藏，等其他的
	 * @param page 分页
	 * @return 用户关注列表
	 */
	public List<BasicAttentionEntity> queryPageByPeopleIdAndAppId(int peopleId,int appId,int attentionType,int modelId,PageUtil page);
	
	
	/**
	 * 根据用户ID和APPID查询用户关注内容数量
	 * @param peopleId 用户ID
	 * @param appId 应用ID
	 * @param attentionType 类型
	 * @return 数量
	 */
	public int queryCountByPeopleIdAndAppId(int peopleId,int appId,int attentionType);
	
	/**
	 * 根据用户ID和APPID查询用户关注内容数量
	 * @param peopleId 用户ID
	 * @param appId 应用ID
	 * @param modelId 模块编号，主要区分文章的收藏与商品的收藏，等其他的
	 * @param attentionType 类型
	 * @return 数量
	 */
	public int queryCountByPeopleIdAndAppId(int peopleId,int appId,int attentionType,int modelId);
	
	/**
	 * 根据收藏id数组和用户id删除收藏记录
	 * @param ids 收藏id数组
	 * @param peopleId 用户id
	 */
	public void delete(String[] ids,int peopleId);
}
