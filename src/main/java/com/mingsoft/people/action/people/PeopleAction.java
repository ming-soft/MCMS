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

package com.mingsoft.people.action.people;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.constant.Const;
import com.mingsoft.people.action.BaseAction;
import com.mingsoft.people.biz.IPeopleBiz;
import com.mingsoft.people.constant.ModelCode;
import com.mingsoft.people.constant.e.CookieConstEnum;
import com.mingsoft.people.constant.e.PeopleEnum;
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.people.entity.PeopleUserEntity;
import com.mingsoft.people.parser.PeopleParser;
import com.mingsoft.util.StringUtil;

/**
 * 铭飞会员系统<br/>
 * 用户登录成功后的操作控制
 * 
 * @author 铭飞开发团队
 * @version 版本号：100-000-000<br/>
 *          创建日期：2016年3月31日<br/>
 *          历史修订：<br/>
 */
@Controller("webPeopleMain")
@RequestMapping("/people")
public class PeopleAction extends BaseAction {
	/**
	 * 注入用户基础业务层
	 */
	@Autowired
	private IPeopleBiz peopleBiz;

	/**
	 * 修改密码
	 * 
	 * @param people
	 *            用户信息<br/>
	 *            <i>people参数包含字段信息参考：</i><br/>
	 *            peopleOldPassword 用户旧密码<br/>
	 *            peoplePassword 用户新密码<br/>
	 *            <dt><span class="strong">返回</span></dt><br/>
	 *            {code:"错误编码",<br/>
	 *            result:"true｜false",<br/>
	 *            resultMsg:"错误信息"<br/>
	 *            }
	 */
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	@ResponseBody
	public void changePassword(@ModelAttribute PeopleEntity people, HttpServletRequest request,
			HttpServletResponse response) {
		if (StringUtil.isBlank(people.getPeoplePassword())) {
			// 用户或密码不能为空
			this.outJson(response, ModelCode.PEOPLE, false,
					this.getResString("err.empty", this.getResString("people.password")));
			return;
		}
		 
		if (StringUtil.isBlank(people.getPeopleOldPassword())) {
			// 用户或密码不能为空
			this.outJson(response, ModelCode.PEOPLE, false,
					this.getResString("err.empty", this.getResString("people.old.password")));
			return;
		}

		// 验证新密码的长度
		if (!StringUtil.checkLength(people.getPeoplePassword(), 6, 30)) {
			this.outJson(response, ModelCode.PEOPLE, false,
					this.getResString("err.length", this.getResString("people.password"), "6", "20"));
			return;
		}
		
		// 获取用户session
		PeopleEntity _people = this.getPeopleBySession(request);
		PeopleEntity curPeople = peopleBiz.getByPeople(_people, this.getAppId(request)); 
		if (!curPeople.getPeoplePassword().equals(StringUtil.Md5(people.getPeopleOldPassword()))) {
			// 用户或密码不能为空
			this.outJson(response, ModelCode.PEOPLE, false,
					this.getResString("err.error", this.getResString("people.password")));
			return;
		}
		// 将用户输入的原始密码用MD5加密再和数据库中的进行比对
		String peoplePassWord = StringUtil.Md5(people.getPeoplePassword(), Const.UTF8);
		// 执行修改
		_people.setPeoplePassword(peoplePassWord);
		this.peopleBiz.updateEntity(_people);
		this.outJson(response, ModelCode.PEOPLE, true);
	}

	/**
	 * 修改手机号<br/>
	 * 存在两种情况：<br/>
	 * 1、用户手机号之间进行过绑定，就需要通过短信发送验证码操作<br/>
	 * 2、用户手机没有绑定，就可以随意修改
	 * 
	 * @param people
	 *            用户信息<br/>
	 *            <i>people参数包含字段信息参考：</i><br/>
	 *            peoplePhone 用户新密码<br/>
	 *            peopleCode 短信验证码<br/>
	 *            <dt><span class="strong">返回</span></dt><br/>
	 *            {code:"错误编码",<br/>
	 *            result:"true｜false",<br/>
	 *            resultMsg:"错误信息"<br/>
	 *            }
	 */
	@RequestMapping(value = "/changePhone", method = RequestMethod.POST)
	@ResponseBody
	public void changePhone(@ModelAttribute PeopleEntity people, HttpServletRequest request,
			HttpServletResponse response) {
		// 验证原始帐号密码
		int appId = this.getAppId(request);
		// 获取用户session
		PeopleEntity _people = this.getPeopleBySession(request);

		// 判断手机是否已经存在
		if (StringUtil.isBlank(people.getPeoplePhone())) {
			this.outJson(response, ModelCode.PEOPLE, false,
					this.getResString("err.empty", this.getResString("people.phone")));
			return;
		}

		// 如果手机号码已经绑定过就需要验证手机短信吗
		if (_people.getPeoplePhoneCheck() == PeopleEnum.PHONE_CHECK.toInt()) {
			PeopleEntity tempPeople = peopleBiz.getByPeople(people, appId);
			// 判断用户输入的验证是否正确
			if (!people.getPeopleCode().equals(tempPeople.getPeopleCode())) {
				// 返回错误信息
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false,
						this.getResString("err.error", this.getResString("people.code")));
				return;
			}
		}
		people.setPeoplePhone(people.getPeoplePhone());
		peopleBiz.updateEntity(people);
		this.outJson(response, ModelCode.PEOPLE, true);
	}

	/**
	 * 验证用户短信、邮箱验证码是否正确
	 * 
	 * @param people
	 *            <i>people参数包含字段信息参考：</i><br/>
	 *            peopleCode 短信、邮箱验证码 <br/>
	 *            <dt><span class="strong">返回</span></dt><br/>
	 *            {code:"模块编码",<br/>
	 *            result:"true｜false"<br/>
	 *            }
	 */
	@RequestMapping(value = "/checkPeopleCode", method = RequestMethod.POST)
	@ResponseBody
	public void checkPeopleCode(@ModelAttribute PeopleEntity people, HttpServletRequest request,
			HttpServletResponse response) {

		// 获取session中的用户实体
		PeopleEntity _people = this.getPeopleBySession(request);
		PeopleEntity _temp = peopleBiz.getByPeople(_people, this.getAppId(request));
		if (people.getPeopleCode().equals(_temp.getPeopleCode())) {
			this.outJson(response, ModelCode.PEOPLE, true);
		} else {
			this.outJson(response, ModelCode.PEOPLE, false);
		}

	}

	/**
	 * 读取当前登录用户的基本信息 用户信息<br/>
	 * <dt><span class="strong">返回</span></dt><br/>
	 * {"peopleAutoLogin":自动登录多少天,"peopleName":用户,"peopleId":用户编号,"peopleMail":
	 * 用户邮箱}<br/>
	 */
	@RequestMapping("/info")
	@ResponseBody
	public void info(HttpServletRequest request, HttpServletResponse response) {
		// 得到登录后session中的用户实体值
		PeopleEntity people = (PeopleEntity) this.getPeopleBySession(request);
		// 返回用户信息
		this.outJson(response, JSONObject.toJSONStringWithDateFormat(people, "yyyy-MM-dd HH:mm:ss"));
	}

	/**
	 * 退出登录
	 */
	@RequestMapping(value = "/quit", method = RequestMethod.POST)
	@ResponseBody
	public void quit(HttpServletRequest request, HttpServletResponse response) {
		// 移除当前用户session
		this.removePeopleBySession(request);
		this.setCookie(request, response, CookieConstEnum.PEOPLE_COOKIE, null);
	}

	/**
	 * 更新用户邮箱或手机号
	 * 
	 * @param peopleUser
	 *            <i>peopleUser参数包含字段信息参考：</i><br/>
	 *            peopleMail 邮箱<br/>
	 *            peoplePhone 号码 <br/>
	 *            <dt><span class="strong">返回</span></dt><br/>
	 *            {code:"模块编码",<br/>
	 *            result:"true｜false",<br/>
	 *            resultMsg:"错误信息"} <br/>
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public void update(@ModelAttribute PeopleEntity people, HttpServletRequest request, HttpServletResponse response) {
		if (people == null) {
			// 未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE, false,
					this.getResString("err.empty", this.getResString("people")));
			return;
		}
		PeopleEntity _people = this.getPeopleBySession(request);
		if (_people.getPeopleMailCheck() == PeopleEnum.MAIL_CHECK.toInt()) {
			people.setPeopleMail(null);
		}
		if (_people.getPeoplePhoneCheck() == PeopleEnum.PHONE_CHECK.toInt()) {
			people.setPeoplePhone(null);
		}
		people.setPeopleName(null);
		people.setPeopleId(this.getPeopleBySession(request).getPeopleId());
		this.peopleBiz.updateEntity(people);
		// 返回更新成功
		this.outJson(response, ModelCode.PEOPLE, true, this.getResString("success"));
	}

	@Autowired
	private PeopleParser peopleParser;

	/**
	 * 前段会员中心所有页面都可以使用该方法 支持参数传递与解析，例如页面中有参数id=10 传递过来，调整页面可以使用{id/}获取该参数
	 * 请求地址例如： ／people/info.do;people/password.do
	 * 
	 * @param key
	 */
	@RequestMapping(value="/{diy}")
	public void diy(@PathVariable(value = "diy") String diy, HttpServletRequest req, HttpServletResponse resp) {
		String content = this.generaterPage("people/" + diy, peopleParser, req);
		this.outString(resp, content);
	}

}