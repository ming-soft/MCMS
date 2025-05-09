/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * <p>
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * <p>
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


package net.mingsoft.cms.action;

import cn.hutool.core.io.file.FileNameUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import io.swagger.v3.oas.annotations.Hidden;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.annotation.LogAnn;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.constant.e.BusinessTypeEnum;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.PinYinUtil;
import net.mingsoft.basic.util.StringUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.constant.e.CategoryTypeEnum;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 分类管理控制层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
@Tag(name = "后端-内容模块接口")
@Controller("cmsCategoryAction")
@RequestMapping("/${ms.manager.path}/cms/category")
public class CategoryAction extends BaseAction {


    /**
     * 注入分类业务层
     */
    @Autowired
    private ICategoryBiz categoryBiz;

    /**
     * 返回主界面index
     * @return
     */
    @Hidden
    @GetMapping("/index")
    @RequiresPermissions("cms:category:view")
    public String index() {
        return "/cms/category/index";
    }

    /**
     * 查询分类列表接口
     * @param category 栏目实体
     * @return
     */
    @Operation(summary =  "查询分类列表接口")
    @Parameters({
            @Parameter(name = "categoryTitle", description = "栏目管理名称", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryParentId", description = "父类型编号", required =  false, in = ParameterIn.QUERY),
    })
    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ResultData list(@ModelAttribute @Parameter(hidden = true) CategoryEntity category) {
        // TODO: 2024/12/2 为了拓展栏目使用方法，增加isChild字段处理
        // 这里根据外部传值，如果没有则默认查询cms下栏目
        if (StrUtil.isBlank(category.getIsChild())) {
            category.setIsChild("cms");
        }
        List categoryList = categoryBiz.list(new LambdaQueryWrapper<CategoryEntity>(category));
        return ResultData.build().success(new EUListBean(categoryList, categoryList.size()));
    }

    /**
     * 返回编辑界面category_form
     * @param category 栏目
     * @return
     */
    @Hidden
    @GetMapping("/form")
    public String form(@ModelAttribute CategoryEntity category, ModelMap model) {
        model.addAttribute("appId", BasicUtil.getApp().getAppId());
        return "/cms/category/form";
    }

    /**
     * 获取分类
     * @param category 分类实体
     */
    @Operation(summary =  "获取分类详情接口")
    @Parameter(name = "id", description = "编号", required =  true, in = ParameterIn.QUERY)
    @GetMapping("/get")
    @RequiresPermissions("cms:category:view")
    @ResponseBody
    public ResultData get(@ModelAttribute @Parameter(hidden = true) CategoryEntity category) {
        if (StringUtils.isBlank(category.getId())) {
            return ResultData.build().error(getResString("err.empty",this.getResString("id")));
        }
        CategoryEntity _category = (CategoryEntity) categoryBiz.getById(category.getId());
        return ResultData.build().success(_category);
    }


    /**
     * 保存分类
     * @param category 分类实体
     */
    @Operation(summary =  "保存分类列表接口")
    @Parameters({
            @Parameter(name = "categoryTitle", description = "栏目管理名称", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryType", description = "栏目类型,1:列表,2:单篇,3:链接", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryDisplay", description = "栏目是否显示,enable:显示 disable:不显示", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryIsSearch", description = "栏目是否可搜索,enable:可搜索 disable:不可搜索", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryId", description = "所属栏目", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categorySort", description = "自定义顺序", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryListUrl", description = "列表模板", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryUrl", description = "内容模板", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryKeyword", description = "栏目管理关键字", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryDescrip", description = "栏目管理描述", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryImg", description = "缩略图", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryIco", description = "栏目小图", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryDiyUrl", description = "自定义链接", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "mdiyModelId", description = "栏目管理的内容模型id", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "dictId", description = "字典对应编号", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryFlag", description = "栏目属性", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryPath", description = "栏目路径", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryParentIds", description = "父类型编号", required =  false, in = ParameterIn.QUERY),
    })
    @PostMapping("/save")
    @ResponseBody
    @LogAnn(title = "保存分类", businessType = BusinessTypeEnum.INSERT)
    @RequiresPermissions("cms:category:save")
    public ResultData save(@ModelAttribute @Parameter(hidden = true) CategoryEntity category) {
        //验证缩略图参数值是否合法
        if (category.getCategoryImg() == null || !category.getCategoryImg().matches("^\\[.{1,}]$")) {
            category.setCategoryImg("");
        }
        //验证栏目管理名称的值是否合法
        if (StringUtils.isBlank(category.getCategoryTitle())) {
            return ResultData.build().error(getResString("err.empty", this.getResString("category.title")));
        }
        if (!StringUtil.checkLength(category.getCategoryTitle() + "", 1, 100)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.title"), "1", "100"));
        }
        //验证栏目描述的值是否合法
        if (!StringUtil.checkLength(category.getCategoryDescrip() + "", 0, 500)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.descrip"), "0", "500"));
        }
        //验证栏目关键字的值是否合法
        if (!StringUtil.checkLength(category.getCategoryKeyword() + "", 0, 300)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.keyword"), "0", "300"));
        }
        //验证栏目路径的值是否合法
        if (!StringUtil.checkLength(category.getCategoryPath() + "", 0, 500)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.path"), "0", "500"));
        }
        //验证栏目列表模板的值是否合法
        if (!StringUtil.checkLength(category.getCategoryListUrl() + "", 0, 50)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.list.url"), "0", "50"));
        }
        //验证栏目内容模板的值是否合法
        if (!StringUtil.checkLength(category.getCategoryUrl() + "", 0, 50)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.url"), "0", "50"));
        }

        //验证栏目自定义链接的值是否合法
        if (!StringUtil.checkLength(category.getCategoryDiyUrl() + "", 0, 255)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.diy.url"), "0", "255"));
        }
        //验证栏目属性的值是否合法
        if (!StringUtil.checkLength(category.getCategoryFlag() + "", 0, 20)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.flag"), "0", "20"));
        }
        //验证栏目类型的值是否合法
        if (!StringUtil.checkLength(category.getCategoryType() + "", 0, 1)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.type"), "0", "1"));
        }
        //验证栏目内容模型id的值是否合法
        if (!StringUtil.checkLength(category.getMdiyModelId() + "", 0, 50)) {
            return ResultData.build().error(getResString("err.length", this.getResString("mdiy.model.id"), "0", "50"));
        }

        // 判断前端拼音传值是否正常
        if (!StringUtil.checkLength(category.getCategoryPinyin() + "", 0, 100)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.pinyin"), "1", "100"));
        }

        // 过滤非法路径
        if (FileNameUtil.containsInvalid(category.getCategoryPinyin())) {
            return ResultData.build().error(this.getResString("err.error",this.getResString("category.pinyin")));
        }

        //验证栏目父ids是否正常
        if (!StringUtil.checkLength(category.getCategoryParentIds() + "", 1, 100)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.parent.id"), "1", "100"));
        }
        //判断拼音是否重复
        if (StrUtil.isNotBlank(category.getCategoryPinyin())) {
            if (!category.getCategoryPinyin().matches("^[a-zA-Z0-9]*$")){
                return ResultData.build().error(this.getResString("err.error",this.getResString("category.pinyin")));
            }
            CategoryEntity _category = new CategoryEntity();
            _category.setCategoryPinyin(category.getCategoryPinyin());
            List<CategoryEntity> query = categoryBiz.query(_category);
            if (query.size() > 0) {
                return ResultData.build().error(getResString("err.exist", this.getResString("category.pinyin")));
            }
        }

        categoryBiz.saveEntity(category);
        return ResultData.build().success(category);
    }

    /**
     * 批量删除分类列表接口
     * @param categorys
     * @return
     */
    @Operation(summary = "批量删除分类列表接口")
    @Parameters({
            @Parameter(name = "categorys", description = "删除的栏目集合", schema = @Schema(allOf = CategoryEntity.class ), required = true)
    })
    @PostMapping("/delete")
    @ResponseBody
    @LogAnn(title = "删除分类", businessType = BusinessTypeEnum.DELETE)
    @RequiresPermissions("cms:category:del")
    public ResultData delete(@RequestBody List<CategoryEntity> categorys) {
        for (int i = 0; i < categorys.size(); i++) {
            categoryBiz.delete(categorys.get(i).getId());
        }
        return ResultData.build().success();
    }

    /**
     *	更新分类列表
     * @param category 分类实体
     */
    @Operation(summary =  "更新分类列表接口")
    @Parameters({
            @Parameter(name = "id", description = "编号", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryTitle", description = "栏目管理名称", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryDisplay", description = "栏目是否显示,enable:显示 disable:不显示", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryIsSearch", description = "栏目是否可搜索,enable:可搜索 disable:不可搜索", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryType", description = "栏目类型,1:列表,2:单篇,3:链接", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryId", description = "所属栏目", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categorySort", description = "自定义顺序", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryListUrl", description = "列表模板", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryUrl", description = "内容模板", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryKeyword", description = "栏目管理关键字", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryDescrip", description = "栏目管理描述", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryImg", description = "banner图", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryIco", description = "栏目小图", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryDiyUrl", description = "自定义链接", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "mdiyModelId", description = "栏目管理的内容模型id", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "dictId", description = "字典对应编号", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryFlag", description = "栏目属性", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryPath", description = "栏目路径", required =  false, in = ParameterIn.QUERY),
            @Parameter(name = "categoryParentIds", description = "父类型编号", required =  false, in = ParameterIn.QUERY),
    })
    @PostMapping("/update")
    @ResponseBody
    @LogAnn(title = "更新分类", businessType = BusinessTypeEnum.UPDATE)
    @RequiresPermissions("cms:category:update")
    public ResultData update(@ModelAttribute @Parameter(hidden = true) CategoryEntity category) {
        //验证缩略图参数值是否合法
        if (category.getCategoryImg() == null || !category.getCategoryImg().matches("^\\[.{1,}]$")) {
            category.setCategoryImg("");
        }
        if (StringUtils.isEmpty(category.getId())){
            return ResultData.build().error(getResString("err.empty", this.getResString("category.id")));
        }
        //验证栏目管理名称的值是否合法
        if (StringUtils.isBlank(category.getCategoryTitle())) {
            return ResultData.build().error(getResString("err.empty", this.getResString("category.title")));
        }
        if (!StringUtil.checkLength(category.getCategoryTitle() + "", 1, 100)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.title"), "1", "100"));
        }
        //验证栏目描述的值是否合法
        if (!StringUtil.checkLength(category.getCategoryDescrip() + "", 0, 500)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.descrip"), "0", "500"));
        }
        //验证栏目关键字的值是否合法
        if (!StringUtil.checkLength(category.getCategoryKeyword() + "", 0, 300)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.keyword"), "0", "300"));
        }
        //验证栏目自定义链接的值是否合法
        if (!StringUtil.checkLength(category.getCategoryDiyUrl() + "", 0, 255)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.diy.url"), "0", "255"));
        }
        //验证栏目属性的值是否合法
        if (!StringUtil.checkLength(category.getCategoryFlag() + "", 0, 20)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.flag"), "0", "20"));
        }
        //验证栏目列表模板的值是否合法
        if (!StringUtil.checkLength(category.getCategoryListUrl() + "", 0, 50)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.list.url"), "0", "50"));
        }
        //验证栏目路径的值是否合法
        if (!StringUtil.checkLength(category.getCategoryPath() + "", 0, 500)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.path"), "0", "500"));
        }
        //验证栏目类型的值是否合法
        if (!StringUtil.checkLength(category.getCategoryType() + "", 0, 1)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.type"), "0", "1"));
        }
        //验证栏目内容模板的值是否合法
        if (!StringUtil.checkLength(category.getCategoryUrl() + "", 0, 50)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.url"), "0", "50"));
        }
        //验证栏目内容模型id的值是否合法
        if (!StringUtil.checkLength(category.getMdiyModelId() + "", 0, 50)) {
            return ResultData.build().error(getResString("err.length", this.getResString("mdiy.model.id"), "0", "50"));
        }
        //验证栏目父ids值是否合法
        if (!StringUtil.checkLength(category.getCategoryParentIds() + "", 0, 100)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.parent.id"), "1", "100"));
        }
        // 过滤非法路径
        if (FileNameUtil.containsInvalid(category.getCategoryPinyin())) {
            return ResultData.build().error(this.getResString("err.error",this.getResString("category.pinyin")));
        }
        //判断拼音是否重复并且是否和原拼音相同
        if (StrUtil.isNotBlank(category.getCategoryPinyin()) && !categoryBiz.getById(category.getId()).getCategoryPinyin().equals(category.getCategoryPinyin())) {
            if (!category.getCategoryPinyin().matches("^[a-zA-Z0-9]*$")){
                return ResultData.build().error(this.getResString("err.error",this.getResString("category.pinyin")));
            }
            CategoryEntity _category = new CategoryEntity();
            _category.setCategoryPinyin(category.getCategoryPinyin());
            List<CategoryEntity> query = categoryBiz.query(_category);
            if (query.size() > 0) {
                return ResultData.build().error(getResString("err.exist", this.getResString("category.pinyin")));
            }
        }
        String pingYin = PinYinUtil.getPingYin(category.getCategoryTitle());
        //如果用户填写了拼音则使用用户填写的
        if (StrUtil.isNotBlank(category.getCategoryPinyin()) && StringUtil.checkLength(category.getCategoryPinyin() + "", 1, 100)) {
            pingYin = category.getCategoryPinyin();
        }
        CategoryEntity categoryEntity = new CategoryEntity();
        categoryEntity.setCategoryPinyin(pingYin);
        CategoryEntity categoryBizEntity = categoryBiz.getOne(new LambdaQueryWrapper<>(categoryEntity));
        category.setCategoryPinyin(pingYin);
        //如果存在此拼音栏目则拼接上id
        if (categoryBizEntity != null && !categoryBizEntity.getId().equals(category.getId())) {
            category.setCategoryPinyin(pingYin + category.getId());
        }
        //判断是否选择子级为所属栏目
        CategoryEntity _category = new CategoryEntity();
        _category.setId(category.getId());
        List<CategoryEntity> categoryList = categoryBiz.queryChildren(_category);
        if (categoryList.size() > 1) {
            for (CategoryEntity item : categoryList) {
                if (item.getId().equals(category.getCategoryId())) {
                    return ResultData.build().error(getResString("cannot.select.child"));
                }
            }
            category.setLeaf(false);
        } else {
            category.setLeaf(true);
        }

        // 这里不能使用mybitsplus 存在业务
        categoryBiz.updateEntity(category);
        return ResultData.build().success(category);
    }

    /**
     * 验证拼音
     * @param category 栏目
     * @return
     */
    @Operation(summary =  "验证拼音")
    @Parameters({
            @Parameter(name = "id", description = "编号", required =  true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryPinyin", description = "栏目管拼音", required =  true, in = ParameterIn.QUERY),
    })
    @GetMapping("/verifyPingYin")
    @ResponseBody
    public ResultData verifyPingYin(@ModelAttribute @Parameter(hidden = true) CategoryEntity category) {
        //验证id是否合法
        if (StringUtils.isEmpty(category.getId())){
            return ResultData.build().error(getResString("err.empty", this.getResString("id")));
        }
        if (!StringUtil.checkLength(category.getId() + "", 0, 20)) {
            return ResultData.build().error(getResString("err.length", this.getResString("id"), "0", "20"));
        }
        //验证拼音是否合法
        if (StringUtils.isEmpty(category.getCategoryPinyin())){
            return ResultData.build().error(getResString("err.empty", this.getResString("category.pinyin")));
        }
        if (FileNameUtil.containsInvalid(category.getCategoryPinyin())) {
            return ResultData.build().error(this.getResString("err.error",this.getResString("category.pinyin")));
        }
        if (!StringUtil.checkLength(category.getCategoryPinyin() + "", 0, 255)) {
            return ResultData.build().error(getResString("err.length", this.getResString("category.pinyin"), "0", "255"));
        }
        long count = categoryBiz.count(Wrappers.<CategoryEntity>lambdaQuery()
                .ne(StrUtil.isNotBlank(category.getId()), CategoryEntity::getId, category.getId())
                .eq(CategoryEntity::getCategoryPinyin, category.getCategoryPinyin()));

        if (count > 0) {
            return ResultData.build().error("存在相同拼音的栏目");
        }
        return ResultData.build().success();
    }

    /**
     * 批量更新模板
     * @param category 栏目实体
     * @return
     */
    @Operation(summary =  "批量更新模板")
    @Parameters({
            @Parameter(name = "id", description = "编号", required =  true, in = ParameterIn.QUERY),
    })
    @GetMapping("/updateTemplate")
    @ResponseBody
    @RequiresPermissions("cms:category:update")
    public ResultData updateTemplate(@ModelAttribute @Parameter(hidden = true) CategoryEntity category) {
        if (category == null || StringUtils.isEmpty(category.getId())) {
            return ResultData.build().error(getResString("err.error", this.getResString("id")));
        }
        category = categoryBiz.getById(category.getId());
        category.setCategoryParentIds(null);
        List<CategoryEntity> childs = categoryBiz.queryChildren(category);
        //更新与父节点相同类型的子栏目的模板内容
        for (int i = 0; i < childs.size(); i++) {
            if (childs.get(i).getCategoryType().equals(category.getCategoryType())) {
                childs.get(i).setCategoryUrl(category.getCategoryUrl());
                childs.get(i).setCategoryListUrl(category.getCategoryListUrl());
                categoryBiz.updateEntity(childs.get(i));
            }
        }
        return ResultData.build().success();
    }

    /**
     * 复制栏目
     * @param category 栏目实体
     * @return
     */
    @Operation(summary =  "复制栏目")
    @Parameters({
            @Parameter(name = "id", description = "编号", required =  true, in = ParameterIn.QUERY)
    })
    @GetMapping("/copyCategory")
    @ResponseBody
    @RequiresPermissions("cms:category:save")
    public ResultData copyCategory(@ModelAttribute @Parameter(hidden = true) CategoryEntity category) {
        if (category == null || StringUtils.isEmpty(category.getId())) {
            return ResultData.build().error(getResString("err.error", this.getResString("id")));
        }
        categoryBiz.copyCategory(category);
        return ResultData.build().success();
    }


    @Operation(summary =  "强制转换类型接口")
    @Parameters({
            @Parameter(name = "typeid", description = "编号", required = true, in = ParameterIn.QUERY),
            @Parameter(name = "categoryType", description = "栏目类型,1:列表,2:单篇,3:链接", required = true, in = ParameterIn.QUERY)
    })
    @GetMapping("/changeType")
    @ResponseBody
    @RequiresPermissions("cms:category:update")
    public ResultData changeType(){
        String typeId = BasicUtil.getString(ParserUtil.TYPE_ID);
        String categoryType = BasicUtil.getString("categoryType");
        CategoryEntity category = categoryBiz.getById(typeId);
        if (category == null){
            return ResultData.build().error(getResString("err.error",getResString("id")));
        }
        if (CategoryTypeEnum.get(categoryType).equals(CategoryTypeEnum.UN_KNOW)){
            return ResultData.build().error(getResString("err.error",getResString("category.type")));
        }
        categoryBiz.changeCategoryType(category,categoryType);
        return ResultData.build().success(category);
    }

}
