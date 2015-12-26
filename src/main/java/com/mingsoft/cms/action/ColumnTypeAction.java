package com.mingsoft.cms.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.basic.biz.IBasicCategoryBiz;
import com.mingsoft.basic.biz.ICategoryBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.entity.BasicCategoryEntity;
import com.mingsoft.basic.entity.CategoryEntity;
import com.mingsoft.basic.entity.ModelEntity;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.cms.entity.ColumnEntity;

/**
 * 
 * <p>
 * <b>铭飞基础框架</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 史爱华
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:类别基础信息关联业务层
 * </p>
 *  
 * <p>
 * Create Date:2015-08-14
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Controller
@RequestMapping("/manager/cms/type")
public class ColumnTypeAction  extends BaseAction {
	
	/**
	 * 业务层的注入
	 */
	@Autowired
	private IColumnBiz columnBiz;
	
	/**
	 * 模块业务层的注入
	 */
	@Autowired
	private IModelBiz modelBiz;
	
	/**
	 * 注入分类业务层
	 */
	@Autowired
	private ICategoryBiz categoryBiz;
	
	/**
	 * 注入基础分类关联业务层
	 */
	@Autowired
	private IBasicCategoryBiz basicCategoryBiz;
	
	/**
	 * 加载页面显示所有文章信息
	 * 
	 * @param request
	 * @return 返回文章页面显示地址
	 */
	@SuppressWarnings("static-access")
	@RequestMapping("/index")
	public String index(HttpServletRequest request, ModelMap mode, HttpServletResponse response) {
		// 站点ID有session获取
		int appId = this.getAppId(request);
		// 需要打开的栏目节点树的栏目ID
		List<ColumnEntity> list = new ArrayList<ColumnEntity>();
		//查询栏目管理
		ModelEntity columModel = modelBiz.getEntityByModelCode(com.mingsoft.base.constant.ModelCode.CMS_COLUMN);
		list = columnBiz.queryAll(appId, columModel.getModelId());
		// columnBiz.queryChild(categoryId,websiteId,this.getModelCodeId(request));
		//获取属性的modeId
		ModelEntity model = modelBiz.getEntityByModelCode(com.mingsoft.base.constant.ModelCode.CMS_COLUMN_TYPE);
		if(model!=null){
			mode.addAttribute("modelId", model.getModelId());
		}
		mode.addAttribute("listColumn", JSONArray.toJSONString(list));
		return "/manager/cms/type/index";
	}
	
	/**
	 * 根据栏目id去查询该分类下的属性,主要是供ajax请求使用
	 * @param categoryId 分类id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{categoryId}/{basicId}/queryByCategoryId")
	public String  queryByCategoryId(@PathVariable int categoryId,@PathVariable int basicId,HttpServletRequest request,HttpServletResponse response, ModelMap mode){
		//获取属性的modeId
		ModelEntity model = modelBiz.getEntityByModelCode(com.mingsoft.base.constant.ModelCode.CMS_COLUMN_TYPE);
		int appId = this.getAppId(request);
		if(model!=null){
			List<CategoryEntity> categoryList = this.categoryBiz.queryChildrenCategory(categoryId, appId, model.getModelId());
			mode.addAttribute("categoryList",JSONArray.toJSONString(categoryList));
		}
		//获取basicid
		if(basicId>0){
					//根据basicI
			List<BasicCategoryEntity> basicCategoryList = basicCategoryBiz.queryByBasicId(basicId);
			mode.addAttribute("basicCategoryList",JSONArray.toJSONString(basicCategoryList));
		}
		
		return "/manager/cms/type/type_fields";
	}
}
