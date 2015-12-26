package com.mingsoft.cms.action;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
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

import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.cms.biz.IContentModelBiz;
import com.mingsoft.cms.biz.IFieldBiz;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.cms.entity.ContentModelEntity;
import com.mingsoft.cms.entity.FieldEntity;
import com.mingsoft.base.constant.CookieConst;
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
 * Comments:字段管理控制层，继承BasicAction
 * </p>
 *  
 * <p>
 * Create Date:2014-9-12
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Controller
@RequestMapping("/manager/cms/field/")
public class FieldAction extends BaseAction{
	
	/**
	 * 字段业务层
	 */
	@Autowired
	private IFieldBiz fieldBiz;
	
	/**
	 * 内容模型业务层
	 */
	@Autowired
	private IContentModelBiz contentModelBiz;
	
	/**
	 * option 选择框
	 */
	private final static int OPTION=9;
	
	/**
	 * radio 选择按钮
	 */
	private final static int RADIO=10;
	
	/**
	 * checkbox 多选框
	 */
	private final static int CHECKBOX = 11;
	
	/**
	 * 栏目业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;
	
	/**
	 * 表单列表路径
	 */
	private final static String PAGE_URL="/manager/cms/field/list.do";
	
	/**
	 * 获取字段属性
	 * @return
	 */
	public Map<Integer,String> getfieldType(){
		Map<String,String> maps = new LinkedHashMap<String,String>(); 
		maps = getMapByProperties("com/mingsoft/cms/resources/field_type");
		Map<Integer,String> fieldType= new LinkedHashMap<Integer,String>();
		Map<Integer,String> map= new LinkedHashMap<Integer,String>();
		for(Entry<String, String> entry : maps.entrySet()){
			map.put(Integer.valueOf(entry.getKey()), entry.getValue());
		}
		for(int i=1; i<=maps.size(); i++){
			fieldType.put(i, map.get(i));
		}
        return fieldType;
	}
	
	
	/**
	 * 查询指定表单所有的自定义字段
	 * @param cmId 表单ID
	 * @param request 请求
	 * @param model
	 * @param response 响应
	 */
	@RequestMapping("/list")
	@ResponseBody
	public Map list(int cmId,HttpServletRequest request, HttpServletResponse response){
		Map model = new HashMap();
		String pageNo = request.getParameter("pageNo");
		if (!StringUtil.isInteger(pageNo)) {
			pageNo = "1";
		}
		int recordCount = fieldBiz.queryCountByCmid(cmId);
		PageUtil page = new PageUtil(StringUtil.string2Int(pageNo),recordCount, recordCount, PAGE_URL);
		this.setCookie(request, response, CookieConst.PAGENO_COOKIE, pageNo);
		//当前表单的所有自定义字段
		List<BaseEntity> fieldList = fieldBiz.queryByPage(cmId, page, "FIELD_ID", false);
		model.put("fieldList", fieldList);
		//获取字段属性
		Map<Integer,String> fieldType = this.getfieldType();
		model.put("fieldType",fieldType);
		model.put("page",page);
		model.put("fieldNum",fieldType.size());
		if(cmId == 0){
			model.put("flag", true);
		} else {
			model.put("flag", false);
		}
		model.put("cmId", cmId);
		return model;
		
	}
	
	
	
	
	/**
	 * 删除自定义字段
	 * @param cmId 表单ID
	 * @param request 请求
	 * @param response 响应
	 */
	@RequestMapping("/{fieldId}/delete")
	@ResponseBody
	public int delete(@PathVariable int fieldId, HttpServletRequest request) {
		int pageNo = 1;
		if (fieldId != 0) {
			//获取要删除的字段实体
			FieldEntity field = (FieldEntity) fieldBiz.getEntity(fieldId);
			fieldBiz.deleteEntity(fieldId);
			//获取内容模型实体
			ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(field.getFieldCmid());
			if(contentModel != null){
				Map fields = new HashMap();
				// 要删除的字段名
				fields.put("fieldName",field.getFieldFieldName());
				//删除列
				fieldBiz.alterTable(contentModel.getCmTableName(),fields,"drop");
			}
			//判断当前页码
			this.getHistoryPageNoByCookie(request);
		}
		return pageNo;
	}
	
	/**
	 * 保存字段数据到数据库
	 * @param field  要保存的字段实体
	 * @param request
	 * @param response 
	 */
	@RequestMapping("/{cmTableName}/save")
	@ResponseBody
	public void save(@ModelAttribute FieldEntity field,@PathVariable String cmTableName, HttpServletResponse response) {
		// 判断是否存在表单
		ContentModelEntity contentModel = contentModelBiz.getContentModelByTableName(cmTableName);
		int cmId = contentModel.getCmId();
		field.setFieldCmid(cmId);
		// 更新前判断数据是否合法
		if(!StringUtil.checkLength(field.getFieldTipsName(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("fieldTipsName"),"1","30"));
			return ;
		}
		if(!StringUtil.checkLength(field.getFieldFieldName(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("fieldFieldName"),"1","30"));
			return ;
		}
		fieldBiz.saveEntity(field);
		//读取属性配置文件
		Map<String,String> maps = new LinkedHashMap<String,String>(); 
		maps = getMapByProperties("com/mingsoft/cms/resources/field_dataType");
		//动态的修改表结构
		//获取字段信息
		Map fileds = new HashMap();
		//压入字段名
		fileds.put("fieldName", field.getFieldFieldName());
		//字段的数据类型
		fileds.put("fieldType",maps.get(String.valueOf(field.getFieldType())));
		//字段的默认值
		//判断该字段是否为checkBox或option或为raido，
		if(field.getFieldType()==OPTION||field.getFieldType()==RADIO||field.getFieldType()==CHECKBOX){
			fileds.put("default",0);
		}else{
			fileds.put("default", field.getFieldDefault());
		}
		
		fieldBiz.alterTable(contentModel.getCmTableName(), fileds,"add");
		this.outJson(response, null, true, null);
	}
	
	/**
	 * 获取编辑的字段实体的信息
	 * @param mode 
	 * @param fieldId :要获取的字段实体的id
	 * @param request
	 * @return
	 */
	@RequestMapping("/{fieldId}/edit")
	@ResponseBody
	public Map edit(@PathVariable int fieldId, HttpServletRequest request){
		Map model = new HashMap();
		FieldEntity field = (FieldEntity) fieldBiz.getEntity(fieldId);
		model.put("field", field);
		return model;
	}
	
	/**
	 * 更新字段信息
	 * @param field 要更新的字段信息的id
	 * @param response 
	 */

	@RequestMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute FieldEntity field, HttpServletResponse response){
		
		// 更新前判断数据是否合法
		if(!StringUtil.checkLength(field.getFieldTipsName(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("fieldTipsName"),"1","30"));
			return ;
		}
		if(!StringUtil.checkLength(field.getFieldFieldName(), 1,30)){
			this.outJson(response,null, false,getResString("err.length",this.getResString("fieldFieldName"),"1","30"));
			return ;
		}
		//获取内容模型实体
		ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(field.getFieldCmid());
		//读取属性配置文件
		Map<String,String> maps = new LinkedHashMap<String,String>(); 
		maps = getMapByProperties("com/mingsoft/cms/resources/field_dataType");
		// 获取更改前的字段实体
		FieldEntity oldField =(FieldEntity) fieldBiz.getEntity(field.getFieldId());
		fieldBiz.updateEntity(field);
		Map fields = new HashMap();
		//更改前的字段名
		fields.put("fieldOldName", oldField.getFieldFieldName());
		//新字段名
		fields.put("fieldName", field.getFieldFieldName());
		//判断该字段是否为checkBox或option或为raido,如果是则默认值为0
		if(field.getFieldType()==OPTION||field.getFieldType()==RADIO||field.getFieldType()==CHECKBOX){
				fields.put("default",0);
		}else{
				fields.put("default", field.getFieldDefault());
		}
		//字段的数据类型
		fields.put("fieldType", maps.get(String.valueOf(field.getFieldType())));
		if(contentModel!=null){
			// 更新表的字段名
			fieldBiz.alterTable(contentModel.getCmTableName(), fields, "modify");
		}
		this.outJson(response,null, true, null);
	}
	
	/**
	 * 判断字段名是否存在重复
	 * @param fieldFieldName :字段名
	 * @param request
	 * @return true:存在重复,false:不存在重复
	 */
	@RequestMapping("/{fieldFieldName}/checkFieldNameExist")
	@ResponseBody
	public boolean checkFieldNameExist(@PathVariable String fieldFieldName, HttpServletRequest request){
		int fieldCmId = 1;
		if(request.getParameter("fieldCmId")!=null){
			fieldCmId =Integer.parseInt(request.getParameter("fieldCmId"));
		}
		if(fieldBiz.getCountFieldName(fieldFieldName, fieldCmId)>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 返回自定义模型的html模板（适用于商城模块）
	 * @param columnId
	 * @param model
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/{columnId}/queryFieldList")
	public String queryFieldList(@PathVariable int columnId,ModelMap model, HttpServletRequest request){
		// 获取栏目信息
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(columnId);
		if(column!=null){
			//获取表单类型的id
			int fieldCmid = column.getColumnContentModelId();
			// 根据表单类型id查找出所有的字段信息
			List<BaseEntity> listField = fieldBiz.queryListByCmid(fieldCmid);
			int basicId = 0;
			if(request.getParameter("basicId")!=null){
				basicId =StringUtil.string2Int( request.getParameter("basicId"));
			}
			
			if(basicId != 0){
				//根据表单id查找内容模型
				ContentModelEntity contentModel= (ContentModelEntity) contentModelBiz.getEntity(fieldCmid);
				// 判断内容模型是否存在
				if(contentModel != null){
					//遍历所有的字段实体,得到字段名列表信息
					List<String> listFieldName = new ArrayList<String>();
					
					for(int i = 0;i<listField.size();i++){
						FieldEntity field = (FieldEntity) listField.get(i);
						listFieldName.add(field.getFieldFieldName());
					}
					// 组织where条件
					Map<String, Integer> where = new HashMap<String, Integer>();
					where.put("basicId", basicId);
					// 获取各字段的值
					List fieldLists = fieldBiz.queryBySQL(contentModel.getCmTableName(), listFieldName, where);
					if (fieldLists != null && fieldLists.size()>0) {
						Map filedValue = (Map)fieldLists.get(0);
						model.addAttribute("filedValue",filedValue);
					}
				}
			}
			model.addAttribute("listField",listField);
			model.addAttribute("appid",this.getAppId(request));
		}
		return "manager/cms/article/article_fields";
	}
	
	/**
	 * 返回cms模块的自定义模型的html页面（适用于cms模块）
	 * @param columnId
	 * @param model
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/{columnId}/queryField")
	public String queryField(@PathVariable int columnId,ModelMap model, HttpServletRequest request){
		// 获取栏目信息
		ColumnEntity column = (ColumnEntity) columnBiz.getEntity(columnId);
		if(column!=null){
			//获取表单类型的id
			int fieldCmid = column.getColumnContentModelId();
			// 根据表单类型id查找出所有的字段信息
			List<BaseEntity> listField = fieldBiz.queryListByCmid(fieldCmid);
			int basicId = 0;
			if(request.getParameter("basicId")!=null){
				basicId =StringUtil.string2Int( request.getParameter("basicId"));
			}
			
			if(basicId != 0){
				//根据表单id查找内容模型
				ContentModelEntity contentModel= (ContentModelEntity) contentModelBiz.getEntity(fieldCmid);
				// 判断内容模型是否存在
				if(contentModel != null){
					//遍历所有的字段实体,得到字段名列表信息
					List<String> listFieldName = new ArrayList<String>();
					
					for(int i = 0;i<listField.size();i++){
						FieldEntity field = (FieldEntity) listField.get(i);
						listFieldName.add(field.getFieldFieldName());
					}
					// 组织where条件
					Map<String, Integer> where = new HashMap<String, Integer>();
					where.put("basicId", basicId);
					// 获取各字段的值
					List fieldLists = fieldBiz.queryBySQL(contentModel.getCmTableName(), listFieldName, where);
					if (fieldLists != null && fieldLists.size()>0) {
						Map filedValue = (Map)fieldLists.get(0);
						model.addAttribute("filedValue",filedValue);
					}
				}
			}
			model.addAttribute("listField",listField);
			model.addAttribute("appid",this.getAppId(request));
		}
		return "manager/cms/article/article_cms_fields";
	}
}

