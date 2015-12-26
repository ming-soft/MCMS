package com.mingsoft.basic.biz;

import java.util.List;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.CategoryEntity;
import com.mingsoft.util.PageUtil;


/**
 * 类别业务层接口，继承接口IBaseBiz
 * @author 刘继平
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface ICategoryBiz extends IBaseBiz {

	/**
	 * 添加类别</br> 有拓展表继承时使用</br>
	 * 
	 * @param categoryEntity 类别实体
	 * @return 返回类别ID
	 */
	public int saveCategory(CategoryEntity categoryEntity);

	/**
	 * 添加类别</br> 没有拓展表继承时使用</br>
	 * 
	 * @param categoryEntity 类别实体
	 * @return 返回类别ID
	 */
	public int saveCategoryEntity(CategoryEntity categoryEntity);

	/**
	 * 根据分类标题和分类的模块ID查询该分类是否存在</br> 若存在则不持久化直接返回数据库中原来的数据</br> 若不存在则持久化并返回实体信息
	 * 
	 * @param categoryTitle
	 *            分类标题
	 * @param categoryCategoryId
	 *            父ID
	 * @param categoryModelId
	 *            模块ID
	 * @return 返回分类实体
	 */
	public CategoryEntity saveByCategoryTitle(String categoryTitle, int categoryCategoryId, int categoryModelId);

	/**
	 * 类别更新</br> 有拓展表继承时使用</br>
	 * 
	 * @param categoryEntity 类别实体
	 */
	public void updateCategory(CategoryEntity categoryEntity);

	/**
	 * 类别更新</br> 没有拓展表继承时使用</br>
	 * 
	 * @param categoryEntity 类别实体
	 */
	public void updateCategoryEntity(CategoryEntity categoryEntity);

	/**
	 * 删除类别</br> 有拓展表继承时使用</br>
	 * 
	 * @param categoryId 类别ID
	 */
	public void deleteCategory(int categoryId);

	/**
	 * 删除类别</br> 没有拓展表继承时使用</br>
	 * 
	 * @param categoryId 类别ID
	 */
	public void deleteCategoryEntity(int categoryId);

	/**
	 * 获取类别
	 * 
	 * @param categoryId 类别ID
	 * @return 返回类别实体
	 */
	public CategoryEntity getCategory(int categoryId);

	/**
	 * 分页查询</br> 查询分类集合</br>
	 * 
	 * @param category
	 *            查询条件
	 * @param page
	 *            对象，主要封装分页的方法
	 * @param orderBy
	 *            排序字段
	 * @param order
	 *            排序方式true:asc false:desc
	 * @return 返回分类集合
	 */
	public List queryByPageList(CategoryEntity category, PageUtil page, String orderBy, boolean order);

	/**
	 * 根据分类ID查询子分类</br>
	 * 
	 * @param category 分类实体
	 * @return 返回分类集合
	 */
	public List<CategoryEntity> queryChilds(CategoryEntity category);

	/**
	 * 根据分类ID查询子分类总数</br>
	 * 
	 * @param category 分类实体
	 * @return 返回子分类总数
	 */
	public int count(CategoryEntity category);

	/**
	 * 根据modelId查询分类
	 * 
	 * @param category 分类实体
	 * @return 返回分类集合
	 */
	public List<CategoryEntity> queryByModelId(CategoryEntity category);

	/**
	 * 根据分类名称查询分类ID集合(课表数据采集使用)
	 * 
	 * @param categoryTitle 分类名称
	 * @param categoryModelId 模块ID
	 * @return 返回分类集合
	 */
	public List<Integer> queryCategoryIdByTitle(String categoryTitle, int categoryModelId);

	/**
	 * 根据学校名称查询该学校所有专业ID
	 * 
	 * @param categoryTitle
	 *            学校名称
	 * @param fatherModelId
	 *            系所属模块ID
	 * @param sonModelId
	 *            学校所属模块ID
	 * @return 返回该学校下专业ID的集合
	 */
	public List<Integer> queryCategoryIdByCategoryTitle(String categoryTitle, int fatherModelId, int sonModelId);

	/**
	 * 根据ID批量查询分类实体
	 * 
	 * @param listId ID集合
	 * @return 返回分类实体集合
	 */
	public List<CategoryEntity> queryBatchCategoryById(List<Integer> listId);

	/**
	 * 查询当前分类下面的子分类
	 * 
	 * @param categoryId 当前分类编号
	 * @param appId 应用编号
	 * @return　返回子分类列表集合
	 */
	public List<CategoryEntity> queryChildrenCategory(int categoryId, int appId,int modelId);

	/**
	 * 查询当前分类下面的子分类的id
	 * 
	 * @param categoryId 当前分类编号
	 * @return appId 应用编号
	 * @return　返回子分类id集合
	 */
	public List<Integer> queryChildrenCategoryIds(int categoryId, int appId,int modelId);

	/**
	 * 根据应用编号与模块编号查询分类
	 * 
	 * @param appId 应用编号
	 * @param modelId 模块编号
	 * @return 返回分类集合
	 */
	public List<CategoryEntity> queryByAppIdOrModelId(Integer appId, Integer modelId);
	
	/**
	 * 递归活取父栏目，
	 * @param appId
	 *            应用编号
	 * @param modelId
	 *            模块编号
	 * @param categoryId 可选
	 * @return  返回分类集合
	 */
	public List<CategoryEntity> queryParent(int appId, int modelId,Integer categoryId);
	
	/**
	 * 主要用于属性查询
	 * @param appId 应用id
	 * @param modelId 模块id
	 * @param categoryDescription 分类描述
	 * @return 返回分类列表
	 */
	public List<CategoryEntity> queryByDescription(int appId, int modelId,String categoryDescription);
	
	/**
	 * 根据应用id和模块id查询分类id的集合
	 * @param appId  应用id
	 * @param modelId 模块id
	 * @return 返回ID集合
	 */
	 public List<Integer> queryCategoryIdsByModelIdAndAppId(int appId,int modelId);
}
