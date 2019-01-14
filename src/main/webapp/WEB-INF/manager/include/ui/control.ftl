<#if label!="">
	<#assign tmp="2">
	<label <#if name?? && name!="">for="${name}"</#if> <#if labelStyle?? && labelStyle!="">style="${labelStyle?default('')}"</#if> <#if colSm?? && colSm!=""><#assign tmp="${colSm}"></#if> class="col-sm-${tmp} control-label ">
	<#if help!="">
		<script>
			$(function () {
			  $('[data-toggle="popover"]').popover()
			})
		</script>
		<span tabindex="0" class="glyphicon glyphicon-question-sign" data-toggle="popover"  role="button" data-trigger="focus" data-container="body" data-placement="${helpDirection?default('rigth')}" title="提示" data-content="${help}"></span>
	</#if>	
	${label}
	</label>
	
</#if>