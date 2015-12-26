/**
 * 
 */
package com.mingsoft.basic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.BasicAttentionEntity;
import com.mingsoft.util.PageUtil;

/**
 * 
 * <p>
 * <b>铭飞科技-基础</b>
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
 * Comments:关注持久化接口
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
public interface IBasicAttentionDao extends IBaseDao {
	
	/**
	 * 根据basicId,关注类型,用户ID,AppId查询</br>
	 * 查询用户是否关注过该商品</br>
	 * @param basicAttention 保存basicId,关注类型,用户ID,AppId查询的关注实体
	 * @return
	 */
	public BasicAttentionEntity getEntityByPeopleAttention(@Param("basicAttention") BasicAttentionEntity basicAttention);
	
	/**
	 * 根据用户ID和APPID查询用户关注内容列表(带分页)
	 * @param peopleId 用户ID
	 * @param appId 应用ID
	 * @param page 分页
	 * @param attentionType 积分类型
	 * @param modelId 模块编号
	 * @return 用户关注列表
	 */
	public List<BasicAttentionEntity> queryPageByPeopleIdAndAppId(@Param("peopleId")int peopleId,@Param("appId")int appId,@Param("attentionType") int attentionType,@Param("modelId") Integer modelId,@Param("page")PageUtil page);
	
	/**
	 * 根据用户ID和APPID查询用户关注内容数量
	 * @param peopleId 用户ID
	 * @param appId 应用ID
	 * @param attentionType 积分类型
	 * @return 数量
	 */
	public int queryCountByPeopleIdAndAppId(@Param("peopleId")int peopleId,@Param("appId")int appId,@Param("attentionType") int attentionType,@Param("modelId") Integer modelId);
	

	/**
	 * 根据收藏id数组和用户id删除收藏记录
	 * @param ids 收藏id数组
	 * @param peopleId 用户id
	 */
	public void delete(@Param("ids") String[] ids,@Param("peopleId") int peopleId);

	
}
