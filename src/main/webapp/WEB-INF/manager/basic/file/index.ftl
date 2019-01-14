<@ms.html5>
	<@ms.nav title="基础文件表管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
			<@ms.searchFormButton>
				 <@ms.queryButton onclick="search()"/> 
			</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNavBtnGroup>
				<@shiro.hasPermission name="file:save"><@ms.panelNavBtnAdd id="addFileBtn" title=""/></@shiro.hasPermission> 
				<@shiro.hasPermission name="file:del"><@ms.panelNavBtnDel id="delFileBtn" title=""/></@shiro.hasPermission> 
			</@ms.panelNavBtnGroup>
		</div>
		<table id="fileList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delFile" title="基础文件表数据删除" >
		<@ms.modalBody>删除此基础文件表
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认" class="btn btn-danger rightDelete"  id="deleteFileBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>


	$(function(){
		$("#fileList").bootstrapTable({
			url:"${managerPath}/basic/file/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true},
				    	{
				        	field: 'id',
				        	title: '文件编号',
				        	width:'11',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'categoryId',
				        	title: '文件分类编号',
				        	width:'11',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'appId',
				        	title: 'APP编号',
				        	width:'11',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'fileName',
				        	title: '文件名称',
				        	width:'200',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'fileUrl',
				        	title: '文件链接',
				        	width:'500',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'fileSize',
				        	title: '文件大小',
				        	width:'11',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'fileJson',
				        	title: '文件详情Json数据',
				        	width:'500',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'fileType',
				        	title: '文件类型：图片、音频、视频等',
				        	width:'50',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'isChild',
				        	title: '子业务',
				        	width:'50',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'updateDate',
				        	title: '更新时间',
				        	width:'0',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'updateBy',
				        	title: '更新者',
				        	width:'11',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'createBy',
				        	title: '创建者',
				        	width:'11',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'createDate',
				        	title: '创建时间',
				        	width:'0',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},
							    	{
				        	field: 'del',
				        	title: '删除标记',
				        	width:'1',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/file/form.do?id="+row.id;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	}
			]
	    })
	})
	//增加按钮
	$("#addFileBtn").click(function(){
		location.href ="${managerPath}/basic/file/form.do"; 
	})
	//删除按钮
	$("#delFileBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#fileList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delFile").modal();
		}
	})
	
	$("#deleteFileBtn").click(function(){
		var rows = $("#fileList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/basic/file/delete.do",
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
        var params = $('#fileList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#fileList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>