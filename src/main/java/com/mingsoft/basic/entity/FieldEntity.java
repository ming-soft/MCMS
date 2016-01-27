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

package com.mingsoft.basic.entity;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.constant.e.FieldSearchEnum;

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
 * Comments:表单类型字段实体，继承BasicEntity
 * </p>
 *  
 * <p>
 * Create Date:2014-9-11
 * </p>
 *
 * <p>
 * Modification history:暂无
 * </p>
 */
public class FieldEntity extends BaseEntity{

	/**
	 * 自增长ID
	 */
	private int fieldId;
	
	/**
	 * 字段提示文字
	 */
	private String fieldTipsName;
	
	/**
	 * 字段名称
	 */
	private String fieldFieldName;
	
	/**
	 * 字段类型(如：1单行文本   2多行文本...)
	 */
	private int fieldType;
	
	/**
	 * 字段的默认值
	 */
	private String fieldDefault;
	
	/**
	 * 绑定内容模型表ID
	 */
	private int fieldCmid;
	
	/**
	 * 判断字段为必填还是可选
	 * 0:必填
	 * 1:可选
	 */
	private int fieldIsNull;
	
	/**
	 * 判断字段是否支持搜索
	 */
	private int fieldIsSearch;
	
	
	
	/**
	 * 
	 * @return
	 */
	public int getFieldIsSearch() {
		return fieldIsSearch;
	}
	
	/**
	 * 
	 * @param fieldIsSearch
	 */
	@Deprecated
	public void setFieldIsSearch(int fieldIsSearch) {
		this.fieldIsSearch = fieldIsSearch;
	}
	
	public void setFieldIsSearch(FieldSearchEnum fieldIsSearch){
		this.fieldIsSearch = fieldIsSearch.toInt();
	}

	/**
	 * 获取fieldId
	 * @return fieldId
	 */
	public int getFieldId() {
		return fieldId;
	}

	/**
	 * 设置fieldId
	 * @param fieldId
	 */
	public void setFieldId(int fieldId) {
		this.fieldId = fieldId;
	}

	/**
	 * 获取fieldTipsName
	 * @return fieldTipsName
	 */
	public String getFieldTipsName() {
		return fieldTipsName;
	}

	/**
	 * 设置fieldTipsName
	 * @param fieldTipsName
	 */
	public void setFieldTipsName(String fieldTipsName) {
		this.fieldTipsName = fieldTipsName;
	}

	/**
	 * 获取fieldFieldName
	 * @return fieldFieldName
	 */
	public String getFieldFieldName() {
		return fieldFieldName;
	}

	/**
	 * 设置fieldFieldName
	 * @param fieldFieldName
	 */
	public void setFieldFieldName(String fieldFieldName) {
		this.fieldFieldName = fieldFieldName;
	}

	/**
	 * 获取fieldType
	 * @return fieldType
	 */
	public int getFieldType() {
		return fieldType;
	}

	/**
	 * 设置fieldType
	 * @param fieldType
	 */
	public void setFieldType(int fieldType) {
		this.fieldType = fieldType;
	}

	/**
	 * 获取fieldCmid
	 * @return fieldCmid
	 */
	public int getFieldCmid() {
		return fieldCmid;
	}

	/**
	 * 设置fieldCmid
	 * @param fieldCmid
	 */
	public void setFieldCmid(int fieldCmid) {
		this.fieldCmid = fieldCmid;
	}
	
	/**
	 * 设置字段的默认值
	 * @return
	 */
	public String getFieldDefault() {
		return fieldDefault;
	}
	
	/**
	 * 获取字段的默认值
	 * @param fieldDefault
	 */
	public void setFieldDefault(String fieldDefault) {
		this.fieldDefault = fieldDefault;
	}
	
	/**
	 * 获取字段是否是可选
	 * @return
	 */
	public int getFieldIsNull() {
		return fieldIsNull;
	}
	
	/**
	 * 设置字段是否是可选
	 * @return
	 */
	public void setFieldIsNull(int fieldIsNull) {
		this.fieldIsNull = fieldIsNull;
	}
	
	
}