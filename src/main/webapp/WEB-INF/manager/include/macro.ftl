<#include "/include/ui/index.ftl"/>
<#global autoCURD=""/>
<#macro autoCURD>
	<#local url=baseUrl?split("?")?first?split("/")?last/>
	<#if  url == "add.do">
		<#global autoCURD="save">
	<#elseif url =="edit.do">
		<#global autoCURD="update">
	</#if>
</#macro>
<@autoCURD/>

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
<#macro pagehelper page displayedPages="5" edges="3" url="">
<#if page?exists && page.pages gt 1>
	<nav class="pageNav">
	<ul class="pagination pull-right" id="pagination">
			<#--格式 <（上一页） 1 2 3 4 >(下一页) -->
			<li class="prev <#if (page.pageNum)==1> disabled" ><a<#else> "><a href="${url}&pageNo=${page.pageNum-1}" </#if> target="_self"><i class="fa fa-angle-left">上一页</i></a></li>
				<#list 1..page.pages as i>
					<li <#if page.pageNum==i>class="active" ><a<#else> ><a href='${url}&pageNo=${i}'</#if>  target="_self">${i}</a></li>
				</#list>
			<li class="next <#if page.pageNum == page.pages>disabled" ><a<#else> "><a href="${url}&pageNo=${page.pageNum+1}"</#if>  target="_self"><i class="fa fa-angle-right">下一页</i></a></li>
	</ul>
	</nav>
	
</#if>
</#macro>


<#--分页-->
<#macro showPage page displayedPages="5" edges="3">
<#if page?exists && page.pageCount gt 1>
	<nav class="pageNav">
	<ul class="pagination pull-right" id="pagination">
		<#if displayedPages?has_content && edges?has_content>
		
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



