package net.mingsoft.cms.constant.e;

import net.mingsoft.base.constant.e.BaseEnum;

/**
 * 文章操作类型
 * @author 铭软开发团队
 * 创建日期：2023-02-17 10:19:59<br/>
 * 历史修订：<br/>
 */
public enum ContentEnum implements BaseEnum {

    /**
     * 文章显示
     */
    DISPLAY("0"),

    /**
     * 文章不显示
     */
    HIDE("1");

    private String isShow;
    ContentEnum(String isShow){
        this.isShow =isShow;
    }

    @Override
    public int toInt() {
        return 0;
    }
    @Override
    public String toString(){
        return this.isShow;
    }
}
