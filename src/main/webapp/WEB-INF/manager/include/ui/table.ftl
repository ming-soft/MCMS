
<#--表格列表-->
<#--head:表格头部标题，数值格式-->
<#--head:表格头部标题-->
<#macro table head="" filed="" listItem="" editField="" editJs="" checkbox="" id="" dateformat="yyyy-MM-dd">
 <script>
 	<#if checkbox?has_content>
		$(function() {
			$("input[name='allCheck${checkbox}']").on("click",function(){  
				if(this.checked){   
					$("input[name='${checkbox}']").each(function(){
						this.checked=true;
					});
				}else{   
					$("input[name='${checkbox}']").each(function(){this.checked=false;});   
				}
			});			
		})
	</#if>
 </script>
 <table class="table table-hover">
	<!--表格栏目属性 开始-->
    <thead>
        <tr>
        	<#if checkbox?has_content>
	        	<th class="text-center" width="10">
	        		<input type="checkbox" name="allCheck${checkbox}">
	        	</th>
        	</#if>
        	<#if head?has_content>
				<#list head as h>
						<#if h?html?length gt 5 &&  h?html?substring(0,6)=="&lt;th">
							${h}
						<#elseif h?contains(",") && h?split(",")[1]?eval gt 0>
							<th width="${h?split(",")[1]}">
							${h?split(",")[0]}
							</th>
						<#else>
							<th>
							 	${h}
		        	        </th>
	        	        </#if>
	        	</#list>        	
        	</#if>
        </tr>
        <#if filed?has_content && listItem?has_content>
        	<#list listItem?eval as item>
        		<tr>
        			<#if checkbox?has_content >
        			<td>
        				<input type="checkbox" name="${checkbox}" value="${item[checkbox]}">
        			</td>
        			</#if>
        			<#list filed as f>
	        			<td>
	        					<#if editField?seq_contains(f)>
	        						<a href="javascript:${editJs}(${item[checkbox]})">${item[f]}</a>
	        					<#else>
	        						<#if item[f]?has_content && item[f]?is_date>
	        							${item[f]?string(dateformat)}
	        						<#else>
	        							${item[f]?default('-')}
	        						</#if>
	        					</#if>
	        			</td>
        			</#list>
        		</tr>
        	</#list>
        	<#if listItem?eval?size==0>
	        	<tr>
	        			<td colspan="${filed?size+1}"><@ms.nodata content="暂无数据" /></td>
	        	</tr>
        	</#if>
        </#if>
        	
    </thead>
    <!--表格栏目属性 结束-->
     <tbody id=${id}>
    	<#nested/>
     </tbody>
 </table>
</#macro>