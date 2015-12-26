<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/> <!--调用head内样式信息-->
<script type="text/javascript" src="${base}/jquery/zTree_v3/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="${base}/jquery/zTree_v3/zTreeStyle.css" type="text/css">
</head>
<style>
	.container{margin:0;padding:0;width:auto}
	hr{margin-top:9px;margin-bottom:9px;padding:0;}
	.rowpadding3{padding-bottom: 3px;}
	.ms-button-group{padding:0px 0px 8px 0px}
	.row {margin-left:0;margin-right:0}
	.form-horizontal .form-group{margin-left:0;margin-right:0}
	.form-group{overflow: hidden;}
	.bs-example>.dropdown>.dropdown-menu {position: static;margin-bottom: 5px;clear: left;}
	.bs-example>.dropdown>.dropdown-toggle {float: left;}
	.padding-zero{padding:0;}
	.link-style a:hover{color:#000;}
	.link-style a:visited{color:#000;}
	.form-inline .form-group {display: inline-block;margin-bottom: 0;vertical-align: middle;}
	#tableArticle .updateArticle {cursor: pointer;}
	#menuBtn{margin:0}
	#menuContent {
		overflow: auto;
		max-height: 240px;
		display: none;
		z-index: 999;
		position: absolute;
		float: left;
		padding: 5px 0;
		margin: 2px 0 0;
		background-color: #ffffff;
		border: 1px solid rgba(0, 0, 0, 0.15);
		border-radius: 4px;
		-webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
		box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
		background-clip: padding-box;
	}
	select, option,#menuBtn{
		cursor: pointer;
		background: white;
	}
	.selColumn{min-width:173px; height:34px;}
	.categoryTree{border-right:1px solid #eeeeee;padding:0;}
</style>
<script>
	
</script>
<body>
	<!----------------------------------- bootstarp 布局容器 开始-------------------------------->	
	<div class="container-fluid link-style">
		<div class="row">
			<div class="col-md-2 categoryTree">
					<ul id="categoryTree" class="ztree" style="margin-top:0; width:100%;margin-left:-9px">
			</div>
			<!--右侧内容编辑区域开始-->
			<div class="col-md-10" style="margin-top:0;padding:0;margin:0">
				<!--------内容 部分  开始-------->
				<div class="row" style="margin-top:0; width:100%;;padding:0 0 0 10px;margin:0">
					<iframe src="${base}/manager/basic/0/list.do" style="width:100%;maring:0;padding:0;border:none;height:100%" id="listFrame" target="listFrame" ></iframe>
				</div>
				<!--内容部分结束-->
			
			</div>
			<!--右侧内容编辑区域结束-->
		
		</div>
	
	</div>

	
	<!--引用弹出框插件-->
	<@warnModal modalName="Model"/>
	<!--JQ特效部分-->
	<script>
		$(function(){	
			$(".categoryTree").height($(document).height());
			
			$("#listFrame").height($(document).height());
			//zTree框架	
			var setting = {
				callback: {
					onClick: function(event, treeId, treeNode) {
							if(treeNode.id>0) {
								$("#listFrame").attr("src","${base}/manager/basic/"+treeNode.id+"/list.do?categoryTitle="+encodeURIComponent(treeNode.name));
							}
					}
				},
				view: {
					dblClickExpand: dblClickExpand 
				},
				data: {
					simpleData: {
						enable: true
					}
				}
			};
	
			function dblClickExpand(treeId, treeNode) {
				return treeNode.level > 0;
			}
	
			$(document).ready(function(){
				$.fn.zTree.init($("#categoryTree"), setting, zNodes);
			});
			
			//获取栏目节点列表
			var listColumn=${listCategory};
			var zNodes = new Array();
			
			//遍历节点，添加到数字中
			for( var i = 0 ; i < listColumn.length; i++){
				zNodes[i] = { id:listColumn[i].categoryId, pId:listColumn[i].categoryCategoryId,name:listColumn[i].categoryTitle, open:false};
			}
		});
		
	</script>
</body>
</html>
