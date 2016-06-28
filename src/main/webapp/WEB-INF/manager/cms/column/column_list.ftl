<!DOCTYPE html>
<html lang="zh">
 <head>
<#include "${managerViewPath}/include/macro.ftl"/>
<#include "${managerViewPath}/include/meta.ftl"/>
</head>
<body>	
<@ms.content>
<@ms.contentBody >
	<@ms.contentNav title="栏目管理 " ></@ms.contentNav >
	<@ms.contentPanel>
		<@ms.panelNav>
			<@ms.panelNavBtnGroup>
				<@ms.panelNavBtnAdd title=""/>
			</@ms.panelNavBtnGroup>
		</@ms.panelNav>
		<@ms.table head=["编号,40",'标题',"属性,50",'链接地址','列表地址','内容地址','封面地址',"<th style='text-align:center;width:10%;'>操作</th>"] id="tableConterent">
			<#if listColumn?has_content && listColumn!="[]">
	        	<@ms.treeTable treeId="clumnTree"  style="width:15%" tbodyId="tableConterent" json="${listColumn?default('')}" jsonName="categoryTitle" jsonId="categoryId" jsonPid="categoryCategoryId"/>
	      	<#else>
             <tr>
	            <td colspan="8" class="text-center">
	            	<@ms.nodata content="暂无栏目"/>
				</td>
	         </tr>
        </#if>
		</@ms.table>
		
		<script id="afterclumnTree" type="text/x-jquery-tmpl">
			<td class="text-center">
				{{if columnType==1 }}
					列表				
				{{else columnType==2 }}
					单页
				{{/if}}
			</td>
			<td style="width:20%">{ms:global.url/}{{= columnPath}}/index.html</td>
			<td style="width:10%">{{= columnListUrl}}</td>
			<td style="width:10%">
				{{if columnType==1 }}
					{{= columnUrl}}
				{{/if}}
			</td>
			<td style="width:10%">
				{{if columnType==2}}
					{{= columnUrl}}
				{{/if}}
			</td>
			<td class="text-center">
				<a class="btn btn-xs red tooltips editclumnTree" onclick="editclumnTree(this)" data-toggle="tooltip" data-id="{{= categoryId}}" data-original-title="编辑">
             		<i class="glyphicon glyphicon-pencil"></i>
            	</a>
				<a class="btn btn-xs red tooltips deleteclumnTree" onclick="deleteclumnTree(this)" data-toggle="tooltip" data-id="{{= categoryId}}" data-original-title="删除" >
             		<i class="glyphicon glyphicon-trash"></i>
            	</a>
			</td>
		</script>
	   	
	   	<!--删除栏目-->    
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
var columnId="";
$(function(){
	$("#addButton").on("click",function(){
		location.href=base+"${baseManager}/cms/column/add.do";
	});
	//确认删除
	$(".rightDelete").on("click",function(){
		$(this).request({url: base+"${baseManager}/cms/column/"+columnId+"/delete.do",type:"json",method:"post",func:function(msg) {
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
	location.href=base+"${baseManager}/cms/column/"+categoryId+"/edit.do";
}

function deleteclumnTree(obj){
	columnId = $(obj).attr("data-id");
	$(".delete").modal();
}
</script>
</body>



</html>













