<@ms.html5>
	 <@ms.nav title="通用用户与信息一对多表编辑" back=true>
    	<@ms.saveButton  onclick="save()"/>
    </@ms.nav>
    <@ms.panel>
    	<@ms.form name="peopleForm" isvalidation=true>
    		<@ms.hidden name="bpId" value="${peopleEntity.bpId?default('')}"/>
    			<@ms.number label="信息编号" name="bpBasicId" value="${peopleEntity.bpBasicId?default('')}" width="240px;" placeholder="请输入信息编号" validation={"required":"false","maxlength":"50","data-bv-stringlength-message":"信息编号长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    			<@ms.number label="用户编号" name="bpPeopleId" value="${peopleEntity.bpPeopleId?default('')}" width="240px;" placeholder="请输入用户编号" validation={"required":"false","maxlength":"50","data-bv-stringlength-message":"用户编号长度不能超过五十个字符长度!", "data-bv-notempty-message":"必填项目"}/>
    			<@ms.text label="创建时间" name="bpDatetime" value="${peopleEntity.bpDatetime?string('yyyy-MM-dd')}"  width="240px;"/>
    	</@ms.form>
    </@ms.panel>
</@ms.html5>
<script>
	var url = "${managerPath}/basic/people/save.do";
	if($("input[name = 'bpId']").val() > 0){
		url = "${managerPath}/basic/people/update.do";
		$(".btn-success").text("更新");
	}
	//编辑按钮onclick
	function save() {
		$("#peopleForm").data("bootstrapValidator").validate();
			var isValid = $("#peopleForm").data("bootstrapValidator").isValid();
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
			data:$("form[name = 'peopleForm']").serialize(),
			url:url,
			success: function(status) {
				if(status.result == true) { 
					<@ms.notify msg="保存或更新成功" type= "success" />
					location.href = "${managerPath}/basic/people/index.do";
				}
				else{
					<@ms.notify msg= "保存或更新失败！" type= "danger" />
					location.href= "${managerPath}/basic/people/index.do";
				}
			}
		})
	}	
</script>
