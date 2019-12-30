package net.mingsoft.cms.dao;

import net.mingsoft.base.dao.IBaseDao;
import java.util.*;

import net.mingsoft.cms.entity.CategoryEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

/**
 * 分类持久层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
@Component("cmsCategoryDao")
public interface ICategoryDao extends IBaseDao {

    /**
     * 查询当前分类下面的所有子分类
     * @param category 必须存在categoryId categoryParentId
     * @return
     */
    public List<net.mingsoft.cms.entity.CategoryEntity> queryChildren(CategoryEntity category);

}