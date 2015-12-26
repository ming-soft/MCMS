<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/macro.ftl"/>
<#include "/manager/include/meta.ftl"/>
</head>
<style>
	.container{margin:0;padding:0;width:auto}
	hr{margin-top:9px;margin-bottom:9px;padding:0;}
	.rowpadding3{padding-bottom: 3px;}
	.ms-button-group{padding:0px 0px 8px 0px}
	.row {margin-left:0;margin-right:0}
	.form-horizontal .form-group{margin-left:0;margin-right:0}
	.form-group{overflow: hidden;}
	.bs-example>.dropdown>.dropdown-menu {position: static;margin-bottom: 5px;clear: left;}
	.bs-example>.dropdown>.dropdown-toggle {float: left;}
	.padding-zero{padding:0;}
	.link-style a{color:black;}
	.form-inline .form-group {display: inline-block;margin-bottom: 0;vertical-align: middle;}
	.dedeteRight{width: 32%;margin: 0 auto;overflow: hidden;}
	/*弹出窗口样式*/
	#WindowDialog .modal-dialog{width:auto;}
	.has-error .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#A94442;}
	.has-success .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#3C763D;}
</style>
<body>
	<@ms.content>
	<@ms.contentBody width="" >
	
		<!--标题和顶部更新按钮开始-->
		<@ms.contentNav title="模版管理 编辑模版文件">
			<@ms.panelNavFilter>
				<@ms.contentNavBack onclick="javascript:history.go(-1)" value="返回上一层"/>
			</@ms.panelNavFilter>
		</@ms.contentNav >
		<!--标题和顶部更新按钮结束-->
		<@ms.contentPanel>
						
			
				
				<@ms.form name="form"  id="editFileForm" >
					<@ms.row>
						<!--提示文字-->
						<@ms.col size="1"  style="text-align: right;">文件名称:</@ms.col>
						<@ms.col size="4">
							<@ms.text title="" size="3" value="${fileName}"  name="fileName" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符"} />
						</@ms.col>
						<@ms.col size="12"></@ms.col>
						<!--表单名称-->
						<@ms.col size="1" style="text-align: right;">文件内容:</@ms.col>
						<@ms.col size="11">
							<@ms.textarea name="fileContent" style="width:129.3%"  wrap="Soft" rows="21"  size=""  value="${fileContent}"  />
						</@ms.col>
						<@ms.hidden  id="fileName" value="${fileName}" />
						<@ms.hidden  id="fileNamePrefix" value="${fileNamePrefix}" />
						<@ms.col size="1"></@ms.col>
						<@ms.col size="2">
		    				<@ms.button class="btn btn-success update" value="修改" />
		    				<@ms.button class="btn btn-default" value="取消" onclick="javascript:history.go(-1)" />
		    			</@ms.col>
		    			
		    		</@ms.row>		
	    		</@ms.form>
				
			
			
			
		</@ms.contentPanel>
	</@ms.contentBody>
</@ms.content>   
	
	
	
	
	<script type="text/javascript">
		
		$(function () {	
			//修改文件
			$(".update").on("click",function(){
				var formData = $("#editFileForm").serialize();
				var URL="${base}/manager/cms/templet/writeFileContent.do"
				var oldFileName = $("#fileName").val();
				var fileNamePrefix = $("#fileNamePrefix").val();
				$(this).request({url:URL,type:"json",method:"post",data:formData+"&oldFileName="+oldFileName+"&fileNamePrefix="+fileNamePrefix,func:function(msg) {
					//回调处理方式
					if(msg.result){
			    		alert("修改模版文件成功");
			    	} else {
			    		alert("修改模版文件失败");
			   	  	}
			   	  	var fileNameUrl = $(".fileNamePrefix").val();
			   	  	//location.href = base+"/manager/cms/templet/showChildFileAndFolder.do?skinFolderName=" + fileNameUrl;
				}});
			});
		});
	</script>
</body>
</html>

