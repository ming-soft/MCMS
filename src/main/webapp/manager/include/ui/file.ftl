<#--
<input type="file"/>
-->
<#macro file
	accept="" value=""
	label="" noHeight="false" required="false" colspan="" width="100" help="" helpPosition="2" colon=":" hasColon="true"
	id="" name="" class="" style="" size="" title="" disabled="" tabindex="" accesskey="" labelStyle=""
	onclick="" ondblclick="" onmousedown="" onmouseup="" onmouseover="" onmousemove="" onmouseout="" onfocus="" onblur="" onkeypress="" onkeydown="" onkeyup="" onselect="" onchange=""
	>
<#include "control.ftl"/><#rt/>
<input type="file"<#rt/>
<#if id!=""> id="${id}"</#if><#rt/>
<#if accept!=""> accept="${accept}"</#if><#rt/>
<#if value!=""> value="${value}"</#if><#rt/>
<#include "common-attributes.ftl"/><#rt/>
<#include "scripting-events.ftl"/><#rt/>
/>
<#include "control-close.ftl"/><#rt/>
</#macro>
