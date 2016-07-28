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

package com.mingsoft.cms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.util.PageUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞MS平台</b>
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
 * @author 姓名 郭鹏辉
 * 
 * @version 300-001-001
 * 
 *          <p>
 *          版权所有 铭飞科技
 *          </p>
 * 
 *          <p>
 *          Comments:文章管理持久化层 || 继承IBaseDao持久化层
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
	int count(@Param("webId") int webId, @Param("basicCategoryIds") int[] basicCategoryIds, @Param("flag") String flag,
			@Param("noFlag") String noFlag, @Param("article") ArticleEntity article);

	/**
	 * 通过视图表来查询文章总数 ，
	 * 
	 * @see IArticleDao.count
	 * @param categoryId
	 *            分类编号
	 * @return 总数
	 */
	@Deprecated
	int countByCategoryId(@Param("categoryId") int categoryId);

	/**
	 * 根据栏目id和文章更新时间获取文章
	 * 
	 * @param basicCategoryId
	 *            分类编号
	 * @param dateTime
	 *            时间
	 * @param appId
	 *            应用时间
	 * @return 文章集合
	 */
	@Deprecated
	List<ArticleEntity> queryListByTime(@Param("basicCategoryId") int basicCategoryId,
			@Param("dateTime") String dateTime, @Param("appId") int appId);

	/**
	 * 通过视图表来查询文章列表
	 * 
	 * @param categoryId
	 *            分类编号
	 * 
	 * @param categoryIds
	 *            分类编号集合
	 * @param page
	 *            分頁
	 * @param contentModelTableName
	 *            关联模型表，更具分类id自动绑定
	 * @return
	 */
	@Deprecated
	List<BaseEntity> queryPageByCategoryId(@Param("categoryId") int categoryId, @Param("categoryIds") List categoryIds,
			@Param("page") PageUtil page, @Param("contentModelTableName") String contentModelTableName);

	/**
	 * 通过分类id获取文章内容
	 * 
	 * @param categoryId
	 *            分类编号
	 * @return 文章集合
	 */
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
	 * 查询指定栏目下的需要的文章属性和不需要的文章属性
	 * 
	 * @see IArticleDao.count
	 * @param basicCategoryIds
	 *            栏目id<br/>
	 * @param flag
	 *            需要的文章属性<br/>
	 * @param noFlag
	 *            不需要的文章属性<br/>
	 * @return 返回查询总条数
	 */
	@Deprecated
	@SuppressWarnings("rawtypes")
	int getCountByColumnId(@Param("webId") int webId, @Param("basicCategoryIds") int[] basicCategoryIds,
			@Param("flag") String flag, @Param("noFlag") String noFlag);

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
	@Deprecated
	int getSearchCount(@Param("tableName") String tableName, @Param("map") Map<String, List> map,
			@Param("websiteId") int websiteId, @Param("ids") List ids);

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
	 * @return 文章集合
	 */
	List<ArticleEntity> query(@Param("webId") int webId, @Param("basicCategoryIds") int[] basicCategoryIds,
			@Param("flag") String flag, @Param("noFlag") String noFlag, @Param("orderBy") String orderBy,
			@Param("order") boolean order, @Param("article") ArticleEntity article);

	/**
	 * 通过文章标题来查询文章集合
	 * 
	 * @see IArticleDao.query
	 * @param articleTitle
	 *            文章标题
	 * @param webId
	 *            应用ID
	 * @param modelCode
	 *            模块编号
	 * @return basicTitle,categoryId的map集合
	 */
	@Deprecated
	List queryByArticleTitle(@Param("articleTitle") String articleTitle, @Param("webId") int webId,
			@Param("modelCode") String modelCode);

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
			@Param("page") PageUtil page, @Param("websiteId") int websiteId, @Param("ids") List ids,
			@Param("sortMap") Map sortMap);

	/**
	 * 根据站点获取文章列表
	 * 
	 * @param webId
	 *            站点id
	 * @param pageNo
	 * @param pageSize
	 * @param orderBy
	 *            排序字段 <br/>
	 * @param order
	 *            排序方式true:asc false:desc <br/>
	 * @return 文章集合
	 */
	@Deprecated
	public List<ArticleEntity> queryPageListByWebsiteId(@Param("webId") int webId, @Param("pageNo") int pageNo, @Param("pageSize") int pageSize,
			@Param("orderBy") String orderBy, @Param("order") boolean order);
	
	/**
	 * 获取站点下文章总条数
	 * 
	 * @param webId
	 *            webId 站点id<br/>
	 * @return 返回查询总条数
	 */
	@Deprecated
	public int getCountByWebsiteId(@Param("webId") int webId);
	
	/**
	 * 根据文章ID集合查询文章实体集合
	 * 
	 * @param articleIds
	 *            文章ID集合
	 * @return 文章实体集合
	 */
	@Deprecated
	@SuppressWarnings("rawtypes")
	public List<ArticleEntity> queryListByArticleIds(@Param("articleIds") List articleIds);


}