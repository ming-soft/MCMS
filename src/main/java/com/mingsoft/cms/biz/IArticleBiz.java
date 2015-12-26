package com.mingsoft.cms.biz;

import java.util.Date;
import java.util.List;
import java.util.Map;


import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IBasicBiz;
import com.mingsoft.basic.entity.BasicCategoryEntity;
import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.cms.entity.ContentModelEntity;
import com.mingsoft.base.constant.ModelCode;
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
 *          Comments:文章管理业务处理层 || 继承IBasicBiz业务处理层
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
public interface IArticleBiz extends IBasicBiz {

	/**
	 * 按照关键字分页查询
	 * 
	 * @param entity
	 *            实体 <br/>
	 * @param page
	 *            PageUtil对象，主要封装分页的方法 <br/>
	 * @param orderBy
	 *            排序字段 <br/>
	 * @param order
	 *            排序方式true:asc false:desc <br/>
	 * @param keyword
	 *            搜索关键字
	 * @param attribute
	 *            搜索文章属性
	 * @param columnId
	 *            文章所属栏目
	 * @return 返回所查询的文章集合
	 */
	public List<ArticleEntity> queryList(PageUtil page, String orderBy, boolean order, String keyword, String articleType, int basicCategoryId, int webId);

	/**
	 * 显示本网站下文章列表
	 * 
	 * @param webId网站id
	 * @param page
	 *            PageUtil对象，主要封装分页的方法 <br/>
	 * @param orderBy
	 *            排序字段 <br/>
	 * @param order
	 *            排序方式true:asc false:desc <br/>
	 * @return 返回所查询的文章集合
	 */
	public List<ArticleEntity> queryPageListByWebsiteId(int webId, PageUtil page, String orderBy, boolean order);

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
	 * @return 返回所查询的文章集合
	 */
	public List<ArticleEntity> queryList(int webId, List<Integer> basicCategoryId, String flag, String noFlag, int start, int pageSize, String orderBy, boolean order);

	/**
	 * 文章查询
	 * 
	 * @para　 webId　网站编号
	 * @param basicCategoryId
	 *            　栏目编号
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
	 * @return 返回所查询的文章集合
	 */
	public List<ArticleEntity> queryList(int webId, int basicCategoryId, String flag, String noFlag, int start, int pageSize, String orderBy, boolean order);

	/**
	 * 根据页面栏目的id获取与其绑定的文章实体
	 * 
	 * @param basicCategoryId
	 * @return 文章实体
	 */
	public List<ArticleEntity> queryListByColumnId(int basicCategoryId);

	/**
	 * 根据站点id获取文章列表
	 * 
	 * @param basicCategoryId
	 * @return 文章集合
	 */
	public List<ArticleEntity> queryListByWebsiteId(int basicId);

	/**
	 * 根据站点id和文章更新时间获取文章列表
	 * 
	 * @param basicCategoryId
	 * @param UpdateArticleDate
	 * @return 文章集合
	 */
	public List<ArticleEntity> queryListByTime(int basicId, Date UpdateArticleDate);

	/**
	 * 根据文章ID集合查询文章实体集合
	 * 
	 * @param articleIds
	 *            文章ID集合
	 * @return 文章实体集合
	 */
	public List<ArticleEntity> queryListByArticleIds(String articleIds);

	/**
	 * 根据文章字段条件查询文章集合
	 * 
	 * @param articleFieldName
	 *            文章字段
	 * @return 文章ID集合
	 */
	public List<Integer> queryListByArticleField(Map<String, String> articleFieldName);

	/**
	 * 根据文章列表ID，flag,等属性获取文章
	 * 
	 * @param webId
	 *            站点编号
	 * @param ids
	 *            栏目ids
	 * @param flag
	 *            需要的文章属性
	 * @param NoFlag
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
	public List<ArticleEntity> queryListByListArticleId(int webId, List<Integer> articleIds, String flag, String NoFlag, int begin, int count, String orderBy, String order);

	/**
	 * 高级查询接口，主要提供给有自定义模型的栏目，
	 * 
	 * @param conntentModel
	 *            自定义模型
	 * @param whereMap
	 *            條件
	 * @param page
	 *            分頁
	 * @param appId
	 *            應用編號
	 * @param ids
	 *            子类id
	 * @return 记录集合
	 */
	public List<ArticleEntity> queryListForSearch(ContentModelEntity conntentModel, Map whereMap, PageUtil page, int appId, List ids, Map orders);

	/**
	 * 高级查询接口，主要提供给有自定义模型的栏目，返回總數
	 * 
	 * @param contentModel
	 *            自定义模型
	 * @param whereMap
	 *            條件
	 * @param appId
	 *            appId 應用編號
	 * @param ids
	 *            子类id
	 * @return 记录数量
	 */
	public int getSearchCount(ContentModelEntity contentModel, Map whereMap, int appId, List ids);

	/**
	 * 通过视图表来查询文章列表
	 * 
	 * @param categoryId
	 *            分类编号
	 * @param page
	 *            分頁
	 * @param _isHasChilds
	 *            ture:取categoryId下面的子栏目 false:只取categoryId栏目
	 * @return　文章列表
	 */
	public List<BaseEntity> queryPageByCategoryId(int categoryId, int appId,PageUtil page, boolean _isHasChilds);

	/**
	 * 根据文章id集合获取文章列表
	 * 
	 * @param basicId
	 *            　文章id
	 * @param basicIds
	 *            　id集合
	 * @return　列表
	 */
	public List queryByBasicIds(int basicId, Integer[] basicIds);

	/**
	 * 根据文章标题查询文章
	 * 
	 * @param articleTitle
	 *            文章标题
	 * @param webId
	 *            应用Id
	 * @param modelCode
	 *            模块编号
	 * @return 文章分类
	 */
	public List queryListByArticleTitle(String articleTitle, int webId, ModelCode modelCode);

	/**
	 * @para　 webId　网站编号
	 * @param basicCategoryId
	 *            　栏目编号
	 * @param flag
	 *            　文章属性
	 * @param noFlag
	 *            　文章不存在的属性
	 * @param keyword 文章关键字
	 * @return
	 */
	int count(int webId, int basicCategoryId, String flag, String noFlag,String keyword);

	/**
	 * 通过视图表来查询文章总数
	 * 
	 * @param categoryId
	 *            分类编号
	 * @return 总数
	 */
	public int countByCategoryId(int categoryId);

	/**
	 * 根据文章id查找文章的总数
	 * 
	 * @param webId
	 * @param articleIds
	 *            :文章id
	 * @param flag
	 *            推荐属性
	 * @param NoFlag
	 *            不推荐属性
	 * @return
	 */
	public int getCountByArticleIds(int webId, List<Integer> articleIds, String flag, String NoFlag);

	/**
	 * 根据站点Id,栏目列表Id，栏目属性，和栏目不推荐属性查找栏目下的文章总数
	 * 
	 * @param webId
	 *            :站点id
	 * @param basicCategoryIds
	 *            :栏目列表id
	 * @param flag
	 *            :文章推荐属性
	 * @param noFlag
	 *            :文章不推荐属性
	 * @return 文章总数
	 */
	public int getCountByColumnId(int webId, List<Integer> basicCategoryIds, String flag, String noFlag);

	/**
	 * 查询本网站下文章列表数目
	 * 
	 * @param webId网站id
	 * @return 文章条数
	 */
	public int getCountByWebsiteId(int webId);

	/**
	 * 通过视图表来查询文章总数
	 * 
	 * @param basicId
	 *            文章编号
	 */
	public ArticleEntity getById(int basicId);

	/**
	 * 根据分类与时间查询文章列表
	 * 
	 * @param categoryId
	 *            分类编号
	 * @param dateTime
	 *            时间
	 * @param appId
	 *            应用编号
	 * @return 文章
	 */
	public List<ArticleEntity> query(int categoryId, String dateTime, int appId);

	/**
	 * 查找basicId下一篇文章
	 * 
	 * @param appId
	 *            　应用编号
	 * @param basicId
	 *            　文章编号
	 * @return
	 */
	public ArticleEntity getNext(int appId, int basicId,Integer categoryId);

	/**
	 * 查找basicId上一篇文章
	 * 
	 * @param appId
	 *            　应用编号
	 * @param basicId
	 *            　文章编号
	 * @return
	 */
	public ArticleEntity getPrevious(int appId, int basicId,Integer categoryId);

	/**
	 * 通过分类id获取文章内容
	 * 
	 * @param categoryId
	 *            　分类编号
	 * @return
	 */
	public ArticleEntity getByCategoryId(int categoryId);
	
	/**
	 * 根据栏目id查询文章bean
	 * @param categoryId 栏目id
	 * @param page 分页对象
	 * @param _isHasChilds 是否查询子分类的文章,true则进行查询子分类的文章
	 * @return  文章bean
	 */
	public List  queryByCategoryForBean(int appId,Integer categoryId,PageUtil page, boolean _isHasChilds);
	
	/**
	 * 根据分类id查询文章总数
	 * @param categoryId 分类id
	 * @param _isHasChilds 查询的总数是否包括子栏目文章数
	 * @return
	 */
	public int coutByCategoryAndChildsId(int appId,int categoryId, boolean isHasChilds);
	
	/**
	 * 保存文章以及属性信息
	 * @param article 文章实体
	 * @param basicCategoryList 基础表和分类关联实体
	 */
	public void saveArticle(ArticleEntity article,List<BasicCategoryEntity> basicCategoryList);
	
	/**
	 * 保存文章以及属性信息
	 * @param article 文章实体
	 * @param basicCategoryList 基础表和分类关联实体
	 */
	public void updateArticle(ArticleEntity article,List<BasicCategoryEntity> basicCategoryList);
}
