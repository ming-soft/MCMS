package net.mingsoft.cms.util;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.PageUtil;
import freemarker.cache.FileTemplateLoader;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;
import net.mingsoft.base.constant.Const;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.bean.ContentBean;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.biz.IModelBiz;
import net.mingsoft.mdiy.biz.impl.ModelBizImpl;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.parser.TagParser;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CmsParserUtil extends ParserUtil {

	/**
	 * 封面
	 */
	private static int COLUMN_TYPE_COVER = 2;

	/**
	 * 指定模板，指定路径进行生成静态页面，会自定识别pc与移动端
	 *
	 * @param templatePath
	 *            模板路径
	 * @param targetPath
	 *            生成后的路径，默认生成的html文件，所以不能带.html后缀，
	 * @throws IOException
	 */
	public static void generate(String templatePath, String targetPath) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(IS_DO, false);
		CategoryEntity column = new CategoryEntity();
		//内容管理栏目编码
		map.put(COLUMN, column);
		String content = CmsParserUtil.generate(templatePath, map, false);
		FileUtil.writeString(content, ParserUtil.buildHtmlPath(targetPath), Const.UTF8);

		// 生成移动页面
		if (ParserUtil.hasMobileFile(templatePath)) {
			// 手机端m
			map.put(ParserUtil.MOBILE, BasicUtil.getApp().getAppMobileStyle());
			content = CmsParserUtil.generate(templatePath, map, true);
			FileUtil.writeString(content, ParserUtil.buildMobileHtmlPath(targetPath), Const.UTF8);
		}
	}

	/**
	 * 生成静态列表页
	 * @param column
	 * @param articleIdTotal
	 * @throws TemplateNotFoundException
	 * @throws MalformedTemplateNameException
	 * @throws ParseException
	 * @throws IOException
	 */
	public static void generateList(CategoryEntity column, int articleIdTotal)
			throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException {
		// 只初始化一次cfg
		if (ftl == null) {
			ftl = new FileTemplateLoader(new File(ParserUtil.buildTempletPath()));
			cfg.setTemplateLoader(ftl);
		}
		// 移动端模板
		try{
			Template mobileTemplate = cfg.getTemplate(
					BasicUtil.getApp().getAppMobileStyle() + File.separator + column.getCategoryListUrl(), Const.UTF8);
			// pc端模板
			Template template = cfg.getTemplate(File.separator + column.getCategoryListUrl(), Const.UTF8);
			// 文章的栏目模型编号
			String columnContentModelId = column.getMdiyModelId();
			StringWriter writer = new StringWriter();
			try {
				// 为了分页添加column,判断栏目是否为父栏目
				template.process(null, writer);
				String content = writer.toString();
				//获取列表页显示的文章数量
				int pageSize = TagParser.getPageSize(content);
				//获取总数
				int totalPageSize = PageUtil.totalPage(articleIdTotal, pageSize);

				String columnListPath;
				String mobilePath;
				ModelEntity contentModel = null;
				// 判断当前栏目是否有自定义模型
				if (StringUtils.isNotBlank(columnContentModelId)) {
					// 通过栏目模型编号获取自定义模型实体
					contentModel = (ModelEntity) SpringUtil.getBean(ModelBizImpl.class).getEntity(Integer.parseInt(columnContentModelId));
				}
				int pageNo = 1;
				PageBean page = new PageBean();
				page.setSize(pageSize);
				//全局参数设置
				Map<String, Object> parserParams = new HashMap<String, Object>();
				parserParams.put(COLUMN, column);
				page.setTotal(totalPageSize);
				parserParams.put(IS_DO, false);
				parserParams.put(HTML, HTML);
				parserParams.put(APP_ID, BasicUtil.getAppId());
				if (contentModel!=null) {
					// 将自定义模型编号设置为key值
					parserParams.put(TABLE_NAME, contentModel.getModelTableName());
				}
				//如果单站点，就废弃站点地址
				if(ParserUtil.IS_SINGLE) {
					parserParams.put(ParserUtil.URL, BasicUtil.getUrl());
				}

				//文章列表页没有写文章列表标签，总数为0
				if (totalPageSize <= 0) {
					// 数据库中第一页是从开始0*size
					// 首页路径index.html
					mobilePath = ParserUtil.buildMobileHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.INDEX);
					columnListPath = ParserUtil.buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.INDEX);
					// 设置分页的起始位置
					page.setPageNo(pageNo);
					parserParams.put(ParserUtil.PAGE, page);
					TagParser tag = new TagParser(content,parserParams);
					FileUtil.writeString(tag.rendering(), columnListPath, Const.UTF8);
					// 判断是手机端生成还是pc端,防止重复生成
					if (ParserUtil.hasMobileFile(column.getCategoryListUrl())) {
						writer = new StringWriter();
						mobileTemplate.process(null, writer);
						tag = new TagParser(writer.toString(), parserParams);
						// 将tag.getContent()写入路径
						FileUtil.writeString(tag.rendering(), mobilePath, Const.UTF8);
					}
					writer = new StringWriter();
				} else {
					// 遍历分页
					for (int i = 0; i < totalPageSize; i++) {
						if (i == 0) {
							// 数据库中第一页是从开始0*size
							// 首页路径index.html
							mobilePath = ParserUtil
									.buildMobileHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.INDEX);
							columnListPath = ParserUtil
									.buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.INDEX);
						} else {
							// 其他路径list-2.html
							mobilePath = ParserUtil.buildMobileHtmlPath(
									column.getCategoryPath() + File.separator + ParserUtil.PAGE_LIST + pageNo);
							columnListPath = ParserUtil
									.buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.PAGE_LIST + pageNo);
						}
						// 设置分页的起始位置
						page.setPageNo(pageNo);
						parserParams.put(ParserUtil.PAGE, page);
						TagParser tag = new TagParser(content,parserParams);
						FileUtil.writeString(tag.rendering(), columnListPath, Const.UTF8);
						// 判断是手机端生成还是pc端,防止重复生成
						if (ParserUtil.hasMobileFile(column.getCategoryListUrl())) {
							writer = new StringWriter();
							mobileTemplate.process(null, writer);
							tag = new TagParser(writer.toString(),parserParams);
							// 将tag.getContent()写入路径
							FileUtil.writeString(tag.rendering(), mobilePath, Const.UTF8);
						}
						writer = new StringWriter();
						pageNo++;
					}
				}
			} catch (TemplateException e) {
				e.printStackTrace();
			}
		}catch (TemplateNotFoundException e){
			e.printStackTrace();
		}
	}

	/**
	 * 生成内容
	 *
	 * @param articleIdList
	 *            文章集合
	 * @return
	 * @throws IOException
	 * @throws ParseException
	 * @throws MalformedTemplateNameException
	 * @throws TemplateNotFoundException
	 */
	public static void generateBasic(List<ContentBean>  articleIdList)
			throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException {

		Map<Object, Object> contentModelMap = new HashMap<Object, Object>();
		ModelEntity contentModel = null;
		String writePath = null;
		// 记录已经生成了文章编号
		List<Integer> generateIds = new ArrayList<>();
		// 生成文档
		for (int artId = 0; artId < articleIdList.size();) {
			//设置分页类
			PageBean page = new PageBean();
			// 文章编号
			int articleId = articleIdList.get(artId).getArticleId();
			// 文章的栏目路径
			String articleColumnPath = articleIdList.get(artId).getCategoryPath();
			// 文章的模板路径
			String columnUrl = articleIdList.get(artId).getCategoryUrl();
			// 文章的栏目模型编号
			String columnContentModelId = "";
			if(StringUtils.isNotBlank(articleIdList.get(artId).getMdiyModelId()) && Integer.parseInt(articleIdList.get(artId).getMdiyModelId())>0){
				columnContentModelId = articleIdList.get(artId).getMdiyModelId();
			}
			// 文章是否已经生成了，生成了就跳过
			if (generateIds.contains(articleId)) {
				artId++;
				continue;
			}

			// 判断文件是否存在，若不存在弹出返回信息
			if (!FileUtil.exist(ParserUtil.buildTempletPath(columnUrl))||StringUtils.isBlank(articleIdList.get(artId).getCategoryId())||articleIdList.get(artId).getCategoryType()==null) {
				artId++;
				continue;
			}
			// 将
			generateIds.add(articleId);
			// 组合文章路径如:html/站点id/栏目id/文章id.html
			writePath = ParserUtil.buildHtmlPath(articleColumnPath + File.separator + articleId);
			//如果是封面就生成index.html
			if(Integer.parseInt(articleIdList.get(artId).getCategoryType()) == COLUMN_TYPE_COVER) {
				writePath = ParserUtil.buildHtmlPath(articleColumnPath + File.separator + ParserUtil.INDEX);
			}
			Map<String, Object> parserParams = new HashMap<String, Object>();
			parserParams.put(ParserUtil.COLUMN, articleIdList.get(artId));
			// 判断当前栏目是否有自定义模型
			if (StringUtils.isNotBlank(columnContentModelId)) {
				// 通过当前栏目的模型编号获取，自定义模型表名
				if (contentModelMap.containsKey(columnContentModelId)) {
					parserParams.put(TABLE_NAME, contentModel.getModelTableName());
				} else {
					// 通过栏目模型编号获取自定义模型实体
					contentModel = (ModelEntity) SpringUtil.getBean(IModelBiz.class)
							.getEntity(Integer.parseInt(columnContentModelId));
					// 将自定义模型编号设置为key值
					contentModelMap.put(columnContentModelId, contentModel.getModelTableName());
					parserParams.put(TABLE_NAME, contentModel.getModelTableName());
				}
			}

			parserParams.put(ID, articleId);
			// 第一篇文章没有上一篇
			if (artId > 0) {
				ContentBean preCaBean = articleIdList.get(artId - 1);
				//判断当前文档是否与上一页文章在同一栏目下，并且不能使用父栏目字符串，因为父栏目中没有所属栏目编号
				if( articleColumnPath.contains(preCaBean.getCategoryId()+"")){
					page.setPreId(preCaBean.getArticleId());
				}
			}
			// 最后一篇文章没有下一篇
			if (artId + 1 < articleIdList.size()) {
				ContentBean nextCaBean = articleIdList.get(artId + 1);
				//判断当前文档是否与下一页文章在同一栏目下并且不能使用父栏目字符串，因为父栏目中没有所属栏目编号
				if(articleColumnPath.contains(nextCaBean.getCategoryId()+"")){
					page.setNextId(nextCaBean.getArticleId());
				}
			}

			parserParams.put(IS_DO, false);
			parserParams.put(ParserUtil.PAGE, page);
			String content = CmsParserUtil.generate(articleIdList.get(artId).getCategoryUrl(), parserParams, false);
			FileUtil.writeString(content, writePath, Const.UTF8);
			// 手机端
			if (ParserUtil.hasMobileFile(columnUrl)) {
				writePath = ParserUtil.buildMobileHtmlPath(articleColumnPath + File.separator + articleId);
				//如果是封面就生成index.html
				if(Integer.parseInt(articleIdList.get(artId).getCategoryType())  == COLUMN_TYPE_COVER) {
					writePath = ParserUtil.buildMobileHtmlPath(articleColumnPath + File.separator + ParserUtil.INDEX);
				}
				// 判断文件是否存在，若不存在弹出返回信息
				if (!FileUtil.exist(ParserUtil.buildTempletPath(MOBILE + File.separator + columnUrl))) {
					artId++;
					continue;
				}
				parserParams.put(MOBILE, BasicUtil.getApp().getAppMobileStyle());
				content = CmsParserUtil.generate(articleIdList.get(artId).getCategoryUrl(), parserParams, true);
				FileUtil.writeString(content, writePath, Const.UTF8);
			}
			artId++;
		}
	}
}
