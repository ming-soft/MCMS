package com.mingsoft.cms.biz.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IBasicCategoryBiz;
import com.mingsoft.basic.biz.ICategoryBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.biz.impl.BasicBizImpl;
import com.mingsoft.basic.entity.BasicCategoryEntity;
import com.mingsoft.cms.biz.IArticleBiz;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.cms.biz.IContentModelBiz;
import com.mingsoft.cms.dao.IArticleDao;
import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.cms.entity.ContentModelEntity;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

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
 *          Comments:文章管理业务层实现类 || 继承BasicBizImpl || 实现IArticleBiz
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
@Service("ArticleBizImpl")
public class ArticleBizImpl extends BasicBizImpl implements IArticleBiz {

	
	/**
	 * 文章持久化处理
	 */
	private IArticleDao articleDao;

	/**
	 * 栏目业务处理
	 */
	@Autowired
	private ICategoryBiz categoryBiz;

	/**
	 * 自定类型义业务处理
	 */
	@Autowired
	private IColumnBiz columnBiz;

	/**
	 * 自定义模型
	 */
	@Autowired
	private IContentModelBiz contentModelBiz;
	
	/**
	 * 模块管理业务层
	 */
	@Autowired
	private IModelBiz modelBiz;
	
	/**
	 * 
	 */
	@Autowired
	private IBasicCategoryBiz basicCategoryBiz;

	/**
	 * 获取Article的持久化层
	 * 
	 * @return 返回持Article的久化对象
	 */
	public IArticleDao getArticleDao() {
		return articleDao;
	}

	/**
	 * 设置Article的持久化层
	 * 
	 * @param articleDao
	 */
	@Autowired
	public void setArticleDao(IArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	/**
	 * 获取IBaseDao的持久化层
	 * 
	 * @return 返回持articleDao的久化对象
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return articleDao;
	}

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
	 * @param webId
	 *            网站id
	 * @return 返回所查询的文章集合
	 */
	@Override
	public List<ArticleEntity> queryList(PageUtil page, String orderBy, boolean order, String keyword, String articleType, int basicCategoryId, int webId) {
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		List<Integer> basicCategoryIds = categoryBiz.queryChildrenCategoryIds(basicCategoryId,webId,modelId);
		if(basicCategoryIds == null || !(basicCategoryIds.size() > 0)){
			return articleDao.queryList(webId,null,articleType , null, page.getPageNo() * page.getPageSize(), page.getPageSize(), orderBy, order,keyword);
		}
		return articleDao.queryList(webId,basicCategoryIds, articleType, null, page.getPageNo() * page.getPageSize(), page.getPageSize(), orderBy, order,keyword);
	}

	/**
	 * 查询本网站下文章列表数目
	 * 
	 * @param webId网站id
	 * @return 文章条数
	 */
	@Override
	public int getCountByWebsiteId(int webId) {
		// TODO Auto-generated method stub
		return articleDao.getCountByWebsiteId(webId);
	}

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
	@Override
	public List<ArticleEntity> queryPageListByWebsiteId(int webId, PageUtil page, String orderBy, boolean order) {
		// TODO Auto-generated method stub
		return articleDao.queryPageListByWebsiteId(webId, page.getPageNo(), page.getPageSize(), orderBy, order);
	}

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
	@Override
	public int getCountByColumnId(int webId, List<Integer> basicCategoryIds, String flag, String noFlag) {
		return articleDao.getCountByColumnId(webId, basicCategoryIds.size() > 0 ? basicCategoryIds : null, flag, noFlag);
	}

	/**
	 * 根据栏目ID，flag,等属性获取文章
	 * 
	 * @param basicCategoryIds
	 *            栏目id
	 * @param flag
	 *            需要的文章属性
	 * @param NoFlag
	 *            不需要的文章属性
	 * @param begin
	 *            光标开始位置
	 * @param count
	 *            每页显示条数
	 * @return 文章集合
	 */
	@Override
	public List<ArticleEntity> queryList(int webId, List<Integer> basicCategoryIds, String flag, String noFlag, int begin, int count, String orderBy, boolean order) {
		
		if (orderBy!=null) {
			if (orderBy.equals("sort")) {
				orderBy = "basic_sort";
			} else if (orderBy.equals("date")) {
				orderBy = "basic_datetime";
			} else if (orderBy.equals("hit")) {
				orderBy = "basic_hit";
			} else if (orderBy.equals("updatedate")) {
				orderBy = "basic_updatedate";
			} else if (orderBy.equals("id")) {
				orderBy = "basic_id";
			} 
		}

		
		List<ArticleEntity> articleList = articleDao.queryList(webId, basicCategoryIds.size() > 0 ? basicCategoryIds : null, flag, noFlag, begin, count, orderBy, order,null);
		return articleList;
	}

	/**
	 * 根据页面栏目的id获取与其绑定的文章实体
	 * 
	 * @param basicCategoryId
	 * @return 文章实体
	 */
	@Override
	public List<ArticleEntity> queryListByColumnId(int basicCategoryId) {
		// TODO Auto-generated method stub
		return articleDao.queryListByColumnId(basicCategoryId);
	}

	/**
	 * 根据站点id获取文章列表
	 * 
	 * @param basicId
	 * @return 文章集合
	 */
	@Override
	public List<ArticleEntity> queryListByWebsiteId(int basicId) {
		// TODO Auto-generated method stub
		return articleDao.queryListByWebsiteId(basicId);
	}

	/**
	 * 根据站点id和文章更新时间获取文章列表
	 * 
	 * @param basicCategoryId
	 * @param UpdateArticleDate
	 * @return 文章集合
	 */
	@Override
	public List<ArticleEntity> queryListByTime(int basicId, Date UpdateArticleDate) {
		// TODO Auto-generated method stub
		List<ArticleEntity> articleList = queryListByWebsiteId(basicId);
		List<ArticleEntity> newArticle = new ArrayList<ArticleEntity>();
		for (int i = 0; i < articleList.size(); i++) {
			// 如果UpdateArticleDate在文章时间之前
			if (articleList.get(i).getBasicUpdateTime().before(UpdateArticleDate)) {
				newArticle.add(articleList.get(i));
			}
		}
		return newArticle;
	}

	/**
	 * 根据文章ID集合查询文章实体集合
	 * 
	 * @param articleIds
	 *            文章ID集合
	 * @return 文章实体集合
	 */
	@SuppressWarnings("rawtypes")
	public List<ArticleEntity> queryListByArticleIds(@Param("articleIds") String articleIds) {
		Integer[] articleIdsList = StringUtil.stringsToIntegers(articleIds.split(","));
		List list = Arrays.asList(articleIdsList);
		return articleDao.queryListByArticleIds(list);
	}

	/**
	 * 根据文章字段条件查询文章集合
	 * 
	 * @param articleFieldName
	 *            文章字段
	 * @return 文章ID集合
	 */
	public List<Integer> queryListByArticleField(Map<String, String> articleFieldName) {
		List<ArticleEntity> listArticle = articleDao.queryListByArticleField(articleFieldName);
		List<Integer> listArticleId = new ArrayList<Integer>();
		for (int i = 0; i < listArticle.size(); i++) {
			listArticleId.add(listArticle.get(i).getBasicId());
		}
		return listArticleId;
	}

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
	@Override
	public int getCountByArticleIds(int webId, List<Integer> articleIds, String flag, String NoFlag) {
		// TODO Auto-generated method stub
		return articleDao.getCountByArticleIds(webId, articleIds, flag, NoFlag);
	}

	/**
	 * 根据文章id集合查找文章实体
	 * 
	 * @param webId
	 *            :站点id
	 * @param articleIds
	 *            :文章id集合
	 * @param flag
	 *            :推荐属性
	 * @param NoFlag
	 *            :不推荐属性
	 * @param begin
	 *            :开始处
	 * @param count
	 *            :查询总数
	 * @param orderBy
	 *            :排序方式
	 * @param order
	 *            :
	 * @return
	 */
	@Override
	public List<ArticleEntity> queryListByListArticleId(int webId, List<Integer> articleIds, String flag, String NoFlag, int begin, int count, String orderBy, String order) {
		// TODO Auto-generated method stub
		List<ArticleEntity> articleList = articleDao.queryListByListArticleId(webId, articleIds.size() > 0 ? articleIds : null, flag, NoFlag, begin, count, orderBy,
				(order == null || order != "false") ? true : false);
		return articleList;
	}

	public List<ArticleEntity> queryListForSearch(ContentModelEntity conntentModel, Map whereMap, PageUtil page, int websiteId,List ids,Map orders) {
		List<ArticleEntity> articleList = new ArrayList<ArticleEntity>();
		String tableName = null;
		if (conntentModel!=null) {
			tableName = conntentModel.getCmTableName();
		}
		// 查找所有符合条件的文章实体
		articleList = articleDao.queryListForSearch(tableName, whereMap, page, websiteId,ids,orders);
		return articleList;
	}

	public int getSearchCount(ContentModelEntity contentModel,Map wherMap, int websiteId,List  ids) {
		if (contentModel!=null) {
			return articleDao.getSearchCount(contentModel.getCmTableName(),wherMap, websiteId,ids);
		}
		return articleDao.getSearchCount(null,wherMap, websiteId,ids);
	}



	@Override
	public List<BaseEntity> queryPageByCategoryId(int categoryId,int appId, PageUtil page, boolean _isHasChilds) {
		// TODO Auto-generated method stub
		// return articleDao.queryByView(categoryId, page);
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		List list = categoryBiz.queryChildrenCategory(categoryId,appId,modelId);
		// 分类不存在直接返回
		if (list == null || list.size() == 0) {
			return null;
		}

		// 如果是最低级栏目需要查询该栏目是否存在自定义模型，如果存在需要再关联自定义模型查询
		if (list.size() == 1) { // 最低级栏目
			ColumnEntity column = (ColumnEntity) columnBiz.getEntity(categoryId);
			if (column.getColumnContentModelId() != 0) { // 存在自定义模型
				ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(column.getColumnContentModelId());
				return articleDao.queryPageByCategoryId(categoryId, null, page, contentModel.getCmTableName());
			} else {
				return articleDao.queryPageByCategoryId(categoryId, null, page, null);
			}
		} else {
			if (_isHasChilds) {
				return articleDao.queryPageByCategoryId(categoryId, list, page, null);
			} else {
				return articleDao.queryPageByCategoryId(categoryId, null, page, null);
			}
		}

	}

	@Override
	public int countByCategoryId(int categoryId) {
		// TODO Auto-generated method stub
		return articleDao.countByCategoryId(categoryId);
	}

	@Override
	public ArticleEntity getById(int basicId) {
		// TODO Auto-generated method stub
		ArticleEntity article = (ArticleEntity) articleDao.getEntity(basicId);
		String contentModelTableName = null;
		int ccmi = article.getColumn().getColumnContentModelId(); // 内容模型编号
		if (ccmi > 0) {
			ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(ccmi);
			contentModelTableName = contentModel.getCmTableName();
		}
		List temp = articleDao.getById(basicId, contentModelTableName);
		if (temp != null && temp.size() > 0) {
			return (ArticleEntity) temp.get(0);
		}
		return null;
	}

	@Override
	public List queryByBasicIds(int basicId, Integer[] basicIds) {
		return articleDao.queryByBasicIds(basicId, basicIds);
	}

	@Override
	public List<ArticleEntity> queryList(int webId, int basicCategoryId, String flag, String noFlag, int start, int pageSize, String orderBy, boolean order) {
		return articleDao.query(webId, basicCategoryId, flag, noFlag, start, pageSize, orderBy, order);
	}

	@Override
	public int count(int webId, int basicCategoryId, String flag, String noFlag,String keyword) {
		return articleDao.count(webId, basicCategoryId, flag, noFlag,keyword);
	}

	/**
	 * 根据文章标题查询文章
	 * 
	 * @param articleTitle
	 *            文章标题
	 * @param webId
	 *            应用Id
	 * @param modelCode
	 *            模块编号
	 * @return 文章集合
	 */
	public List queryListByArticleTitle(String articleTitle, int webId, ModelCode modelCode) {
		// 将文章标题截断
		String[] _articleTitle = articleTitle.split(",");
		if (_articleTitle.length > 1) {
			articleTitle = _articleTitle[1];
		} else {
			articleTitle = _articleTitle[0];
		}
		// 查询文章集合
		List<ArticleEntity> articleList = this.articleDao.queryByArticleTitle(articleTitle, webId, modelCode.toString());
		return articleList;
	}

	@Override
	public List<ArticleEntity> query(int categoryId, String dateTime,int appId) {
		return articleDao.queryListByTime(categoryId, dateTime,appId);
	}

	@Override
	public ArticleEntity getNext(int appId, int basicId,Integer categoryId) {
		// TODO Auto-generated method stub
		return articleDao.getNextOrPrevious(appId, basicId, true,categoryId);
	}

	@Override
	public ArticleEntity getPrevious(int appId, int basicId,Integer categoryId) {
		// TODO Auto-generated method stub
		return articleDao.getNextOrPrevious(appId, basicId, false,categoryId);
	}

	@Override
	public ArticleEntity getByCategoryId(int categoryId) {
		// TODO Auto-generated method stub
		List list = articleDao.getByCategoryId(categoryId);
		if (list != null && list.size() > 0) {
			return (ArticleEntity) list.get(0);
		}
		return null;
	}

	@Override
	public List  queryByCategoryForBean(int appId,Integer categoryId,
			PageUtil page,boolean _isHasChilds) {
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		//查询该分类下的所有子分类
		List list = categoryBiz.queryChildrenCategory(categoryId,appId,modelId);
		// 分类不存在直接返回
		if (list == null || list.size() == 0) {
				return null;
		}
		//如果没有子分类
		if(list.size()==1){
			ColumnEntity column = (ColumnEntity) columnBiz.getEntity(categoryId);
			if (column.getColumnContentModelId() != 0) { // 存在自定义模型
				ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(column.getColumnContentModelId());
				return articleDao.queryByCategoryForBean(categoryId, null, page, contentModel.getCmTableName());
			} else {
				return articleDao.queryByCategoryForBean(categoryId, null, page, null);
			}
		}else{
			if (_isHasChilds) {
				return articleDao.queryByCategoryForBean(categoryId, list, page,null);
			} else {
				return articleDao.queryByCategoryForBean(categoryId, null, page,null);
			}
		}
	}

	@Override
	public int coutByCategoryAndChildsId(int appId,int categoryId, boolean isHasChilds) {
		// TODO Auto-generated method stub
		int count = 0;
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		//查询该分类下的所有子分类
		if(isHasChilds){
			List<Integer> basicCategoryIds = categoryBiz.queryChildrenCategoryIds(categoryId, appId,modelId);
			count=this.getCountByColumnId(appId, basicCategoryIds, null, null);
		}else{
			count=this.countByCategoryId(categoryId);
		}
		return count;
	}

	@Override
	public void saveArticle(ArticleEntity article, List<BasicCategoryEntity> basicCategoryList) {
		// TODO Auto-generated method stub
		this.saveBasic(article);
		List<BasicCategoryEntity> newBasicCategoryList = new ArrayList<BasicCategoryEntity>();
		for(int i=0;i<basicCategoryList.size();i++){
			BasicCategoryEntity basicCategory= basicCategoryList.get(i);
			basicCategory.setBcBasicId(article.getBasicId());
			newBasicCategoryList.add(basicCategory);
			
		}
		if(newBasicCategoryList!=null &&newBasicCategoryList.size()>0){
			this.basicCategoryBiz.deleteEntity(article.getBasicId());
			this.basicCategoryBiz.saveBatch(newBasicCategoryList);
		}
		
	}

	@Override
	public void updateArticle(ArticleEntity article, List<BasicCategoryEntity> basicCategoryList) {
		// TODO Auto-generated method stub
		this.updateBasic(article);
		if(article!=null){
			
			if(basicCategoryList!=null &&basicCategoryList.size()>0){
				this.basicCategoryBiz.deleteEntity(article.getBasicId());
				this.basicCategoryBiz.saveBatch(basicCategoryList);
			}
			
		}
		
	}

	
	
	
	
}
