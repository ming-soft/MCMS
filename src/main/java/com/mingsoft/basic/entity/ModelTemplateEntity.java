package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;
import java.sql.Timestamp;

/**
 * 模块模版实体
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ModelTemplateEntity extends BaseEntity {

    /**
     * 自动编号
     */
    private int modelTemplateId;

	/**
     * 应用编号
     */
    private int modelTemplateAppId;

    /**
     * 模块的编号
     */
    private int modelTemplateModelId;

    /**
     * 对应路径
     */
    private String modelTemplatePath;
    
    /**
     * 标题
     */
    private String modelTemplateTitle;
    
    
    public String getModelTemplateTitle() {
		return modelTemplateTitle;
	}

	public void setModelTemplateTitle(String modelTemplateTitle) {
		this.modelTemplateTitle = modelTemplateTitle;
	}

	/**
     * 路径值
     */
    private String modelTemplateKey;
    

	public String getModelTemplateKey() {
		return modelTemplateKey;
	}

	public void setModelTemplateKey(String modelTemplateKey) {
		this.modelTemplateKey = modelTemplateKey;
	}

	public int getModelTemplateAppId() {
		return modelTemplateAppId;
	}

	public void setModelTemplateAppId(int modelTemplateAppId) {
		this.modelTemplateAppId = modelTemplateAppId;
	}

	public int getModelTemplateModelId() {
		return modelTemplateModelId;
	}

	public void setModelTemplateModelId(int modelTemplateModelId) {
		this.modelTemplateModelId = modelTemplateModelId;
	}

	public String getModelTemplatePath() {
		return modelTemplatePath;
	}

	public void setModelTemplatePath(String modelTemplatePath) {
		this.modelTemplatePath = modelTemplatePath;
	}
	
    public int getModelTemplateId() {
		return modelTemplateId;
	}

	public void setModelTemplateId(int modelTemplateId) {
		this.modelTemplateId = modelTemplateId;
	}

}
