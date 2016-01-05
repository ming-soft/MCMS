<!DOCTYPE html>
<html lang="zh">
<head>
  	<#include "/manager/include/macro.ftl"/>
  	<#include "/manager/include/meta.ftl"/>
</head>
<body>	
	<@ms.content>
		<@ms.contentBody>
			<#if flag == true>
				<@ms.contentNav title="新增角色">
					<@ms.contentNavBack onclick="javascript:history.go(-1)" value="返回角色列表"/>
				</@ms.contentNav>
			<#else>
				<@ms.contentNav title="编辑角色">
					<@ms.contentNavBack onclick="javascript:history.go(-1)" value="返回角色列表"/>
				</@ms.contentNav>
			</#if>	
				
				<@ms.contentPanel>
		    			<@ms.form isvalidation=true name="saveRoleFrom" style="width: 55%" class="form-inline" action="">
				    		<@ms.text name="roleName" label="角色名称:" title="角色名称"  maxlength="30"  validation={"required":"true", "data-bv-notempty-message":"请填写标题"}/>
				    		<#if flag == false><input type="hidden" name="roleId" value="${role.roleId}"/><input type="hidden" id="oldRoleName" name="oldRoleName" value="${role.roleName}"/></#if>
				    		<!-- 树形模块菜单开始 -->	
								<#if listModel?has_content>
										<@ms.tree label="模块列表:" treeId="tree" json="${listModel?default('')}" jsonId="modelId" jsonPid="modelModelId" jsonName="modelTitle"  showIcon="true" expandAll="true" ischeck="true"/>
			    					<#else> 
										<@ms.treeInput  treeId="errorTree"  buttonText="暂无数据"/>
			    				</#if>	
			    			<!-- 树形模块菜单结束 -->
		    			</@ms.form>	
		    			<#if listModel?has_content>
			    			<@ms.buttonarea style="margin-left: 18%">
			    			   <#if flag == true><@ms.savebutton id="save"/> <#else><@ms.savebutton id="save" value="更新"/> </#if>
				    			
				    			<@ms.button id="reset" style="margin-left:1%" value="重置" /> 
			    			</@ms.buttonarea>
			    		<#else>
			    			<@ms.nodata/>	
			    		</#if>
	        	</@ms.contentPanel>		
		</@ms.contentBody>
	</@ms.content>
	
	<script type="text/javascript">
		
			
		<#if flag == true>
	     	 $("input[name='roleName']").attr("placeholder","请输入角色名称")       
		<#else>
			 $("input[name='roleName']").val("${role.roleName}");
		</#if>
			
		$(function () {
			//前端验证角色名称是否存在
			$("input[name='roleName']").blur(function(){
				var oldRoleName = $("#oldRoleName").length;
				var roleName = $(this).val();
				if((oldRoleName != 0 && $("#oldRoleName").val() != roleName) || (oldRoleName == 0)){
					$.ajax({
					   type: "post",
					   dataType: "json",
					   url:  "${base}/manager/role/judgeRoleNameExist.do",
					   data: "roleName=" + roleName,
					   success: function(msg){
					     	if(msg){
					     		alert("该角色名称已存在，请再次输入");
					     		$("input[name='roleName']").val(null);
					     	} 
					   }
					});
				}
			});
			//点击重置按钮取消树形菜单的选中
			$("#reset").click(function(){
				 zTreeObjtree.checkAllNodes(false);
			});
			
			
			//更新角色时勾选出该角色所拥有的模块
			<#if listSelModel?has_content>
	   			<#list listSelModel as selModel>
	   				var nodes = zTreeObjtree.getNodes();
	   				for(var i=0; i<nodes.length; i++){
						if(nodes[i].modelId==${selModel.modelId}){
							zTreeObjtree.checkNode(nodes[i], true, true);
						}
						
					}
				</#list>
			</#if> 
			
			//声明需要获取的树形菜单的每一个子节点的id
			var modelId = new Array();
			
			//保存按钮点击提交表单
			$("#save").click(function(){
				if($("#saveRoleFrom").data('bootstrapValidator').validate().isValid()){
					$(this).attr("disabled","true");
					var nodes = zTreeObjtree.getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++){
						modelId[i] = nodes[i].modelId;
					}
					if(modelId==""||modelId==null||modelId==undefined){
						alert("请选择功能模块！");
						$("#save").removeAttr("disabled");
						return;
					}
					var URL = "${base}/manager/role/<#if flag == true>save<#else>update</#if>.do";
					$.ajax({
					   type: "post",
					   dataType: "json",
					   url:  URL,
					   data: $("#saveRoleFrom").serialize() + "&modelId=" + modelId,
					   beforeSend:function(){
					   		$("#save").text($("#save").text()+"中");
					   		$("#save").attr("disabled",true);
					   },
					   success: function(msg){
					     	if(msg.result){
					     		alert("<#if flag == true>保存<#else>更新</#if>成功");
					   			location.href = "${base}"+msg.resultMsg;
					    	} else {
					    	    alert(msg.resultMsg);
					    	}
					    	$("#save").removeAttr("disabled");
					   },error: function(){
					   	  	alert("操作失败");
					   	$("#save").removeAttr("disabled");
					   	  	location.href = "${base}/manager/role/queryList.do";
					   }
					});
				}
			});
		});	
		
		
		
	</script>
	
</body>
</html>