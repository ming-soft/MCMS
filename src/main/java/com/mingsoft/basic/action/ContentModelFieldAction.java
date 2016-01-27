/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

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

package com.mingsoft.basic.action;

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

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.e.TableCloumnEnum;
import com.mingsoft.base.constant.e.TableEnum;
import com.mingsoft.basic.biz.IContentModelBiz;
import com.mingsoft.basic.biz.IContentModelFieldBiz;
import com.mingsoft.basic.constant.e.ContentModelFieldEnum;
import com.mingsoft.basic.entity.ContentModelEntity;
import com.mingsoft.basic.entity.ContentModelFieldEntity;
import com.mingsoft.basic.entity.FieldEntity;
import com.mingsoft.util.StringUtil;

/**
 * 
 * ms-basic 自定义模型字段
 * 
 * @author 会飞的猪
 * @version 版本号：<br/>
 *          创建日期：2016年1月15日<br/>
 *          历史修订：<br/>
 */
@Controller
@RequestMapping("/manager/contentModel/contentModelField")
public class ContentModelFieldAction extends com.mingsoft.basic.action.BaseAction {

	@Autowired
	private IContentModelFieldBiz contentModelFieldBiz;

	@Autowired
	private IContentModelBiz contentModelBiz;

	/**
	 * 表单列表
	 * 
	 * @return 返回表单列表页面
	 */
	@RequestMapping("/{contentModelId}/list")
	public String list(@PathVariable int contentModelId, HttpServletRequest request, ModelMap model,
			HttpServletResponse response) {
		
		List list = contentModelFieldBiz.queryListByCmid(contentModelId);
		// 获取字段属性
		model.put("fieldTypes", ContentModelFieldEnum.toMap());
		model.put("contentModelId", contentModelId);
		model.addAttribute("contentModelFieldList", list);
		return "/manager/content_model/content_model_field_list";
	}

	/**
	 * 保存内容模型实体
	 * 
	 * @param contentModel
	 * @param response
	 */
	@RequestMapping("/save")
	@ResponseBody
	public void save(@ModelAttribute ContentModelFieldEntity field, HttpServletRequest request,
			HttpServletResponse response) {
		// 判断是否存在表单
		ContentModelEntity contentModel = (ContentModelEntity)contentModelBiz.getEntity(field.getFieldCmid());
		// 更新前判断数据是否合法
		if(!StringUtil.checkLength(field.getFieldTipsName(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("content.model.field.tips.name"),"1","30"));
			return ;
		}
		if(!StringUtil.checkLength(field.getFieldFieldName(), 1,30)){
			this.outJson(response, null, false,getResString("err.length",this.getResString("content.model.field.column.ame"),"1","30"));
			return ;
		}
		
		if (contentModelFieldBiz.getEntityByCmId(field.getFieldCmid(),field.getFieldFieldName())!=null) {
			this.outJson(response, null, false,getResString("err.exist",this.getResString("content.model.field")));
			return;
		}
		
		contentModelFieldBiz.saveEntity(field);
		//动态的修改表结构
		//获取字段信息
		Map fileds = new HashMap();
		//压入字段名
		fileds.put("fieldName", field.getFieldFieldName());
		//字段的数据类型
		fileds.put("fieldType",field.getFieldColumnType());
		//字段的默认值
		fileds.put("default", field.getFieldDefault());
		
		contentModelFieldBiz.alterTable(contentModel.getCmTableName(), fileds,TableEnum.ALTER_ADD);
		this.outJson(response, null, true, null);
	}

	/**
	 * 删除表单类型
	 * 
	 * @param cmId
	 *            表单ID
	 * @param request
	 *            请求
	 * @param response
	 *            响应
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public void delete(HttpServletRequest request, HttpServletResponse response) {
		String fieldIds = request.getParameter("fieldId");
		if (!StringUtil.isBlank(fieldIds) && StringUtil.isIntegers(fieldIds.split(","))) {
			int[] ids = StringUtil.stringsToInts(fieldIds.split(","));
			for (int i=0;i<ids.length;i++) {
				//获取要删除的字段实体
				ContentModelFieldEntity field = (ContentModelFieldEntity) contentModelFieldBiz.getEntity(ids[i]);
				contentModelFieldBiz.deleteEntity(ids[i]);
				//获取内容模型实体
				ContentModelEntity contentModel = (ContentModelEntity) contentModelBiz.getEntity(field.getFieldCmid());
				if(contentModel != null){
					Map<String,Object> fields = new HashMap<String, Object>();
					// 要删除的字段名
					fields.put("fieldName",field.getFieldFieldName());
					//删除列
					contentModelFieldBiz.alterTable(contentModel.getCmTableName(),fields,TableEnum.ALTER_DROP);
				}
			}
			this.outJson(response, true);
		}
	}

	/**
	 * 编辑表单
	 * 
	 * @param cmId
	 *            表单ID
	 * @return 编辑表单页面
	 */
	@RequestMapping("/{filedId}/edit")
	@ResponseBody
	public void edit(@PathVariable int filedId,HttpServletResponse response) {
		// 获取表单实体
		ContentModelFieldEntity contentModelField = (ContentModelFieldEntity) contentModelFieldBiz.getEntity(filedId);
		this.outJson(response, contentModelField);
	}

	/**
	 * 更新内容模型实体
	 * 
	 * @param contentModel
	 *            内容模型实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute ContentModelFieldEntity contentModelFieldEntity, HttpServletRequest request,
			HttpServletResponse response) {
		contentModelFieldBiz.updateEntity(contentModelFieldEntity);
		this.outJson(response, true);
	}
}