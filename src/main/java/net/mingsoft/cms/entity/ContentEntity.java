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

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import net.mingsoft.base.entity.BaseEntity;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
* 文章实体
* @author 铭飞开发团队
* 创建日期：2019-11-28 15:12:32<br/>
* 历史修订：<br/>
*/
@TableName("cms_content")
public class ContentEntity extends BaseEntity {

private static final long serialVersionUID = 1574925152617L;

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
	* 文章标题
	*/
	private String contentTitle;
	/**
	* 所属栏目
	*/
	private String categoryId;
	/**
	* 文章类型
	*/
	private String contentType;
	/**
	* 是否显示
	*/
	private String contentDisplay;
	/**
	* 文章作者
	*/
	private String contentAuthor;
	/**
	* 文章来源
	*/
	private String contentSource;
	/**
	* 发布时间
	*/
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
	private Date contentDatetime;
	/**
	* 自定义顺序
	*/
	private Integer contentSort;
	/**
	* 文章缩略图
	*/
	private String contentImg;
	/**
	* 描述
	*/
	private String contentDescription;
	/**
	* 关键字
	*/
	private String contentKeyword;
	/**
	* 文章内容
	*/
	private String contentDetails;
	/**
	* 文章跳转链接地址
	*/
	private String contentUrl;
	/**
	* 文章管理的应用id
	*/

	/**
	* 点击次数
	*/
	private Integer contentHit;

	public Integer getContentHit() {
		return contentHit;
	}

	public void setContentHit(Integer contentHit) {
		this.contentHit = contentHit;
	}

	/**
	* 设置文章标题
	*/
	public void setContentTitle(String contentTitle) {
	this.contentTitle = contentTitle;
	}

	/**
	* 获取文章标题
	*/
	public String getContentTitle() {
	return this.contentTitle;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	/**
	* 设置文章类型
	*/
	public void setContentType(String contentType) {
	this.contentType = contentType;
	}

	/**
	* 获取文章类型
	*/
	public String getContentType() {
	return this.contentType;
	}
	/**
	* 设置是否显示
	*/
	public void setContentDisplay(String contentDisplay) {
	this.contentDisplay = contentDisplay;
	}

	/**
	* 获取是否显示
	*/
	public String getContentDisplay() {
	return this.contentDisplay;
	}
	/**
	* 设置文章作者
	*/
	public void setContentAuthor(String contentAuthor) {
	this.contentAuthor = contentAuthor;
	}

	/**
	* 获取文章作者
	*/
	public String getContentAuthor() {
	return this.contentAuthor;
	}
	/**
	* 设置文章来源
	*/
	public void setContentSource(String contentSource) {
	this.contentSource = contentSource;
	}

	/**
	* 获取文章来源
	*/
	public String getContentSource() {
	return this.contentSource;
	}
	/**
	* 设置发布时间
	*/
	public void setContentDatetime(Date contentDatetime) {
	this.contentDatetime = contentDatetime;
	}

	/**
	* 获取发布时间
	*/
	public Date getContentDatetime() {
	return this.contentDatetime;
	}
	/**
	* 设置自定义顺序
	*/
	public void setContentSort(Integer contentSort) {
	this.contentSort = contentSort;
	}

	/**
	* 获取自定义顺序
	*/
	public Integer getContentSort() {
	return this.contentSort;
	}
	/**
	* 设置文章缩略图
	*/
	public void setContentImg(String contentImg) {
	this.contentImg = contentImg;
	}

	/**
	* 获取文章缩略图
	*/
	public String getContentImg() {
	return this.contentImg;
	}
	/**
	* 设置描述
	*/
	public void setContentDescription(String contentDescription) {
	this.contentDescription = contentDescription;
	}

	/**
	* 获取描述
	*/
	public String getContentDescription() {
	return this.contentDescription;
	}
	/**
	* 设置关键字
	*/
	public void setContentKeyword(String contentKeyword) {
	this.contentKeyword = contentKeyword;
	}

	/**
	* 获取关键字
	*/
	public String getContentKeyword() {
	return this.contentKeyword;
	}
	/**
	* 设置文章内容
	*/
	public void setContentDetails(String contentDetails) {
	this.contentDetails = contentDetails;
	}

	/**
	* 获取文章内容
	*/
	public String getContentDetails() {
	return this.contentDetails;
	}
	/**
	* 设置文章跳转链接地址
	*/
	public void setContentUrl(String contentUrl) {
	this.contentUrl = contentUrl;
	}

	/**
	* 获取文章跳转链接地址
	*/
	public String getContentUrl() {
	return this.contentUrl;
	}

}
