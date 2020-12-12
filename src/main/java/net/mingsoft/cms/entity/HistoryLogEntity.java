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
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import net.mingsoft.base.entity.BaseEntity;
import java.util.Date;
/**
* 文章浏览记录实体
* @author 铭飞开发团队
* 创建日期：2019-12-23 9:24:03<br/>
* 历史修订：<br/>
*/
public class HistoryLogEntity extends BaseEntity {

private static final long serialVersionUID = 1577064243576L;

	/**
	* 文章编号
	*/
	private String contentId;
	/**
	* 浏览ip
	*/
	private String hlIp;
	/**
	* 用户idp
	*/
	private String peopleId;
	/**
	* 是否为移动端
	*/
	private Boolean hlIsMobile;


	/**
	* 设置文章编号
	*/
	public void setContentId(String contentId) {
	this.contentId = contentId;
	}

	/**
	* 获取文章编号
	*/
	public String getContentId() {
	return this.contentId;
	}
	/**
	* 设置浏览ip
	*/
	public void setHlIp(String hlIp) {
	this.hlIp = hlIp;
	}

	/**
	* 获取浏览ip
	*/
	public String getHlIp() {
	return this.hlIp;
	}

	public String getPeopleId() {
		return peopleId;
	}

	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	* 设置是否为移动端
	*/
	public void setHlIsMobile(Boolean hlIsMobile) {
	this.hlIsMobile = hlIsMobile;
	}

	/**
	* 获取是否为移动端
	*/
	public Boolean getHlIsMobile() {
	return this.hlIsMobile;
	}
}
