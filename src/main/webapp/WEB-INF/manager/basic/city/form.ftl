<@ms.html5>
	 <@ms.nav title="省市县镇村数据编辑" back=true>
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="cityForm" isvalidation=true>
    		<@ms.hidden name="id" value="${cityEntity.id?default('')}"/>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	var url = "${managerPath}/basic/city/save.do";
	if($("input[name = 'id']").val() > 0){
		url = "${managerPath}/basic/city/update.do";
		$(".btn-success").text("更新");
	}
	//编辑按钮onclick
	function save() {
		$("#cityForm").data("bootstrapValidator").validate();
			var isValid = $("#cityForm").data("bootstrapValidator").isValid();
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
			data:$("form[name = 'cityForm']").serialize(),
			url:url,
			success: function(status) {
				if(status.result == true) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					location.href = "${managerPath}/basic/city/index.do";
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "danger" />
					location.href= "${managerPath}/basic/city/index.do";
				}
			}
		})
	}	
</script>
