<@ms.html5>
	<@ms.nav title="角色管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
		<@ms.text label="角色名" name="roleName" value=""  width="240px;" placeholder="请输入角色名" />
		<@ms.searchFormButton>
			 <@ms.queryButton onclick="search()"/> 
		</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<@shiro.hasPermission name="role:save"><@ms.panelNavBtnAdd title="" id="addRoleBtn"/></@shiro.hasPermission> 
					<@shiro.hasPermission name="role:del"><@ms.panelNavBtnDel title="" id="delRoleBtn"/></@shiro.hasPermission> 
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="roleList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delRole" title="角色删除" >
		<@ms.modalBody>删除此角色
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="删除" class="btn btn-danger rightDelete" id="deleteRoleBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		$("#roleList").bootstrapTable({
			url:"${managerPath}/basic/role/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true,
			    			formatter: function (value, row, index){
			    				//不能删除自己
			    				if("${Session.manager_session.managerRoleID}" == row.roleId){
			    					return {disabled : true};
			    				}
			    			}
	    				},{
				        	field: 'roleId',
				        	title: '编号',
				        	align: 'center',
				        	width: '80',
				    	},{
				        	field: 'roleName',
				        	title: '角色名',
				        	formatter:function(value,row,index) {
				        		if("${Session.manager_session.managerRoleID}" == row.roleId){
					        		return  value ;
					        	}else{
					        		var url = "${managerPath}/basic/role/form.do?roleId="+row.roleId;
					        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
					        	}
				        	}
				    	}]
	    })
	})
	//增加按钮
	$("#addRoleBtn").click(function(){
		location.href ="${managerPath}/basic/role/form.do"; 
	})
	//删除按钮
	$("#delRoleBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#roleList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delRole").modal();
		}
	})
	
	$("#deleteRoleBtn").click(function(){
		var rows = $("#roleList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/basic/role/delete.do",
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
	//查询功能
	function search(){
		var search = $("form[name='searchForm']").serializeJSON();
        var params = $('#roleList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#roleList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>