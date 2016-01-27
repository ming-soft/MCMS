<#if label!="">
	<#if name?? && name!="">
		<label for="${name}" <#if labelStyle?? && labelStyle!="">style="${labelStyle?default('')}"</#if> class="col-sm-3  control-label ">
		<#if help!="">
				<span tabindex="0" class="glyphicon glyphicon-question-sign" data-toggle="popover"  role="button" data-trigger="focus" data-container="body" data-placement="${helpDirection?default('rigth')}" title="提示" data-content="${help}"></span>
		</#if>	
		${label}
		</label>
	<#else>
		<label <#if labelStyle?? && labelStyle!="">style="${labelStyle?default('')}"</#if> class="col-sm-3 control-label">
		<#if help!="">
				<span tabindex="0" class="glyphicon glyphicon-question-sign" role="button" data-toggle="popover" data-trigger="focus" data-container="body" data-placement="${helpDirection?default('right')}" title="提示" data-content="${help}"></span>
		</#if>
		${label}
		</label>		
	</#if>
</#if>