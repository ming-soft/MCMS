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
				<#if value!="">
					<@ms.text name="${filedName}"  width="300"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${value}" />
				<#else>
					<@ms.text name="${filedName}"  width="300"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${defaultValue}"/>
				</#if>
				
				
			<#break>
			<#case "2">
				
				<#if value!="">
					<@ms.textarea name="${filedName}"  width="600" label="${name}"  wrap="Soft" rows="4"  size=""  value="${value}" placeholder="请输入${name}"/>
				<#else>
					<@ms.textarea name="${filedName}"  width="600" label="${name}"  wrap="Soft" rows="4"  size=""  value="${defaultValue}" placeholder="请输入${name}"/>
				</#if>
			<#break>
			<#case "3">
				<@ms.editor name="${filedName}"  width="600" label="${filedName}"content="${value}"  width="688px;" appId="${appId?default(0)}"/>			
				 
			<#break>
			<#case "4">
				<#if value!="">
					<@ms.text name="${filedName}"  width="300"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${value}"/>
				<#else>
					<@ms.text name="${filedName}"  width="300"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${defaultValue}"/>
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
					<@ms.text name="${filedName}"  width="300"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${value}"/>
				<#else>
					<@ms.text name="${filedName}"  width="300"  label="${name}" title="${name}" size="5"  placeholder="请输入${name}"  value="${defaultValue}"/>
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
				<#if value!="">
					<@ms.date label="${name}" name="${filedName}" value="${value}" single=true width="300"/>
				<#else>
					<@ms.date label="${name}" name="${filedName}" value="${defaultValue}" single=true width="300"/>
				</#if>
			<#break>
			<#case "7">
					<@ms.formRow label="${name}">
							<@uploadImg path="upload/article/${appId}/" inputName="${filedName}" size="30" filetype="" msg="提示：可以上传多张图片"  maxSize="10" imgs="${value?default('')}" />
					</@ms.formRow>
			<#break>
			
			<#case "8">
				<@ms.formRow label="${name}">
						<@uploadFile path="upload/article/${appId}/" inputName="${filedName}" size="1" filetype="*" msg="建议上传5M以下的文件"  maxSize="5" callBack="test" isRename="false"/>
				</@ms.formRow>
				<script>
				 function test(e){
            		isSuccess = true;
					alert("文件上传成功 ");
	   			}
	   			</script>
	   			
			<#break>
			
			<#case "9">
				<@ms.formRow label="${name}" width="300">
						<select class="form-control" name="${filedName}"></select>
				</@ms.formRow>
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
				<@ms.radio name="${filedName}" label="${name}" list=defaultValue?split(',') value="${value}"/>
			<#break>
			<#case "11">
				<@ms.checkbox name="${filedName}" label="${name}" list=defaultValue?split(',') valueList=value?split(",")/>
			<#break>
			
			<#default>	
		</#switch>
		
</#macro>


<#if listField?has_content>
			<#list listField as listField>
					<#if filedValue?has_content>
							<@field type="${listField.fieldType}" name="${listField.fieldTipsName}" filedName="${listField.fieldFieldName}" value="${filedValue['${listField.fieldFieldName}']?default('')}"  defaultValue="${listField.fieldDefault?default('')}" isnull="${listField.fieldIsNull?default()}"/>
					<#else>
							<@field type="${listField.fieldType}" name="${listField.fieldTipsName}" filedName="${listField.fieldFieldName}" value=""  defaultValue="${listField.fieldDefault?default('')}" isnull="${listField.fieldIsNull?default()}"/>
					</#if>
			</#list>
</#if>
