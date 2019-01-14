<@ms.html5>
	<@ms.nav title="栏目表管理"></@ms.nav>
	<!--@ms.searchForm name="searchForm" isvalidation=true>
		<@ms.searchFormButton>
			 <@ms.queryButton onclick="search()"/> 
		</@ms.searchFormButton>			
	</@ms.searchForm-->
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<#include "${managerViewPath}/${model?default('')}/column/shiro-button.ftl"/>
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="columnList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delColumn" title="删除栏目" >	
		<@ms.modalBody>删除选中栏目，如果有子栏目也会一并删除
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认删除？"  id="deleteColumnBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>
<script>
	$(function(){
		$("#columnList").bootstrapTable({
			url:"${managerPath}/${model?default('')}/column/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
			idField: 'categoryId',
            treeShowField: 'categoryTitle',
            parentIdField: 'categoryCategoryId',
	    	columns: [
	    		{ 
	    			checkbox: true
	    		},{
		        	field: 'categoryId',
		        	title: '编号',
		        	align: 'center'
		    	},{
		        	field: 'categoryTitle',
		        	title: '标题',
		        	align: 'left',
		        	formatter:function(value,row,index) {
						<#include "${managerViewPath}/${model?default('')}/column/shiro-update.ftl"/>
		        	}
		    	},{
		        	field: 'columnType',
		        	title: '属性',
		        	align: 'center',
		        	formatter:function(value,row,index) {
		        		if(value == 1){
		        			return "列表";
		        		}else if(value == 2){
		        			return "单页";
		        		}else if(value == 3){
		        			return "外部链接";
		        		}
		        	}
		    	},{
		        	field: 'columnPath',
		        	title: '链接地址',
		        	align: 'left',
		        	formatter:function(value,row,index) {
		        		return "{ms:global.url/}"+value+"/index.html";
		        	}
		    	},{
		        	field: 'columnListUrl',
		        	title: '列表地址',
		        	align: 'left',
		        	formatter:function(value,row,index) {
		        		if(value != null){
		        			return value;
		        		}else{
		        			return "";
		        		}
		        	}
		    	},{
		        	field: 'columnUrl',
		        	title: '内容地址',
		        	align: 'left',
		        	formatter:function(value,row,index) {
		        		if(row.columnType == 1){
		        			return value;
		        		}else{
		        			return "";
		        		}
		        	}
		    	},{
		        	field: 'columnUrl',
		        	title: '封面地址',
		        	align: 'left',
		        	formatter:function(value,row,index) {
		        		if(row.columnType == 2){
		        			return value;
		        		}else{
		        			return "";
		        		}
		        	}
		    	}]
	    })
	})
 
	
	//增加按钮
	$("#addColumnBtn").click(function(){
		location.href ="${managerPath}/${model?default('')}/column/add.do?modelId=${Session.model_id_session?default(0)}&modelTitle=${Session.model_title_session?default('')}"; 
	})
	//删除按钮
	$("#delColumnBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#columnList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delColumn").modal();
		}
	})
	
	$("#deleteColumnBtn").click(function(){
		var rows = $("#columnList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		var ids = [];
		for(var i=0;i<rows.length;i++){
			ids[i] = rows[i].categoryId;
		}
		ids.reverse();
		$.ajax({
			type: "post",
			url: "${managerPath}/${model?default('')}/column/delete.do?ids="+ids,
			dataType: "json",
			contentType: "application/json",
			success:function(msg) {
				if(msg.result == true) {
					<@ms.notify msg= "删除成功" type= "success" />
				}else {
					<@ms.notify msg= "删除失败" type= "warning" />
				}
				location.reload();
			}
		})
	});
	//查询功能
	function search(){
		var search = $("form[name='searchForm']").serializeJSON();
        var params = $('#columnList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#columnList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>