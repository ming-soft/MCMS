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