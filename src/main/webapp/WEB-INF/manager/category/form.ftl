<@ms.html5>
	 <@ms.nav title="${modelTitle}编辑" back=true>
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="categoryForm" isvalidation=true>
    		<@ms.hidden name="categoryId" value="${categoryEntity.categoryId?default('')}"/>
			<@ms.hidden name="categoryModelId" value="${modelId?default('0')}"/>
			<@ms.text label="${modelTitle}标题" name="categoryTitle" value="${categoryEntity.categoryTitle?default('')}"  width="240px;" placeholder="请输入类别标题" validation={"required":"true","maxlength":"50","data-bv-stringlength-message":"类别标题长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    		<@ms.textarea colSm="2" name="categoryDescription" label="${modelTitle}描述" wrap="Soft" rows="3"  size="" width="642px;" value="${categoryEntity.categoryDescription?default('')}" placeholder="${modelTitle}描述" validation={"maxlength":"50","data-bv-stringlength-message":"栏目描述长度不能超过五十个字符长度!"}/>
    		<@ms.formRow label="缩略图">
				<@ms.uploadImg path="category" inputName="categorySmallImg" size="15" filetype="" msg=""  maxSize="1" imgs="${(category.categorySmallImg)?default('')}" />
    		</@ms.formRow>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	var url = "${managerPath}/category/save.do";
	if($("input[name = 'categoryId']").val() > 0){
		url = "${managerPath}/category/update.do";
		$(".btn-success").text("更新");
	}
	//编辑按钮onclick
	function save() {
		$("#categoryForm").data("bootstrapValidator").validate();
			var isValid = $("#categoryForm").data("bootstrapValidator").isValid();
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
			data:$("form[name = 'categoryForm']").serialize(),
			url:url,
			success: function(status) {
				if(status.categoryId != null) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					history.go(-1); 
					location.reload();
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "danger" />
				}
			}
		})
	}	
</script>
