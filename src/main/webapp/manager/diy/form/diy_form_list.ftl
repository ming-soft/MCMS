<!DOCTYPE html>
<html lang="en">
<head>
	<#include "/manager/include/macro.ftl"/>
	<#include "/manager/include/meta.ftl"/> 
<style> 
	 
</style>
</head>

<body>
	<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="自定义表单管理">
			</@ms.contentNav>
			<@ms.contentPanel>
				<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						<@ms.panelNavBtnAdd  id="totalAdd"/>
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
					
					<@ms.table head=['编号','名称','表单提交地址','请求数据地址','操作']>
						<#if list?has_content>
		        			<#list list as form>
		           				<tr> 
						           	<td class="text-center basicId">${form.diyFormId?c?default(0)}</td>
						            <td class="text-center" id="name" >
						            	<a href="${base}/manager/diy/form/${form.diyFormId?c?default(0)}/edit.do?title=${form.diyFormTipsName?default(0)}" class="btn btn-xs red tooltips " data-toggle="tooltip" data-original-title="编辑表单" >
						            	${form.diyFormTipsName?default(0)}
						            	</a>
						            </td>
						            <td class="text-center" >/from/${form.diyFormUrl?default("")}.do</td>
						             <td class="text-center" >/from/${form.diyFormUrl?default("")}/queryData.do</td>
						            <td class="text-center">
			                    		<a href="${base}/manager/diy/form/${form.diyFormId?c?default(0)}/query.do?title=${form.diyFormTipsName?default(0)}" class="btn btn-xs red tooltips" data-toggle="tooltip" data-original-title="查看记录" >
				                     		<i class="glyphicon glyphicon-comment"></i>
				                    	</a>
				                    	
				                    	<a href="javascript:(0)" class="btn btn-xs red tooltips del-btn" data-toggle="tooltip" data-original-title="删除表单"  data-id="${form.diyFormId?c?default(0)}">
				                     		<i class="glyphicon glyphicon-trash"></i>
				                    	</a>
									</td>
						        </tr>
		           			</#list>
		           		<#else>	
			           			<tr>
						            <td colspan="5" class="text-center">
						            	<a href="${base}/manager/diy/form/add.do"><@ms.nodata/></a>
									</td>
					          	</tr>
		           		</#if>
					</@ms.table>	
			</@ms.contentPanel>
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
		<!--删除的模态框开始-->
		<@ms.modal modalName="delete" title="删除自定义表单">
			 <@ms.modalBody>
				确定删除该自定义表单吗？
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeDelete"/>  
	 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--删除的模态框结束-->
		
		<!--=================模态框部分结束=================-->
	</@ms.content>
	
	<script type="text/javascript">				
	
	<#if list?has_content>
		$("#allCheck").attr("style","display:block;margin:0 auto");
		<#else>
		$("#allCheck").attr("style","display:none");
	</#if>
	
		//进行自定义表单删除的函数
		function deleteDiyForm(diyFormId){
			var URL="${base}/manager/diy/form/"+diyFormId+"/delete.do"
			$(this).request({url:URL,type:"json",method:"post",func:function(msg) {
				//回调处理方式
				if(msg.result) {
				    	$(".closeModal").click();
						alert("删除成功");
			    	} else {
						alert("删除失败");
				    	$(".closeModal").click();
			    	}
			    	location.reload();
			}});
			
		}
				
		var diyFormId;//获取自定义表单编号
		$(function(){
				$(".del-btn").click(function(){
					$(".delete").modal();//打开删除的模态框
					diyFormId = $(this).attr("data-id");
				});
				
				$("#deleteButton").click(function(){
					deleteDiyForm(diyFormId);
				});
				
				$("#closeDelete").click(function(){
					$(".delete").modal("hide");
				});
				
				$("#totalDelete").click(function(){
					$(".deleteAll").modal();
				});
				$("#closeAllDelete").click(function(){
					$(".deleteAll").modal("hide");
				});
		});
		
		$("#totalAdd").click(function(){
			location.href = "${base}/manager/diy/form/add.do"
		});
		
		//全选
	   	$("#allCheck").on("click",function(){   
			if(this.checked){
			      $("input[name='ids']").each(function(){this.checked=true;});
			}else{
			      $("input[name='ids']").each(function(){this.checked=false;});   
			}   
		}); 	
		
	</script>
</body>
</html>
	