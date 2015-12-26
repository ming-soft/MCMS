package com.mingsoft.basic.action;

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
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.basic.biz.IDiyFormBiz;
import com.mingsoft.basic.biz.IDiyFormFieldBiz;
import com.mingsoft.basic.entity.DiyFormEntity;
import com.mingsoft.basic.entity.ManagerEntity;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 通用自定义表单
 * @author 王天培
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2014-6-15<br/>
 * 历史修订：<br/>
 */
@Controller("diyForm")
@RequestMapping("/manager/diy/form")
public class DiyFormAction extends BaseAction{
	
	/**
	 * 自定义表前缀
	 */
	private static final String TABLE_NAME_PREFIX = "diy_";
	
	/**
	 * 表名分隔符
	 */
	private static final String TABLE_NAME_SPLIT= "_";
	
	/**
	 * 注入自定义表单biz
	 */
	@Autowired
	IDiyFormBiz diyFormBiz;
	
	/**
	 * 注入自定义表单字段的biz
	 */
	@Autowired
	IDiyFormFieldBiz diyFormFieldBiz;
	
	/**
	 * 加载自定义表单列表页面
	 * @param request 请求对象
	 * @param model ModelMap实体对象
	 * @return 自定义表单页面地址
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request,ModelMap model)  {
		List list = diyFormBiz.query(this.getAppId(request));
		model.addAttribute("list", list);
		return "/manager/diy/form/diy_form_list";
	}
	
	/**
	 * 加载自定义表单的数据列表页面
	 * @param diyFormId 自定义表单id
	 * @param request 请求对象
	 * @param model ModelMap实体对象
	 * @return 自定义表单数据列表页面地址
	 */
	@RequestMapping("/{diyFormId}/query")
	public String query(@PathVariable("diyFormId") int diyFormId,HttpServletRequest request,ModelMap model)  {
		// 当前页面
		int pageNo = 1;
		// 获取页面的当页数
		if (request.getParameter("pageNo") != null) {
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		}
		int appId = this.getAppId(request);
		int count = diyFormBiz.countDiyFormData(diyFormId, appId);
		PageUtil page = new PageUtil(pageNo, 30,count,"/manager/diy/form/"+diyFormId+"/data.do");
		Map map = diyFormBiz.queryDiyFormData(diyFormId, appId, page);
		if (map!=null) {
			if (map.get("fields") != null) {
				model.addAttribute("fields", map.get("fields"));
			}
			if (map.get("list") != null) {
				model.addAttribute("list", map.get("list"));
			}			
		}
		
		model.addAttribute("title", request.getParameter("title"));
		model.addAttribute("page", page);
		return "/manager/diy/form/diy_form_data_list";
	}
	
	/**
	 * 根据id删除自定义表单
	 * @param id 自定义表单的自增长id
	 * @param diyFormId 自定义表单id
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/{diyFormId}/{id}/delete")
	@ResponseBody
	public void delete(@PathVariable("id") int id,@PathVariable("diyFormId") int diyFormId,HttpServletRequest request,HttpServletResponse response)  {
		diyFormBiz.deleteQueryDiyFormData(id, diyFormId);
		this.outJson(response, null, true);
	}
	
	/**
	 * 批量删除（返回删除后的页面数）
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/allDelete")
	@ResponseBody
	public void allDelete(HttpServletRequest request,HttpServletResponse response) {
		int pageNo = 1;
		//接收页面传来的多选框数组
			String[] ids = request.getParameterValues("ids");
			if (StringUtil.isDoubles(ids)) {
				//删除多条自定义模版
				diyFormBiz.deleteAll(ids);
				//返回json数据，结束
				this.getHistoryPageNoByCookie(request);
				this.outJson(response,null,true,String.valueOf(pageNo));
			}else{
				this.outJson(response,null,false,String.valueOf(pageNo));
			}
		}
	
	/**
	 * 加载自定义表单页面
	 * @param request 请求对象
	 * @return 自定义表单页面地址
	 */
	@RequestMapping("/add")
	public String add(HttpServletRequest request) {
		return "/manager/diy/form/diy_form";
	}
	
	/**
	 * 加载自定义表单编辑页面
	 * @param diyFormId 自定义表单id
	 * @param model ModelMap实体对象
	 * @return 自定义表单编辑页面地址
	 */
	@RequestMapping("/{diyFormId}/edit")
	public String edit(@PathVariable int diyFormId,ModelMap model){
		DiyFormEntity diyForm = (DiyFormEntity) this.diyFormBiz.getEntity(diyFormId);
		model.addAttribute("diyForm", diyForm);
		
		return "/manager/diy/form/diy_form";
	}
	
	/**
	 * 保存自定义表单
	 * @param diyForm 自定义表单实体对象
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/save")
	public void  save(@ModelAttribute DiyFormEntity diyForm,HttpServletRequest request, HttpServletResponse response){
		// 更新前判断数据是否合法
		if(!StringUtil.checkLength(diyForm.getDiyFormTableName(), 1,20)){
				this.outJson(response, null, false,getResString("err.length",this.getResString("fieldTipsName"),"1","20"));
				return ;
		}
		if(!StringUtil.checkLength(diyForm.getDiyFormTipsName(), 1,20)){
				this.outJson(response, null, false,getResString("err.length",this.getResString("fieldFieldName"),"1","20"));
				return ;
		}
		
		// 获取当前管理员实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		//获取当前管理员Id
		int managerId = managerSession.getManagerId();
		//获取实际创建的表名
		String diyFormTableName =TABLE_NAME_PREFIX+managerId+TABLE_NAME_SPLIT+diyForm.getDiyFormTableName();
		//判断是否存在重复的表
		if( this.diyFormBiz.getByTableName(diyFormTableName)!=null){
			this.outJson(response, null, false,this.getResString("err.exist",this.getResString("diy.form.table.name")));
			return;
		}
		//获取appId
		int appId = this.getAppId(request);
		//设置appId
		diyForm.setDiyFormAppId(appId);
		//设置管理员id
		diyForm.setDiyFormManagerId(managerId);
		//设置自定义表单的表面
		String tableName = TABLE_NAME_PREFIX+managerId+TABLE_NAME_SPLIT+diyForm.getDiyFormTableName();
		diyForm.setDiyFormTableName(tableName);
		
		//在数据库中创建自定义表单的表
		this.diyFormBiz.createDiyFormTable(diyForm.getDiyFormTableName(), null);
		//保存自定义表单实体
		diyFormBiz.saveEntity(diyForm);
		int diyFormId =  diyFormBiz.getByTableName(tableName).getDiyFormId();
		this.outJson(response, null, true,String.valueOf(diyFormId));
	}
	
	/**
	 * 更新自定义表单
	 * @param diyForm 自定义表单实体
	 * @param response 响应对象
	 * @param request 请求对象
	 */
	@RequestMapping("/update")
	public void update(@ModelAttribute DiyFormEntity diyForm, HttpServletResponse response,HttpServletRequest request){
		// 更新前判断数据是否合法
		if(!StringUtil.checkLength(diyForm.getDiyFormTableName(), 1,20)){
				this.outJson(response, null, false,getResString("err.length",this.getResString("fieldTipsName"),"1","20"));
				return ;
		}
		if(!StringUtil.checkLength(diyForm.getDiyFormTipsName(), 1,20)){
				this.outJson(response, null, false,getResString("err.length",this.getResString("fieldFieldName"),"1","20"));
				return ;
		}
		
		//自增长ID
		int diyFormId =  diyFormBiz.getByTableName(diyForm.getDiyFormTableName()).getDiyFormId();
		diyForm.setDiyFormId(diyFormId);
		//更新自定义表单实体
		diyFormBiz.updateEntity(diyForm);
		
		this.outJson(response, null, true,String.valueOf(diyFormId));
	}
	
	/**
	 * 验证自定义表名合法性
	 * @param diyFormTableName 自定义表单表名
	 * @param request 请求对象
	 * @param response 响应对象
	 */
	@RequestMapping("/{diyFormTableName}/checkTableNameExist")
	public void checkTable(@PathVariable String diyFormTableName, HttpServletRequest request, HttpServletResponse response){
		// 获取当前管理员实体
		ManagerEntity managerSession = (ManagerEntity) getSession(request, SessionConst.MANAGER_ESSION);
		//获取当前管理员Id
		int managerId = managerSession.getManagerId();
		//组装表名
		diyFormTableName =TABLE_NAME_PREFIX+managerId+TABLE_NAME_SPLIT+diyFormTableName;
		DiyFormEntity diyForm = this.diyFormBiz.getByTableName(diyFormTableName);
		if(diyForm==null){
			this.outJson(response, null, false);
		}
		this.outJson(response, null, true);
	}
	
	/**
	 * 删除自定义表单 
	 * @param diyFormId 自定义表单id
	 * @param response 响应对象
	 */
	@RequestMapping("/{diyFormId}/delete")
	public void delete(@PathVariable int diyFormId, HttpServletResponse response){
		
		//根据表单id查找表单实体
		DiyFormEntity diyForm = (DiyFormEntity) this.diyFormBiz.getEntity(diyFormId);
		if(diyForm==null){
			this.outJson(response, null, false,this.getResString("err.not.exist",this.getResString("diy.form")));
			return;
		}
		diyFormBiz.dropTable(diyForm.getDiyFormTableName());
		diyFormBiz.deleteEntity(diyFormId);
		this.outJson(response, null, true);
	}
}
