/**
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
 * 本软件及相关文档文件（以下简称“软件”）的版权归 铭软科技 所有
 * 遵循铭软科技《保密协议》
 */

package net.mingsoft.cms.constant.e;

import net.mingsoft.base.constant.e.BaseEnum;

/**
 * @Author: 铭飞团队
 * @Description: 栏目是否显示枚举类
 * @Date: Create in 2023/03/24 14:18
 */
public enum CategoryDisplayEnum implements BaseEnum {

    /**
     * 启用
     */
    ENABLE("enable"),

    /**
     * 禁用
     */
    DISABLE("disable");

    CategoryDisplayEnum(String status) {
        this.status = status;
    }

    private String status;

    @Override
    public int toInt() {
        return 0;
    }

    @Override
    public String toString() {
        return status;
    }
}
