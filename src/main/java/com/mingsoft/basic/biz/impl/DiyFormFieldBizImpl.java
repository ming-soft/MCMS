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

package com.mingsoft.basic.biz.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mingsoft.basic.biz.IDiyFormFieldBiz;
import com.mingsoft.basic.dao.IDiyFormFieldDao;
import com.mingsoft.basic.entity.DiyFormFieldEntity;
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;

/**
 * 自定义表单字段接口实现类
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service
public class DiyFormFieldBizImpl extends BaseBizImpl implements IDiyFormFieldBiz {

	/**
	 * 注入自定义表单字段持久化层
	 */
	@Autowired
	private IDiyFormFieldDao diyFormFieldDao;
	
	/**
	 * 获取自定义表单字段持久化层
	 * @return diyFormFieldDao 返回自定义表单字段持久化层
	 */
	@Override
	protected IBaseDao getDao() {
		// TODO Auto-generated method stub
		return diyFormFieldDao;
	}
	@Override
	public List<DiyFormFieldEntity> queryByDiyFormId(int diyFormId) {
		// TODO Auto-generated method stub
		return diyFormFieldDao.queryByDiyFormId(diyFormId);
	}
	@Override
	public DiyFormFieldEntity getByFieldName(Integer diyFormFormId,
			String diyFormFieldFieldName) {
		// TODO Auto-generated method stub
		return diyFormFieldDao.getByFieldName(diyFormFormId, diyFormFieldFieldName);
	}
	

}