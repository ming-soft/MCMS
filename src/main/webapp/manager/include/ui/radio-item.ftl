	<label><input type="radio"<#rt/>
 value="${rkey}"<#rt/>
<#if (rkey?string=="" && (!value?? || value?string=="")) || (value?? && value?string!="" && value?string==rkey?string)> checked="checked"</#if><#rt/>
<#include "common-attributes.ftl"/><#rt/>
/>${rvalue}</label><#if hasNext> </#if>
