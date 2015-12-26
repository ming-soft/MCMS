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
	maxlength="" minlength=""
	placeholder=""
	validation=""
	labelStyle=""
	>
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>
	<div  class="ms-form-control" style="height:auto">
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