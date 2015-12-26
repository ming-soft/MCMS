<#--
<input type="text"/>
-->
<#macro text    id=""    name=""    value=""	label=""	title=""
 	class="form-control" 	style=""	readonly=""	disabled=false	maxlength=""	minlength=""	
 	validation="" size=""	 placeholder="" groupClass="form-group" onclick="" onchange="" labelStyle="">
<div class="${groupClass}">	
	<#include "control.ftl"/><#rt/>
		<input type="text" <#rt/>
		<#if id!=""> id="${id}"</#if><#rt/>
		<#if maxlength!=""> maxlength="${maxlength}"</#if><#rt/>
		<#if readonly!=""> readonly="${readonly}"</#if><#rt/>
		<#if value?? && value?string!=""> value="${value?html}"</#if><#rt/>
		<#if  onchange?? && onchange!=""> onchange="${onchange}"</#if><#rt/>
		<#include "common-attributes.ftl" /><#rt/>
		
		/><#rt/>
</div>
</#macro>

<#--
<input type="text"/>
-->
<#macro fromgroup    id="" size="" label="" style="">
<div class="form-group ms-form-group" style="${style}">	
	<#include "control.ftl"/><#rt/>
	<div class="ms-form-control">
		<#nested/><#rt/>
	 </div>
</div>
</#macro>

<#--
<input type="password"/>
-->
<#macro password
	maxlength="" readonly="" value="" autocomplete="off"
	label=""     colon=":" hasColon="true"
	id="" name="" class="" style="" size="" title="" disabled=false 
   equalTo="" maxlength="" minlength="" class="form-control" validation=""
	labelStyle="">
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>
	<div  class="ms-form-control">
		<input type="password" autocomplete="${autocomplete}"<#rt/>
		<#if id!=""> id="${id}"</#if><#rt/>
		<#if maxlength!=""> maxlength="${maxlength}"</#if><#rt/>
		<#if readonly!=""> readonly="${readonly}"</#if><#rt/>
		<#if value!=""> value="${value}"</#if><#rt/>
		<#include "common-attributes.ftl"/><#rt/>
		/>
	</div>
</div>
</#macro>

<#--
<input type="hidden"/>
-->
<#macro hidden
	id="" name="" value=""
	>
<input type="hidden"<#rt/>
<#if id!=""> id="${id}"</#if><#rt/>
<#if name!=""> name="${name}"</#if><#rt/>
<#if value?string!=""> value="${value}"</#if><#rt/>
/>
</#macro>

<#--
<input type="radio"/>
-->
<#macro radio
	 name list listKey="" listValue="" value=""
	 required="false" help="" helpPosition="2" colon=":" hasColon="true"
	 id="" label="" class="" style=""  disabled=false direction=true validation="" size="" labelStyle="">
<div class="form-group ms-form-group">
	<#include "control.ftl"/><#rt/>
	<div  class="ms-form-control">
		<#if list?is_sequence><#--LIST-->
			<#if listKey!="" && listValue!="">
				<#list list as item>
					<#local rkey=item[listKey]>
					<#local rvalue=item[listValue]>
					<#local index=item_index>
					<#local hasNext=item_has_next>
					<#include "radio-item.ftl"><#t/>
				</#list>
			<#else>
				<#list list as item>
					<#local rkey=item>
					<#local rvalue=item>
					<#local index=item_index>
					<#local hasNext=item_has_next>
					<#include "radio-item.ftl"><#t/>
				</#list>
			</#if>
		<#else>
			<#list list?keys as key><#--MAP-->
				<#local rkey=key/>
				<#local rvalue=list[key]/>
				<#local index=key_index>
				<#local hasNext=key_has_next>
				<#include "radio-item.ftl"><#t/>
			</#list>
		</#if>
	</div>
</div>
</#macro>

<#--
<input type="checkbox"/>
-->
<#macro checkbox 
	value="" cvalue=""  readonly="" checked="" labelFor=""
	label=""  validation=""   
	id="" name="" class="" style="" size="" title="" disabled=false labelStyle=""
	>
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>
	<div class="ms-form-control">
		<div class="checkbox <#if disabled?? && disabled>disabled</#if>">
			<label>
				<input type="checkbox"<#rt/>
				 value="${value}"<#rt/>
				 id="${id+'-'+name}"<#rt/>
				<#if readonly!=""> readonly="${readonly}"</#if><#rt/>
				<#if checked!=""> checked="${checked}"<#elseif cvalue!="" && cvalue==value> checked="checked"</#if><#rt/>
				<#include "common-attributes.ftl"/><#rt/>
				/><#if labelFor!="">${labelFor}</#if>			
			</label>
		</div>
	</div>
</div>
</#macro>


