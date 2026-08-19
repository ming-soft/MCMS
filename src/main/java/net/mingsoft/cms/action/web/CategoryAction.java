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

import cn.hutool.core.map.MapUtil;
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
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.mdiy.biz.IModelBiz;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.util.ConfigUtil;
import net.mingsoft.mdiy.util.ParserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 分类管理控制层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
@Tag(name = "前端-内容模块接口")
@Controller("WebcmsCategoryAction")
@RequestMapping("/cms/category")
public class CategoryAction extends net.mingsoft.cms.action.BaseAction{


	/**
	 * 注入分类业务层
	 */
	@Autowired
	private ICategoryBiz categoryBiz;

	/**
	 * 模型业务层
	 */
	@Autowired
	private IModelBiz modelBiz;

	/**
	 * 查询分类列表
	 */
	@Operation(summary = "查询分类列表接口")
	@Parameters({
		@Parameter(name = "type", description = "栏目属性，如son、self、nav等", required = false, in = ParameterIn.QUERY),
		@Parameter(name = "typeid", description = "栏目id", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "typeids", description = "多个栏目id，以逗号隔开", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "size", description = "栏目个数", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "flag", description = "筛选指定属性栏目", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "noflag", description = "筛选属性之外的栏目", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "orderby", description = "排序方式", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "order", description = "升序或降序", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "appId", description = "站点id，配合typeid参数使用", required = false, in = ParameterIn.QUERY),
    })
	@RequestMapping(value = "/list",method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResultData list(HttpServletResponse response, HttpServletRequest request) {
		//会将请求参数全部转换map
		Map<String,Object> map = BasicUtil.assemblyRequestMap();
		ParserUtil.checkRequestParams(map);
		if (BasicUtil.getWebsiteApp() != null) {
			map.putIfAbsent(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getId());
		}
		String typeid = (String) map.get("typeid");
		CategoryEntity column = null;
		if (StrUtil.isNotBlank(typeid)){
			column = categoryBiz.getById(typeid);
			if (column != null) {
				map.put(ParserUtil.COLUMN, column);
			}
		}
		// 默认不分页处理
		if (map.containsKey("size")) {
			map.put("size",BasicUtil.getInt("size",10));
		}
		String type = MapUtil.getStr(map, "type");
		// 如果type等于self且mdiyCategoryModelId不为空，说明有自定义模型
		if (column != null && StrUtil.equals(type, "self") && StrUtil.isNotBlank(column.getMdiyCategoryModelId())) {
			ModelEntity modelEntity = modelBiz.getEntityById(column.getMdiyCategoryModelId());
			if (modelEntity != null) {
				map.put(ParserUtil.TABLE_NAME, modelEntity.getModelTableName());
			}
		}
		// 获取栏目属性
		// 判断是否开启短链
		boolean shortSwitch = ConfigUtil.getBoolean("静态化配置", "shortSwitch", false);
		map.put(ParserUtil.SHORT_SWITCH, shortSwitch);
		List<Map<String,Object>> categoryList  = categoryBiz.list(map);
		return ResultData.build().success(new EUListBean(categoryList,categoryList.size()));

	}


	/**
	 * 获取分类
	 * @param category 分类实体
	 */
	@Operation(summary =  "获取分类列表接口")
    @Parameter(name = "id", description = "编号", required = true, in = ParameterIn.QUERY)
	@Parameter(name = "appId", description = "站点id", required = false, in = ParameterIn.QUERY)
	@GetMapping("/get")
	@ResponseBody
	public ResultData get(@ModelAttribute @Parameter(hidden = true) CategoryEntity category){
		if(category.getId()==null) {
			return ResultData.build().error();
		}
		category.setSqlWhere("");
		CategoryEntity _category = (CategoryEntity)categoryBiz.getById(category.getId());
		if (_category == null) {
			return ResultData.build().error(getResString("err.error", getResString("id")));
		}
		Map<String, Object> map = new HashMap<>();
		map.put("type", "self");
		map.put(ParserUtil.TYPE_ID, _category.getId());
		map.put(ParserUtil.COLUMN, _category);
		if (BasicUtil.getWebsiteApp() != null) {
			map.putIfAbsent(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getId());
		}
		if (StrUtil.isNotBlank(_category.getMdiyCategoryModelId())) {
			ModelEntity modelEntity = modelBiz.getEntityById(_category.getMdiyCategoryModelId());
			if (modelEntity != null) {
				map.put(ParserUtil.TABLE_NAME, modelEntity.getModelTableName());
			}
		}
		// 判断是否开启短链
		boolean shortSwitch = ConfigUtil.getBoolean("静态化配置", "shortSwitch", false);
		map.put(ParserUtil.SHORT_SWITCH, shortSwitch);
		List<Map<String,Object>> categoryList  = categoryBiz.list(map);
		return ResultData.build().success(categoryList.get(0));
	}

}
