<#--4.5.5版本该文件废弃->
<#--后台的UI界面通用区域定义 -->
<#macro html5 width="100%" style="">
<!DOCTYPE html>
<html lang="en">
	<head>
		<#include "/manager/include/macro.ftl"/>
		<#include "/manager/include/meta.ftl"/>
	</head>
	<body>
		<div class="ms-content">
				<div class="ms-content-body" style="width:${width};${style}">
		   			<#nested/>
		   		</div>
		</div>
	</body>
</html>
</#macro>

<#macro panel style="">
	    <div class="ms-content-body-panel" style="${style}"> 
	   		<#nested/>
	    </div>
</#macro>

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
<#macro left>
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
<#macro panelNav empty=false>
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


<#macro panelNavBtnAdd value="" icon="plus" class="default" id="addButton" onclick="" title="">
	<@ms.isPanelNavBtn id="${id}" _id="addButton" class="${class}" _class="default"/>
	<@ms.button icon="${icon}" id="${_id}" value="${value} " icon="${icon}"  class="btn btn-${_class}" onclick="${onclick}" title="${title}"/>
</#macro>
<#macro panelNavBtnDel value="" icon="trash" class="danger" id="delButton" onclick="" title="">
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
<#macro table head="" list="" id="">
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





