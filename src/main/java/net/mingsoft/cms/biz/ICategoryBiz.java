package net.mingsoft.cms.biz;

import net.mingsoft.base.biz.IBaseBiz;
import net.mingsoft.cms.entity.CategoryEntity;

import java.util.List;


/**
 * 分类业务
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
public interface ICategoryBiz extends IBaseBiz<CategoryEntity> {

    /**
     * 查询当前分类下的所有子分类
     * @param category
     * @return
     */
    List<CategoryEntity> queryChilds(CategoryEntity category);

    void saveEntity(CategoryEntity entity);

    /**更新父级及子集
     * @param entity
     */
    void updateEntity(CategoryEntity entity);

    /**只更新自身
     * @param entity
     */
    void update(CategoryEntity entity);

    void delete(String categoryId);

    void copyCategory(CategoryEntity entity);
}
