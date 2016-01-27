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
			<@ms.contentNav title="记录列表">
					<@ms.contentNavBack onclick="javascript:history.go(-1)" value="返回自定义列表"/>
			</@ms.contentNav>
			<@ms.contentPanel>

					<@ms.table head=['数据','<th class="text-center">提交时间</th>',"<th class='text-center'>操作</th>"]>
						<#if list?has_content>
		        			<#list list as form>
		           				<tr> 
			           			<!--<td class="text-center basicId">${form['Id']?default(0)}</td>-->
			           				<td style="width:40%">
			           					<ul>
								           	<#list fields as field>
								            	<li><b style="color:#999">${field.diyFormFieldTipsName}:</b>${form['${field.diyFormFieldFieldName}']?default('')}</li>
								            </#list>
			            				</ul>
			           				</td>
			            			<td style="width:40%" id="name" class="text-center">${form.date?default("")}</td>
			            			<td class="text-center">
                    					<a class="btn btn-xs red tooltips del-btn " data-toggle="tooltip" data-original-title="删除" data-url="${basePath}/manager/diy/form/${form['fromID']?default(0)}/${form['Id']?default(0)}/delete.do">
	                     					<i class="glyphicon glyphicon-trash"></i>
	                    				</a>
									</td>
			        			</tr>
			        	</#list>
		           	<#else>
			           	<tr>
				            <td colspan="5" class="text-left">
				            	<@ms.nodata/>
							</td>
			          	</tr>
		          	</#if>
					</@ms.table>
					<!--分页样式 开始-->
					<#if page?has_content>
						<@showPage page=page/>
					</#if>
			</@ms.contentPanel>
		</@ms.contentBody>
		
		<!--删除自定义表单提交数据开始-->    
				<@ms.modal modalName="delete" title="删除数据">
					  <@ms.modalBody>
					  		确定要删除该数据吗?
				     </@ms.modalBody>
					 <@ms.modalButton>
				 		<@ms.button class="btn btn-danger deleteData" value="确定" url="${basePath}/manager/diy/form/0/0/delete.do"/>
				 	</@ms.modalButton>
				</@ms.modal>
		<!--删除自定义表单提交数据结束-->    		
	</@ms.content>	
</body>
</html>

<script>
//进行字段删除的函数

$(function(){
	//删除按钮点击
	$(".del-btn").click(function() {
		var url = $(this).attr("data-url");		
		$(".deleteData").attr("data-ajax-url",url);
		$(".delete").modal();
		//设置
	});
	//点击确定进行删除
	$(".deleteData").click(function() {
		$(".deleteData").text("删除中");
		$(".deleteData").attr("disabled",true);
		$(this).request({method:"post",func:function(msg) { 
			var json = jQuery.parseJSON(msg);
			if(json.result==true){
				alert("删除成功");
			}else{
				alert("删除失败");
			}
			location.reload();
		}});
	});
	
})
</script>
	