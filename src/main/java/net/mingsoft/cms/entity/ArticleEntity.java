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

package net.mingsoft.cms.entity;

import java.io.File;
import java.util.Arrays;

import net.mingsoft.basic.entity.AppEntity;
import net.mingsoft.basic.entity.BasicEntity;
import net.mingsoft.basic.entity.ColumnEntity;
import org.apache.commons.lang3.StringUtils;

import cn.hutool.core.util.ArrayUtil;
import net.mingsoft.base.constant.Const;
import net.mingsoft.mdiy.util.ParserUtil;

/**
 * 
 * @ClassName:  ArticleEntity   
 * @Description:TODO(文章模块实体类 || 继承BasicEntity实体)   
 * @author: 铭飞开发团队
 * @date:   2018年1月31日 下午2:55:48   
 *     
 * @Copyright: 2018 www.mingsoft.net Inc. All rights reserved.
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
		if (!StringUtils.isBlank(app.getAppMobileStyle())) {
			return app.getAppHostUrl()+ParserUtil.HTML+Const.SEPARATOR+ParserUtil.MOBILE+Const.SEPARATOR+this.getArticleUrl();
		}
		return app.getAppHostUrl()+Const.SEPARATOR+ParserUtil.HTML+Const.SEPARATOR+this.getArticleUrl();
	}
}