<@ms.html5>
	<@ms.nav title="文章列表"></@ms.nav>
	<@ms.searchForm   name="searchForm" action="">
			<#if articleTypeList?has_content>
				<@ms.select label="文章属性" default="全部" value="a" name="articleType" id="forumSelect"  list=articleTypeList  listValue="dictLabel"   listKey="dictValue"    value="${articleType?default('')}"/>
			<#else>
				<@ms.select label="文章属性"     name="articleType" id="forumSelect" value="" list=["默认属性"]  />
			</#if>
			<@ms.text label="文章标题"  name="basicTitle" value="" title="请输入文章标题"  placeholder="请输入文章标题" />
			<@ms.searchFormButton>
				<@ms.queryButton id="submitSearch" />								
			</@ms.searchFormButton>
	</@ms.searchForm>
	<div id="toolbar">
		<@ms.panelNavBtnGroup>
			<@shiro.hasPermission name="article:save"><@ms.panelNavBtnAdd title=""/></@shiro.hasPermission> 
			<@shiro.hasPermission name="article:del"><@ms.panelNavBtnDel title=""/></@shiro.hasPermission> 
		</@ms.panelNavBtnGroup>
	</div>
	<@ms.panel>
		<table id="articleListTable"
			data-show-refresh="true"
	        data-show-columns="true"
	        data-show-export="true"
			data-method="post" 
			data-detail-formatter="detailFormatter" 
			data-pagination="true"
			data-page-size="10"
			data-side-pagination="server">
		</table>
	</@ms.panel>
</@ms.html5>	
<!--删除限时文章-->    
<@ms.modal modalName="delete" title="删除文章">
	  <@ms.modalBody>
	  		确定要删除所选的文章吗?
     </@ms.modalBody>
	 <@ms.modalButton>
 		<@ms.button class="btn btn-danger rightDelete" value="确定"/>
 	</@ms.modalButton>
</@ms.modal>			
<script>
	
	
	$(function(){
		var search = $("form[name='searchForm']").serializeJSON();
		var articleType = search.articleType; 
		$("#articleListTable").bootstrapTable({
		url:"${managerPath}/cms/article/${categoryId}/list.do?articleTypeStr="+articleType,
		contentType : "application/x-www-form-urlencoded",
		queryParamsType : "undefined",
		toolbar: "#toolbar",
	    columns: [{ checkbox: true}, {
	        field: 'column.categoryTitle',
	        title: '栏目名',
	        width: 90,
	        align: 'left'
	    },{
	        field: 'basicTitle',
	        title: '文章标题',
	        
	        formatter: function (value, row, index){
				<@shiro.hasPermission name="article:update">	        
	        	var url='${managerPath}/cms/article/'+row.articleID+"/edit.do";
	    		return "<a href="+url+" target='_self' >"+value+"</a>";
	    		</@shiro.hasPermission> 
	    		<@shiro.lacksPermission name="article:update">
	    			return value;
	    		</@shiro.lacksPermission> 
	    		
	    	}
	    }, {
	        field: 'articleAuthor',
	        title: '作者',
	        width: 100
	    }, {
	        field: 'basicSort',
	        title: '排序',
	        align: 'center',
	        width: 50
	    }, {
	        field: 'basicHit',
	        title: '点击',
	        align: 'center',
	        width: 50
	    }, {
	        field: 'basicDateTime',
	        title: '发布时间',
	        align: 'center',
	        width: 90
	    }]
	});
	//查询文章标题
	$("#submitSearch").click(function(){
		var search = $("form[name='searchForm']").serializeJSON();
		var params = $('#articleListTable').bootstrapTable('getOptions');
		params.queryParams = function(params) {  
		 	$.extend(params,search);
	        	return params;  
			}  
		$("#articleListTable").bootstrapTable('refresh', {query:$("form[name='searchForm']").serializeJSON()});
	});
	//添加文章
	$("#addButton").click(function(){
		if(${isParent}==true){
			<@ms.notify msg="不能选择父级栏目" />
			return false;
		}
		location.href = "${managerPath}/cms/article/add.do?categoryId=${categoryId?default(0)}&modelId=${Session.model_id_session?default(0)}&categoryTitle=${categoryTitle?default('')}"; 
	});	
	//点击重置按钮
	$(".reset").click(function(){
		$("input[name=basicTitle]").val("");
	})
	//多选删除
	$("#delButton").click(function(){
		//获取勾选的所在行的所有数据
		var rows = $("#articleListTable").bootstrapTable("getSelections");
		if(rows!=""){
		//弹出modal窗体
			$(".delete").modal();
		}else{
			<@ms.notify msg="请选择文章!" type="warning"/>
		}
	});
	//删除多个文章
	$(".rightDelete").click(function(){
		var rows = $("#articleListTable").bootstrapTable("getSelections");
		if(rows!=""){
			$.ajax({
				url:"${managerPath}/cms/article/delete.do",
				type:'post',
				dataType:'json',
				data:JSON.stringify(rows),
				contentType:'application/json',
				success:function(msg) {
					if (msg.result) {
						<@ms.notify msg="删除成功!" type="success"/>
						location.reload();
					} else {
						<@ms.notify msg="删除失败" type="fail"/>
					}
				}
			});
		}else{
	    	<@ms.notify msg="请选择文章!" type="warning"/>
	    }
	});
});
</script>













