package net.mingsoft.cms.action;

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
import net.mingsoft.basic.util.StringUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.entity.CategoryEntity;
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
public class CategoryAction extends BaseAction{
	
	
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
    	@ApiImplicitParam(name = "categoryManagerId", value = "发布用户id", required =false,paramType="query"),
    	@ApiImplicitParam(name = "appId", value = "应用编号", required =false,paramType="query"),
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
	public ResultData list(@ModelAttribute @ApiIgnore CategoryEntity category,HttpServletResponse response, HttpServletRequest request,@ApiIgnore ModelMap model,BindingResult result) {
		category.setAppId(BasicUtil.getAppId());
		BasicUtil.startPage();
		List categoryList = categoryBiz.query(category);
		return ResultData.build().success(new EUListBean(categoryList,(int)BasicUtil.endPage(categoryList).getTotal()));
	}
	
	/**
	 * 返回编辑界面category_form
	 */
	@GetMapping("/form")
	public String form(@ModelAttribute CategoryEntity category,HttpServletResponse response,HttpServletRequest request,ModelMap model){
		if(category.getId()!=null){
			BaseEntity categoryEntity = categoryBiz.getEntity(Integer.parseInt(category.getId()));			
			model.addAttribute("categoryEntity",categoryEntity);
		}
		model.addAttribute("appId",BasicUtil.getAppId());
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
	public ResultData get(@ModelAttribute @ApiIgnore CategoryEntity category,HttpServletResponse response, HttpServletRequest request,@ApiIgnore ModelMap model){
		if(category.getId()==null) {
			return ResultData.build().error();
		}
		category.setAppId(BasicUtil.getAppId());
		CategoryEntity _category = (CategoryEntity)categoryBiz.getEntity(Integer.parseInt(category.getId()));
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
		@ApiImplicitParam(name = "categoryManagerId", value = "发布用户id", required =false,paramType="query"),
		@ApiImplicitParam(name = "appId", value = "应用编号", required =false,paramType="query"),
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
		if(!StringUtil.checkLength(category.getCategoryParentId()+"", 1, 100)){
			return ResultData.build().error(getResString("err.length", this.getResString("category.parent.id"), "1", "100"));
		}
		category.setAppId(BasicUtil.getAppId());
		categoryBiz.saveEntity(category);
		return ResultData.build().success(category);
	}
	
	/**
	 * @param category 分类实体
	 */
	@ApiOperation(value = "批量删除分类列表接口")
	@PostMapping("/delete")
	@ResponseBody
	@LogAnn(title = "删除分类", businessType = BusinessTypeEnum.DELETE)
	@RequiresPermissions("cms:category:del")
	public ResultData delete(@RequestBody List<CategoryEntity> categorys,HttpServletResponse response, HttpServletRequest request) {
		for(int i = 0;i<categorys.size();i++){
			categoryBiz.delete(Integer.parseInt(categorys.get(i).getId()));
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
		@ApiImplicitParam(name = "categoryManagerId", value = "发布用户id", required =false,paramType="query"),
		@ApiImplicitParam(name = "appId", value = "应用编号", required =false,paramType="query"),
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
		if(!StringUtil.checkLength(category.getCategoryParentId()+"", 0, 100)){
			return ResultData.build().error(getResString("err.length", this.getResString("category.parent.id"), "1", "100"));
		}
		//判断是否选择子级为所属栏目
		 CategoryEntity _category = new CategoryEntity();
		 _category.setCategoryParentId(category.getId());
		 _category.setAppId(BasicUtil.getAppId());
		 List<CategoryEntity> categoryList = categoryBiz.queryChilds(_category);
		 for(CategoryEntity item:categoryList){
			 if(item.getId().equals(category.getCategoryId())){
				 return ResultData.build().error(getResString("cannot.select.child"));
			 }
		 }
		 category.setAppId(BasicUtil.getAppId());
		categoryBiz.updateEntity(category);
		return ResultData.build().success(category);
	}


		
}