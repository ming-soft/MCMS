<#include "ui/index.ftl"/>
<#global autoCURD=""/>
<#macro autoCURD>
	<#if  baseUrl?split("/")?last == "add.do">
		<#global autoCURD="save">
	<#elseif baseUrl?split("/")?last =="edit.do">
		<#global autoCURD="update">
	</#if>
</#macro>
<@ms.autoCURD/>

<#--权限控制-->
<#--link:必须 type:add/del/edit/query class:样式 id,value:显示文字-->
<#macro auth link type="" value="" class="" id="">
	<@shiro.hasPermission name="${link}">
		<#if type=="add">
			<@ms.panelNavBtnAdd id="${id}" value="${value}" class="${class}"/>
		<#elseif type=="del">
			<@ms.panelNavBtnDel id="${id}" value="${value}" class="${class}"/>
		<!--
		<#elseif type=="edit">
			<@ms.panelNavBtnDel id="${id}" value="${value}" class="${class}"/>
			-->
		<#else>
			<a href="${link}" class="${class}">${value}</a>
		</#if>
	</@shiro.hasPermission>
</#macro>

<#--分页-->
<#macro showPage page displayedPages="5" edges="3">
<#if page?exists && page.pageCount gt 1>
	<nav class="pageNav">
	<ul class="pagination pull-right" id="pagination">
		<#if displayedPages?has_content && edges?has_content>
		
			<script type="text/javascript" src="${base}/js/manager/page.js"></script> 
			<script>
				$(function(){
					$('#pagination').pagination({
						pages: ${page.pageCount},
						cssStyle: 'pagination pull-right',
						displayedPages: ${displayedPages?default(1)},
						hrefTextPrefix:"${page.linkUrl}pageNo=",
						currentPage:${page.pageNo+1},
						edges:<#if edges?has_content>${edges?default(3)}<#else>3</#if>
					});
				})
			</script>
			
		<#else>
			<#--格式 <（上一页） 1 2 3 4 >(下一页) -->
			<li class="prev <#if (page.pageNo+1)==1> disabled" ><a<#else> "><a href="${page.previousUrl}" </#if> target="_self"><i class="fa fa-angle-left">上一页</i></a></li>
				<#list 1..page.pageCount as i>
					<li <#if page.pageNo+1==i>class="active" ><a<#else> ><a href='${page.linkUrl}pageNo=${i}'</#if>  target="_self">${i}</a></li>
				</#list>
			<li class="next <#if page.pageNo+1 == page.pageCount>disabled" ><a<#else> "><a href="${page.nextUrl}"</#if>  target="_self"><i class="fa fa-angle-right">下一页</i></a></li>
		</#if>
	</ul>
	</nav>
	
</#if>
</#macro>
<#macro method>
	${baseUrl}
</#macro>



