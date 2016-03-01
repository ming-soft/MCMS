<@ms.html5>
	<@ms.nav title="模板管理"></@ms.nav>
	<@ms.panel>
		<@ms.uploadFile path="templets/${websiteId}/" inputName="websiteStyle" size="10" filetype="zip" msg="建议上传30M以下的zip文件,模版名称不能使用中文,zip的压缩方式为:存储"  maxSize="30" callBack="setUrl" isRename="false"/>
		<@ms.table head=['<th class="text-center">图标</th>','模板名称',"<th style='width:20%;text-align:center'>类型</th>","<th class='text-center' style='width:10%;'>操作</th>"]>
			<#if folderNameList?has_content>
           		<#list folderNameList as folderName>
		        	<tr> 
			            <td style="width:7%" class="pic text-center"><span class='glyphicon glyphicon-folder-close'></span></td>
			            <td style="width:35%">${folderName}</td>
			            <td class="text-center">文件夹</td>
			            <td style="width:10%;text-align:center">
			            	<a class="btn btn-xs tooltips deleteIcon" data-toggle="tooltip" data-title="templets/${websiteId}/${folderName}" data-original-title="删除">
		                        <i class="glyphicon glyphicon-trash" style="color:#428BCA"></i>
		                    </a>				      
	                    	<a  class="btn btn-xs tooltips" href="${base}/manager/cms/templet/showChildFileAndFolder.do?skinFolderName=templets/${websiteId}/${folderName}" data-toggle="tooltip" data-original-title="打开文件夹" >
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
				   url: base+"/manager/cms/templet/unZip.do",
				   data: "fileUrl=" + fileUrl,
				   success: function(msg){ 
				   		alert("模版上传成功!");
				     	location.href="${base}/manager/cms/templet/queryTempletSkin.do"
				   }
			  });            	   
	   	} 
       
       	//点击返回按钮，关闭模态框
       	$("#closeDelete").click(function() {
       		$(".delete").modal("hide");
       	})
       
       	//点击删除按钮进行删除模版
		$("#deleteButton").click(function(){			
			var URL = base+"/manager/cms/"+name.replace("templets","templet")+"/delete.do";
			var DATA = "name=" + name + "&websiteId=" + ${websiteId};
			$(this).attr("disabled",true);
			$(this).text("删除中");
			$(this).request({url:URL,data:DATA,type:"json",method:"post",func:function(msg) {
				if(msg){
			      	alert("删除模版成功");
			      	location.href="${base}/manager/cms/templet/queryTempletSkin.do"
			      } else {
			      	alert("删除模版失败");
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
