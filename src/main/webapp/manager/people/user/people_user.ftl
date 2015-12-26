<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/> 
</head>
<body>
<@ms.content>
		<@ms.contentBody>
			
			<@ms.contentNav title="用户管理" >
				<@ms.savebutton  id="saveUpdate" value=""/>
				<@ms.contentNavBack  class="btn btn-default returnList" value="返回列表" />
			</@ms.contentNav >
			<@ms.contentPanel>
				<@ms.form  isvalidation=true name="peopleForm" action="${basePath}/manager/people/user/update.do" class="form-inline searchForm" style="min-height:98%">
			  			<#if peopleUser?has_content>
			  			<input type="hidden" class="form-control" name="peopleId" value="" />
			  			</#if>
			  			<@ms.row>
			  			<@ms.col size="6">
			  			
			  			<@ms.text name="peopleUserNickName" label="用户昵称" placeholder="请输入用户昵称" title="" size="5" style="width:40%" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"12","data-bv-stringlength-message":"昵称不能超过12个字符"}/>
			  			</@ms.col>
			  			<@ms.col size="12"></@ms.col>
			  			<@ms.col size="6">
			  				<@ms.text name="peopleName" label="用户名" placeholder="请输入用户名"  title="" size="5" style="width:40%" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"12","data-bv-stringlength-message":"用户名长度不能超过12个字符"}/>
			  			</@ms.col>
			  			<@ms.col size="12"></@ms.col>
			  				<#if peopleUser?has_content>
			  				<@ms.col size="6">
			  					<@ms.password name="peoplePassword" label="密码"   title="" size="5" style="width:40%" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-message":"密码长度不能超过20个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z0-9_]+$',"data-bv-regexp-message":"密码只能由英文字母，数字，下划线组成!"}/>
			  				</@ms.col>
			  				<@ms.col size="12"></@ms.col>
			  				<#else>
			  				<@ms.col size="6">
			  					<@ms.password name="peoplePassword" label="密码"   title="" size="5" style="width:40%" validation={"data-bv-stringlength":"true","required":"true", "data-bv-notempty-message":"密码不能为空","data-bv-stringlength-max":"20","data-bv-stringlength-message":"密码长度不能超过20个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z0-9_]+$',"data-bv-regexp-message":"密码只能由英文字母，数字，下划线组成!"}/>
			  				</@ms.col>
			  				<@ms.col size="12"></@ms.col>
			  				</#if>
			  				<@ms.col size="6">
			  					<@ms.text name="peoplePhone" label="手机号" placeholder="请输入手机号" title="" size="5" style="width:36%" validation={"maxlength":"18","data-bv-stringlength":"true","data-bv-stringlength-max":"18","data-bv-stringlength-message":"手机号码长度不能超过18个字符","data-bv-regexp":"true", "data-bv-regexp-regexp":'^[1][1-8][0-9]{9}',"data-bv-regexp-message":"手机号码格式错误"}/>
			  				</@ms.col>
			  				<@ms.col size="12"></@ms.col>
			  				<@ms.col size="6">
			  					<@ms.text name="peopleMail" label="邮箱" placeholder="请输入邮箱" title="" size="5" style="width:36%" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"50","data-bv-stringlength-message":"邮箱长度不能超过50个字符","data-bv-regexp":"true", "data-bv-regexp-regexp":'^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$',"data-bv-regexp-message":"邮箱格式错误"}/>
			  				</@ms.col>
			  				<@ms.col size="12"></@ms.col>
			  				<@ms.col size="6">
			  					<#assign peopleSexs=[{"id":"1","name":"男"},{"id":"2","name":"女"}]>
								<@ms.radio name="peopleUserSex" label="性别"  list=peopleSexs listKey="id" listValue="name" value="1"/>
			  				</@ms.col>
			  				<@ms.col size="12"></@ms.col>
			  				<@ms.col size="6">
			  					<@ms.text name="peopleUserRealName" label="姓名"  placeholder="请输入姓名" title="" value="" size="2" style="width:50%" validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"8","data-bv-stringlength-message":"真实姓名长度不能超过8个字符"}/>
			  				</@ms.col>
			  				<@ms.col size="12"></@ms.col>
			  				<@ms.col  style="text-align: right; width:14%;">用户头像</@ms.col>
			  				<@ms.col size="8">
								<div style="float:left;position: relative;z-index:1;">
								<#if peopleUser?has_content>
        								<@uploadImg path="upload/people/${appId?default(0)}/" inputName="peopleUserIcon" size="1" filetype="" msg="提示:用户头像,支持jpg格式"  maxSize="2" imgs="${peopleUser.peopleUserIcon?default('')}"  />
        							<#else>
        								<@uploadImg path="upload/people/${appId?default(0)}/" inputName="peopleUserIcon" size="1" filetype="" msg="提示:用户头像,支持jpg格式"  maxSize="2" imgs=""/>
        						</#if>
								</div>
							</@ms.col>
			  				
            				<@ms.col size="12"></@ms.col>
            				<@ms.col size="6">
			    				<@ms.text name="peopleUserCard" label="用户身份证" placeholder="请输入用户身份证" title="" size="5" style="width:50%"   validation={"data-bv-stringlength":"true","data-bv-stringlength-min":"15","data-bv-stringlength-max":"18","data-bv-stringlength-message":"身份证输入不合法"}/>
			    			</@ms.col>
			    			<@ms.col size="12"></@ms.col>
			    			<@ms.col size="6">
			    				<@ms.textarea name="peopleUserAddress"  label="用户地址"   rows="4"  placeholder="请输入用户地址" style="width:80%"  validation={"data-bv-stringlength":"true","data-bv-stringlength-max":"60","data-bv-stringlength-message":"地址不能超过60个字符"}/>
			    			</@ms.col>
			    			<@ms.col size="12"></@ms.col>
			    			</@ms.row>
			    	</@ms.form>
			</@ms.contentPanel>
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
		<!--删除的模态框开始-->
</@ms.content>
	
	<script>
		$(function(){
			<#if peopleUser?has_content>
				$("input[name=peopleName]").val("${peopleUser.peopleName?default('')}");
				$("input[name=peopleUserNickName]").val("${peopleUser.peopleUserNickName?default('')}");
				$("input[name=peoplePhone]").val("${peopleUser.peoplePhone?default('')}");
				$("input[name=peopleUserRealName]").val("${peopleUser.peopleUserRealName?default('')}");
				$("input[name=peopleUserCard]").val("${peopleUser.peopleUserCard?default('')}");
				$("textarea[name=peopleUserAddress]").val("${peopleUser.peopleUserAddress?default('')}");
				$("input[name=peopleId]").val("${peopleUser.peopleId?default('')}");
				$("input[name=peopleMail]").val("${peopleUser.peopleMail?default('')}");
				$("#peopleForm").attr("action","${basePath}/manager/people/user/update.do")
				$("[name='peopleUserSex'][value="+${peopleUser.peopleUserSex?default(1)}+"]").attr("checked", true);
				$("#saveUpdate").text("更新")
				<#else>
				$("#peopleForm").attr("action","${basePath}/manager/people/user/save.do")
				$("#saveUpdate").text("保存")
			</#if>
			
			
			//更新用户基本信息
			$("#saveUpdate").click(function() {
				var vobj = $("#peopleForm").data('bootstrapValidator').validate();
				if(!vobj.isValid()){
					return;
				}
				$(this).postForm("#peopleForm",{func:function(msg) {
					if(msg.result){
						alert($("#saveUpdate").text()+"成功");
						location.href=msg.resultMsg;
					}else{
						alert(msg.resultMsg);
					}
				}});
			});
			
			
		});
	</script>	
</body>
</html>	