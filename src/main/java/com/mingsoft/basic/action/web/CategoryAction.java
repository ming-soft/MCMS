package com.mingsoft.basic.action.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.basic.biz.ICategoryBiz;
import com.mingsoft.basic.entity.CategoryEntity;

/**
 * 供前端查询分类信息使用
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Controller("webCategory")
@RequestMapping("/category")
public class CategoryAction extends BaseAction{
	
	/**
	 * 分类业务处理层注入
	 */
	@Autowired
	private ICategoryBiz categoryBiz;
	
	/**
	 * 根据分类id查找其父分类实体,如果父分类不存在则返回该分类实体
	 * @param categoryId 分类ID
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse对象
	 */
	@RequestMapping("/{categoryId}/getParentCategory")
	@ResponseBody
	public void getParentCategory(@PathVariable int categoryId,HttpServletRequest request, HttpServletResponse response){
		CategoryEntity category = this.categoryBiz.getCategory(categoryId);
		if(category!=null){
			CategoryEntity paCategory = categoryBiz.getCategory(category.getCategoryCategoryId());
			if(paCategory==null){
				this.outJson(response, JSONObject.toJSONString(category));
			}
			this.outJson(response, JSONObject.toJSONString(paCategory));
		}
	}
	
	/**
	 * 获取指定站点下的省份数据
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse对象
	 */
	@RequestMapping("/queryProvince")
	@ResponseBody
	public void queryProvince(HttpServletRequest request, HttpServletResponse response){
		int appId = this.getAppId(request);
		//获取省数据
		List<CategoryEntity>listProvince = categoryBiz.queryByAppIdOrModelId(appId,this.getModelCodeId(request,com.mingsoft.base.constant.ModelCode.CITY));
		this.outJson(response,JSONObject.toJSONStringWithDateFormat(listProvince,"yyyy-MM-dd HH:mm:ss"));
	}
	
	/**
	 * 根据指定分类id查询其子分类
	 * @param categoryId 分类id
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse对象
	 */
	@RequestMapping("/{categoryId}/queryChildren")
	public void queryChildren(@PathVariable int categoryId,HttpServletRequest request, HttpServletResponse response){
		CategoryEntity category = (CategoryEntity) this.categoryBiz.getEntity(categoryId);
		if(category!=null){
			List<CategoryEntity> list = this.categoryBiz.queryChilds(category);
			this.outJson(response, JSONObject.toJSONStringWithDateFormat(list,"yyyy-MM-dd HH:mm:ss"));
		}
	}
	
}
