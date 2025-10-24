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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.tags.Tag;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.entity.CategoryEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
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
	 * 查询分类列表
	 * @param category 分类实体
	 */
	@Operation(summary = "查询分类列表接口")
	@Parameters({
    	@Parameter(name = "id", description = "栏目管理ID", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryTitle", description = "栏目管理名称", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryShortTitle", description = "栏目管理副标题", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryPinyin", description = "栏目管理别名", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryId", description = "所属栏目id", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryType", description = "栏目管理属性", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryListUrl", description = "列表模板", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryUrl", description = "内容模板", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryKeyword", description = "栏目管理关键字", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryDescrip", description = "栏目管理描述", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryDiyUrl", description = "自定义链接", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "mdiyModelId", description = "文章管理的内容模型id", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "dictId", description = "字典对应编号", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryFlag", description = "栏目属性", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryPath", description = "栏目路径", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "categoryParentIds", description = "父类型编号", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "leaf", description = "叶子节点", required = false, in = ParameterIn.QUERY),
    	@Parameter(name = "topId", description = "顶级id", required = false, in = ParameterIn.QUERY),
    })
	@PostMapping(value="/list")
	@ResponseBody
	public ResultData list(@ModelAttribute @Parameter(hidden = true) CategoryEntity category) {
		category.setSqlWhere("");
		List categoryList = categoryBiz.query(category);
		return ResultData.build().success(new EUListBean(categoryList,(int)BasicUtil.endPage(categoryList).getTotal()));
	}


	/**
	 * 获取分类
	 * @param category 分类实体
	 */
	@Operation(summary =  "获取分类列表接口")
    @Parameter(name = "id", description = "编号", required = true, in = ParameterIn.QUERY)
	@GetMapping("/get")
	@ResponseBody
	public ResultData get(@ModelAttribute @Parameter(hidden = true) CategoryEntity category){
		if(category.getId()==null) {
			return ResultData.build().error();
		}
		category.setSqlWhere("");
		CategoryEntity _category = (CategoryEntity)categoryBiz.getById(category.getId());
		return ResultData.build().success(_category);
	}

}
