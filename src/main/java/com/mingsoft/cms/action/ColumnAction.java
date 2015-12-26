package com.mingsoft.cms.action;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.cms.biz.IContentModelBiz;
import com.mingsoft.cms.constant.e.ColumnTypeEnum;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.StringUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
 * </p>
 * 
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 刘继平
 * 
 * @version 300-001-001
 * 
 * 
 *          <p>
 *          版权所有 铭飞科技
 *          </p>
 * 
 *          <p>
 *          Comments: 栏目控制层，继承BasicAction
 *          </p>
 * 
 *          <p>
 *          Create Date:2014-7-15
 *          </p>
 * 
 *          <p>
 *          Modification history:
 *          </p>
 */
@Controller
@RequestMapping("/manager/cms/column")
public class ColumnAction extends BaseAction {

	/**
	 * 业务层的注入
	 */
	@Autowired
	private IColumnBiz columnBiz;
	
	
	/**
	 * 模块业务层注入
	 */
	@Autowired
	private IModelBiz modelBiz;
	
	
	/**
	 * 业务层的注入表单内容模型
	 */
	@Autowired
	private IContentModelBiz contentModelBiz;

	/**
	 * 栏目添加
	 * 
	 * @param column
	 *            栏目对象
	 * @return 返回页面跳转
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute ColumnEntity column,
			HttpServletRequest request,HttpServletResponse response) {
		if(!checkForm(column,response)){
			return;
		}
		column.setCategoryAppId( this.getAppId(request));
		column.setColumnWebsiteId(this.getAppId(request));
		column.setCategoryManagerId(getManagerBySession(request).getManagerId());
		column.setCategoryDateTime(new Timestamp(System.currentTimeMillis()));
		column.setCategoryModelId(this.getModelCodeId(request));
		
		if(column.getColumnType()==ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()){
			column.setColumnListUrl(null);
		}
		columnBiz.saveCategory(column);
		this.columnPath(request,column);
		this.outJson(response, ModelCode.CMS_COLUMN, true,null,JSONArray.toJSONString(column.getCategoryId()));
	}

	/**
	 * 栏目添加跳转页面
	 * 
	 * @return
	 */
	@RequestMapping("/add")
	public String add(HttpServletRequest request,ModelMap model) {
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		// 站点ID
		int appId =this.getAppId(request);
		List<ColumnEntity> list = columnBiz.queryAll(appId, this.getModelCodeId(request));
		// 查询属于当前管理员的内容模型
		List<BaseEntity> listCm = contentModelBiz.queryByManagerId(managerSession.getManagerId());
		ColumnEntity columnSuper = new ColumnEntity();
		model.addAttribute("columnSuper", columnSuper);
		model.addAttribute("column",new ColumnEntity());
		model.addAttribute("listColumn", JSONObject.toJSON(list).toString());
		model.addAttribute("listCm", listCm);
		return "/manager/cms/column/column";
	}

	/**
	 * 栏目首页面列表显示
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request) {
			
		// 站点ID有session获取
		int websiteId = this.getAppId(request);
		// 需要打开的栏目节点树的栏目ID
		int categoryId = 0;
		List<ColumnEntity> list = new ArrayList<ColumnEntity>();

		Object cId = request.getParameter("categoryId");
		if (!StringUtil.isBlank(cId)) {
			categoryId = Integer.parseInt(cId.toString());
		}
		// 是否为顶级栏目
		//if (categoryId == Const.COLUMN_TOP_CATEGORY_ID) {
			list = columnBiz.queryAll(websiteId, this.getModelCodeId(request));// columnBiz.queryChild(categoryId,websiteId,this.getModelCodeId(request));
//		} else {
//			list = columnBiz.queryColumnChildListRecursionByWebsiteId(categoryId, websiteId);
//		}

		
		//栏目链接标签拼接字符串
		request.setAttribute("columnRegexConstant", IParserRegexConstant.HTML_SAVE_PATH+File.separator+websiteId);
		
		request.setAttribute("listColumn", JSONArray.toJSONString(list));
		return "/manager/cms/column/column_list";
	}

	/**
	 * 子栏目列表显示
	 */
	@RequestMapping("/{categoryId}/childList")
	public void childList(@PathVariable int categoryId,HttpServletResponse response, HttpServletRequest request) {
		
		// 站点ID有session获取
		int websiteId =this.getAppId(request);
		// 需要打开的栏目节点树的栏目ID
		List<ColumnEntity> list = new ArrayList<ColumnEntity>();

		list = columnBiz.queryChild(categoryId, websiteId,this.getModelCodeId(request));

		response.setCharacterEncoding("utf-8");
		this.outJson(response, ModelCode.CMS_COLUMN, true, "", JSONObject.toJSON(list).toString());
	}
	/**
	 * 根据栏目ID删除栏目记录
	 * 
	 * @param request
	 * @return 重定向
	 */
	@RequestMapping("/{categoryId}/delete")
	public void delete(@PathVariable int categoryId,
			HttpServletResponse response, HttpServletRequest request) {
		
		// 站点ID有session获取
		int websiteId = this.getAppId(request);
		// 查询该栏目是否有子栏目,如果存在子栏目则返回错误提示，否则删除该栏目
		if (columnBiz.queryChild(categoryId, websiteId,this.getModelCodeId(request)).size() > 0) {
			this.outJson(response, ModelCode.CMS_COLUMN, true, "false");
		} else {
			columnBiz.deleteCategory(categoryId);
			this.outJson(response, ModelCode.CMS_COLUMN, true, "true");
		}
	}
	/**
	 * 根据栏目ID进行栏目删除确认，如果有子栏目则不能被删除
	 * @param categoryId 栏目ID
	 * @param response
	 * @param request
	 */
	@RequestMapping("/{categoryId}/deleteConfirm")
	public void deleteConfirm(@PathVariable int categoryId,
			HttpServletResponse response, HttpServletRequest request){
		// 站点ID有session获取
				int websiteId = this.getAppId(request);
				// 查询该栏目是否有子栏目,如果存在子栏目则返回错误提示，否则删除该栏目
				if (columnBiz.queryColumnChildListCountByWebsiteId(categoryId, websiteId) > 0) {
					this.outJson(response, ModelCode.CMS_COLUMN, true, "false");
				} else {
					this.outJson(response, ModelCode.CMS_COLUMN, true, "true");
				}
	}
	
	/**
	 * 栏目路径
	 * @param column 栏目实体
	 */
	public void columnPath(HttpServletRequest request,ColumnEntity column){
		String columnPath = "";
		String file = this.getRealPath(request,null)+IParserRegexConstant.HTML_SAVE_PATH+File.separator+ column.getColumnWebsiteId();
		String delFile = "";
		//修改栏目路径时，删除已存在的文件夹
		column = (ColumnEntity) columnBiz.getEntity(column.getCategoryId());
		delFile = file + column.getColumnPath();
		if(!StringUtil.isBlank(delFile)){
			File delFileName = new File(delFile);
			delFileName.delete();
		}
		//若为顶级栏目，则路径为：/+栏目ID
		if(column.getCategoryCategoryId() == 0){
			column.setColumnPath(File.separator+column.getCategoryId());
			file = file + File.separator + column.getCategoryId();
		} else {
			List<ColumnEntity> list = columnBiz.queryParentColumnByColumnId(column.getCategoryId());
			if(!StringUtil.isBlank(list)){
				String temp = "";
				for(int i = list.size()-1; i>=0; i--){
					ColumnEntity entity = list.get(i);
					columnPath = columnPath + File.separator + entity.getCategoryId();
					temp = temp + File.separator + entity.getCategoryId();
				}
				column.setColumnPath(columnPath + File.separator + column.getCategoryId());
				file = file + temp + File.separator + column.getCategoryId();
			}
		}
		columnBiz.updateEntity(column);
		//生成文件夹
		File fileName = new File(file);
        fileName.mkdir();
	}
	
	/**
	 * 栏目更新
	 * 
	 * @param column
	 *            栏目实体
	 * @return 重定向
	 */
	@RequestMapping("/update")
	public void update(@ModelAttribute ColumnEntity column,
			HttpServletRequest request,HttpServletResponse response) {
		
		if(!checkForm(column,response)){
			return;
		}
		if(column.getColumnType()==ColumnTypeEnum.COLUMN_TYPE_COVER.toInt()){
			column.setColumnListUrl(null);
		}
		column.setCategoryManagerId(getManagerBySession(request).getManagerId());
		column.setColumnWebsiteId(this.getAppId(request));
		columnBiz.updateCategory(column);
		this.columnPath(request,column);
		this.outJson(response, ModelCode.CMS_COLUMN, true,null,JSONArray.toJSONString(column.getCategoryId()));
	
	}

	/**
	 * 栏目更新页面跳转
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/{columnId}/edit")
	public String edit(@PathVariable int columnId, HttpServletRequest request,ModelMap model) {
		// 获取管理实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		// 站点ID
		int appId = this.getAppId(request);
		List<ColumnEntity> list = new ArrayList<ColumnEntity>();
		// 判断管理员权限,查询其管理的栏目集合
		list = columnBiz.queryAll(appId, this.getModelCodeId(request));

		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(columnId);
		// 查询属于当前管理员的内容模型
		List<BaseEntity> listCm = contentModelBiz.queryByManagerId(managerSession.getManagerId());
		model.addAttribute("column", column);
		model.addAttribute("columnc", column.getCategoryId());
		model.addAttribute("listCm", listCm);
		ColumnEntity columnSuper = new ColumnEntity();
		// 获取父栏目对象
		if (column.getCategoryCategoryId() != Const.COLUMN_TOP_CATEGORY_ID) {
			columnSuper = (ColumnEntity) columnBiz.getEntity(column.getCategoryCategoryId());
		}
		model.addAttribute("columnSuper", columnSuper);
		model.addAttribute("listColumn", JSONObject.toJSON(list).toString());
		return "/manager/cms/column/column";
	}

	/**
	 * 查询全部栏目集合 使用queryJsonAll替代
	 * 
	 * @param response
	 */
	@Deprecated
	@RequestMapping("/columnList")
	public void columnList(HttpServletResponse response,
			HttpServletRequest request) {
		
		// 该站点ID有session提供
		int websiteId = this.getAppId(request);
		List<ColumnEntity> list  = columnBiz.queryColumnListByWebsiteId(websiteId);
		response.setCharacterEncoding("utf-8");
		this.outJson(response, ModelCode.CMS_COLUMN, true, "", JSONObject.toJSON(list).toString());
	}
	
	@RequestMapping("/queryJsonAll")
	public void queryJsonAll(HttpServletResponse response,
			HttpServletRequest request) {
		
		// 该站点ID有session提供
		int websiteId =  this.getAppId(request);
		Integer modelId = modelBiz.getEntityByModelCode(ModelCode.CMS_COLUMN).getModelId(); // 查询当前模块编号
		//获取所有的内容管理栏目
		List<ColumnEntity> list  = columnBiz.queryAll(websiteId,modelId);
		response.setCharacterEncoding("utf-8");
		this.outJson(response, ModelCode.CMS_COLUMN, true, "", JSONObject.toJSON(list).toString());
	}
	
	
	/**
	 * 后台验证填写的栏目信息是否合法
	 * @param column  栏目信息
	 * @param response
	 * @return false:不合法 true:合法
	 */
	private boolean checkForm(ColumnEntity column, HttpServletResponse response){
		

			//栏目标题空值验证
			if(StringUtil.isBlank(column.getCategoryTitle())){
				this.outJson( response, ModelCode.CMS_COLUMN, false, getResString("err.empty", this.getResString("categoryTitle")));
				return false;
			}
			//栏目标题长度验证
			if(!StringUtil.checkLength(column.getCategoryTitle(), 1, 31)){
				this.outJson( response, ModelCode.CMS_COLUMN, false, getResString("err.length", this.getResString("categoryTitle"), "1", "30"));
				return false;
			}
			//栏目属性空值验证
			if(StringUtil.isBlank(column.getColumnType())){
				this.outJson( response, ModelCode.CMS_COLUMN, false, getResString("err.empty", this.getResString("columnType")));
				return false;
			}
			//栏目描述处理
			if(StringUtil.checkLength(column.getColumnDescrip(), 0, 500)){
				column.setColumnDescrip(StringUtil.subString(column.getColumnDescrip(), 500));
			}
			//栏目简介处理
			if(StringUtil.checkLength(column.getColumnKeyword(), 0, 500)){
				column.setColumnKeyword(StringUtil.subString(column.getColumnKeyword(), 500));
			}
			
			return true;
	}

}
