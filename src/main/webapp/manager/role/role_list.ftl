<!DOCTYPE html>
<html lang="en">
<head>
	<#include "/manager/include/meta.ftl"/>
	<#include "/manager/include/macro.ftl"/>
<style>

</style>
</head>
<body>
	<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="角色管理">
			</@ms.contentNav>
			<@ms.contentPanel>
				<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						<@ms.panelNavBtnAdd  id="totalAdd"/>
						<@ms.panelNavBtnDel  id="totalDelete"/>
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
					
					<@ms.table head=['<th class="text-center"><input type="checkbox" id="allCheck"/></th>','<th style="width:7%;text-align:center;">编号</th>','角色名称',"<th style='text-align:center;width:10%;'>操作</th>"]>
						<#if listRole?has_content>
		           			<#list listRole as role>
					          <tr>
					            <td style="width:5%" class="text-center">
						          	<#if role.roleId!=managerRoleId>
		  								<input type="checkbox" name="ids" value="${role.roleId?c?default(0)}">
						            </#if>
					            </td>
					            <input type="hidden" name="${role.roleId?c?default(0)}" />
					            <td style="width:7%" class="roleId text-center">${role.roleId?c?default(0)}</td>
			            		<td style="width:40%">${role.roleName?default("暂无")}</td>
					            <td class="text-center operate">
				                    <a class="btn btn-xs tooltips" data-toggle="tooltip" href="${base}/manager/role/${role.roleId}/edit.do" data-original-title="编辑">
			                     		<i class="glyphicon glyphicon-pencil"></i>
			                    	</a>
								</td>
					          </tr>
				           </#list>
						<#else>
		           			<tr>
					            <td colspan="4" class="text-center">
					            	<a href="${base}/manager/role/add.do"><@ms.nodata/></a>
								</td>
				          	</tr>
		           		</#if>
					</@ms.table>	
					<@showPage page=page/>
			</@ms.contentPanel>
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
		<!--删除的模态框开始-->
		<@ms.modal modalName="delete" title="删除角色">
			 <@ms.modalBody>
				确定删除该角色吗？
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeDelete"/>  
	 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--删除的模态框结束-->
		<!--多选删除的模态框开始-->
		<@ms.modal modalName="deleteAll" title="多选删除角色">
			 <@ms.modalBody>
				您确定删除您所勾选的角色么？
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeAllDelete"/>  
	 			<@ms.button class="btn btn-danger" id="deleteButtonAll" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--多选删除的模态框结束-->
		<!--=================模态框部分结束=================-->
	</@ms.content>
	
	<script type="text/javascript">	
		
		//触发模态框事件或者是模态框中按钮的事件
		$(function(){
				var roleId;
				//删除角色
				$(".del-btn").on("click",function(){
					roleId = $(this).attr("data-id");
					$(".delete").modal();
				});
		
				$("#deleteButton").click(function(){
					deleteRole(roleId);
				});
				
				$("#closeDelete").click(function(){
					$(".delete").modal("hide");
				});
				
				$("#totalDelete").click(function(){
					$(".deleteAll").modal();
				});
				$("#closeAllDelete").click(function(){
					$(".deleteAll").modal("hide");
				});
				
				
				
				//全选
			   	$("#allCheck").on("click",function(){   
					if(this.checked){   
						$("input[name='ids']").each(function(){this.checked=true;});
					}else{   
						$("input[name='ids']").each(function(){this.checked=false;});   
					}   
				}); 
				
				//批量删除
				$("#deleteButtonAll").on("click",function(){
					batchDelete();
				});
		});
	
		//删除角色
		function deleteRole(roleId){
			//拼接ajax地址
			var URL="${base}/manager/role/"+roleId+"/delete.do";
			$("#deleteButtonAll").text("删除中");
			$("#deleteButtonAll").attr("disabled",true);
			$(this).request({url:URL,data:"roleId=" + roleId,type:"json",method:"post",func:function(msg) {
				//回调处理方式
				if(msg != 0) {
			    	$("input[name="+roleId+"]").parent().remove();
		    		alert("删除角色成功");
		    		if($("tbody tr").length==0 && msg != 1){
		    			location.href = base+"/manager/role/queryList.do?pageNo="+(msg-1);
					}else{
						location.href = base+"/manager/role/queryList.do?pageNo="+msg;
					}
		    	} else {
					alert("删除失败");
		    	}
		    	location.reload();
			}});
		}
		
		//批量删除角色
		function batchDelete(){
			var count = 0;
			var ids = $("input[name='ids']").serialize();
			$("input[name='ids']").each(function(){
				if(this.checked==true){
					count++;
				}
			});	
			if(ids.length != 0) {
				var URL= "${base}/manager/role/allDelete.do";
				$("#deleteButtonAll").text("删除中");
				$("#deleteButtonAll").attr("disabled",true);
				$(this).request({url:URL,data:ids,type:"json",method:"post",func:function(msg) {
                	if(msg != 0) {
			   			alert("批量删除成功");
			   			if($("tbody tr").length == count && msg != 1){
		    				location.href = base+"/manager/role/queryList.do?pageNo="+(msg-1);
						}else{
							location.href = base+"/manager/role/queryList.do?pageNo="+msg;
						}
			   		} else {
			    		alert("删除角色失败");
			    		$("#deleteButtonAll").text("删除");
						$("#deleteButtonAll").attr("disabled",false);
						$(".deleteAll").modal("hide");
			    	}
				}});
			 } else {
				alert("删除失败，请先选择管理员");
				$(".deleteAll").modal("hide");
			 }
		}
		
		$("#totalAdd").click(function(){
			location.href = "${base}/manager/role/add.do"
		});
	</script>
	
</body>
</html>
