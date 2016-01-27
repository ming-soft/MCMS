<@ms.html5>
	<@ms.nav title="自定义表单" back=true>
		<@ms.saveButton id="saveDiyForm" />
	</@ms.nav>
	<@ms.panel>	
		<#if diyForm?has_content>
			<@ms.form name="diyForm" isvalidation=true  action="${base}/manager/diy/form/update.do">		
				<!--自定义表单名称-->
				<@ms.text title="名称" label="自定义表单名称" width="300" size="3" value="${diyForm.diyFormTipsName?default('')}" placeholder="请输入自定义表单名称" name="diyFormTipsName" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符"} />
				<!--自定义表单表名-->
				<@ms.text title="名称" label="自定义表单表名" width="300" size="3" help="注：自定义表单表名一旦保存不能再更改" value="${diyForm.diyFormTableName?split('_')[1]}"  placeholder="表名只能为英文字符" name="diyFormTableName" readonly="true" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z]+$',"data-bv-regexp-message":"表单名称只能由英文字母组成!"}/>
			</@ms.form>
		<#else>
			<@ms.form  name="diyForm" isvalidation=true action="${base}/manager/diy/form/save.do">
				<!--自定义表单名称-->
				<@ms.text title="名称" label="自定义表单名称" width="300" size="3" value="" placeholder="请输入自定义表单名称" name="diyFormTipsName" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符"} />
				<!--自定义表单表名-->
				<@ms.text title="名称" label="自定义表单表名" width="300" name="diyFormTableName" size="3" value="" help="注：自定义表单表名一旦保存不能再更改" placeholder="表名只能为英文字符" name="diyFormTableName" validation={"required":"true", "data-bv-notempty-message":"名称不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"20","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-20个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z]+$',"data-bv-regexp-message":"表单名称只能由英文字母组成!"}/>
    		</@ms.form>
		</#if>
		<#if diyForm?has_content>
			<h4><strong>字段信息</strong></h4>
			<!--新增按钮-->
			<@ms.panelNav>
				<@ms.panelNavBtnGroup>
					<@ms.addButton  id="addField"/>
				</@ms.panelNavBtnGroup>
			</@ms.panelNav>
			<@ms.table head=['提示文字,200','字段名,100',"类型,90",'默认值,300',"操作"]>
			</@ms.table>			
		</#if>	
	</@ms.panel>
</@ms.html5>  
<!--删除的模态框开始-->
<@ms.modal id="deleteModal" title="删除字段">
	 <@ms.modalBody>
		确定删除该字段吗？
     </@ms.modalBody>
     <@ms.modalButton> 
		<@ms.button class="btn btn-danger" id="deleteButtonField" value="删除"/>  
	 </@ms.modalButton>
</@ms.modal>
<!--删除的模态框结束-->

<!--编辑和新增字段模态框开始-->
<@ms.modal id="openModal" title="新增字段" resetFrom=true style="width:45%">
	<@ms.modalBody height="500">
		<@ms.form isvalidation=true name="fieldForm" action="">
			<@ms.text title="名称" label="字段提示文字"  width="200" size="3"  value="" placeholder="请输入提示文字" name="diyFormFieldTipsName" validation={"required":"true", "data-bv-notempty-message":"不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"100","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-100个字符"} />
			<@ms.text title="名称" label="字段名称"  width="200" size="3" value=""  placeholder="请输入字段名称" name="diyFormFieldFieldName"  validation={"required":"true", "data-bv-notempty-message":"不能为空","data-bv-stringlength":"true","data-bv-stringlength-max":"100","data-bv-stringlength-min":"1","data-bv-stringlength-message":"长度介于1-100个字符","data-bv-regexp":"true","data-bv-regexp-regexp":'^[A-Za-z]+$',"data-bv-regexp-message":"字段名只能为字符!"}  />
			<@ms.formRow label="数据类型"  width="300">
            	<div id="fieldTypeInfo" class="col-sm-10 ms-from-group-input ms-form-input">
				</div>
            </@ms.formRow>
            <@ms.radio name="diyFormFieldIsNull"  label="必填字段"  width="200" list=[{"id":0,"value":"必填"},{"id":1,"value":"可选"}] value="1" listKey="id" listValue="value"/>
            <@ms.textarea name="diyFormFieldDefault" help="日期与文本类型无效" label="字段默认值"   wrap="Soft" rows="5"  size=""  value=""  placeholder="下拉框,多选框等存在多个默认值的必须使用英文逗号隔开"/>
			<@ms.hidden name="diyFormFieldFormId" value="" />
			<div id="hideFieldId" style="display:none;"></div>
		</@ms.form>
    </@ms.modalBody>
	<@ms.modalButton>
		<@ms.saveButton id="saveOrUpdate" />  
	</@ms.modalButton>
</@ms.modal>
<!--编辑和新增字段模态框结束-->
<script type="text/javascript">
	//进行自定义表单删除的函数
	function deleteField(fieldId){
		var URL="${base}/manager/diy/formField/"+fieldId+"/delete.do";
		$("#deleteButtonField").text("删除中");
		$("#deleteButtonField").attr("disabled",true);
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
		
		//保存表单
		$("#saveDiyForm").click(function(){
				var URL="${base}/manager/diy/form/"+$("input[name='diyFormTableName']").val()+"/checkTableNameExist.do"
				$(this).request({url:URL,method:"post",func:function(msg) {
					var obj = jQuery.parseJSON(msg);
					if(obj.result){
				    	alert("表名已存在，请重新输入");
				     	$("input[name='diyFormTableName']").val("");
					} else {
						var diyForm = $("#diyForm");
						var thisHtml  = $(this).text();
						var vobj = diyForm.data('bootstrapValidator').validate();
						if(vobj.isValid()){
							$.ajax({
								type: "post",
								dataType: "json",
							 	url:diyForm.attr("action"),
							  	data:diyForm.serialize(),
							  	beforeSend:function() {
				   					$("#saveDiyForm").attr('disabled',true);
				  			 	},success: function(msg){
							     	if(msg){
							     		alert($.trim(thisHtml)+"成功");
							     	}
							     	location.href="${base}/manager/diy/form/"+msg.resultMsg+"/edit.do";							     	
							   },error:function(){
					   				$("#saveDiyForm").attr('disabled',false);
					   			}
							});
						}					
					}
				}});

		});	
		

		
		<#if diyForm?has_content>
			// 用于判断编辑时用户是否改变了字段名称的值
			var oldFielName =$("input[name='diyFormFieldFieldName']").val();					
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
		    					$("tbody").append("<tr class='fieldList'><td>"+msg.fieldList[i].diyFormFieldTipsName+"</td>"+
								            "<td>"+msg.fieldList[i].diyFormFieldFieldName+"</td>"+
								 			"<td>"+fieldTypeC+"</td>"+
								 			"<td>"+msg.fieldList[i].diyFormFieldDefault+"</td>"+
								            "<td>"+
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
				    			$("#fieldTypeInfo").append("<div><label><input type='radio' name='diyFormFieldType' value='"+k+"'>"+msg.fieldType[k]+"</label></div>");
				    		}
				    	}
			  		}
				});
			}
		
				
			//点击新增字段时，弹出新增字段的弹框
			$("body").delegate("#addField","click",function(){
				//打开模态框
				$(".openModal").modal();
				//情空模态框值
				$("#fieldForm input[type='text']").val("");
				$("#fieldForm textarea").val("");
				$("input:radio[value='1']").attr("checked", true);
				$("#hideFieldId").html("");
				//加载相关数据
				$("input[name='diyFormFieldFormId']").val("${diyForm.diyFormId}");
				var url = "${base}/manager/diy/formField/"+${diyForm.diyFormId}+"/save.do";
				$("#saveOrUpdate").html("保存");
				$("#fieldForm").attr("action",url);
				$("#openModalTitle").text("新增字段");
			});
			//查询字段列表				
			queryFieldList(${diyForm.diyFormId});
			//点击保存开始字段的保存
			$("body").delegate("#saveOrUpdate","click",function(){
			
				var diyFormFieldFieldName = $("#fieldForm input[name='diyFormFieldFieldName']").val();
				var diyFormFieldFormId = $("input[name='diyFormFieldFormId']").val();
				if($("#fieldForm").data('bootstrapValidator').validate().isValid()){
					var URL="${base}/manager/diy/formField/"+diyFormFieldFieldName+"/checkFieldNameExist.do"
					$(this).request({url:URL,method:"post",data:diyFormFieldFormId,func:function(msg) {
						if(msg && oldFielName!=diyFormFieldFieldName){
				     		alert("字段名已存在，请再次输入");
				     		$("input[name='diyFormFieldFieldName']").val("");
				     	} else {
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
								var vobj = $("#fieldForm").data('bootstrapValidator').validate();
								var thisHtml = $("#saveOrUpdate").html();
								if(vobj.isValid() && flag){
									$.ajax({
							   			type: "post",
							   			dataType: "json",
							   			url: $("#fieldForm").attr("action"),
							   			data:$("#fieldForm").serialize(),
						   				beforeSend:function() {
						   					$("#saveOrUpdate").html(thisHtml+"中...");
						   					$("#saveOrUpdate").attr('disabled',true);
						  			 	},success: function(msg){
						   					if(msg.result){
						   						alert(thisHtml+"成功");
								   				location.reload();
							   				} else {
							   					alert(msg.resultMsg);
							   					$("#saveOrUpdate").attr('disabled',false);
							   					$("#saveOrUpdate").html(thisHtml);
							   				}
							   			},error:function(){
							   				$("#saveOrUpdate").attr('disabled',false);
							   				$("#saveOrUpdate").html(thisHtml);
							   			}
							   		});
								}				     	
				     	}
					}});
				}
							
			});
			//打开编辑模态框
			$("body").delegate(".editform","click",function(){
				//打开编辑模态框
				$(".openModal").modal();
				//情空模态框的值
				$("#fieldForm input[type='text']").val("");
				$("#fieldForm textarea").val("");
				$("input:radio[value='1']").attr("checked", true);
				//表单id
				$("input[name='diyFormFieldFormId']").val("${diyForm.diyFormId}");
				//表单字段更新地址
				var url = "${base}/manager/diy/formField/update.do";
				$("#fieldForm").attr("action",url);
				//表单字段ID
				var diyFormFieldId = $(this).attr("data-id");
				$("#saveOrUpdate").html("更新");
				$("#hideFieldId").html("<input name='diyFormFieldId' type='hidden'/>");
				$("input[name='diyFormFieldId']").val(diyFormFieldId);
				//查询字段对应信息的地址
				var URL="${base}/manager/diy/formField/"+diyFormFieldId+"/edit.do"
				var fieldForm = $("#fieldForm").serialize();
				$(this).request({url:URL,method:"post",data:fieldForm,func:function(msg) {
					$("input[name='diyFormFieldTipsName']").val(msg.diyFormfield.diyFormFieldTipsName);
     				$("input[name='diyFormFieldFieldName']").val(msg.diyFormfield.diyFormFieldFieldName);
     				$("textarea[name='diyFormFieldDefault']").val(msg.diyFormfield.diyFormFieldDefault);
     				var fieldType = msg.diyFormfield.diyFormFieldType;
     				oldFielName = msg.diyFormfield.diyFormFieldFieldName;
     				$("[name='diyFormFieldType'][value="+msg.diyFormfield.diyFormFieldType+"]").attr("checked", true);
     				$("[name='diyFormFieldIsNull'][value="+msg.diyFormfield.diyFormFieldIsNull+"]").attr("checked", true);
     				$("#openModalTitle").text("更新字段");
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
								
		</#if>
	});
</script>