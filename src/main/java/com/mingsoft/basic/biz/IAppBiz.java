/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

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

package com.mingsoft.basic.biz;

import com.mingsoft.basic.entity.AppEntity;

/**
 * 网站基本信息业务层接口
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IAppBiz extends IBasicBiz{
	
	/**
	 * 查找域名相同站点的个数
	 * @param websiteUrl 域名
	 * @return 返回站点个数
	 */
	int countByUrl(String websiteUrl);
	
	/**
	 * 根据站点管理员id查找站点
	 * @param managerId 站点管理员id
	 * @return 返回站点实体
	 */
	AppEntity getByManagerId(int managerId);
	/**
	 * 根据站点域名获取站点实体
	 * @param websiteUrl 域名
	 * @return 返回站点实体
	 */
	AppEntity getByUrl(String websiteUrl);
}