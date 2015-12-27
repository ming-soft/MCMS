/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

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