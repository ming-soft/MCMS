<#--后台的UI界面通用区域定义-->

<#--主体结构-->
<#macro content>
	<div class="ms-content">
		<#nested/>
	</div>
</#macro>

<#--左侧菜单-->
<#macro contentMenu>
   <div class="ms-content-menu">
   		<#nested/>
    </div>
</#macro>

<#--内容-->
<#macro contentBody width="100%" style="">
   <div class="ms-content-body" style="width:${width};${style}">
   		<#nested/>
    </div>
</#macro>
<#--内容导航-->
<#--button:格式为map 例如:button={"text":标题,"link":默认返回}-->
<#macro contentNav title="板块名称">
    <div class="ms-content-body-title">
        <span>${title}</span>
        <#nested/>
    </div>
</#macro>

<#--搜索按钮组-->
<#macro searchBtnGroup size="1">
    <@ms.col size="${size}" style="text-align:right;border-top: 1px #EAEAEA solid;padding-top: 10px;">
        <#nested/>
    </@ms.col>
</#macro>

<#-- 分割线-->
<#macro panelNav empty=
false>
    <div class="ms-content-body-panel-nav"  <#if empty>style="  padding: 0;"</#if>>
        <#nested/>
    </div>
</#macro>
<#--列表上面导航条右侧的过滤按钮区域 右浮动  -->
<#macro panelNavFilter>
      <div style="float:right;">
        <#nested/>
    </div>
</#macro>
<#--列表按钮组  如下拉菜单-->
<#macro panelNavBtnGroup role="group" btn="" >
	<div class="btn-group" role="${role}">
		 <#nested/> 
	</div>
</#macro>
<#-- 判断按钮的传入参数是否为空值 -->
<#macro isPanelNavBtn class _class id _id>
	<#assign _id="${_id}"/>
	<#if id?has_content>
		<#assign _id="${id}" />
	</#if>
	
	<#assign _class="${_class}">
	<#if class?has_content>
		<#assign _class="${class}">
	</#if>
</#macro>
<#macro panelNavBtnAdd value="" icon="plus" class="default" id="addButton" onclick="" title="新增">
	<@ms.isPanelNavBtn id="${id}" _id="addButton" class="${class}" _class="default"/>
	<@ms.button icon="${icon}" id="${_id}" value="${value} " icon="${icon}"  class="btn btn-${_class}" onclick="${onclick}" title="${title}"/>
</#macro>
<#macro panelNavBtnDel value="" icon="trash" class="danger" id="delButton" onclick="" title="删除">
	<@ms.isPanelNavBtn id="${id}" _id="delButton" class="${class}" _class="danger"/>
	<@ms.button icon="${icon}" value="${value} " icon="${icon}" id="${id}" class="btn btn-${_class}"  onclick="${onclick}" title="${title}"/>
</#macro>
<#macro contentNavBack value="返回" icon="share-alt" class="default"  onclick="javascript:history.go(-1)" title="返回">
	<@ms.button  value="${value}" icon="${icon}"  onclick="${onclick}"  class="btn btn-${class}"   title="${title}"/>
</#macro>
<#macro panelNavBtnSave value="保存" icon="disk" class="default" id="saveButton" onclick="" title="保存" >
	<@ms.button class="btn btn-success" value="${value} " icon="${icon}" id="${id}"   onclick="${onclick}" title="${title}"/>
</#macro>
<#---->
<#macro contentPanel style="">
    <div class="ms-content-body-panel" style="${style}"> 
   		<#nested/>
    </div>
</#macro>

<#--模态框按钮区域-->
<#macro modalButtonarea>
	<div class="modal-footer">
			<#nested/>
	</div>
</#macro>

<#--警告的模态框-->
<#macro warn  modalName>
	<div id="warn${modalName}Dialog" class="modal fade  ${modalName}" tabindex="-1" data-focus-on="input:first">
	 <div class="modal-dialog">
	    <div class="modal-content">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title"  id="warn${modalName}Title">警告！</h4>
		</div>
		<div class="modal-body"  id="warn${modalName}Body">
			<#nested/>
		</div>
		<div class="modal-footer">
			<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
			<button type="button"  id="warn${modalName}Ok" class="btn btn-primary right" >确定</button>
		</div>
		</div>
	 </div>
	</div>	
</#macro>

<#--模块框-->
<#macro modal modalName title="标题" style="" resetFrom=true>
	<div class="modal fade ${modalName}" id="${modalName}Dialog" >
	  <div class="modal-dialog"  style="${style}">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="${modalName}Title">
	       	${title}
	        </h4>
	      </div>
				<#nested/>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<script>
		
	<#if resetFrom>
		$(function(){
			$('#${modalName}Dialog').on('hide.bs.modal', function (event) {
			  if ($("#${modalName}Dialog form").length>0) {
			  	$("#${modalName}Dialog form").data('bootstrapValidator').resetForm(true);
			  }
			})	
		});
	</#if>
		
	</script>
</#macro>

<#--模态框内容-->
<#macro modalBody>
	      <div class="modal-body">
	      	<#nested/>
	      </div>
</#macro>

<#--模态框按钮区域-->
<#macro modalButton>
	       <div class="modal-footer">
	      	<#nested/>
	      </div>
</#macro>

<#--整行-->
<#macro row>
	<div class="row">
	<#nested/>
	</div>
</#macro>

<#--整列-->
<#macro col size="1" style="">
	<div class="col-md-${size} col-sm-${size}" style="${style}">
		<#nested/>
	</div>
</#macro>

<#--提示没有数据-->
<#macro nodata content="暂无数据" style="text-align:center">
	<p class="alert alert-info" role="alert" style="${style}">
		${content}
	</p>
</#macro>


<#--表格列表-->
<#macro table head="" list="" id="" >
 <table class="table table-hover">
	<!--表格栏目属性 开始-->
    <thead>
        <tr>
        
        	<#if head?has_content>
				<#list head as h>
						<#if h?html?length gt 5 &&  h?html?substring(0,6)=="&lt;th">
							${h}
						<#else>
							<th>
							 	${h}
		        	        </th>
	        	        </#if>
	        	</#list>        	
        	</#if>
        	
        </tr>
    </thead>
    <!--表格栏目属性 结束-->
     <tbody id=${id}>
    	<#nested/>
     </tbody>
 </table>
</#macro>





