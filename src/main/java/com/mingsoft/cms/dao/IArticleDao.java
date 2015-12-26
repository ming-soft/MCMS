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
	 * 获取站点下文章总条数
	 * 
	 * @param webId
	 *            webId 站点id<br/>
	 * @return 返回查询总条数
	 */
	public int getCountByWebsiteId(@Param("webId") int webId);

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
	public List<ArticleEntity> queryPageListByWebsiteId(@Param("webId") int webId, @Param("pageNo") int pageNo, @Param("pageSize") int pageSize,
			@Param("orderBy") String orderBy, @Param("order") boolean order);

	/**
	 * 根据栏目id获取该栏目下所有文章
	 * 
	 * @param typeId
	 *            文章所属栏目
	 * @param articleId
	 *            文章id
	 * @return Map集合
	 */
	public List<ArticleEntity> queryArticleMap(@Param("basicCategoryId") int basicCategoryId);

	/**
	 * 查询指定栏目下的需要的文章属性和不需要的文章属性
	 * 
	 * @param basicCategoryIds
	 *            栏目id<br/>
	 * @param flag
	 *            需要的文章属性<br/>
	 * @param noFlag
	 *            不需要的文章属性<br/>
	 * @return 返回查询总条数
	 */
	@SuppressWarnings("rawtypes")
	public int getCountByColumnId(@Param("webId") int webId, @Param("basicCategoryIds") List basicCategoryIds, @Param("flag") String flag,
			@Param("noFlag") String noFlag);

	/**
	 * 根据栏目ID，flag,等属性获取文章
	 * 
	 * @param webId
	 *            站点编号
	 * @param ids
	 *            栏目ids
	 * @param flag
	 *            需要的文章属性
	 * @param noFlag
	 *            不需要的文章属性
	 * @param begin光标开始位置
	 * @param count
	 *            每页显示条数
	 * @param orderBy
	 *            排序依据字段
	 * @param order
	 *            false,true
	 * @param keyword
	 *            关键字   
	 * @return 文章集合
	 */
	public List<ArticleEntity> queryList(@Param("webId") int webId, @Param("basicCategoryIds") List<Integer> basicCategoryIds,
			@Param("flag") String flag, @Param("noFlag") String noFlag, @Param("begin") int begin, @Param("count") int count,
			@Param("orderBy") String orderBy, @Param("order") boolean order,@Param("keyword") String keyword);
	
	
	/**
	 * 文章查询
	 * 
	 * @para　 webId　网站编号
	 * @param basicCategoryId
	 *            　栏目编号集合
	 * @param flag
	 *            　文章属性
	 * @param noFlag
	 *            　文章不存在的属性
	 * @param start
	 *            　开始位置
	 * @param pageSize
	 *            　一页显示数量
	 * @param orderBy
	 *            　排序字段
	 * @param order
	 *            　排序方式
	 * @return 文章集合
	 */
	public List<ArticleEntity> query(@Param("webId") int webId, @Param("basicCategoryId") int basicCategoryId,
			@Param("flag") String flag, @Param("noFlag") String noFlag, @Param("begin") int begin, @Param("count") int count,
			@Param("orderBy") String orderBy, @Param("order") boolean order);
	
	/**
	 * @para　 webId　网站编号
	 * @param basicCategoryId
	 *            　栏目编号
	 * @param flag
	 *            　文章属性
	 * @param noFlag
	 *            　文章不存在的属性
	 * @param keyword 文章关键字
	 * @return 文章总数
	 */
	int count(@Param("webId")int webId, @Param("basicCategoryId") int basicCategoryId, @Param("flag")String flag, @Param("noFlag")String noFlag,@Param("keyword")String keyword);


	/**
	 * 根据页面栏目的id获取与其绑定的文章实体
	 * 
	 * @param basicCategoryId
	 * @return 文章实体
	 */
	public List<ArticleEntity> queryListByColumnId(@Param("basicCategoryId") int basicCategoryId);

	/**
	 * 根据站点获取的所有栏目
	 * 
	 * @param basicId
	 * @return 文章集合
	 */
	public List<ArticleEntity> queryListByWebsiteId(@Param("basicId") int basicId);

	/**
	 * 根据栏目id和文章更新时间获取文章
	 * 
	 * @param basicCategoryId 分类编号
	 * @param dateTime　时间
	 * @param appId　应用时间
	 * @return 文章集合
	 */
	public List<ArticleEntity> queryListByTime(@Param("basicCategoryId") int basicCategoryId, @Param("dateTime") String dateTime,@Param("appId") int appId);

	/**
	 * 根据文章ID集合查询文章实体集合
	 * 
	 * @param articleIds
	 *            文章ID集合
	 * @return 文章实体集合
	 */
	@SuppressWarnings("rawtypes")
	public List<ArticleEntity> queryListByArticleIds(@Param("articleIds") List articleIds);

	/**
	 * 根据文章字段条件查询文章集合
	 * 
	 * @param articleFieldName
	 *            文章字段
	 * @return 文章ID集合
	 */
	public List<ArticleEntity> queryListByArticleField(@Param("articleFieldName") Map<String, String> articleFieldName);

	/**
	 * 根据文章id查找文章的总数
	 * 
	 * @param webId
	 * @param articleIds
	 *            :文章id
	 * @param flag
	 *            推荐属性
	 * @param noFlag
	 *            不推荐属性
	 * @return 文章总数
	 */
	public int getCountByArticleIds(@Param("webId") int webId, @Param("articleIds") List<Integer> articleIds, @Param("flag") String flag,
			@Param("noFlag") String noFlag);

	/**
	 * 根据文章列表ID，flag,等属性获取文章
	 * 
	 * @param webId
	 *            站点编号
	 * @param ids
	 *            栏目ids
	 * @param flag
	 *            需要的文章属性
	 * @param noFlag
	 *            不需要的文章属性
	 * @param begin光标开始位置
	 * @param count
	 *            每页显示条数
	 * @param orderBy
	 *            排序依据字段
	 * @param order
	 *            false,true
	 * @return 文章集合
	 */
	public List<ArticleEntity> queryListByListArticleId(@Param("webId") int webId, @Param("articleIds") List<Integer> articleIds,
			@Param("flag") String flag, @Param("noFlag") String noFlag, @Param("begin") int begin, @Param("count") int count,
			@Param("orderBy") String orderBy, @Param("order") boolean order);

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
	public List<ArticleEntity> queryListForSearch(@Param("tableName") String tableName, @Param("map") Map<String, List> map,
			@Param("page") PageUtil page, @Param("websiteId") int websiteId,@Param("ids") List ids,@Param("sortMap") Map sortMap);

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
	public int getSearchCount(@Param("tableName") String tableName, @Param("map") Map<String, List> map, @Param("websiteId") int websiteId,@Param("ids")List ids);

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
	public List<BaseEntity> queryPageByCategoryId(@Param("categoryId") int categoryId, @Param("categoryIds") List categoryIds, @Param("page") PageUtil page,
			@Param("contentModelTableName") String contentModelTableName);

	/**
	 * 通过视图表来查询文章总数
	 * 
	 * @param categoryId
	 *            分类编号
	 * @return 总数
	 */
	public int countByCategoryId(@Param("categoryId") int categoryId);
	
	/**
	 * 通过分类id获取文章内容
	 * @param categoryId　分类编号
	 * @return 文章集合
	 */
	public List getByCategoryId(@Param("categoryId") int categoryId);
	
	/**
	 * 通过视图表来查询文章总数
	 * 
	 * @param basicId
	 *            文章编号
	 * @param contentModelTableName
	 *           对应模块表名称
	 */
	public List getById(@Param("basicId") int basicId,@Param("contentModelTableName") String contentModelTableName);
	
	/**
	 * 根据文章id集合获取文章列表
	 * @param basicId　文章编号，便于提供UNION使用
	 * @param basicIds　id集合
	 * @return　列表
	 */
	public List queryByBasicIds(@Param("basicId")int basicId,@Param("basicIds") Integer[] basicIds);
	
	/**
	 * 通过文章标题来查询文章集合
	 * @param articleTitle 文章标题
	 * @param webId 应用ID
	 * @param modelCode 模块编号
	 * @return basicTitle,categoryId的map集合
	 */
	public List  queryByArticleTitle(@Param("articleTitle")String articleTitle,@Param("webId")int webId,@Param("modelCode")String modelCode);
	
	/**
	 * 根据分类与时间查询文章列表
	 * @param categoryId 分类编号
	 * @param dateTime 时间
	 * @return 文章
	 */
	public List<ArticleEntity> query(@Param("categoryId")Integer categoryId,@Param("dateTime")String dateTime);

	/**
	 * 查找basicId上一篇文章
	 * @param appId　应用编号
	 * @param basicId　文章编号
	 * @param flag　true:上一条 false:下一条
	 * @return
	 */
	public ArticleEntity getNextOrPrevious(@Param("appId")int appId, @Param("basicId")int basicId, @Param("flag")boolean flag,@Param("categoryId")Integer categoryId);
	
	/**
	 * 根据栏目id删除文章实体
	 * @param columnId 栏目id
	 */
	public void deleteByColumnId(int columnId);
	

	
	/**
	 * 查询文章bean实体，只返回文章的基本信息
	 * @param appId 应用id
	 * @param categoryId 分类id
	 * @param categoryIds 子分类集合
	 * @return 文章集合
	 */
	public List queryByCategoryForBean(@Param("categoryId")Integer categoryId,@Param("categoryIds") List categoryIds,@Param("page") PageUtil page,@Param("contentModelTableName") String contentModelTableName);
	
	
}
