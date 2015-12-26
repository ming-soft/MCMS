package com.mingsoft.basic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.mingsoft.base.dao.IBaseDao;
import com.mingsoft.basic.entity.MailTemplateEntity;

 /**
  * 邮件模板持久化层
  * @author 杨新远
  * @version 
  * 版本号：100-000-000<br/>
  * 创建日期：2012-03-15<br/>
  * 历史修订：<br/>
  */
public interface IMailTemplateDao extends IBaseDao{
	/**
	 * 根据站点id得到邮箱模板列表
	 * @param mailTemplateAppId 站点id
	 * @return 返回MailTemplateEntity列表
	 */
	List<MailTemplateEntity> queryAllByAppId(@Param("mailTemplateAppId") int mailTemplateAppId);
	
	/**
	 * 删除评论，多条或者一条
	 * @param ids 多条评论集合
	 */
	public void deleteAll(@Param("ids")String[] ids);

	/**
	 * 根据应用编号与模块编号获取邮件模板
	 * @param mailTemplateAppId 应用编号
	 * @param modelId 模块编码
	 * @return 返回MailTemplateEntity null:没有找到
	 */
	MailTemplateEntity getByAppIdAndModelCode(@Param("mailTemplateAppId")int mailTemplateAppId,@Param("modelId") int modelId);
}
