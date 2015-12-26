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
				<@ms.contentNav title="更新主页">
					<@ms.panelNavFilter>
						
					</@ms.panelNavFilter>
				</@ms.contentNav>

				<!--更新信息提示-->
				<div class="col-md-12 col-xs-12" style="margin-top:20px">
					<div class="form-group">
						<p class="alert alert-info" role="alert" style="margin:0">
							<span class="glyphicon glyphicon-pushpin text-lef "></span>
							<a class="alert-link text-lef" style="margin-left: 12px;">
			            		更新主页，如果系统存在引导页面可以手动修改主页位置文件名,default.html引导页面index.html主页。
							</a>
						</p>
					</div>
				</div>

				<!--选择更新的主页-->
				<@ms.contentPanel >
					
					<@ms.row>	
					
						<@ms.col>
							<label>选择主页模板</label>
						</@ms.col>
						<@ms.col size="2">
							<select class="form-control" id="select_id"></select>
							<input type="hidden" name="url"/>
						</@ms.col>
						<@ms.col size="12" style="height:20px;"></@ms.col>	
						
						<@ms.col>
							<label>主页位置</label>
						</@ms.col>
						<@ms.col size="2">
							<@ms.text  id="position" title="选择主页位置" value="index.html" placeholder="输入主页位置" name="position" />
						</@ms.col>
						<@ms.col size="6" style="line-height:33px;">注:主页位置htm文件名一般为index.html或default.html</@ms.col>
						<@ms.col size="12"></@ms.col>
						<@ms.col size="1" ></@ms.col>
						<@ms.col size="1" >
								<@ms.button class="btn btn-primary" id="updateIndex" value="更新主页" />
						</@ms.col>
						<@ms.col size="2" style="display: none;">
								<@ms.panelNavBtnSave title="" id="viewIndex" value="预览主页" />
						</@ms.col>
					</@ms.row>
				</@ms.contentPanel>

			</@ms.contentBody>
		</@ms.content>

		<!--点击进行按钮提交-->
		<script>
			$(function(){
				var URL="${base}/manager/cms/templet/queryTempletFileForColumn.do";
				var DATA = "";
				$(this).request({url:URL,data:DATA,type:"json",method:"post",func:function(msg) {
					if(msg.length==0){
						$("#select_id").append("<option value='' >暂无文件</option>")
					}
					for(var i = 0;i<msg.length;i++){
						$("#select_id").append("<option value="+msg[i]+">"+msg[i]+"</option>");
						//如果存在index.html
						if(msg[i]=="index.html" || msg[i]=="index.htm"){
							$("#select_id").find("option[value='"+msg[i]+"']").attr("selected",true);
						}
					}
				}});
			})
			
			//点击一键更新主页时，进行主页更新
			$("#updateIndex").click(function(){
				
				//更新时预览按钮隐藏
				$("#viewIndex").parent("div").hide();
				
				//选择的主页模板名称和主页位置
				var url = $("#select_id").val();
				var position =$("input[name='position']").val();
				
				//封装ajax请求参数
				var URL="${base}/manager/cms/generate//generateIndex.do";
				var DATA = "url="+url+"&position="+position;
				$(this).html("更新中..").attr("disabled", "disabled");
				
				$(this).request({url:URL,data:DATA,type:"json",method:"post",func:function(msg) {
					$("#updateIndex").html("更新主页").removeAttr("disabled");
					if(msg){
						$("#viewIndex").parent("div").show();
						alert("更新成功");
					}else{
						alert("更新失败,模版路径不存在");
					}
					$("#updateIndex").html("更新主页")
				}});
			});
			
			//点击预览时，进行预览
			$("#viewIndex").click(function(){
				var position =$("input[name='position']").val();
				window.open("${base}/manager/cms/generate/"+position+"/viewIndex.do");
			});
		</script>
	</body>

</html>