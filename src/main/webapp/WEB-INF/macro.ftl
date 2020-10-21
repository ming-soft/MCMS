<#macro ms_file jsonString>
    <#if jsonString??&&jsonString!=''>
        <@compress>
            ${jsonString?eval[0].path}
        </@compress>
    </#if>
</#macro>