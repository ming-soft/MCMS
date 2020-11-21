/**
The MIT License (MIT) * Copyright (c) 2019 铭飞科技

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

package net.mingsoft.cms.biz.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import net.mingsoft.basic.constant.Const;
import net.mingsoft.basic.holder.DataHolder;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.bean.CategoryBean;
import net.mingsoft.cms.bean.ContentBean;
import net.mingsoft.cms.dao.ICategoryDao;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.cms.util.CmsParserUtil;
import net.mingsoft.mdiy.bean.AttributeBean;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import net.mingsoft.base.biz.impl.BaseBizImpl;
import net.mingsoft.base.dao.IBaseDao;

import java.io.IOException;
import java.util.*;

import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.dao.IContentDao;

/**
 * 文章管理持久化层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
 @Service("cmscontentBizImpl")
public class ContentBizImpl  extends BaseBizImpl<IContentDao, ContentEntity> implements IContentBiz {

	/*
	 * log4j日志记录
	 */
	protected final Logger LOG = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private IContentDao contentDao;
	/**
	 * 栏目管理业务层
	 */
	@Autowired
	private ICategoryDao categoryDao;


	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return contentDao;
	}

	@Override
	public List<CategoryBean> queryIdsByCategoryIdForParser(ContentBean contentBean) {
		return this.contentDao.queryIdsByCategoryIdForParser(contentBean);
	}

	@Override
	public int getSearchCount(ModelEntity contentModel, List diyList, Map whereMap, int appId, String categoryIds) {
		if (contentModel!=null) {
			return contentDao.getSearchCount(contentModel.getModelTableName(),diyList,whereMap, appId,categoryIds);
		}
		return contentDao.getSearchCount(null,null,whereMap, appId,categoryIds);
	}

	/*
	 * 任务调度静态化任务
	 */
	public void staticizeTask(Integer appId, String tmpFileName, String generateFileName) {
		LOG.info("定时静态化任务", new Date());
		try {
			//将任务采集传过来的appId导入到线程变量中
			//当前线程使用appId时优先使用此数据
			DataHolder.set(ParserUtil.APP_ID, appId);
			//调用三种静态化
			genernateColumn();
			generaterIndex(tmpFileName, generateFileName);
			//生成文章日期默认为执行日期的上一天
			generateArticle(DateUtil.format(DateUtil.yesterday(), "yyyy-MM-dd"));
			LOG.info("静态化完成", new Date());
		} catch (IOException e) {
			LOG.info("静态化失败", new Date());
			e.printStackTrace();
		}
	}

	/*
	 * 生成文章逻辑
	 */
	private void generateArticle(String dateTime) throws IOException {
		// 网站风格物理路径
		List<CategoryBean> articleIdList = null;
		List<CategoryEntity> categoryList = null;
		AttributeBean attributeBean = new AttributeBean();
		ContentBean contentBean = new ContentBean();
		contentBean.setBeginTime(dateTime);
		Map<String, Object> map = new HashMap<>();
		if(BasicUtil.getWebsiteApp() != null){
			map.put(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getAppId());
		}
		PageBean page = new PageBean();
		map.put(ParserUtil.HTML, ParserUtil.HTML);
		map.put(ParserUtil.URL, BasicUtil.getUrl());
		map.put(ParserUtil.PAGE, page);

		CategoryEntity categoryEntity = new CategoryEntity();
		categoryList = categoryDao.query(categoryEntity);
		for(CategoryEntity category : categoryList){
			contentBean.setCategoryId(category.getId());
			// 分类是列表
			if(category.getCategoryType().equals("1")){
				// 判断模板文件是否存在
				if (!FileUtil.exist(ParserUtil.buildTempletPath(category.getCategoryListUrl())) || StringUtils.isEmpty(category.getCategoryListUrl())) {
					LOG.error("模板不存在：{}",category.getCategoryUrl());
					continue;
				}
				// 获取文章列表表属性
				ParserUtil.read(category.getCategoryListUrl(),map, page,attributeBean);
				contentBean.setFlag(attributeBean.getFlag());
				contentBean.setNoflag(attributeBean.getNoflag());
				contentBean.setOrder(attributeBean.getOrder());
				contentBean.setOrderBy(attributeBean.getOrderby());
			}
			articleIdList = queryIdsByCategoryIdForParser(contentBean);
			// 有符合条件的就更新
			if (articleIdList.size() > 0) {
				CmsParserUtil.generateBasic(articleIdList);
			}
		}
	}

	/*
	 * 生成栏目逻辑
	 */
	private void genernateColumn() throws IOException {
		List<CategoryEntity> columns = new ArrayList<>();
		// 获取所有的内容管理栏目
		CategoryEntity categoryEntity=new CategoryEntity();
		columns = categoryDao.query(categoryEntity);
		List<CategoryBean> articleIdList = null;
		// 1、设置模板文件夹路径
		// 获取栏目列表模版
		for (CategoryEntity column : columns) {
			ContentBean contentBean = new ContentBean();
			contentBean.setCategoryId(column.getId());
			// 分类是列表
			if(column.getCategoryType().equals("1")) {
				// 判断模板文件是否存在
				if (!FileUtil.exist(ParserUtil.buildTempletPath(column.getCategoryListUrl()))) {
					LOG.error("模板不存在：{}", column.getCategoryUrl());
					continue;
				}
				//获取模板中列表标签中的条件
				Map<String, Object> map = new HashMap<>();
				if(BasicUtil.getWebsiteApp() != null){
					map.put(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getAppId());
				}
				PageBean page = new PageBean();
				map.put(ParserUtil.HTML, ParserUtil.HTML);
				map.put(ParserUtil.URL, BasicUtil.getUrl());
				map.put(ParserUtil.PAGE, page);
				AttributeBean attributeBean = new AttributeBean();
				// 获取文章列表模板标签属性
				ParserUtil.read(column.getCategoryListUrl(), map, page, attributeBean);
				contentBean.setFlag(attributeBean.getFlag());
				contentBean.setNoflag(attributeBean.getNoflag());
				contentBean.setOrder(attributeBean.getOrder());
				contentBean.setOrderBy(attributeBean.getOrderby());
			}
			articleIdList = contentDao.queryIdsByCategoryIdForParser(contentBean);
			// 判断列表类型
			switch (column.getCategoryType()) {
				//TODO 暂时先用字符串代替
				case "1": // 列表
					CmsParserUtil.generateList(column, articleIdList.size());
					break;
				case "2":// 单页
					if(articleIdList.size()==0){
						CategoryBean columnArticleIdBean=new CategoryBean();
						CopyOptions copyOptions=CopyOptions.create();
						copyOptions.setIgnoreError(true);
						BeanUtil.copyProperties(column,columnArticleIdBean,copyOptions);
						articleIdList.add(columnArticleIdBean);
					}
					CmsParserUtil.generateBasic(articleIdList);
					break;
			}
		}
	}

	/*
	 * 生成主页逻辑
	 */
	private void generaterIndex(String templatePath, String targetPath) throws IOException {
		if (!FileUtil.exist(ParserUtil.buildTempletPath())) {
			LOG.info("模板文件不存在");
			return;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(ParserUtil.IS_DO, false);
		CategoryEntity column = new CategoryEntity();
		//内容管理栏目编码
		map.put(ParserUtil.COLUMN, column);
		//如果单站点，就废弃站点地址
		if (ParserUtil.IS_SINGLE) {
			map.put(ParserUtil.URL, BasicUtil.getUrl());
		}
		//设置生成的路径
		map.put(ParserUtil.HTML, ParserUtil.HTML);
		//设置站点编号
		if(BasicUtil.getWebsiteApp() !=null){
			map.put(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getAppId());
		}
		String read = ParserUtil.read(templatePath, map);
		FileUtil.writeString(read, ParserUtil.buildHtmlPath(targetPath), net.mingsoft.base.constant.Const.UTF8);
	}

}