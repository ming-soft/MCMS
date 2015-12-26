<!DOCTYPE html>
<html lang="en">
<head>
	 <#include "/manager/include/macro.ftl"/>
  	<#include "/manager/include/meta.ftl"/>
</head>
<body>
<@ms.content>
	<@ms.contentBody>
		<@ms.contentNav title="添加站点">
			<@ms.button class="btn btn-success"  id="saveOrUpdateApp"  value="保存"/>
		</@ms.contentNav >
		<@ms.contentPanel>

			<@ms.form isvalidation=true name="appForm" style="width: 65%;" class="form-inline" action="${base}/manager/app/save.do">
				<@ms.text name="appName" label="网站标题" value="${app.appName?default('')}"  title="网站标题" placeholder="请输入网站标题" style="width:40%;"  validation={"maxlength":"50","required":"true", "data-bv-notempty-message":"必填项目","data-bv-stringlength-message":"网站标题在50个字符以内!"}/>
            	<div class="form-group">
        			<label class="col-md-3  col-xs-3" style="width:30%">网站logo</label>
        			<div class="col-md-4  col-xs-4" style="padding: 0;">
        				<@uploadImg path="upload/app/${app.appId?c?default(0)}/" inputName="appLogo" size="1" filetype="" msg="提示:网站logo图片"  maxSize="1" imgs="${app.appLogo?default('')}" />
					</div>
           	   </div>
            	<div class="form-group ms-form-group">	
					<label for="appKeyword">启动移动端</label>
					<div class="ms-form-control" style="height:auto;margin-top: 8px;">
						<input type="checkbox" name="mobile" style="float:left"/>
						<div style="float: left;margin-left: 5px;">启用</div>
					</div>
				</div>
				<@ms.textarea name="appUrl"  label="域 名"  rows="4" value="${app.appUrl?default('')}" placeholder="使用回车换行可以输入多个域名地址，必须要加http://" validation={"maxlength":"150","required":"true","data-bv-notempty-message":"必填项目", "data-bv-stringlength-message":"长度在150个字符以内!"} />
				<#if SystemManager==true>
				<#else>
					<!--普通管理员下拉选择-->
					<@ms.select name="appStyle" id="appStyle" label="模板风格" list=["暂无模版"]  value="${app.appStyle?default('暂无模版')}" validation={"required":"true", "data-bv-notempty-message":"必填项目"}/>
				</#if>
				
				<@ms.textarea name="appKeyword"  label="关键字"  value="${app.appKeyword?default('')}" rows="4"  placeholder="请输入关键字"/>
				<@ms.textarea name="appDescription"  label="描述"  value="${app.appDescription?default('')}" rows="4"  placeholder="请输入站点描述"/>
				<@ms.textarea name="appCopyright"  label="版权信息"  value="${app.appCopyright?default('')}" rows="4"  placeholder="请输入版权信息"/>
				<input type="hidden" name="appMobileStyle" value="${app.appMobileStyle?default('')}"/>
				<#if SystemManager==true>
					<!--超级管理员对站点的管理-->
					<@ms.date name="appPayDate" label="应用续费时间" size="6" value="${(app.appPayDate?string('yyyy-MM-dd'))!''}" single=true  placeholder="点击选择时间段"/> 
					<@ms.textarea name="appPay"  label="应用费用清单"  rows="4" value="${app.appPay?default('')}"  placeholder="请输入应用费用清单"/>
					<@ms.text name="appId"style="display:none" readonly="readonly" value="${app.appId?c?default(0)}"/>
				</#if>
			</@ms.form>	
			
		</@ms.contentPanel>
	</@ms.contentBody>
</@ms.content>

<script>
	$(function(){
		//如果已启用手机端则，默认选中
		if($("input[name=appMobileStyle]").val()=="m"){
			$("input[name=mobile]").prop("checked",'true')
		}
		
		$("input[name=mobile]").click(function(){
			//$("input[name=mobile]").prop("checked",'true')
		})
		
		<#if app.appId != 0>
			$("#saveOrUpdateApp").text("更新");
			$("#saveOrUpdateApp").prev("span").text("编辑站点");
			$("#appForm").attr("action","${base}/manager/app/update.do");
			<#if SystemManager==true>
			<#else>
				var appStyle="";
				$.ajax({
					type: "post",
					dataType: "json",
					url:  "${base}/manager/cms/templet/queryAppTempletSkin.do",
					success: function(msg){
						if(msg.fileName != null && msg.fileName.length != 0){
							//清空默认信息
							$("#appStyle").html("");
				   			for(var i=0; i<msg.fileName.length; i++){
				   				if ("${app.appStyle?default('')}"==msg.fileName[i]) {
				   					$("#appStyle").append("<option value="+msg.fileName[i]+" selected>"+msg.fileName[i]+"</option>")
				   				} else {
					   				$("#appStyle").append("<option value="+msg.fileName[i]+">"+msg.fileName[i]+"</option>")
					   			}
					   		}
				   		}else{
				   			$(".appStyle").append("<option>暂无模版</option>");
				   		}
					}
				});
			</#if>
		</#if>
		
		
		
		//点击保存或更新按钮进行保存
		$("#saveOrUpdateApp").click(function(){
			var vobj = $("#appForm").data('bootstrapValidator').validate();
			if(vobj.isValid()){
				if($("input[name=mobile]").is(':checked')){
					$("input[name=appMobileStyle]").val("m")
				}else{
					$("input[name=appMobileStyle]").val("")
				}
				
				$(this).postForm("#appForm",{func:function(msg) {
					if (msg.result) {
			     		<#if app.appId != 0>
				     			alert("更新成功");
					   			$("#updateapp").attr("disabled", true);
					   			if(msg.resultData==1){
					    			location.href="${base}/manager/app/list.do?pageNo="+msg.resultMsg;
					    		}else{
					    			location.href="${base}/manager/app/-1/edit.do";
					    		}
			     			<#else>
			     			alert("保存成功");
			     			$("saveapp").attr("disabled", true);
			    			location.href="${base}/manager/app/list.do";
			     		</#if>
			     		$("saveOrUpdateWeixin").attr("disabled", true);
			    	}else{
			    		alert(msg.resultMsg);
			    	}
				}});
			} else {
				alert("表单验证失败");
			}  
		});
		
	});
	
</script>
</body>
</html>

	