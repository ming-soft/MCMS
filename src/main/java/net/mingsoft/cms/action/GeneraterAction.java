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

package net.mingsoft.cms.action;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import net.mingsoft.basic.action.BaseAction;
import net.mingsoft.basic.biz.IColumnBiz;
import net.mingsoft.basic.biz.IModelBiz;
import net.mingsoft.basic.entity.AppEntity;
import net.mingsoft.basic.entity.CategoryEntity;
import net.mingsoft.basic.entity.ColumnEntity;
import net.mingsoft.cms.bean.ColumnArticleIdBean;
import net.mingsoft.cms.biz.IArticleBiz;
import net.mingsoft.cms.constant.ModelCode;
import net.mingsoft.cms.util.CmsParserUtil;
import net.mingsoft.mdiy.biz.IContentModelBiz;
import net.mingsoft.mdiy.biz.IContentModelFieldBiz;

import cn.hutool.core.io.FileUtil;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.mdiy.util.ParserUtil;

/**
 * 
 * @ClassName: GeneraterAction
 * @Description:TODO 生成器
 * @author: 铭飞开发团队
 * @date: 2018年1月31日 下午2:52:07
 * 
 * @Copyright: 2018 www.mingsoft.net Inc. All rights reserved.
 */
@Controller("cmsGenerater")
@RequestMapping("/${ms.manager.path}/cms/generate")
@Scope("request")
public class GeneraterAction extends BaseAction {

	/**
	 * 文章管理业务层
	 */
	@Autowired
	private IArticleBiz articleBiz;

	/**
	 * 栏目管理业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;

	/**
	 * 模块管理业务层
	 */
	@Autowired
	private IModelBiz modelBiz;

	@Value("${ms.manager.path}")
	private String managerPath;

	/**
	 * 新增字段业务层
	 */
	@Autowired
	protected IContentModelFieldBiz fieldBiz;

	/**
	 * 自定义模型业务层
	 */
	@Autowired
	protected IContentModelBiz contentBiz;

	/**
	 * 更新主页
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest request, ModelMap model) {
		// 该站点ID有session提供
		int websiteId = BasicUtil.getAppId();
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		// 获取所有的内容管理栏目
		List<ColumnEntity> list = columnBiz.queryAll(websiteId, modelId);
		model.addAttribute("list", JSONArray.toJSONString(list));
		model.addAttribute("now", new Date());
		return "/cms/generate/index";
	}

	/**
	 * 生成主页
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("/generateIndex")
	@RequiresPermissions("cms:generate:index")
	@ResponseBody
	public void generateIndex(HttpServletRequest request, HttpServletResponse response) {
		// 模版文件名称
		String tmpFileName = request.getParameter("url");
		// 生成后的文件名称
		String generateFileName = request.getParameter("position");
		
		// 获取文件所在路径 首先判断用户输入的模版文件是否存在
		if (!FileUtil.exist(ParserUtil.buildTempletPath())) {
			this.outJson(response, false, getResString("templet.file"));
		} else {
			try {
				CmsParserUtil.generate(tmpFileName, generateFileName);
				this.outJson(response, true);
			} catch (IOException e) {
				e.printStackTrace();
				this.outJson(response, false);
			}
		}
	}
	


	/**
	 * 生成列表的静态页面
	 * 
	 * @param request
	 * @param response
	 * @param columnId
	 */
	@RequestMapping("/{columnId}/genernateColumn")
	@RequiresPermissions("cms:generate:column")
	@ResponseBody
	public void genernateColumn(HttpServletRequest request, HttpServletResponse response, @PathVariable int columnId) {
		// 获取站点id
		AppEntity app = BasicUtil.getApp();
		List<ColumnEntity> columns = new ArrayList<ColumnEntity>();
		// 如果栏目id小于0则更新所有的栏目，否则只更新选中的栏目
		int modelId = BasicUtil.getModelCodeId(ModelCode.CMS_COLUMN); // 查询当前模块编号
		if (columnId > 0) {
			List<CategoryEntity> categorys = columnBiz.queryChildrenCategory(columnId, app.getAppId(), modelId);
			for (CategoryEntity c : categorys) {
				columns.add((ColumnEntity) columnBiz.getEntity(c.getCategoryId()));
			}
		} else {
			// 获取所有的内容管理栏目
			columns = columnBiz.queryAll(app.getAppId(), modelId);
		}
		List<ColumnArticleIdBean> articleIdList = null;
		try {
			// 1、设置模板文件夹路径
			// 获取栏目列表模版
			for (ColumnEntity column : columns) {
				// 判断模板文件是否存在
				if (!FileUtil.exist(ParserUtil.buildTempletPath(column.getColumnUrl()))) {
					continue;
				}
				articleIdList = articleBiz.queryIdsByCategoryIdForParser(column.getCategoryId(), null, null);
				// 判断列表类型
				switch (column.getColumnType()) {
				case ColumnEntity.COLUMN_TYPE_LIST: // 列表
					CmsParserUtil.generateList(column, articleIdList.size());
					break;
				case ColumnEntity.COLUMN_TYPE_COVER:// 单页
					CmsParserUtil.generateBasic(articleIdList);
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			this.outJson(response, false);
		}
		this.outJson(response, true);
	}

	/**
	 * 根据栏目id更新所有的文章
	 * 
	 * @param request
	 * @param response
	 * @param columnId
	 */
	@RequestMapping("/{columnId}/generateArticle")
	@RequiresPermissions("cms:generate:article")
	@ResponseBody
	public void generateArticle(HttpServletRequest request, HttpServletResponse response, @PathVariable int columnId) {
		String dateTime = request.getParameter("dateTime");
		// 网站风格物理路径
		List<ColumnArticleIdBean> articleIdList = null;
		try {
			// 查出所有文章（根据选择栏目）包括子栏目
			articleIdList = articleBiz.queryIdsByCategoryIdForParser(columnId, dateTime, null);
			// 有符合条件的新闻就更新
			if (articleIdList.size() > 0) {
				CmsParserUtil.generateBasic(articleIdList);
			}
			this.outJson(response, true);
		} catch (IOException e) {
			e.printStackTrace();
			this.outJson(response, false);
		}
	}
	


	/**
	 * 用户预览主页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/{position}/viewIndex")
	public String viewIndex(HttpServletRequest request, @PathVariable String position, HttpServletResponse response) {
		AppEntity app = BasicUtil.getApp();
		// 组织主页预览地址
		String indexPosition = app.getAppHostUrl() + File.separator + ParserUtil.HTML + File.separator + app.getAppId()
				+ File.separator + position + ParserUtil.HTML_SUFFIX;
		return "redirect:" + indexPosition;
	}
}