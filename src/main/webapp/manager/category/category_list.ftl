<!DOCTYPE html>
<html lang="zh">
 <head>
<#include "/manager/include/macro.ftl"/>
<#include "/manager/include/meta.ftl"/>
</head>
<body>	
<@ms.content>
<@ms.contentBody >
	<@ms.contentNav title="栏目列表管理"></@ms.contentNav >
	<@ms.contentPanel>
		<@ms.panelNav>
			<@ms.panelNavBtnGroup>
				<@ms.panelNavBtnAdd/>
			</@ms.panelNavBtnGroup>
		</@ms.panelNav>
		<@ms.table head=['编号','标题','操作'] id="tableConterent">
			<#if categoryJson?has_content && categoryJson!="[]">
	        	<@ms.treeTable treeId="peopleAddressTree"  style="width:60%" tbodyId="tableConterent" json="${categoryJson?default('')}" jsonName="categoryTitle" jsonId="categoryId" jsonPid="categoryCategoryId"/>
	      	<#else>
             	<tr>
		            <td colspan="4" class="text-center">
		            	<@ms.nodata/>
					</td>
	          	</tr>                          
        	</#if>
		</@ms.table>
		
		<script id="afterpeopleAddressTree" type="text/x-jquery-tmpl">
			<td class="text-center">
				<a class="btn btn-xs red tooltips addpeopleAddressTree" data-toggle="tooltip" data-id="{{= categoryId}}" data-original-title="添加" >
                 	<i class="glyphicon glyphicon-plus"></i>
                </a>	
				<a class="btn btn-xs red tooltips editclumnTree" onclick="editclumnTree(this)" data-toggle="tooltip" data-id="{{= categoryId}}" data-original-title="编辑">
             		<i class="glyphicon glyphicon-pencil"></i>
            	</a>
				<a class="btn btn-xs red tooltips deleteclumnTree" onclick="deleteclumnTree(this)" data-toggle="tooltip" data-id="{{= categoryId}}" data-original-title="删除" >
             		<i class="glyphicon glyphicon-trash"></i>
            	</a>
			</td>
		</script>
	   	
	   	<!--删除-->    
		<@ms.modal modalName="delete" title="删除栏目">
			  <@ms.modalBody>
			  		确定要删除所选的栏目吗?
		     </@ms.modalBody>
			 <@ms.modalButton>
		 		<@ms.button class="btn btn-danger rightDelete" value="确定"/>
		 	</@ms.modalButton>
		</@ms.modal>
				
				
	</@ms.contentPanel>
</@ms.contentBody>
</@ms.content>        

<script>
var categoryId="";
$(function(){

	$("body").delegate("#addButton,.addpeopleAddressTree", "click", function(){    
	
		var categoryCategoryId = $(this).attr("data-id");
		if(categoryCategoryId==undefined){
			location.href = base+"/manager/category/add.do?modelId=${modelId?default(0)}&modelTitle=栏目&categoryCategoryId=${categoryCategoryId?default(0)}";
			return;
		}
		
		location.href = base+"/manager/category/add.do?modelId=${modelId?default(0)}&modelTitle=栏目&categoryCategoryId="+categoryCategoryId;
	});

	
	
	//确认删除
	$(".rightDelete").on("click",function(){
	
		$(this).request({url: base+"/manager/category/"+categoryId+"/delete.do",type:"json",method:"post",func:function(msg) {
			var columnJson = $.parseJSON(msg.resultMsg);
			if(columnJson==false){
				alert("请先删除子栏目");
				$(".delete").modal("hide");
			}else{
				alert("删除成功");
				location.reload();
			}
		}});
	});
});


function editclumnTree(obj){
	var categoryId = $(obj).attr("data-id");
	location.href = base+"/manager/category/"+categoryId+"/edit.do?modelId=${modelId?default(0)}&modelTitle="+"栏目";
}

function deleteclumnTree(obj){
	categoryId = $(obj).attr("data-id");
	$(".delete").modal();
}
</script>
</body>

</html>













