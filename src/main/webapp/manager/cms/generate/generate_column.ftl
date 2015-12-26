<!DOCTYPE html>
<html lang="en">

	<head>
		<!--调用head内样式信息-->
		<#include "/manager/include/macro.ftl"/>
		<#include "/manager/include/meta.ftl"/>
	</head>

	<body>
		<@ms.content>
			<@ms.contentBody>

				<!--标题和顶部更新按钮-->
				<@ms.contentNav title="一键更新栏目">
					<@ms.panelNavFilter>
						
					</@ms.panelNavFilter>
				</@ms.contentNav>

				<!--更新信息提示-->
				<div class="col-md-12 col-xs-12" style="margin-top:20px">
					<div class="form-group">
						<p class="alert alert-info" role="alert" style="margin:0">
							<span class="glyphicon glyphicon-pushpin text-lef "></span>
							<a class="alert-link text-lef" style="margin-left: 12px;">
			            		更新栏目列表，推荐使用指定栏目更新。系统提示“更新中...”请不要刷新页面或点击其他菜单。
							</a>
						</p>
					</div>
				</div>

				<!--选择更新的栏目-->
				<@ms.contentPanel style="width:50%;">
					<div class="form-group" style="min-height:35px;">
						<label class="col-md-2  col-xs-2">选择栏目</label>
						<div class="col-md-4  col-xs-4" style="padding: 0;">
							<#if list?has_content>
								<@ms.treeInput treeId="inputTree" json="${list?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" buttonText="选择更新的栏目" addNodesName="所有栏目" inputName="columnId" showIcon="true" expandAll="true" />
							<#else>
								<@ms.treeInput treeId="errorTree" buttonText="暂无数据" />
							</#if>
						</div>
					</div>
					 <div class="col-md-2  col-xs-2"></div> 
					<@ms.button class="btn btn-primary" id="updateColumn" value="更新栏目" />
				</@ms.contentPanel>

			</@ms.contentBody>
		</@ms.content>

		<!--点击进行按钮提交-->
		<script>
			$("#updateColumn").click(function() {
				
				var columnId = 0;
				if($("input[name='columnId']").val() !="" && $("input[name='columnId']").val().length>0){
					columnId = $("input[name='columnId']").val();
				}
				
				var URL="${base}/manager/cms/generate/"+columnId+"/genernateColumn.do";
				$(this).html("更新中..").attr("disabled", "disabled");
				
				$(this).request({url:URL,data:columnId,type:"json",method:"post",func:function(msg) {
					$("#updateColumn").html("更新栏目").removeAttr("disabled");
					//回调处理方式
					if (msg) {
						alert("更新栏目成功");
					} else {
						alert("更新栏目失败");
					}
				}});
				
			});
		</script>
	</body>

</html>