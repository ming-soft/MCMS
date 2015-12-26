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
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.people.entity.PeopleUserEntity;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.people.action.BaseAction;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.ImageUtil;
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
 * @author 成卫雄
 *                QQ:330216230
 *
 * <p>
 * Comments:普通用户详细信息控制层(外部请求接口)
 * </p>
 *
 * <p>
 * Create Date:2014-11-1
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
@Controller("webPeopleUser")
@RequestMapping("/people/user")
public class PeopleUserAction extends BaseAction{
	
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
	 * 新增用户详细信息
	 * @param peopleUser 用户信息实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute PeopleUserEntity peopleUser,HttpServletRequest request,HttpServletResponse response){
		//获取用户session
		PeopleEntity people = this.getPeopleBySession(request);
		
		if(people == null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		
		if(peopleUser == null){
			//未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER,false,this.getResString("people.user.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		peopleUser.setPeopleAppId(people.getPeopleAppId());
		peopleUser.setPeopleId(people.getPeopleId());
		this.peopleUserBiz.saveEntity(peopleUser);
		//更新手机和电子邮件
		if(!StringUtil.isBlank(peopleUser.getPeopleMail())){
			people.setPeopleMail(peopleUser.getPeopleMail());
		}
		if(!StringUtil.isBlank(peopleUser.getPeoplePhone())){
			people.setPeoplePhone(peopleUser.getPeoplePhone());
		}
		this.peopleBiz.updateEntity(people);
		//返回用户添加成功
		this.outJson(response, ModelCode.PEOPLE_USER,true,this.getResString("people.user.save.msg.success",com.mingsoft.people.constant.Const.RESOURCES));
	}
	
	/**
	 * 获取用户详细信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getEntity")
	public void getEntity(HttpServletRequest request,HttpServletResponse response){
		//获取用户session
		PeopleEntity people = this.getPeopleBySession(request);
		if(people == null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		
		PeopleUserEntity peopleUser = (PeopleUserEntity) this.peopleUserBiz.getEntity(people.getPeopleId());
		if(peopleUser == null){
			//没用用户详细信息
			this.outJson(response, ModelCode.PEOPLE_USER,false,this.getResString("people.user.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		//返回用户详细信息
		this.outJson(response, ModelCode.PEOPLE_USER,true,null,JSONObject.toJSONStringWithDateFormat(peopleUser,"yyyy-MM-dd HH:mm:ss"));
	}
	
	/**
	 * 用户更新详细信息
	 * @param peopleUser 用户信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/update")
	public void update(@ModelAttribute PeopleUserEntity peopleUser,HttpServletRequest request,HttpServletResponse response){
		//获取用户session
		PeopleEntity people = this.getPeopleBySession(request);
	
		if(people == null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		
		if(peopleUser == null){
			//未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER,false,this.getResString("people.user.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		
		peopleUser.setPeopleId(people.getPeopleId());
		this.peopleUserBiz.updatePeople(peopleUser);
		//返回更新成功
		this.outJson(response, ModelCode.PEOPLE_USER,true,this.getResString("people.user.update.msg.success",com.mingsoft.people.constant.Const.RESOURCES));
	}
	
	
	/**
	 * 保存用户头像(包含头像)
	 * @param peopleUser 用户信息实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/saveUserIcon")
	public void saveUserIcon(@ModelAttribute PeopleUserEntity peopleUser,HttpServletRequest request,HttpServletResponse response){
		//获取用户session
		PeopleEntity people = this.getPeopleBySession(request);
		
		
		if(people == null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		
		if(peopleUser == null){
			//未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER,false,this.getResString("people.user.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		
		String imgPath =getUserIcon(people.getPeopleId(), peopleUser.getPeopleUserIcon().trim(),request); //新图片路径
		if(!StringUtil.isBlank(imgPath)){
			peopleUser.setPeopleUserIcon(imgPath);
		}
		
	
		peopleUser.setPeopleAppId(people.getPeopleAppId());
		peopleUser.setPeopleId(people.getPeopleId());
		this.peopleUserBiz.saveEntity(peopleUser);
		//更新手机和电子邮件
		if(!StringUtil.isBlank(peopleUser.getPeopleMail())){
			people.setPeopleMail(peopleUser.getPeopleMail());
		}
		if(!StringUtil.isBlank(peopleUser.getPeoplePhone())){
			people.setPeoplePhone(peopleUser.getPeoplePhone());
		}
		this.peopleBiz.updateEntity(people);
		//返回用户添加成功
		this.outJson(response, ModelCode.PEOPLE_USER,true,this.getResString("people.user.save.msg.success",com.mingsoft.people.constant.Const.RESOURCES));
	}
	
	/**
	 * 更新用户信息(包含头像)
	 * @param peopleUser 用户信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("/updateUserIcon")
	public void updateUserIcon(@ModelAttribute PeopleUserEntity peopleUser,HttpServletRequest request,HttpServletResponse response){
		//获取用户session
		PeopleEntity people = this.getPeopleBySession(request);
	

		
		if(people == null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		
		PeopleUserEntity oldPeopleUser = (PeopleUserEntity) peopleUserBiz.getEntity(people.getPeopleId());
		
		if(peopleUser == null){
			//未填写信息返回错误信息
			this.outJson(response, ModelCode.PEOPLE_USER,false,this.getResString("people.user.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		
		
		String imgPath =getUserIcon(people.getPeopleId(), peopleUser.getPeopleUserIcon().trim(),request); //新图片路径
		if(!StringUtil.isBlank(imgPath)){
			oldPeopleUser.setPeopleUserIcon(imgPath);
		}

		this.peopleUserBiz.updatePeople(oldPeopleUser);
		//返回更新成功
		this.outJson(response, ModelCode.PEOPLE_USER,true,this.getResString("people.user.update.msg.success",com.mingsoft.people.constant.Const.RESOURCES));
	}
	
	/**
	 * 上传头像
	 * @param peopleId 用户id
	 * @param imgPath 原图片路径
	 * @param request
	 * @return 新图片路径
	 */
	private String getUserIcon(int peopleId,String imgPath,HttpServletRequest request){
		if(!StringUtil.isBlank(imgPath)){
			int x1= this.getInt(request, "x1", 0);
			int y1 = this.getInt(request, "y1", 0);
			int x2 = this.getInt(request, "x2", 0);
			int y2 = this.getInt(request, "y2", 0);
			Integer imgWidth = this.getInt(request, "imgWidth");
			if(StringUtil.isBlank(imgWidth)){
				return null;
			}
			String sufix = StringUtil.getFileFix(imgPath);	//获取图片后缀
			//新的图片路径
			String savePath = StringUtil.buildPath("upload","people",this.getAppId(request),StringUtil.getDateSimpleStr()+"_"+peopleId+sufix);	
			//原图片的物理路径
			String imgWidthStr = StringUtil.buildPath(this.getRealPath(request,File.separator),imgPath);
			//保存的物理路径
			String savePathStr = StringUtil.buildPath(this.getRealPath(request,File.separator),savePath);
			FileUtil.createFolder(savePathStr);
			int[] imgSiz  = ImageUtil.getImageWidthHeight(imgWidthStr.trim());
			int saveImgWidth=imgSiz[0];	//获取图片的实际宽度
			int newX1 = x1*saveImgWidth/imgWidth;
			int newY1 = y1*saveImgWidth/imgWidth;
			
			ImageUtil.cut(newX1, newY1,(x2-x1)*saveImgWidth/imgWidth, (y2-y1)*saveImgWidth/imgWidth, imgWidthStr, savePathStr.toString());
			new File(imgWidthStr).delete(); 	//删除旧的路径下的图片
			return savePath;
		}
		
		return null;
	}
	
	
	
}
