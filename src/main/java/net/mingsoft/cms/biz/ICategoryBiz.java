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
public interface ICategoryBiz extends IBaseBiz {

    /**
     * 查询当前分类下的所有子分类
     * @param category
     * @return
     */
    List<CategoryEntity> queryChilds(CategoryEntity category);

    void saveEntity(CategoryEntity entity);

    void updateEntity(CategoryEntity entity);

    void delete(int categoryId);
}