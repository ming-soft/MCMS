/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

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

package com.mingsoft.people.biz;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.people.entity.PeopleOpenEntity;

/**
 * 开发平台用户接口 例如qq模块 
 * @author 肥猪
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2016年1月25日<br/>
 * 历史修订：<br/>
 */
public interface IPeopleOpenBiz extends IBaseBiz{

	/**
	 * 根据平台openid读取用户编号
	 * @param openId 平台openid信息
	 * @return null:无数据
	 */
	PeopleOpenEntity getByOpenId(String openId); 
	
	/**
	 * 保存开源用户信息，
	 * @param peopleOpen
	 */
	void savePeopleOpen(PeopleOpenEntity peopleOpen);
}