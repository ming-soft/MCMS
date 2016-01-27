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


import com.mingsoft.base.constant.e.TableCloumnEnum;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.constant.e.ContentModelFieldEnum;
import com.mingsoft.basic.constant.e.FieldSearchEnum;

/**
 * 
 * ms-basic 自定义模型字段
 * 
 * @author 会飞的猪
 * @version 版本号：<br/>
 *          创建日期：2016年1月15日<br/>
 *          历史修订：<br/>
 */
public class ContentModelFieldEntity extends BaseEntity {

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
	 * 字段类型(如：1单行文本 2多行文本...)
	 */
	private int fieldType;

	/**
	 * 字段对应的字段类型中文名称
	 */
	private String fieldTypeString;

	/**
	 * 字段的默认值
	 */
	private String fieldDefault;

	/**
	 * 绑定内容模型表ID
	 */
	private int fieldCmid;

	/**
	 * 判断字段为必填还是可选 0:必填 1:可选
	 */
	private int fieldIsNull;

	/**
	 * 判断字段是否支持搜索
	 */
	private int fieldIsSearch;

	/**
	 * 字段长度
	 */
	private int fieldLength = 1;

	public String getFieldTypeString() {
		return ContentModelFieldEnum.get(this.getFieldType()).toString();
	}

	public void setFieldTypeString(String fieldTypeString) {
		this.fieldTypeString = fieldTypeString;
	}

	public int getFieldLength() {
		return fieldLength;
	}

	public void setFieldLength(int fieldLength) {
		if (this.fieldLength <= 0) {
			this.fieldLength = 11;
		} else {
			this.fieldLength = fieldLength;
		}
	}

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

	public void setFieldIsSearch(FieldSearchEnum fieldIsSearch) {
		this.fieldIsSearch = fieldIsSearch.toInt();
	}

	/**
	 * 获取fieldId
	 * 
	 * @return fieldId
	 */
	public int getFieldId() {
		return fieldId;
	}

	/**
	 * 设置fieldId
	 * 
	 * @param fieldId
	 */
	public void setFieldId(int fieldId) {
		this.fieldId = fieldId;
	}

	/**
	 * 获取fieldTipsName
	 * 
	 * @return fieldTipsName
	 */
	public String getFieldTipsName() {
		return fieldTipsName;
	}

	/**
	 * 设置fieldTipsName
	 * 
	 * @param fieldTipsName
	 */
	public void setFieldTipsName(String fieldTipsName) {
		this.fieldTipsName = fieldTipsName;
	}

	/**
	 * 获取fieldFieldName
	 * 
	 * @return fieldFieldName
	 */
	public String getFieldFieldName() {
		return fieldFieldName;
	}

	/**
	 * 设置fieldFieldName
	 * 
	 * @param fieldFieldName
	 */
	public void setFieldFieldName(String fieldFieldName) {
		this.fieldFieldName = fieldFieldName;
	}

	/**
	 * 获取fieldType
	 * 
	 * @return fieldType
	 */
	public int getFieldType() {
		return fieldType;
	}

	public String getFieldColumnType() {
		// 1=单行文本(varchar)
		// 2=多行文本
		// 3=HTML文本
		// 4=整数类型
		// 5=小数类型
		// 6=时间类型
		// 7=图片
		// 8=附件类型
		// 9=使用option下拉框
		// 10=使用radio选项卡
		// 11=Checkbox多选框
		if (this.getFieldType() == ContentModelFieldEnum.DATE.toInt()) {
			return TableCloumnEnum.DATETIME.toString();
		} else if (this.getFieldType() == ContentModelFieldEnum.FLOAT.toInt()) {
			return TableCloumnEnum.FLOAT.toString() + "(10)";
		} else if (this.getFieldType() == ContentModelFieldEnum.INT.toInt()) {
			return TableCloumnEnum.INT.toString() + "(11)";
		} else if (this.getFieldType() == ContentModelFieldEnum.HTML.toInt()) {
			return TableCloumnEnum.TEXT.toString();
		} else {
			return TableCloumnEnum.VARCHAR.toString() + "(225)";
		}

	}

	/**
	 * 设置fieldType
	 * 
	 * @param fieldType
	 */
	public void setFieldType(int fieldType) {
		this.fieldType = fieldType;
	}

	/**
	 * 获取fieldCmid
	 * 
	 * @return fieldCmid
	 */
	public int getFieldCmid() {
		return fieldCmid;
	}

	/**
	 * 设置fieldCmid
	 * 
	 * @param fieldCmid
	 */
	public void setFieldCmid(int fieldCmid) {
		this.fieldCmid = fieldCmid;
	}

	/**
	 * 设置字段的默认值
	 * 
	 * @return
	 */
	public String getFieldDefault() {
		if (this.fieldType == ContentModelFieldEnum.DATE.toInt()
				|| this.fieldType == ContentModelFieldEnum.HTML.toInt()) {
			return null;
		}

		if (fieldDefault == null || fieldDefault.length() == 0) {
			return null;
		}
		return fieldDefault;
	}

	/**
	 * 获取字段的默认值
	 * 
	 * @param fieldDefault
	 */
	public void setFieldDefault(String fieldDefault) {
		this.fieldDefault = fieldDefault;
	}

	/**
	 * 获取字段是否是可选
	 * 
	 * @return
	 */
	public int getFieldIsNull() {
		return fieldIsNull;
	}

	/**
	 * 设置字段是否是可选
	 * 
	 * @return
	 */
	public void setFieldIsNull(int fieldIsNull) {
		this.fieldIsNull = fieldIsNull;
	}

}