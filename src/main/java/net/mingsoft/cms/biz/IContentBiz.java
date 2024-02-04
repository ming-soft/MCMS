/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
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


package net.mingsoft.cms.biz;

import net.mingsoft.base.biz.IBaseBiz;
import net.mingsoft.cms.bean.CategoryBean;
import net.mingsoft.cms.bean.ContentBean;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.mdiy.entity.ModelEntity;

import java.util.List;
import java.util.Map;


/**
 * 文章业务
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
public interface IContentBiz extends IBaseBiz<ContentEntity> {


    /**
     * 根据文章属性查询
     * @param contentBean
     * @return
     */
    List<CategoryBean> queryIdsByCategoryIdForParser(ContentBean contentBean);
    /**
     * 查询文章,不包括单篇
     * @param contentBean
     * @return
     */
    List<CategoryBean> queryContent(ContentBean contentBean);

    /**
     * 文章搜索结果总数，提供搜索使用
     * @param contentModel 文章模型，
     * @param diyList 扩展模型字段 List<Map> key:自定义模型字段:值
     * @param whereMap 条件
     * @param categoryIds 栏目编号集合 格式：1,2,3
     * @return
     */
    int getSearchCount(ModelEntity contentModel, List diyList, Map whereMap, String categoryIds);
    /**
     * 根据文章属性查询,不包括单篇
     * @param contentBean
     * @return
     */
    List<CategoryBean> queryIdsByCategoryIdForParserAndNotCover(ContentBean contentBean);

    /**
     * 根据解析标签arclist的sql获取list
     * @return
     */
    List list(Map map);

}
