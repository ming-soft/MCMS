package com.mingsoft.cms.parser.impl;



import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.parser.IParser;


/**
 * 当前文章的上一篇文章，下一篇文章的链接标题解析（单标签） 上一篇文章链接：{ms:field.prelink/} 上一篇文章标题：{ms:field.pretitle/} 下一篇文章链接：{ms:field.nextlink/} 下一篇文章标题：{ms:field.nexttitle/} 文章内容标签
 * 
 * @author 成卫雄 QQ:330216230 技术支持：景德镇铭飞科技 官网：www.ming-soft.com
 */
public class ArticleHistoryParser extends IParser {
	
	
	/**
	 * 文章上一篇连接标签
	 */
	private final static String ARTICLE_PRELINK_FIELD="\\{ms:field.prelink/\\}";
	
	/**
	 *  上一篇文章标题 标签
	 */
	private final static String ARTICLE_PRETITLE_FIELD="\\{ms:field.pretitle/\\}";
	
	/**
	 *  文章下一篇连接标签
	 */
	private final static String ARTICLE_NEXTLINK_FIELD="\\{ms:field.nextlink/\\}";
	
	/**
	 * 文章下一篇标题标签
	 */
	private final static String ARTICLE_NEXTTITLE_FIELD="\\{ms:field.nexttitle/\\}";

	
	/**
	 * 上一篇文章
	 */
	private ArticleEntity previous;
	
	/**
	 * 下一篇文章
	 */
	private ArticleEntity next;

	/**
	 * 构造必须的参数
	 * 
	 * @param htmlContent
	 *            原HTML代码
	 * @param newContent
	 *            标签内容
	 * @param urlPage
	 *            当前项目的相对地址
	 */
	public ArticleHistoryParser(String htmlContent, ArticleEntity previous, ArticleEntity next) {
		super.htmlCotent = htmlContent;
		this.previous = previous;
		this.next = next;
	}

	@Override
	public String parse() {
		// TODO Auto-generated method stub
		if (this.previous != null) {
			// 替换上一篇文章链接
			super.htmlCotent = replaceRegex(this.previous.getArticleLinkURL(),ARTICLE_PRELINK_FIELD);
			// 替换上一篇文章标题
			super.htmlCotent = replaceRegex(this.previous.getBasicTitle(),ARTICLE_PRETITLE_FIELD);
		} else {
			// 替换上一篇文章链接
			super.htmlCotent = replaceRegex("#",ARTICLE_PRELINK_FIELD);
			// 替换上一篇文章标题
			super.htmlCotent = replaceRegex("",ARTICLE_PRETITLE_FIELD);
		}
		if (this.next != null) {
			// 替换上一篇文章链接
			super.htmlCotent = replaceRegex(this.next.getArticleLinkURL(),ARTICLE_NEXTLINK_FIELD);
			// 替换上一篇文章标题
			super.htmlCotent = replaceRegex(this.next.getBasicTitle(),ARTICLE_NEXTTITLE_FIELD);
		} else {
			// 替换上一篇文章链接
			super.htmlCotent = replaceRegex("#", ARTICLE_NEXTLINK_FIELD);
			// 替换上一篇文章标题
			super.htmlCotent = replaceRegex("", ARTICLE_NEXTTITLE_FIELD);
		}
		return super.htmlCotent;
	}

	/**
	 * 替换不同的标签
	 * 
	 * @param htmlContent
	 *            HTML代码
	 * @param newContent
	 *            替换内容
	 * @param regex
	 *            正则表达式
	 * @return 替换完成后的HTML代码
	 */
	private String replaceRegex(String newContent, String regex) {
		// 判断用户是否在HTML代码中写入了该标签
		super.newCotent = newContent;
		String overHtml = super.replaceAll(regex);
		return overHtml;
	}

}
