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


package net.mingsoft.cms.action.web;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.bean.CategoryBean;
import net.mingsoft.cms.bean.ContentBean;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.biz.IHistoryLogBiz;
import net.mingsoft.cms.constant.e.CategoryTypeEnum;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.cms.entity.HistoryLogEntity;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.biz.IModelBiz;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * 文章管理控制层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
@Tag(name="前端-内容模块接口")
@Controller("WebcmsContentAction")
@RequestMapping("/cms/content")
public class ContentAction extends net.mingsoft.cms.action.BaseAction{


	/**
	 * 注入文章业务层
	 */
	@Autowired
	private IContentBiz contentBiz;

	@Autowired
	private ICategoryBiz categoryBiz;

	@Autowired
	private IModelBiz modelBiz;

	@Autowired
	private IHistoryLogBiz historyLogBiz;

	/**
	 * 查询文章列表接口
	 * @return
	 */
	@Operation(summary = "查询文章列表接口")
	@Parameters({
			@Parameter(name = "typeid", description = "所属栏目", required =true, in= ParameterIn.QUERY),
			@Parameter(name = "pageNo", description = "页码", required =false, in= ParameterIn.QUERY),
			@Parameter(name = "size", description = "一页显示数量", required =false, in= ParameterIn.QUERY),
			@Parameter(name = "orderby", description = "排序", required =false, in= ParameterIn.QUERY),
    })
	@GetMapping(value = "/list")
	@ResponseBody
	public ResultData list(HttpServletResponse response, HttpServletRequest request) {
		//会将请求参数全部转换map
		Map map = BasicUtil.assemblyRequestMap();
		String typeid = (String) map.get("typeid");
		if (StrUtil.isBlank(typeid)){
			return ResultData.build().error(getResString("err.empty", this.getResString("content.category.id")));
		}
		ContentBean content = new ContentBean();
		content.setCategoryType(CategoryTypeEnum.LIST.toString());
		content.setContentDisplay("0");
		content.setCategoryId(typeid);
		List<CategoryBean> articleList = contentBiz.queryIdsByCategoryIdForParser(content);
		PageBean page = new PageBean();
		List filedStr = new ArrayList<>();
		page.setPageNo(BasicUtil.getInt("pageNo",1));
		page.setSize(BasicUtil.getInt("size",10));
		map.put("ispaging","true");
		map.putIfAbsent("size",page.getSize());
		if (BasicUtil.getWebsiteApp() != null) {
			map.put("appid", BasicUtil.getWebsiteApp().getId());
		}
		map.put(ParserUtil.PAGE, page);
		if (typeid != null) {
			CategoryEntity column = categoryBiz.getById(typeid);
			// 获取表单类型的id
			if (column != null && ObjectUtil.isNotNull(column.getMdiyModelId())) {
				ModelEntity	contentModel = (ModelEntity) modelBiz.getById(column.getMdiyModelId());
				if (contentModel != null) {
					// 保存自定义模型的数据
					Map<String, String> fieldMap = contentModel.getFieldMap();
					for (String s : fieldMap.keySet()) {
						filedStr.add(fieldMap.get(s));
					}
					// 设置自定义模型表名，方便解析的时候关联表查询
					map.put(ParserUtil.TABLE_NAME, contentModel.getModelTableName());

				}
			}

			// 设置栏目，方便解析的时候关联表查询
			map.put(ParserUtil.COLUMN, column);
		}
		//实际上list是需要参数，例如分页、栏目分类、属性等待，具体看标签arclist对应的参数
		List contentList = contentBiz.list(map);
		return ResultData.build().success(new EUListBean(contentList,articleList.size()));
	}


	/**
	 * 获取文章列表接口
	 * @param content 文章
	 * @return
	 */
	@Operation(summary =  "获取文章列表接口")
    @Parameter(name = "id", description = "编号", required = true, in = ParameterIn.QUERY)
	@GetMapping("/get")
	@ResponseBody
	public ResultData get(@ModelAttribute @Parameter(hidden = true) ContentEntity content){
		if(content.getId()==null) {
			return ResultData.build().error(getResString("err.empty",this.getResString("id")));
		}
		content.setSqlWhere("");
		ContentEntity _content = contentBiz.getById(content.getId());
		if(_content==null) {
			return ResultData.build().error(getResString("err.error",this.getResString("id")));
		}
		// 获取栏目数据
		CategoryEntity categoryEntity = categoryBiz.getById(_content.getCategoryId());
		ModelEntity modelEntity = new ModelEntity();
		if (categoryEntity != null) {
			modelEntity = modelBiz.getById(categoryEntity.getMdiyModelId());
		}
		// 组织map查询数据
		Map<String, Object> map = new HashMap<>();
		map.put("dataid", content.getId());
		// 如果没有自定义模型, 不设置自定义模型
		if (modelEntity != null && StringUtils.isNotBlank(modelEntity.getModelTableName())) {
			map.put("tableName", modelEntity.getModelTableName());
		}
		Map contentMap = contentBiz.get(map);
		return ResultData.build().success(contentMap);
	}

	/**
	 * 查看文章点击数
	 * @param contentId 文章编号
	 * @return
	 */
	@Operation(summary =  "查看文章点击数")
	@Parameter(name = "contentId", description = "文章编号", required = true, in = ParameterIn.PATH)
	// 由于适配增加了对clob序列化处理，此处需要指定响应头
	@GetMapping(value = "/{contentId}/hit", produces = "application/javascript")
	@ResponseBody
	public String hit(@PathVariable @Parameter(hidden = true) String contentId) {
		if(StringUtils.isEmpty(contentId)){
			return "document.write(0)";
		}
	 	//获取ip
		String ip = BasicUtil.getIp();
		//获取端口（移动/web..）
		boolean isMobileDevice = BasicUtil.isMobileDevice();

		ContentEntity content = contentBiz.getById(contentId);
		if(content == null){
			return "document.write(0)";
		}
	 	//浏览数+1
		if(ObjectUtil.isNotEmpty(content.getContentHit())){
			content.setContentHit(content.getContentHit()+1);
		}else {
			content.setContentHit(1);
		}
		contentBiz.updateById(content);

		// cms_history 增加相应记录
		HistoryLogEntity entity = new HistoryLogEntity();
		entity.setHlIsMobile(isMobileDevice);
		entity.setHlIp(ip);
		entity.setContentId(content.getId());
		entity.setCreateDate(new Date());
		historyLogBiz.save(entity);

		return "document.write(" + content.getContentHit() + ")";
	}

}
