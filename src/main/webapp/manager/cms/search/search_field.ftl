

<#if listFieldName?exists>
	<form id="searchDataForm" action="${base}/html/${websiteId?default()}/${searchId?default()}/search.do" method="post">
		<#if basicCategoryId!=0>
		<input type="hidden" name="categoryId" value="${basicCategoryId}"/> <!--必须存在-->
		</#if>
		<!--表单的name值不能改变-->
	 	<#list listFieldName as search>
	 		<#if search.type?string=="4"><!--数字填写方式:如1-23表示区间查询1表示等值查询--></#if>
	 		<#if search.name=="columnId">
	 			<#if basicCategoryId!=0>
	 			<input type="text" name="categoryId" value="${basicCategoryId}"/>
	 			</#if>
	 		<#else>
	 		<input type="text" name="${search.name}"/>
	 		</#if>
	 		
		</#list>	
		<input type="submit" value="搜索">
	</form>
</#if>

