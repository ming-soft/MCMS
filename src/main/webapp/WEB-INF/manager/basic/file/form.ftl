<@ms.html5>
	 <@ms.nav title="基础文件表编辑" back=true>
	 	<#if fileEntity.id??>
	 		<@ms.updateButton  onclick="saveOrUpdate()"/>
	 	<#else>
	 		<@ms.saveButton  onclick="saveOrUpdate()"/>
	 	</#if>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="fileForm" isvalidation=true>
    		<@ms.hidden name="id" value="${(fileEntity.id)?default('')}"/>
			<@ms.text label="文件分类编号" name="categoryId"  value="${(fileEntity.categoryId)?default('')}" width="240px;" placeholder="请输入文件分类编号" validation={"data-bv-between":"true","required":"true", "data-bv-between-message":"文件分类编号必须大于0小于9999999999","data-bv-between-min":"0", "data-bv-between-max":"9999999999","data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="文件名称" name="fileName" value="${(fileEntity.fileName)?default('')}"  width="240px;" placeholder="请输入文件名称" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"文件名称长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="文件链接" name="fileUrl" value="${(fileEntity.fileUrl)?default('')}"  width="240px;" placeholder="请输入文件链接" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"文件链接长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="文件大小" name="fileSize"  value="${(fileEntity.fileSize)?default('')}" width="240px;" placeholder="请输入文件大小" validation={"data-bv-between":"true","required":"true", "data-bv-between-message":"文件大小必须大于0小于9999999999","data-bv-between-min":"0", "data-bv-between-max":"9999999999","data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="文件详情Json数据" name="fileJson" value="${(fileEntity.fileJson)?default('')}"  width="240px;" placeholder="请输入文件详情Json数据" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"文件详情Json数据长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="文件类型：图片、音频、视频等" name="fileType" value="${(fileEntity.fileType)?default('')}"  width="240px;" placeholder="请输入文件类型：图片、音频、视频等" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"文件类型：图片、音频、视频等长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text label="子业务" name="isChild" value="${(fileEntity.isChild)?default('')}"  width="240px;" placeholder="请输入子业务" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"子业务长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>

   	var logoClass = "glyphicon-floppy-saved";
	var url = "${managerPath}/basic/file/save.do";
	if($("input[name = 'id']").val() > 0){
		logoClass = "glyphicon-open";
		url = "${managerPath}/basic/file/update.do";
	}
	//编辑按钮onclick
	function saveOrUpdate() {
		$("#fileForm").data("bootstrapValidator").validate();
			var isValid = $("#fileForm").data("bootstrapValidator").isValid();
			if(!isValid) {
				<@ms.notify msg= "数据提交失败，请检查数据格式！" type= "warning" />
				return;
		}
		var btnWord =$(".btn-success").text();
		$(".btn-success").text(btnWord+"中...");
		$(".btn-success").prop("disabled",true);
		$.ajax({
			type:"post",
			dataType:"json",
			data:$("form[name = 'fileForm']").serialize(),
			url:url,
			success: function(data) {
				if(data.id > 0) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					location.href = "${managerPath}/basic/file/index.do";
				}
				else{
					$(".btn-success").html(btnWord+"<span class='glyphicon " + logoClass + "' style='margin-right:5px'></span>");
					$(".btn-success").text(btnWord);
					$(".btn-success").removeAttr("disabled");
					$('.ms-notifications').offset({top:43}).notify({
					   type:'danger',
					   message: { text:data.resultMsg }
					}).show();
				}
			}
		})
	}	
</script>
