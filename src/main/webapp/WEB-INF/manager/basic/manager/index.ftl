<@ms.html5>
	<@ms.nav title="管理员管理"></@ms.nav>
	<style>
		.select2-container .select2-container--default {  
		 	height: 34px;  
		} 
		.select2-container .select2-selection--single{
			font: inherit;
			border: 1px solid #ccc;
		    display: block;
		    height: 34px;
		    padding: 0px 3px;
    		font-size: 14px;
    		color: rgb(85, 85, 85);
		}
	</style>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<@shiro.hasPermission name="manager:save"><@ms.panelNavBtnAdd title="" id="addManagerBtn"/></@shiro.hasPermission> 
					<@shiro.hasPermission name="manager:del"><@ms.panelNavBtnDel title="" id="delManagerBtn"/></@shiro.hasPermission> 
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="managerList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delManager" title="管理员删除" >
		<@ms.modalBody>删除此管理员
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="删除" class="btn btn-danger rightDelete" id="deleteManagerBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
	
	<@ms.modal id="addManager" title="管理员编辑"  resetFrom=true>
    <@ms.modalBody>
		<@ms.form name="managerForm" isvalidation=true action="${managerPath}/basic/manager/save.do" redirect="${managerPath}/basic/manager/index.do">
			<@ms.hidden name="managerId" value="0"/>
			<@ms.text label="管理员名" name="managerName" value=""  width="240px;" placeholder="请输入管理员名" validation={"required":"true","minlength":"3","maxlength":"12","data-bv-stringlength-message":"管理员用户名长度为3~12个字符!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="管理员昵称" name="managerNickName" value=""  width="240px;" placeholder="请输入管理员昵称" validation={"required":"true","maxlength":"15","data-bv-stringlength-message":"管理员昵称长度不能超过十五个字符长度!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="管理员密码" name="managerPassword" value=""  width="240px;" placeholder="请输入管理员密码" validation={"minlength":"6","maxlength":"20","data-bv-stringlength-message":"管理员密码长度为6~20个字符!"}/>
			<@ms.select id="managerRoleID"  name="managerRoleID" label="角色编号"/>	
    	</@ms.form>
    </@ms.modalBody>
    <@ms.modalButton>
         <@ms.saveButton id= "saveOrUpdate"/>
    </@ms.modalButton>
</@ms.modal>
	
</@ms.html5>

<script>
	$(function(){
		//加载选择角色列表
		$("#managerRoleID").request({url:"${managerPath}/basic/role/list.do",type:"json",method:"post",func:function(msg) {
			var managerArr = msg.rows;
			$("#managerRoleID").val(null).trigger("change");
			if(managerArr.length != 0 && ($("#managerRoleID").val() == null)){
	   			for(var i=0; i<managerArr.length; i++){
		   			$("#managerRoleID").append($("<option>").val(managerArr[i].roleId).text(managerArr[i].roleName));
		   			$("#managerRoleID").select2({width: "210px"}).val(managerArr[i].roleId).trigger("change");
		   		}
	   		} else if($("#managerRoleID").val()<0) {
	   			$("#managerRoleID").append("<option>暂无角色</option>");
	   		}
	   		//使用select2插件
	 		$("#managerRoleID").select2({width: "210px"});
		}});
		$("#managerList").bootstrapTable({
			url:"${managerPath}/basic/manager/query.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true,
		    			formatter: function (value, row, index){
		    				//不能删除自己
		    				if("${Session.manager_session.managerName}" == row.managerName){
		    					return {disabled : true};
		    				}
		    			}
	    				},{
				        	field: 'managerName',
				        	title: '账号',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		if(row.managerId == 0){
				        			return value;
				        		}else{
				        			<@shiro.hasPermission name="manager:update">	        
						        	return "<a onclick='updateSearch("+row.managerId+")' style='cursor:pointer;text-decoration:none;' >" + value + "</a>";
						    		</@shiro.hasPermission> 
						    		<@shiro.lacksPermission name="manager:update">
						    			return value;
						    		</@shiro.lacksPermission>
				        			
				        		}
				        	}
				    	},							    	{
				        	field: 'managerNickName',
				        	title: '昵称'
				    	},							    	{
				        	field: 'managerPassword',
				        	title: '密码'
				    	},							    	{
				        	field: 'roleName',
				        	title: '角色名称'
				    	},							    	{
				        	field: 'managerTime',
				        	title: '创建时间',
				        	align: 'center'
				    	}		]
	    })
	})
	//增加按钮
	$("#addManagerBtn").click(function(){
		$('#managerForm').attr("${managerPath}/basic/manager/save.do");
		$(".addManager").modal();
	})
	
	var url = "${managerPath}/basic/manager/save.do";
	if($("input[name = 'managerId']").val() > 0){
		url = "${managerPath}/basic/manager/update.do";
		$(".btn-success").text("更新");
	}
	
	//保存按钮
	$("#saveOrUpdate").click(function(){
		$("#managerForm").data("bootstrapValidator").validate();
		var isValid = $("#managerForm").data("bootstrapValidator").isValid();
		if(!isValid) {
			<@ms.notify msg= "数据提交失败，请检查数据格式！" type= "warning" />
			return;
		}
		$(this).text("正在保存...");
		$(this).attr("disabled","true");
		var managerEntity = $('#managerForm').serialize();
		var url = $('#managerForm').attr("action");
		$.ajax({
			type: "post",
			url:url,
			data: managerEntity,
			dataType:"json",
			success:function(data){
				if(data.managerId > 0){
					<@ms.notify msg= "保存或更新成功" type= "success" />
					location.reload();
				}else {
					 $('.ms-notifications').offset({top:43}).notify({
			    		    type:'warning',
						    message: { text:data.resultMsg }
						 }).show();	
					$("#saveOrUpdate").removeAttr("disabled");
					$("#saveOrUpdate").text("保存");
					}
			}
		});
	})
	
	//删除按钮
	$("#delManagerBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#managerList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delManager").modal();
		}
	})
	
	$("#deleteManagerBtn").click(function(){
		var rows = $("#managerList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/basic/manager/delete.do",
			data: JSON.stringify(rows),
			dataType: "json",
			contentType: "application/json",
			success:function(msg) {
				if(msg.result == true) {
					<@ms.notify msg= "删除成功" type= "success" />
				}else {
					<@ms.notify msg= "删除失败" type= "danger" />
				}
				location.reload();
			}
		})
	});
	
	//表单赋值
	function updateSearch(managerId){
		$(this).request({url:"${managerPath}/basic/manager/get.do?managerId="+managerId,func:function(manager) {
			if (manager.managerId > 0) {
				$("#managerForm").attr("action","${managerPath}/basic/manager/update.do");
				$("#managerForm input[name='managerName']").val(manager.managerName);
				$("#managerForm input[name='managerId']").val(manager.managerId);
				$("#managerForm input[name='managerNickName']").val(manager.managerNickName);
				$("#managerRoleID").select2({width: "210px"}).val(manager.managerRoleID).trigger("change");
				$("#managerForm select[name='managerRoleID']").val(manager.managerRoleID);
				$("#addManager").modal();
			}					
		}});
	}
</script>