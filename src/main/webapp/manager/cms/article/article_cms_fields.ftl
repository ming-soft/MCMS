<#--自定义内容模型字段-->
<#--field:字段实体-->
<script type="text/javascript" src="${base}/jquery/moment.js"></script>
<script type="text/javascript" src="${base}/jquery/daterangepicker.js"></script>
<style>

.margin10{margin-bottom:15px;}
</style>
<#include "/manager/include/macro.ftl"/>
<#macro field type name filedName value defaultValue isnull>
		
	   
	<#--根据filed实体的类别来显示项目的控件-->
		<#switch type>
			<#case "1">
				
				<#if isnull="0">
					<#assign  validationType={"required":"true", "data-bv-notempty-message":"必填"}>
				</#if>
				<#if value!="">
					<@ms.text name="${filedName}"  style="width: 15%;"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${value}" labelStyle="width:15%" style="width:30%" validation="${validationType?default('')}"/>
				<#else>
					<@ms.text name="${filedName}"  style="width: 15%;"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${defaultValue}" labelStyle="width:15%" style="width:30%"/>
				</#if>
				
				
			<#break>
			<#case "2">
				
				
				<#if value!="">
					<@ms.textarea name="${filedName}" label="${name}"  wrap="Soft" rows="4"  size=""  value="${value}" placeholder="请输入${name}" labelStyle="width:15%" style="width:60%"/>
				<#else>
					<@ms.textarea name="${filedName}" label="${name}"  wrap="Soft" rows="4"  size=""  value="${defaultValue}" placeholder="请输入${name}" labelStyle="width:15%" style="width:60%"/>
				</#if>
			<#break>
			<#case "3">
				<@ms.editor name="${filedName}" label="${filedName}"content="${value}" labelStyle="width:15%" width="688px;"/>			
				 
			<#break>
			<#case "4">
				<#if value!="">
					<@ms.text name="${filedName}"  style="width: 15%;"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${value}" labelStyle="width:15%" style="width:30%"/>
				<#else>
					<@ms.text name="${filedName}"  style="width: 15%;"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${defaultValue}" labelStyle="width:15%" style="width:30%"/>
				</#if>
				
				<script>
					//判断用户输入的是否为数字
					$("input[name='${filedName}']").blur(function(){
						if((isNaN($(this).val()))){
							alert("${name}"+"只能输入数字");
							$(this).val("");
						}
					});
				</script>
				
			<#break>
			<#case "5">
				<#if value!="">
					<@ms.text name="${filedName}"  style="width: 15%;"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${value}" labelStyle="width:15%" style="width:30%"/>
				<#else>
					<@ms.text name="${filedName}"  style="width: 15%;"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${defaultValue}" labelStyle="width:15%" style="width:30%"/>
				</#if>
				
				<script>
					//判断用户输入的是否为数字
					$("input[name='${filedName}']").blur(function(){
						if((isNaN($(this).val()))){
							alert("${name}"+"只能输入数字");
							$(this).val("");
						}
					});
					
				</script>
				
			<#break>
			<#case "6">
					<div class="form-group">
						<label for="${filedName}" class="control-label" style="width:15%;">${name}:</label>    
						<div class="input-prepend input-group ms-form-control"  style='height:auto'>
								<span class="add-on input-group-addon">
									<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
								</span>
								<input type="text" style="width:132px" name="${filedName}" id="birthday" class="form-control" value="<#if value!="">${value}<#else>${defaultValue}</#if>" />
						</div>
					</div>
				<script>
					$(function(){
						// 获取系统当前时间
						var date=new Date()
						var time = date.getFullYear()+"-";
						if(date.getMonth()+1<10){
							time = time +"0" +(date.getMonth()+1)+"-";
						}else{
							time = time + (date.getMonth()+1)+"-";
						}
						if(date.getDate()+1<10){
							time = time +"0" +date.getDate();
						}else{
							time = time +date.getDate();
						}
						$("#birthday").val(time);
						// 应用日历
						$('#birthday').daterangepicker({
								singleDatePicker: true
						},
						function(start, end, label) {
							console.log(start.toISOString(), end.toISOString(), label);
						});
					});
				</script>
			<#break>
			<#case "7">
					<div class="form-group " >
					
						
							<label for="${filedName}" class="control-label" style="width:15%">${name}</label>    
							<div class='ms-form-control' style='height:auto'>
								<@uploadImg path="upload/article/${appid}/" inputName="${filedName}" size="30" filetype="" msg="提示：可以上传多张图片"  maxSize="10" imgs="${value?default('')}" />
							</div>
						
					</div>
			<#break>
			
			<#case "8">
				<div class="form-group " >
							<label for="${filedName}" class="control-label" style="width:15%">${name}</label>    
							<div class='ms-form-control' style='height:auto'>
								<@uploadFile path="upload/article/${appid}/" inputName="${filedName}" size="1" filetype="*" msg="建议上传5M以下的文件"  maxSize="5" callBack="test" isRename="false"/>
							</div>
				</div>
				<script>
				 function test(e){
            		isSuccess = true;
					alert("文件上传成功 ");
	   			}
	   			</script>
	   			
			<#break>
			
			<#case "9">
				<div class="form-group">
						<label for="${filedName}" class="control-label" style="width:15%">${name}</label>
						<div class='ms-form-control' style='height:auto'>  
						 <select name="${filedName}" style="width:20%;"></select>
						</div>
				</div>
					
				<script>
						var dselect= new Array();
						dselect ="${defaultValue}".split(",");		
						for(var i = 0;i<dselect.length;i++){
							var j = i+1;
							if(dselect[i]!=""){
								$("select[name='${filedName}']").append("<option selected value="+(i+1)+">"+dselect[i]+"</option>");
							}
						}
						var checkValue="${value}";
						$("select[name='${filedName}']").find("option[value="+checkValue+"]").attr("selected",true);
				</script>
			<#break>
			<#case "10">
				<div class="form-group" id="${filedName}">
					
					<label for="${filedName}" class="control-label" style="float:left;width:15%">${name}</label>    
							
					
				</div>
				<script>
					var dselect= new Array();
					dselect ="${defaultValue}".split(",");
						for(var i = 0;i<dselect.length;i++){
							if(dselect[i]!=""){
								var id ="#"+ "${filedName}";
								$(id).append("<div class='ms-form-control' style='height:auto;width:9%;'><input type='radio' name='${filedName}' value="+(i+1)+" />"+dselect[i]+"</div>");
							}
						}
					 $("input[value='${value}']").attr("checked","checked");
				</script>
				
			<#break>
			<#case "11">
				<div class="form-group"  id="${filedName}">
					<label for="${filedName}" class="control-label" style="float:left;width:15%">${name}</label>    
				</div>
				<script>
					$(function(){
						var dselect= new Array();
						dselect ="${defaultValue}".split(",");
						for(var i = 0;i<dselect.length;i++){
							if(dselect[i]!=""){
								var id ="#"+ "${filedName}";
								$(id).append(" <div class='ms-form-control' style='height:auto;width:9%;'><input type='checkBox' name='${filedName}' value="+(i+1)+">"+dselect[i]+"</div>");
							}
						}
						
						dselect ="${value}".split(",");
						for(var i = 0;i<dselect.length;i++){
							$("input[value="+dselect[i]+"]").attr("checked","checked");
						}
					});
				</script>
				
			<#break>
			
			<#default>	
		</#switch>
		
</#macro>


<#if listField?has_content>
<div class="form-group" style="overflow:hidden;">
			<#list listField as listField>
					<#if filedValue?has_content>
							<@field type="${listField.fieldType}" name="${listField.fieldTipsName}" filedName="${listField.fieldFieldName}" value="${filedValue['${listField.fieldFieldName}']?default('')}"  defaultValue="${listField.fieldDefault?default('')}" isnull="${listField.fieldIsNull?default()}"/>
					<#else>
							<@field type="${listField.fieldType}" name="${listField.fieldTipsName}" filedName="${listField.fieldFieldName}" value=""  defaultValue="${listField.fieldDefault?default('')}" isnull="${listField.fieldIsNull?default()}"/>
					</#if>
			</#list>
</div>
</#if>
