<@ms.html5>
	<@ms.nav title="省市县镇村数据管理"></@ms.nav>
	<@ms.searchForm name="searchForm" isvalidation=true>
		<@ms.text label="省" name="provinceName" value=""  width="240px;" placeholder="请输入省／直辖市／自治区级名称" />
		<@ms.text label="市" name="cityName" value=""  width="240px;" placeholder="请输入市级名称" />
		<@ms.text label="县" name="countyName" value=""  width="240px;" placeholder="请输入县／区级名称" />
		<@ms.text label="镇" name="townName" value=""  width="240px;" placeholder="请输入街道／镇级名称" />
		<@ms.text label="村" name="villageName" value=""  width="240px;" placeholder="请输入村委会名称" />
		<@ms.searchFormButton>
			 <@ms.queryButton onclick="search()"/> 
		</@ms.searchFormButton>			
	</@ms.searchForm>
	<@ms.panel>
		<div id="toolbar">
			<@ms.panelNav>
				<@ms.buttonGroup>
				</@ms.buttonGroup>
			</@ms.panelNav>
		</div>
		<table id="cityList" 
			data-show-refresh="true"
			data-show-columns="true"
			data-show-export="true"
			data-method="post" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
	
	<@ms.modal  modalName="delCity" title="授权数据删除" >
		<@ms.modalBody>删除此授权
			<@ms.modalButton>
				<!--模态框按钮组-->
				<@ms.button  value="确认删除？"  id="deleteCityBtn"  />
			</@ms.modalButton>
		</@ms.modalBody>
	</@ms.modal>
</@ms.html5>

<script>
	$(function(){
		$("#cityList").bootstrapTable({
			url:"${managerPath}/basic/city/list.do",
			contentType : "application/x-www-form-urlencoded",
			queryParamsType : "undefined",
			toolbar: "#toolbar",
	    	columns: [{ checkbox: true},
				    	{
				        	field: 'provinceName',
				        	title: '省／直辖市／自治区级名称',
				        	align: 'center'
				    	},{
				        	field: 'cityName',
				        	title: '市级名称',
				        	align: 'center'
				    	},{
				        	field: 'countyName',
				        	title: '县／区级名称',
				        	align: 'center'
				    	},{
				        	field: 'townName',
				        	title: '街道／镇级名称',
				        	align: 'center'
				    	},{
				        	field: 'villageName',
				        	title: '村委会名称',
				        	align: 'center'
				    	}]
	    })
	})
	//增加按钮
	$("#addCityBtn").click(function(){
		location.href ="${managerPath}/basic/city/form.do"; 
	})
	//删除按钮
	$("#delCityBtn").click(function(){
		//获取checkbox选中的数据
		var rows = $("#cityList").bootstrapTable("getSelections");
		//没有选中checkbox
		if(rows.length <= 0){
			<@ms.notify msg="请选择需要删除的记录" type="warning"/>
		}else{
			$(".delCity").modal();
		}
	})
	
	$("#deleteCityBtn").click(function(){
		var rows = $("#cityList").bootstrapTable("getSelections");
		$(this).text("正在删除...");
		$(this).attr("disabled","true");
		$.ajax({
			type: "post",
			url: "${managerPath}/basic/city/delete.do",
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
        var params = $('#cityList').bootstrapTable('getOptions');
        params.queryParams = function(params) {  
        	$.extend(params,search);
	        return params;  
       	}  
   	 	$("#cityList").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	}
</script>