/**
The MIT License (MIT) * Copyright (c) 2016 铭飞科技(mingsoft.net)

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

package com.mingsoft.people.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.basic.biz.ICategoryBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.constant.Const;
import com.mingsoft.basic.constant.e.CookieConstEnum;
import com.mingsoft.basic.entity.CategoryEntity;
import com.mingsoft.basic.entity.ModelEntity;
import com.mingsoft.people.biz.IPeopleStudentBiz;
import com.mingsoft.people.constant.ModelCode;
import com.mingsoft.people.entity.PeopleStudentEntity;
import com.mingsoft.util.ExcelUtil;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;
/**
 * 
 * <p>
 * <b>铭飞科技-会员系统</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 *
 * @author 史爱华
 *             
 *
 * <p>
 * Comments: 学生信息管理
 * </p>
 *
 * <p>
 * Create Date:2014-10-31
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Controller
@RequestMapping("/${managerPath}/people/student")
public class PeopleStudentAction extends BaseAction{
	
	/**
	 * 
	 */
	@Autowired
	private IPeopleStudentBiz peopleStudentBiz;
	
	@Autowired
	private ICategoryBiz categoryBiz;
	
	@Autowired
	private IModelBiz modelBiz;
	
	@Value("${managerPath}")
	private String managerPath;
	
	
	@RequestMapping("/list")
	public String list(ModelMap mode,HttpServletRequest request,HttpServletResponse response){
		Map map = assemblyRequestMap(request);
		//获取应用ID
		int appId = this.getAppId(request);
		//查询用户总数  
		int peopleCount = this.peopleStudentBiz.getCountByMap(appId,map);
		int pageNo = 1;
		
		if(request.getParameter("pageNo")!=null){
			pageNo=Integer.parseInt(request.getParameter("pageNo").toString());
		}
		//查询城市的模块实体
		ModelEntity  model = modelBiz.getEntityByModelCode(com.mingsoft.basic.constant.ModelCode.CITY);
		int modelId = 0;
		if(model!=null){
			//获取城市的模块id
			modelId = model.getModelId();
		}
		//查询城市数据
		List<CategoryEntity> listCategory = categoryBiz.queryByAppIdOrModelId(appId,modelId);
		JSONObject ja = new JSONObject();
		mode.addAttribute("listCategory", listCategory);
		//分页通用类
		PageUtil page=new PageUtil(pageNo,peopleCount,getUrl(request)+ managerPath + "/people/student/list.do");
		List<PeopleStudentEntity> listPeopleStudent = this.peopleStudentBiz.queryByMap(appId, page,map);
		mode.addAttribute("listPeopleStudent", listPeopleStudent);
		mode.addAttribute("page", page);
		return view("/people/student/people_student_list");
	}
	
	/**
	 * 获取用户详细信息
	 * @param peopleId 用户ID
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{peopleId}/query")
	public void query(@PathVariable int peopleId,HttpServletRequest request,HttpServletResponse response){
		//获取用户实体信息
		PeopleStudentEntity peopleStudent = peopleStudentBiz.getPeopleStudent(peopleId);
		//判断用户是否存在
		if(peopleStudent==null){
				//返回错误信息
				this.outJson(response,ModelCode.PEOPLE,false,this.getResString("people.session.msg.null.error"));
				return ;
		}
		//返回用户详细信息
		this.outJson(response, ModelCode.PEOPLE_USER,true,null,JSONObject.toJSONString(peopleStudent));
	}
	/**
	 * 编辑用户信息
	 * @param peopleId 用户ID
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{peopleId}/edit")
	public String edit(@PathVariable int peopleId,HttpServletRequest request,HttpServletResponse response){
		//获取用户实体信息
		PeopleStudentEntity peopleStudent = peopleStudentBiz.getPeopleStudent(peopleId);
		request.setAttribute("peopleStudent", peopleStudent);
		return view("/people/student/people_student");
	}	
	
	@RequestMapping("/update") 
	@ResponseBody
	public void update(@ModelAttribute PeopleStudentEntity peopleStudent,HttpServletRequest request,HttpServletResponse response){
		peopleStudentBiz.updatePeopleStudent(peopleStudent);
		// 获取cookie
		String cookie =this.getCookie(request, CookieConstEnum.BACK_COOKIE);
		this.outJson(response, null, true,String.valueOf(cookie));
	}	
	
	/**
	 * 导出学生数据
	 * @param request
	 * @param response
	 */
	@RequestMapping("/exprotStudentsExcel")
	public void exportSendExcel(HttpServletRequest request, HttpServletResponse response)  {
		Map map = assemblyRequestMap(request);
		int appId = this.getAppId(request);
		List<PeopleStudentEntity> listPeopleStudent = this.peopleStudentBiz.queryByMap(appId, null,map);
		String[] titles = new String[] {"编号", "姓名","学校", "电话","所在系"};

		
		List<Object> values = new ArrayList<Object>();
		for (int i = 0; i < listPeopleStudent.size(); i++) {
			PeopleStudentEntity peopleStudent = (PeopleStudentEntity) listPeopleStudent.get(i);
			Object[] objs = new Object[titles.length];
			objs[0] = i + 1;
			objs[1] =peopleStudent.getPeopleUserRealName();
			objs[2] =peopleStudent.getPeopleStudentSchool();
			objs[3] = peopleStudent.getPeoplePhone();//姓名
			objs[4] = peopleStudent.getPeopleStudentDepartment();
			values.add(objs);

		}
		ExcelUtil.exportExcel("学生信息" + StringUtil.getDateSimpleStr() + ".xls", titles, values, response);
	}
}