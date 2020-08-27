package net.mingsoft.cms.bean;

import net.mingsoft.cms.entity.ContentEntity;

/**
 * 文章实体bean
 */
public class ContentBean extends ContentEntity {

    /**
     * 静态化地址
     */
    private String staticUrl;


    public String getStaticUrl() {
        return staticUrl;
    }

    public void setStaticUrl(String staticUrl) {
        this.staticUrl = staticUrl;
    }
}
