<@ms.html5>
	<@ms.nav title="文章列表" back=true></@ms.nav>
	<@ms.panel>
				<@ms.searchForm   name="searchForm" action="">
							<#if articleTypeList?has_content>
								<@ms.select label="文章属性"     name="articleType" id="forumSelect"  list=articleTypeList  listValue="value"   listKey="key"    value="${articleType?default('')}"/>
							<#else>
								<@ms.select label="文章属性"     name="articleType" id="forumSelect" value="" list=["默认属性"]  />
							</#if>
							<@ms.text label="关键字"  name="keyWord" value="" title="请输入关键字"  placeholder="请输入关键字" value="${keyword?default('')}"/>
							<@ms.searchFormButton>
								<@ms.queryButton id="submitSearch"/>								
							</@ms.searchFormButton>
				</@ms.searchForm>
				
				<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						<@ms.panelNavBtnAdd title=""/>
						<@ms.panelNavBtnDel title=""/>
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
				<@ms.table head=["<th class='text-center'>编号</th>",'文章标题,300','栏目名,150','作者,90','<th class="text-center">点击量</th>','<th class="text-center">排序</th>'] checkbox="ids">
					<#if listArticle?has_content>
			        	<#list listArticle as listArticle>
		                	<tr id="tableArticle">
					        	<td>
									<input type="checkbox" name="ids" value="${listArticle.basicId?c?default(0)}">
					            </td>
					        	<td class="articleId text-center" >${listArticle.basicId?c?default(0)}</td>
					            <td>
					            	<a style="cursor: pointer;">
				            			<span class="updateArticle" data-toggle="tooltip"  data-original-title="点击修改文章" data-id="${listArticle.basicId?c?default(0)}">
				            				<#if keyword?has_content>
				            					${listArticle.basicTitle?default("无标题")?replace(keyword,"<font color='red'>"+keyword+"</font>")}
				            				<#else>
				            					${listArticle.basicTitle?default("无标题")}
				            				</#if>
					            			<span style="color:red">
					            				<#if articleTypeList?has_content>
						        					<#list articleTypeList as at>
						        						<#if at.key?default("")?string?trim == listArticle.articleType?default("")?string?trim?replace(","," ")>
						        							[${at.value}]
			  											<#break>
				  										</#if>
						        					</#list>
					        					</#if>
					        				</span>
				            			</span>
					            	</a>
					            </td>
					            <td><#if listArticle.column?exists>${listArticle.column.categoryTitle?default("")}</#if></td>
					            <td>${listArticle.articleAuthor?default("无作者")}</td>
					            <td class="text-center">${listArticle.basicHit?c?default(0)}</td>
					            <td class="text-center">${listArticle.basicSort?c?default(0)}</td>
			          		</tr>
					   </#list>
			      	<#else>
		            <#if articleShow?has_content>
		             	<tr>
				            <td colspan="8" class="text-center">
				            	<@ms.nodata content="暂无文章"/>
							</td>
			          	</tr>
			        <#else>
			          	<tr>
			            	<td colspan="8" class="text-center">
				            	<@ms.nodata content="没有搜索到文章"/>
							</td>
			          	</tr>
		         	</#if>	
		        </#if>
				</@ms.table>
				<!--分页样式 开始-->
				<#if page?has_content>
					<@ms.pagehelper page=page url="${managerPath}/cms/article/${categoryId}/list.do?${params}"/>
				</#if>	
	</@ms.panel>
</@ms.html5>	
<!--删除限时文章-->    
<@ms.modal modalName="delete" title="删除文章">
	  <@ms.modalBody>
	  		确定要删除所选的文章吗?
     </@ms.modalBody>
	 <@ms.modalButton>
 		<@ms.button class="btn btn-danger rightDelete" value="确定"/>
 	</@ms.modalButton>
</@ms.modal>			
<script>
	$(function(){	
		var listTitle="<#if categoryTitle?has_content>${categoryTitle}<#else>全部</#if>&nbsp;<small><#if articleShow?has_content>列表<#else>查询结果</#if></small>";
		$(".ms-content-body-title>span").html(listTitle);
		//预览文章
		/*$(".preview").click(function(){
			var articleId = $(this).attr("data-id");
			var viewAction = articleId+"detail.do"
			window.open(base+"${baseManager}/cms/generate/"+viewAction+"/viewIndex.do");
		});*/
		//添加文章
		$("#addButton").click(function(){
			location.href = base+"${baseManager}/cms/article/add.do?categoryId=${categoryId?default(0)}&categoryTitle=${categoryTitle?default('')}"; 
		});	
		//编辑文章
		$(".updateArticle").click(function(){
			var id = $(this).attr("data-id");
			location.href = base+"${baseManager}/cms/article/"+id+"/edit.do";
		});	
		//全选
	   	$("input[name='allCheck']").on("click",function(){  
			if(this.checked){   
				$("input[name='ids']").each(function(){this.checked=true;});
			}else{   
				$("input[name='ids']").each(function(){this.checked=false;});   
			}
		});		
		//筛选文章
		$("#submitSearch").click(function(){
			var articleType=$("#forumSelect").val();
			var keyword =  $('[name="keyWord"]').val();
			location.href = base+"${baseManager}/cms/article/${categoryId?default(0)}/list.do?keyword="+keyword+"&articleType="+articleType;
		});
		//点击重置按钮
		$(".reset").click(function(){
			$("input[name=keyWord]").val("");
		})
	   	var articleId="";//单个文章id
	   	var ids ="";//多个文章id
		
		//多选删除
		$("#delButton").click(function(){
			ids = $("input[name='ids']").serialize();
			if(ids!=""){
				$(".delete").modal();
			}else{
				alert("请选择文章!");
			}
		});
		//删除多个文章
		$(".rightDelete").click(function(){
			if(ids=="" && articleId!="" ){
				ids= "ids="+articleId;
			}
			deletes(ids);
		});

	});
	//删除文章
	function deletes(ids){
		if(ids!=""){
			$(this).request({url:base+"${baseManager}/cms/article/delete.do",type:"json",data:ids,method:"post",func:function(msg) {
				if (msg.result) {
					alert("删除成功！")
					location.reload();
				} else {
					alert("删除失败");
				}
			}});
		}else{
	    	alert("请选择文章！");
	    }
	}
</script>













