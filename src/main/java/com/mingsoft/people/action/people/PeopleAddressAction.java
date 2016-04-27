package com.mingsoft.people.action.people;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.entity.ListJson;
import com.mingsoft.people.action.BaseAction;
import com.mingsoft.people.biz.IPeopleAddressBiz;
import com.mingsoft.people.constant.ModelCode;
import com.mingsoft.people.constant.e.PeopleAddressEnum;
import com.mingsoft.people.entity.PeopleAddressEntity;
import com.mingsoft.people.entity.PeopleEntity;
import com.mingsoft.util.StringUtil;
/**
 * 
 * 普通用户收货地址信息控制层(外部请求接口)
 * @author yangxy
 * @version 
 * 版本号：【100-000-000】
 * 创建日期：2015年8月23日 
 * 历史修订：
 */
@Controller("peopleAddress")
@RequestMapping("/people/address")
public class PeopleAddressAction extends BaseAction{
	/**
	 * 注入用户收货地址业务层
	 */
	@Autowired
	private IPeopleAddressBiz peopleAddressBiz;
	
	/**
	 * 通过用户id和站点id查询用户收货地址列表
	 * @param request
	 * @param response
	 */
	@RequestMapping("/queryAddressList")
	public void queryAddressList(HttpServletRequest request,HttpServletResponse response){
		//通过session得到用户实体
		PeopleEntity peopleEntity = this.getPeopleBySession(request); 
		if(peopleEntity==null){
			//当session不存在返回错误信息
			this.outJson(response,null,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
		//通过用户id和站点id查询用户收货地址列表
		List<PeopleAddressEntity> list = peopleAddressBiz.queryListByAppIdAndPeopleId(peopleEntity.getPeopleId(), this.getAppId(request));
		//将总数放入json参数
		ListJson json = new ListJson(list.size(), list);
		//返回列表
		this.outJson(response,JSONObject.toJSONString(json));
	}
	
	/**
	 * 保存用户收货地址
	 * @param peopleAddressEntity 用户收货序列化地址实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/save")
	public void save(@ModelAttribute PeopleAddressEntity peopleAddressEntity, HttpServletRequest request,HttpServletResponse response){
		
		//通过session得到用户实体
		PeopleEntity peopleEntity = this.getPeopleBySession(request); 
		if(peopleEntity==null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		// 判断用户信息是否为空
		if (peopleAddressEntity == null) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.null.error"), this.getResString("people.msg.null.error"));
			return;
		}
		// 验证手机号
		if (StringUtil.isBlank(peopleAddressEntity.getPeopleAddressPhone())) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.phone.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
		//验证邮箱
		if(!StringUtil.isBlank(peopleAddressEntity.getPeopleAddressMail())){
			if (StringUtil.checkEmail(peopleAddressEntity.getPeopleAddressMail())) {
				this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.mail.error", com.mingsoft.people.constant.Const.RESOURCES));
				return;
			}
		}	
		//判断省、市、详细地址是否为空
		if(StringUtil.isBlank(peopleAddressEntity.getPeopleAddressProvince())||StringUtil.isBlank(peopleAddressEntity.getPeopleAddressCity())||StringUtil.isBlank(peopleAddressEntity.getPeopleAddressAddress())){
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.user.msg.null.error"));
			return;
		}
		//通过peopleId查询用户默认收货地址实体
		PeopleAddressEntity entity = peopleAddressBiz.getDefaultEntity(peopleEntity.getPeopleId(), PeopleAddressEnum.ADDRESS_DEFAULT);
		//判断该用户是否有地址（默认状态为0）
		if(entity!=null){
			//注入地址状态1（非默认状态）
			peopleAddressEntity.setPeopleAddressDefault(PeopleAddressEnum.ADDRESS_NOT_DEFAULT);
		}
		//注入用户id
		peopleAddressEntity.setPeopleAddressPeopleId(peopleEntity.getPeopleId());
		//注入站点id
		peopleAddressEntity.setPeopleAddressAppId(this.getAppId(request));
		//进行保存
		peopleAddressBiz.saveEntity(peopleAddressEntity);
		this.outJson(response,null,true,JSONObject.toJSONString(peopleAddressEntity));
	}
	
	/**
	 * 更新用户收货地址
	 * @param peopleAddressEntity 用户收货地址序列化实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/update")
	public void update(@ModelAttribute PeopleAddressEntity peopleAddressEntity,HttpServletRequest request,HttpServletResponse response){
		
		//通过session得到用户实体
		PeopleEntity peopleEntity = this.getPeopleBySession(request); 
		if(peopleEntity==null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		// 判断用户信息是否为空
		if (StringUtil.isBlank(peopleAddressEntity.getPeopleAddressProvince())||StringUtil.isBlank(peopleAddressEntity.getPeopleAddressCity())||StringUtil.isBlank(peopleAddressEntity.getPeopleAddressAddress())) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.null.error"), this.getResString("people.msg.null.error"));
			return;
		}
		// 验证手机号
		if (StringUtil.isBlank(peopleAddressEntity.getPeopleAddressPhone())) {
			this.outJson(response, ModelCode.PEOPLE_REGISTER, false, this.getResString("people.msg.phone.error", com.mingsoft.people.constant.Const.RESOURCES));
			return;
		}
		//通过peopleId查询用户默认收货地址实体
		PeopleAddressEntity entity = peopleAddressBiz.getDefaultEntity(peopleEntity.getPeopleId(), PeopleAddressEnum.ADDRESS_DEFAULT);
		//如果将地址状态修改为默认，且不是自身，则将之前默认地址设为非默认
		if(peopleAddressEntity.getPeopleAddressDefault()==PeopleAddressEnum.ADDRESS_DEFAULT.toInt() && peopleAddressEntity.getPeopleAddressId()!=entity.getPeopleAddressId()){
			entity.setPeopleAddressDefault(PeopleAddressEnum.ADDRESS_NOT_DEFAULT);
			peopleAddressBiz.updateEntity(entity);
		}
		//更新用户地址
		peopleAddressBiz.updateEntity(peopleAddressEntity);
		this.outJson(response,null,true);
	}
	
	/**
	 * 根据收货地址id删除收货信息
	 * @param peopleAddressId 收货地址id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/{peopleAddressId}/delete")
	public void delete(@PathVariable int peopleAddressId,HttpServletRequest request,HttpServletResponse response){
		//通过session得到用户实体
		PeopleEntity peopleEntity = this.getPeopleBySession(request); 
		if(peopleEntity==null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		//根据收货地址id删除收货信息
		peopleAddressBiz.deleteEntity(peopleAddressId, this.getAppId(request));
		this.outJson(response,null, true);
	}
	
	/**
	 * 通过用户session中的peopleId查询用户默认收获地址实体
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getEntityByDefault")
	public void getEntityByDefault(HttpServletRequest request,HttpServletResponse response){
		//通过session得到用户实体
		PeopleEntity peopleEntity = this.getPeopleBySession(request); 
		if(peopleEntity==null){
			//当session不存在返回错误信息
			this.outJson(response,ModelCode.PEOPLE_USER,false,this.getResString("people.session.msg.null.error",com.mingsoft.people.constant.Const.RESOURCES));
			return ;
		}
		//通过peopleId查询用户默认收获地址实体
		PeopleAddressEntity entity = peopleAddressBiz.getDefaultEntity(peopleEntity.getPeopleId(), PeopleAddressEnum.ADDRESS_DEFAULT);
		//返回用户实体
		if(entity!=null){
			this.outJson(response,JSONObject.toJSONString(entity));
		}else{
			this.outJson(response, null, false);
		}
		
	}
	
	
	/**
	 * 通过peopleAddressId查询用户收货地址实体
	 * @param peopleAddressId 用户收货地址id
	 * @param resquest
	 * @param response
	 */
	@RequestMapping("/{peopleAddressId}/getEntity")
	public void getEntity(@PathVariable int peopleAddressId,HttpServletRequest resquest,HttpServletResponse response){
		//通过用户地址id查询用户地址实体
		PeopleAddressEntity entity = (PeopleAddressEntity) peopleAddressBiz.getEntity(peopleAddressId);
		//返回json形式的实体
		
		this.outJson(response,JSONObject.toJSONString(entity));
	}
}



