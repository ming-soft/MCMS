/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import net.mingsoft.basic.biz.IColumnBiz;
import net.mingsoft.mdiy.biz.IContentModelBiz;
import net.mingsoft.mdiy.biz.IContentModelFieldBiz;
import net.mingsoft.basic.entity.ColumnEntity;
import net.mingsoft.mdiy.entity.ContentModelEntity;
import net.mingsoft.mdiy.entity.ContentModelFieldEntity;

import net.mingsoft.base.action.BaseAction;
import net.mingsoft.basic.util.BasicUtil;

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
	private IContentModelFieldBiz fieldBiz;
	
	/**
	 * 
	 * 根据当前栏目id和字段名称获取自定义模型中的字段实体信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{columId}/getEntity")
	@ResponseBody
	public void getEntity(@PathVariable int columId,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("111");
		BasicUtil.setSession("xxx", "888");
		System.err.println("session:"+BasicUtil.getSession("xxx"));
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
				ContentModelFieldEntity field = fieldBiz.getEntityByCmId(column.getColumnContentModelId(), fieldFieldName);
				//返回字段实体
				this.outJson(response, JSONObject.toJSONString(field));
			}
		}
		
	}
}