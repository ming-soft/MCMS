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
			<@ms.contentNav title="模板列表"></@ms.contentNav>
			<@ms.contentPanel>
					<!--上传模板文件夹-->
					<@ms.form name="">
						<@ms.row>
							<@ms.col style="line-height: 30px;text-align: right;">
								<b>模版上传:</b>
							</@ms.col>
							
							<@ms.col size="5">
								<@uploadFile path="templets/${websiteId}/" inputName="websiteStyle" size="10" filetype="zip" msg="建议上传30M以下的zip文件,zip的压缩方式为:存储"  maxSize="30" callBack="setUrl" isRename="false"/>
							</@ms.col>
						</@ms.row>

					</@ms.form>
					
					<@ms.table head=['图标','模板名称','类型','操作']>
						<#if folderNameList?has_content>
			           		<#list folderNameList as folderName>
					        	<tr> 
						            <td class="text-center"><span class='glyphicon glyphicon-folder-close'></span></td>
						            <td class="text-left" style="text-align: center;">${folderName}</td>
						            <td class="text-center">文件夹</td>
						            <td class="text-center">
						            	<a class="btn btn-xs tooltips deleteIcon" data-toggle="tooltip" data-title="${folderName}" data-original-title="删除">
					                        <i class="glyphicon glyphicon-trash" style="color:#428BCA"></i>
					                    </a>				      
				                    	<a class="btn btn-xs tooltips" href="${base}/manager/cms/templet/showChildFileAndFolder.do?skinFolderName=${folderName}" data-toggle="tooltip" data-original-title="打开文件夹" >
				                     		<i class="glyphicon glyphicon-log-in" style="color:#428BCA"></i>
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
			</@ms.contentPanel>
			
		</@ms.contentBody>
	</@ms.content>
	
	<!--=================模态框部分开始=================-->
	<@ms.modal modalName="delete" title="删除评论">
		 <@ms.modalBody>
			确定删除该模板吗？
	     </@ms.modalBody>
	     <@ms.modalButton>
    		<@ms.button value="返回" id="closeDelete"/>  
 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
 		 </@ms.modalButton>
	</@ms.modal>
	<!--=================模态框部分结束=================-->
	
	<script type="text/javascript">
	   var name;
	   var fileUrl;
       function setUrl(e){
       	   if (e<0) {
       	 	  
       	   } else {
       		fileUrl = e;
           	  $.ajax({
				   type: "post",
				   url: base+"/manager/cms/templet/unZip.do",
				   data: "fileUrl=" + fileUrl,
				   success: function(msg){ 
				   		alert("模版上传成功！ 	");
				     	location.href="${base}/manager/cms/templet/queryTempletSkin.do"
				   }
			  });            	   
       	   }
	   }
       
       //点击返回按钮，关闭模态框
       $("#closeDelete").click(function() {
       		$(".delete").modal("hide");
       })
       
       //点击删除按钮进行删除模版
		$("#deleteButton").click(function(){
			
			var URL = "/manager/cms/templet/"+${websiteId}+"/"+name+"/delete.do";
			var DATA = "name=" + name + "&websiteId=" + ${websiteId};
			$(this).request({url:URL,data:DATA,type:"json",method:"post",func:function(msg) {
				if(msg){
			      	alert("删除模版成功");
			      	location.href="${base}/manager/cms/templet/queryTempletSkin.do"
			      } else {
			      	alert("删除模版失败");
			      }
			}});
			
		});
	
	   $(function(){
	       //删除模版
			$("table").delegate(".deleteIcon","click",function(){
				name = $(this).attr("data-title");
				$(".delete").modal();
			});	
	                   
	   }); 
	</script>
</body>
</html>
	