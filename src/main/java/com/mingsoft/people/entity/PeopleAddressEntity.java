package com.mingsoft.people.entity;

import com.mingsoft.base.constant.e.BaseEnum;
import com.mingsoft.base.entity.BaseEntity;

/**
 * 
 * 用户收货地址实体类
 * @author yangxy
 * @version 
 * 版本号：【100-000-000】
 * 创建日期：2015年8月24日 
 * 历史修订：
 */
public class PeopleAddressEntity extends BaseEntity{

	/**
	 * 用户收货地址自增长Id
	 */
	int peopleAddressId;
	
	/**
	 * 对应用户基础信息拓展表的id
	 */
	int peopleAddressPeopleId;
	
	/**
	 * 用户收货人姓名
	 */
	String peopleAddressConsigneeName;
	
	/**
	 * 收货人所在的省
	 */
	String peopleAddressProvince;
	
	/**
	 * 收货人所在的市
	 */
	String peopleAddressCity;
	
	/**
	 * 收货人所在区
	 */
	String peopleAddressDistrict;
	
	/**
	 * 街道
	 */
	private int peopleAddressStreet;
	
	/**
	 * 收货人的详细收货地址
	 */
	String peopleAddressAddress;
	
	/**
	 * 收货人邮箱
	 */
	String peopleAddressMail;
	
	/**
	 * 收货人手机
	 */
	String peopleAddressPhone;
	
	/**
	 * 是否是收货人最终收货地址。0代表是，1代表不是，默认为0
	 */
	int peopleAddressDefault;

	/**
	 * 对应的站点id
	 */
	int peopleAddressAppId;

	public int getPeopleAddressId() {
		return peopleAddressId;
	}

	public void setPeopleAddressId(int peopleAddressId) {
		this.peopleAddressId = peopleAddressId;
	}

	public int getPeopleAddressPeopleId() {
		return peopleAddressPeopleId;
	}

	public void setPeopleAddressPeopleId(int peopleAddressPeopleId) {
		this.peopleAddressPeopleId = peopleAddressPeopleId;
	}

	public String getPeopleAddressConsigneeName() {
		return peopleAddressConsigneeName;
	}

	public void setPeopleAddressConsigneeName(String peopleAddressConsigneeName) {
		this.peopleAddressConsigneeName = peopleAddressConsigneeName;
	}

	public String getPeopleAddressProvince() {
		return peopleAddressProvince;
	}

	public void setPeopleAddressProvince(String peopleAddressProvince) {
		this.peopleAddressProvince = peopleAddressProvince;
	}

	public String getPeopleAddressCity() {
		return peopleAddressCity;
	}

	public void setPeopleAddressCity(String peopleAddressCity) {
		this.peopleAddressCity = peopleAddressCity;
	}

	public String getPeopleAddressDistrict() {
		return peopleAddressDistrict;
	}

	public void setPeopleAddressDistrict(String peopleAddressDistrict) {
		this.peopleAddressDistrict = peopleAddressDistrict;
	}

	public String getPeopleAddressAddress() {
		return peopleAddressAddress;
	}

	public void setPeopleAddressAddress(String peopleAddressAddress) {
		this.peopleAddressAddress = peopleAddressAddress;
	}

	public String getPeopleAddressMail() {
		return peopleAddressMail;
	}

	public void setPeopleAddressMail(String peopleAddressMail) {
		this.peopleAddressMail = peopleAddressMail;
	}

	public String getPeopleAddressPhone() {
		return peopleAddressPhone;
	}

	public void setPeopleAddressPhone(String peopleAddressPhone) {
		this.peopleAddressPhone = peopleAddressPhone;
	}

	public int getPeopleAddressDefault() {
		return peopleAddressDefault;
	}
	
	/**
	 * 推荐使用枚举类形参方法，此方法过时
	 * @param peopleAddressDefault
	 */
	@Deprecated
	public void setPeopleAddressDefault(int peopleAddressDefault) {
		this.peopleAddressDefault = peopleAddressDefault;
	}
	/**
	 * 枚举类形参方法
	 * @param peopleAddressDefault
	 */
	public void setPeopleAddressDefault(BaseEnum peopleAddressDefault) {
		this.peopleAddressDefault = peopleAddressDefault.toInt();
	}

	public int getPeopleAddressAppId() {
		return peopleAddressAppId;
	}

	public void setPeopleAddressAppId(int peopleAddressAppId) {
		this.peopleAddressAppId = peopleAddressAppId;
	}

	public int getPeopleAddressStreet() {
		return peopleAddressStreet;
	}

	public void setPeopleAddressStreet(int peopleAddressStreet) {
		this.peopleAddressStreet = peopleAddressStreet;
	}
	
	

}
