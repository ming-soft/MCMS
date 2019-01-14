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
<#include "/include/ui/common-attributes.ftl"/><#rt/>
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
	<div class="search-form-div"></div>
	
	<script type="text/javascript">
    $(function(){
        //收缩筛选
        var clickTimes = 1;
        var searchFormheight = $("#searchForm").height();
        
        //初始化顶住筛选部分的空白div
        $(".search-form-div").height(searchFormheight + 15);
        var _height = parseInt(searchFormheight)-26;
        
        $("#searchForm").find(".close").click(function(){
            var obj = $(this);
            if (clickTimes % 2 == 1) {
                //空白div与筛选同时往上缩
                $(".search-form-div").animate({height:"0px"},"slow");
                $("#searchForm").animate({top:"-"+_height+"px"},"slow");
                obj.find("span").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
            } else {
            
                //空白div与筛选同时展开
                $(".search-form-div").animate({height:searchFormheight+15+"px"},"slow");
                $("#searchForm").animate({top:"46px"},"slow");
                obj.find("span").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
            }
            clickTimes++
        })
    })
</script>
	
</#macro>

<#macro searchFormButton close="">
		<div class="bottom" style="clear:both">
			<div class="close"><span class="glyphicon glyphicon-chevron-up"></span></div>
			<@ms.resetButton/>
			<#nested/><#rt/>
		</div>
</#macro>

<#--自定义行-->
<#macro formRow label=" " class="form-control" colSm="" groupClass="form-group" width="" labelStyle="" help="" style="" >
	<div class="${groupClass}">	
		<#include "/include/ui/control.ftl"/><#rt/>
		<div class="col-sm-9 ms-from-group-input" style="line-height:30px;<#if width!=""> width:${width}px;</#if>${style}"<#rt/>>
			<#nested/>
		</div>
	</div>
</#macro>

<#--
<input type="text"/>
-->
<#macro fromgroup   id="" size="" label="" style="">
<div class="form-group ms-form-group" style="${style}" help="">	
	<#include "/include/ui/control.ftl"/><#rt/>
	<div class="ms-form-control">
		<#nested/><#rt/>
	 </div>
</div>
</#macro>

