<#--
<select><option></option></select>
-->
<#macro select
	list value="" multiple=false  listKey="" listValue="" listDeep=""  default="请选择"
	label="" validation=""    colon=":" hasColon="true" readonly=""
	id="" name="" class="form-control" style="" size="" title="" disabled=false
	labelStyle=""
	>
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>
	<div class="ms-form-control" style="height:auto">
		<select<#rt/>
		<#if id!=""> id="${id}"</#if><#rt/>
		<#if multiple>multiple="multiple"</#if><#rt/>
	   <#if readonly!=""> readonly="${readonly}"</#if><#rt/>
		<#include "common-attributes.ftl"/><#rt/>
		><#rt/>
		<#if value?string=="">
			<option value="">${default}</option>
		</#if>
		<#if list?is_hash>
			<#list list?keys as key>
				<option value="${key}" <#if key?string==value?string> selected="selected"</#if>>${list[key]}</option><#rt/>
			</#list>
		<#elseif list?is_sequence || list?eval?is_sequence>
			<#assign tempList=[]/>
			<#if list?is_string> 
				<#assign tempList=list?eval/>
			</#if>
			<#if listKey!="" && listValue!="">
				<#if listDeep!="" && tempList?size gt 0><#local origDeep=tempList[0][listDeep]+1/></#if>
				<#list tempList as item>
					<option value="${item[listKey]}"<#if item[listKey]?string==value?string> selected="selected"</#if>><#if listDeep!="" && item[listDeep] gte origDeep><#list origDeep..item[listDeep] as i>&nbsp;&nbsp;</#list>></#if>${item[listValue]!}</option><#rt/>
				</#list>
			<#else>
				<#list list as item>
					<option value="${item}"<#if item==value> selected="selected"</#if>>${item}</option><#rt/>
				</#list>
			</#if>
		</#if>
		</select>
	</div>

</div>
</#macro>
