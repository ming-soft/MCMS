<@ms.html5>
	<@ms.nav title="角色设置" back=true>
		<@ms.saveButton id="save"/>
	</@ms.nav>
	<@ms.panel>
		<@ms.form name="columnForm" isvalidation=true  >                                                   
			<@ms.text name="roleName" label="角色名称:" title="角色名称" value="${roleEntity.roleName?default('')}" width="300" validation={"required":"true","maxlength":"30","data-bv-notempty-message":"请填写角色名称"}/>
			<@ms.formRow label="权限管理:">
				<div>
					<table id="modelList" 
						data-show-export="true"
						data-method="post" 
						data-side-pagination="server">
					</table>
				</div>
			</@ms.formRow>
		</@ms.form>
	</@ms.panel>
</@ms.html5>

<script>
	$(function(){
		//数据初始化
		$("#modelList").bootstrapTable({
			url:"${managerPath}/model/modelList.do?roleId=${roleEntity.roleId?default('')}",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			idField: 'modelId',
            treeShowField: 'modelTitle',
            parentIdField: 'modelModelId',
	    	columns: [
				    	{
				        	field: 'modelTitle',
				        	title: '模块标题',
				        	width: '200'
				    	},{
				        	field: 'attribute',
				        	title: '功能权限',
				        	formatter:function(value,row,index) {
				        		var attribute = "";
				        		for(var i=0;i<row.modelChildList.length;i++){
				        			var modelId = row.modelChildList[i].modelId;
				        			var str = "<label style=' margin-top: 3px;  margin-right: 20px;' class='ms-check'><input type='checkbox'	data-ids='"+row.modelChildList[i].modelParentIds+"' value='"+modelId+"' name='attribute'/> "+row.modelChildList[i].modelTitle+"</label>"
				        			if(row.modelChildList[i].chick == 1){
				        				str = "<label style=' margin-top: 3px;  margin-right: 20px;' class='ms-check'><input type='checkbox' checked='checked' data-ids='"+row.modelChildList[i].modelParentIds+"' value='"+modelId+"' name='attribute'/> "+　row.modelChildList[i].modelTitle+"</label>";
				        			}
				        			if(attribute == ""){
				        				attribute = str;
				        			}else{
				        				attribute = attribute+str;
				        			}
				        		}
				        		return attribute;
				        	}
				    	}]
	    })
	})
	//保存操作
	$("#save").click(function(){
		$("#columnForm").data("bootstrapValidator").validate();
		var isValid = $("#columnForm").data("bootstrapValidator").isValid();
		if(!isValid) {
			<@ms.notify msg= "数据提交失败，请检查数据格式！" type= "warning" />
			return;
		}
		var roleName = $("input[name=roleName]").val();
		var roleId = "${roleEntity.roleId?default('')}";
		var oldRoleName = "${roleEntity.roleName?default('')}";
		var ids=[];
		$("input[name=attribute]").each(function () {
			if($(this).is(':checked')){
				var modelId = $(this).val();
			    var modelModelIds = $(this).attr("data-ids");
			    ids.push(modelId);
			    if(modelModelIds!="") {
				    var parentIds = modelModelIds.split(",");
				    for(var i=0;i<parentIds.length;i++){
				    	if(parentIds[i]!="") {
					    	if($.inArray(parentIds[i], ids) == -1){
						    	ids.push(parentIds[i]);
						    }				    	
				    	}
				    }			    
			    }
			}
		});
		if(roleName == "" || roleName == null){
			<@ms.notify msg= '角色名不能为空' type= "warning" />
		}else{
			$.ajax({
		 	type:"post",
		 	url:"${managerPath}/basic/role/saveOrUpdateRole.do",
		 	dataType: "json",
		 	data:{ids:ids,roleName:roleName,roleId:roleId,oldRoleName:oldRoleName},
		 	success:function(data){
		 		if(data.result == false) {
					$('.ms-notifications').offset({top:43}).notify({
					    type:'warning',
					    message: { text:data.resultMsg }
					 }).show();	
				}else {
					<@ms.notify msg= "操作成功" type= "success" />
					location.href= "${managerPath}/basic/role/index.do";
				}
		 	}
		});
		}
		
	})
</script>