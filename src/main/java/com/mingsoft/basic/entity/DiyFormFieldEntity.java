package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.constant.e.DiyFormFieldEnum;

/**
 * 自定义表单字段
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class DiyFormFieldEntity extends BaseEntity{
	/**
	 * 字段的默认值
	 */
	private String diyFormFieldDefault;
	
	/**
	 * 字段名称
	 */
	private String diyFormFieldFieldName;
	
	/**
	 * 对应的自定义from的id
	 */
	private int diyFormFieldFormId;
	
	/**
	 * 自增长ID
	 */
	private int diyFormFieldId;
	
	/**
	 * 判断字段为必填还是可选
	 * 参考：DiyFormFieldEnum.IS_NULL
	 */
	private int diyFormFieldIsNull;
	
	/**
	 * 排序
	 */
	private int diyFormFieldSort;
	
	/**
	 * 字段提示文字
	 */
	private String diyFormFieldTipsName;
	
	/**
	 * 字段类型
	 * 参考：DiyFormFieldEnum
	 */
	private int diyFormFieldType;

	public String getDiyFormFieldDefault() {
		return diyFormFieldDefault;
	}

	public String getDiyFormFieldFieldName() {
		return diyFormFieldFieldName;
	}

	public int getDiyFormFieldFormId() {
		return diyFormFieldFormId;
	}

	public int getDiyFormFieldId() {
		return diyFormFieldId;
	}

	public int getDiyFormFieldIsNull() {
		return diyFormFieldIsNull;
	}

	public int getDiyFormFieldSort() {
		return diyFormFieldSort;
	}

	public String getDiyFormFieldTipsName() {
		return diyFormFieldTipsName;
	}

	public int getDiyFormFieldType() {
		return diyFormFieldType;
	}

	public void setDiyFormFieldDefault(String diyFormFieldDefault) {
		this.diyFormFieldDefault = diyFormFieldDefault;
	}
	public void setDiyFormFieldFieldName(String diyFormFieldFieldName) {
		this.diyFormFieldFieldName = diyFormFieldFieldName;
	}
	
	public void setDiyFormFieldFormId(int diyFormFieldFormId) {
		this.diyFormFieldFormId = diyFormFieldFormId;
	}

	public void setDiyFormFieldId(int diyFormFieldId) {
		this.diyFormFieldId = diyFormFieldId;
	}

	public void setDiyFormFieldIsNull(int diyFormFieldIsNull) {
		this.diyFormFieldIsNull = diyFormFieldIsNull;
	}

	public void setDiyFormFieldSort(int diyFormFieldSort) {
		this.diyFormFieldSort = diyFormFieldSort;
	}

	public void setDiyFormFieldTipsName(String diyFormFieldTipsName) {
		this.diyFormFieldTipsName = diyFormFieldTipsName;
	}

	public void setDiyFormFieldType(DiyFormFieldEnum diyFormFieldType) {
		this.diyFormFieldType = diyFormFieldType.toInt();
	}

	public void setDiyFormFieldType(int diyFormFieldType) {
		this.diyFormFieldType = diyFormFieldType;
	}

	
	
	
	
}
