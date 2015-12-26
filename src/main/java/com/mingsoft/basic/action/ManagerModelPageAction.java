package com.mingsoft.basic.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.basic.biz.IManagerModelPageBiz;
import com.mingsoft.basic.entity.ManagerModelPageEntity;
import com.mingsoft.basic.entity.ManagerSessionEntity;

/**
 * 管理员模块页面控制层
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015-01-16<br/>
 * 历史修订：<br/>
 */
@Controller
@RequestMapping("/manager/managerModelPage")
public class ManagerModelPageAction extends BaseAction{
	/**
	 * 注入业务层
	 */
	@Autowired
	private IManagerModelPageBiz managerModelPageBiz;
	
	/**
	 * 管理员添加页面模块
	 * @param managerModelPage 管理员页面实体
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute ManagerModelPageEntity managerModelPage,HttpServletRequest request, HttpServletResponse response){
		//根据管理员id查找管理员模块页面实体对象
		ManagerModelPageEntity oldManagerModelPage =(ManagerModelPageEntity) managerModelPageBiz.getByManagerIdAndModelId(managerModelPage.getManagerModelPagemanagerId(),managerModelPage.getManagerModelPageModelId());
		//判断记录是否已经存在，如果存在则进行更新
		if(oldManagerModelPage!=null){
			managerModelPageBiz.updateEntity(managerModelPage);
			this.outJson(response, null, true);
			return;
		}
		managerModelPageBiz.saveEntity(managerModelPage);
		this.outJson(response, null, true);
	}
	
	/**
	 * 根据管理员id查找实体
	 * @param managerModelPageModelId 管理员id
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/{managerModelPageModelId}/getEntity")
	public void getEntity(@PathVariable("managerModelPageModelId") int managerModelPageModelId,HttpServletRequest request, HttpServletResponse response){
		//获取
		ManagerSessionEntity managerSession = getManagerBySession(request);
		int managerId = managerSession.getManagerId();
		//根据管理员id查找管理员模块页面实体对象
		ManagerModelPageEntity managerModelPage =(ManagerModelPageEntity) managerModelPageBiz.getByManagerIdAndModelId(managerId,managerModelPageModelId);
		if(managerModelPage==null){
			this.outJson(response,null, false);
			return;
		}
		this.outJson(response,null, true,JSONObject.toJSONString(managerModelPage));
	}
}
