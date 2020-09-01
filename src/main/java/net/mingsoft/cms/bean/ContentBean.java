package net.mingsoft.cms.bean;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import net.mingsoft.cms.entity.ContentEntity;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 文章实体bean
 */
public class ContentBean extends ContentEntity {

    /**
     * 静态化地址
     */
    private String staticUrl;

    /**
     * 开始时间
     */
    private String beginTime;

    /**
     * 结束时间
     */
    private String endTime;

    /**
     * 属性标记
     */
    private String flag;

    /**
     * 不包含属性标记
     */
    private String noflag;

    public String getStaticUrl() {
        return staticUrl;
    }

    public void setStaticUrl(String staticUrl) {
        this.staticUrl = staticUrl;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getNoflag() {
        return noflag;
    }

    public void setNoflag(String noflag) {
        this.noflag = noflag;
    }
}
