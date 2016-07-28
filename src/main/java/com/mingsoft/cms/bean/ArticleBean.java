/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

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

package com.mingsoft.cms.bean;

import java.io.File;
import java.sql.Timestamp;
import java.util.Date;

import com.mingsoft.base.constant.Const;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.ColumnEntity;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.StringUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞MS平台</b>
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
 * @author 姓名 史爱华
 * 
 * @version 
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments: ArticleEntity实体的bean用于给外部请求数据使用
 * </p>
 *  
 * <p>
 * Create Date:2015-06-15
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public class ArticleBean {
	
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
	
	private int articleFreeOrder;
	
	
	
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
	 * 文章标题
	 */
	private String articleTitle;
	
	/**
	 * 文章描述
	 */
	private String articleDescription;
	
	/**
	 * 文章所属的分类Id
	 */
	private int articleCategoryId;
	
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
	 * 发布时间
	 */
	private Timestamp articleDateTime;

	/**
	 * 更新时间
	 */
	private Date articleUpdateTime;
	
	/**
	 * 缩略图
	 */
	private String articleThumbnails;
	
	/**
	 * 点击次数
	 */
	private int articleHit;
	
	
	
	
	public int getArticleFreeOrder() {
		return articleFreeOrder;
	}

	public void setArticleFreeOrder(int articleFreeOrder) {
		this.articleFreeOrder = articleFreeOrder;
	}

	public String getArticleTitle() {
		return articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}

	public String getArticleDescription() {
		return articleDescription;
	}

	public void setArticleDescription(String articleDescription) {
		this.articleDescription = articleDescription;
	}

	public int getArticleCategoryId() {
		return articleCategoryId;
	}

	public void setArticleCategoryId(int articleCategoryId) {
		this.articleCategoryId = articleCategoryId;
	}

	public int getArticleHit() {
		return articleHit;
	}

	public void setArticleHit(int articleHit) {
		this.articleHit = articleHit;
	}

	public Timestamp getArticleDateTime() {
		return articleDateTime;
	}

	public void setArticleDateTime(Timestamp articleDateTime) {
		this.articleDateTime = articleDateTime;
	}

	public Date getArticleUpdateTime() {
		return articleUpdateTime;
	}

	public void setArticleUpdateTime(Date articleUpdateTime) {
		this.articleUpdateTime = articleUpdateTime;
	}

	public String getArticleThumbnails() {
		return articleThumbnails;
	}

	public void setArticleThumbnails(String articleThumbnails) {
		this.articleThumbnails = articleThumbnails;
	}

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



	
	public String getArticleUrl(AppEntity app) {
		if (!StringUtil.isBlank(app.getAppMobileStyle())) {
			return app.getAppHostUrl()+IParserRegexConstant.HTML_SAVE_PATH+Const.SEPARATOR+IParserRegexConstant.MOBILE+Const.SEPARATOR+this.getArticleUrl();
		}
		return app.getAppHostUrl()+Const.SEPARATOR+IParserRegexConstant.HTML_SAVE_PATH+Const.SEPARATOR+this.getArticleUrl();
	}
	
}