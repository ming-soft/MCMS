package net.mingsoft.cms.util;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.PageUtil;
import freemarker.cache.FileTemplateLoader;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;
import net.mingsoft.base.constant.Const;
import net.mingsoft.basic.entity.ColumnEntity;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.basic.util.StringUtil;
import net.mingsoft.cms.bean.ColumnArticleIdBean;
import net.mingsoft.cms.constant.e.ColumnTypeEnum;
import net.mingsoft.mdiy.biz.IContentModelBiz;
import net.mingsoft.mdiy.entity.ContentModelEntity;
import net.mingsoft.mdiy.parser.TagParser;
import net.mingsoft.mdiy.util.ParserUtil;

public class CmsParserUtil extends ParserUtil {

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
		boolean mobileStyle = false;
		//判断是否有移动端
		if (!StringUtil.isBlank(BasicUtil.getApp().getAppMobileStyle())) {
			mobileStyle = true;
		}
		String content = CmsParserUtil.generate(templatePath, map, mobileStyle);
		
		FileUtil.writeString(content, ParserUtil.buildHtmlPath(targetPath), Const.UTF8);
		// 生成移动页面
		if (mobileStyle) {
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
	public static void generateList(ColumnEntity column, int articleIdTotal)
			throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException {
		// 只初始化一次cfg
		if (ftl == null) {
			ftl = new FileTemplateLoader(new File(ParserUtil.buildTempletPath()));
			cfg.setTemplateLoader(ftl);
		}
		// 移动端模板
		Template mobileTemplate = cfg.getTemplate(
				BasicUtil.getApp().getAppMobileStyle() + File.separator + column.getColumnListUrl(), Const.UTF8);
		// pc端模板
		Template template = cfg.getTemplate(File.separator + column.getColumnListUrl(), Const.UTF8);

		
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
			
			int pageNo = 1;
			// 遍历分页
			for (int i = 0; i < totalPageSize; i++) {
				Map parserParams = new HashMap();
				parserParams.put(COLUMN, column);
				parserParams.put(TOTAL, totalPageSize);
				parserParams.put(RCOUNT, pageSize);
				parserParams.put(TYPE_ID, column.getCategoryId());
				parserParams.put(IS_DO, false);
				if (i == 0) {
					// 数据库中第一页是从开始0*size
					// 首页路径index.html
					mobilePath = ParserUtil
							.buildMobileHtmlPath(column.getColumnPath() + File.separator + ParserUtil.INDEX);
					columnListPath = ParserUtil
							.buildHtmlPath(column.getColumnPath() + File.separator + ParserUtil.INDEX);
				} else {
					// 其他路径list-2.html
					mobilePath = ParserUtil.buildMobileHtmlPath(
							column.getColumnPath() + File.separator + ParserUtil.PAGE_LIST + pageNo);
					columnListPath = ParserUtil
							.buildHtmlPath(column.getColumnPath() + File.separator + ParserUtil.PAGE_LIST + pageNo);
				}
				
				// 设置分页的起始位置
				parserParams.put(PAGE_NO, pageNo);
				TagParser tag = new TagParser(content,parserParams);

				FileUtil.writeString(tag.rendering(), columnListPath, Const.UTF8);

				// 判断是手机端生成还是pc端,防止重复生成
				if (ObjectUtil.isNotNull(BasicUtil.getApp().getAppMobileStyle())) {
					writer = new StringWriter();
					mobileTemplate.process(null, writer);
					tag = new TagParser(writer.toString(),parserParams);
					// 将tag.getContent()写入路径
					FileUtil.writeString(tag.rendering(), mobilePath, Const.UTF8);
				}
				
				writer = new StringWriter();
				pageNo++;
			}

		} catch (TemplateException e) {
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
	public static void generateBasic(List<ColumnArticleIdBean> articleIdList)
			throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException {

		Map<Object, Object> contentModelMap = new HashMap<Object, Object>();
		ContentModelEntity contentModel = null;
		String writePath = null;
		// 记录已经生成了文章编号
		List<Integer> generateIds = new ArrayList<>();
		// 生成文档
		for (int ai = 0; ai < articleIdList.size();) {
			// 文章编号
			int articleId = articleIdList.get(ai).getArticleId();
			// 文章的栏目路径
			String articleColumnPath = articleIdList.get(ai).getColumnPath();
			// 文章的模板路径
			String columnUrl = articleIdList.get(ai).getColumnUrl();
			// 文章的栏目模型编号
			int columnContentModelId = articleIdList.get(ai).getColumnContentModelId();
			// 文章是否已经生成了，生成了就跳过
			if (generateIds.contains(articleId)) {
				ai++;
				continue;
			}

			// 判断文件是否存在，若不存在弹出返回信息
			if (!FileUtil.exist(ParserUtil.buildTempletPath(columnUrl))) {
				ai++;
				continue;
			}
			// 将
			generateIds.add(articleId);
			// 组合文章路径如:html/站点id/栏目id/文章id.html
			writePath = ParserUtil.buildHtmlPath(articleColumnPath + File.separator + articleId);
			//如果是封面就生成index.html
			if(articleIdList.get(ai).getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {
				writePath = ParserUtil.buildHtmlPath(articleColumnPath + File.separator + ParserUtil.INDEX);
			}
			Map<String, Object> parserParams = new HashMap<String, Object>();
			// 判断当前栏目是否有自定义模型
			if (columnContentModelId > 0) {
				// 通过当前栏目的模型编号获取，自定义模型表名
				if (contentModelMap.containsKey(columnContentModelId)) {
					parserParams.put(TABLE_NAME, contentModel.getCmTableName());
				} else {
					// 通过栏目模型编号获取自定义模型实体
					contentModel = (ContentModelEntity) SpringUtil.getBean(IContentModelBiz.class)
							.getEntity(columnContentModelId);
					// 将自定义模型编号设置为key值
					contentModelMap.put(columnContentModelId, contentModel.getCmTableName());
					parserParams.put(TABLE_NAME, contentModel.getCmTableName());
				}
			}

			parserParams.put(ID, articleId);
			// 第一篇文章没有上一篇
			if (ai > 0) {
				parserParams.put(PRE_ID, articleIdList.get(ai - 1).getArticleId());
			}
			// 最后一篇文章没有下一篇
			if (ai + 1 < articleIdList.size()) {
				parserParams.put(NEXT_ID, articleIdList.get(ai + 1).getArticleId());
			}

			parserParams.put(IS_DO, false);
			
			String content = CmsParserUtil.generate(articleIdList.get(ai).getColumnUrl(), parserParams, false);
			FileUtil.writeString(content, writePath, Const.UTF8);

			// 手机端
			if (StringUtils.isNotEmpty(BasicUtil.getApp().getAppMobileStyle())) {
				writePath = ParserUtil.buildMobileHtmlPath(articleColumnPath + File.separator + articleId);
				//如果是封面就生成index.html
				if(articleIdList.get(ai).getColumnType() == ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()) {
					writePath = ParserUtil.buildMobileHtmlPath(articleColumnPath + File.separator + ParserUtil.INDEX);
				}
				// 判断文件是否存在，若不存在弹出返回信息
				if (!FileUtil.exist(ParserUtil.buildTempletPath(MOBILE + File.separator + columnUrl))) {
					ai++;
					continue;
				}
				parserParams.put(MOBILE, BasicUtil.getApp().getAppMobileStyle());
				content = CmsParserUtil.generate(articleIdList.get(ai).getColumnUrl(), parserParams, true);
				FileUtil.writeString(content, writePath, Const.UTF8);
			}
			ai++;
		}
	}
}
