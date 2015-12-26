<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/>
<style>

</style>
</head>
<body>
	<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="内容模型管理列表">
			</@ms.contentNav>
			<@ms.contentPanel>
				<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						<@ms.panelNavBtnAdd  id="totalAdd"/>
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
					<@ms.table head=['编号','内容模型名称','操作']>
						<#if listContentModel?has_content>
				           <#list listContentModel as model>
					          <tr>
					            <td class="text-center">${model.cmId?c?default(0)}</td>		          	
					            <td class="text-center">
					            	 <a class="btn btn-xs tooltips updateModalBtn" href="${base}/manager/cms/contentModel/${model.cmId?c?default(0)}/edit.do" data-toggle="tooltip" data-original-title="编辑内容模型">
					            		${model.cmTipsName?default("暂无")}
					            	</a>
					            </td>
					            <td class="text-center operate">
				                    <a class="btn btn-xs tooltips delete-btn" data-toggle="tooltip" data-id="${model.cmId?c?default(0)}" data-original-title="删除">
				                        <i class="glyphicon glyphicon-trash"></i>
				                    </a>
				                   
			                     		
			                    	
								</td>
					          </tr>
				           </#list>
							<#else>
			           			<tr>
						            <td colspan="4" class="text-center">
						            	<a href="${base}/manager/cms/contentModel/add.do"><@ms.nodata/></a>
									</td>
					          	</tr>
			           		</#if>
					</@ms.table>	
					<@showPage page=page/>
			</@ms.contentPanel>
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
		<!--删除的模态框开始-->
		<@ms.modal modalName="delete" title="删除内容模型">
			 <@ms.modalBody>
				确定删除该模型吗？
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeDelete"/>  
	 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--删除的模态框结束-->
		<!--=================模态框部分结束=================-->
	</@ms.content>
	<!-- bootstarp 布局容器 结束 -->	
	
	<script type="text/javascript">	
		$("#totalAdd").click(function(){
			location.href = "${base}/manager/cms/contentModel/add.do"
		});
	
		//删除内容模型
		function deleteForm(cmId){
			var URL = base+"/manager/cms/contentModel/"+cmId+"/delete.do"
			$(this).request({url:URL,data:"cmId=" + cmId,type:"json",method:"post",func:function(msg) {
				if(msg != 0) {
			    	$(".closeModal").click();
					alert("删除内容模型成功");
		    		if($("tbody tr").length==0 && msg != 1){
		    			location.href = base+"/manager/cms/contentModel/list.do?pageNo="+(msg-1);
					}else{
						location.href = base+"/manager/cms/contentModel/list.do?pageNo="+msg;
					}
		    	} else {
					alert("删除内容模型失败");
			    	$(".delete").modal("hide");
		    	}	
			}});
		}
		
		
		$(function(){
			
			//点击删除模态框消失
			$("#closeDelete").click(function(){
				$(".delete").modal("hide");
			});
			//内容模型id
			var cmId;
			$(".delete-btn").click(function(){
				cmId = $(this).attr("data-id");
				$(".delete").modal();
			});
			//删除内容模型
			$("#deleteButton").on("click",function(){
				deleteForm(cmId);
			});	
		});
	</script>

</body>
</html>
