/**
 * 
 */
package com.mingsoft.people.action.people;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.people.biz.IPeopleBiz;
import com.mingsoft.people.biz.IPeopleUserBiz;
import com.mingsoft.people.constant.ModelCode;
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.people.entity.PeopleUserEntity;
import com.mingsoft.people.action.BaseAction;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.ImageUtil;
import com.mingsoft.util.StringUtil;

/**
 * 
 * 铭飞会员系统 详细的用户信息
 * @author 铭飞开发团队
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2016年3月31日<br/>
 * 历史修订：<br/>
 */
@Controller("webPeopleUser")
@RequestMapping("/people/user")
public class PeopleUserAction extends BaseAction {

	/**
	 * 注入用户详细信息业务层
	 */
	@Autowired
	private IPeopleUserBiz peopleUserBiz;

	/**
	 * 注入用户业务层
	 */
	@Autowired
	private IPeopleBiz peopleBiz;

	/**
	 * 
	 * 读取当前登录用户的基本信息 用户信息<br/>
	 * <dt><span class="strong">返回</span></dt><br/>
	 * {"peopleId":0,peopleUserBirthday:生日 格式 2016-01-01, peopleUserCard:身份证号码,
	 * peopleUserIcon:头像, peopleUserNickName:昵称, peopleUserRealName:真实姓名,
	 * peopleUserSex:用户性别 0未知\1男\2女 } <br/>
	 */
	@RequestMapping("/info") 
	public void info(HttpServletRequest request, HttpServletResponse response) {
		// 获取用户session
		PeopleEntity people = this.getPeopleBySession(request);
		PeopleUserEntity peopleUser = (PeopleUserEntity) this.peopleUserBiz.getEntity(people.getPeopleId());
		if (peopleUser == null) {
			// 没用用户详细信息
			this.outJson(response, ModelCode.PEOPLE_USER, false);
			return;
		}
		// 返回用户详细信息
		this.outJson(response, JSONObject.toJSONStringWithDateFormat(peopleUser, "yyyy-MM-dd HH:mm:ss"));
	}

	/**
	 * 更新用户信息
	 * 
	 * @param peopleUser
	 *            <i>peopleUser参数包含字段信息参考：</i><br/>
	 *            peopleUserBirthday 生日 格式 2016-01-01<br/>
	 *            peopleUserCard 身份证号码 <br/>
	 *            peopleUserIcon 头像<br/>
	 *            peopleUserNickName 昵称<br/>
	 *            peopleUserRealName 真实姓名<br/>
	 *            peopleUserSex 用户性别 0未知\1男\2女<br/>
	 *            <dt><span class="strong">返回</span></dt><br/>
	 *            {code:"模块编码",<br/>
	 *            result:"true｜false",<br/>
	 *            resultMsg:"错误信息"} <br/>
	 */
	@RequestMapping("/update")
	public void update(@ModelAttribute PeopleUserEntity peopleUser, HttpServletRequest request,
			HttpServletResponse response) {
		if (peopleUser == null) {
			// 未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER, false,
					this.getResString("err.empty", this.getResString("people")));
			return;
		}

		peopleUser.setPeopleId(this.getPeopleBySession(request).getPeopleId());
		PeopleUserEntity pue = (PeopleUserEntity) this.peopleUserBiz.getEntity(peopleUser.getPeopleId());
		if (pue.getPeopleUserPeopleId() == 0) {
			this.peopleUserBiz.saveEntity(peopleUser);
		} else {
			peopleUserBiz.updatePeople(peopleUser);
		}
		// 返回更新成功
		this.outJson(response, ModelCode.PEOPLE_USER, true, this.getResString("success"));
	}

	/**
	 * 保存用户头像(包含头像)
	 * 
	 * @param peopleUser
	 *            用户信息实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/saveUserIcon")
	public void saveUserIcon(@ModelAttribute PeopleUserEntity peopleUser, HttpServletRequest request,
			HttpServletResponse response) {
		// 获取用户session
		PeopleEntity people = this.getPeopleBySession(request);

		if (people == null) {
			// 当session不存在返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER, false,
					this.getResString("people.session.msg.null.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		if (peopleUser == null) {
			// 未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER, false,
					this.getResString("people.user.msg.null.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		String imgPath = getUserIcon(people.getPeopleId(), peopleUser.getPeopleUserIcon().trim(), request); // 新图片路径
		if (!StringUtil.isBlank(imgPath)) {
			peopleUser.setPeopleUserIcon(imgPath);
		}

		peopleUser.setPeopleAppId(people.getPeopleAppId());
		peopleUser.setPeopleId(people.getPeopleId());
		this.peopleUserBiz.saveEntity(peopleUser);
		// 更新手机和电子邮件
		if (!StringUtil.isBlank(peopleUser.getPeopleMail())) {
			people.setPeopleMail(peopleUser.getPeopleMail());
		}
		if (!StringUtil.isBlank(peopleUser.getPeoplePhone())) {
			people.setPeoplePhone(peopleUser.getPeoplePhone());
		}
		this.peopleBiz.updateEntity(people);
		// 返回用户添加成功
		this.outJson(response, ModelCode.PEOPLE_USER, true,
				this.getResString("people.user.save.msg.success", com.mingsoft.people.constant.Const.RESOURCES));
	}

	/**
	 * 更新用户信息(包含头像)
	 * 
	 * @param peopleUser
	 *            用户信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/updateUserIcon")
	public void updateUserIcon(@ModelAttribute PeopleUserEntity peopleUser, HttpServletRequest request,
			HttpServletResponse response) {
		// 获取用户session
		PeopleEntity people = this.getPeopleBySession(request);

		if (people == null) {
			// 当session不存在返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER, false,
					this.getResString("people.session.msg.null.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		PeopleUserEntity oldPeopleUser = (PeopleUserEntity) peopleUserBiz.getEntity(people.getPeopleId());

		if (peopleUser == null) {
			// 未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER, false,
					this.getResString("people.user.msg.null.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}

		String imgPath = getUserIcon(people.getPeopleId(), peopleUser.getPeopleUserIcon().trim(), request); // 新图片路径
		if (!StringUtil.isBlank(imgPath)) {
			oldPeopleUser.setPeopleUserIcon(imgPath);
		}

		this.peopleUserBiz.updatePeople(oldPeopleUser);
		// 返回更新成功
		this.outJson(response, ModelCode.PEOPLE_USER, true,
				this.getResString("people.user.update.msg.success", com.mingsoft.people.constant.Const.RESOURCES));
	}

	/**
	 * 上传头像
	 * 
	 * @param peopleId
	 *            用户id
	 * @param imgPath
	 *            原图片路径
	 * @param request
	 * @return 新图片路径
	 */
	private String getUserIcon(int peopleId, String imgPath, HttpServletRequest request) {
		if (!StringUtil.isBlank(imgPath)) {
			int x1 = this.getInt(request, "x1", 0);
			int y1 = this.getInt(request, "y1", 0);
			int x2 = this.getInt(request, "x2", 0);
			int y2 = this.getInt(request, "y2", 0);
			Integer imgWidth = this.getInt(request, "imgWidth");
			if (StringUtil.isBlank(imgWidth)) {
				return null;
			}
			String sufix = StringUtil.getFileFix(imgPath); // 获取图片后缀
			// 新的图片路径
			String savePath = StringUtil.buildPath("upload", "people", this.getAppId(request),
					StringUtil.getDateSimpleStr() + "_" + peopleId + sufix);
			// 原图片的物理路径
			String imgWidthStr = StringUtil.buildPath(this.getRealPath(request, File.separator), imgPath);
			// 保存的物理路径
			String savePathStr = StringUtil.buildPath(this.getRealPath(request, File.separator), savePath);
			FileUtil.createFolder(savePathStr);
			int[] imgSiz = ImageUtil.getImageWidthHeight(imgWidthStr.trim());
			int saveImgWidth = imgSiz[0]; // 获取图片的实际宽度
			int newX1 = x1 * saveImgWidth / imgWidth;
			int newY1 = y1 * saveImgWidth / imgWidth;

			ImageUtil.cut(newX1, newY1, (x2 - x1) * saveImgWidth / imgWidth, (y2 - y1) * saveImgWidth / imgWidth,
					imgWidthStr, savePathStr.toString());
			new File(imgWidthStr).delete(); // 删除旧的路径下的图片
			return savePath;
		}

		return null;
	}

}
