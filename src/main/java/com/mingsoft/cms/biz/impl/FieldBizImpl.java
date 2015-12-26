package com.mingsoft.cms.biz.impl;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.impl.BasicBizImpl;
import com.mingsoft.cms.biz.IFieldBiz;
import com.mingsoft.cms.constant.e.FieldSearchEnum;
import com.mingsoft.cms.dao.IFieldDao;
import com.mingsoft.cms.entity.FieldEntity;
import com.mingsoft.util.PageUtil;

/**
 * 
 * 
 * <p>
 * <b>铭飞CMS-铭飞内容管理系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author 姓名：张敏
 * 
 * @version 300-001-001
 * 
 * <p>
 * 版权所有 铭飞科技
 * </p>
 *  
 * <p>
 * Comments:字段业务层实现类，继承BasicBizImpl，实现IFieldBiz
 * </p>
 *  
 * <p>
 * Create Date:2014-9-11
 * </p>
 *
 * <p>
 * Modification history:暂无
 * </p>
 */
@Service("fieldBiz")
public class FieldBizImpl extends BasicBizImpl implements IFieldBiz{

	/**
	 * 字段持久化层
	 */
	@Autowired
	private IFieldDao fieldDao;
	
	/**
	 * 获取fieldDao
	 */
	@Override
	protected IBaseDao getDao() {
		return fieldDao;
	}
	
	/**
	 * 查询指定表单的自定义字段列表
	 * @param fieldCmid 表单ID
	 * @return
	 */
	public List<BaseEntity> queryListByCmid(int fieldCmid){
		return fieldDao.queryListByCmid(fieldCmid);
	}
	
	/**
	 * 统计指定表单的字段数量
	 * @param fieldCmid
	 * @return
	 */
	public int queryCountByCmid(int fieldCmid){
		return fieldDao.queryCountByCmid(fieldCmid);
	}
	
	/**
	 * 分页查询指定表单的字段
	 * @param fieldCmid 表单ID
	 * @param pageNo 当前页
	 * @param pageSize 每页显示数
	 * @param orderBy 排序字段
	 * @param order 排序方式
	 * @return 返回字段集合
	 */
	public List<BaseEntity> queryByPage(int fieldCmid,PageUtil page,String orderBy,boolean order){
		return fieldDao.queryByPage(fieldCmid, page.getPageNo(), page.getPageSize(), orderBy, order);
	}
	
	/**
	 * 根据字段名和表单模型id查找符合条件的记录个数
	 * @param fieldName :字段名
	 * @param fieldCmdId : 表单模型id
	 * @return 记录个数
	 */
	@Override
	public int getCountFieldName(String fieldFieldName, int fieldCmdId) {
		// TODO Auto-generated method stub
		return fieldDao.getCountFieldName(fieldFieldName, fieldCmdId);
	}
	
	/**
	 * 通过字段名获取字段实体
	 * @param fieldFieldName 字段名
	 * @return 字段实体
	 */
	public FieldEntity getEntityByFieldName(String fieldFieldName){
		return fieldDao.getEntityByFieldName(fieldFieldName);
	}

	/**
	 * 根据内容模型id和字段名查找字段实体
	 * @param cmId
	 * @param fieldFieldName
	 * @return 字段实体
	 */
	@Override
	public FieldEntity getEntityByCmId(int cmId, String fieldFieldName) {
		return fieldDao.getEntityByCmId(cmId, fieldFieldName);
	}
	
	/**
	 * 根据自定义字段信息动态查询表
	 * @param table 表名
	 * @param diyFieldName 自定义字段
	 * @return 返回ID集合
	 */
	public List<Integer> queryListBySQL(String table,Map<String,String> diyFieldName){
		
		// 根据列名查找字段实体
		List<FieldEntity> listField = new ArrayList<FieldEntity>();
		Iterator<String> it = diyFieldName.keySet().iterator();

		for(Iterator iter = diyFieldName.keySet().iterator();iter.hasNext();){
			FieldEntity field = fieldDao.getEntityByFieldName(iter.next().toString());
			if(field!=null){
				listField.add(field);
			}
		}
		
		String where = "where 1=1";
		for(int i = 0;i<listField.size();i++){
			for(Iterator iter = diyFieldName.keySet().iterator();iter.hasNext();){
				String key = iter.next().toString();
				if(listField.get(i).getFieldFieldName().equals(String.valueOf(key))){
					//判断类型是否为数字类型
					if(listField.get(i).getFieldType()==4||listField.get(i).getFieldType()==5){
						//判断是否存在数字区间如7-8,如果不存在则进行等值查询
						if(diyFieldName.get(key).indexOf("-")>0){
							//取出“-”的前一位数
							int preNum = 1;
							//取出“-”的后一位数
							int nextNum = 12;
							where +=" and "+ listField.get(i).getFieldFieldName()+" between " + preNum +" and " +nextNum;
						}else{
							where +=" and "+listField.get(i).getFieldFieldName()+" = "+Integer.valueOf(diyFieldName.get(key));
						}
					}else{
						where +=" and "+listField.get(i).getFieldFieldName()+" like "+"'%"+String.valueOf(diyFieldName.get(key))+"%'";
					}
					
				}
			}
		}
		List<Map> listMap = fieldDao.queryListByListField(table,where);
		List<Integer> listIds= new ArrayList<Integer>();
		for(int i = 0;i<listMap.size();i++){
			Iterator iter = listMap.get(i).keySet().iterator(); 
			while (iter.hasNext()){  
				listIds.add(Integer.valueOf(listMap.get(i).get(iter.next()).toString()));
			 } 
		}
		 
		return listIds;
	}

	@Override
	public List<FieldEntity> queryByContentModelId(int contentModelId) {
		return this.fieldDao.queryByContentModelId(contentModelId);
	}

	@Override
	public List<FieldEntity> queryByIsSearch(int contentMdoelId, FieldSearchEnum fieldIsSearch) {
		// TODO Auto-generated method stub
		return this.fieldDao.queryByIsSearch(contentMdoelId, fieldIsSearch.toInt());
	}
	
	
}
