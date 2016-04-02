<#--
<form></form>
name:表单名称
id:表单id
action:提交地址
method:提交方式
-->
<#macro form  name id="" target=""
	 action="" method="post"  enctype=""  
	 class="form-horizontal"  style="display:none; width:100%; background-color: white;" isvalidation=false tooltip=false
	 redirect=""
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
<@ms.hidden name="redirect" value="${redirect}"/>
<#nested/><#rt/>
<script>
	$(function() {
				var id = "${name}";
				<#if id?? && id!="">id="${id}"</#if>
				$('#'+id).fadeIn("slow");
				<#if isvalidation>
				$('#'+id).bootstrapValidator({
						<#if tooltip>
				        container: 'tooltip',
				        </#if>
				        feedbackIcons: {
				            valid: 'glyphicon glyphicon-ok',
				            invalid: 'glyphicon glyphicon-remove',
				            validating: 'glyphicon glyphicon-refresh'
				        }
						
				});	
				
				</#if>
				//$("#${name} .form-group>div.radio").siblings("i.form-control-feedback").clone().prependTo($("#${name} .form-group>div.radio"));
				//$("#${name} .form-group>div.radio").siblings("i.form-control-feedback").remove();
				<#if !class?has_content>
					
					$("#${name} .form-group>label").removeClass("col-sm-2");
					$("#${name} .form-group>div").removeClass("col-sm-9");
					var width = $("#${name} .form-group>div.ms-from-group-input").width();
					//$("#${name} .form-group>div.ms-from-group-input>:input").unwrap().parent().width(width);
					$("#${name} .form-group>div.ms-from-group-input").addClass("has-feedback").parent().width(width);
					
					//$("#${name} .form-group label").removeClass("checkbox-inline").removeClass("radio-inline");
					//$("#${name} .has-feedback .form-control-feedback").css({top:"25px"});
				<#elseif class?index_of("searchForm") gt -1>
					$("#${name} .form-group>label").removeClass("col-sm-3");
					$("#${name} .form-group>div").removeClass("col-sm-9");
					
					$("#${name} .form-group>label").addClass("col-sm-4");
					$("#${name} .form-group>div").addClass("col-sm-8");		
					
					$("#${name} .ms-form-group").addClass("col-sm-4");	
					$("#${name}").show(); 
				</#if>
	})
</script>
</form>
</#macro>

<#macro searchForm  name id="" target=""
	 action="" method="post"  enctype=""  
	 class="searchForm form-inline"  style="display:none;  background-color: white;" isvalidation=false tooltip=true >
	<@ms.form name="${name}" id="${id}" action="${action}" style="display:none;background-color: white;" isvalidation=true class="${class}" tooltip=true>
		<#nested/><#rt/>
	</@ms.form>
</#macro>

<#macro searchFormButton close="">
		<div class="bottom" style="clear:both">
			<!--div class="close">close</div-->
			<@ms.resetButton/>
			<#nested/><#rt/>
		</div>
</#macro>

<#--自定义行-->
<#macro formRow label=" " 
 	class="form-control" 	 	
 	 width=""  groupClass="form-group"   labelStyle="" help="">
<div class="${groupClass}">	
	<#include "control.ftl"/><#rt/>
	<div class="col-sm-9 ms-from-group-input" style="line-height:30px;<#if width!=""> width:${width}px;</#if>"<#rt/>>
		<#nested/>
	</div>
</div>
</#macro>

<#--
<input type="text"/>
-->
<#macro fromgroup   id="" size="" label="" style="">
<div class="form-group ms-form-group" style="${style}" help="">	
	<#include "control.ftl"/><#rt/>
	<div class="ms-form-control">
		<#nested/><#rt/>
	 </div>
</div>
</#macro>

