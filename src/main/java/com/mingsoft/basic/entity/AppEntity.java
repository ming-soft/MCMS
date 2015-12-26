package com.mingsoft.basic.entity;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.mingsoft.base.entity.BaseEntity;

/**
 * 网站基本信息实体类
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class AppEntity extends BaseEntity {

	/**
	 * 应用名称
	 */
	private String appName;

	/**
	 * 应用描述
	 */
	private String appDescription;

	/**
	 * 应用logo
	 */
	private String appLogo;

	/**
	 * 应用编号
	 */
	private int appId;

	/**
	 * 网站采用的模板风格
	 */

	private String appStyle;
	
	/**
	 * 移动端样式目录
	 */
	private String appMobileStyle;


	/**
	 * 网站关键字
	 */
	private String appKeyword;

	/**
	 * 网站版权信息
	 */
	private String appCopyright;

	/**
	 * 网站域名
	 */
	private String appUrl;

	/**
	 * 管理站点的管理员id
	 */
	private int appManagerId;

	/**
	 * 站点日期
	 */
	private Date appDatetime;
	
	/**
	 * 应用续费时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date appPayDate;
	
	/**
	 * 应用费用清单
	 */
	private String appPay;
	
	public Date getAppPayDate() {
		return appPayDate;
	}

	public void setAppPayDate(Date appPayDate) {
		this.appPayDate = appPayDate;
	}

	public String getAppPay() {
		return appPay;
	}

	public void setAppPay(String appPay) {
		this.appPay = appPay;
	}

	public Date getAppDatetime() {
		return appDatetime;
	}

	public void setAppDatetime(Date appDatetime) {
		this.appDatetime = appDatetime;
	}

	/**
	 * 获取网站版权信息
	 * 
	 * @return 返回网站版权信息
	 */
	public String getAppCopyright() {
		return appCopyright;
	}

	public String getAppDescription() {
		return appDescription;
	}

	public int getAppId() {
		return appId;
	}

	/**
	 * 获取网站的关键字
	 * 
	 * @return 返回网站关键字
	 */
	public String getAppKeyword() {
		return appKeyword;
	}

	/**
	 * 获取管理员的id
	 * 
	 * @return 返回管理员ID
	 */
	public int getAppManagerId() {
		return appManagerId;
	}

	public String getAppName() {
		return appName;
	}

	/**
	 * 获取网站使用的模板风格
	 * 
	 * @return 返回网站使用的模板风格
	 */
	public String getAppStyle() {
		return appStyle;
	}

	/**
	 * 获取网站域名
	 */
	public String getAppUrl() {
		return appUrl;
	}
	
	/**
	 * 获取网站域名
	 */
	public String getAppHostUrl() {
		if (appUrl.indexOf("\n") > 0) { //存在多个域名绑定
			return appUrl.split("\n")[0].trim();
		}
		return appUrl;
	}

	public String getAppLogo() {
		return appLogo;
	}

	/**
	 * 设置网站版权信息
	 * 
	 * @param appCopyright
	 */
	public void setAppCopyright(String appCopyright) {
		this.appCopyright = appCopyright;
	}

	public void setAppDescription(String appDescription) {
		this.appDescription = appDescription;
	}

	public void setAppId(int appId) {
		this.appId = appId;
	}

	/**
	 * 设置网站关键字
	 * 
	 * @param appKeyword
	 */
	public void setAppKeyword(String appKeyword) {
		this.appKeyword = appKeyword;
	}

	/**
	 * 设置管理员的id
	 */
	public void setAppManagerId(int appManagerId) {
		this.appManagerId = appManagerId;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	/**
	 * 设置网站使用的模板风格
	 * 
	 * @param appStyle
	 */
	public void setAppStyle(String appStyle) {
		this.appStyle = appStyle;
	}

	/**
	 * 设置网站域名
	 * 
	 * @param appUrl
	 */
	public void setAppUrl(String appUrl) {
		this.appUrl = appUrl;
	}
	

	public String getAppMobileStyle() {
		return appMobileStyle;
	}

	public void setAppMobileStyle(String appMobileStyle) {
		this.appMobileStyle = appMobileStyle;
	}

	public void setAppLogo(String appLogo) {
		this.appLogo = appLogo;
	}

}
