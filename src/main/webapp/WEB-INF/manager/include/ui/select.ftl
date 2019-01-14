<#--
<select><option></option></select>
-->
<#macro select
	list=[] value="" multiple=false  listKey="" listValue="" listDeep=""  
	label="" validation=""    colon=":" hasColon="true" readonly=""
	id="" name="" class="form-control" style="" size="" title="" disabled=false
	labelStyle=""
	width=""
	help=""
	helpDirection=""
	default=""
	defaultValue=""
	select2=false
	>
<div class="form-group ms-form-group">	
	<#include "/include/ui/control.ftl"/><#rt/>
	<div class="col-sm-9 ms-form-control ms-from-group-input" <#if width!=""> style="width:${width}px"</#if><#rt/>>
		<select<#rt/>
		<#if id!=""> id="${id}"</#if><#rt/>
		<#if multiple>multiple="multiple"</#if><#rt/>
	   <#if readonly!=""> readonly="${readonly}"</#if><#rt/>
		<#include "/include/ui/common-attributes.ftl"/><#rt/>
		><#rt/>
			<#if default?has_content>
			<option value="<#if value?has_content>${value}</#if>">${default}</option>
			</#if>
			<#if list?is_sequence><#--LIST-->
				<#if listKey!="" && listValue!="">
					<#list list as item>
						<#local rkey=item[listKey]>
						<#local rvalue=item[listValue]>
						<option value="${rkey}" <#if rkey?string==value?string> selected="selected"</#if>>${rvalue}</option><#rt/>
					</#list>
				<#else>
					<#list list as item>
						<option value="${item}" <#if item?string==value?string> selected="selected"</#if>>${item}</option><#rt/>
					</#list>
				</#if>
			<#else>
				<#list list?keys as key>
					<#local rkey=key/>
					<#local rvalue=list[key]/>
					<option value="${rkey}" <#if rkey?string==value?string> selected="selected"</#if>>${rvalue}</option><#rt/>
				</#list>
			
			</#if>
		</select>
	</div>

</div>
<#if select2>
	<script>
		$(function() {
			$("select[name='${name}']").select2({width: "${width}px"});
			$("select[name='${name}']").select2().val("${value}").trigger("change");;
		})
	</script>	
</#if>
</#macro>

<#macro select2  name list value="" multiple=false  listKey="" listValue="" listDeep=""  default="请选择"
	label="" validation=""    colon=":" hasColon="true" readonly=""
	 class="form-control" style="" size="" title="" disabled=false
	labelStyle=""
	width=""
	>
	<select id="${name}" name="${name}">
		<option></option>
	</select>
	<script>
		$(function() {
			$("#${name}").select2():
		})
	</script>
</#macro>
