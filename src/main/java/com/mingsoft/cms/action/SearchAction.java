package com.mingsoft.cms.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.cms.biz.IFieldBiz;
import com.mingsoft.cms.biz.ISearchBiz;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.cms.entity.FieldEntity;
import com.mingsoft.cms.entity.SearchEntity;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
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
 * @author 姓名：张敏
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:搜索控制层，继承BasicAction
 * </p>
 *  
 * <p>
 * Create Date:2014-7-14
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Controller
@RequestMapping("/manager/cms/search")
public class SearchAction extends BaseAction {

	/**
	 * 栏目业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;
	
	/**
	 * 字段业务层
	 */
	@Autowired
	private IFieldBiz fieldBiz;
	
	/**
	 * 搜索业务层
	 */
	@Autowired
	private ISearchBiz searchBiz;
	
	/**
	 * 搜索列表路径
	 */
	private final static String PAGE_URL = "/manager/cms/search/list.do";
	
	/**
	 * 跳转至创建搜索页面
	 * @param model
	 * @param request 请求
	 * @return 返回页面
	 */
	@RequestMapping("/add")
	public String add(ModelMap model ,HttpServletRequest request){
 		List<ColumnEntity> columnList = columnBiz.queryColumnListByWebsiteId(getManagerBySession(request).getBasicId());
 		model.addAttribute("columnList", JSONObject.toJSON(columnList).toString());
		model.addAttribute("flag", true);
		return "/manager/cms/search/search";
	}
	
	/**
	 * 查询栏目自定义的字段名
	 * @param columnId 栏目ID
	 * @param model
	 * @param request 请求
	 */
	@RequestMapping("/{columnId}/queryFieldName")
	@ResponseBody
	public Map queryFieldName(@PathVariable int columnId, HttpServletRequest request){
		Map model = new HashMap();
		// 获取栏目信息
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(columnId);
		if(column!=null){
			//获取表单类型的id
			int fieldCmid = column.getColumnContentModelId();
			// 根据表单类型id查找出所有的字段信息
			List<BaseEntity> listField = fieldBiz.queryListByCmid(fieldCmid);
			model.put("listField",listField);
		}
		return model;
	}
	
	/**
	 * 验证表单提交数据
	 * @param search 搜索
	 * @param response
	 * @return 返回提示信息
	 */
	private boolean validateForm(SearchEntity search,HttpServletResponse response){
		if(!StringUtil.checkLength(search.getSearchName(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("searchName"),"1","30"));
			return  false;
		}
		if(!StringUtil.checkLength(search.getSearchTemplets(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("searchTemplets"),"1","30"));
			return false;
		}
		return true;
	}
	
	/**
	 * 保存搜索表单
	 * @param search 搜索实体
	 * @param request 请求
	 * @param response 响应
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute SearchEntity search,HttpServletRequest request,HttpServletResponse response){
		if(this.validateForm(search, response)){
			ManagerSessionEntity managerSession = getManagerBySession(request);
			search.setSearchWebsiteId(managerSession.getBasicId());
			searchBiz.saveEntity(search);
			this.outJson(response, null, true, String.valueOf(search.getSearchId()));
		}		
	}

	/**
	 * 生成搜索表单的html样式
	 * @param model
	 * @param request 请求
	 * @return 返回html样式
	 */
	@RequestMapping("/generateSreachFormHtml")
	public String generateSreachFormHtml(ModelMap model, HttpServletRequest request){
		ManagerSessionEntity managerSession = getManagerBySession(request);
		int searchId = 0;
		if(!StringUtil.isBlank(request.getParameter("searchId"))){
			searchId = Integer.valueOf(request.getParameter("searchId"));
		}
		//获取页面勾选的字段信息
		Map<String, String[]> field = new HashMap<String,String[]>();
		field = request.getParameterMap();
		int basicCategoryId = 0;
		int cmId = 0;
		Map<String, String> articleField = getMapByProperties("com/mingsoft/cms/resources/article_field");
		Map<String, String> articleType = getMapByProperties("com/mingsoft/cms/resources/article_attribute");
		List<Map<String,String>> listFieldName = new ArrayList<Map<String,String>>();	
		for(Entry<String, String[]> entry : field.entrySet()){
			String key = entry.getKey();
			String value =  entry.getValue()[0];
			if(key.equals("columnId") && !StringUtil.isBlank(value) && !key.equals("searchId")){
				basicCategoryId = Integer.valueOf(value);
			}
			if(!key.equals("columnId") && !key.equals("searchId")){ 
				Map<String,String> map = new HashMap<String,String>();	
				map.put("name", key);
				map.put("type", value);
				//若为文章字段则直接取配置文件；若为自定义字段，则取数据库值
				if(!StringUtil.isBlank(articleField.get(key))){
					map.put("ch", articleField.get(key));
				} else {					
					//若栏目ID不为0，则选择了栏目
					if(basicCategoryId != 0){
						ColumnEntity column = (ColumnEntity) columnBiz.getEntity(Integer.valueOf(basicCategoryId));
						//获取表单类型的id
						cmId = column.getColumnContentModelId();
					}
					FieldEntity fieldEntity = (FieldEntity) fieldBiz.getEntityByCmId(cmId,key);
					if(!StringUtil.isBlank(fieldEntity)){
						String fieldTipsName = fieldEntity.getFieldTipsName();
						map.put("ch", fieldTipsName);
					} 
				}
				if(key.equals("article_type")){
					map.put("default", articleType.toString());
				} else {
					map.put("default", key.toString());
				}
				listFieldName.add(map);
			}
		}
		model.addAttribute("searchId", searchId);
		model.addAttribute("websiteId", managerSession.getBasicId());
		model.addAttribute("listFieldName", listFieldName);
		model.addAttribute("basicCategoryId",basicCategoryId);
		return "manager/cms/search/search_field";
	}

	
	
	/**
	 * 搜索列表
	 * @param model
	 * @param request 请求
	 */
	@RequestMapping("/list")
	public String list(ModelMap model, HttpServletRequest request){
		int appId = this.getAppId(request);
		//当前页数
		Integer pageNo = this.getInt(request, "pageNo",1);
		int recordCount = searchBiz.queryCount(appId);
		PageUtil page = new PageUtil(pageNo,recordCount, getUrl(request) + PAGE_URL);
		List<BaseEntity> searchList = searchBiz.query(appId, page);
		model.addAttribute("searchList",searchList);
		model.addAttribute("page", page);
		return "manager/cms/search/search_list";
	}
	
	/**
	 * 删除搜索
	 * @param roleId ID
	 * @param response 响应
	 */
	@RequestMapping("/{searchId}/delete")
	@ResponseBody
	public int delete(@PathVariable int searchId, HttpServletRequest request){
		int pageNo = 1;
		if(searchId != 0){
			searchBiz.deleteEntity(searchId);
			//判断当前页码
			this.getHistoryPageNoByCookie(request);
		}
		return pageNo;
	}
	
	/**
	 * 更新搜索
	 * @param request 请求
	 * @return 返回更新搜索页面
	 */
	@RequestMapping("/{searchId}/edit")
	public String edit(@PathVariable int searchId,ModelMap model,HttpServletRequest request){
		if(searchId == 0){
			return "/manager/searchId/list";
		}
		List<ColumnEntity> columnList = columnBiz.queryColumnListByWebsiteId(getManagerBySession(request).getBasicId());
 		model.addAttribute("columnList", JSONObject.toJSON(columnList).toString());
		SearchEntity search = (SearchEntity)searchBiz.getEntity(searchId);
		model.addAttribute("search",search);
		model.addAttribute("flag", false);
		return "/manager/cms/search/search";
				
	}
	
	/**
	 * 保存搜索表单
	 * @param search 搜索实体
	 * @param request 请求
	 * @param response 响应
	 */
	@RequestMapping("/update")
	public void update(@ModelAttribute SearchEntity search,HttpServletRequest request,HttpServletResponse response){
		if(this.validateForm(search, response)){
			searchBiz.updateEntity(search);
			this.outJson(response, null, true,null);
		}
	}
}
