/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
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

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import freemarker.template.TemplateException;
import net.mingsoft.base.biz.SqlQueryWrapper;
import net.mingsoft.base.biz.impl.BaseBizImpl;
import net.mingsoft.base.dao.IBaseDao;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.cms.bean.CategoryBean;
import net.mingsoft.cms.bean.ContentBean;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.dao.IContentDao;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.mdiy.biz.ITagBiz;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.entity.TagEntity;
import net.mingsoft.mdiy.util.ParserUtil;
import net.sf.jsqlparser.JSQLParserException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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


	@Autowired
	private ITagBiz tagBiz;


	@Override
	protected IBaseDao getDao() {
		
		return contentDao;
	}


	@Override
	public List<CategoryBean> queryIdsByCategoryIdForParser(ContentBean contentBean) {
		return this.contentDao.queryIdsByCategoryIdForParser(contentBean);
	}

	@Override
	public List<ContentBean> queryContent(ContentBean contentBean) {
		return this.contentDao.queryContent(contentBean);

	}

	@Override
	public int getSearchCount(ModelEntity contentModel, Map<String,Object> diyModel, Map whereMap, String categoryIds) {
		if (contentModel!=null) {
			return contentDao.getSearchCount(contentModel.getModelTableName(),diyModel,whereMap, categoryIds);
		}
		return contentDao.getSearchCount(null,null,whereMap, categoryIds);
	}

	@Override
	public List<CategoryBean> queryIdsByCategoryIdForParserAndNotCover(ContentBean contentBean) {
		return this.contentDao.queryIdsByCategoryIdForParserAndNotCover(contentBean);
	}

	@Override
	public EUListBean list(Map<String,Object> map ) {
		//通过tagSqlBiz获取arclist对应的sql
		QueryWrapper<TagEntity> tagWrapper = new QueryWrapper<>();
		tagWrapper.eq("tag_name", "arclist");
		TagEntity tagEntity = tagBiz.getOne(tagWrapper,false);
		String sqlFtl = tagEntity.getTagSql();
		List<Map<String, Object>> contentEntities = null;
		int total = 0;
		try {
			String sql = ParserUtil.rendering(map,sqlFtl);
			Map<String, Object> sqlPrepareParams = ParserUtil.flatten(map);
			//执行原生的sql
			contentEntities = tagBiz.queryForListByNamedJdbc(sql,sqlPrepareParams);

			// 获取到总数
			SqlQueryWrapper sqlQueryWrapper = new SqlQueryWrapper();
			String countSql = sqlQueryWrapper.getCountSql(sql);
			List<Map<String, Object>> list = queryForListByNamedJdbc(countSql, sqlPrepareParams);

			Object countValue = list.get(0).values().iterator().next();
			total = ((Number)countValue).intValue();
		} catch (IOException | TemplateException | JSQLParserException e) {
			e.printStackTrace();
		}
		return new EUListBean(contentEntities, total);
	}

	@Override
	public Map<String,Object> get(Map<String,Object> map) {
		//通过tagSqlBiz获取data对应的sql
		LambdaQueryWrapper<TagEntity> wrapper = new LambdaQueryWrapper<>();
		wrapper.eq(TagEntity::getTagName, "data");
		TagEntity tagEntity = tagBiz.getOne(wrapper,false);
		if (tagEntity == null) {
			return null;
		}
		String sqlFtl = tagEntity.getTagSql();
		Map<String,Object> content = null;
		try {
			// data没有取嵌套map参数的场景 不做flatten操作
			String sql = ParserUtil.rendering(map,sqlFtl);
			//执行原生的sql
			List<Map<String, Object>> contentEntities = tagBiz.queryForListByNamedJdbc(sql,map);
			if (CollUtil.isEmpty(contentEntities)) {
				return null;
			}
			// 默认取出第一个返回数据
			content = contentEntities.get(0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return content;
	}


}
