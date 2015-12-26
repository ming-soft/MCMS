package com.mingsoft.basic.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONArray;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.basic.biz.ISystemSkinBiz;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.basic.entity.SystemSkinEntity;
import com.mingsoft.base.constant.SessionConst;

/**
 * 后台主题
 * @author 王天培
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015-1-10<br/>
 * 历史修订：<br/>
 */
@Controller
@RequestMapping("/manager/systemSkin/")
public class SystemSkinAciton extends BaseAction{

	/**
	 * 主题业务
	 */
	@Autowired
	private ISystemSkinBiz systemSkinBiz;
	
	/**
	 * 通过系统主题id更新主题
	 * @param request 请求对象
	 * @param response 响应对象
	 * @param systemSkinId 系统主题id
	 */
	@RequestMapping("/{systemSkinId}/updateForManager")
	@ResponseBody
	public void updateForManager(HttpServletRequest request,HttpServletResponse response,@PathVariable int systemSkinId){
		ManagerSessionEntity mse = this.getManagerBySession(request);
		SystemSkinEntity sse = systemSkinBiz.updateManagerSystemSkin(mse.getManagerId(), systemSkinId);
		if (sse!=null) {
			mse.setSystemSkin(sse);
			this.setSession(request, SessionConst.MANAGER_ESSION, mse);
		}
	}
	
	/**
	 * 查询所有主题以json格式返回list集合
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/query")
	@ResponseBody
	public void query(HttpServletRequest request,HttpServletResponse response){
		List list = systemSkinBiz.queryAll();
		this.outJson(response, JSONArray.toJSONString(list));
	}
}
