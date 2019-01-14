<@ms.html5>
	<@ms.nav title="通用用户与信息一对多表管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
			<@ms.searchFormButton>
				 <@ms.queryButton onclick="search()"/> 
			</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<@ms.addButton id="addPeopleBtn"/>
					<@ms.delButton id="delPeopleBtn"/>
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="peopleList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delPeople" title="授权数据删除" >
		<@ms.modalBody>删除此授权
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认删除？"  id="deletePeopleBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		$("#peopleList").bootstrapTable({
			url:"${managerPath}/basic/people/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true},
				    	{
				        	field: 'bpId',
				        	title: '',
				        	width:'10',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/people/form.do?bpId="+row.bpId;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},							    	{
				        	field: 'bpBasicId',
				        	title: '信息编号',
				        	width:'10',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/people/form.do?bpBasicId="+row.bpBasicId;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},							    	{
				        	field: 'bpPeopleId',
				        	title: '用户编号',
				        	width:'10',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/people/form.do?bpPeopleId="+row.bpPeopleId;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	},							    	{
				        	field: 'bpDatetime',
				        	title: '创建时间',
				        	width:'19',
				        	align: 'center',
				        	formatter:function(value,row,index) {
				        		var url = "${managerPath}/basic/people/form.do?bpDatetime="+row.bpDatetime;
				        		return "<a href=" +url+ " target='_self'>" + value + "</a>";
				        	}
				    	}			]
	    })
	})
	//增加按钮
	$("#addPeopleBtn").click(function(){
		location.href ="${managerPath}/basic/people/form.do"; 
	})
	//删除按钮
	$("#delPeopleBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#peopleList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delPeople").modal();
		}
	})
	
	$("#deletePeopleBtn").click(function(){
		var rows = $("#peopleList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/basic/people/delete.do",
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
        var params = $('#peopleList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#peopleList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>