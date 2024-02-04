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


package net.mingsoft.cms.aop;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.Query;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.exception.BusinessException;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.constant.e.CategoryDisplayEnum;
import net.mingsoft.cms.constant.e.CategoryIsSearchEnum;
import net.mingsoft.cms.constant.e.CategoryTypeEnum;
import net.mingsoft.cms.dao.ICategoryDao;
import net.mingsoft.cms.dao.IContentDao;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.entity.ContentEntity;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


/**
 * 增加移动审批权限
 */

@Aspect
@Component("CategoryAop")
public class CategoryAop extends net.mingsoft.basic.aop.BaseAop {


    @Value("${ms.diy.html-dir:html}")
    private String htmlDir;

    @Autowired
    private ICategoryDao categoryDao;

    @Autowired
    private IContentDao contentDao;

    @Pointcut("execution(* net.mingsoft.cms.action.CategoryAction.delete(..)) ")
    public void delete() {
    }

    /**
     * 栏目保存接口切面
     */
    @Pointcut("execution(* net.mingsoft.cms.action.CategoryAction.save(..)) ")
    public void save() {}

    /**
     * 栏目更新接口切面
     */
    @Pointcut("execution(* net.mingsoft.cms.action.CategoryAction.update(..)) ")
    public void update() {}



    @Around("save() || update()")
    public ResultData move(ProceedingJoinPoint pjp) throws Throwable {
        CategoryEntity category = getType(pjp, CategoryEntity.class);
        if (category == null) {
            throw new BusinessException("栏目不存在!");
        }

        // 获取返回值
        Object obj = pjp.proceed(pjp.getArgs());
        ResultData resultData = JSONUtil.toBean(JSONUtil.toJsonStr(obj), ResultData.class);
        category = resultData.getData(CategoryEntity.class);

        if (category == null) {
            return resultData;
        }

        // 如果栏目被设置为不显示，将栏目下所有子栏目也设置为不显示
        if (CategoryDisplayEnum.DISABLE.toString().equalsIgnoreCase(category.getCategoryDisplay())){
            List<String> ids = categoryDao.queryChildren(category).stream().map(CategoryEntity::getId).collect(Collectors.toList());
            LambdaUpdateWrapper<CategoryEntity> wrapper = new UpdateWrapper<CategoryEntity>().lambda();
            wrapper.set(CategoryEntity::getCategoryDisplay,CategoryDisplayEnum.DISABLE.toString());
            wrapper.in(CategoryEntity::getId,ids);
            categoryDao.update(null,wrapper);

        }

        // 如果栏目被设置为不被搜索，将栏目下所有子栏目也设置为不被搜索
        if (CategoryIsSearchEnum.DISABLE.toString().equalsIgnoreCase(category.getCategoryIsSearch())){
            List<String> ids = categoryDao.queryChildren(category).stream().map(CategoryEntity::getId).collect(Collectors.toList());
            LambdaUpdateWrapper<CategoryEntity> wrapper = new UpdateWrapper<CategoryEntity>().lambda();
            wrapper.set(CategoryEntity::getCategoryIsSearch,CategoryIsSearchEnum.DISABLE.toString());
            wrapper.in(CategoryEntity::getId,ids);
            categoryDao.update(null,wrapper);

        }

        CategoryEntity parent = categoryDao.selectById(category.getCategoryId());
        if (parent == null) {
            return resultData;
        }

        // 用于判断父级栏目之前是否是子栏目
        // 只有父节点之前为子节点 && 父栏目类型为列表 && 子栏目为列表
        boolean flag = !parent.getLeaf() && StringUtils.equals(parent.getCategoryType(), CategoryTypeEnum.LIST.toString());
        if (flag) {
            // 将父栏目的内容模板清空
            parent.setCategoryUrl("");
            categoryDao.updateById(parent);
            CategoryEntity returnCategory = JSONUtil.toBean(resultData.get(ResultData.DATA_KEY).toString(), CategoryEntity.class);
            // 获取父栏目ID集合
            String categoryIds = StringUtils.isEmpty(parent.getCategoryParentIds())
                    ? returnCategory.getId() : parent.getCategoryParentIds() + "," + returnCategory.getId();
            if (!StringUtils.equals(returnCategory.getCategoryType(), CategoryTypeEnum.LIST.toString())) {
                // 如果子栏目不为列表,将直接删除父栏目下的文章
                LambdaQueryWrapper<ContentEntity> contentDeleteWrapper = new QueryWrapper<ContentEntity>().lambda();
                contentDeleteWrapper.eq(ContentEntity::getCategoryId, parent.getId());
                List<ContentEntity> list = contentDao.selectList(contentDeleteWrapper);
                if (CollectionUtil.isNotEmpty(list)) {
                    String[] ids = ArrayUtil.toArray(list.stream().map(ContentEntity::getId).collect(Collectors.toList()), String.class);
                    contentDao.delete(ids);
                }
            }
            // 将父栏目下的文章移动到子栏目下
            LambdaUpdateWrapper<ContentEntity> contentWrapper = new UpdateWrapper<ContentEntity>().lambda();
            contentWrapper.set(ContentEntity::getCategoryId, returnCategory.getId());
            contentWrapper.eq(ContentEntity::getCategoryId, parent.getId());
            contentDao.update(new ContentEntity(), contentWrapper);

            return resultData;
        }
        return resultData;
    }


    /**
     * 删除栏目后并删除文章对应的静态化文件
     *
     * @param jp
     */
    @After("delete()")
    public void delete(JoinPoint jp) {
        List<CategoryEntity> categoryEntities = (List<CategoryEntity>) getJsonParam(jp);
        for (CategoryEntity categoryEntity : categoryEntities) {
            // 删除静态文件
            deleteCategoryHtml(categoryEntity.getCategoryPath());
        }
    }


    /**
     * @param categoryPath 栏目目录
     *                     删除栏目静态文件
     */
    public void deleteCategoryHtml(String categoryPath) {
        // 过滤非法路径
        if (StringUtils.isEmpty(categoryPath) || categoryPath.contains("../") || categoryPath.contains("..\\")) {
            LOG.error("非法路径：{}", categoryPath);
            throw new BusinessException("非法路径");
        }
        // html真实路径
        String htmlPath = BasicUtil.getRealPath(htmlDir);
        // appDir
        String appDir = BasicUtil.getApp().getAppDir();
        // 删除静态文件
        // 文件夹路径组成 html真实路径 + appdir + 栏目路径
        boolean flag = FileUtil.del(htmlPath
                + File.separator + appDir
                + categoryPath
        );
        if (flag) {
            LOG.info("删除静态文件夹成功！");
        } else {
            LOG.info("删除失败！");
        }
    }

}
