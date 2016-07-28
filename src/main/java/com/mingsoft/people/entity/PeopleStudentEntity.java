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

package com.mingsoft.people.entity;



/**
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 *
 * @author 王天培
 *                QQ:78750478
 *
 * <p>
 * Comments:学生
 * </p>
 *
 * <p>
 * Create Date:2014-12-18
 * </p>
 *
 * <p>
 * Modification history:
 * </p>
 */
public class PeopleStudentEntity extends PeopleUserEntity{
	
	private int peopleStudentPeopleId;
	/**
	 * 学生学历
	 */
	private int peopleStudentEducation;
	
	/**
	 * 学生入学年份
	 */
	private int peopleStudentIndate;
	
	/**
	 * 大学所在城市
	 */
	private int peopleStudentCityID;
	
	/**
	 * 学校名称
	 */
	private String peopleStudentSchool;
	
	/**
	 * 所在院系
	 */
	private String peopleStudentDepartment;
	
	/**
	 * 所在专业
	 */
	private String peopleStudentSpecialty;
	
	/**
	 * 学生班级
	 */
	private String peopleStudentClass;
	
	/**
	 * 学生学号
	 */
	private String peopleStudentNo;
	
	/**
	 * 学生宿舍号
	 */
	private String peopleStudentRoom;
	

	

	/**
	 * 获取学生所在城市
	 * @return
	 */
	public int getPeopleStudentCityID() {
		return peopleStudentCityID;
	}
	
	/**
	 * 获取学生班级
	 * @return
	 */
	public String getPeopleStudentClass() {
		return peopleStudentClass;
	}

	/**
	 * 获取学生所在系部
	 * @return
	 */
	public String getPeopleStudentDepartment() {
		return peopleStudentDepartment;
	}
	
	/**
	 * 获取学生学历
	 * @return
	 */
	public int getPeopleStudentEducation() {
		return peopleStudentEducation;
	}
	
	/**
	 * 获取学生入学年份
	 * @return
	 */
	public int getPeopleStudentIndate() {
		return peopleStudentIndate;
	}
	
	/**
	 * 获取学生学号
	 * @return
	 */
	public String getPeopleStudentNo() {
		return peopleStudentNo;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getPeopleStudentPeopleId() {
		return peopleStudentPeopleId;
	}
	
	/**
	 * 获取学生宿舍号
	 * @return
	 */
	public String getPeopleStudentRoom() {
		return peopleStudentRoom;
	}

	/**
	 * 获取学生所在学校
	 * @return
	 */
	public String getPeopleStudentSchool() {
		return peopleStudentSchool;
	}
	
	/**
	 * 获取学生专业
	 * @return
	 */
	public String getPeopleStudentSpecialty() {
		return peopleStudentSpecialty;
	}
	
	/**
	 * 设置学生所在城市
	 * @param peopleStudentCityID
	 */
	public void setPeopleStudentCityID(int peopleStudentCityID) {
		this.peopleStudentCityID = peopleStudentCityID;
	}
	
	/**
	 * 设置学生班级
	 * @param peopleStudentClass
	 */
	public void setPeopleStudentClass(String peopleStudentClass) {
		this.peopleStudentClass = peopleStudentClass;
	}
	
	/**
	 * 设置学生所在系部
	 * @param peopleStudentDepartment
	 */
	public void setPeopleStudentDepartment(String peopleStudentDepartment) {
		this.peopleStudentDepartment = peopleStudentDepartment;
	}
	
	/**
	 * 设置学生学历
	 * @param peopleStudentEducation
	 */
	public void setPeopleStudentEducation(int peopleStudentEducation) {
		this.peopleStudentEducation = peopleStudentEducation;
	}
	
	/**
	 *  设置学生入学年份
	 * @param peopleStudentIndate
	 */
	public void setPeopleStudentIndate(int peopleStudentIndate) {
		this.peopleStudentIndate = peopleStudentIndate;
	}
	
	/**
	 * 设置学生学号
	 * @param peopleStudentNo
	 */
	public void setPeopleStudentNo(String peopleStudentNo) {
		this.peopleStudentNo = peopleStudentNo;
	}
	
	/**
	 * 
	 * @param peopleStudentPeopleId
	 */
	public void setPeopleStudentPeopleId(int peopleStudentPeopleId) {
		this.peopleStudentPeopleId = peopleStudentPeopleId;
	}
	
	/**
	 * 设置学生的宿舍号
	 * @param peopleStudentRoom
	 */
	public void setPeopleStudentRoom(String peopleStudentRoom) {
		this.peopleStudentRoom = peopleStudentRoom;
	}
	
	/**
	 * 设置学生所在学校
	 * @param peopleStudentSchool
	 */
	public void setPeopleStudentSchool(String peopleStudentSchool) {
		this.peopleStudentSchool = peopleStudentSchool;
	}
	
	/**
	 * 设置用户专业
	 * @param peopleStudentSpecialty
	 */
	public void setPeopleStudentSpecialty(String peopleStudentSpecialty) {
		this.peopleStudentSpecialty = peopleStudentSpecialty;
	}
	
	
}