package com.mingsoft.basic.entity;

import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.constant.e.ModelEnum;

import java.sql.Timestamp;

/**
 * 模块实体
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ModelEntity extends BaseEntity {

    /**
     * 模块的编号
     */
    private int modelId;

    /**
     * 模块的标题
     */
    private String modelTitle;

    /**
     * 发布时间
     */
    private Timestamp modelDatetime;

    /**
     * 模块父id
     */
    private int modelModelId;

    /**
     * 链接地址
     */
    private String modelUrl;

    /**
     * 模块编码
     */
    private String modelCode;

    /**
     * 模块图标
     */
    private String modelIcon = null;
    
    /**
     *模块管理员Id
     */
    private int modelManagerId;

    public int getModelIsMenu() {
		return modelIsMenu;
	}
    
    @Deprecated
	public void setModelIsMenu(int modelIsMenu) {
		this.modelIsMenu = modelIsMenu;
	}
	
	public void setModelIsMenu(ModelEnum modelIsMenu) {
		this.modelIsMenu = modelIsMenu.toInt();
	}

	private int modelIsMenu;
    
    /**
     * 获取modelCode
     * @return modelCode
     */
    public String getModelCode() {
        return modelCode;
    }

    /**
     * 设置modelCode
     * @param modelCode
     */
    public void setModelCode(String modelCode) {
        this.modelCode = modelCode;
    }

    /**
     * 获取modelIcon
     * @return modelIcon
     */
    public String getModelIcon() {
        return modelIcon;
    }

    /**
     * 设置modelIcon
     * @param modelIcon
     */
    public void setModelIcon(String modelIcon) {
        this.modelIcon = modelIcon;
    }

    /**
     * 获取modelModelId
     * @return modelModelId
     */
    public int getModelModelId() {
        return modelModelId;
    }

    /**
     * 设置modelModelId
     * @param modelModelId
     */
    public void setModelModelId(int modelModelId) {
        this.modelModelId = modelModelId;
    }

    /**
     * 获取modelUrl
     * @return modelUrl
     */
    public String getModelUrl() {
        return modelUrl;
    }

    /**
     * 设置modelUrl
     * @param modelUrl
     */
    public void setModelUrl(String modelUrl) {
        this.modelUrl = modelUrl;
    }

    /**
     * 获取modelId
     * @return modelId
     */
    public int getModelId() {
        return modelId;
    }

    /**
     * 设置modelId
     * @param modelId
     */
    public void setModelId(int modelId) {
        this.modelId = modelId;
    }

    /**
     * 获取modelDatetime
     * @return modelDatetime
     */
    public Timestamp getModelDatetime() {
        return modelDatetime;
    }

    /**
     * 设置modelDatetime
     * @param modelDatetime
     */
    public void setModelDatetime(Timestamp modelDatetime) {
        this.modelDatetime = modelDatetime;
    }

    /**
     * 获取modelTitle
     * @return modelTitle
     */
    public String getModelTitle() {
        return modelTitle;
    }

    /**
     * 设置modelTitle
     * @param modelTitle 
     */
    public void setModelTitle(String modelTitle) {
        this.modelTitle = modelTitle;
    }
    
    /**
     * 获取管理员id 
     * @return 返回管理员ID
     */
	public int getModelManagerId() {
		return modelManagerId;
	}
	
	/**
	 * 设置管理员id
	 * @param modelManagerId 管理员ID
	 */
	public void setModelManagerId(int modelManagerId) {
		this.modelManagerId = modelManagerId;
	}
}
