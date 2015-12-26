<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/>
<style>
	.container{margin:0;padding:0;width:auto}
	 hr{margin-top:9px;margin-bottom:9px;padding:0;}
	.ms-button-group{padding:0px 0px 8px 0px}
	.row {margin-left:0;margin-right:0}
	.form-horizontal .form-group{margin-left:0;margin-right:0}
	.form-group{overflow: hidden;}
	
	.padding-zero{padding:0;}
	/*链接样式*/
	.link-style a:hover{color:#000;}
	.link-style a:visited{color:#000;}
	.operate a:visited{color:#428BCA;}
	.form-inline .form-group {display: inline-block;margin-bottom: 0;vertical-align: middle;}
	.dedeteRight{width: 32%;margin: 0 auto;overflow: hidden;}
	
	.margin20{ margin-top:20px;}
	.marginleft70{ margin-left:-70px;}
	.has-error .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#A94442;}
	.has-success .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#3C763D;}
	.form-control{ padding-right:22px;} 
	.zhu{ height:30px; line-height:30px; color:#F00;}
	.fieldRadio{float:left;width:50%;height:25px;}
</style>
</head>
<body>
<@ms.content>
	<@ms.contentBody width="" >
	
			<!--标题和顶部更新按钮-->
			<#if contentModel?has_content>
				<@ms.contentNav title="更新内容模型">
					<@ms.panelNavFilter>
						<@ms.contentNavBack  onclick="location.href='${base}/manager/cms/contentModel/list.do'" value="返回内容模型列表"/>
					</@ms.panelNavFilter>
				</@ms.contentNav >
			<#else>
				<@ms.contentNav title="新增内容模型">
					<@ms.panelNavFilter>
						<@ms.contentNavBack   onclick="location.href='${base}/manager/cms/contentModel/list.do'" value="返回内容模型列表"/>
					</@ms.panelNavFilter>
				</@ms.contentNav >
			</#if>	
		<@ms.contentPanel>
			<div class="form-group">
				<label class="col-md-2 control-label col-xs-2 "><h4><strong>内容模型表单信息</strong></h4></label>
			</div>
			
				<@ms.row>
					<@ms.col size="12">
					<#if contentModel?has_content>
						<@ms.form  name="saveForm" class="contentModelFrom" action="${base}/manager/diy/form/update.do">
							<!--提示文字-->
							<@ms.col  style="text-align: right; width:15%;">内容模型名称</@ms.col>
							<@ms.col size="4">
								<@ms.text title="名称" size="3" value="${contentModel.cmTipsName?default('')}" placeholder="请输入自定义内容模型名称" name="cmTipsName" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"13","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-13个字符"} />
							</@ms.col>
							<@ms.col size="12"></@ms.col>
							<!--表单名称-->
							<@ms.col  style="text-align: right; width:15%;">内容模型表名</@ms.col>
							<@ms.col size="8">
								<@ms.text title="名称" size="3" value="${contentModel.cmTableName?default('')}"  placeholder="表名只能为英文字符或下划线或数字" name="cmTableName" readonly="true" style="width:30%;"/>
								<span style=" height:30px; line-height:30px; color:#F00;font-weight:bold;">注：表单名称一旦保存不能再更改</span>
							</@ms.col>
							<@ms.hidden name="cmId" value="${contentModel.cmId}"  />
							<@ms.col size="12"></@ms.col>
							<@ms.col style="width:15%;"></@ms.col>
							<@ms.col size="4">
			    				<@ms.button class="btn btn-primary updateContentModel" value="更新表单" />
			    			</@ms.col>
		    			</@ms.form>
					<#else>
						<@ms.form  name="saveForm" class="contentModelFrom" action="${base}/manager/diy/form/save.do">
							<!--提示文字-->
							<@ms.col  style="text-align: right; width:15%;">内容模型名称</@ms.col>
							<@ms.col size="4">
								<@ms.text title="名称" size="3"  placeholder="请输入内容模型名称" name="cmTipsName" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符"}/>
							</@ms.col>
							<@ms.col size="12"></@ms.col>
							<!--表单名称-->
							<@ms.col  style="text-align: right; width:15%;">内容模型表名</@ms.col>
							<@ms.col size="9">
								<@ms.text  title="名称" size="3"   placeholder="表名只能为英文字符或下划线或数字"  name="cmTableName"  validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"13","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-13个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z0-9_]+$',"data-bv-regexp-message":"表单名称只能由英文字母，数字，下划线组成!"} style="width:30%;"/>
								<span style=" height:30px; line-height:30px; color:#F00;font-weight:bold;">注：表单名称一旦保存不能再更改</span>
							</@ms.col>
							<@ms.col size="12"></@ms.col>
							<@ms.col style="width:15%;"></@ms.col>
							<@ms.col size="4">
			    				<@ms.button class="btn btn-primary saveContentModel" value="保存表单" />
			    			</@ms.col>
			    		</@ms.form>
					</#if>
					</@ms.col>
				</@ms.row>
			
			<#if contentModel?has_content>
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
 			<@ms.button class="btn btn-danger" id="deleteButtonField" value="删除"/>  
 		 </@ms.modalButton>
	</@ms.modal>
	<!--删除的模态框结束-->

	
	<!--编辑和新增字段模态框开始-->
	<@ms.modal modalName="openModal" title="" style="min-width:555px;">
		 <@ms.modalBody>
		
			<div class="row" id="fieldModel">
		<form action="" class="form-horizontal" role="form" id="fieldFrom">
			<@ms.row>
				<!--字段提示文字-->
				<@ms.col size="4" style="text-align: right;">字段提示文字</@ms.col>
				<@ms.col size="7">
					<@ms.text title="名称"  size="3"  value="" placeholder="请输入提示文字" name="fieldTipsName" validation={"required":"true", "data-bv-notempty-message":"不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"100","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-100个字符"} />
				</@ms.col>
				
				<!--字段名称-->
				<@ms.col size="4" style="text-align: right;">字段名称</@ms.col>
				<@ms.col size="7">
					<@ms.text title="名称" size="3" value=""  placeholder="请输入字段名称" name="fieldFieldName"  validation={"required":"true", "data-bv-notempty-message":"不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"100","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-100个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z0-9]+$',"data-bv-regexp-message":"字段名只能为字符!"}  />
				</@ms.col>
				
				<!--数据类型-->
				<@ms.hidden name="fieldCmid" value="${cmId}"  />
				<@ms.col size="4" style="text-align: right;">数据类型</@ms.col>
				<@ms.col size="7">
					<div styel="display:none;" id="hideFieldId"></div>
					<div  id="fieldTypeInfo"></div>
				</@ms.col>
				<@ms.col size="12" style="height: 8px;"></@ms.col>
				<!--是否是必填字段-->
				<@ms.col size="4" style="text-align: right;">是否是必填字段</@ms.col>
				<@ms.col size="7">
					<div class='fieldRadio'>
						<input value='0' name="fieldIsNull" type="radio"/>必填
					</div>
					<div class='fieldRadio'>
						<input value='1' type="radio" name="fieldIsNull"/>可选
					</div>
				</@ms.col>
				<@ms.col size="12" style="height: 8px;"></@ms.col>
				<!--是否是搜索-->
				<@ms.col size="4" style="text-align: right;">是否是搜索</@ms.col>
				<@ms.col size="7">
					<div class='fieldRadio'>
						<input value='1' name="fieldIsSearch" type="radio"/>是
					</div>
					<div class='fieldRadio'>
						<input value='0' type="radio" name="fieldIsSearch"/>否
					</div>
				</@ms.col>
				<@ms.col size="12" style="height: 8px;"></@ms.col>
				<!--字段默认值-->
				<@ms.col size="4" style="text-align: right;">字段默认值</@ms.col>
				<@ms.col size="7">
					<@ms.textarea name="fieldDefault"   wrap="Soft" rows="5"  size=""  value=""  placeholder="下拉框,多选框等存在多个默认值的必须使用英文逗号隔开"/>
				</@ms.col>
				
				
			</@ms.row>
		
			
		
		</form>
	</div>
	     </@ms.modalBody>
	     <@ms.modalButton>
    		
 			<@ms.button class="btn btn-primary" id="saveOrUpdate" value="保存"/>  
 		 </@ms.modalButton>
	</@ms.modal>
	<!--编辑和新增字段模态框结束-->
	
	<script type="text/javascript">
		//表单验证绑定函数
		function bindValidate(obj){
			bootstrapValidator = obj.bootstrapValidator({
				feedbackIcons: {
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	                
	            },
		       	fields: {
		            fieldTipsName: {
		                validators: {
		                    notEmpty: { message: '字段提示文字不能为空'},
		                    stringLength: {min: 1,max: 30,message: '字段提示文字长度介于1-30个字符'}
		                }
		            },
		            fieldFieldName: {
		                validators: {
		                    notEmpty: {message: '字段名称不能为空'},
		                    stringLength: {min: 1,max: 13,message: '字段长度介于1-13个字符'},
		                    regexp: {regexp: /^[a-zA-Z0-9]+$/,message: '字段名只能由英文字母，数字组成'}
		                }
		            },
		        }
		     });
		}
	
	
	
		<#if flag == false>
		//字段列表
		function queryFieldList(){
			$.ajax({
			   type: "post",
			   dataType: "json",
			   url:  base+"/manager/cms/field/list.do",
			   data: "cmId=" + ${cmId},
			   success: function(msg){
			   		if(msg.fieldList.length != 0){
			    		$("tbody").html("");
			    		//获取字段列表信息
			    		for(var i=0; i<msg.fieldList.length; i++){	    					
	    					var fieldTypeC =  msg.fieldType[msg.fieldList[i].fieldType];
	    					$("tbody").append("<tr class='fieldList'><td class='text-center'>"+msg.fieldList[i].fieldId+"</td>"+		          	
							            "<td class='text-center'>"+msg.fieldList[i].fieldTipsName+"</td>"+
							            "<td class='text-center'>"+msg.fieldList[i].fieldFieldName+"</td>"+
							 			"<td class='text-center'>"+fieldTypeC+"</td>"+
							            "<td class='text-center'>"+
					                    "<a class='btn btn-xs tooltips delete' data-toggle='tooltip' data-id='"+msg.fieldList[i].fieldId+"' data-original-title='删除'>"+
					                    "<i class='glyphicon glyphicon-trash'></i></a>"+
					                    "<a class='btn btn-xs tooltips edit' data-toggle='tooltip' data-id='"+msg.fieldList[i].fieldId+"' data-original-title='编辑'>"+
				                     	"<i class='glyphicon glyphicon-pencil'></i></a></td></tr>");
			    		}
			    	}
			    	//动态获取字段属性			    	
			    	if(msg.fieldType != null){
			    		for(var k=1; k<=msg.fieldNum; k++){
			    			$("#fieldTypeInfo").append("<div class='fieldRadio'><input type='radio' class='text-center' name='fieldType' value='"+k+"'>"+msg.fieldType[k]+"</div>");
			    		}
			    	}
			   }
			});
		}
		</#if>
		//删除字段
		function deleteField(fieldId){
			var URL="${base}/manager/cms/field/"+fieldId+"/delete.do"
			$(this).request({url:URL,method:"post",type:"json",func:function(msg) {
				if(msg != 0) {
			    	$(".closeModal").click();
					alert("删除字段成功");
		    		if($("tbody tr").length==0 && msg != 1){
		    			location.href = base+"/manager/cms/contentModel/add.do";
					}else{
						location.href = base+"/manager/cms/contentModel/${cmId}/edit.do";
					}
		    	} else {
					alert("删除字段失败");
			    	$(".closeModal").click();
		    	}
			}});
		}
		
		// 点击新增字段时弹出新增字段弹出框
		function saveField(){
			bindValidate($("#fieldFrom"));
			$("#saveOrUpdate").html("保存");
			$("#fieldFrom input:text").val("");
			$("input:radio[value='1']").attr("checked", true);
			var cmTableName=$("input[name='cmTableName']").val();
			$("#fieldFrom").attr("action","${base}/manager/cms/field/"+cmTableName+"/save.do");
			$("#openModalTitle").text("新增字段");
		}
		
		// 用于判断编辑时用户是否改变了字段名称的值
		var oldFielName =$("input[name='fieldFieldName']").val();
		$(function(){
		
		
			//对内容模型的表单进行验证
			bindValidate($(".contentModelFrom"));
			//更新内容模型函数
			function updateContentModel(){
				if(bootstrapValidator.data('bootstrapValidator').validate().isValid()){
					var URL="${base}/manager/cms/contentModel/update.do"
					var contentModel = $(".contentModelFrom").serialize();
					$(this).request({url:URL,method:"post",type:"json",data:contentModel,func:function(msg) {
						if(msg.result){
							alert("更新成功");
						}else {
							alert("更新失败");
								
						}
					}});
				}
			}
			//点击更新表单按钮
		 	$(".updateContentModel").on("click",function(){
				updateContentModel();
		 	});
			//字段列表查询
			<#if flag == false>
			
	
			
			//点击新增字段按钮,弹出新增字段的模态框
			$("#addField").on("click",function(){
				$(".openModal").modal();//打开删除的模态框
				saveField();
			});
			//关闭模态框
			$("#closeSaveUpdate").click(function(){
				$(".openModal").modal("hide");
			});
			
			//点击删除，弹出删除提示框
			$("tbody").delegate(".delete","click",function(){
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
			$("input[name='fieldFieldName']").blur(function(){
				var fieldFieldName = $(this).val();
				var fieldCmId = $("input[name='fieldCmid']").val();
				if(oldFielName!=$("input[name='fieldFieldName']").val() && $("input[name='fieldFieldName']").val()!=""){
					var URL="${base}/manager/cms/field/"+fieldFieldName+"/checkFieldNameExist.do"
					$(this).request({url:URL,method:"post",type:"json",data:fieldCmId,func:function(msg) {
						if(msg){
				     		alert("字段名已存在，请再次输入");
				     		$("input[name='fieldFieldName']").val("");
				     	} 
					}});
				}
			});
			
			
			
			// 点击模态框保存按钮时进行ajax请求保存数据
			
			$(".openModal").delegate("#saveOrUpdate", "click", function(){
				var fieldType = $("input[name='fieldType']:checked").val();
				var flag = true;
				// 当用户选择的是数字类型时,默认值只能为数字
				if(fieldType=="6"||fieldType =="7"){
					if((isNaN($("textarea[name='fieldDefault']").val()))){
						$($("textarea[name='fieldDefault']")).val("");
						flag = false;
						alert("字段类型为数字类型,默认值只能为数字")
					}
				}
				bindValidate($("#fieldFrom"));
				if(bootstrapValidator.data('bootstrapValidator').validate().isValid()&&flag){
					
					$.ajax({
						type: "post",
						url:$("#fieldFrom").attr("action"),
						dataType:"json",
						data: $("#fieldFrom").serialize(),
						success: function(msg){
							var fieldCmid = $("input[name='fieldCmid']").val();
							if(msg.result){
								if($("#saveOrUpdate").html()=="更新"){
									alert("更新成功");
									location.href="${base}/manager/cms/contentModel/"+fieldCmid+"/edit.do";
								}else{
									alert("保存成功");
									location.href="${base}/manager/cms/contentModel/"+fieldCmid+"/edit.do";
								}
								
							}else{
								alert(msg.resultMsg);
							}
							$("#saveOrUpdate").attr('disabled',true);
						}
					});
				}
			});
			
			// 点击编辑按钮弹出更新模态框
			$("tbody").delegate(".edit","click",function(){
				$(".openModal").modal();//打开模态框
				$("#saveOrUpdate").attr('disabled',false);
				var fieleId = $(this).attr("data-id");
				bindValidate($("#fieldFrom"));
				$("#hideFieldId").html("<input name='fieldId'type='hidden'/>");
				$("input[name='fieldId']").val(fieleId);
				$("#saveOrUpdate").html("更新");
				$("#fieldFrom").attr("action","${base}/manager/cms/field/update.do");
				
				var URL="${base}/manager/cms/field/"+fieleId+"/edit.do"
				$(this).request({url:URL,method:"post",type:"json",func:function(msg) {
					$("input[name='fieldTipsName']").val(msg.field.fieldTipsName);
			     	$("input[name='fieldFieldName']").val(msg.field.fieldFieldName);
			     	$("textarea[name='fieldDefault']").val(msg.field.fieldDefault);
			     	var fieldType = msg.field.fieldType;
			     	
			     	oldFielName = msg.field.fieldFieldName;
			     	$("[name='fieldType'][value="+fieldType+"]").attr("checked", true);
			     	$("[name='fieldIsSearch'][value="+msg.field.fieldIsSearch+"]").attr("checked", true);
			     	$("[name='fieldIsNull'][value="+msg.field.fieldIsNull+"]").attr("checked", true);
			     	
				}});
				
				$("#openModalTitle").text("更新字段");
			});
			//关闭模态框
			$("#closeSaveUpdate").click(function(){
				$(".openModal").modal("hide");
			});
			queryFieldList();
		<#else>
		
			
			//新增内容模型函数
			function saveContentModel(){
				if(bootstrapValidator.data('bootstrapValidator').validate().isValid()){
					$.ajax({
						type: "post",
						url:"${base}/manager/cms/contentModel/save.do",
						dataType:"json",
						data: $(".contentModelFrom").serialize(),
						beforeSend:function() {
			   				$(".saveContentModel").html("正在保存...");
			   				$(".saveContentModel").attr("disabled","disabled");
			   				$(".saveContentModel").unbind("click");
			  			 },
						success: function(msg){
							if(msg.result){
								$("input[name='cmTableName']").attr("readonly","readonly");
								$("input[name='fieldCmid']").val(msg.resultMsg);
								alert("表单信息保存成功");
								$(".saveContentModel").html("更新表单");
								$(".saveContentModel").removeAttr("disabled");
							 	$(".saveContentModel").bind("click",function(){
							 		updateContentModel();
							 	});	
								location.href="${base}/manager/cms/contentModel/"+msg.resultMsg+"/edit.do";
							}else{
								alert(msg.resultMsg);
							}
						}
					});
				}
			}
		
			//点击保存表单按钮
			$(".saveContentModel").bind("click",function(){
				saveContentModel();
			});
			
			
			//对内容模型的表单进行验证
			bindValidate($(".contentModelFrom"));
			// 前端验证内容模型的表名是否相同
			$("input[name='cmTableName']").blur(function(){
				var cmTableName= $(this).val();
				if(cmTableName!=""){
					var URL="${base}/manager/cms/contentModel/"+cmTableName+"/checkcmTableNameExist.do"
					$(this).request({url:URL,method:"post",type:"json",func:function(msg) {
						if(msg){
						     alert("表名已存在，请重新输入");
						     $("input[name='cmTableName']").val("");
						} 
					}});
				}
			});
		</#if>
		});
	</script>

</body>
</html>
