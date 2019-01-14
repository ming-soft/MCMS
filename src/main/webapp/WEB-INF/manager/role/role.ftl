<@ms.html5>
	<@ms.nav title="角色设置" back=true>
		<@ms.saveButton id="save"/>
		<@ms.resetButton id="reset" value="重置" onclick=" " />
	</@ms.nav>
	<@ms.panel>
		<@ms.form isvalidation=true name="saveRoleFrom" style="width: 55%" action="">
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
		<#if !listModel?has_content>
			<@ms.nodata/>	
		</#if>
	</@ms.panel>
</@ms.html5>
	
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
					   url:  "${managerPath}/role/judgeRoleNameExist.do",
					   data: "roleName=" + roleName,
					   success: function(msg){
					     	if(msg){
					     		<@ms.notify msg= "该角色名称已存在，请再次输入" type= "warning" />
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
	   		var nodes = zTreeObjtree.transformToArray(zTreeObjtree.getNodes());
			<#if listSelModel?has_content>
	   			<#list listSelModel as selModel>
	   				for(i=0; i<nodes.length; i++){
						if(nodes[i].modelId==${selModel.modelId}){
							zTreeObjtree.checkNode(nodes[i], true, false);
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
						<@ms.notify msg= "请选择功能模块！" type= "warning"/>
						$("#save").removeAttr("disabled");
						return;
					}
					var URL = "${managerPath}/role/<#if flag == true>save<#else>update</#if>.do";
					$.ajax({
					   type: "post",
					   dataType: "json",
					   url:  URL,
					   data: $("#saveRoleFrom").serialize() + "&modelId=" + modelId,
					   beforeSend:function(){
					   		$("#save").attr("disabled",true);
					   },
					   success: function(msg){
					     	if(msg.result){
					     		<#if flag == true>
					     			<@ms.notify msg= "保存成功" type= "success" />
					     		<#else>
					     			<@ms.notify msg= "更新成功" type= "warning" />
					     		</#if>
					   			location.href = "${managerPath}/role/queryList.do";
					    	} else {
					    	    $('.ms-notifications').offset({top:43}).notify({
					    			type:'warning',
					    			message: { text:msg.resultMsg }
					 			}).show();	
					    	}
					    	$("#save").removeAttr("disabled");
					   },error: function(){
					   	  	<@ms.notify msg= "操作失败" type= "danger" />
					   		$("#save").removeAttr("disabled");
					   	  	location.href = "${managerPath}/role/queryList.do";
					   }
					});
				}
			});
		});	
		
		
		
	</script>
