package com.mingsoft.basic.action;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.action.BaseAction;
import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.basic.biz.IMailTemplateBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.constant.e.ModelEnum;
import com.mingsoft.basic.entity.MailTemplateEntity;
import com.mingsoft.util.StringUtil;

/**
 * 邮箱模板管理层
 * @author 杨新远
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015-1-10<br/>
 * 历史修订：<br/>
 */
@Controller("mailTemplate")
@RequestMapping("/manager/mail/template")
public class MailTemplateAction  extends BaseAction{
		//注入邮件模板业务层
		@Autowired
		IMailTemplateBiz mailTemplateBiz;
		//注入模块业务层
		@Autowired
		private IModelBiz modelBiz;
		
		/**
		 * 加载邮箱模板列表页面
		 * @param request 请求对象
		 * @param model ModelMap实体对象
		 * @return 邮箱模板列表页面地址
		 */
		@RequestMapping("/list")
		public String list(HttpServletRequest request, ModelMap model){
				//得到邮箱模板实体列表(通过站点id)
				List<MailTemplateEntity> mailTemplateList = mailTemplateBiz.queryAllByAppId(this.getAppId(request));
				//返回给页面
				model.addAttribute("mailTemplateList", mailTemplateList);
				
				//通过模块枚举类的值获取模块实体数组
				List<BaseEntity>  modelEntityList = modelBiz.queryModelByIsMenu(ModelEnum.NOTMENU);
				if(!modelEntityList.isEmpty()){
					//将Object类型的数组转为JSON传到页面
					String modelEntityListJson = JSONObject.toJSONString(modelEntityList);
					//返回页面
					model.addAttribute("modelEntityList", modelEntityListJson);
				}
				return "/manager/mail/mail_template_list";
		}
		
		/**
		 * 通过 mailTemplateId 查询邮箱模板实体
		 * @param mailTemplateId 邮箱模板id
		 * @param request 请求对象
		 * @param response 响应对象
		 */
		@RequestMapping("/getEntity")
		public void getEntity(String mailTemplateId,HttpServletRequest request,HttpServletResponse response){
			int mtId = Integer.parseInt(mailTemplateId);
			//得到邮箱模板实体
			MailTemplateEntity mailTemplateEntity = (MailTemplateEntity) mailTemplateBiz.getEntity(mtId);
			//判断实体是否为空，若不为空输出实体
			if(mailTemplateEntity!=null){
				this.outJson(response,null,true,JSONObject.toJSONString(mailTemplateEntity));
			}else{
				this.outJson(response, null,false);
			}
		}

		/**
		 * 保存页面传来的邮箱模板实体
		 * @param mailTemplateEntity  邮箱模板实体
		 * @param request 请求对象
		 * @param response 响应对象
		 */
		@RequestMapping("/save")
		public void save(@ModelAttribute  MailTemplateEntity mailTemplateEntity,HttpServletRequest request, HttpServletResponse response){
			//判断实体是否有值,如果没有则返回false
			if(
					StringUtil.isBlank(mailTemplateEntity.getMailTemplateContent())
					||StringUtil.isBlank(mailTemplateEntity.getMailTemplateModelId())
					){
						this.outJson(response,null,false);
						return;
				}
			//传入的实体中的modelId
			int modelId = mailTemplateEntity.getMailTemplateModelId();
			//由于同一个模块id只能对应一个值，所以如果在数据库中已经存在
			//一个modelid对应的邮件模板，那么就返回false
			if(mailTemplateBiz.getByAppIdAndModelCode(this.getAppId(request), modelId)!=null){
				this.outJson(response,null,false,this.getResString("err.exist"));
				return;
			}
			//加入站点id
			mailTemplateEntity.setMailTemplateAppId(this.getAppId(request));
			//进行持久化
			mailTemplateBiz.saveEntity(mailTemplateEntity);
			//返回正确
			this.outJson(response,null,true);
		}
		
		/**
		 *  更新邮箱模板实体
		 * @param mailTemplateEntity 邮箱模板实体
		 * @param mailTemplateId 邮箱模板id
		 * @param request 请求对象
		 * @param response 响应对象
		 */
		@RequestMapping("/{mailTemplateId}/update")
		public void update(@ModelAttribute  MailTemplateEntity mailTemplateEntity, @PathVariable int mailTemplateId,HttpServletRequest request, HttpServletResponse response){
			//判断实体是否为空
			if(mailTemplateEntity!=null){
				mailTemplateEntity.setMailTemplateAppId(this.getAppId(request));
				mailTemplateEntity.setMailTemplateId(mailTemplateId);
				mailTemplateBiz.updateEntity(mailTemplateEntity);
				this.outJson(response,null,true);
				return;
			}
			this.outJson(response,null,false);
		}
		
		
		/**
		 * 批量删除邮箱模板
		 * @param request 请求对象
		 * @param response 响应对象
		 */
		@RequestMapping("/delete")
		public void delete(HttpServletRequest request, HttpServletResponse response){
			//接收页面传来的多选框数组
			String[] ids = request.getParameterValues("radioCategoryId");
			if (StringUtil.isDoubles(ids)) {
				//删除多条评论
				mailTemplateBiz.deleteAll(ids);
				//返回json数据，结束
				this.outJson(response, null, true,"",this.redirectBack(request,false));
				return ;
			}
			this.outJson(response,null,false,this.getResString("err"));	
			return ;
		}
}





















