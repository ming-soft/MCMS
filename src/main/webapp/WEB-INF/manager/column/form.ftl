<@ms.html5>
	<@ms.nav title="栏目管理" back=true>
		<#if column.categoryId == 0>
	 		<@ms.saveButton id="saveUpdate" value="保存"/>
	 	<#else>
	 		<@ms.updateButton id="saveUpdate" value="更新"/>
	 	</#if>
		</@ms.nav>
	<@ms.panel>
		<@ms.form name="columnForm" isvalidation=true  action="" method="post" >
				<#if column.categoryId!=0>
					<@ms.hidden name="categoryId" value="${column.categoryId?c?default(0)}" />
				</#if>
				<@ms.text name="categoryTitle" width="200" label="${Session.model_title_session?default('栏目')}名称" title="${Session.model_title_session?default('栏目')}名称" placeholder="${Session.model_title_session?default('栏目')}名称" value="${column.categoryTitle?default('')}" id="" validation={"data-bv-stringlength":"true","required":"true", "data-bv-notempty-message":"必填项目", "data-bv-regexp":"true","data-bv-regexp-regexp":'^[^[!@#$%^&*()_+-/~?！@#￥%…&*（）——+—？》《：“‘’]+$',"data-bv-stringlength-max":"50","data-bv-regexp-message":"${Session.model_title_session?default('栏目')}名称不能包含特殊字符","data-bv-stringLength-message":"长度不能超过50个字符"} />
		        <@ms.formRow label="所属栏目" width="300">
					<@ms.treeInput treeId="inputTree"  json="${listColumn?default('')}"  jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" inputName="categoryCategoryId" inputValue="${column.categoryCategoryId?c?default(0)}" addNodesName="顶级栏目管理"  buttonText="${columnSuper.categoryTitle?default('顶级栏目管理')}" clickZtreeId="clickZtreeId(event,treeId,treeNode);"  expandAll="true" showIcon="true"/>
				</@ms.formRow>
          		<@ms.text name="categorySort"  width="200"  label="自定义顺序" title="自定义顺序" size="5"  placeholder="请输入文章顺序" value="${column.categorySort?c?default(0)}"  validation={"data-bv-between":"true","data-bv-between-message":"自定义顺序必须大于0","data-bv-between-min":"0", "data-bv-between-max":"99999999","data-bv-notempty-message":"自定义顺序不能为空","data-bv-between-message":"请输入0-99999999之间的数","required":"true", "data-bv-notempty-message":"必填项目"}/>
          		<@ms.textarea name="columnKeyword" width="600" label="${Session.model_title_session?default('栏目')}关键字" wrap="Soft" rows="4" placeholder="${Session.model_title_session?default('栏目')}关键字，有助于搜索"   value="${column.columnKeyword?default('')}"  validation={"data-bv-stringlength":"true", "data-bv-stringlength-max":"200","data-bv-stringLength-message":"长度不能超过200个字符"} /> 
          		<@ms.textarea name="columnDescrip" width="600" label="${Session.model_title_session?default('栏目')}描述" wrap="Soft" rows="4" placeholder="${Session.model_title_session?default('栏目')}描述，对${Session.model_title_session?default('栏目')}关键字的扩展"   value="${column.columnDescrip?default('')}" validation={"data-bv-stringlength":"true", "data-bv-stringlength-max":"200","data-bv-stringLength-message":"长度不能超过200个字符"} />
				<@ms.formRow label="缩略图" width="400">
					<@ms.uploadImg path="column" imgs="${(column.categorySmallImg)?default('')}" inputName="categorySmallImg" size="1" msg="提示：栏目缩略图,最多可上传1张"  maxSize="2"   />
				</@ms.formRow>
				<#assign columnTypes=[{"id":"1","name":"列表"},{"id":"2","name":"封面"}]>
				<@ms.radio name="columnType" label="${Session.model_title_session?default('栏目')}属性"  list=columnTypes listKey="id" listValue="name" value="${column.columnType?c?default(1)}" />
				<@ms.select name="columnContentModelId" width="200"  list=[]  listKey="cmId" listValue="cmTipsName"  label="${Session.model_title_session?default('栏目')}内容模型"  default="请选择" value="0"/>
				<#assign columnModelUrls=[{"id":"0","name":"暂无文件"}]>
				<@ms.select name="columnListUrl" width="300" id="columnListUrlModel"  list=columnModelUrls  listKey="id" listValue="name" label="列表模版"  value="${column.columnListUrl?default('')}"  select2=true/>
				<@ms.select name="columnUrl" width="300" id="columnUrlModel" default="暂无文件"  list=columnModelUrls  listKey="id" listValue="name" label="内容模版"  value="${column.columnUrl?default('')}"  select2=true/>
				<@ms.hidden name="modelId"  value="${Session.model_id_session?default('0')}" />
			</@ms.form>
	</@ms.panel>
</@ms.html5>	
<script>
$(function(){

	var columnContentModelId= "${column.columnContentModelId?default('')}"
	$("select[name=columnContentModelId]").find("option[value="+columnContentModelId+"]").attr("selected","selected");
	<#if column.columnType == 0> 
		  $("input:radio[name='columnType']:first").attr("checked",true);
	</#if>
	var columnListUrlSes = "${column.columnListUrl?default('')}";
	var columnUrlSes = "${column.columnUrl?default('')}";
	//页面加载列表模板和内容模板
	$.ajax({
	   type: "post",
	   dataType: "json",
	   url:  "${managerPath}/template/queryTemplateFileForColumn.do",
	   success: function(msg){
	   		$("#columnListUrlModel").html("");
	     	$("#columnUrlModel").html("");
	     	if(msg.length != 0){
	   			for(var i=0; i<msg.length; i++){
	   				if(msg[i] == columnListUrlSes) {
	   					$("#columnListUrlModel").append("<option selected>"+msg[i]+"</option>")
	   				}else{
	   					$("#columnListUrlModel").append("<option>"+msg[i]+"</option>")
	   				}
		   			if( msg[i] == columnUrlSes){
		   				$("#columnUrlModel").append("<option selected>"+msg[i]+"</option>")
		   			}else{
		   				$("#columnUrlModel").append("<option>"+msg[i]+"</option>")
		   			}
		   		}
	   		}else{
	   			$("#columnListUrlModel").append("<option>暂无文件</option>");
			   	$("#columnUrlModel").append("<option>暂无文件</option>");
	   		}
	   		<#if column.columnType ==2 >
				$("#columnListUrlModel").parents(".form-group").hide();
				$("#columnListUrlModel").css("disabled",true);
				$("#columnUrlModel").parent().prev().text("封面模板:");
			</#if>
	   }
	});	
	
	//切换栏目属性
	$("input[name='columnType']").click(function(){
		if($(this).val()== 2){
			$("#columnListUrlModel").parents(".form-group").hide();
			$("#columnListUrlModel").css("disabled",true);
			$("#columnUrlModel").parent().prev().text("封面模板:");
		}else if($(this).val()== 1){
			$("#columnListUrlModel").parents(".form-group").show();
			$("#columnListUrlModel").css("disabled",false);
			$("#columnUrlModel").parent().prev().text("内容模板:");
		}
	});
	
	//栏目保存提交事件
	$("#saveUpdate").click(function(){
		$("#columnForm").data("bootstrapValidator").validate();
		var isValid = $("#columnForm").data("bootstrapValidator").isValid();
		if(!isValid) {
			<@ms.notify msg= "数据提交失败，请检查数据格式！" type= "warning" />
			return;
		}
		if($("#columnListUrlModel").find("option:selected").text()=="暂无文件"){
			$("#columnListUrlModel").find("option:selected").text("");
		}
		if($("#columnUrlModel").find("option:selected").text()=="暂无文件"){
			$("#columnUrlModel").find("option:selected").text("");
		}
		//如果选择的是普通文章，则
		if($("select[name=columnContentModelId]").find("option:selected").val()==""){
			$("select[name=columnContentModelId]").find("option:selected").val(0)
		}
		var formdata = $("#columnForm").serialize();
		var URL = "";
		<#if column.categoryId==0>
		URL ="${managerPath}/${model?default("")}/column/save.do?modelId=${Session.model_id_session?default(0)}&modelTitle=${Session.model_title_session?default('')}";
		<#else>
		URL = "${managerPath}/${model?default("")}/column/update.do?modelId=${Session.model_id_session?default(0)}&modelTitle=${Session.model_title_session?default('')}";
		</#if>
		if(isNaN($("input[name=categorySort]").val())){
			<@ms.notify msg= "自定义排序必须是数字" type= "warning" />
			$("input[name=categorySort]").val(0);
			return;
		}
		$.ajax({
		   	type: "post",
		   	url: URL,
		   	data: formdata,
		   	dataType:"json",
		   	beforeSend:function(){
		   		//获取按钮值
				var bottonText = $("#saveUpdate").text().trim();
				//设置按钮加载状态值
				$("#saveUpdate").attr("data-loading-text",bottonText+"中");
				//执行加载状态
				$("#saveUpdate").button('loading');
		   	},
		   	success: function(msg){
		    	if (msg.result) {
	     			<#if column.categoryId==0>
	     				<@ms.notify msg= "保存成功" type= "success" />
	     			<#else>
	     				<@ms.notify msg= "更新成功" type= "success" />	
	     			</#if>
	     			var modelId = ${Session.model_id_session?default(0)};
	     			location.href="${managerPath}/${model?default("")}/column/index.do?modelId=${Session.model_id_session?default(0)}&modelTitle=${Session.model_title_session?default('')}";
	    		}else{
	    			<#if column.categoryId==0>
	     				<@ms.notify msg= "保存失败" type= "warning" />
	     			<#else>
	     				<@ms.notify msg= "更新失败" type= "warning" />
	     			</#if>
	    		}
	    		$("#saveUpdate").button('reset')
		   	}
		});
	});
	//获取内容模型列表
	$.ajax({
		type: "post",
		url: "${managerPath}/mdiy/contentModel/list.do?pageSize=100",
		dataType: "json",
		contentType: "application/json",
		success:function(data) {
			for( var i=0 ; i<data.rows.length ; i++){
				var value = data.rows[i];
				var columnContentModelId = ${column.columnContentModelId?c?default(0)};
				if(columnContentModelId == value.cmId){
					$("select[name=columnContentModelId]").append("<option value = "+value.cmId+" selected='selected'>"+value.cmTipsName+"</option>");		//添加<option>元素
				}else{
					$("select[name=columnContentModelId]").append("<option value = "+value.cmId+">"+value.cmTipsName+"</option>");		//添加<option>元素
				}
				
			}
		}
	})
});

//选择栏目后查询自定义模型
function clickZtreeId(event,treeId,treeNode){
	//栏目不能选择自己及其子栏目为父栏目的事件
	<#if column.categoryId gt 0 >
		var booleanClick=true;
		var nodeParam = zTreeObjinputTree.getNodesByParam("categoryId", "${column.categoryId?c?default(0)}", null);
		var nodes = zTreeObjinputTree.getNodesByParam("categoryId", treeNode.categoryId, nodeParam[0]);
		if(nodes.length>0 || treeNode.categoryId == nodeParam[0].categoryId){
			booleanClick=false;
			<@ms.notify msg= "不能选择该栏目作为父栏目" type= "warning" />
		}
		return booleanClick;
	</#if>
} 
</script>
