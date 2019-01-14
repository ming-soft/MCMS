<label class="ms-radio" style="padding-right:10px"><input type="radio"<#rt/>
 value="${rkey}"<#rt/>
 <#if  onclick?? && onclick!=""> onclick="${onclick}"</#if><#rt/>
<#if disabled?? && disabled> disabled="disabled" </#if><#rt/>
<#if (rkey?string=="" && (!value?? || value?string=="")) || (value?? && value?string!="" && value?string==rkey?string)> checked="checked"</#if><#rt/>
<#include "common-attributes.ftl"/><#rt/>
/> ${rvalue} </label>    <#if hasNext> </#if>
