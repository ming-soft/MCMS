<#if name!=""> name="${name}"</#if><#rt/>
<#if class!=""> class="${class}"</#if><#rt/>
<#if style!=""> style="${style}"</#if><#rt/>
<#if title?? && title!=""> title="${title}"</#if><#rt/>
<#if disabled?? && disabled> disabled="${disabled}"</#if><#rt/>
<#if maxlength?? && maxlength!=""> maxlength="${maxlength}"</#if><#rt/>
<#if minlength?? && minlength!=""> minlength="${minlength}"</#if><#rt/>
<#if name!=""> name="${name}"</#if><#rt/>
<#if placeholder?? && placeholder!=""> placeholder="${placeholder}"</#if><#rt/>
<#if  validation?? && validation?has_content><#--验证框架，需要bootstrapValidator框架-->
	<#list validation?keys as key>
		${key}="${validation[key]}"<#rt/>
	</#list>
</#if>
<#if  onclick?? && onclick!=""> onclick="${onclick}"</#if><#rt/>
<#rt/>