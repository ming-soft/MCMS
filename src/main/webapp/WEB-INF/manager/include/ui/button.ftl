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
	<#include "/include/ui/common-attributes.ftl"/><#rt/>
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

<#--
重置按钮
-->
<#macro resetbutton value="" id="" name="" class="" style="" size="" title="" disabled=false>
	<button type="reset"  class="btn reset"
	<#include "/include/ui/common-attributes.ftl"/><#rt/>
	>
	<#if id!=""> id="${id}"</#if><#rt/>
	<#if value!="">${value}<#else>重置</#if>
	</button><#rt/>
</#macro>

<#macro button value="" id="" name="" class="btn btn-primary" style=""   disabled=false
onclick="" click="" url="" toggle="tooltip" target="bottom" icon="" title="" placement="bottom"
>
	<button type="button"
	<#include "/include/ui/common-attributes.ftl"/><#rt/>
	<#if toggle!=""> data-toggle="${toggle}"</#if><#rt/>
	<#if onclick!=""> onclick="${onclick}"</#if><#rt/>
	<#if target!=""> data-target="${target}"</#if><#rt/>
	<#if id!=""> id="${id}"</#if><#rt/>
	<#if url!=""> data-ajax-url="${url}"</#if><#rt/>
	<#if placement!=""> data-placement="${placement}"</#if><#rt/>
	
	>
	<#if value!="">${value}<#else>按钮</#if>
	<#if icon!=""> <span class="glyphicon glyphicon-${icon}" <#if value?trim !="" >style="margin-right:5px"</#if>></span></#if>
	
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
    <li <#include "/include/ui/attributes.ftl"/><#rt/>><#if href !="" ><a href="${href}">${value}</a><#else>${value}</#if></li>
</#macro>



<#--添-->
<#macro addButton value="" icon="plus" class="default" id="addButton${.now?date?string('yyyyMMddhhmmss')}" onclick="" title="添加" url="" openModal="" openModalBefor="">
	<@ms.isPanelNavBtn id="${id}" _id="addButton" class="${class}" _class="default"/>
	<#if url!="">
			<@ms.button icon="${icon}" id="${id}" value="${value} " icon="${icon}"  class="btn btn-${_class}" onclick="location.href='${url}'" title="${title}"/>
	<#else>
		<@ms.button icon="${icon}" id="${id}" value="${value} " icon="${icon}"  class="btn btn-${_class}" onclick="${onclick}" title="${title}"/>
	</#if>
	<#if openModal!="">
		<script>
			$(function() {
					$("#${id}").click(function() {
						<#if openModalBefor!="">
							eval("${openModalBefor}()");
						</#if>
						$("#${openModal}").modal();
					});
			})
		</script>
	</#if>
</#macro>
<#--删-->
<#macro delButton value="" icon="trash" class="danger" id="delButton${.now?date?string('yyyyMMddhhmmss')}" onclick="" title="删除" fieldName="" url="">
	<#if fieldName!="">
		<script>
			$(function() {
				$("#${id}").on("click",function() {
					var ids = "";    
					var params = ""; 
					var count = 0;
					$('input[name="${fieldName}"]:checked').each(function(){    
					   ids += $(this).val() + ",";
					   params += "${fieldName}=" + $(this).val() + "&";
					   count ++;
					});   
					if (count == 0) {
						 <@ms.notify msg="请选择要删除的数据！"/>			
					} else {
						$('.deleteModal${id}').modal();
						$("#deleteModal${id}Num").text(count);
						
						$('.deleteBtn${id}').on("click",function() { 
							<#if onclick?has_content>	
								eval(${onclick}(ids));
							<#elseif url?has_content>
							$(this).request({url:"${url}",type:"json",data:params,method:"post",func:function(msg) {
								if (msg.result) {
									<@ms.notify msg="删除成功！"/>
									location.reload();
								} else {
									<@ms.notify msg="删除失败！"/>
								}
							}});
							</#if>
						});
						
					}
				});				
			})
		</script>
	</#if>	
	<@ms.isPanelNavBtn id="${id}" _id="delButton" class="${class}" _class="danger"/>
	
	<!--删除提示-->    
	<@ms.modal modalName="deleteModal${id}" title="删除提示!">
		  <@ms.modalBody>
		  		确认删除<span style="color: red; font-size: 20px;" id="deleteModal${id}Num"></span>条记录？
	     </@ms.modalBody>
		 <@ms.modalButton>
	 		<@ms.button class="btn btn-danger deleteBtn${id}" value="确定删除"/>
	 	</@ms.modalButton>
	</@ms.modal>	
	
	<@ms.button icon="${icon}" value="${value} " icon="${icon}" id="${id}" class="btn btn-${_class}"  onclick="${onclick}" title="${title}"/>
</#macro>

<#macro editButton value="" icon="edit" class="warning" id="editButton${.now?date?string('yyyyMMddhhmmss')}" onclick="" title="编辑">
	<@ms.isPanelNavBtn id="${id}" _id="editButton" class="${class}" _class="danger"/>
	<@ms.button icon="${icon}" value="${value} " icon="${icon}" id="${id}" class="btn btn-${_class}"  onclick="${onclick}" title="${title}"/>
</#macro>

<#macro queryButton value="查询" icon="search" class="default" id="queryButton${.now?date?string('yyyyMMddhhmmss')}" onclick="" title="查询" form="" >
	<@ms.button class="btn btn-info" value="${value} " icon="${icon}" id="${id}"   onclick="${onclick}" title="${title}"/>
	<#if onclick=="" && form!="">
	<script>
		$(function() {
			$("#${id}").click(function() {
					$("#${form}")[0].submit();
			})
		})
	</script>
	</#if>
</#macro>
<#--返回-->
<#macro backButton value="返回" icon="share-alt" class="default" id="backButton${.now?date?string('yyyyMMddhhmmss')}"  onclick="javascript:history.go(-1)" title="返回">
	<@ms.button  value="${value}" icon="${icon}"  onclick="${onclick}"  class="btn btn-${class}"   title="${title}" id="${id}"/>
</#macro>
<#--保存-->
<#macro saveButton value="保存" icon="floppy-saved" class="default" id="saveButton${.now?date?string('yyyyMMddhhmmss')}" onclick="" title="保存" postForm="" postBefor="" postAfter="">
	<@ms.button icon="${icon}" class="btn btn-success" value="${value} " icon="${icon}" id="${id}"   onclick="${onclick}" title="${title}" />
	<@ms.event postForm="${postForm}"  postBefor="${postBefor}" postAfter="${postBefor}" id="${id}"/>
</#macro>
<#macro updateButton value="更新" icon="open" class="default" id="updateButton" onclick="" title="更新"  postForm="" postBefor="" postAfter="" postForm="" postBefor="" postAfter="">
	<@ms.button icon="${icon}" class="btn btn-success" value="${value} " icon="${icon}" id="${id}"   onclick="${onclick}" title="${title}"/>
	<@ms.event postForm="${postForm}"  postBefor="${postBefor}" postAfter="${postBefor}" id="${id}"/>
</#macro>
<#macro resetButton value="重置" icon="retweet" class="warning" id="resetButton${.now?long}" onclick="" title="重置" form="" >
	<@ms.button icon="${icon}" class="btn btn-warning" value="${value} " icon="${icon}" id="${id}"   onclick="${onclick}" title="${title}"/>
	<script>
	    <#--优先click事件-->
		<#if onclick=="">
		$(function() {
			$("#${id}").click(function() {
				<#if form!="">
					$("#${form}")[0].reset();
				<#else>
					$("#${id}").parents("form:first")[0].reset();
				</#if>
			})
		})
		</#if>
	</script>
</#macro>
<#macro exportButton value="导出" icon="export" class="default" id="exportButton" onclick="" title="导出" >
	<@ms.button icon="${icon}" class="btn btn-default" value="${value} " icon="${icon}" id="${id}"   onclick="${onclick}" title="${title}"/>
</#macro>
<#macro importButton value="导入" icon="import" class="warning" id="importButton" onclick="" title="导入" >
	<@ms.button icon="${icon}" class="btn btn-default" value="${value} " icon="${icon}" id="${id}"   onclick="${onclick}" title="${title}"/>
</#macro>
<#macro setingButton value="设置" icon="cog" class="warning" id="importButton" onclick="" title="设置" >
	<@ms.button icon="${icon}" class="btn btn-primary" value="${value} " icon="${icon}" id="${id}"   onclick="${onclick}" title="${title}"/>
</#macro>

<#macro event postForm=""  postBefor="" postAfter="" id="">
	<#if postForm!="">
		<script>
			$(function() {
				$("#${id}").click(function() {
					var vobj = true;
					try {
						vobj = $("#${postForm}").data('bootstrapValidator').validate().isValid();
					} catch (e){}
					
					var postBefor = true;
						<#if postBefor!="">
							postBefor = eval(${postBefor}()); 
						</#if>
						if(vobj && postBefor) {
						
							$(this).postForm("#${postForm}",{func:function(msg) {
								if (msg.result) {
						     		//history.back();
									 <@ms.notify msg="保存成功！" type="success"/>			
									 var redirect = $("#${postForm} input[name='redirect']").val();
									 if (redirect!="") {
									 	location.href=redirect;
									 }
									 <#if postAfter!="">
									 	eval(${postAfter}(msg));
									 </#if>
									 
						    	}else{
						    		 var message = msg.resultMsg; 
						    		 if (message=="" || message==undefined) {
						    		 	message="后台验证失败";
						    		 }
						    		 $('.ms-notifications').notify({
						    		    type:'warning',
									    message: { text:message }
									 }).show();
						    	}
							}});
					    } else {
							<@ms.notify msg="验证失败，请重新输入！" />
									 
					    }			
				});
			})	
		</script>
	</#if>
</#macro>

<#--按钮组-->
<#macro buttonGroup role="group">
	<div class="btn-group" role="${role}">
		 <#nested/> 
	</div>
</#macro>

<#macro menuButton links name="菜单名称" class="default">
<div class="btn-group dropdown"> 
  <button type="button" class="btn btn-${class}">${name}</button>
  <button type="button" class="btn btn-${class} dropdown-toggle" data-toggle="dropdown"  aria-expanded="false">
    <span class="caret"></span>
    <span class="sr-only"></span>
  </button>
  <ul class="dropdown-menu">
      <#list links as b>
      	<li><a href="javascript:${b.click?default("void")}()">${b.name?default("菜单")}</a></li>
      </#list>
  </ul>
</div>
</#macro>
 
<#macro switchButton name on off size="small" value="" class="" color="default" onclass="danger" offclass="primary">
	<input type="checkbox" class="ms-button-switch-${name}" data-on="${onclass}" data-off="${offclass}" data-size="${size}" data-on-text="${on.text}"  data-off-text="${off.text}" data-off-color="${color}"/>
	<script>
		$(function() {
			<#if value!="">
				<#if value==on.value?string>
					$(".ms-button-switch-${name}").bootstrapSwitch('state', true);
				<#else>
					$(".ms-button-switch-${name}").bootstrapSwitch('state', false);
				</#if>
			<#else>
				$(".ms-button-switch-${name}").bootstrapSwitch('state', true);
			</#if>
			
			$('.ms-button-switch-${name}').on('switchChange.bootstrapSwitch', function(event, state) {
				if (state) {
					$("input[name='${name}']").val('${on.value}');
				} else {
					$("input[name='${name}']").val('${off.value}');
				}
			});
			
		})
	</script>
	<input type="hidden" name="${name}" value="${value}"/>
</#macro>


