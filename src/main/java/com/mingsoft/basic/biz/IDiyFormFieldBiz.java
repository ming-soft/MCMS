package com.mingsoft.basic.biz;

import java.util.List;
import com.mingsoft.base.biz.IBaseBiz;
import com.mingsoft.basic.entity.DiyFormFieldEntity;

/**
 * 自定义表单接口
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public interface IDiyFormFieldBiz extends IBaseBiz{
	
	/**
	 * 通过from的id获取实体
	 * @param diyFormId　自定义表单id 
	 * @return　返回实体
	 */
	List<DiyFormFieldEntity> queryByDiyFormId( int diyFormId);
	
	/**
	 * 获取自定义表单字段
	 * @param diyFormFieldFormId　自定义表单id 
	 * @param diyFormFieldFieldName 　自定义表单字段名
	 * @return 返回自定义表单实体
	 */
	DiyFormFieldEntity  getByFieldName(Integer diyFormFieldFormId,String diyFormFieldFieldName);
	
}
