<#--
<input type="t"/>
-->
<#macro time    id=""    name=""    value="" 
	label=""  title=""  size=""  labelStyle="" width=""
  class="form-control"   style="" readonly="" disabled=false  maxlength=""  minlength=""   placeholder="" 	validation="" 
  help=""
  helpDirection=""
  >
<div class="form-group ms-form-group">
    <#include "control.ftl"/><#rt/>
    <div class="control-group col-sm-9 ms-from-group-input"  style="min-widht:200px;<#if width!="">width:${width}px</#if>"<#rt/>>
    	<div class="controls">
		     <div class="input-prepend input-group date" <#if id!=""> id="${id}"<#elseif name!="">id="${name}"</#if><#rt/> 
		     data-date="" data-date-format="hh:ii"  data-link-format="hh:ii">
		         <span class="add-on input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
		         <input type="text"<#rt/>
		              <#if maxlength!=""> maxlength="${maxlength}"</#if><#rt/>
		              <#if readonly!=""> readonly="${readonly}"</#if><#rt/>
		              <#if value?? && value?string!=""> value="${value?html}"</#if><#rt/>
		              <#include "common-attributes.ftl"/><#rt/>/>
		 	</div>
		</div>
	</div>
</div>

<script>
	$(function(){
	 $('#${name}').datetimepicker({
	        language: 'cn', 
	        todayBtn:  1,
			autoclose: true,
			todayHighlight: 1,
			format: 'hh:ii',
			startView: 1,
			minView: 0,
			maxView: 1,
			forceParse: 0,
	    });
    });
</script>

</#macro>
