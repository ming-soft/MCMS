<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/macro.ftl"/>
<#include "/manager/include/meta.ftl"/>
<style>
	
	 hr{margin-top:9px;margin-bottom:9px;padding:0;}
	.form-horizontal .form-group{margin-left:0;margin-right:0}
	.form-group{overflow: hidden;}
	.padding-zero{padding:0;}
	/*链接样式*/
	.link-style a:hover{color:#000;}
	.link-style a:visited{color:#000;}
	.form-inline .form-group {display: inline-block;margin-bottom: 0;vertical-align: middle;}
	/*弹出窗口样式*/
	#WindowDialog .modal-dialog{width:auto;}
	.control-label{font-weight:normal;font-size:14px;}
	.margin20{ margin-top:20px;}
	.marginleft70{ margin-left:-70px;}
	.form-control{ padding-right:22px;} 
	.fieldRadio{float:left;width:50%;height:25px;}
</style>
</head>
<body>
	
<@ms.content>
	<@ms.contentBody width="" >
	
			<!--标题和顶部更新按钮-->
			<#if diyForm?has_content>
				<@ms.contentNav title="更新自定义表单">
					<@ms.panelNavFilter>
						<@ms.contentNavBack  onclick="location.href='${base}/manager/diy/form/list.do'" value="返回表单列表"/>
					</@ms.panelNavFilter>
				</@ms.contentNav >
			<#else>
				<@ms.contentNav title="新增自定义表单">
					<@ms.panelNavFilter>
						<@ms.contentNavBack   onclick="location.href='${base}/manager/diy/form/list.do'" value="返回表单列表"/>
					</@ms.panelNavFilter>
				</@ms.contentNav >
			</#if>	
		<@ms.contentPanel>
			<div class="form-group">
				<label class="col-md-2 control-label col-xs-2 "><h4><strong>自定义表单信息</strong></h4></label>
			</div>
			
				<@ms.row>
					<@ms.col size="12">
					<#if diyForm?has_content>
						<@ms.form  name="saveForm" class="diyFormFrom" action="${base}/manager/diy/form/update.do">
							<!--提示文字-->
							<@ms.col  style="text-align: right; width:15%;">自定义表单名称</@ms.col>
							<@ms.col size="4">
								<@ms.text title="名称" size="3" value="${diyForm.diyFormTipsName?default('')}" placeholder="请输入自定义表单名称" name="diyFormTipsName" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符"} />
							</@ms.col>
							<@ms.col size="12"></@ms.col>
							<!--表单名称-->
							<@ms.col  style="text-align: right; width:15%;">自定义表单表名</@ms.col>
							<@ms.col size="4">
								<@ms.text title="名称" size="3" value="${diyForm.diyFormTableName?default('')}"  placeholder="表名只能为英文字符或下划线或数字" name="diyFormTableName" readonly="true" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z0-9_]+$',"data-bv-regexp-message":"表单名称只能由英文字母，数字，下划线组成!"}/>
								<span style=" height:30px; line-height:30px; color:#F00;font-weight:bold;">注：自定义表单表名一旦保存不能再更改</span>
							</@ms.col>
							
							
							<@ms.col size="12"></@ms.col>
							<@ms.col style="width:15%;"></@ms.col>
							<@ms.col size="4">
			    				<@ms.button class="btn btn-primary saveDiyForm" value="更新表单" />
			    			</@ms.col>
		    			</@ms.form>
					<#else>
						<@ms.form  name="saveForm" class="diyFormFrom" action="${base}/manager/diy/form/save.do">
							<!--提示文字-->
							<@ms.col  style="text-align: right; width:15%;">自定义表单名称</@ms.col>
							<@ms.col size="4">
								<@ms.text title="名称" size="3"  placeholder="请输入自定义表单名称" name="diyFormTipsName" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符"}/>
							</@ms.col>
							<@ms.col size="12"></@ms.col>
							<!--表单名称-->
							<@ms.col  style="text-align: right; width:15%;">自定义表单表名</@ms.col>
							<@ms.col size="4">
								<@ms.text  title="名称" size="3"   placeholder="表名只能为英文字符或下划线或数字" name="diyFormTableName"  validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z0-9_]+$',"data-bv-regexp-message":"表单名称只能由英文字母，数字，下划线组成!"}/>
								<span style=" height:30px; line-height:30px; color:#F00;font-weight:bold;">注：自定义表单表名一旦保存不能再更改</span>
							</@ms.col>
							<@ms.col size="12"></@ms.col>
							<@ms.col style="width:15%;"></@ms.col>
							<@ms.col size="4">
			    				<@ms.button class="btn btn-primary saveDiyForm" value="保存表单"/>
			    			</@ms.col>
			    		</@ms.form>
					</#if>
					</@ms.col>
				</@ms.row>
			
			<#if diyForm?has_content>
			<hr>
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-2 "><h4><strong>字段信息</strong></h4></label>
				</div>
				<!--新增按钮-->
				<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						<@ms.panelNavBtnAdd  id="addField"/>
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
    			<@ms.table head=['编号','字段提示文字','字段名称','字段类型','操作']>
						<#if searchList?has_content>
		        			<#list searchList as search>
		           				<tr>
						            <td class="text-center commentId" style="width: 10%"></td>
						            <td class="text-center" style="width: 30%"></td>
						            <td class="text-center" style="width: 30%"></td>
						            <td class="text-center" style="width: 30%"></td>
						            <td class="text-center operate" style="width: 10%">
					                    <a class="btn btn-xs tooltips deleteImg" data-toggle="tooltip" data-id="" data-original-title="删除">
					                        <i class="glyphicon glyphicon-trash"></i>
					                    </a>
					                     <a class="btn btn-xs red tooltips  updateSearch" data-toggle="tooltip"  data-original-title="编辑" data-id="">
					                     	<i class="glyphicon glyphicon-pencil"></i>
					                    </a>
									</td>
						        </tr>
		           			</#list>
		           		<#else>	
			           			<tr>
						            <td colspan="5" class="text-center">
						            	<@ms.nodata/>
									</td>
					          	</tr>
		           		</#if>
					</@ms.table>
				
			</#if>	
		</@ms.contentPanel>
	</@ms.contentBody>
</@ms.content>   

	


	<!--删除的模态框开始-->
	<@ms.modal modalName="deleteModal" title="删除字段">
		 <@ms.modalBody>
			确定删除该字段吗？
	     </@ms.modalBody>
	     <@ms.modalButton>
    		<@ms.button value="返回" id="closeDelete"/>  
 			<@ms.button class="btn btn-danger" id="deleteButtonField" value="删除"/>  
 		 </@ms.modalButton>
	</@ms.modal>
	<!--删除的模态框结束-->
	
	
	
	<!--编辑和新增字段模态框-->
	
	<!--编辑和新增字段模态框开始-->
	<@ms.modal modalName="openModal" title="">
		 <@ms.modalBody>
		
			<div class="row" id="fieldModel">
		<form action="" class="form-horizontal" role="form" id="fieldFrom">
			<@ms.row>
				<!--字段提示文字-->
				<@ms.col size="4" style="text-align: right;">字段提示文字:</@ms.col>
				<@ms.col size="7">
					<@ms.text title="名称"  size="3"  value="" placeholder="请输入提示文字" name="diyFormFieldTipsName" validation={"required":"true", "data-bv-notempty-message":"不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"100","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-100个字符"} />
				</@ms.col>
				
				<!--字段名称-->
				<@ms.col size="4" style="text-align: right;">字段名称:</@ms.col>
				<@ms.col size="7">
					<@ms.text title="名称" size="3" value=""  placeholder="请输入字段名称" name="diyFormFieldFieldName"  validation={"required":"true", "data-bv-notempty-message":"不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"100","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-100个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z0-9]+$',"data-bv-regexp-message":"字段名只能为字符!"}  />
				</@ms.col>
				
				<!--数据类型-->
				<@ms.hidden name="fieldCmid" value=""  />
				<@ms.col size="4" style="text-align: right;">数据类型:</@ms.col>
				<@ms.col size="7">
					<div  id="fieldTypeInfo"></div>
				</@ms.col>
				<@ms.col size="12" style="height: 8px;"></@ms.col>
				<!--是否是必填字段-->
				<@ms.col size="4" style="text-align: right;">是否是必填字段:</@ms.col>
				<@ms.col size="7">
					<div class='fieldRadio'>
						<input value='0' name="diyFormFieldIsNull" type="radio"/>必填
					</div>
					<div class='fieldRadio'>
						<input value='1' type="radio" name="diyFormFieldIsNull"/>可选
					</div>
				</@ms.col>
				<@ms.col size="12" style="height: 8px;"></@ms.col>
				<!--字段默认值-->
				<@ms.col size="4" style="text-align: right;">字段默认值:</@ms.col>
				<@ms.col size="7">
					<@ms.textarea name="diyFormFieldDefault"   wrap="Soft" rows="5"  size=""  value=""  placeholder="下拉框,多选框等存在多个默认值的必须使用英文逗号隔开"/>
				</@ms.col>
				<@ms.hidden name="diyFormFieldFormId" value=""  />
				<div id="hideFieldId" style="display:none;"></div>
			</@ms.row>
		
			
		
		</form>
	</div>
	     </@ms.modalBody>
	     <@ms.modalButton>
    		<@ms.button value="返回" id="closeSaveUpdate"/>  
 			<@ms.button class="btn btn-danger" id="saveOrUpdate" value="保存"/>  
 		 </@ms.modalButton>
	</@ms.modal>
	<!--编辑和新增字段模态框结束-->
	
	
		

	
	<!--编辑和新增字段模态框内容-->
	
	

	<script type="text/javascript">
		//进行自定义表单删除的函数
		function deleteField(fieldId){
			var URL="${base}/manager/diy/formField/"+fieldId+"/delete.do"
			$(this).request({url:URL,type:"json",method:"post",func:function(msg) {
				//回调处理方式
				if(msg.result) {
			    	$(".closeModal").click();
					alert("删除字段成功");
		    	} else {
					alert("删除字段失败");
			    	$(".closeModal").click();
		    	}
		    	location.reload();
			}});
			
		}
	
			$(function(){
				//自定义表单的表单验证
				$('.diyFormFrom').bootstrapValidator({
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh',
							autoFocus : true
						}
				});
			
				//点击保存时，进行自定义表单的保存
				$(".saveDiyForm").click(function(){
						var thisHtml  = $(this).text();
						var vobj = $(".diyFormFrom").data('bootstrapValidator').validate();
						if(vobj.isValid()){
							$.ajax({
								type: "post",
								dataType: "json",
							 	url:$(".diyFormFrom").attr("action"),
							  	data:$(".diyFormFrom").serialize(),
							  	beforeSend:function() {
				   					$(".saveDiyForm").html(thisHtml+"中...");
				   					$(".saveDiyForm").attr('disabled',true);
				   					$(".saveDiyForm").unbind("click");
				  			 	},success: function(msg){
				  			 		$(".saveDiyForm").html(thisHtml);
				  			 		$(".saveDiyForm").attr('disabled',false);
				  			 		$(".saveDiyForm").bind("click");
							     	if(msg){
							     		alert($.trim(thisHtml)+"成功");
							     	}
							     	
							     	location.href="${base}/manager/diy/form/"+msg.resultMsg+"/edit.do";
							     	
							   },error:function(){
					   				$(".saveDiyForm").attr('disabled',false);
					   				$(".saveDiyForm").html(thisHtml);
					   			}
							});
						}
				});	
				
				//判断表明是否存在相同
				$("input[name='diyFormTableName']").blur(function(){
					var diyFormTableName = $(this).val();
					if(diyFormTableName!=""){
						var URL="${base}/manager/diy/form/"+diyFormTableName+"/checkTableNameExist.do"
						$(this).request({url:URL,method:"post",data:diyFormTableName,func:function(msg) {
							var obj = jQuery.parseJSON(msg);
							if(obj.result){
						    	 alert("表名已存在，请重新输入");
						     	$("input[name='diyFormTableName']").val("");
							} 
						}});
					}
				});
				
				<#if diyForm?has_content>
					// 用于判断编辑时用户是否改变了字段名称的值
					var oldFielName =$("input[name='diyFormFieldFieldName']").val();
					$('#fieldFrom').bootstrapValidator({
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh',
							autoFocus : true
						}
					});	
						
					//获取字段列表信息
					function queryFieldList(diyFormId){
					$.ajax({
					   type: "post",
					   dataType: "json",
					   url: "${base}/manager/diy/formField/list.do",
					   data: "diyFormId=" + diyFormId,
					   success: function(msg){
					   		if(msg.fieldList.length != 0){
					    		$("tbody").html("");
					    		//获取字段列表信息
					    		for(var i=0; i<msg.fieldList.length; i++){	    					
			    					var fieldTypeC =  msg.fieldType[msg.fieldList[i].diyFormFieldType];
			    					$("tbody").append("<tr class='fieldList'><td class='text-center'>"+msg.fieldList[i].diyFormFieldId+"</td>"+		          	
									            "<td class='text-center'>"+msg.fieldList[i].diyFormFieldTipsName+"</td>"+
									            "<td class='text-center'>"+msg.fieldList[i].diyFormFieldFieldName+"</td>"+
									 			"<td class='text-center'>"+fieldTypeC+"</td>"+
									            "<td class='text-center'>"+
							                    "<a class='btn btn-xs tooltips delete deleteImg' data-toggle='tooltip' data-id='"+msg.fieldList[i].diyFormFieldId+"' data-original-title='删除'>"+
							                    "<i class='glyphicon glyphicon-trash'></i></a>"+
							                    "<a class='btn btn-xs tooltips editform' data-toggle='tooltip' data-id='"+msg.fieldList[i].diyFormFieldId+"' data-original-title='编辑'>"+
						                     	"<i class='glyphicon glyphicon-pencil'></i></a></td></tr>");
					    		}
					    	}
					    	$("#fieldTypeInfo").html("");
					    	//动态获取字段属性			    	
					    	if(msg.fieldType != null){
					    		for(var k=1; k<=msg.fieldNum; k++){
					    			$("#fieldTypeInfo").append("<div class='fieldRadio'><input type='radio' class='text-center' name='diyFormFieldType' value='"+k+"'>"+msg.fieldType[k]+"</div>");
					    		}
					    	}
					   }
					});
				}
			
					
					//点击新增字段时，弹出新增字段的弹框
					$("body").delegate("#addField","click",function(){
						$(".openModal").modal();//打开删除的模态框
							$("#fieldFrom input[type='text']").val("");
							$("#fieldFrom textarea").val("");
							$("input:radio[value='1']").attr("checked", true);
							$("#hideFieldId").html("");
							$("input[name='diyFormFieldFormId']").val("${diyForm.diyFormId}");
							var url = "${base}/manager/diy/formField/"+${diyForm.diyFormId}+"/save.do";
							$("#saveOrUpdate").html("保存");
							$("#fieldFrom").attr("action",url);
							$("#openModalTitle").text("新增字段");
							//openModal($("#fieldModel"),"新增字段");
						});
						//关闭模态框
						$("#closeSaveUpdate").click(function(){
							$(".openModal").modal("hide");
						});
					
						
					
					
					queryFieldList(${diyForm.diyFormId});
					//点击保存开始字段的保存
					$("body").delegate("#saveOrUpdate","click",function(){
							var fieldType = $("input[name='diyFormFieldType']:checked").val();
							var flag = true;
							// 当用户选择的是数字类型时,默认值只能为数字
							if(fieldType=="4"||fieldType =="5"){
								if((isNaN($("textarea[name='diyFormFieldDefault']").val()))){
									$($("textarea[name='diyFormFieldDefault']")).val("");
									flag = false;
									alert("字段类型为数字类型,默认值只能为数字")
								}
							}
							var vobj = $("#fieldFrom").data('bootstrapValidator').validate();
							var thisHtml = $(this).html();
							if(vobj.isValid()&&flag){
								$.ajax({
						   			type: "post",
						   			dataType: "json",
						   			url: $("#fieldFrom").attr("action"),
						   			data:$("#fieldFrom").serialize(),
						   				beforeSend:function() {
					   					$("#saveOrUpdate").html(thisHtml+"中...");
					   					$("#saveOrUpdate").attr('disabled',true);
					   					$("#saveOrUpdate").unbind("click");
					  			 	},success: function(msg){
						   				$("#saveOrUpdate").attr('disabled',false);
						   					if(msg.result){
						   						$("#saveOrUpdate").html(thisHtml);
						   						alert(thisHtml+"成功");
						   				}
						   				$("#saveOrUpdate").html(thisHtml);
						   				location.reload();
						   			},error:function(){
						   				$("#saveOrUpdate").attr('disabled',false);
						   				$("#saveOrUpdate").html(thisHtml);
						   			}
						   		});
							}
								
						});
					//点击保存开始字段的保存
					$("body").delegate(".editform","click",function(){
								$(".openModal").modal();//打开删除的模态框
								$("#fieldFrom input[type='text']").val("");
								$("#fieldFrom textarea").val("");
								$("input:radio[value='1']").attr("checked", true);
								//表单id
								$("input[name='diyFormFieldFormId']").val("${diyForm.diyFormId}");
								var url = "${base}/manager/diy/formField/update.do";
								$("#fieldFrom").attr("action",url);
								var diyFormFieldId = $(this).attr("data-id");
								$("#saveOrUpdate").html("更新");
								$("#hideFieldId").html("<input name='diyFormFieldId' type='hidden'/>");
								$("input[name='diyFormFieldId']").val(diyFormFieldId);
								
								var URL="${base}/manager/diy/formField/"+diyFormFieldId+"/edit.do"
								var fieldFrom = $("#fieldFrom").serialize();
								$(this).request({url:URL,method:"post",data:fieldFrom,func:function(msg) {
									$("input[name='diyFormFieldTipsName']").val(msg.diyFormfield.diyFormFieldTipsName);
				     				$("input[name='diyFormFieldFieldName']").val(msg.diyFormfield.diyFormFieldFieldName);
				     				$("textarea[name='diyFormFieldDefault']").val(msg.diyFormfield.diyFormFieldDefault);
				     				var fieldType = msg.diyFormfield.diyFormFieldType;
				     				oldFielName = msg.diyFormfield.diyFormFieldFieldName;
				     				$("[name='diyFormFieldType'][value="+msg.diyFormfield.diyFormFieldType+"]").attr("checked", true);
				     				$("[name='diyFormFieldIsNull'][value="+msg.diyFormfield.diyFormFieldIsNull+"]").attr("checked", true);
				     				$("#openModalTitle").text("更新字段");
					   				//openModal($("#fieldModel"),"更新字段");
								}});
						});
					//点击删除，弹出删除提示框
					$("body").delegate(".deleteImg","click",function(){
						var fieldId = $(this).attr("data-id");
						$(".deleteModal").modal();//打开删除的模态框
						$("#deleteButtonField").click(function(){
							deleteField(fieldId);
						});
					});
					//关闭模态框
					$("#closeDelete").click(function(){
						$(".deleteModal").modal("hide");
					});
				
					
					//前端判断同一个表单中是否存在相同的字段名
						$("input[name='diyFormFieldFieldName']").blur(function(){
							var diyFormFieldFieldName = $(this).val();
							var diyFormFieldFormId = $("input[name='diyFormFieldFormId']").val();
							if(oldFielName!=$("input[name='diyFormFieldFieldName']").val() && $("input[name='diyFormFieldFieldName']").val()!=""){
								var URL="${base}/manager/diy/formField/"+diyFormFieldFieldName+"/checkFieldNameExist.do"
								$(this).request({url:URL,method:"post",data:diyFormFieldFormId,func:function(msg) {
									if(msg){
							     		alert("字段名已存在，请再次输入");
							     		$("input[name='diyFormFieldFieldName']").val("");
							     		
							     	}
								}});
							}
						});
			
				</#if>
			});

//最新js写法结束
	
	
	</script>

</body>
</html>
