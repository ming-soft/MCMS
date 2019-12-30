package net.mingsoft.cms.bean;

import net.mingsoft.cms.entity.CategoryEntity;

/**
* 文章实体
* @author 铭飞开发团队
* 创建日期：2019-11-28 15:12:32<br/>
* 历史修订：<br/>
*/
public class ContentBean extends CategoryEntity {

	/**
	 * 文章编号
	 */
	private int articleId;

	public int getArticleId() {
		return articleId;
	}

	public void setArticleId(int articleId) {
		this.articleId = articleId;
	}
}