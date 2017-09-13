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

package com.mingsoft.cms.parser;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IColumnBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.ColumnEntity;
import com.mingsoft.basic.parser.IGeneralParser;
import com.mingsoft.cms.biz.IArticleBiz;
import com.mingsoft.cms.constant.ModelCode;
import com.mingsoft.cms.entity.ArticleEntity;
import com.mingsoft.cms.parser.impl.ArticleAuthorParser;
import com.mingsoft.cms.parser.impl.ArticleContentParser;
import com.mingsoft.cms.parser.impl.ArticleDateParser;
import com.mingsoft.cms.parser.impl.ArticleDescripParser;
import com.mingsoft.cms.parser.impl.ArticleHistoryParser;
import com.mingsoft.cms.parser.impl.ArticleIdParser;
import com.mingsoft.cms.parser.impl.ArticleKeywordParser;
import com.mingsoft.cms.parser.impl.ArticleLinkParser;
import com.mingsoft.cms.parser.impl.ArticleLitpicParser;
import com.mingsoft.cms.parser.impl.ArticleSourceParser;
import com.mingsoft.cms.parser.impl.ArticleTitleParser;
import com.mingsoft.cms.parser.impl.ArticleTypeIdParser;
import com.mingsoft.cms.parser.impl.ArticleTypeLinkParser;
import com.mingsoft.cms.parser.impl.ArticleTypeTitleParser;
import com.mingsoft.cms.parser.impl.ChannelParser;
import com.mingsoft.cms.parser.impl.ColumnParser;
import com.mingsoft.cms.parser.impl.HitParser;
import com.mingsoft.mdiy.biz.IContentModelBiz;
import com.mingsoft.mdiy.biz.IContentModelFieldBiz;
import com.mingsoft.mdiy.entity.ContentModelEntity;
import com.mingsoft.mdiy.entity.ContentModelFieldEntity;
import com.mingsoft.mdiy.parser.ListParser;
import com.mingsoft.mdiy.parser.TaglibParser;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.parser.PageUtilHtml;
import com.mingsoft.parser.impl.general.ChannelContParser;
import com.mingsoft.parser.impl.general.PageNumParser;
import com.mingsoft.parser.impl.general.PageParser;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

import net.mingsoft.basic.util.BasicUtil;

/**
 * 替换标签类
 * 
 * @author 成卫雄 QQ:330216230 技术支持：景德镇铭飞科技 官网：www.ming-soft.com
 */
@Component
@Scope("prototype")
public class CmsParser extends IGeneralParser {

	
	/**
	 * 文章业务层
	 */
	@Autowired
	private IArticleBiz articleBiz;

	/**
	 * 栏目业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;

	/**
	 * 新增字段业务层 
	 */
	@Autowired
	private IContentModelFieldBiz fieldBiz; 

	/**
	 * 内容模型业务层
	 */
	@Autowired
	private IContentModelBiz contentBiz;
	
	/**
	 * 当前页码
	 */
	private int curPageNo;
	
	
	
	/**
	 * 列表连接地址
	 */
	private String listLinkPath;

	private ArticleEntity article, previous, next;

	private ColumnEntity column;
	
	
	/**
	 * 新增模块业务层
	 */
	@Autowired
	private IModelBiz modelBiz;
	
	private List searchList = null;

	/**
	 * 当前栏目编号，根据栏目生成时候用到
	 */
	private int curColumnId;
	
	public static final String CUR_COLUMNID="curColumnId",PREVIOUS="previous",NEXT="next",CUR_PAGE_NO="curPageNo",LIST_LINK_PATH="listLinkPath";
	
	public static final String 	LIST_ARTICLE = "articleList",SEARCH_LIST_ARTICLE="searchList";
	
	/**
	 * obj:
	 */
	@Override
	public String parse(String html,Object... obj) {
		super.htmlContent = html;
		init(obj);
		modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		htmlContent = parseGeneral();
		htmlContent = parseChannel();
		htmlContent  = parseSearchList();
		htmlContent = parseList();
		htmlContent = parseArclist();
		htmlContent = parsePage();
		htmlContent = parseArticle();
		
		return htmlContent;
	}
	

	public void init(Object... obj) {
		super.init(obj);
		mobilePath = "";
		column = null;
		this.curColumnId = 0;
		article = null;
		searchList = null;
		page = null;
		curPageNo=1;
		previous=null;
		next=null;
		for (Object o : obj) {
		if (o != null) {
				if (o instanceof Map) {
					Map temp = (Map) o;
					if (StringUtil.isInteger(temp.get(CUR_COLUMNID))) {
						curColumnId = Integer.parseInt(temp.get(CUR_COLUMNID) + "");
					}
					if (temp.get(PREVIOUS) instanceof ArticleEntity) {
						previous =(ArticleEntity)temp.get(PREVIOUS);
					}
					if (temp.get(NEXT) instanceof ArticleEntity) {
						next =(ArticleEntity)temp.get(NEXT);
					}			
					if (StringUtil.isInteger(temp.get(CUR_PAGE_NO) )) {
						curPageNo = Integer.parseInt(temp.get(CUR_PAGE_NO)+"");
					}		
					if (!StringUtil.isBlank(temp.get(LIST_LINK_PATH) )) {
						listLinkPath = temp.get(LIST_LINK_PATH)+"";
					}			
					if (!StringUtil.isBlank(temp.get(MOBILE) )) {
						mobilePath = temp.get(MOBILE)+"";
					}
					if (temp.get(SEARCH_LIST_ARTICLE)  instanceof  java.util.List) {
						//搜索时候的文章列表数据
						searchList = (List)temp.get(SEARCH_LIST_ARTICLE);
					}
				}
				if (o instanceof ColumnEntity) {
					column = (ColumnEntity)o;
					//直接影响ms:arclist的数据，根据栏目生成的时候需要必须要进行此操作
					this.curColumnId = column.getCategoryId();
				}
				if (o instanceof ArticleEntity) { //显示文章内容的时候必须存在
					article = (ArticleEntity)o;
				}
				if (o instanceof AppEntity) { //显示文章内容的时候必须存在
					app = (AppEntity)o;
				}
				if (o instanceof PageUtil) { //显示 文章搜索的时候必须存在
					page = (PageUtil)o;
				}
			}
		}
	}

	/**
	 * 查找页面中分页标签中出现的size的值
	 * 
	 * @param htmlContent
	 * @param column
	 * @param curPageNo
	 * @return
	 */
	public int getPageSize(AppEntity website, String htmlContent, ColumnEntity column) {
		this.app = website;
		// 页面总数，默认为1
		int pageSize = 1;
		// 当前列表标签中属性的集合-------------------
		Map<String, String> property = ListParser.listProperty(htmlContent, true);
		// 没有找到分页标签标签
		if (property == null) {
			return pageSize;
		}
		String isPaging = property.get(ListParser.LIST_ISPAGING);
		if (!StringUtil.isBlank(isPaging) && isPaging.equals("true")) {
			int[] columnIds = null;
			if(column!=null){
				// 取出当前栏目下的子栏目Id
				if (column.getCategoryId() != 0) {
					int[] _columnIds = columnBiz.queryChildIdsByColumnId(column.getCategoryId(), app.getAppId());
					columnIds = new int [_columnIds.length+1]; 
					if (_columnIds.length>0) {
						System.arraycopy(_columnIds, 0, columnIds, 0, _columnIds.length-1);
					}
					columnIds[_columnIds.length] = column.getCategoryId();
				}
			}
			// 列表每页显示的数量
			int size = StringUtil.string2Int(property.get(ListParser.LIST_SIZE));
			// 显示文章的形式flag属性
			String flag = property.get(ListParser.LIST_FLAG);
			// 显示文章的形式noflag属性
			String noFlag = property.get(ListParser.LIST_NOFLAG);
			// 数据库中该栏目下文章的总数
			;
			int articleCount = articleBiz.count(website.getAppId(), columnIds, flag, noFlag, null);
			// 当用户知道的显示数量小于0或大于文章实际总数时
			if (size <= 0 || size > articleCount) {
				size = articleCount;
			}
			// 如果文章总数为0则分页数量为1
			if (size == 0) {
				pageSize = 1;
				return pageSize;
			}
			pageSize = articleCount % size >= 1 ? articleCount / size + 1 : articleCount / size;
		}
		return pageSize;
	}

	/**
	 * 解析列表标签
	 * 
	 * @param htmlContent
	 *            模版内容
	 * @param linkColumnId
	 *            栏目编号
	 * @return　替换好的内容
	 */
	private String parseArclist() {
		// 查找当前模版页面拥有多少个列表标签
		int listNum = ListParser.countArcList(super.htmlContent);
		//List<String> noParserHtml = new ArrayList<String>();
		// 替换完分页标签后的HTML代码
		for (int i = 0; i < listNum; i++) {
			
			// 当前列表标签中属性的集合-------------------
			Map<String, String> property = ListParser.listProperty(super.htmlContent, false);
			// 取当前标签下的栏目ID
			int columnId = StringUtil.string2Int(property.get(ListParser.LIST_TYPEID));
			// 列表每页显示的数量
			int size = StringUtil.string2Int(property.get(ListParser.LIST_SIZE));
			// 显示文章的形式flag属性
			String flag = property.get(ListParser.LIST_FLAG);
			// 显示文章的形式noflag属性
			String noFlag = property.get(ListParser.LIST_NOFLAG);
			// 排序
			String orderBy = property.get(ListParser.LIST_ORDERBY);
			String order = property.get(ListParser.LIST_ORDER);
			// 取出当前栏目下的子栏目Id
			int[] columnIds = null;
			if (columnId != 0) {
				int[] _columnIds = columnBiz.queryChildrenCategoryIds(columnId, app.getAppId(),modelId);
				columnIds = new int[_columnIds.length+1];
				if (_columnIds.length>0) {
					System.arraycopy(_columnIds, 0, columnIds, 0, _columnIds.length);
				}
				
				columnIds[_columnIds.length]=columnId;
			} else {
				columnId = this.curColumnId;
				columnIds = columnBiz.queryChildrenCategoryIds(columnId, app.getAppId(),modelId);
			}
			// 数据库中该栏目下文章的总数
			int articleCount = articleBiz.getCountByColumnId(app.getAppId(), columnIds, flag, noFlag);

			// 如果没有指定文章每页显示数量则显示所有数量
			if (size <= 0 || size > articleCount) {
				size = articleCount;
			}
			// 当数据库中该栏目下没有该文章时不取数据
			if (articleCount != 0) {
				/**
				 * 判断文章列表的orderby属性
				 */
				if (StringUtil.isBlank(order)) {
					order = "desc";
				}
				// 从数据库取出文章列表数组
				BasicUtil.startPage(0,size,false);
				List<ArticleEntity> listArticles = articleBiz.query(app.getAppId(), columnIds, flag, noFlag,orderBy, order.equals("desc") ? true : false,null);
				BasicUtil.endPage(listArticles);
				// 替换列表标签
				htmlContent = new com.mingsoft.cms.parser.impl.ListParser(app,htmlContent, listArticles,  this.getWebsiteUrl(), property, false, fieldBiz, contentBiz).parse();
			}else{
				htmlContent = new com.mingsoft.cms.parser.impl.ListParser(app,htmlContent, null,  this.getWebsiteUrl(), property, false, fieldBiz, contentBiz).parse();
			}
		}
		return htmlContent;
	}

	/**
	 * 解析文章内容
	 * 
	 * @param article
	 *            当前文章
	 * @param previous当前文章的上一篇
	 * @param next当前文章的下一篇
	 * @return
	 */
	private String parseArticle() {
		if (article == null) {
			return htmlContent;
		}
		// 获取文章所属的栏目实体
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(article.getBasicCategoryId());
		if(column==null){
			return htmlContent;
		}
		// 替换文章作者标签：{ms:field.author/}
		htmlContent = new ArticleAuthorParser(htmlContent, article.getArticleAuthor()).parse();

		// 替换文章内容标签：{ms:field.content/}
		htmlContent = new ArticleContentParser(htmlContent, article.getArticleContent()).parse();

		// 替换文章时间标签：{ms:field.date fmt="yyyy-mm-dd"/}
		htmlContent = new ArticleDateParser(htmlContent, article.getBasicDateTime()).parse();

		// 替换文章发布来源标签：{ms:field.source/}
		htmlContent = new ArticleSourceParser(htmlContent, article.getArticleSource()).parse();

		// 替换文章标题标签： {ms:field.title/}
		htmlContent = new ArticleTitleParser(htmlContent, article.getBasicTitle()).parse();

		// 替换文章点击数标签： {ms:field.hit/}
		htmlContent = new HitParser(htmlContent,"<script type='text/javascript' src='"+app.getAppHostUrl()+"/basic/"+article.getBasicId()+"/hit.do' ></script>").parse();
				
		// 替换文章id标签： {ms:field.id/}
		htmlContent = new ArticleIdParser(htmlContent, article.getBasicId() + "").parse();

		// 替换文章描述： {ms:field.Descrip/}
		htmlContent = new ArticleDescripParser(htmlContent, article.getBasicDescription()).parse();
		
		// 替换文章关键字： {ms:field.keyword/}
		htmlContent = new ArticleKeywordParser(htmlContent, article.getArticleKeyword()).parse();

		// 替换文章缩略图标签
		htmlContent = new ArticleLitpicParser(htmlContent, article.getBasicThumbnails()).parse();
		//解析当前栏目信息
		htmlContent = new ColumnParser(htmlContent,column,this.getWebsiteUrl()).parse();
		// 替换文章栏目链接标签{ms:filed.typelink/}
		ColumnEntity tmp = null;
		htmlContent = new ArticleTypeIdParser(htmlContent, column.getCategoryId() + "").parse();
		ArticleTypeTitleParser attp = new ArticleTypeTitleParser(htmlContent, column.getCategoryTitle());
		if (attp.isTop()) {
			if (column.getCategoryCategoryId() > 0) {
				tmp = (ColumnEntity) columnBiz.getEntity(column.getCategoryCategoryId());
				attp.setNewCotent(tmp.getCategoryTitle());
			}
		} else {
			attp.setNewCotent(column.getCategoryTitle());
		}
		htmlContent = attp.parse();

		// 替换文章栏目链接标签{ms:filed.typelink/}
		ArticleTypeLinkParser atlp = new ArticleTypeLinkParser(htmlContent, this.getWebsiteUrl() + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
		if (atlp.isTop()) {
			if (tmp == null && column.getCategoryCategoryId() > 0) { // 如果用户写分类名称标签的时候没有使用top属性，而在使用连接标签的时候使用就再次查询分类
				tmp = (ColumnEntity) columnBiz.getEntity(column.getCategoryCategoryId());
			}
			atlp.setNewCotent(this.getWebsiteUrl() + tmp.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
		}
		htmlContent = atlp.parse();

		// 替换当前文章内容链接标签：{ms:field.link}
		htmlContent = new ArticleLinkParser(htmlContent, article.getArticleLinkURL()).parse();

		// 替换上一篇文章、下一篇文章，链接、标题，标签
		htmlContent = new ArticleHistoryParser(htmlContent, previous, next).parse();

		// 判断该文章是否有新增字段
		if (column.getColumnContentModelId() != 0) {
			// 根据表单类型id查找出所有的字段信息
			List<BaseEntity> listField = fieldBiz.queryListByCmid(column.getColumnContentModelId());
			// 遍历所有的字段实体,得到字段名列表信息
			List<String> listFieldName = new ArrayList<String>();
			for (int i = 0; i < listField.size(); i++) {
				ContentModelFieldEntity field = (ContentModelFieldEntity) listField.get(i);
				listFieldName.add(field.getFieldFieldName());
			}
			ContentModelEntity contentModel = (ContentModelEntity) contentBiz.getEntity(column.getColumnContentModelId());
			// 组织where条件
			Map<String, Integer> where = new HashMap<String, Integer>();
			where.put("basicId", article.getBasicId());
			// 获取各字段的值
			// 根据表单类型id查找出所有的字段信息
			List fieldLists = fieldBiz.queryBySQL(contentModel.getCmTableName(), listFieldName, where);
			if(fieldLists.size()>0){
				Map filedValue = (Map) fieldLists.get(0);
				if (filedValue != null) {
					htmlContent = new TaglibParser(htmlContent, filedValue, column.getColumnContentModelId(), fieldBiz,listField).parse();
				}
			}
			

			// 读取并解析各标签内容
		}
		return htmlContent;
	}

	/**
	 * 解析分类标签
	 * 
	 * @param htmlContent
	 *            　原始html内容
	 * @param column
	 *            　
	 * @param websiteUrl
	 *            网站连接地址
	 * @return
	 */
	private String parseChannel() {
		// 替换完文章标签后的HTML模版

		// 当只存在栏目ID时，解析相关的文章中的栏目标签
		if (column != null) {
			ColumnEntity tmp = null;
			String columnTitle = column.getCategoryTitle();
			int columnId = column.getCategoryId();
			//解析当前栏目信息
			htmlContent = new ColumnParser(htmlContent,column,this.getWebsiteUrl()).parse();
			// 解析当前栏目id// 替换文章所在栏目标签：{ms:field.typeid/}
			ArticleTypeIdParser atId = new ArticleTypeIdParser(htmlContent, columnId+ "");
			if (atId.isTop()) {
				if (column.getCategoryCategoryId() > 0) {
					tmp = (ColumnEntity) columnBiz.getEntity(column.getCategoryCategoryId());
					columnId = tmp.getCategoryId();
				}
			}
			htmlContent = new ArticleTypeIdParser(htmlContent, column.getCategoryId() + "").parse();
			// 替换文章所在栏目标签：{ms:field.typetitle/}
			ArticleTypeTitleParser attp = new ArticleTypeTitleParser(htmlContent, columnTitle);
			if (attp.isTop()) {
				if (column.getCategoryCategoryId() > 0) {
					tmp = (ColumnEntity) columnBiz.getEntity(column.getCategoryCategoryId());
					columnTitle = tmp.getCategoryTitle();
				}
			}
			attp.setNewCotent(columnTitle);
			htmlContent = attp.parse();
			// 替换文章栏目链接标签{ms:filed.typelink/}
			ArticleTypeLinkParser atlp = new ArticleTypeLinkParser(htmlContent, this.getWebsiteUrl() + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
			if (atlp.isTop()) {
				if (column.getCategoryCategoryId() > 0) { // 如果用户写分类名称标签的时候没有使用top属性，而在使用连接标签的时候使用就再次查询分类
					tmp = (ColumnEntity) columnBiz.getEntity(column.getCategoryCategoryId());
					atlp.setNewCotent(this.getWebsiteUrl() + tmp.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
				}else{
					atlp.setNewCotent(this.getWebsiteUrl() + column.getColumnPath() + File.separator + IParserRegexConstant.HTML_INDEX);
				}
				
			}
			htmlContent = atlp.parse();
		}
		// //----------------------------解析栏目标签----------------------------

		// //替换完列表标签后的HTML文件
		String channel = htmlContent;

		// 查找当前模版页面拥有多少个栏目列表标签
		int strNumType = ChannelParser.channelNum(channel);

		for (int i = 0; i < strNumType; i++) {
			// 当前列表栏目中属性的集合
			Map<String, String> mapProperty = ChannelParser.channelProperty(channel);

			// 取当前标签下的栏目ID
			int tempColumnId = StringUtil.string2Int(mapProperty.get(ChannelParser.CHANNEL_TYPEID));

			if (tempColumnId == 0 && column != null) {
				tempColumnId = column.getCategoryId();
			}
			List<ColumnEntity> categoryList = null;
			//指定要显示的栏目数量
			String size = mapProperty.get(ChannelParser.CHANNEL_TYPE_SIZE);
			Integer _size = null;
			if(!StringUtil.isBlank(size) && StringUtil.isInteger(size)){
				if(StringUtil.string2Int(size)>0){
					_size = StringUtil.string2Int(size);
				}
				
			}
			if (tempColumnId != 0) {
				// 取出栏目的取值范围
				String type = mapProperty.get(ChannelParser.CHANNEL_TYPE);
				//同级栏目是否显示属性
				String childType = mapProperty.get(ChannelParser.CHANNEL_TYP_SIBLING);
				// 根据范围在BIZ中取出不同的栏目信息
				
				
				
				// 判断用户填写的栏目属性，如果未填写那么取当前栏目的下级栏目，如果但前栏目没有下级栏目那么晚取本级栏目
				// 如果填写:son,那么取下级栏目，没有下级栏目则取本级栏目
				// 如果为：top,那么取上级栏目，如果没有上级栏目则取本级栏目
				// 如果为：level,则取本级栏目
				if (type == null) {
					categoryList = columnBiz.queryChildListByColumnId(tempColumnId,_size);
					//当值为true表示不存在子级分类时，显示他的同级分类
					if(childType!=null && childType.equals("true") && categoryList.size()<=0){
						categoryList = columnBiz.querySibling(tempColumnId,_size);
					}
				} else if (type.equals(ChannelParser.CHANNEL_TYPE_SON)) {
					categoryList = columnBiz.queryChildListByColumnId(tempColumnId,_size);
				} else if (type.equals(ChannelParser.CHANNEL_TYPE_TOP)) {
					categoryList = columnBiz.queryTopSiblingListByColumnId(tempColumnId,_size);
				} else if (type.equals(ChannelParser.CHANNEL_TYPE_LEVEL)) {
					categoryList = columnBiz.querySibling(tempColumnId,_size);
				}
				// 替换栏目标签
				htmlContent = new ChannelParser(channel, categoryList, this.getWebsiteUrl(), column != null ? column.getCategoryId() : 0, mapProperty.get(ChannelParser.CHANNEL_CLASS)).parse();
				// 替换完栏目标签后的HTML代码
				channel = htmlContent;
			} else {
				categoryList = columnBiz.queryChild(tempColumnId, app.getAppId(),modelId,_size);
				// 替换栏目标签
				htmlContent = new ChannelParser(channel, categoryList, this.getWebsiteUrl()).parse();
				// 替换完栏目标签后的HTML代码
				channel = htmlContent;
			}
		}
		// 替换完封面标签后的TML文件
		String channelContHtml = channel;
		// 查找当前模版页面拥有多少个封面列表标签
		int channelConNum = ChannelContParser.channelContNum(channelContHtml);
		for (int i = 0; i < channelConNum; i++) {
			// 取出当前封面标签中的封面ID
			int channelTypeId = ChannelContParser.channelContTypeId(channelContHtml);
			if (channelTypeId == 0 && column != null) {
				channelTypeId = column.getCategoryId();
			}
			String channelCont = "";
			// 取出当前封面的内容
			if (channelTypeId != 0) {
				List<ArticleEntity> arctile = articleBiz.queryListByColumnId(channelTypeId);
				if (arctile != null) {
					if (arctile.size() > 0) {
						channelCont = arctile.get(arctile.size() - 1).getArticleContent();
					} else {
						channelCont = arctile.get(arctile.size()).getArticleContent();
					}
				}
			}
			// 替换封面标签
			htmlContent = new ChannelContParser(channelContHtml, channelCont).parse();
			channelContHtml = htmlContent;
		}

		return htmlContent;
	}

	/**
	 * 解析分页列表标签
	 * 
	 * @param htmlContent
	 *            模版内容
	 * @param column
	 *            栏目编号
	 * @param curPageNo
	 *            当前页码
	 * @return　替换好的内容
	 */
	private String parseList() {
	
		// 替换完分页标签后的HTML代码
		// 当前列表标签中属性的集合-------------------
		Map<String, String> property = ListParser.listProperty(htmlContent, true);
		if (property == null) { // 没有找到分页标签标签
			return htmlContent;
		}
		String isPaging = property.get(ListParser.LIST_ISPAGING);
		if (isPaging != null && isPaging.equals("true")) {
			int[] columnIds = null;
			if (column!=null) {
				this.curColumnId = column.getCategoryId();
				int[] _columnIds = columnBiz.queryChildrenCategoryIds(curColumnId, app.getAppId(),modelId);
				columnIds = new int[_columnIds.length+1];
				if (_columnIds.length>0) {
					System.arraycopy(_columnIds, 0, columnIds, 0, _columnIds.length);
				}
				columnIds[_columnIds.length]=curColumnId;
				// 取出当前栏目下的子栏目Id
				// 列表每页显示的数量
				int size = StringUtil.string2Int(property.get(ListParser.LIST_SIZE));
				// 显示文章的形式flag属性
				String flag = property.get(ListParser.LIST_FLAG);
				// 显示文章的形式noflag属性
				String noFlag = property.get(ListParser.LIST_NOFLAG);
				// 排序
				String orderBy = property.get(ListParser.LIST_ORDERBY);
				String order = property.get(ListParser.LIST_ORDER);
				// 数据库中该栏目下文章的总数
				int articleCount = articleBiz.getCountByColumnId(app.getAppId(), columnIds, flag, noFlag);
				// 如果没有指定文章每页显示数量则显示所有数量
				if (size <= 0 || size > articleCount) {
					size = articleCount;
				}
				//设置page实例，防止该栏目下没有文章时，page标签不渲染
				if (page==null)  {
					page = new PageUtilHtml(curPageNo, size, articleCount, listLinkPath);
				}
				// 当数据库中该栏目下没有该文章时不取数据
				if (articleCount != 0) {
					/**
					 * 判断文章列表的orderby属性
					 */
					if (StringUtil.isBlank(order)) {
						order = "desc";
					}
					
					BasicUtil.startPage(page.getPageNo()+1,page.getPageSize(),false);
					// 从数据库取出文章列表数组
					List<ArticleEntity> listArticles = articleBiz.query(this.app.getAppId(), columnIds, flag, noFlag,  orderBy, order.equals("desc") ? true : false,null);
					// 替换列表标签
					htmlContent = new com.mingsoft.cms.parser.impl.ListParser(app,htmlContent, listArticles,  this.getWebsiteUrl(), property, true, fieldBiz, contentBiz).parse();
				}else{
					htmlContent = new com.mingsoft.cms.parser.impl.ListParser(app,htmlContent, null,  this.getWebsiteUrl(), property, true, fieldBiz, contentBiz).parse();
				}
			}
		}
		return htmlContent;
	}


	/**
	 * 解析分页标签
	 * @return
	 */
	private String parsePage() {
		// 替换分页标签
		htmlContent = new PageParser(htmlContent, page).parse();
		// 替换页面的总数，当前文章处于第几页，列表文章的总数标签
		htmlContent = new PageNumParser(htmlContent, page).parse();
		return htmlContent;
	}

	
	/**
	 * 搜索的分页查询
	 * 
	 * @param htmlContent
	 *            搜索模板内容
	 * @param articleList
	 *            文章实体列表
	 * @param page
	 *            分页
	 * @return
	 */
	public String parseSearchList() {
		// 当前列表标签中属性的集合-------------------
		Map<String, String> property = ListParser.listProperty(htmlContent, true);
		if (property == null) { // 没有找到分页标签标签
			return htmlContent;
		}
		String isPaging = property.get(ListParser.LIST_ISPAGING);
		if (isPaging != null && isPaging.equals("true")) {
			// 排序
			String order = property.get(ListParser.LIST_ORDER);
			// 取当前标签下的栏目ID
			// 从数据库取出文章列表数组
			List  listArticles =searchList;
			// 当数据库中该栏目下没有该文章时不取数据
			if(listArticles!=null){
				/**
				 * 判断文章列表的orderby属性
				 */
				if (StringUtil.isBlank(order)) {
					order = "desc";
				}
				// 替换列表标签
				htmlContent = new com.mingsoft.cms.parser.impl.ListParser(app,htmlContent, listArticles,  this.getWebsiteUrl(), property, true, fieldBiz, contentBiz).parse();
			}
		}
		return htmlContent;
	}
}