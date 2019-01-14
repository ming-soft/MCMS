<@ms.html5>
	<@ms.nav title="模板管理"></@ms.nav>
	<@ms.panel>
		<@shiro.hasPermission name="template:upload"><@ms.uploadFile path="" uploadFloderPath="templets/${websiteId}/" inputName="websiteStyle" size="10" filetype="*.zip" msg="建议上传30M以下的zip文件,模版名称不能使用中文,zip的压缩方式为:存储"  maxSize="30" callBack="setUrl" isRename="false"/></@shiro.hasPermission> 
		<@ms.table head=['<th class="text-center">图标</th>','模板名称',"<th style='width:20%;text-align:center'>类型</th>","<th class='text-center' style='width:10%;'>操作</th>"]>
			<#if folderNameList?has_content>
           		<#list folderNameList as folderName>
		        	<tr> 
			            <td style="width:7%" class="pic text-center"><span class='glyphicon glyphicon-folder-close'></span></td>
			            <td style="width:35%">${folderName}</td>
			            <td class="text-center">文件夹</td>
			            <td style="width:10%;text-align:center">
			            	<@shiro.hasPermission name="template:del">	
			            	<a class="btn btn-xs tooltips deleteIcon" data-toggle="tooltip" data-title="${folderName}" data-original-title="删除">
		                        <i class="glyphicon glyphicon-trash" style="color:#428BCA"></i>
		                    </a>	
		                    </@shiro.hasPermission>	
		                    <@shiro.hasPermission name="template:update">	      
	                    	<a  class="btn btn-xs tooltips" href="${managerPath}/template/showChildFileAndFolder.do?skinFolderName=templets/${websiteId}/${folderName}" data-toggle="tooltip" target="_self" data-original-title="打开文件夹" >
	                     		<i class="glyphicon glyphicon-log-in" style="color:#428BCA"></i>
	                    	</a>	
	                    	</@shiro.hasPermission>		                    	
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
	</@ms.panel>
</@ms.html5>
	<!--=================模态框部分开始=================-->
	<@ms.modal modalName="delete" title="删除模板">
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
       		fileUrl = e;
           	 $.ajax({
				   type: "post",
				   url: base+"${baseManager}/template/unZip.do",
				   data: "fileUrl=" + fileUrl,
				   success: function(msg){ 
				   		<@ms.notify msg= "模版上传成功!" type= "success" />
				     	location.href=base+"${baseManager}/template/queryTemplateSkin.do"
				   }
			  });            	   
	   	} 
       
       	//点击返回按钮，关闭模态框
       	$("#closeDelete").click(function() {
       		$(".delete").modal("hide");
       	})
       
       	//点击删除按钮进行删除模版
		$("#deleteButton").click(function(){
			var URL = base+"${baseManager}/template/delete.do";
			var DATA = "fileName=" + name;
			$(this).attr("disabled",true);
			$(this).text("删除中");
			$(this).request({url:URL,data:DATA,type:"json",method:"post",func:function(msg) {
				if(msg){
			      	<@ms.notify msg= "删除模版成功" type= "success" />
			      	location.href=base+"${baseManager}/template/queryTemplateSkin.do"
			      } else {
			      	<@ms.notify msg= "删除模版失败" type= "warning" />
			      	$("#deleteButton").attr("disabled",false);
					$("#deleteButton").text("删除");
			      }
			}});
			
		});
		
       	//删除模版
		$("table").delegate(".deleteIcon","click",function(){
			name = $(this).attr("data-title");
			$(".delete").modal();
		});	   
	</script>
