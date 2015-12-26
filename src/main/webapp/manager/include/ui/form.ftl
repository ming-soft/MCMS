<#--
<form></form>
name:表单名称
id:表单id
action:提交地址
method:提交方式
-->
<#macro form  name id="" target=""
	 action="" method="post"  enctype=""  
	 class="form-horizontal" style=""  
	 isvalidation=false
	>
<form<#rt/>
 role="form"<#rt/>
 method="${method}"<#rt/>
 action="${action}"<#rt/>
<#if target!="">target="${target}" <#else> target="_self"</#if><#rt/>

<#if id!=""> id="${id}"<#else> id="${name}"</#if><#rt/>
<#if enctype!=""> enctype="${enctype}"</#if><#rt/>
<#include "common-attributes.ftl"/><#rt/>
>
<#nested/><#rt/>
<#if isvalidation>
<script>
	$(function() {
				var id = "${name}";
				<#if id?? && id!="">id="${id}"</#if>
				$('#'+id).bootstrapValidator({
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh',
							autoFocus : true
						}
				});	
	})
</script>
</#if>
</form>
</#macro>
