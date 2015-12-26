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
			<@ms.contentNav title="一键更新文章" >
				<@ms.panelNavFilter>
				</@ms.panelNavFilter>
			</@ms.contentNav >
			
			<!--更新信息提示-->
			<div class="col-md-12 col-xs-12" style="margin-top:20px">
				<div class="form-group">
					<p class="alert alert-info" role="alert" style="margin:0">
						<span class="glyphicon glyphicon-pushpin text-lef "></span>
						<a class="alert-link text-lef" style="margin-left: 12px;">
			            	根据时间与栏目类型生成文章
						</a>
					</p>
				</div>
			</div>
			
			<!--选择栏目和选择更新时间-->
			<@ms.contentPanel style="width:50%;">
				<div class="form-group" style="min-height: 35px;">
	        		<label class="col-md-2  col-xs-2">所属栏目</label>
	        		<div class="col-md-4  col-xs-4" style="padding: 0;">
	        			<#if list?has_content>
							<@ms.treeInput  treeId="inputTree" json="${list?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" addNodesName="所有栏目" buttonText="选择更新的栏目" inputName="columnId"  showIcon="true" expandAll="true" />
	    				<#else> 
							<@ms.treeInput  treeId="errorTree"  buttonText="暂无数据" />
	    				</#if>	
	 				</div>
	            </div>
	            <label class="col-md-2  col-xs-2">起始时间</label>
	            <@ms.date name="dateTime" single=true readonly="readonly" style="width:36%;" value="${now?string('yyyy-MM-dd')}" validation={"required":"true", "data-bv-notempty-message":"必填项目"} placeholder="点击该框选择时间段"  />
	            <div class="col-md-2  col-xs-2"></div> 
	            <@ms.button class="btn btn-primary" id="updateArticle" value="更新文档"/>
			</@ms.contentPanel>		
			
		</@ms.contentBody>
	</@ms.content>
	
	<!--点击进行按钮提交-->
	<script>
		$("#updateArticle").click(function() {
			
			var columnId = 0;
			if($("input[name='columnId']").val() !="" && $("input[name='columnId']").val().length>0){
				columnId = $("input[name='columnId']").val();
			}
			
			var URL="${base}/manager/cms/generate/" + columnId + "/generateArticle.do";
			var DATA = "dateTime=" + $("input[name='dateTime']").val();
			$(this).html("更新中..").attr("disabled", "disabled");
			
			$(this).request({url:URL,data:DATA,type:"json",method:"post",func:function(msg) {
				$("#updateArticle").html("更新文档").removeAttr("disabled");
				//回调处理方式
				if (msg) {
					alert("更新文档成功");
				} else {
					alert("更新文档失败");
				}
			}});
			
		});
	</script>
</body>

</html>