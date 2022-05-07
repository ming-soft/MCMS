/**
 * Copyright (c) 2012-2022 铭软科技(mingsoft.net)
 * 本软件及相关文档文件（以下简称“软件”）的版权归 铭软科技 所有
 * 遵循铭软科技《保密协议》
 */

package net.mingsoft.cms.aop;

import cn.hutool.core.io.FileUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.mdiy.biz.IDictBiz;
import net.mingsoft.mdiy.entity.DictEntity;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;
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


    @Pointcut("execution(* net.mingsoft.cms.action.CategoryAction.delete(..)) ")
    public void delete() {
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
