/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

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

package net.mingsoft.cms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import net.mingsoft.cms.bean.ColumnArticleIdBean;
import net.mingsoft.cms.entity.ArticleEntity;

import net.mingsoft.base.dao.IBaseDao;


/**
 * 
 * @ClassName:  IArticleDao   
 * @Description:TODO(文章管理持久化层 || 继承IBaseDao持久化层)   
 * @author: 铭飞开发团队
 * @date:   2018年1月31日 下午2:55:33   
 *     
 * @Copyright: 2018 www.mingsoft.net Inc. All rights reserved.
 */
public interface IArticleDao extends IBaseDao {

	/**
	 * @para webId 网站编号
	 * @param basicCategoryIds
	 *            栏目编号集合
	 * @param flag
	 *            文章属性
	 * @param noFlag
	 *            文章不存在的属性
	 * @param article
	 *            文章实体，便于扩展查询
	 * @return 文章总数
	 */
	@Deprecated
	int count(@Param("webId") int webId, @Param("basicCategoryIds") int[] basicCategoryIds, @Param("flag") String flag,
			@Param("noFlag") String noFlag, @Param("article") ArticleEntity article);

	/**
	 * 通过分类id获取文章内容
	 * 
	 * @param categoryId
	 *            分类编号
	 * @return 文章集合
	 */
	@Deprecated
	List getByCategoryId(@Param("categoryId") int categoryId);

	/**
	 * 通过视图表来查询文章总数
	 * 
	 * @param basicId
	 *            文章编号
	 * @param contentModelTableName
	 *            对应模块表名称
	 */
	List getById(@Param("basicId") int basicId, @Param("contentModelTableName") String contentModelTableName);

	/**
	 * 查找basicId上一篇文章
	 * 
	 * @param appId
	 *            应用编号
	 * @param basicId
	 *            文章编号
	 * @param flag
	 *            true:上一条 false:下一条
	 * @return
	 */
	ArticleEntity getNextOrPrevious(@Param("appId") int appId, @Param("basicId") int basicId,
			@Param("flag") boolean flag, @Param("categoryId") Integer categoryId);

	/**
	 * 根据查询文章实体总数
	 * 
	 * @param tableName
	 *            :自定义生成的表名
	 * @param map
	 *            key:字段名 value:List 字段的各种判断值 list[0]:是否为自定义字段 list[1]:是否为整形
	 *            list[2]:是否是等值查询 list[3]:字段的值
	 * @return 文章实体总数
	 */
	int getSearchCount(@Param("tableName") String tableName, @Param("map") Map<String, List> map,
			@Param("websiteId") int websiteId, @Param("ids") String ids);

	/**
	 * 文章查询
	 * 
	 * @para webId 网站编号
	 * @param basicCategoryIds
	 *            栏目编号集合
	 * @param flag
	 *            文章属性
	 * @param noFlag
	 *            文章不存在的属性
	 * @param orderBy
	 *            排序字段
	 * @param order
	 *            true 升序 false 降序 排序方式
	 * @param article
	 *            文章实体，便于扩展查询
	 * @param beginTime 开始时间    
	 * @param endTime 结束时间 
	 * @return 文章集合
	 */
	List<ArticleEntity> query(@Param("webId") int webId, @Param("basicCategoryIds") int[] basicCategoryIds,
			@Param("flag") String flag, @Param("noFlag") String noFlag, @Param("orderBy") String orderBy,
			@Param("order") boolean order, @Param("beginTime") String beginTime,@Param("endTime") String endTime, 
			@Param("article") ArticleEntity article);

	/**
	 * 根据页面栏目的id获取与其绑定的文章实体
	 * 
	 * @param basicCategoryId
	 * @return 文章实体
	 */
	@Deprecated
	List<ArticleEntity> queryListByColumnId(@Param("basicCategoryId") int basicCategoryId);

	/**
	 * 根据查询文章实体
	 * 
	 * @param tableName
	 *            :自定义生成的表名
	 * @param map
	 *            获取查询条件的Map key:字段名 value:List 字段的各种判断值 list[0]:是否为自定义字段
	 *            list[1]:是否为整形 list[2]:是否是等值查询 list[3]:字段的值
	 * @return 文章实体
	 */
	@Deprecated
	List<ArticleEntity> queryListForSearch(@Param("tableName") String tableName, @Param("map") Map<String, List> map,
			 @Param("websiteId") int websiteId, @Param("ids") List ids,
			@Param("sortMap") Map sortMap);

	/**
	 * 查询文章编号集合
	 * @param categoryId 栏目编号
	 * @param appId 站点编号
	 * @param beginTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	public List<ColumnArticleIdBean> queryIdsByCategoryIdForParser(@Param("categoryId")int categoryId,@Param("appId")int appId , @Param("beginTime") String beginTime,@Param("endTime") String endTime);
}