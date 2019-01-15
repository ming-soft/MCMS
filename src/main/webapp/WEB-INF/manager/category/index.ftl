<@ms.html5>
	<@ms.nav title="${modelTitle}"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
			<@ms.text label="${modelTitle}标题" name="categoryTitle" value=""  width="240px;" placeholder="请输入类别标题" validation={"maxlength":"50","data-bv-stringlength-message":"${modelTitle}标题长度不能超过五十个字符长度!"}/>
			<@ms.searchFormButton>
				<@ms.queryButton onclick="search()"/> 
			</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
					<#include "/${model?default('')}/category/shiro-button.ftl"/>					
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="categoryList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delCategory" title="${modelTitle}数据删除" >
		<@ms.modalBody>删除此数据
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button class="btn btn-danger rightDelete" id="deleteCategoryBtn" value="确定"/>
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		var category = {modelId:${modelId?default('0')},modelTitle:"${modelTitle?default('0')}"};
		$("#categoryList").bootstrapTable({
			url:"${managerPath}/category/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			queryParams:function(params) {
				return $.extend(params,category);
			},
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true},
				    	{
				        	field: 'categoryId',
				        	title: '${modelTitle}编号',
				        	align: 'center',
				        	width:'120'
				    	},{
				        	field: 'categoryTitle',
				        	title: '${modelTitle}标题',
				        	formatter:function(value,row,index) {
				        		<#include "/${model?default('')}/category/shiro-update.ftl"/>
				        	}
				    	},							    	{
				        	field: 'categoryDescription',
				        	title: '${modelTitle}描述'
				    	}	]
	    })
	})
	//增加按钮
	$("#addCategoryBtn").click(function(){
		location.href ="${managerPath}/category/form.do?modelId=${modelId?default('0')}&modelTitle=${modelTitle?default('0')}"; 
	})
	//删除按钮
	$("#delCategoryBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#categoryList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delCategory").modal();
		}
	})
	
	$("#deleteCategoryBtn").click(function(){
		var rows = $("#categoryList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/category/delete.do",
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
		var modelId = {modelId:${modelId}};
		var search = $("form[name='searchForm']").serializeJSON();
        var params = $('#categoryList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search,modelId);
	        return params;  
       	}  
   	 	$("#categoryList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>