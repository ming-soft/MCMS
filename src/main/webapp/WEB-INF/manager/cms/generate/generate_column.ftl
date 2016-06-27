<@ms.html5>
	<@ms.nav title="更新主页">	<@ms.button class="btn btn-primary" id="updateColumn" value="生成栏目" /></@ms.nav>
	<@ms.panel>

				<!--更新信息提示-->
						<p class="alert alert-info" role="alert">
							<span class="glyphicon glyphicon-pushpin text-lef "></span>
							<a class="alert-link text-lef" style="margin-left: 12px;">
			            		更新栏目列表，推荐使用指定栏目更新。系统提示“更新中...”请不要刷新页面或点击其他菜单。
							</a>
						</p>

				<!--选择更新的栏目-->
				<@ms.form name="generateColumn">
					<@ms.formRow label="选择要生成栏目" width="300">
							<#if list?has_content>
								<@ms.treeInput treeId="inputTree" json="${list?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" buttonText="选择更新的栏目" addNodesName="所有栏目" inputName="columnId" showIcon="true" expandAll="true" />
							<#else>
								<@ms.treeInput treeId="errorTree" buttonText="暂无数据" />
							</#if>
					</@ms.formRow>
				</@ms.form>

	</@ms.panel>
</@ms.html5>	
		<!--点击进行按钮提交-->
		<script>
			$("#updateColumn").click(function() {
				
				var columnId = 0;
				if($("input[name='columnId']").val() !="" && $("input[name='columnId']").val().length>0){
					columnId = $("input[name='columnId']").val();
				}
				
				var URL="${managerPath}/cms/generate/"+columnId+"/genernateColumn.do";
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
