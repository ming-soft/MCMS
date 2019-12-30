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
	* 用户id
	*/
	private String hlPeopleId;
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
	/**
	* 设置用户id
	*/
	public void setHlPeopleId(String hlPeopleId) {
	this.hlPeopleId = hlPeopleId;
	}

	/**
	* 获取用户id
	*/
	public String getHlPeopleId() {
	return this.hlPeopleId;
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