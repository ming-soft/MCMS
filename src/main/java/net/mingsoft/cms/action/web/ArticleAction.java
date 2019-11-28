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

package net.mingsoft.cms.action.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import io.swagger.annotations.ApiOperation;
import net.mingsoft.base.filter.DateValueFilter;
import net.mingsoft.basic.action.BaseAction;
import net.mingsoft.basic.bean.ListBean;
import net.mingsoft.basic.biz.IColumnBiz;
import net.mingsoft.basic.entity.ColumnEntity;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.biz.IArticleBiz;
import net.mingsoft.cms.entity.ArticleEntity;
import net.mingsoft.mdiy.biz.IContentModelBiz;
import net.mingsoft.mdiy.biz.IContentModelFieldBiz;
import net.mingsoft.mdiy.entity.ContentModelEntity;
import springfox.documentation.annotations.ApiIgnore;

/**
 * 
 * @ClassName:  ArticleAction   
 * @Description:TODO 前段文章控制，如果标签不能满足可以使用这个控制来满足用户的查询文章需求，主要是通过ajax返回json数据格式   
 * @author: 铭飞开发团队
 * @date:   2018年1月31日 下午2:52:44   
 *     
 * @Copyright: 2018 www.mingsoft.net Inc. All rights reserved.
 */
@Controller("jsonApiArticle")
@RequestMapping("/mcms/article")
public class ArticleAction extends BaseAction {

	/**
	 * 文章管理业务处理层
	 */
	@Autowired
	private IArticleBiz articleBiz;

	/**
	 * 栏目管理业务处理层
	 */
	@Autowired
	private IColumnBiz columnBiz;

	/**
	 * 内容模型管理业务处理层
	 */
	@Autowired
	private IContentModelBiz contentModelBiz;

	/**
	 * 自定义字段管理业务处理层
	 */
	@Autowired
	private IContentModelFieldBiz fieldBiz;

	/**
	 * 文章信息
	 * 
	 * @param basicId
	 *            文章编号
	 *            <dt><span class="strong">返回</span></dt><br/>
	 *            {"basicCategoryId":分类编号,basicTitle
	 *            :"标题",basicDescription:"描述",basicThumbnails:"缩略图",
	 *            basicDateTime:"发布时间",basicUpdateTime:"更新时间","basicHit":点击数,
	 *            "basicId":编号 articleContent:"文章内容","basicSort":排序,[自定义模型字段]}
	 */
	@GetMapping("/{basicId}/detail")
	@ResponseBody
	public void detail(@PathVariable int basicId, HttpServletRequest request, HttpServletResponse response) {
		ArticleEntity article = articleBiz.getById(basicId);
		if (article == null) {
			this.outJson(response, "");
			return;
		}
		// 获取文章栏目id获取栏目实体
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(article.getBasicCategoryId());
		ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz
				.getEntity(column.getColumnContentModelId());

		// 判断内容模型的值
		if (contentModel != null) {
			Map where = new HashMap();
			// 压入basicId字段的值
			where.put("basicId", basicId);
			// 遍历所有的字段实体,得到字段名列表信息
			List<String> listFieldName = new ArrayList<String>();
			listFieldName.add("basicId");
			// 查询新增字段的信息
			List fieldLists = fieldBiz.queryBySQL(contentModel.getCmTableName(), listFieldName, where);
			if (fieldLists.size() > 0) {
				Map map = (Map) fieldLists.get(0);
				article.setExtendsFields(map);
			}
		}

		this.outJson(response, JSONObject.toJSONStringWithDateFormat(article, "yyyy-MM-dd hh:mm:ss"));
	}


	/**
	 * 文章列表信息
	 * 
	 * @param pageSize
	 *            一页显示数量
	 * @param pageNum
	 *            当前页码
	 * @param basicCategoryId
	 *            分类编号
	 *            <dt><span class="strong">返回</span></dt><br/>
	 *            {"list":"[{
	 *            "basicTitle":"标题",
	 *            "basicDescription":"描述",
	 *            "basicThumbnails":"缩略图",
	 *            "basicDateTime":"发布时间",
	 *            "basicUpdateTime":"更新时间",
	 *            "basicHit":点击数,
	 *            "basicId":编号,
	 *            "articleContent":文章内容,
	 *            "articleAuthor":文章作者
	 *      	  "articleType":文章属性,
	 *      	  "articleSource":文章的来源,
	 *      	  "articleUrl":文章跳转链接地址,
	 *      	  "articleKeyword":文章关键字,
	 *      	  "articleCategoryId":文章所属的分类Id,
	 *      	  "articleTypeLinkURL":文章分类url地址，主要是用户生成html使用,
	 *            "order":"排序方式",
	 *            "orderBy":"排序字段     
	 *            }],
	 *             "page":{"endRow": 2,  当前页面最后一个元素在数据库中的行号
	 * 				"firstPage": 1, 第一页页码
	 * 				"hasNextPage": true存在下一页false不存在, 
	 * 				"hasPreviousPage": true存在上一页false不存在, 
	 * 				"isFirstPage": true是第一页false不是第一页, 
	 * 				"isLastPage": true是最后一页false不是最后一页, 
	 * 				"lastPage": 最后一页的页码, 
	 * 				"navigatePages": 导航数量，实现 1...5.6.7....10效果, 
	 * 				"navigatepageNums": []导航页码集合, 
	 * 				"nextPage": 下一页, 
	 * 				"pageNum": 当前页码, 
	 * 				"pageSize": 一页显示数量, 
	 * 				"pages": 总页数, 
	 * 				"prePage": 上一页, 
	 * 				"size": 总记录, 
	 * 				"startRow":当前页面第一个元素在数据库中的行号, 
	 * 				"total":总记录数量
	 * 				}
	 */
	@RequestMapping(value = "/list",method= RequestMethod.GET)
	@ApiOperation(value="文章列表信息")
	@ResponseBody
	public void list(@ModelAttribute @ApiIgnore ArticleEntity article, HttpServletRequest request, HttpServletResponse response) {
		int appId = BasicUtil.getAppId();
		int[] ids = null;
		if (article.getBasicCategoryId()>0) {
			 ids = new int[]{article.getBasicCategoryId()};
		}
		//默认为desc排序
		boolean isOrder = true;
		if(!StringUtils.isBlank(article.getOrder())){
			String	basicOrder = article.getOrder();
			if(basicOrder.equalsIgnoreCase("asc")){
				isOrder = false;
			}
		}
		BasicUtil.startPage();
		List<ArticleEntity> list = articleBiz.query(appId, ids, null, null, article.getOrderBy(), isOrder, null, null, article);
		
		for(ArticleEntity _article : list){
			// 获取文章栏目id获取栏目实体
			ColumnEntity column = (ColumnEntity) columnBiz.getEntity(_article.getBasicCategoryId());
			ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz
					.getEntity(column.getColumnContentModelId());

			// 判断内容模型的值
			if (contentModel != null) {
				Map where = new HashMap();
				// 压入basicId字段的值
				where.put("basicId", _article.getBasicId());
				// 遍历所有的字段实体,得到字段名列表信息
				List<String> listFieldName = new ArrayList<String>();
				listFieldName.add("basicId");
				// 查询新增字段的信息
				List fieldLists = fieldBiz.queryBySQL(contentModel.getCmTableName(), listFieldName, where);
				if (fieldLists.size() > 0) {
					Map map = (Map) fieldLists.get(0);
					_article.setExtendsFields(map);
				}
			}
		}
		this.outJson(response, JSONArray.toJSONString(new ListBean(list, BasicUtil.endPage(list)),new DateValueFilter("yyyy-MM-dd HH:mm:ss")));
	}

}