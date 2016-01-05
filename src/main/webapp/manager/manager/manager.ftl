<!DOCTYPE html>
<html lang="en">
<head>
  	<#include "/manager/include/macro.ftl"/>
  	<#include "/manager/include/meta.ftl"/>   
</head>
<body>
<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="管理员管理"></@ms.contentNav >
			<@ms.contentPanel>
				<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						<@ms.panelNavBtnAdd  id="totalAdd" title=""/>
						<@ms.panelNavBtnDel  id="totalDelete"/>
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
	              <@ms.table head=['<th style="text-align:center;width:10%;"><input type="checkbox" id="allCheck" value="全选" data-original-title="全选删除" data-toggle="tooltip"/></th>','账号','昵称','密码','角色名称',"<th style='text-align:center'>添加时间</th>","<th style='text-align:center;width:10%;'>操作</th>"]>
	           			<#if listManager?has_content>
	           				<#list listManager as manager>
	                    	<tr>
						          	<td style="text-align:center;width:10%;">
					            		<#if manager.managerName != managerSession.managerName>
		  									<input type="checkbox" name="checkbox" value="${manager.managerId?c?default(0)}">
		  								</#if>
						            </td>	          	
						            <td style="width:10%">${manager.managerName?default("暂无")}</td>
						            <td style="width:10%">${manager.managerNickName?default("暂无")}</td>
						 			<td style="width:25%">${manager.managerPassword?default("暂无")}</td>
						            <td style="width:10%">${manager.roleName?default("暂无")}</td>
						            <td class="text-center">${manager.managerTime?string("yyyy-MM-dd HH:mm:ss")}</td>
						            <td class="text-center operate">
						            	<a class="btn btn-xs tooltips  addPage" data-toggle="tooltip" data-id="${manager.managerId?c?default(0)}" data-original-title="绑定">
					                     		<i class="glyphicon glyphicon-plus"></i>
					                    </a>
						            	<#if manager.managerName != managerSession.managerName>
						                    <!--a class="btn btn-xs tooltips updateModalBtn" data-toggle="tooltip" data-id="${manager.managerId?c?default(0)}" data-original-title="编辑">
					                     		<i class="glyphicon glyphicon-pencil"></i>
					                    	</a-->
				                    	</#if>	
									</td>
						         </tr>
	                    	</#list>
	                 		<#else>
	                 			<tr>
						            <td colspan="5" class="text-left">
						            	<@ms.nodata/>
									</td>
					          	</tr>
	        			</#if>
	        			</@ms.table>
					<@showPage page=page/>
			</@ms.contentPanel>		
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
		
		<!--修改/保存的模态框开始-->
		<@ms.modal modalName="update" title="">
			 <@ms.modalBody>
				<@ms.form isvalidation=true name="updateManager" id="updateManager" class="form-inline" action="">	
		    		<@ms.text name="managerName"  style="width:40%"  label="账号" title="账号" maxlength="30" placeholder="请输入账号" validation={"required":"true", "data-bv-notempty-message":"账号不能为空"}/>
		    		<@ms.text name="managerNickName"  style="width:40%"  label="昵称" title="昵称"  maxlength="30" placeholder="请输入昵称" validation={"required":"true", "data-bv-notempty-message":"昵称不能为空"}/>
		    		<@ms.text name="managerPassword"  style="width:40%"  label="密码" title="密码"  maxlength="100" placeholder="请输入密码"/>	
					<@ms.select  name="managerRoleID" label="选择角色"  list="listRole"  id="orderStatus" listKey="roleId"  listValue="roleName" value="" style="width:57%" validation={"required":"true", "data-bv-notempty-message":"角色不能为空"}/>
	    			<input type="hidden" class="managerPeopleID" name="managerPeopleID" value="0"/>
					<input type="hidden" class="oldManagerName" name="oldManagerName" value=""/>
		    	</@ms.form>		          	
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeUpdate"/>  
	 			<@ms.savebutton id="updateButton"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--修改/保存的模态框结束-->
		
		<!--多选删除的模态框开始-->
		<@ms.modal modalName="deleteAll" title="批量删除管理员">
			 <@ms.modalBody>
				您确定删除您所勾选的管理员吗？
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeDelete"/>  
	 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--多选删除的模态框结束-->
		<!--单个删除的模态框开始-->
		<@ms.modal modalName="deleteRadio" title="删除管理员">
			 <@ms.modalBody>
				您确定删除您所勾选的管理员吗？
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeRadio"/>  
	 			<@ms.button class="btn btn-danger" id="deleteRadio" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--单个删除的模态框结束-->
		
		<@ms.modal modalName="managerPageModel" title="主页面绑定">
			 <@ms.modalBody>
				<@ms.form isvalidation=true name="managerPageForm" id="managerPageForm" class="form-inline" action="${base}/manager/managerModelPage/save.do">	
		    		<@ms.text name="managerModelPageUrl"  style="width:40%"  label="主界面地址:" title="主界面地址:" size="5" maxlength="30" placeholder="请输入主页面地址"/>
		    		<@ms.select  name="managerModelPageModelId" label="选择模块"  list="listManager"  id="orderStatus" listKey="managerRoleID"  listValue="roleName" value="" style="width:57%"/>
		  			<input type="hidden"  name="managerModelPagemanagerId">
		    	</@ms.form>		          	
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeSaveUrl"/>  
	 			<@ms.savebutton id="saveUrl"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--=================模态框部分结束=================-->
	</@ms.content>
	<script>				
	var URL='';
	//模态框的操作
	$(function () {	
		$("#totalAdd").click(function(){
			$("#updateTitle").text("新增管理员");	
			$("#updateButton").text("保存");
			URL="${base}/manager/manager/save.do";
	 		$(".update").modal();
	 	});
	 	$("#closeUpdate").click(function(){
	 		$(".update").modal("hide");
	 	});
	 	
	 	$("#closeDelete").click(function(){
	 		$(".deleteAll").modal("hide");
	 	});
	 	
	 	$("#closeRadio").click(function(){
	 		$(".deleteRadio").modal("hide");
	 	});
	 	
	 	$("#closeSaveUrl").click(function(){
	 		$(".managerPageModel").modal("hide");
	 	});	
	});
	 	
 		//全选
	   	$("#allCheck").on("click",function(){   
			if(this.checked){
			      $("input[name='checkbox']").each(function(){this.checked=true;});
			}else{
			      $("input[name='checkbox']").each(function(){this.checked=false;});   
			}   
		}); 
		
	 //点击更新按钮
	 $("#updateButton").click(function() {
			var formData = $("#updateManager").serialize();
			var vobj = $("#updateManager").data('bootstrapValidator').validate();
			if(vobj.isValid()){
					$.ajax({
					   type: "post",
					   dataType: "json",
					   url:  URL,
					   data: formData, 
					   beforeSend:function(){
					   		$("#updateButton").text($("#updateButton").text()+"中");
					   		$("#updateButton").attr("disabled",true);
					   },
					   success: function(msg){ 
					   		if(msg.result==true){
					   			if($("#updateButton").text() == "保存中"){
					   				alert("保存成功!");
					   			}else{
					   				alert("更新成功!");
					   			}
					   			location.reload();
					   		}else{
					   			alert(msg.resultMsg);
					   		}
					   },error: function(){
					   	  alert("数据请求失败，请检查请求地址和参数是否正确");
					   	  location.href = base+"/manager/role/add.do";
					   }
				});
			 }
			
	 });
	 
	$(".updateModalBtn").click(function(){
		$("#updateTitle").text("编辑管理员");			
		$("#updateButton").text("更新");	
		//找到点击的id
		var managerId =  $(this).attr("data-id");
		URL="${basePath}/manager/manager/"+managerId+"/edit.do";
		$.ajax({
			type: "post",
			dataType:"json",
			url:  URL,
			data: "managerId=" + managerId,
			success: function(msg){	
	   			if(msg.manager != null){
			   		$("input[name='managerName']").val(msg.manager.managerName);
			   		$("input[name='oldManagerName']").val(msg.manager.managerName);
			   		$("input[name='managerNickName']").val(msg.manager.managerNickName);
			   		$("input[name='managerPassword']").val(msg.manager.managerPassword);
			   		$("input[name='managerRoleID']").val(msg.manager.managerRoleID);
			   		$("select[name=managerRoleID]").find("option[value="+msg.manager.managerRoleID+"]").attr("selected",true);
		   		}
		   },error: function(){
		   	  alert("系统异常");
		   }
		});
		URL = "${base}/manager/manager/update.do?managerId="+managerId;
		$(".update").modal();
	});
	 
	 $("#totalDelete").click(function(){
	 	var radioData = $("input[name='checkbox']").serialize();
		if(radioData!=""){
			$(".deleteAll").modal();//打开
		}else{
			alert("请选择需要删除的管理员！");
		}
	 });
	 
	 
	 	//批量删除管理员
		$("#deleteButton").click(function(){
			var count = 0;
			var checkboxData = $("input[name='checkbox']").serialize();
			$("input[name='checkbox']").each(function(){
				if(this.checked==true){
					count++;
				}
			});
			if(checkboxData.length != 0) {
				$.ajax({
				   type: "post",
				   dataType: "json",
				   url:  base+"/manager/manager/allDelete.do",
				   data: checkboxData,
				   beforeSend:function(){
				   		$("#deleteButton").text("删除中");
				   		$("#deleteButton").attr("disabled",true);
				   },
				   success: function(msg){
				   		alert("删除管理员成功");
				   		if($("tbody tr").length == count && msg != 1){
				     		location.href = base+"/manager/manager/queryList.do?pageNo="+(msg-1);
						}else{
				     		location.href = base+"/manager/manager/queryList.do?pageNo="+msg;
						}
				   },error: function(){
				   	  alert("批量删除管理员失败");
				      $(".deleteAll").modal("hide");
				   }
				});
			 } else {
				alert("删除失败，请先选择管理员");
				$(".deleteAll").modal("hide");
			 }
		 });
		 
		 
		 var radioManagerId 
		 $(".delete").click(function(){
		 	radioManagerId =  $(this).attr("data-id");
 		 	$(".deleteRadio").modal();
		 });
		 
		 //删除单个
		 $("#deleteRadio").click(function(){
		 	$.ajax({
			   type: "post",
			   dataType: "json",
			   url:  "${base}/manager/manager/"+radioManagerId+"/delete.do",
			   data: "managerId=" + radioManagerId,
			   success: function(msg){
			    	if(msg != 0) {
						alert("删除管理员成功");
			    		if($("tbody tr").length==0 && msg != 1){
			    			location.href = base+"/manager/manager/queryList.do?pageNo="+(msg-1);
						}else{
							location.href = base+"/manager/manager/queryList.do?pageNo="+msg;
						}
			    	} else {
						alert("删除管理员失败");
				    	$(".closeModal").click();
			    	}
			   },error: function(){
			   	  alert("系统异常");
			   }
			});
		 });
		 
		
		 //点击弹出管理员主界面新增或更新弹出框
		$(".addPage").click(function(){
			var managerModelPageModelId = $(this).attr("data-id");
			$("input[name='managerModelPagemanagerId']").val($(this).attr("data-id"));
			//查询该管理员的模块信息
			$.ajax({
			   type: "post",
			   dataType: "json",
			   url:  base+"/manager/model/"+$(this).attr("data-id")+"/queryModelByRoleId.do",
			   data:$("#managerPageForm").serialize(),
			   success: function(msg){
			     	if(msg.result){
			     		var modelJson =jQuery.parseJSON( msg.resultMsg);
			     		$("select[name='managerModelPageModelId']").html("");
			     		for (i=0;i<modelJson.length;i++) {
							if (modelJson[i].modelModelId==0) {
								$("select[name='managerModelPageModelId']").append("<option  value="+modelJson[i].modelId+">"+modelJson[i].modelTitle+"</option>");
							}
						}
			     	} 
			   }
			});
			//查询该管理员是否绑定主界面
			var modelId=0;
			queryModelPage(modelId,managerModelPageModelId);
			$(".managerPageModel").modal();
		});
		//查询模块是否绑定主界面
		function queryModelPage(modelId,managerModelPageModelId){
			$.ajax({
			   type: "post",
			   dataType: "json",
			   url:  "${base}/manager/managerModelPage/"+modelId+"/getEntity.do",
			   data:"managerModelPageModelId="+managerModelPageModelId,
			   success: function(msg){
			     	if(msg.result){
			     		var json =jQuery.parseJSON(msg.resultMsg);
			     		alert(msg);
			     		$("input[name='managerModelPageUrl']").val(json.managerModelPageUrl);
			     	} 
			   }
			});
		}
		
		//点击保存时，开始主界面信息的保存
		$("#saveUrl").click(function(){
			$.ajax({
				type: "post",
				dataType: "json",
				url:  "${base}/manager/managerModelPage/save.do",
				data:$("#managerPageForm").serialize(),
				beforeSend:function(){
					$("#saveUrl").text("保存中");
					$("#saveUrl").attr("disabled",true)
				},
				success: function(msg){
					if(msg){
			     		alert("保存成功");
			     		location.href = base+"/manager/manager/queryList.do";
			     	} 
			   	}
			});
		});
	</script>
</body>
</html>
