<#--
<input type="file"/>
-->
<#macro file
	accept="" value=""
	label="" noHeight="false" required="false" colspan="" width="100" help="" helpPosition="2" colon=":" hasColon="true"
	id="" name="" class="" style="" size="" title="" disabled="" tabindex="" accesskey="" labelStyle=""
	onclick="" ondblclick="" onmousedown="" onmouseup="" onmouseover="" onmousemove="" onmouseout="" onfocus="" onblur="" onkeypress="" onkeydown="" onkeyup="" onselect="" onchange=""
	>
<#include "/include/ui/control.ftl"/><#rt/>
<input type="file"<#rt/>
<#if id!=""> id="${id}"</#if><#rt/>
<#if accept!=""> accept="${accept}"</#if><#rt/>
<#if value!=""> value="${value}"</#if><#rt/>
<#include "/include/ui/common-attributes.ftl"/><#rt/>
<#include "/include/ui/scripting-events.ftl"/><#rt/>
/>
<#include "/include/ui/control-close.ftl"/><#rt/>
</#macro>
