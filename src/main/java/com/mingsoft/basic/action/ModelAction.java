package com.mingsoft.basic.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IManagerBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.basic.entity.ModelEntity;
import com.mingsoft.util.StringUtil;

/**
 * 模块控制层
 * @author 史爱华
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-6-29<br/>
 * 历史修订：<br/>
 */
@Controller
@RequestMapping("/manager/model")
public class ModelAction extends BaseAction {

	/**
	 * 注入模块业务层
	 */
	@Autowired
	private IModelBiz modelBiz;
	
	@Autowired
	private IManagerBiz managerBiz;

	/**
	 * 增加模块
	 * @param model 模块实体
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/save")
	@ResponseBody
	public void save(@ModelAttribute ModelEntity model,
			HttpServletRequest request, HttpServletResponse response) {
		//获取管理员id并赋值给模块的id
		model.setModelId(getManagerId(request));
		// 获取模块保存时间
		model.setModelDatetime(new Timestamp(System.currentTimeMillis()));
		if (!StringUtil.checkLength(model.getModelTitle(), 1, 20) ) {
			this.outJson(response,getResString("err.length",this.getResString("modelTitle"),"2","20"));
			return;
		}
		if(!StringUtil.checkLength(model.getModelCode(), 1, 20)){
			this.outJson(response,getResString("err.length",this.getResString("modelCode"),"2","20"));
			return;
		}
		
		//判断图标是否为空，不为空去掉,图标地址中含有的“|”
		//空值判断
		if(!StringUtil.isBlank(model.getModelIcon())) {
			model.setModelIcon( model.getModelIcon().replace("|", ""));
		}
		modelBiz.saveEntity(model);
		//返回模块id到页面
		this.outJson(response, ModelCode.ROLE, true,String.valueOf(model.getModelId()));
	}

	/**
	 * 查询所有模块，以json格式输出
	 * @param response 响应对象
	 */
	@RequestMapping("/queryAll")
	public void queryAll(HttpServletResponse response) {
		List<BaseEntity> modelList = modelBiz.queryAll();
		this.outJson(response, JSONObject.toJSONString(modelList));
	}

	/**
	 * 根据模块id编辑模块
	 * @param modelId 模块id
	 * @return 模块实体Map集合
	 */
	@RequestMapping("/edit/{modelId}")
	@ResponseBody
	public Map edit( @PathVariable int modelId) {
		Map mode = new HashMap();
		List<BaseEntity> allModel = modelBiz.queryAll();
		mode.clear();
		//根据id获取模块
		ModelEntity model = (ModelEntity) modelBiz.getEntity(modelId);
		//根据父模块id查寻模块
		ModelEntity parentModel = (ModelEntity) modelBiz.getEntity(model.getModelModelId());
		mode.put("allModel", allModel);
		mode.put("parentModel", parentModel);
		mode.put("model", model);
		return mode;
	}

	/**
	 * 修改模块
	 * @param model 模块实体
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute ModelEntity model,
			HttpServletRequest request, HttpServletResponse response) {
		if (!StringUtil.checkLength(model.getModelTitle(), 2, 20)
				|| !StringUtil.checkLength(model.getModelCode(), 2, 20)) {
			return;
		}
		//判断图标是否为空，不为空去掉,图标地址中含有的“|”
		//空值判断
		if(!StringUtil.isBlank(model.getModelIcon())) {
			model.setModelIcon( model.getModelIcon().replace("|", ""));
		}
		modelBiz.updateEntity(model);		
		this.outJson(response, ModelCode.ROLE, true,String.valueOf(model.getModelId()));
	}

	/**
	 * 加载模块列表页
	 * @param mode ModelMap实体对象
	 * @param request 请求对象
	 * @return 模块列表页面地址
	 */
	@RequestMapping("/list")
	public String list(ModelMap mode, HttpServletRequest request) {
		List<BaseEntity> parentModelList = modelBiz.queryAll();
		mode.addAttribute("parentModelList", JSONArray.toJSONString(parentModelList));
		return "/manager/model/model_list";
	}

	/**
	 * 根据模块id查询所有子模块列表
	 * @param modelId 模块id
	 * @param response 响应对象
	 * @return 子模块的map集合
	 */
	@RequestMapping("/{modelId}/childlist")
	@ResponseBody
	public Map childList(@PathVariable int modelId,
			HttpServletResponse response) {
		Map model = new HashMap();
		List<BaseEntity> childModelList = modelBiz.queryChildList(modelId);
		model.put("chileModelList", childModelList);
		return model;
	}

	/**
	 * 根据id查询是否有子模块
	 * @param modelId 模块id
	 * @param response 响应对象
	 */
	@RequestMapping("/{modelId}/isChildModel")
	@ResponseBody
	public void isChildModel(@PathVariable int modelId, HttpServletResponse response) {
		int childCount = modelBiz.queryChildList(modelId).size();
		if (childCount > 0) {
			this.outJson(response,true);
		}else{
			this.outJson(response,modelId);
		}
		
	}

	/**
	 * 根据Id删除模块
	 * @param modelId 模块id
	 * @param response 响应对象
	 */
	@RequestMapping("/{modelId}/delete")
	@ResponseBody
	public void delete(@PathVariable int modelId, HttpServletResponse response) {
		ModelEntity model = (ModelEntity) modelBiz.getEntity(modelId);
		modelBiz.deleteEntity(modelId);
		this.outJson(response, ModelCode.ROLE, true,
				String.valueOf(model.getModelModelId()));
	}
	
	/**
	 * 根据管理员ID查询模块集合
	 * @param managerId 管理员id
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/{managerId}/queryModelByRoleId")
	public void queryModelByRoleId(@PathVariable int managerId,HttpServletRequest request, HttpServletResponse response) {
		ManagerEntity manager =(ManagerEntity) managerBiz.getEntity(managerId);
		if(manager==null){
			return;
		}
		List<BaseEntity> modelList = new ArrayList<BaseEntity>();
		modelList = modelBiz.queryModelByRoleId(manager.getManagerRoleID());
		this.outJson(response, null,true, JSONObject.toJSONString(modelList));

	}
}
