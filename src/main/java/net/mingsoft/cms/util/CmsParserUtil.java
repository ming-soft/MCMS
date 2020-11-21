package net.mingsoft.cms.util;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.PageUtil;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.TemplateNotFoundException;
import net.mingsoft.base.constant.Const;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.bean.CategoryBean;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.mdiy.bean.AttributeBean;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.biz.IModelBiz;
import net.mingsoft.mdiy.biz.impl.ModelBizImpl;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;

/**
 * 文章解析工具类
 */
public class CmsParserUtil extends ParserUtil {

	/**
	 * 封面
	 */
	private static int COLUMN_TYPE_COVER = 2;

	private final static String FIELD="field";

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
		String content = CmsParserUtil.generate(templatePath, map);
		FileUtil.writeString(content, ParserUtil.buildHtmlPath(targetPath), Const.UTF8);
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
		try{
			// 文章的栏目模型编号
			Integer columnContentModelId = column.getMdiyModelId();
			PageBean page = new PageBean();
			page.setSize(10);
			//获取分页数量

			//获取列表页显示的文章数量
			//获取总数

			String columnListPath;
			ModelEntity contentModel = null;
			// 判断当前栏目是否有自定义模型
			if (columnContentModelId != null) {
				// 通过栏目模型编号获取自定义模型实体
				contentModel = (ModelEntity) SpringUtil.getBean(ModelBizImpl.class).getEntity(columnContentModelId);
			}
			int pageNo = 1;

			//全局参数设置
			Map<String, Object> parserParams = new HashMap<String, Object>();
			parserParams.put(COLUMN, column);
			//标签中使用field获取当前栏目
			parserParams.put(FIELD, column);
			parserParams.put(IS_DO, false);
			parserParams.put(HTML, HTML);
			if(BasicUtil.getWebsiteApp() != null){
				parserParams.put(APP_ID, BasicUtil.getWebsiteApp().getAppId());
			}
			if (contentModel!=null) {
				// 将自定义模型编号设置为key值
				parserParams.put(TABLE_NAME, contentModel.getModelTableName());
			}
			//如果单站点，就废弃站点地址
			if(ParserUtil.IS_SINGLE) {
				parserParams.put(ParserUtil.URL, BasicUtil.getUrl());
			}
			parserParams.put(ParserUtil.PAGE, page);
			AttributeBean attributeBean = new AttributeBean();
			ParserUtil.read(File.separator + column.getCategoryListUrl(),parserParams, page,attributeBean);
			int totalPageSize = PageUtil.totalPage(articleIdTotal, page.getSize());
			page.setTotal(totalPageSize);
			//文章列表页没有写文章列表标签，总数为0
			if (totalPageSize <= 0) {
				// 数据库中第一页是从开始0*size
				columnListPath = ParserUtil.buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.INDEX);
				// 设置分页的起始位置
				page.setPageNo(pageNo);
				String read = ParserUtil.read(File.separator + column.getCategoryListUrl(), parserParams);
				FileUtil.writeString(read, columnListPath, Const.UTF8);

			} else {
				// 遍历分页
				for (int i = 0; i < totalPageSize; i++) {
					if (i == 0) {
						// 数据库中第一页是从开始0*size
						// 首页路径index.html
						columnListPath = ParserUtil
								.buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.INDEX);
					} else {
						// 其他路径list-2.html
						columnListPath = ParserUtil
								.buildHtmlPath(column.getCategoryPath() + File.separator + ParserUtil.PAGE_LIST + pageNo);
					}
					// 设置分页的起始位置
					page.setPageNo(pageNo);
					String read = ParserUtil.read(File.separator + column.getCategoryListUrl(), parserParams);
					FileUtil.writeString(read, columnListPath, Const.UTF8);
					pageNo++;
				}
			}
		}catch (Exception e){
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
	public static void generateBasic(List<CategoryBean>  articleIdList) {

		Map<Object, Object> contentModelMap = new HashMap<Object, Object>();
		ModelEntity contentModel = null;
		// 记录已经生成了文章编号
		List<String> generateIds = new ArrayList<>();
		ExecutorService pool= SpringUtil.getBean(ExecutorService.class);
		// 生成文章
		for (int artId = 0; artId < articleIdList.size();) {
			String writePath = null;
			//设置分页类
			PageBean page = new PageBean();
			// 文章编号
			String articleId = articleIdList.get(artId).getArticleId();
			// 文章的栏目路径
			String articleColumnPath = articleIdList.get(artId).getCategoryPath();
			// 该文章相关分类
			String categoryParentId = articleIdList.get(artId).getId() ;
			if(StringUtils.isNotBlank(articleIdList.get(artId).getCategoryParentId())){
				categoryParentId += ','+articleIdList.get(artId).getCategoryParentId();
			}
			// 文章的模板路径
			String columnUrl = articleIdList.get(artId).getCategoryUrl();
			// 文章的栏目模型编号
			Integer columnContentModelId = null;
			if(articleIdList.get(artId).getMdiyModelId() != null && articleIdList.get(artId).getMdiyModelId() > 0){
				columnContentModelId = articleIdList.get(artId).getMdiyModelId();
			}
			// 文章是否已经生成了，生成了就跳过
			if (generateIds.contains(articleId)) {
				artId++;
				continue;
			}

			// 判断文件是否存在，若不存在弹出返回信息
			if (!FileUtil.exist(ParserUtil.buildTempletPath(columnUrl))||articleIdList.get(artId).getCategoryId()==null||articleIdList.get(artId).getCategoryType()==null) {
				artId++;
				continue;
			}
			// 将
			generateIds.add(articleId);
			//如果是封面就生成index.html
			if(Integer.parseInt(articleIdList.get(artId).getCategoryType()) == COLUMN_TYPE_COVER) {
				writePath = ParserUtil.buildHtmlPath(articleColumnPath + File.separator + ParserUtil.INDEX);
			}else {
                // 组合文章路径如:html/站点id/栏目id/文章id.html
                writePath = ParserUtil.buildHtmlPath(articleColumnPath + File.separator + articleId);
            }
			Map<String, Object> parserParams = new HashMap<String, Object>();
			parserParams.put(ParserUtil.COLUMN, articleIdList.get(artId));
			// 判断当前栏目是否有自定义模型
			if (columnContentModelId != null) {
				// 通过当前栏目的模型编号获取，自定义模型表名
				if (contentModelMap.containsKey(columnContentModelId)) {
					parserParams.put(TABLE_NAME, contentModel.getModelTableName());
				} else {
					// 通过栏目模型编号获取自定义模型实体
					contentModel = (ModelEntity) SpringUtil.getBean(IModelBiz.class)
							.getEntity(columnContentModelId);
					// 将自定义模型编号设置为key值
					contentModelMap.put(columnContentModelId, contentModel.getModelTableName());
					parserParams.put(TABLE_NAME, contentModel.getModelTableName());
				}
			}

			parserParams.put(ID, articleId);
			// 第一篇文章没有上一篇
			if (artId > 0) {
				CategoryBean preCaBean = articleIdList.get(artId - 1);
				//判断当前文档是否与上一页文章在同一栏目下，并且不能使用父栏目字符串，因为父栏目中没有所属栏目编号
//				if( categoryParentId.contains(preCaBean.getCategoryId()+"")){
					page.setPreId(preCaBean.getArticleId());
//				}
			}
			// 最后一篇文章没有下一篇
			if (artId + 1 < articleIdList.size()) {
				CategoryBean nextCaBean = articleIdList.get(artId + 1);
				//判断当前文档是否与下一页文章在同一栏目下并且不能使用父栏目字符串，因为父栏目中没有所属栏目编号
//				if(categoryParentId.contains(nextCaBean.getCategoryId()+"")){
					page.setNextId(nextCaBean.getArticleId());
//				}
			}

			parserParams.put(IS_DO, false);
			parserParams.put(ParserUtil.PAGE, page);
			String finalWritePath = writePath;
			HashMap<Object, Object> cloneMap = CollUtil.newHashMap();
			cloneMap.putAll(parserParams);
            HttpServletRequest request = SpringUtil.getRequest();
            pool.execute(() -> {
				String content = null;
				try {
					SpringUtil.setRequest(request);
					content = CmsParserUtil.generate(columnUrl, cloneMap);
					FileUtil.writeString(content, finalWritePath, Const.UTF8);
				} catch (IOException e) {
					e.printStackTrace();
				}
			});
			artId++;
		}
	}
}
