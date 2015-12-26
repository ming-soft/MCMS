<#--
<input type="text"/>
-->
<#macro date    id=""    name=""    value="" begin="" end="" limit="30"  
	time=false single=false label=""	title=""	size=""	
	class="form-control"	 style=""	readonly=""	validation=""   disabled=false	 maxlength=""	minlength=""	 placeholder="" ranges=true
	labelStyle=""
	>
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>
			<div class="control-group">
		            <div class="controls">
			             <div class="input-prepend input-group">
			               <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
							<input type="text"<#rt/>
							<#if id!=""> id="${id}"<#elseif name!="">id="${name}"</#if><#rt/>
							<#if maxlength!=""> maxlength="${maxlength}"</#if><#rt/>
							<#if readonly!=""> readonly="${readonly}"</#if><#rt/>
							<#if value?? && value?string!=""> value="${value?html}"</#if><#rt/>
							<#include "common-attributes.ftl"/><#rt/>
							/><#rt/> 
			             </div>
		            </div>
	          </div>	 
</div>
<script>
  var ${name}Set = {
    startDate: moment().subtract(29, 'days'),
    endDate: moment(),
    <#if begin?has_content>minDate: '${begin?string('yyyy-MM-dd')}',</#if>
     <#if end?has_content>maxDate: '${end?string('yyyy-MM-dd')}',</#if>
    dateLimit: { days: ${limit} },
    showDropdowns: true,
    showWeekNumbers: true,
    <#if time>
    timePicker: true,
    timePickerIncrement: 1,
    </#if>
    <#if single>singleDatePicker: true,</#if>
    timePicker12Hour: true,
    <#if ranges>
    ranges: {
       '今天': [moment(), moment()],
       '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
       '最近7天': [moment().subtract(6, 'days'), moment()],
       '最近30天': [moment().subtract(29, 'days'), moment()],
       '当月': [moment().startOf('month'), moment().endOf('month')],
       '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
    },
    </#if>
    opens: 'left',
    buttonClasses: ['btn btn-default'],
    applyClass: 'btn-small btn-primary',
    cancelClass: 'btn-small',
    format: 'YYYY-MM-DD<#if time> hh:mm:ss</#if>',
    separator: '至',
    locale: {
        applyLabel: '确认',
        cancelLabel: '取消',
        //fromLabel: '开始时间',
        //toLabel: '结束时间',
        customRangeLabel: '自定义',
        daysOfWeek: ['日', '一', '二', '三', '四', '五','六'],
        monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
        firstDay: 1
    }
  };
                  
   var ${name}Func = function(start, end, label) {
    //alert("Callback has fired: [" + start.format('MMMM D, YYYY') + " to " + end.format('MMMM D, YYYY') + ", label = " + label + "]");
    //$('#subscribeReplyForm').formValidation('revalidateField', "${name}");
  }
$('#${name}').daterangepicker(${name}Set, ${name}Func);
      $('#${name}').on('apply.daterangepicker', function(ev, picker) {
            $('#${name}').parents("form:first").data('bootstrapValidator').revalidateField('sdfsfsdsdfsd');
        });
</script>

</#macro>
