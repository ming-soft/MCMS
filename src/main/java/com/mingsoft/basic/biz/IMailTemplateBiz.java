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

import java.util.List;

import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.MailTemplateEntity;

/**
 * 邮件模板业务层接口
 * @author 杨新远
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IMailTemplateBiz extends IBaseBiz{
	
	/**
	 * 通过站点id绑定的邮箱模板对应的应用编号查询邮箱模板列表
	 * @param mailTemplateAppId 应用编号
	 * @return 返回邮箱模板列表
	 */
	List<MailTemplateEntity> queryAllByAppId(int mailTemplateAppId);
	/**
	 * 根据应用编号与模块编号获取邮件模板
	 * @param mailTemplateAppId 应用编号
	 * @param modelId 模块id,
	 * @return 返回邮箱模板实体 null:没有找到
	 */
	MailTemplateEntity getByAppIdAndModelCode(int mailTemplateAppId,int modelId);
	/**
	 * 多选删除
	 * @param ids 前端传来的勾选的checkbox的id序列化值
	 */
	void deleteAll(String[] ids);
}