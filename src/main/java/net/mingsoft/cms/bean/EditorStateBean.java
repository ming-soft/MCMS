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

package net.mingsoft.cms.bean;

import cn.hutool.json.JSONUtil;

import java.util.HashMap;

/**
 * 百度编辑器状态实体类
 * 返回类型一般为大概两种如：{state: "SUCCESS", url:"", type:"",...}，{state: "info"}用来返回错误信息
 */
public class EditorStateBean extends HashMap<String, Object> {

    /**
     * 状态
     */
    private boolean state  = true;

    /**
     * 状态信息，一般用来返回错误信息
     */
    private String info;

    public EditorStateBean() {
    }

    public EditorStateBean(boolean state) {
        this.state = state;
    }

    public EditorStateBean(boolean state, String info) {
        this.state = state;
        this.info = info;
    }

    public boolean isSuccess() {
        return this.state;
    }

    @Override
    public String toString() {
        if (this.state) {
            this.put("state", "SUCCESS");
        } else {
            this.put("state", this.info);
        }
        return JSONUtil.toJsonStr(this);
    }

}
