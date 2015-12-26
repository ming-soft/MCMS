<#--
表单相关按钮存放区域
-->
<#macro buttonarea id="" label="" class="form-group" style="clear: both;" size="">
<div class="${class} ms-form-group" 
	<#if id!=""> id="${id}"</#if><#rt/>
	<#if style?? && style?string!=""> style="${style}"</#if><#rt/>
	>
	<#if label!="">
		<label class=" control-label text-right ms-form-label">${label}</label>
	</#if>
	 <div  class="ms-form-control">
		<#nested/><#rt/>
	 </div>
</div>
</#macro>

<#--
保存按钮
-->
<#macro savebutton value="" id="" name="" class="" style=""   disabled=false
onclick="" click=""
>
	<button type="button"  class="btn btn-success"
	<#include "common-attributes.ftl"/><#rt/>
	<#if id!=""> id="${id}"</#if><#rt/>
	>
	<#if value!="">${value}<#else>保存</#if>
	</button><#rt/>
		<#if click?? && click!="" && id?? && id!="">
		<script>
			$(function() {
				$("#${id}").click(function() {
					eval(${click});
				});
			})
		</script>
	</#if>
</#macro>

<#macro button value="" id="" name="" class="btn btn-primary" style=""   disabled=false
onclick="" click="" url="" toggle="tooltip" target="bottom" icon="" title="" placement="bottom"
>
	<button type="button"
	<#include "common-attributes.ftl"/><#rt/>
	<#if toggle!=""> data-toggle="${toggle}"</#if><#rt/>
	<#if onclick!=""> onclick="${onclick}"</#if><#rt/>
	<#if target!=""> data-target="${target}"</#if><#rt/>
	<#if id!=""> id="${id}"</#if><#rt/>
	<#if url!=""> data-ajax-url="${url}"</#if><#rt/>
	<#if placement!=""> data-placement="${placement}"</#if><#rt/>
	
	>
	<#if value!="">${value}<#else>按钮</#if>
	<#if icon!=""><span class="glyphicon glyphicon-${icon}"></span></#if>
	
	</button><#rt/>
	<#if click?? && click!="" && id?? && id!="">
		<script>
			$(function() {
				$("#${id}").click(function() {
					eval(${click});
				});
			})
		</script>
	</#if>
</#macro>

<#--
重置按钮
-->
<#macro resetbutton value="" id="" name="" class="" style="" size="" title="" disabled=false>
	<button type="reset"  class="btn reset"
	<#include "common-attributes.ftl"/><#rt/>
	>
	<#if id!=""> id="${id}"</#if><#rt/>
	<#if value!="">${value}<#else>重置</#if>
	</button><#rt/>
</#macro>


<#--按钮组-->
<#macro btnGroup value="" id="" name="" class="default" style="" size="" title="" disabled=false >
  <button type="button" class="btn btn-${class}">${value}</button>
  <button type="button" class="btn btn-${class} dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
    <span class="caret"></span>
    <span class="sr-only">Toggle Dropdown</span>
  </button>
  <ul class="dropdown-menu" role="menu">
    	<#nested/>
  </ul>
</#macro>
<#--按钮组－子菜单，配合btnGroup使用-->
<#macro btnGroupLi value="" href="" class="" id="" ajaxUrl="">
    <li <#include "attributes.ftl"/><#rt/>><#if href !="" ><a href="${href}">${value}</a><#else>${value}</#if></li>
</#macro>
