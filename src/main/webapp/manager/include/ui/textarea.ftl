<#--
<textarea name="textarea"></textarea>
-->
<#macro textarea
	name
	wrap="soft" 
	readonly="" 
	cols="" 
	rows="" 
	value=""
	label="" 
	title=""
	required="false" 
	id="" 
	class="form-control" 
	style="" 
	size=""
	disabled=false
	maxlength="" 
	placeholder=""
	validation=""
	labelStyle=""
	width=""
	help=""
	helpDirection=""
	>
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>
	<div  class="ms-form-control ms-from-group-input col-sm-9" <#if width!=""> style="width:${width}px"</#if><#rt/>>
		<textarea<#rt/>
		<#if id!=""> id="${id}"</#if><#rt/>
		<#if wrap!=""> wrap="${wrap}"</#if><#rt/>
		<#if readonly!=""> readonly="${readonly}"</#if><#rt/>
		<#if cols!=""> cols="${cols}"</#if><#rt/>
		<#if rows!=""> rows="${rows}"</#if><#rt/>
		<#include "common-attributes.ftl"/><#rt/>
		><#if value?? && value!="">${value!?html}</#if></textarea>
	</div>
</div>
</#macro>
