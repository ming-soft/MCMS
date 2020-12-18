/**
 * The MIT License (MIT)
 * Copyright (c) 2020 铭软科技(mingsoft.net)
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
package net.mingsoft.cms.entity;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import net.mingsoft.base.entity.BaseEntity;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 分类实体
 *
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
@TableName("cms_category")
public class CategoryEntity extends BaseEntity {

    private static final long serialVersionUID = 1574925152750L;


    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    @Override
    public String getId() {
        return id;
    }

    @Override
    public void setId(String id) {
        this.id = id;
    }

    /**
     * 栏目管理名称
     */
    private String categoryTitle;
    /**
     * 栏目别名
     */
    private String categoryPinyin;
    /**
     * 所属栏目
     */
    @TableField(insertStrategy = FieldStrategy.NOT_EMPTY, updateStrategy = FieldStrategy.NOT_EMPTY, whereStrategy = FieldStrategy.NOT_EMPTY)
    private String categoryId;
    /**
     * 栏目管理属性
     */
    private String categoryType;
    /**
     * 自定义顺序
     */
    private Integer categorySort;
    /**
     * 列表模板
     */
    private String categoryListUrl;
    /**
     * 内容模板
     */
    private String categoryUrl;
    /**
     * 栏目管理关键字
     */
    private String categoryKeyword;
    /**
     * 栏目管理描述
     */
    private String categoryDescrip;
    /**
     * 缩略图
     */
    private String categoryImg;
    /**
     * 自定义链接
     */
    private String categoryDiyUrl;
    /**
     * 栏目管理的内容模型id
     */
    private Integer mdiyModelId;
    /**
     * 类别发布时间
     */
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    private Date categoryDatetime;

    /**
     * 字典对应编号
     */
    private Integer dictId;
    /**
     * 栏目属性
     */
    private String categoryFlag;
    /**
     * 栏目路径
     */
    private String categoryPath;
    /**
     * 父类型编号
     */
    private String categoryParentIds;

    /**
     * 叶子节点
     */
    private Boolean leaf;

    /**
     * 顶级id
     */
    private String topId;

    public Boolean getLeaf() {
        return leaf;
    }

    public void setLeaf(Boolean leaf) {
        this.leaf = leaf;
    }

    public String getTopId() {
        return topId;
    }

    public void setTopId(String topId) {
        this.topId = topId;
    }

    /**
     * 设置栏目管理名称
     */
    public void setCategoryTitle(String categoryTitle) {
        this.categoryTitle = categoryTitle;
    }

    /**
     * 获取栏目管理名称
     */
    public String getCategoryTitle() {
        return this.categoryTitle;
    }

    /**
     * 设置所属栏目
     */
    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryPinyin() {
        return categoryPinyin;
    }

    public void setCategoryPinyin(String categoryPinyin) {
        this.categoryPinyin = categoryPinyin;
    }

    /**
     * 获取所属栏目
     */
    public String getCategoryId() {
        return this.categoryId;
    }

    /**
     * 设置栏目管理属性
     */
    public void setCategoryType(String categoryType) {
        this.categoryType = categoryType;
    }

    /**
     * 获取栏目管理属性
     */
    public String getCategoryType() {
        return this.categoryType;
    }

    /**
     * 设置自定义顺序
     */
    public void setCategorySort(Integer categorySort) {
        this.categorySort = categorySort;
    }

    /**
     * 获取自定义顺序
     */
    public Integer getCategorySort() {
        return this.categorySort;
    }

    /**
     * 设置列表模板
     */
    public void setCategoryListUrl(String categoryListUrl) {
        this.categoryListUrl = categoryListUrl;
    }

    /**
     * 获取列表模板
     */
    public String getCategoryListUrl() {
        return this.categoryListUrl;
    }

    /**
     * 设置内容模板
     */
    public void setCategoryUrl(String categoryUrl) {
        this.categoryUrl = categoryUrl;
    }

    /**
     * 获取内容模板
     */
    public String getCategoryUrl() {
        return this.categoryUrl;
    }

    /**
     * 设置栏目管理关键字
     */
    public void setCategoryKeyword(String categoryKeyword) {
        this.categoryKeyword = categoryKeyword;
    }

    /**
     * 获取栏目管理关键字
     */
    public String getCategoryKeyword() {
        return this.categoryKeyword;
    }

    /**
     * 设置栏目管理描述
     */
    public void setCategoryDescrip(String categoryDescrip) {
        this.categoryDescrip = categoryDescrip;
    }

    /**
     * 获取栏目管理描述
     */
    public String getCategoryDescrip() {
        return this.categoryDescrip;
    }

    /**
     * 设置缩略图
     */
    public void setCategoryImg(String categoryImg) {
        this.categoryImg = categoryImg;
    }

    /**
     * 获取缩略图
     */
    public String getCategoryImg() {
        return this.categoryImg;
    }

    /**
     * 设置自定义链接
     */
    public void setCategoryDiyUrl(String categoryDiyUrl) {
        this.categoryDiyUrl = categoryDiyUrl;
    }

    /**
     * 获取自定义链接
     */
    public String getCategoryDiyUrl() {
        return this.categoryDiyUrl;
    }

    public Integer getMdiyModelId() {
        return mdiyModelId;
    }

    public void setMdiyModelId(Integer mdiyModelId) {
        this.mdiyModelId = mdiyModelId;
    }

    /**
     * 设置类别发布时间
     */
    public void setCategoryDatetime(Date categoryDatetime) {
        this.categoryDatetime = categoryDatetime;
    }

    /**
     * 获取类别发布时间
     */
    public Date getCategoryDatetime() {
        return this.categoryDatetime;
    }

    /**
     * 设置字典对应编号
     */
    public void setDictId(Integer dictId) {
        this.dictId = dictId;
    }

    /**
     * 获取字典对应编号
     */
    public Integer getDictId() {
        return this.dictId;
    }

    /**
     * 设置栏目属性
     */
    public void setCategoryFlag(String categoryFlag) {
        this.categoryFlag = categoryFlag;
    }

    /**
     * 获取栏目属性
     */
    public String getCategoryFlag() {
        return this.categoryFlag;
    }

    /**
     * 设置栏目路径
     */
    public void setCategoryPath(String categoryPath) {
        this.categoryPath = categoryPath;
    }

    /**
     * 获取栏目路径
     */
    public String getCategoryPath() {
        return this.categoryPath;
    }

    /**
     * 设置父类型编号
     */
    public void setCategoryParentIds(String categoryParentIds) {
        this.categoryParentIds = categoryParentIds;
    }

    /**
     * 获取父类型编号
     */
    public String getCategoryParentIds() {
        return this.categoryParentIds;
    }

    /**
     * 获取栏目标题 （标签使用）
     */
    public String getTypetitle() {
        return this.categoryTitle;
    }

    /**
     * 获取栏目链接 （标签使用，动态链接不考虑）
     */
    public String getTypelink() {
        return "3".equals(this.categoryType) ? this.categoryDiyUrl : this.categoryPath + "/index.html";
    }

    /**
     * 获取栏目关键字 （标签使用）
     */
    public String getTypekeyword() {
        return this.categoryKeyword;
    }

    /**
     * 获取栏目url （标签使用）
     */
    public String getTypeurl() {
        return this.categoryDiyUrl;
    }

    /**
     * 获取栏目属性 （标签使用）
     */
    public String getFlag() {
        return this.categoryFlag;
    }

    /**
     * 获取栏目父级Id （标签使用）
     */
    public String getParentids() {
        return this.categoryParentIds;
    }

    /**
     * 获取栏目描述（标签使用）
     */
    public String getTypedescrip() {
        return this.categoryDescrip;
    }

    /**
     * 获取栏目Id（标签使用）
     */
    public String getTypeid() {
        return this.id;
    }

    /**
     * 获取栏目图片 (标签使用）
     */
    public String getTypelitpic() {
        return categoryImg;
    }
}
