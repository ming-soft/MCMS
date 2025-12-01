/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
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



package net.mingsoft.cms.constant.e;

import net.mingsoft.base.constant.e.BaseEnum;

/**
 * @Author: 铭飞团队
 * @Description:
 * @Date: Create in 2020/06/23 14:18
 */
public enum CategoryTypeEnum implements BaseEnum {

    /**
     * 列表
     */
    LIST("1"),
    /**
     * 封面
     */
    COVER("2"),
    /**
     * 链接
     */
    LINK("3"),

    /**
     * 未知类型
     * 使用场景说明：
     * 1. 兼容基于栏目表扩展的业务，并且只有内容模板，如专题插件，栏目类型为业务对应的类型topic，在静态化栏目时如果未匹配到标准栏目类型，采用默认类型进行静态化处理
     * 2. 不会存储在数据库中，只用于业务判断。
     * 3. 第三方业务场景不设置cover类型,cover类型静态化时会校验文章数量，如专题插件不满足条件
     * 4. Switch语句兼容性：确保在Switch-Case结构中不会返回null值，避免潜在的空指针异常。
     */
    UN_KNOW("0");


    CategoryTypeEnum(String type) {
        this.type = type;
    }

    private String type;

    public static CategoryTypeEnum get(String type) {
        for (CategoryTypeEnum e : CategoryTypeEnum.values()) {
            if (e.type.equals(type)) {
                return e;
            }
        }
        return CategoryTypeEnum.UN_KNOW;
    }

    @Override
    public int toInt() {
        return Integer.parseInt(type);
    }

    @Override
    public String toString() {
        return type;
    }
}
