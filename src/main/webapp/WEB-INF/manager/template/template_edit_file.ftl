	<@ms.html5>
		<@ms.nav title="编辑模版文件" back=true>
			<@ms.savebutton  id="update" value="修改"/>
		</@ms.nav>
		<@ms.panel>		
			<@ms.form name="form"  id="editFileForm">
				<!--文件名称-->
				<@ms.text label="文件名称" value="${name?default('')}" readonly="readonly"/>
				<@ms.hidden value="${fileName}" name="fileName" />
				<!--文件内容-->
				<@ms.textarea name="fileContent" label="文件内容"   wrap="Soft" rows="21"  size="" value="${fileContent}"/>
				<@ms.hidden id="fileName" value="${fileName}" />
				<@ms.hidden id="fileNamePrefix" value="${fileNamePrefix}" />		
    		</@ms.form>
		</@ms.panel>
	</@ms.html5> 
	<script type="text/javascript">		
		$(function () {	
			//修改文件
			$("#update").on("click",function(){
				var formData = $("#editFileForm").serialize();
				var URL=base+"${baseManager}/template/writeFileContent.do"
				var oldFileName = $("#fileName").val();
				var fileNamePrefix = $("#fileNamePrefix").val();
				$(this).text("修改中");
				$(this).attr("disabled",true);
				$(this).request({url:URL,type:"json",method:"post",data:formData+"&oldFileName="+oldFileName+"&fileNamePrefix="+fileNamePrefix,func:function(msg) {
					//回调处理方式
					if(msg.result){
			    		<@ms.notify msg= "修改模版文件成功" type= "success" />
			    	} else {
			    		<@ms.notify msg= "修改模版文件失败" type= "warning" />
			   	  	}
			   	  	var fileNameUrl = $(".fileNamePrefix").val();
			   	  	$("#update").text("修改");
					$("#update").attr("disabled",false);
				}});
			});
		});
	</script>

