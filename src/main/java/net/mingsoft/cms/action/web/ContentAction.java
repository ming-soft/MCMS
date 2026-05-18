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
import net.mingsoft.base.constant.Const;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.biz.IHistoryLogBiz;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.cms.entity.ContentEntity;
import net.mingsoft.cms.entity.HistoryLogEntity;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.biz.IModelBiz;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.util.ConfigUtil;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.UnsupportedEncodingException;
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
	 * 自定义模型查询必须指定栏目，仅在typeid参数存在时生效
	 * @return 文章列表
	 */
	@Operation(summary = "查询文章列表接口")
	@Parameters({
			@Parameter(name = "typeid", description = "所属栏目", required =false, in= ParameterIn.QUERY),
			@Parameter(name = "pageNo", description = "页码", required =false, in= ParameterIn.QUERY),
			@Parameter(name = "ispaging", description = "是否分页", required =false, in= ParameterIn.QUERY),
			@Parameter(name = "typeids", description = "多个栏目id，以逗号隔开", required = false, in = ParameterIn.QUERY),
			@Parameter(name = "size", description = "文章个数", required = false, in = ParameterIn.QUERY),
			@Parameter(name = "flag", description = "筛选指定属性文章", required = false, in = ParameterIn.QUERY),
			@Parameter(name = "noflag", description = "筛选属性之外的文章", required = false, in = ParameterIn.QUERY),
			@Parameter(name = "orderby", description = "排序方式", required = false, in = ParameterIn.QUERY),
			@Parameter(name = "order", description = "升序或降序", required = false, in = ParameterIn.QUERY),
			@Parameter(name = "appId", description = "站点id，配合typeid参数使用", required = false, in = ParameterIn.QUERY),

	})
	@RequestMapping(value = "/list",method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResultData list(HttpServletResponse response, HttpServletRequest request) {
		//会将请求参数全部转换map
		Map<String,Object> map = BasicUtil.assemblyRequestMap();
		String typeid = (String) map.get("typeid");
		 if (StrUtil.isBlank(typeid)){
			typeid = (String) map.get("categoryId");
		}

		PageBean page = new PageBean();
		Set<String> modelFieldNames = new HashSet<>();
		// 栏目对应自定义模型字段的值 自定义模型仅在单栏目查询时支持
		Map<String,Object> modelFieldValueMap = new HashMap<>();
		// 栏目对应模型
		ModelEntity contentModel = null;
		page.setPageNo(BasicUtil.getInt("pageNo",1));
		page.setSize(BasicUtil.getInt("size",10));
		map.put("ispaging","true");
		map.putIfAbsent("size",page.getSize());
		if (BasicUtil.getWebsiteApp() != null) {
			map.put(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getId());
		}
		map.put(ParserUtil.PAGE, page);
		if (typeid != null) {
			CategoryEntity column = categoryBiz.getById(typeid);
			// 获取表单类型的id
			if (column != null && ObjectUtil.isNotNull(column.getMdiyModelId())) {
				contentModel = (ModelEntity) modelBiz.getById(column.getMdiyModelId());
				if (contentModel != null) {
					// 保存自定义模型的数据
					Map<String, String> fieldMap = contentModel.getFieldMap();
					for (String s : fieldMap.keySet()) {
						modelFieldNames.add(fieldMap.get(s));
					}
					// 设置自定义模型表名，方便解析的时候关联表查询
					map.put(ParserUtil.TABLE_NAME, contentModel.getModelTableName());

				}
			}

			// 设置栏目，方便解析的时候关联表查询
			map.put(ParserUtil.COLUMN, column);
		}
		// 读取请求中自定义模型的字段
		if (!modelFieldNames.isEmpty()) {
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				if (entry != null) {
					//空值不处理
					if (ObjectUtil.isNull(entry.getValue())) {
						continue;
					}

					Object rawValue = entry.getValue();
					if (rawValue == null) {
						continue;
					}

					String value = rawValue.toString();
					// 如果是get方法需要将请求地址参数转码
					if (request.getMethod().equals(RequestMethod.GET)) {
						try {
							value = new String(value.getBytes("ISO-8859-1"), Const.UTF8);
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}

					// 保存至自定义字段集合
					if (StringUtils.isNotBlank(value)) {
						//判断请求中的是否是自定义模型中的字段
						if (modelFieldNames.contains(entry.getKey())) {
							//设置自定义模型字段和值
							modelFieldValueMap.put(entry.getKey(),value);
						}
					}

				}
			}
		}

		//添加自定义模型的字段和值
		if (modelFieldValueMap.size() > 0) {
			map.put("diyModel", modelFieldValueMap);
		}

		int count = contentBiz.getSearchCount(contentModel, modelFieldValueMap, map, typeid);
		// 判断是否开启短链
		boolean shortSwitch = ConfigUtil.getBoolean("静态化配置", "shortSwitch", false);
		map.put(ParserUtil.SHORT_SWITCH, shortSwitch);
		//实际上list是需要参数，例如分页、栏目分类、属性等待，具体看标签arclist对应的参数
		List<Map<String,Object>> contentList = contentBiz.list(map);
		return ResultData.build().success(new EUListBean(contentList,count));
	}


	/**
	 * 根据文章id获取指定文章接口，如果文章有绑定的自定义模型会一并查询返回
	 * @param content 文章
	 * @return 文章数据
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
		// 判断是否开启短链
		boolean shortSwitch = ConfigUtil.getBoolean("静态化配置", "shortSwitch", false);
		map.put(ParserUtil.SHORT_SWITCH, shortSwitch);
		Map<String,Object> contentMap = contentBiz.get(map);
		return ResultData.build().success(contentMap);
	}

	/**
	 * 查看文章点击数
	 * @param contentId 文章编号
	 * @return 文章点击数
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
