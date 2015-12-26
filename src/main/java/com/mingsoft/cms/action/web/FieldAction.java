package com.mingsoft.cms.action.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.cms.biz.IColumnBiz;
import com.mingsoft.cms.biz.IContentModelBiz;
import com.mingsoft.cms.biz.IFieldBiz;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.cms.entity.ContentModelEntity;
import com.mingsoft.cms.entity.FieldEntity;

/**
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 *
 * @author 史爱华
 *
 * <p>
 * Comments: 供前端页面获取自定义模型中字段实体信息
 * </p>
 *
 * <p>
 * Create Date:2015-07-11
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Controller("webField")
@RequestMapping("/field")
public class FieldAction extends BaseAction{
	
	/**
	 * 栏目业务层
	 */
	@Autowired
	private IColumnBiz columnBiz;
	
	/**
	 * 内容模型业务层
	 */
	@Autowired
	private IContentModelBiz contentModelBiz;
	
	/**
	 * 字段管理业务层
	 */
	@Autowired
	private IFieldBiz fieldBiz;
	
	/**
	 * 
	 * 根据当前栏目id和字段名称获取自定义模型中的字段实体信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{columId}/getEntity")
	@ResponseBody
	public void getEntity(@PathVariable int columId,HttpServletRequest request, HttpServletResponse response) {
		//获取字段名称
		String fieldFieldName = request.getParameter("fieldFieldName");
		//根据栏目id获取栏目实体
		ColumnEntity column = (ColumnEntity) this.columnBiz.getEntity(columId);
		if(column==null){
			this.outJson(response, this.getResString("err"));
			return;
		}else{
			//判断该栏目下是存在内容模型
			if(column.getColumnContentModelId()>0){
				//获取当前栏目对应的内容模型
				ContentModelEntity contentModel = (ContentModelEntity) this.contentModelBiz.getEntity(column.getColumnContentModelId());
				if(contentModel==null){
					this.outJson(response, this.getResString("err"));
					return;
				}
				//获取字段实体
				FieldEntity field = fieldBiz.getEntityByCmId(column.getColumnContentModelId(), fieldFieldName);
				//返回字段实体
				this.outJson(response, JSONObject.toJSONString(field));
			}
		}
		
	}
}
