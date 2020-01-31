package net.mingsoft.cms.entity;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import net.mingsoft.base.entity.BaseEntity;
import java.util.Date;
/**
* 分类实体
* @author 铭飞开发团队
* 创建日期：2019-11-28 15:12:32<br/>
* 历史修订：<br/>
*/
public class CategoryEntity extends BaseEntity {

private static final long serialVersionUID = 1574925152750L;

	/**
	* 栏目管理名称
	*/
	private String categoryTitle;
	/**
	* 所属栏目
	*/
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
	private String mdiyModelId;
	/**
	* 类别发布时间
	*/
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
	private Date categoryDatetime;
	/**
	* 发布用户id
	*/
	private Integer categoryManagerId;
	/**
	* 应用编号
	*/
	private Integer appId;
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
	private String categoryParentId;


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
	/**
	* 设置栏目管理的内容模型id
	*/
	public void setMdiyModelId(String mdiyModelId) {
	this.mdiyModelId = mdiyModelId;
	}

	/**
	* 获取栏目管理的内容模型id
	*/
	public String getMdiyModelId() {
	return this.mdiyModelId;
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
	* 设置发布用户id
	*/
	public void setCategoryManagerId(Integer categoryManagerId) {
	this.categoryManagerId = categoryManagerId;
	}

	/**
	* 获取发布用户id
	*/
	public Integer getCategoryManagerId() {
	return this.categoryManagerId;
	}
	/**
	* 设置应用编号
	*/
	public void setAppId(Integer appId) {
	this.appId = appId;
	}

	/**
	* 获取应用编号
	*/
	public Integer getAppId() {
	return this.appId;
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
	public void setCategoryParentId(String categoryParentId) {
	this.categoryParentId = categoryParentId;
	}

	/**
	* 获取父类型编号
	*/
	public String getCategoryParentId() {
	return this.categoryParentId;
	}
}