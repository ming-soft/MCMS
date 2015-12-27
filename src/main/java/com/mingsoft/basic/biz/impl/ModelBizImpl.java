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
import com.mingsoft.base.biz.impl.BaseBizImpl;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.base.constant.e.BaseEnum;
import com.mingsoft.basic.constant.e.ModelEnum;
import com.mingsoft.basic.dao.IModelDao;
import com.mingsoft.basic.entity.ModelEntity;

/**
 * 模块业务接口实现类
 * @author 张敏
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Service("modelBiz")
public class ModelBizImpl extends BaseBizImpl implements IModelBiz{

	@Override
	public List<BaseEntity> queryChildList(int modelModelId) {
		// TODO Auto-generated method stub
		return modelDao.queryChildList(modelModelId);
	}
	
	@Override
	public List<BaseEntity> queryParent() {
		// TODO Auto-generated method stub
		return modelDao.queryParent();
	}
	
	@Override
	public List<BaseEntity> queryModelByManagerId(int managerId,int modelId){
		// TODO Auto-generated method stub
		return modelDao.queryModelByManagerId(managerId,modelId);
	}

	@Override
	public List<BaseEntity> queryModelByManager() {
		// TODO Auto-generated method stub
		return modelDao.queryModelByManager();
	}
	
	@Override
	public List<BaseEntity> queryModelByRoleId(int roleId){
		// TODO Auto-generated method stub
		return modelDao.queryModelByRoleId(roleId);
	}

	@Override
	public ModelEntity getEntityByModelCode(BaseEnum modelCode){
		// TODO Auto-generated method stub
		return modelDao.getEntityByModelCode(modelCode.toString());
	}	
	
	@Override
	public ModelEntity getEntityByModelCode(String modelCode) {
		// TODO Auto-generated method stub
		return modelDao.getEntityByModelCode(modelCode);
	}

	/**
	 * 模块持久化层
	 */
    private IModelDao modelDao;
    

	/**
	 * 获取模块持久化层
	 * @return modelDao 返回模块持久化层
	 */
    public IModelDao getModelDao() {
        return modelDao;
    }

    @Autowired
    public void setModelDao(IModelDao modelDao) {
        this.modelDao = modelDao;
    }

    @Override
    protected IBaseDao getDao() {
        // TODO Auto-generated method stub
        return modelDao;
    }

	@Override
	public ModelEntity getModel(String modelType,int modelId) {
		// TODO Auto-generated method stub
		return modelDao.getModel(modelType,modelId);
	}

	@Override
	public List<BaseEntity> queryModelByIsMenu(ModelEnum modelEnum) {
		// TODO Auto-generated method stub
		return modelDao.queryModelByIsMenu(modelEnum.toInt());
	}

}