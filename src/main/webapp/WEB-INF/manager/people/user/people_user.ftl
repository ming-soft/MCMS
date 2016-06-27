<@ms.html5>
	<@ms.nav title="用户管理" back=true>
		<@ms.saveButton  id="saveUpdate" postForm="peopleForm" /> 
	</@ms.nav>
	<@ms.panel>
		<@ms.form isvalidation=true name="peopleForm" action="${managerPath}/people/user/${autoCURD}.do" redirect="${managerPath}/people/user/list.do?${params}">
			<@ms.text name="peopleUserNickName" width="300" label="用户昵称"	title="用户昵称" size="5"  placeholder="请输入文章标题"  value="${peopleUser.peopleUserNickName?default('')}" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"12","data-bv-stringlength-message":"昵称不能超过12个字符"}/>
			<@ms.text name="peopleName" label="用户名" placeholder="请输入用户名"  title="" size="5" width="300"  value="${peopleUser.peopleName?default('')}" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"12","data-bv-stringlength-message":"用户名长度不能超过12个字符"}/>
			<@ms.password name="peoplePassword" label="密码"   title="" size="5" width="300"  validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-message":"密码长度不能超过20个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z0-9_]+$',"data-bv-regexp-message":"密码只能由英文字母，数字，下划线组成!"}/>
			<@ms.text name="peoplePhone" label="手机号" placeholder="请输入手机号" title="" size="5" width="300" value="${peopleUser.peoplePhone?default('')}" validation={"maxlength":"18","data-bv-stringlength":"true","data-bv-stringlength-max":"18","data-bv-stringlength-message":"手机号码长度不能超过18个字符","data-bv-regexp":"true", "data-bv-regexp-regexp":'^[1][1-8][0-9]{9}',"data-bv-regexp-message":"手机号码格式错误"}/>
			<@ms.text name="peopleMail" label="邮箱" placeholder="请输入邮箱" title="" size="5" width="300" value="${peopleUser.peopleMail?default('')}" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"50","data-bv-stringlength-message":"邮箱长度不能超过50个字符","data-bv-regexp":"true", "data-bv-regexp-regexp":'^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$',"data-bv-regexp-message":"邮箱格式错误"}/>
			<#assign peopleSexs=[{"id":"1","name":"男"},{"id":"2","name":"女"}]>
			<@ms.radio name="peopleUserSex" label="性别"  list=peopleSexs listKey="id" listValue="name" value="${peopleUser.peopleUserSex?default('1')}"/>
			<@ms.text name="peopleUserRealName" label="姓名"  placeholder="请输入姓名" title="" value="${peopleUser.peopleUserRealName?default('')}" size="2" width="300" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"8","data-bv-stringlength-message":"真实姓名长度不能超过8个字符"}/>
			<@ms.hidden name="peopleId" value="${peopleUser.peopleId?default('0')}"/>
			<@ms.formRow label="头像" width="400">
					<@ms.uploadImg path="upload/people/${appId?default(0)}/" inputName="peopleUserIcon" size="1" filetype="" msg="提示:文章缩略图,支持jpg格式"  maxSize="2" imgs="${peopleUser.peopleUserIcon?default('')}"  />
			</@ms.formRow>
			<@ms.text name="peopleUserCard" label="用户身份证" placeholder="请输入用户身份证" title="" size="5"  width="300" value="${peopleUser.peopleUserCard?default('')}"   validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"18","data-bv-stringlength-message":"身份证输入不合法"}/>
			<@ms.textarea name="peopleUserAddress"  label="用户地址"   rows="4"  placeholder="请输入用户地址" width="500" value="${peopleUser.peopleUserAddress?default('')}" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"60","data-bv-stringlength-message":"地址不能超过60个字符"}/>
		</@ms.form>
	</@ms.panel>
</@ms.html5>