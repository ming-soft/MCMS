package com.mingsoft.basic.entity;

import java.util.Date;
import com.mingsoft.base.entity.BaseEntity;

/**
 * 系统皮肤
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class SystemSkinEntity extends BaseEntity{

	private int systemSkinId;
	
	/**
	 * 背景图
	 */
	private String systemSkinBackgroundImg;
	
	/**
	 * 字体颜色
	 */
	private String systemSkinColor;
	
	/**
	 * 全局样式
	 */
	private String systemSkinCss;
	
	private Date systemSkinDate;
	
	private int systemSkinAppId;
	/**
	 * 登陆页面
	 */
	private String systemSkinLoginPage;
	

	public String getSystemSkinLoginPage() {
		return systemSkinLoginPage;
	}

	public void setSystemSkinLoginPage(String systemSkinLoginPage) {
		this.systemSkinLoginPage = systemSkinLoginPage;
	}

	public int getSystemSkinAppId() {
		return systemSkinAppId;
	}

	public void setSystemSkinAppId(int systemSkinAppId) {
		this.systemSkinAppId = systemSkinAppId;
	}

	public Date getSystemSkinDate() {
		return systemSkinDate;
	}

	public void setSystemSkinDate(Date systemSkinDate) {
		this.systemSkinDate = systemSkinDate;
	}

	public int getSystemSkinId() {
		return systemSkinId;
	}

	public void setSystemSkinId(int systemSkinId) {
		this.systemSkinId = systemSkinId;
	}

	public String getSystemSkinBackgroundImg() {
		return systemSkinBackgroundImg;
	}

	public void setSystemSkinBackgroundImg(String systemSkinBackgroundImg) {
		this.systemSkinBackgroundImg = systemSkinBackgroundImg;
	}

	public String getSystemSkinColor() {
		return systemSkinColor;
	}

	public void setSystemSkinColor(String systemSkinColor) {
		this.systemSkinColor = systemSkinColor;
	}

	public String getSystemSkinCss() {
		return systemSkinCss;
	}

	public void setSystemSkinCss(String systemSkinCss) {
		this.systemSkinCss = systemSkinCss;
	}
	
	
}
