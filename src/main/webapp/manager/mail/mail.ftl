<!DOCTYPE html>
<html lang="zh">
<head>
  	<#include "/manager/include/macro.ftl"/>
  	<#include "/manager/include/meta.ftl"/>
</head>
<body>	
	<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="邮件管理页">
				<#if mailEntity?has_content>
								<@ms.panelNavBtnSave  value="更新" title="更新" id="updateButton"/>
					<#else>
								<@ms.panelNavBtnSave value="保存" title="保存" id="updateButton"/>
				</#if>
			</@ms.contentNav>
				<@ms.contentPanel>
		    			<@ms.form isvalidation=true name="saveMail" style="width: 55%" class="form-inline" action="${base}/manager/mail/save.do">
				    		<@ms.text name="mailName" label="标题:" title="标题"  maxlength="30"   validation={"required":"true", "data-bv-notempty-message":"请填写标题"}/>
				    		<@ms.text name="mailPassword" label="密码:" title="密码" maxlength="30" style="width: 45%"  validation={"required":"true", "data-bv-notempty-message":"请填写密码"}/>
				    		<@ms.text name="mailPort" label=" 服务器端口:" title=" 服务器端口" maxlength="5" style="  width: 15%" validation={"pattern":"^[0-9]*$","required":"true", "data-bv-notempty-message":"请填写服务器端口"}/>
				    		<@ms.text name="mailServer" label="发送地址:" title="发送地址" maxlength="50"  validation={"required":"true", "data-bv-notempty-message":"请填写发送地址"}/>
		    			</@ms.form>	
	        	</@ms.contentPanel>		
		</@ms.contentBody>
	</@ms.content>
</body>
</html>
<script>

	<#if mailEntity?has_content>
   		$("input[name='mailName']").val("${mailEntity.mailName?default("")}");
   		$("input[name='mailPassword']").val("${mailEntity.mailPassword?default("")}");
   		$("input[name='mailPort']").val("${mailEntity.mailPort?c?default(0)}");
   		$("input[name='mailServer']").val("${mailEntity.mailServer?default("")}");
		$("#saveMail").attr("action","${base}/manager/mail/update.do");	
	</#if>

		 //点击更新按钮
	 $("#updateButton").click(function() {
	 		
	 		var vobj = $("#saveMail").data('bootstrapValidator').validate();
	 		if(vobj.isValid()){
				//idValid()  ：功能检查对象变量是否已经实例化
				
				$(this).postForm("#saveMail",{func:function(data) {
					location.reload();
					<#if smsEntity?has_content>
					alert("修改成功");
					<#else>
					alert("保存成功");
					</#if>
				}})
			} else {
				alert("保存失败");
			}    		
 		})
</script>








