package com.mingsoft.cms.entity;

import java.io.File;

import com.mingsoft.basic.entity.AppEntity;

import com.mingsoft.basic.entity.BasicEntity;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.StringUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 姓名 郭鹏辉
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:文章模块实体类 || 继承BasicEntity实体
 * </p>
 *  
 * <p>
 * Create Date:2014-7-14
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public class ArticleEntity extends BasicEntity{
	
	/**
	 * 文章Id
	 */
	private int articleID;
	
	/**
	 * 文章内容
	 */
	private String articleContent;
	
	/**
	 * 文章作者
	 */
	private String articleAuthor;
	
	/**
	 * 文章属性
	 */
	private String articleType ;
	
	/**
	 * 文章的来源
	 */
	private String articleSource;

	/**
	 * 文章跳转链接地址
	 */
	private String articleUrl;
	
	/**
	 * 文章关键字
	 */
	private String articleKeyword;
	
	/**
	 * 文章自定义显示顺序
	 */
	@Deprecated
	private int articleFreeOrder;
	
	
	/**
	 * 站点d
	 */
	private int articleWebId;
	
	/**
	 * 文章url地址 主要是用户生成html使用
	 */
	private String articleLinkURL;
	
	/**
	 * 文章分类url地址，主要是用户生成html使用
	 */
	private String articleTypeLinkURL;
	
	/**
	 * 一对一管理栏目
	 */
	private ColumnEntity  column;
	
	
	/**
	 * 获取文章实体所属的栏目实体
	 * @return
	 */
	public ColumnEntity getColumn() {
		return column;
	}
	
	/**
	 * 设置文章所属的栏目实体
	 * @param column
	 */
	public void setColumn(ColumnEntity column) {
		this.column = column;
	}

	public String getArticleTypeLinkURL() {
		return articleTypeLinkURL;
	}

	public void setArticleTypeLinkURL(String articleTypeLinkURL) {
		this.articleTypeLinkURL = articleTypeLinkURL;
	}

	public String getArticleLinkURL() {
		return articleLinkURL;
	}

	public void setArticleLinkURL(String articleLinkURL) {
		this.articleLinkURL = articleLinkURL;
	}

	/**
	 * 获取文章作者
	 * @return 返回文章作者
	 */
	public String getArticleAuthor() {
		return articleAuthor;
	}

	/**
	 * 获取文章内容
	 * @return 返回文章内容
	 */
	public String getArticleContent() {
		return articleContent;
	}

	/**
	 * 获取自定义显示顺序
	 * @return
	 */
	public int getArticleFreeOrder() {
		return articleFreeOrder;
	}
	
	/**
	 * 获取文章Id
	 * @return 返回文章Id
	 */
	public int getArticleID() {
		return articleID;
	}
	
	/**
	 * 获取文章关键字
	 * @return 返回文章关键字
	 */
	public String getArticleKeyword() {
		return articleKeyword;
	}
	
	/**
	 * 获取文章的来源
	 * @return 返回文章的来源
	 */
	public String getArticleSource() {
		return articleSource;
	}
	
	/**
	 * 获取文章属性
	 * @return 返回文章属性
	 */
	public String getArticleType() {
		return articleType;
	}
	
	/**
	 * 获取文章跳转链接
	 * @return 返回文章跳转链接
	 */
	public String getArticleUrl() {
		return articleUrl; 
	}
	
	/**
	 * 获取文章站点id
	 * @return
	 */
	public int getArticleWebId() {
		return articleWebId;
	}
	
	/**
	 * 设置文章作者
	 * @param articleAuthor 传入文章作者
	 */
	public void setArticleAuthor(String articleAuthor) {
		this.articleAuthor = articleAuthor;
	}
	
	/**
	 * 设置文章内容
	 * @param articleContent 传入文章内容
	 */
	public void setArticleContent(String articleContent) {
		this.articleContent = articleContent;
	}
	
	/**
	 * 设置文章自定义显示循序排序
	 * @param articleFreeOrder
	 */
	public void setArticleFreeOrder(int articleFreeOrder) {
		this.articleFreeOrder = articleFreeOrder;
	}

	/**
	 * 设置文章Id
	 * @param articleID 传入文章Id
	 */
	public void setArticleID(int articleID) {
		this.articleID = articleID;
	}

	/**
	 * 设置文章关键字
	 * @param articleKeyword 传入文章关键字列表
	 */
	public void setArticleKeyword(String articleKeyword) {
		this.articleKeyword = articleKeyword;
	}

	/**
	 * 设置文章的来源
	 * @param articleSource 传入文章的来源
	 */
	public void setArticleSource(String articleSource) {
		this.articleSource = articleSource;
	}

	/**
	 * 设置文章属性
	 * @param articleType 传入文章属性
	 */
	public void setArticleType(String articleType) {
		this.articleType = articleType;
	}
	
	/**
	 * 设置文章跳转链接
	 * @param articleUrl 传入文章跳转链接地址
	 */
	public void setArticleUrl(String articleUrl) {
		this.articleUrl = articleUrl;
	}


	/**
	 * 设置文章站点id
	 * @param articleWebId
	 */
	public void setArticleWebId(int articleWebId) {
		this.articleWebId = articleWebId;
	}
	
	public String getArticleUrl(AppEntity app) {
		if (!StringUtil.isBlank(app.getAppMobileStyle())) {
			return app.getAppHostUrl()+IParserRegexConstant.HTML_SAVE_PATH+File.separator+"m"+File.separator+this.getArticleUrl();
		}
		return app.getAppHostUrl()+File.separator+IParserRegexConstant.HTML_SAVE_PATH+File.separator+this.getArticleUrl();
	}
}
