<!DOCTYPE html>
<html lang="zh">
 <head>
<#include "/manager/include/macro.ftl"/>
<#include "/manager/include/meta.ftl"/>
</head>
<body>
<@ms.content>
 	<@ms.contentMenu>
		 <!-- 树形模块菜单开始 -->
		<#if listColumn?has_content>
				<@ms.tree  treeId="inputTree" json="${listColumn?default('')}" addNodesName=""  jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle"   showIcon="true" expandAll="true" getZtreeId="getZtreeId(event,treeId,treeNode);" />
			<#else> 
				<@ms.nodata content="暂无栏目"/>
		</#if>
		<!-- 树形模块菜单结束 -->
	</@ms.contentMenu>
	<@ms.contentBody width="85%" style="overflow-y: hidden;">
		<@ms.contentPanel  style="margin:0;padding:0;overflow-y: hidden;">
				<div class="row alertInfo" style="margin:8px;">
					<div class="alert alert-info">注意：只有最小栏目才能进行分类属性的添加</div>
				</div>
				<iframe src="${base}/manager/category/0/childList.do?modelId=${modelId?default(0)}&categoryCategoryId=0" style="width:100%;maring:0;padding:0;border:none;height:100%;background-image: url(${static}/loading.gif);  background-repeat: no-repeat;  background-position: center;display:none" id="listFrame" target="listFrame"></iframe>
				
		</@ms.contentPanel>
	</@ms.contentBody>
</@ms.content>
<script>
//树形结点
function getZtreeId(event,treeId,treeNode){
	//如果当前栏目没有子栏目时才能进行添加
	if(treeNode.check_Child_State==-1){
		$("#listFrame").show();
		$(".alertInfo").hide();
		$("#listFrame").attr("src","${base}/manager/category/"+treeNode.categoryId+"/childList.do?modelId=${modelId?default(0)}&categoryCategoryId="+treeNode.categoryId);
	}else{
		$("#listFrame").hide();
		$(".alertInfo").show();
	}
	
}
</script>
</body>
</html>
