package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;

/**
 * 邮件实体类
 * @author 杨新远
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class MailTemplateEntity extends BaseEntity{
	
	/**
	 * 邮箱id
	 */
	private int mailTemplateId;
	/**
	 * 邮箱模板对应的站点id
	 */
	private int mailTemplateAppId;
	/**
	 * 邮箱模板对应的模块id 
	 */
	private int mailTemplateModelId;
	/**
	 * 模板内容
	 */
	private String mailTemplateContent;
	
	/**
	 * 模板标题
	 */
	private String mailTemplateTitle;
	

	/**
	 * 模板接收用户
	 */
	private String mailTemplateReceive;
	
	public String getMailTemplateTitle() {
		return mailTemplateTitle;
	}
	public void setMailTemplateTitle(String mailTemplateTitle) {
		this.mailTemplateTitle = mailTemplateTitle;
	}
	
	public int getMailTemplateId() {
		return mailTemplateId;
	}
	public void setMailTemplateId(int mailTemplateId) {
		this.mailTemplateId = mailTemplateId;
	}
	public int getMailTemplateAppId() {
		return mailTemplateAppId;
	}
	public void setMailTemplateAppId(int mailTemplateAppId) {
		this.mailTemplateAppId = mailTemplateAppId;
	}
	public int getMailTemplateModelId() {
		return mailTemplateModelId;
	}
	public void setMailTemplateModelId(int mailTemplateModelId) {
		this.mailTemplateModelId = mailTemplateModelId;
	}
	public String getMailTemplateContent() {
		return mailTemplateContent;
	}
	public void setMailTemplateContent(String mailTemplateContent) {
		this.mailTemplateContent = mailTemplateContent;
	}
	public String getMailTemplateReceive() {
		return mailTemplateReceive;
	}
	public void setMailTemplateReceive(String mailTemplateReceive) {
		this.mailTemplateReceive = mailTemplateReceive;
	}
	
}



















