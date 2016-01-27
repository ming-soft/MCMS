	<label class="ms-check"><input type="checkbox"<#rt/>
	 value="${rkey}"<#rt/>
	<#if valueList?seq_contains(rkey)> checked="checked"</#if><#rt/>
	<#include "common-attributes.ftl"/><#rt/>
	/> ${rvalue}</label><#if hasNext> </#if>
