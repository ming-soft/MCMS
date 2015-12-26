<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/macro.ftl"/>
<#include "/manager/include/meta.ftl"/>
</head>
<body>
	
<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="搜索管理">
			</@ms.contentNav>
			<@ms.contentPanel>
				<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						
						<@ms.panelNavBtnAdd/>
						
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
					<@ms.table head=['编号','搜索名称','搜索结果模版','操作']>
						<#if searchList?has_content>
		        			<#list searchList as search>
		           				<tr>
		           					
						            <td class="text-center commentId" style="width: 10%">${search.searchId?c?default(0)}</td>
						            <td class="text-center" style="width: 35%" ">
						            	
			            					<span class="updateSearch" data-toggle="tooltip"  data-original-title="点击修改搜索模块" data-id="${search.searchId?c?default(0)}" style="cursor: pointer;">
						            			${search.searchName?default("暂无")}
						            		</span>
						            	
						            </td>
						            <td class="text-center" style="width: 35%">${search.searchTemplets?default("暂无")}</td>
						            <td class="text-center operate" style="width: 10%">
					                    <a class="btn btn-xs tooltips deleteImg" data-toggle="tooltip" data-id="${search.searchId?c?default(0)}" data-original-title="删除">
					                        <i class="glyphicon glyphicon-trash"></i>
					                    </a>
					                    
									</td>
						        </tr>
		           			</#list>
		           		<#else>	
			           			<tr>
						            <td colspan="4" class="text-center">
						            	<@ms.nodata/>
									</td>
					          	</tr>
		           		</#if>
					</@ms.table>
					<@showPage page=page/>
			</@ms.contentPanel>
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
			<!--删除的模态框开始-->
			<@ms.modal modalName="delete" title="删除搜索模板">
				 <@ms.modalBody>
					确定删除该条搜索吗？
			     </@ms.modalBody>
			     <@ms.modalButton>
		    		<@ms.button value="返回" id="closeDelete"/>  
		 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
		 		 </@ms.modalButton>
			</@ms.modal>
			<!--删除的模态框结束-->

		<!--=================模态框部分结束=================-->
	</@ms.content>
	<!--删除模态框-->
	<@warnModal modalName="deleteWarn"/>

	
	<script type="text/javascript">	
	
			//全选
	   	$("#allCheck").on("click",function(){   
			if(this.checked){
			      $("input[name='searchId']").each(function(){this.checked=true;});
			}else{
			      $("input[name='searchId']").each(function(){this.checked=false;});   
			}   
		}); 
	
		//var ids = $("input[name='searchId']").serialize();
		//删除评论 
		function deleteSearch(id){
				var URL="${base}/manager/cms/search/"+id+"/delete.do"
				$(this).request({url:URL,type:"json",method:"post",func:function(msg) {
					//回调处理方式
					if(msg != 0) {
						alert("删除搜索成功");
			    		if($("tbody tr").length==0 && msg != 1){
			    			location.href = base+"/manager/cms/search/list.do?pageNo="+(msg-1);
						}else{
							location.href = base+"/manager/cms/search/list.do?pageNo="+msg;
						}
			    	} else {
						alert("删除搜索失败");
			    	}
				}});
			}
		
		
		
		$(function () {		
			
			//删除搜索模态框
			$(".deleteImg").on("click",function(){
				
				$(".delete").modal();//打开
				var basicId=$(this).attr("data-id");
				$(".delete").modal();//打开
				
				$("#deleteButton").click(function(){
						deleteSearch(basicId);
				});
			});
			
			
			//修改搜索器
			$(".updateSearch").on("click",function(){
				var searchId = $(this).attr("data-id");
				location.href="${base}/manager/cms/search/"+searchId+"/edit.do";
			});	
			
			
			//关闭删除模态框
			$("#closeDelete").click(function(){
				$(".delete").modal("hide");//关闭
			});
			
			//新增搜索
			$("#addButton").on("click",function(){
				location.href="${base}/manager/cms/search/add.do";
			});	
			
		});	
	
	</script>
	
</body>
</html>
