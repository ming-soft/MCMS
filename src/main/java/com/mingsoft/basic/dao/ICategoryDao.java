package com.mingsoft.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.CategoryEntity;
import com.mingsoft.util.PageUtil;

/**
 * 类别数据持久层，继承IBaseDao
 * @author 刘继平
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface ICategoryDao extends IBaseDao {

	/**
     * 分页查询</br>
     * 查询分类集合</br>
	 * @param category 分类实体
	 * @param page pageUtil实体
	 * @param orderBy 排序字段
	 * @param order 排序方式true:asc false:desc
	 * @return 返回分类集合
	 */
	public List<CategoryEntity> queryByPageList(@Param("category")CategoryEntity category,@Param("page")PageUtil page,@Param("orderBy")String orderBy,@Param("order") boolean order);
	
    /**
     * 根据分类ID查询子分类</br>
     * @param category 分类实体
     */
    public List<CategoryEntity> queryChilds(@Param("category")CategoryEntity category);
    
    
    /**
     * 根据分类ID查询子分类总数</br>
     * @param category 分类实体
     */
    public int count(@Param("category")CategoryEntity category);
    
    /**
     * 根据modelId查询分类
     * @param category 分类实体
     * @return 返回分类集合
     */
    public List<CategoryEntity> queryByModelId(@Param("category")CategoryEntity category);
    
    /**
     * 根据分类名称查询分类Id集合(课表数据采集使用)
     * @param categoryTitle 分类名称
     * @param categoryModelId 模块ID
     * @return 返回查询到的分类集合
     */
    public List <Integer> queryCategoryIdByTitle(@Param("categoryTitle")String categoryTitle,@Param("categoryModelId")int categoryModelId);
    
    /**
     * 根据学校名称查询该学校所有专业ID
     * @param categoryTitle 学校名称
     * @param fatherModelId 系所属模块ID
     * @param sonModelId 子分类模块ID
     * @return 返回该学校下专业ID的集合
     * @deprecated 因为categoryTitle可能会出现重复
     */
    public List<Integer> queryCategoryIdByCategoryTitle(@Param("categoryTitle")String categoryTitle,@Param("fatherModelId")int fatherModelId,@Param("sonModelId")int sonModelId);
    
    /**
     * 查询categoryId分类下的子分类数据
     * @param categoryId 父分类编号
     * @param fatherModelId 父分类所属模块ID
     * @param sonModelId 子分类模块ID
     * @return 返回子分类集合
     */
    public List<Integer> queryCategoryIdByCategoryId(@Param("categoryId")int categoryId,@Param("fatherModelId")int fatherModelId,@Param("sonModelId")int sonModelId);
    
    /**
     * 根据ID批量查询分类实体
     * @param listId ID集合
     * @return 返回分类实体
     */
    public List<CategoryEntity> queryBatchCategoryById(@Param("listId")List<Integer> listId);
    
    /**
     * 查询当前分类下面的子分类
     * @param categoryId　当前分类编号
     * @param appId　应用编号
     * @return　返回子分类列表
     */
    public List<CategoryEntity> queryChildrenCategoryId(@Param("categoryId")int categoryId,@Param("appId")int appId,@Param("modelId")int modelId);


	/**
	 * 根据应用编号与模块编号查询分类
	 * 
	 * @param appId 应用编号
	 * @param modelId 模块编号
	 * @return 返回分类集合
	 */
	public List<CategoryEntity> queryByAppIdOrModelId(@Param("appId")Integer appId,@Param("modelId") Integer modelId);

	/**
	 * 递归活取父栏目，
	 * @param categoryId 
	 * @return  返回父类id，格式 1,3,4,5
	 */
	public String queryParentIds(int categoryId);
	
	/**
	 * 主要用于属性查询
	 * @param appId 应用id
	 * @param modelId 模块id
	 * @param categoryDescription 分类描述
	 * @return 返回分类集合
	 */
	public List<CategoryEntity> queryByDescription(@Param("appId")Integer appId,@Param("modelId") Integer modelId,@Param("categoryDescription")String categoryDescription);
	
	 /**
     * 查询当前分类下面的子分类
     * @param categoryId　当前分类编号
     * @param appId　应用编号
     * @param modelId 模块Id
     * @return　返回子分类列表集合
     */
    public List<CategoryEntity> queryChildrenCategoryIdByModelId(@Param("categoryId")Integer categoryId,@Param("appId")int appId,@Param("modelId")int modelId);
}
