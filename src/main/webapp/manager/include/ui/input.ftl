<#--
<input type="text"/>
-->
<#macro text id="" name="" value=""	label="" title=""
 	class="form-control" 	style=""	readonly=""	disabled=false	maxlength=""	minlength=""	
 	validation="" size=""	width="" placeholder="" groupClass="form-group" onclick="" onchange="" labelStyle="" autocomplete="off" help="" helpDirection="">
<div class="${groupClass} ms-form-group">	
	<#include "control.ftl"/><#rt/>
	<div class="col-sm-9 ms-from-group-input ms-form-input"  style="<#if width!="">width:${width}px;</#if>${style}"<#rt/>>
		<input type="text"  autocomplete="${autocomplete}"<#rt/>
		<#if id!=""> id="${id}"</#if><#rt/>
		<#if maxlength!=""> maxlength="${maxlength}"</#if><#rt/>
		<#if size!=""> maxlesizength="${size}"</#if><#rt/>
		<#if readonly!=""> readonly="${readonly}"</#if><#rt/>
		<#if value?? && value?string!=""> value="${value?html}"</#if><#rt/>
		<#if  onchange?? && onchange!=""> onchange="${onchange}"</#if><#rt/>
		<#include "common-attributes.ftl" /><#rt/>
		/><#rt/>
	</div>
</div>
</#macro>

<#--
<input type="password"/>
-->
<#macro password
	id="" name="" value=""	label="" title=""
 	class="form-control" 	style=""	readonly=""	disabled=false	maxlength=""	minlength=""	
 	validation="" size=""	width="" placeholder="" groupClass="form-group" onclick="" onchange="" labelStyle="" autocomplete="off" help="" helpDirection="">
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>
	<div  class="ms-form-control ms-from-group-input col-sm-9" <#if width!=""> style="width:${width}px"</#if><#rt/>>
		<input type="password" autocomplete="${autocomplete}"<#rt/>
		<#if id!=""> id="${id}"</#if><#rt/>
		<#if maxlength!=""> maxlength="${maxlength}"</#if><#rt/>
		<#if readonly!=""> readonly="${readonly}"</#if><#rt/>
		<#if value!=""> value="${value}"</#if><#rt/>
		<#if  onchange?? && onchange!=""> onchange="${onchange}"</#if><#rt/>
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
	 name list listKey="" listValue="" value="" width=""
	  help="" helpPosition="2" colon=":" hasColon="true"
	  label="" class="" style=""  disabled=false direction=true validation="" size="" labelStyle="" onclick="" help="" helpDirection="">
<div class="form-group ms-form-group  _${name}Div">
	<#include "control.ftl"/><#rt/>
	<div class="col-sm-9 ms-from-group-input " style="margin-top:7px<#if width!=""> ;width:${width}px</#if>"<#rt/>>
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
	<script>
		$(function() {
			<#if direction>
				//$("._${name}Div label.ms-radio").removeClass("radio").addClass("radio-inline");
			<#else>
				//$("._${name}Div label.ms-radio").removeClass("radio-inline").addClass("radio");
			</#if>
		})
	</script>
</#macro>



<#--
<input type="checkbox"/>
-->
<#macro checkbox
	list listKey="" listValue="" valueList=[]
	label=""     colon=":" hasColon="true"
	id="" name="" class="" style="" size="" title="" disabled=false
	validation="" direction=true
	width=""
	labelStyle=""
	help=""
	helpDirection=""
	>
<div class="form-group ms-form-group _${name}Div">	
	<#include "control.ftl"/><#rt/>
	<div class="col-sm-9 ms-from-group-input  " style="margin-top:7px<#if width!=""> ;width:${width}px</#if>"<#rt/> >
		<#if list?is_sequence>
			<#if listKey!="" && listValue!=""> 
				<#list list as item>
					<#local rkey=item[listKey]>
					<#local rvalue=item[listValue]>
					<#local index=item_index>
					<#local hasNext=item_has_next>
					<#include "checkboxlist-item.ftl"><#t/>
				</#list>
			<#else>
				<#list list as item>
					<#local rkey=item>
					<#local rvalue=item>
					<#local index=item_index>
					<#local hasNext=item_has_next>
					<#include "checkboxlist-item.ftl"><#t/>
				</#list>
			</#if>
		<#else>
			<#list list?keys as key>
				<#local rkey=key/>
				<#local rvalue=list[key]/>
				<#local index=key_index>
				<#local hasNext=key_has_next>
				<#include "checkboxlist-item.ftl"><#t/>
			</#list>
		</#if>
	</div>
</div>

	<script>
		$(function() {
			<#if direction>
				//$("._${name}Div label.ms-checkbox").removeClass("checkbox").addClass("checkbox-inline");
			<#else>
				//$("._${name}Div label.ms-checkbox").removeClass("checkbox-inline").addClass("checkbox");
			</#if>
		})
	</script>

</#macro>

<#--
<input type="checkbox"/>
4.5.5废弃
-->
<#macro checkboxlist
	list listKey="" listValue="" valueList=[]
	label=""     colon=":" hasColon="true"
	id="" name="" class="" style="" size="" title="" disabled=false
	validation="" direction=true
	width=""
	labelStyle=""
	help=""
	helpDirection=""
	>
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>
	<div class="col-sm-9" <#if width!=""> style="${width}px"</#if><#rt/>>
		<#if list?is_sequence>
			<#if listKey!="" && listValue!="">
				<#list list as item>
					<#local rkey=item[listKey]>
					<#local rvalue=item[listValue]>
					<#local index=item_index>
					<#local hasNext=item_has_next>
					<#include "checkboxlist-item.ftl"><#t/>
				</#list>
			<#else>
				<#list list as item>
					<#local rkey=item>
					<#local rvalue=item>
					<#local index=item_index>
					<#local hasNext=item_has_next>
					<#include "checkboxlist-item.ftl"><#t/>
				</#list>
			</#if>
		<#else>
			<#list list?keys as key>
				<#local rkey=key/>
				<#local rvalue=list[key]/>
				<#local index=key_index>
				<#local hasNext=key_has_next>
				<#include "checkboxlist-item.ftl"><#t/>
			</#list>
		</#if>
	</div>
</div>	
</#macro>
