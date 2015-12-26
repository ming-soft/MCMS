package com.mingsoft.basic.action;

import javax.servlet.http.HttpServletRequest;
import com.mingsoft.basic.biz.IMailBiz;
import com.mingsoft.basic.biz.IMailTemplateBiz;
import com.mingsoft.basic.biz.IModelBiz;
import com.mingsoft.basic.biz.impl.MailTemplateBizImpl;
import com.mingsoft.basic.constant.e.MailEnum;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.basic.entity.MailEntity;
import com.mingsoft.basic.entity.MailTemplateEntity;
import com.mingsoft.basic.entity.ManagerSessionEntity;
import com.mingsoft.basic.entity.ModelEntity;
import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.util.MailUtil;
import com.mingsoft.util.StringUtil;

/**
 * 基础应用层的父类base
 * @author 成卫雄
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2015-7-19<br/>
 * 历史修订：<br/>
 */
public class BaseAction extends com.mingsoft.base.action.BaseAction{

	
	/**
	 * 根据当前的模块获取到当前模块的分类模块信息
	 * @param request 请求对象
	 * @return 错误返回null，正确返回模块实体对象
	 */
	protected ModelEntity getCategoryModelCode(HttpServletRequest request) {
		Object obj = this.getSession
				(request, SessionConst.MODEL_ID_SESSION);
		if (StringUtil.isInteger(obj)) {
			com.mingsoft.basic.biz.IModelBiz modelBiz = (com.mingsoft.basic.biz.IModelBiz) getBean(request.getServletContext(), "modelBiz");
			return modelBiz.getModel(IModelBiz.CATEGORY_MODEL, Integer.parseInt(obj.toString()));
		} else {
			return null;
		}
	}

	/**
	 * 根据当前的模块获取到当前模块的basic文章模块信息
	 * @param request 请求对象
	 * @return 错误返回null，正确返回模块实体对象
	 */
	protected ModelEntity getBasicModelCode(HttpServletRequest request) {
		Object obj = this.getSession(request, SessionConst.MODEL_ID_SESSION);
		if (StringUtil.isInteger(obj)) {
			com.mingsoft.basic.biz.IModelBiz modelBiz = (com.mingsoft.basic.biz.IModelBiz) getBean(request.getServletContext(), "modelBiz");
			return modelBiz.getModel(IModelBiz.BASIC_MODEL, Integer.parseInt(obj.toString()));
		} else {
			return null;
		}
	}	
	
	/**
	 * 获得当前应用的邮件服务器
	 * @param request 请求对象
	 * @return null 表示没有找到，正确返回邮箱实体对象
	 */
	protected MailEntity getMail(HttpServletRequest request) {
		AppEntity app = getApp(request);
		if (app == null) {
			return null;
		}
		// 获取用户所请求的域名地址
		IMailBiz mailBiz = (IMailBiz) getBean(request.getServletContext(), "mailBiz");
		MailEntity mail = mailBiz.getByAppId(app.getAppId());
		if (mail == null) {
			return null;
		}
		return mail;
	}	
	
	/**
	 * 发送邮件
	 * @param request 请求对象
	 * @param mailType 邮件类型(MailEntity.TEXT MailEntity.HTML)
	 * @param title 标题
	 * @param content 内容
	 * @param toUser 接收用户
	 */
	protected void sendMail(HttpServletRequest request, MailEnum mailType, String title, String content, String[] toUser) {
		MailEntity mail = getMail(request);
		if (mailType.toInt() == MailEnum.TEXT.toInt()) {
			MailUtil.sendText(mail.getMailServer(), mail.getMailPort(), mail.getMailName(), mail.getMailPassword(), title, content, toUser);
		} else if (mailType.toInt() == MailEnum.HTML.toInt()) {
			MailUtil.sendHtml(mail.getMailServer(), mail.getMailPort(), mail.getMailName(), mail.getMailPassword(), title, content, toUser);
		}
	}
	
	/**
	 * 发送html邮件内容
	 * @param request 请求对象
	 * @param modelCode 模块编码
	 * @param toUser  接收用户邮件地址
	 * @param content 发送内容
	 */
	@Deprecated
	protected void sendMail(HttpServletRequest request, String modelCode, String[] toUser,String content) {
		IMailTemplateBiz mailTemplateBiz = (MailTemplateBizImpl)this.getBean(request.getServletContext(), "mailTemplateBiz");
		int modelId = this.getModelCodeId(request, modelCode);
		MailTemplateEntity mte =  mailTemplateBiz.getByAppIdAndModelCode(this.getAppId(request), modelId);
		if (mte!=null) {
			String _content = mte.getMailTemplateContent();
			_content = _content.replace("{content}", content);
			//如果实体不为空就获取邮箱模板的标题和内容一起发送指定的邮箱地址
			this.sendMail(request, MailEnum.HTML,mte.getMailTemplateTitle(),_content, toUser);
		}
	}

	/**
	 * 发送html邮件内容,谨慎使用
	 * @param request 请求对象
	 * @param modelCodeId 模块编号，一般提供给后台没有对模块进行统一管理的模块
	 * @param toUser 接收用户邮件地址
	 */
	protected void sendMail(HttpServletRequest request, int modelCodeId, String[] toUser) {
		IMailTemplateBiz mailTemplateBiz = (MailTemplateBizImpl)this.getBean(request.getServletContext(), "mailTemplateBiz");
		MailTemplateEntity mte =  mailTemplateBiz.getByAppIdAndModelCode(this.getAppId(request), modelCodeId);
		if (mte!=null) {
			//如果实体不为空就获取邮箱模板的标题和内容一起发送指定的邮箱地址
			this.sendMail(request, MailEnum.HTML,mte.getMailTemplateTitle(),mte.getMailTemplateContent(), toUser);
		}
	}
	
	/**
	 * 获取管理员id，规则：没有父ID就获取自身的ID
	 * @param request 请求对象
	 * @return 管理员编号
	 */
	protected int getManagerId(HttpServletRequest request) {
		ManagerSessionEntity managerSession = (ManagerSessionEntity) this.getManagerBySession(request);
		int managerParent = managerSession.getManagerParentID();

		if (managerParent == 0) {
			return managerSession.getManagerId();
		} else {
			return managerParent;
		}
	}
	
	/**
	 * 判断当前管理员是否是系统平台管理员
	 * @param request 请求对象
	 * @return true:是系统平台管理员，false:不是系统平台管理员
	 */
	protected boolean isSystemManager(HttpServletRequest request) {
		ManagerSessionEntity manager = (ManagerSessionEntity) getManagerBySession(request);
		if (manager.getManagerRoleID() == Const.DEFAULT_SYSTEM_MANGER_ROLE_ID) {
			return true;
		} else {
			return false;
		}
	}	
	
	/**
	 * 读取管理员session
	 * @param request 请求对象
	 * @return 获取不到就返回null
	 */
	protected ManagerSessionEntity getManagerBySession(HttpServletRequest request) {
		// 传入用管理员请求，读取管理员的session || super,调用父类的protected属性的getSession方法
		ManagerSessionEntity managerSession = (ManagerSessionEntity) this.getSession(request, SessionConst.MANAGER_ESSION);
		if (managerSession != null) {
			// 返回管理员的所有信息
			return managerSession;
		}
		return null;
	}	
	
}
