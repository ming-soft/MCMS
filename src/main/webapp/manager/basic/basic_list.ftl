<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/> <!--调用head内样式信息-->
<script type="text/javascript" src="${base}/jquery/zTree_v3/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="${base}/jquery/zTree_v3/zTreeStyle.css" type="text/css">
</head>
<style>
	.container{margin:0;padding:0;width:auto}
	.row {margin-left:0;margin-right:0}
</style>
<script>
	
</script>
<body>
	<!----------------------------------- bootstarp 布局容器 开始-------------------------------->	
	<div class="container-fluid link-style">
		<div class="row">
			<div></div>
			
			<!--右侧内容编辑区域开始-->
			<diiv class="col-">
			
		<!--顶部   开始-->
		<div class="row rowpadding3">
			<div class="col-md-12">
				<h3 class="page-title bottomLine">
					<#if model_title_session?has_content>${model_title_session}<#else>全部</#if><small><#if articleShow?has_content>列表<#else>查询结果</#if></small>		            
				</h3>
			</div>
		</div>
		<!--顶部  结束-->
		<hr>
		<!--------内容 部分  开始-------->
		<div class="row" id="articlePage">
					<!--功能按键部分 开始-->
					<div class="form-group">
						<button type="button" class="btn btn-success col-md" id="addButton">新增${model_title_session}&nbsp;<span class="glyphicon glyphicon-plus"></span></button>
						<button type="button" class="btn btn-danger btn-md" id="allDelete">批量删除 <span class="glyphicon glyphicon-trash"></button>
					</div>
					<!--功能按键部分 结束-->
					<!--搜索框  开始-->
					<div class="form-inline form-group searchForm" role="form">
						<div class="form-group">
							<label for="kayword" class="sr-only">关键字</label>
							<input type="text" class="form-control" name="keyword" placeholder="输入关键字" value="${keyword?default('')}">
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-primary" id="search">搜索</button>
						</div>
					 </div>	
					<!--搜索框的使用 结束-->
			
						<!--列表 开始-->
						<table class="table table-bordered">
							<!--表格栏目属性 开始-->
					        <thead>
					        	<tr>
					        		<td colspan="8" class="text-left">
				                     	<i class="glyphicon glyphicon-pushpin"></i>
				                     	<strong>${categoryTitle?default("")}列表</strong>
					        		</td>
					        	</tr>
						        <tr>
						        	<th class="col-md-1 text-center">
						        		<label   data-toggle="tooltip" title="" data-original-title="点击全选">
						        			<input type="checkbox" id="allCheck" value="全选">
						        		</label>
						        	</th>
						        	<th class="col-md-1 text-center" >ID</th>
						            <th class="col-md-7 text-left" >${model_title_session}</th>
						            <th class="col-md-4 text-center">操作</th>
						        </tr>
					        </thead>
					        <!--表格栏目属性 结束-->
					        <!--表格内容  开始-->
					        <tbody>
					        <#if basicList?has_content>
					        	<#list basicList as basic>
					        	<tr id="tableArticle">
					        	<td class="text-center">
										<input type="checkbox" name="checkbox" value="${basic.basicId?default(0)}">
					            </td>
					        	<td class="text-center articleId" >${basic.basicId?default(0)}</td>
					            <td class="text-left" >
					            	${basic.basicTitle?default("")}
					            </td>
					            <td class="text-center" >
				                    <a class="btn btn-xs red tooltips del-btn deleteArticle" href="javascript:void(0)" data-toggle="tooltip" data-url="/manager/basic/${basic.basicId?default(0)}/delete.do" data-original-title="删除" data-id="${basic.basicId?default(0)}">
				                     <i class="glyphicon glyphicon-trash"></i>
				                    </a>
				                    <a class="btn btn-xs red tooltips  updateArticle" href="javascript:void(0)" data-toggle="tooltip"  data-original-title="修改" data-id="${basic.basicId?default(0)}">
				                     <i class="glyphicon glyphicon-pencil"></i>
				                    </a>
								</td>
					          </tr>
					           </#list>
					           <#else>
					            <#if articleShow?has_content>
					             	<tr>
						            <td colspan="5" class="text-center">
						            	<p class="alert alert-info" role="alert" style="margin:0">
						            		<span class="glyphicon glyphicon-plus"></span>
						            		<a href="${base}/manager/cms/article/add.do" class="alert-link">
						            		您还没有添加文章，点击添加文章
						            		</a>
									  	</p>
									</td>
						          </tr>
						           <#else>
						          <tr>
						            <td colspan="5" class="text-center">
						            	<p class="alert alert-info" role="alert" style="margin:0">
						            		<span class="glyphicon glyphicon-plus"></span>
						            		没有数据！  
									  	</p>
									</td>
						          </tr>
					         	</#if>	
					        </#if>
						</tbody>
					</table>
				</div>
				<!--列表结束-->
				
					<!--分页样式 开始-->
					<div class="container-fluid">
						<#if page?has_content>
							<@showPage page=page/>
						</#if>	
					</div>
					<!--分页样式 结束-->			
			
			</div>
			<!--右侧内容编辑区域结束-->
		</div>
	
	</div>

	
	<!--引用弹出框插件-->
	<@warnModal modalName="Model"/>

	<!--JQ特效部分-->
	<script>
		
		$(function(){	
			
			//添加文章
			$("#articlePage").delegate("#addButton","click",function(){
				location.href = base+"/manager/basic/add.do?categoryId=${categoryId?default(0)}&categoryTitle=${categoryTitle?default(0)}"; 
			});
			
			//编辑文章
			$("#articlePage").delegate("table tr td .updateArticle","click",function(){
				var id = $(this).attr("data-id");
				location.href = base+"/manager/basic/"+id+"/edit.do";
			});
			
			//返回文章列表
			$("#articlePage").delegate("#returnButton","click",function(){
				location.href = base+"/manager/basic/list.do";
			});
			
			//点击搜索进行文章搜索
			$("#articlePage").delegate("#search","click",function(){
				var columnId=$('[name="basicCategoryId"]').val();
				var articleType=$(".searchForm .attribute").val();
				var keyword =  $('[name="keyword"]').val();
				
				location.href = base+"/manager/basic/${categoryId?default(0)}/list.do?keyword="+keyword+"&articleType="+articleType;
			});
		    //启用工具提示
		   	$("[data-toggle='tooltip']").tooltip();
		   	
		   	//全选
		   	$("#allCheck").click(function(){  
				if(this.checked){   
					$("input[name='checkbox']").each(function(){this.checked=true;});
				}else{   
					$("input[name='checkbox']").each(function(){this.checked=false;});   
				}
			}); 
			
			//多选删除
			$("#allDelete").click(function(){
					warnModel("确定要删除？","批量删除<#if model_title_session?has_content>${model_title_session}</#if>","allRight()");
			});
		});
		
		//批量删除
		function allRight(){
		//将checkbox序列化
				var checkboxData = $("input[name='checkbox']").serialize();
				if(checkboxData!=""){
					$.ajax({ 
						type: "POST", 
						url: base+"/manager/basic/allDelete.do",
						data: checkboxData,
						dataType:"Json",
		    			success: function(msg){
		    				
		    				if (msg.result) {
		    					alert("批量删除成功！")
		    				 	history.go(-1);
		    				} else {
		    					alert("批量删除失败");
		    				}
		    				    				
		    			},
		    		});
		    	}else{
		        	alert("请选择文章！");
		        }
		} 
	</script>
</body>
</html>
