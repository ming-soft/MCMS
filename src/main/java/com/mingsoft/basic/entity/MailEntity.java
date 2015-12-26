package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;

/**
 * 邮件实体类
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class MailEntity extends BaseEntity {

	/**
	 * 邮件对应的站点id
	 */
	private int mailAppId;
	/**
	 * 邮件对应的模块id
	 */
	private int mailModelId;
	/**
	 * 发件方名称
	 */
	private String mailName;
	/**
	 * 发件方密码
	 */
	private String mailPassword;
	/**
	 * 邮件端口
	 */
	private int mailPort;
	/**
	 * 接收方名称
	 */
	private String mailServer;
	/**
	 * 邮件内容
	 */
	private String mailContent;
	/**
	 * 收件方地址
	 */
	private String mailReceive;

	public int getMailAppId() {
		return mailAppId;
	}

	public String getMailContent() {
		return mailContent;
	}

	public int getMailModelId() {
		return mailModelId;
	}

	public String getMailName() {
		return mailName;
	}

	public String getMailPassword() {
		return mailPassword;
	}

	public int getMailPort() {
		return mailPort;
	}

	public String getMailReceive() {
		return mailReceive;
	}

	public String getMailServer() {
		return mailServer;
	}

	public void setMailAppId(int mailAppId) {
		this.mailAppId = mailAppId;
	}

	public void setMailContent(String mailContent) {
		this.mailContent = mailContent;
	}

	public void setMailModelId(int mailModelId) {
		this.mailModelId = mailModelId;
	}

	public void setMailName(String mailName) {
		this.mailName = mailName;
	}

	public void setMailPassword(String mailPassword) {
		this.mailPassword = mailPassword;
	}

	public void setMailPort(int mailPort) {
		this.mailPort = mailPort;
	}

	public void setMailReceive(String mailReceive) {
		this.mailReceive = mailReceive;
	}

	public void setMailServer(String mailServer) {
		this.mailServer = mailServer;
	}
}