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
		
			<!--标题-->
			<@ms.contentNav title="模板列表">
				<@ms.panelNavFilter>
					<@ms.contentNavBack onclick="javascript:history.go(-1)" value="返回上一层" />
				</@ms.panelNavFilter>
			</@ms.contentNav>
			
			<@ms.contentPanel>
					<!--上传模板文件夹-->
					<@ms.form name="">
						<@ms.row>
							<@ms.col style="line-height: 30px;text-align: right;">
								<b>文件上传:</b>
							</@ms.col>
							
							<@ms.col size="5">
								<@uploadFile path="templets/${uploadFileUrl}" inputName="file" size="20" filetype="*.htm;*.html;*.jpg;*.gif;*.png;*.css;*.js;*.ico;*.swf" msg="建议上传5M以下htm/html/css/js/jpg/gif/png/swf文件"  maxSize="5" callBack="test" isRename="false"/>
							</@ms.col>
						</@ms.row>
					</@ms.form>
					
					<@ms.table head=['图标','模板名称','类型','操作']>
						<#if fileNameList?has_content>
			           		<#list fileNameList as fileName>
					        	<tr> 
						            <td class="text-center pic"></td>
						            <td class="text-center name">${fileName}</td>
						            <td class="text-center type"></td>
						            <td class="text-center">			      
				                    	<a class="btn btn-xs tooltips deleteIcon" data-toggle="tooltip" data-title="${fileName}" data-original-title="删除">
					                        <i class="glyphicon glyphicon-trash" style="color:#428BCA"></i>
					                    </a>
					                    <a class="btn btn-xs tooltips editFileBtn" data-toggle="tooltip" data-title="${fileName}" data-original-title="编辑">
				                     		<i class="glyphicon glyphicon-pencil" style="color:#428BCA"></i>
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
		var fileName;
		var isSuccess = false;
		var fileUrl;
		var skinFolderName = "${uploadFileUrl?replace("\\","/")}";
		
	   var interval;  
       function run() {  
          interval = setInterval(chat, "1000");  
       }  
       function test(e){
            isSuccess = true;
            fileUrl = e;
			alert("模版文件上传成功 ");
	   }
       function chat() {  
       	  if(isSuccess){
       	  	  clearTimeout(interval);  //关闭定时器  
       	  	  var temp = $(".deleteIcon").attr("data-title");
       	  	  if(temp == null || temp == ""){
       	  	  	temp = $(".editFileBtn").attr("data-title");
       	  	  }
       	  	  if(temp != null && temp != ""){
       	  	  	temp = temp.substring(0,temp.lastIndexOf("/"));
       	  	  } else {
       	  	  	temp = skinFolderName.substring(skinFolderName.indexOf("/"));
       	  	  	temp = temp.substring(temp.indexOf("/"));
       	  	  }
       	  	  //若上传的为zip压缩文件则直接解压
       	  	  if($("#file").val().substring($("#file").val().lastIndexOf(".")+1) == "zip"){
	       	  	  $.ajax({
					   type: "post",
					   url: base+"/manager/cms/templet/unZip.do",
					   data: "fileUrl=" + fileUrl,
					   success: function(msg){ 
					     	location.href="${base}/manager/cms/templet/showChildFileAndFolder.do?skinFolderName="+temp;
					     	fileName = temp + fileUrl.substring(fileUrl.lastIndexOf("/"));
					     	//deleteTempletsFile();
					     	$("#deleteButton").click();
					   }
				  });
			  } else {
	     	 	 location.href="${base}/manager/cms/templet/showChildFileAndFolder.do?skinFolderName="+temp;
	     	  }
           }
       }
		
		//删除模版文件
		$("#deleteButton").click(function(){
			
			var URL = base+"/manager/cms/templet/deleteTempletsFile.do";
			var DATA = "fileName=" + fileName;
			$(this).request({url:URL,data:DATA,type:"json",method:"post",func:function(msg) {
					if(msg != 0) {
						alert("删除模版文件成功");
						fileName = fileName.substring(0,fileName.lastIndexOf("/"));
			    		location.href = base+"/manager/cms/templet/showChildFileAndFolder.do?skinFolderName="+fileName;
			    	} else {
						alert("删除模版文件失败");
			    	}
			}});
			
		});
		
		$(function () {	
			//加载页面时启动定时器  
	        run(); 
	        
	        //若为文件夹，则左侧显示文件夹图标；若为文件，则左侧显示文件图标，且稍向右偏移
	       $(".name").each(function(i){
	        	var temp = $(this).html();
	        	if(temp.indexOf(".") >= 0){
	        		$(this).parent().find(".pic").prepend("<span class='glyphicon glyphicon-file'></span>")
	        		$(this).parent().find(".type").prepend("文件")
	        	} else {
	        		$(this).parent().find(".pic").prepend("<span class='glyphicon glyphicon-folder-close'></span>")
	        		$(this).parent().find(".type").prepend("文件夹")
	        		$(this).parent().find(".editFileBtn").attr("data-original-title","打开文件夹");
	        		$(this).parent().find(".editFileBtn").find(".glyphicon").removeClass("glyphicon-pencil");
	        		$(this).parent().find(".editFileBtn").find(".glyphicon").addClass("glyphicon-log-in");	        		
	        		$(this).parent().find(".deleteIcon").remove();
	        	}
	        	var suffix = temp.substring(temp.lastIndexOf(".")+1);
				if(suffix == "jpg" || suffix == "gif" || suffix == "png"){
					$(this).parent().find(".type").prepend("图像")
					$(this).parent().find(".editFileBtn").remove();
				}
	        });

	        
	        //编辑模版文件，若为文件夹，则跳至显示子文件和子文件夹action；若为文件，则直接读取代码内容，且跳至模版文件修改页面
			$("table").delegate(".editFileBtn","click",function(){
				fileName = $(this).attr("data-title");
		        if(fileName.indexOf(".") >= 0){
		        	location.href = base+"/manager/cms/templet/readFileContent.do?fileName="+fileName;
		        } else {
					location.href="${base}/manager/cms/templet/showChildFileAndFolder.do?skinFolderName="+fileName;
				}
			});
	        
			//点击返回按钮，关闭模态框
	       $("#closeDelete").click(function() {
	       		$(".delete").modal("hide");
	       })
			
			//删除模版
			$("table").delegate(".deleteIcon","click",function(){
				fileName = $(this).attr("data-title");
				$(".delete").modal();
			});	
		});
	</script>
</body>
</html>
	