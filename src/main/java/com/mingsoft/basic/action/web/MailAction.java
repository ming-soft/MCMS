package com.mingsoft.basic.action.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.basic.action.BaseAction;
import com.mingsoft.util.StringUtil;

/**
 * 自由调用邮箱层
 * @author 杨新远
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@Controller("webMail")
@RequestMapping("/mail")
public class MailAction extends BaseAction{
	/**
	 * 自由调用邮箱
	 * @param peopleMail 邮件地址
	 * @param modelCode 模块编码（AES加密过的）
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse对象
	 */
	@RequestMapping("{peopleMail}/sendMail")
	public void sendMail(String peopleMail,String modelCode,HttpServletRequest request,HttpServletResponse response) {

		//后台验证传来的用户邮箱地址是否合法
		if(!StringUtil.isEmail(peopleMail)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("people.msg.mail.error"));
			return;
		}
		//验证模块编码是否为空
		if(StringUtil.isBlank(modelCode)){
			this.outJson(response, ModelCode.PEOPLE,false,this.getResString("err.dataType"));
			return;
		}
		//获取验证码
		String peopleCode= StringUtil.randomNumber(6);
		//解密
		String _modelCode = this.decryptByAES(request, modelCode); 
		//将邮箱地址压如String数组
		String[] user={peopleMail};
		//发送邮箱
		this.sendMail(request, _modelCode, user,peopleCode);
		//返回操作成功信息
		this.outJson(response, null, true, this.getResString("ok"));
	}
}	
