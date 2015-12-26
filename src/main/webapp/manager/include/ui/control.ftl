<#if label!="">
	<#if name?? && name!="">
		<label for="${name}" <#if labelStyle?? && labelStyle!="">style="${labelStyle?default('')}"</#if>>${label}</label>
	<#else>
		<label <#if labelStyle?? && labelStyle!="">style="${labelStyle?default('')}"</#if>>${label}</label>		
	</#if>
 
</#if>
