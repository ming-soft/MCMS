<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/>
<script type="text/javascript" src="${base}/jquery/zTree_v3/jquery.ztree.all-3.5.min.js"></script>
<link rel="stylesheet" href="${base}/jquery/zTree_v3/zTreeStyle.css" type="text/css">
<style>
	.container{margin:0;padding:0;width:auto}
	 hr{margin-top:9px;margin-bottom:9px;padding:0;}
	.ms-button-group{padding:0px 0px 8px 0px}
	.row {margin-left:0;margin-right:0}
	.form-horizontal .form-group{margin-left:0;margin-right:0}
	.form-group{overflow: hidden;}
	.bs-example>.dropdown>.dropdown-menu {position: static;margin-bottom: 5px;clear: left;}
	.bs-example>.dropdown>.dropdown-toggle {float: left;}
	.padding-zero{padding:0;}
	/*链接样式*/
	.link-style a:hover{color:#000;}
	.link-style a:visited{color:#000;}
	.operate a:visited{color:#428BCA;}
	.form-inline .form-group {display: inline-block;margin-bottom: 0;vertical-align: middle;}
	.dedeteRight{width: 32%;margin: 0 auto;overflow: hidden;}
	/*弹出窗口样式*/
	#WindowDialog .modal-dialog{width:auto;}
	.control-label{font-weight:normal;font-size:14px;}
	.margin20{ margin-top:20px;}
	.marginleft35{ margin-left:-35px;}
	.has-error .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#A94442;}
	.has-success .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#3C763D;}
	.form-control{ padding-right:22px;} 
</style>
</head>
<body>
	<!-- bootstarp 布局容器 开始 -->	
	<div class="container-fluid link-style">
		<!--顶部   开始-->
		<div class="row">
			<div class="col-md-10">
				<h3 class="page-title bottomLine">
					数据管理  <small>导入织梦数据</small></h3>
				</h3>
			</div>
		</div>
		<!--顶部  结束-->
		<hr>
		
		<div class="row margin20">
			<!---手动数据库连接开始-->
			<div class="col-md-4 connectionForm" style="border-right: 1px solid #ccc;">
				
					<div class="form-group">
						<h4><strong>远程数据链接</strong></h4>
					</div>
			
					<form action="${base}/manager/cms/dede/connection.do" class="form-horizontal" id="remoteDataForm">
						<input type="hidden" id="remoteColumnId" name="remoteColumnId"/>
						<input type="hidden" id="localColumnId" name="localColumnId"/>
						<div class="form-group">
							<label class="col-md-5 control-label ">主机名/IP地址:</label>
							<div class="col-md-7 ">
								<input type="text" class=" form-control" placeholder="请输入主机名/IP地址" name="ipAddress" >
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-5 control-label ">数据库名称:</label>
							<div  class="col-md-7 ">
								<input type="text" class=" form-control" placeholder="请输入数据库名称" name="databaseName" >
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-5 control-label ">表前缀:</label>
							<div class="col-md-7 ">
								<input type="text" class=" form-control" placeholder="请输入表前缀" value="dede" name="prefixName">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-5 control-label ">端口号:</label>
							<div class="col-md-7 ">
								<input type="text" class=" form-control" placeholder="请输入端口号" value="3306" name="port">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-5 control-label " for="nickName">用户名:</label>
							<div class="col-md-7 ">
								<input type="text" class=" form-control" placeholder="请输入用户名" name="userName" >
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-5 control-label " for="nickName">密码:</label>
							<div class="col-md-7 ">
								<input type="text" class=" form-control" placeholder="请输入密码" name="userPassword" >
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-5 control-label "></label>
							<div class="col-md-7 ">
								<button type="button"class="btn btn-success btn-md" id="connection">连接</button>
								<button type="button"class="btn btn-danger btn-md" id="close" style="display:none;">关闭连接</button>
							</div>
						</div>
					</form>				
			
			</div>
			<!---手机数据库连接结束-->
			
			<!--栏目显示区域开始-->
			<div class="col-md-3">
					<div class="form-group">
						<h4><strong>远程栏目</strong></h4>
					</div>		
					<ul id="remoteColumnTree" class="ztree">
						<div class="alert alert-warning" role="alert" style="line-height:40px;text-align:center">未连接到远程数据库</div>					
				    </ul>
			</div>
			<div class="col-md-3 importBorder" style="line-height:200px;border-left: 1px solid #ccc;border-right: 1px solid #ccc;text-align: center;height:100%;width:10%">
				<button type="button" class="btn btn-primary btn-xs" id="startImport" disabled="disabled">导入>></button>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<h4><strong>本地栏目</strong></h4>
				</div>				
				<ul id="localColumnTree" class="ztree"></ul>
			</div>
			<!--栏目显示区域结束-->
			
		</div>
		
	</div>
	<script type="text/javascript">
			var setting = {
				callback: {
					onClick: function(event, treeId, treeNode) {
						$("#remoteColumnId").val(treeNode.id);
					}
				},
				data: {
					simpleData: {
						enable: true
					}
				}
			};		
			
			var localTreeSetting = {
				callback: {
					onClick: function(event, treeId, treeNode) {
						localId = treeNode.id;
						$("#localColumnId").val(treeNode.id);
					}
				},
				data: {
					simpleData: {
						enable: true,
					}
				},
			};		
			
			var nodes = new Array();
			var localColumn = ${localColumnList?default("")};	
			for (i=0;i<localColumn.length;i++)  {
				nodes[i] = {id:localColumn[i].categoryId,pId:localColumn[i].categoryCategoryId,name:localColumn[i].categoryTitle};
			}
		   $.fn.zTree.init($("#localColumnTree"), localTreeSetting,nodes);
	
		$(function () {	
			$("#startImport").attr("disable","disable");
			$(".importBorder").height($(document).height());
			$(".connectionForm").height($(document).height());
			//连接数据库
			$("#connection").on("click",function(){
				var formData = $("#remoteDataForm").serialize();
				$.ajax({
				   type: "post",
				   dataType: "json",
				   url:  $("#remoteDataForm").attr("action"),
				   data: formData, 
				   beforeSend:function() {
				   		$("#connection").text("正在连接...");
				   },
				   success: function(msg){ 
			   			if(msg) {
			   				//如果连接成功则进行表单禁用和数据展示
			   				if(msg.result){
			   					$.fn.zTree.init($("#remoteColumnTree"), setting, msg);$.fn.zTree.init($("#remoteColumnTree"), setting, msg);
			   					$("#connection").hide();
			   					$("#close").show();
			   					
			   					//禁用所有的属于表单
			   					$("input").attr("readonly","readonly");
			   				}else{
			   					alert("连接不成功，请重新输入");
			   					$("#connection").text("连接");
			   				}
			   				
			   				$("#startImport").removeAttr("disabled")
			   				
			   				
			   			} else {
			   				alert("连接不成功，请重新输入");
			   			}
				   },
				   error:function(){ 
     				 alert("操作远程数据库发生异常");
     				 $("#connection").text("连接"); 
   				  } 
				});
			});
			
			//点击开始导入
			$("#startImport").on("click",function(){
				var formData = $("#remoteDataForm").serialize();
				if (parseInt($("#remoteColumnId").val())<=0 || parseInt($("#localColumn").val())<=0) {
					alert("请选择栏目");
					return;
				}
				$.ajax({
				   type: "post",
				   dataType: "json",
				   beforeSend:function() {
				   		$("#startImport").text("导入中...");
				   },
				  data:formData,
				   url:  "${base}/manager/cms/dede/importData.do",
				   success: function(msg){ 
				   		if (msg!=""){
				   			if (msg.result) {
				   				alert("导入成功");
				   			} else {
				   				alert("导入失败");
				   			}
				   			$("#startImport").text("导入>>");
				   		}
				   }
				});
			});
			
			//数据库链接关闭
			$("#close").on("click",function(){
				$.ajax({
				   type: "post",
				   dataType: "json",
				   url:  "${base}/manager/cms/dede/close.do",
				   success: function(msg){ 
				   		if(msg){
			   				alert("链接关闭成功");
			   				//禁用所有的属于表单
			   				$("input").removeAttr("readonly");
			   				$("#connection").show();
			   				$("#close").hide();			   				
			   				$("#startImport").attr("disabled","true");
			   				$("#connection").removeAttr("disabled"); 
			   				$("#connection").text("连接");
			   				$("#remoteColumnTree").html('<div class="alert alert-warning" role="alert" style="line-height:40px;text-align:center">未连接到远程数据库</div>		');
			   			} else {
			   				alert("链接关闭失败");
			   			}
				   }
				});
			});
		});
	</script>

</body>
</html>
