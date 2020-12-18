/**
 * The MIT License (MIT)
 * Copyright (c) 2020 铭软科技(mingsoft.net)
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

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import net.mingsoft.base.entity.BaseEntity;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.basic.annotation.LogAnn;
import net.mingsoft.basic.bean.EUListBean;
import net.mingsoft.basic.constant.e.BusinessTypeEnum;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.PinYinUtil;
import net.mingsoft.basic.util.StringUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.entity.CategoryEntity;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 分类管理控制层
 * @author 铭飞开发团队
 * 创建日期：2019-11-28 15:12:32<br/>
 * 历史修订：<br/>
 */
@Api(value = "分类接口")
@Controller("cmsCategoryAction")
@RequestMapping("/${ms.manager.path}/cms/category")
public class CategoryAction extends BaseAction {


	/**
	 * 注入分类业务层
	 */
	@Autowired
	private ICategoryBiz categoryBiz;

	/**
	 * 返回主界面index
	 */
	@GetMapping("/index")
	public String index(HttpServletResponse response,HttpServletRequest request){
		return "/cms/category/index";
	}

	/**
	 * 查询分类列表
	 * @param category 分类实体
	 */
	@ApiOperation(value = "查询分类列表接口")
	@ApiImplicitParams({
    	@ApiImplicitParam(name = "categoryTitle", value = "栏目管理名称", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryId", value = "所属栏目", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryType", value = "栏目管理属性", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categorySort", value = "自定义顺序", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryListUrl", value = "列表模板", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryUrl", value = "内容模板", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryKeyword", value = "栏目管理关键字", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryDescrip", value = "栏目管理描述", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryImg", value = "缩略图", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryDiyUrl", value = "自定义链接", required =false,paramType="query"),
    	@ApiImplicitParam(name = "mdiyModelId", value = "栏目管理的内容模型id", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryDatetime", value = "类别发布时间", required =false,paramType="query"),
    	@ApiImplicitParam(name = "dictId", value = "字典对应编号", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryFlag", value = "栏目属性", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryPath", value = "栏目路径", required =false,paramType="query"),
    	@ApiImplicitParam(name = "categoryParentId", value = "父类型编号", required =false,paramType="query"),
    	@ApiImplicitParam(name = "createBy", value = "创建人", required =false,paramType="query"),
    	@ApiImplicitParam(name = "createDate", value = "创建时间", required =false,paramType="query"),
    	@ApiImplicitParam(name = "updateBy", value = "修改人", required =false,paramType="query"),
    	@ApiImplicitParam(name = "updateDate", value = "修改时间", required =false,paramType="query"),
    	@ApiImplicitParam(name = "del", value = "删除标记", required =false,paramType="query"),
    	@ApiImplicitParam(name = "id", value = "编号", required =false,paramType="query"),
    })
	@RequestMapping("/list")
	@ResponseBody
	public ResultData list(@ModelAttribute @ApiIgnore CategoryEntity category, HttpServletResponse response, HttpServletRequest request, @ApiIgnore ModelMap model, BindingResult result) {
		BasicUtil.startPage();
		List categoryList = categoryBiz.query(category);
		return ResultData.build().success(new EUListBean(categoryList,(int) BasicUtil.endPage(categoryList).getTotal()));
	}

	/**
	 * 返回编辑界面category_form
	 */
	@GetMapping("/form")
	public String form(@ModelAttribute CategoryEntity category, HttpServletResponse response, HttpServletRequest request, ModelMap model){
		model.addAttribute("appId", BasicUtil.getApp().getAppId());
		return "/cms/category/form";
	}

	/**
	 * 获取分类
	 * @param category 分类实体
	 */
	@ApiOperation(value = "获取分类列表接口")
    @ApiImplicitParam(name = "id", value = "编号", required =true,paramType="query")
	@GetMapping("/get")
	@ResponseBody
	public ResultData get(@ModelAttribute @ApiIgnore CategoryEntity category, HttpServletResponse response, HttpServletRequest request, @ApiIgnore ModelMap model){
		if(category.getId()==null) {
			return ResultData.build().error();
		}
		CategoryEntity _category = (CategoryEntity)categoryBiz.getById(category.getId());
		return ResultData.build().success(_category);
	}

	@ApiOperation(value = "保存分类列表接口")
	 @ApiImplicitParams({
    	@ApiImplicitParam(name = "categoryTitle", value = "栏目管理名称", required =true,paramType="query"),
		@ApiImplicitParam(name = "categoryId", value = "所属栏目", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryType", value = "栏目管理属性", required =false,paramType="query"),
		@ApiImplicitParam(name = "categorySort", value = "自定义顺序", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryListUrl", value = "列表模板", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryUrl", value = "内容模板", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryKeyword", value = "栏目管理关键字", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryDescrip", value = "栏目管理描述", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryImg", value = "缩略图", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryDiyUrl", value = "自定义链接", required =false,paramType="query"),
		@ApiImplicitParam(name = "mdiyModelId", value = "栏目管理的内容模型id", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryDatetime", value = "类别发布时间", required =false,paramType="query"),
		@ApiImplicitParam(name = "dictId", value = "字典对应编号", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryFlag", value = "栏目属性", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryPath", value = "栏目路径", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryParentId", value = "父类型编号", required =false,paramType="query"),
		@ApiImplicitParam(name = "createBy", value = "创建人", required =false,paramType="query"),
		@ApiImplicitParam(name = "createDate", value = "创建时间", required =false,paramType="query"),
		@ApiImplicitParam(name = "updateBy", value = "修改人", required =false,paramType="query"),
		@ApiImplicitParam(name = "updateDate", value = "修改时间", required =false,paramType="query"),
		@ApiImplicitParam(name = "del", value = "删除标记", required =false,paramType="query"),
		@ApiImplicitParam(name = "id", value = "编号", required =false,paramType="query"),
	})

	/**
	* 保存分类
	* @param category 分类实体
	*/
	@PostMapping("/save")
	@ResponseBody
	@LogAnn(title = "保存分类", businessType = BusinessTypeEnum.INSERT)
	@RequiresPermissions("cms:category:save")
	public ResultData save(@ModelAttribute @ApiIgnore CategoryEntity category, HttpServletResponse response, HttpServletRequest request) {
		//验证栏目管理名称的值是否合法
		if(StringUtil.isBlank(category.getCategoryTitle())){
			return ResultData.build().error(getResString("err.empty", this.getResString("category.title")));
		}
		if(!StringUtil.checkLength(category.getCategoryTitle()+"", 1, 100)){
			return ResultData.build().error(getResString("err.length", this.getResString("category.title"), "1", "100"));
		}

		if(!StringUtil.checkLength(category.getCategoryPath()+"", 1, 100)){
			return ResultData.build().error(getResString("err.length", this.getResString("category.path"), "1", "100"));
		}
		if(!StringUtil.checkLength(category.getCategoryParentIds()+"", 1, 100)){
			return ResultData.build().error(getResString("err.length", this.getResString("category.parent.id"), "1", "100"));
		}
		//判断拼音是否重复
		if(StrUtil.isNotBlank(category.getCategoryPinyin())) {
			CategoryEntity _category = new CategoryEntity();
			_category.setCategoryPinyin(category.getCategoryPinyin());
			List<CategoryEntity> query = categoryBiz.query(_category);
			if (query.size() > 0) {
				return ResultData.build().error(getResString("err.exist", this.getResString("category.pinyin")));
			}
		}

		categoryBiz.saveEntity(category);
		return ResultData.build().success(category);
	}

	/**
	 * @param categorys 分类实体
	 */
	@ApiOperation(value = "批量删除分类列表接口")
	@PostMapping("/delete")
	@ResponseBody
	@LogAnn(title = "删除分类", businessType = BusinessTypeEnum.DELETE)
	@RequiresPermissions("cms:category:del")
	public ResultData delete(@RequestBody List<CategoryEntity> categorys, HttpServletResponse response, HttpServletRequest request) {
		for(int i = 0;i<categorys.size();i++){
			categoryBiz.delete(categorys.get(i).getId());
		}
		return ResultData.build().success();
	}
	/**
	*	更新分类列表
	* @param category 分类实体
	*/
	 @ApiOperation(value = "更新分类列表接口")
	 @ApiImplicitParams({
	    @ApiImplicitParam(name = "id", value = "编号", required =true,paramType="query"),
    	@ApiImplicitParam(name = "categoryTitle", value = "栏目管理名称", required =true,paramType="query"),
		@ApiImplicitParam(name = "categoryId", value = "所属栏目", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryType", value = "栏目管理属性", required =false,paramType="query"),
		@ApiImplicitParam(name = "categorySort", value = "自定义顺序", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryListUrl", value = "列表模板", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryUrl", value = "内容模板", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryKeyword", value = "栏目管理关键字", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryDescrip", value = "栏目管理描述", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryImg", value = "缩略图", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryDiyUrl", value = "自定义链接", required =false,paramType="query"),
		@ApiImplicitParam(name = "mdiyModelId", value = "栏目管理的内容模型id", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryDatetime", value = "类别发布时间", required =false,paramType="query"),
		@ApiImplicitParam(name = "dictId", value = "字典对应编号", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryFlag", value = "栏目属性", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryPath", value = "栏目路径", required =false,paramType="query"),
		@ApiImplicitParam(name = "categoryParentId", value = "父类型编号", required =false,paramType="query"),
		@ApiImplicitParam(name = "createBy", value = "创建人", required =false,paramType="query"),
		@ApiImplicitParam(name = "createDate", value = "创建时间", required =false,paramType="query"),
		@ApiImplicitParam(name = "updateBy", value = "修改人", required =false,paramType="query"),
		@ApiImplicitParam(name = "updateDate", value = "修改时间", required =false,paramType="query"),
		@ApiImplicitParam(name = "del", value = "删除标记", required =false,paramType="query"),
		@ApiImplicitParam(name = "id", value = "编号", required =false,paramType="query"),
	})
	@PostMapping("/update")
	@ResponseBody
	@LogAnn(title = "更新分类", businessType = BusinessTypeEnum.UPDATE)
	@RequiresPermissions("cms:category:update")
	public ResultData update(@ModelAttribute @ApiIgnore CategoryEntity category, HttpServletResponse response,
                             HttpServletRequest request) {
		//验证栏目管理名称的值是否合法
		if(StringUtil.isBlank(category.getCategoryTitle())){
			return ResultData.build().error(getResString("err.empty", this.getResString("category.title")));
		}
		if(!StringUtil.checkLength(category.getCategoryTitle()+"", 1, 100)){
			return ResultData.build().error(getResString("err.length", this.getResString("category.title"), "1", "100"));
		}

		if(!StringUtil.checkLength(category.getCategoryPath()+"", 0, 100)){
			return ResultData.build().error(getResString("err.length", this.getResString("category.path"), "1", "100"));
		}
		if(!StringUtil.checkLength(category.getCategoryParentIds()+"", 0, 100)){
			return ResultData.build().error(getResString("err.length", this.getResString("category.parent.id"), "1", "100"));
		}
		 //判断拼音是否重复并且是否和原拼音相同
		 if(StrUtil.isNotBlank(category.getCategoryPinyin()) && !categoryBiz.getById(category.getId()).getCategoryPinyin().equals(category.getCategoryPinyin())) {
			 CategoryEntity _category = new CategoryEntity();
			 _category.setCategoryPinyin(category.getCategoryPinyin());
			 List<CategoryEntity> query = categoryBiz.query(_category);
			 if (query.size() > 0) {
				 return ResultData.build().error(getResString("err.exist", this.getResString("category.pinyin")));
			 }
		 }
		 String pingYin = PinYinUtil.getPingYin(category.getCategoryTitle());
		 //如果用户填写了拼音则使用用户填写的
		 if (StrUtil.isNotBlank(category.getCategoryPinyin())) {
		 	pingYin = category.getCategoryPinyin();
		 }
		 CategoryEntity categoryEntity=new CategoryEntity();
		 categoryEntity.setCategoryPinyin(pingYin);
		 CategoryEntity categoryBizEntity = categoryBiz.getEntity(categoryEntity);
		 category.setCategoryPinyin(pingYin);
		 //如果存在此拼音栏目则拼接上id
		 if(categoryBizEntity!=null&&!categoryBizEntity.getId().equals(category.getId())){
			 category.setCategoryPinyin(pingYin+category.getId());
		 }
		//判断是否选择子级为所属栏目
		 CategoryEntity _category = new CategoryEntity();
		 _category.setCategoryParentIds(category.getId());
		 List<CategoryEntity> categoryList = categoryBiz.queryChilds(_category);
		 for(CategoryEntity item:categoryList){
			 if(item.getId().equals(category.getCategoryId())){
				 return ResultData.build().error(getResString("cannot.select.child"));
			 }
		 }
		categoryBiz.updateEntity(category);
		return ResultData.build().success(category);
	}

	@ApiOperation(value = "验证拼音")
	@GetMapping("/verifyPingYin")
	@ResponseBody
	public ResultData verifyPingYin(@ModelAttribute @ApiIgnore CategoryEntity category, HttpServletResponse response, HttpServletRequest request, @ApiIgnore ModelMap model){
	 	int count = categoryBiz.count(Wrappers.<CategoryEntity>lambdaQuery()
				.ne(StrUtil.isNotBlank(category.getId()), CategoryEntity::getId, category.getId())
				.eq(CategoryEntity::getCategoryPinyin, category.getCategoryPinyin()));

		if(count>0){
			return ResultData.build().error("存在相同拼音的栏目");
		}
		return ResultData.build().success();
	}

	@ApiOperation(value = "批量更新模版")
	@GetMapping("/updateTemplate")
	@ResponseBody
	@RequiresPermissions("cms:category:update")
	public ResultData updateTemplate(@ModelAttribute @ApiIgnore CategoryEntity category){
		if (category ==null || StringUtils.isEmpty(category.getId())) {
			return ResultData.build().error(getResString("err.error", this.getResString("id")));
		}
		category = categoryBiz.getById(category.getId());
		category.setCategoryParentIds(null);
		List<CategoryEntity> childs = categoryBiz.queryChilds(category);
		//更新与父节点相同类型的子栏目的模板内容
		for (int i =0; i < childs.size(); i++) {
			if (childs.get(i).getCategoryType().equals(category.getCategoryType())) {
				childs.get(i).setCategoryUrl(category.getCategoryUrl());
				childs.get(i).setCategoryListUrl(category.getCategoryListUrl());
				categoryBiz.updateEntity(childs.get(i));
			}
		}
		return ResultData.build().success();
	}

	@ApiOperation(value = "复制栏目")
	@GetMapping("/copyCategory")
	@ResponseBody
	@RequiresPermissions("cms:category:save")
	public ResultData copyCategory(@ModelAttribute @ApiIgnore CategoryEntity category){
		if (category == null || StringUtils.isEmpty(category.getId())) {
			return ResultData.build().error(getResString("err.error", this.getResString("id")));
		}
		categoryBiz.copyCategory(category);
		return ResultData.build().success();
	}

}
