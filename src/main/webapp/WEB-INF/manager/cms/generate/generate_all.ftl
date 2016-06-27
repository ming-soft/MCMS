<!DOCTYPE html>
<html lang="en">
<head>
<!--调用head内样式信息-->
<#include "${managerViewPath}/include/meta.ftl"/>
<link href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet">
<link href="${base}/css/daterangepicker.css" rel="stylesheet">
<script type="text/javascript" src="${base}/jquery/moment.js"></script>
<script type="text/javascript" src="${base}/jquery/daterangepicker.js"></script>
</head>
<style> 
	.container{margin:0;padding:0;width:auto}
	hr{margin-top:9px;margin-bottom:9px;padding:0;}
	.rowpadding3{padding-bottom: 3px;}
	.ms-button-group{padding:0px 0px 8px 0px}
	.row {margin-left:0;margin-right:0}
	.form-group{overflow: hidden;}
	.link-style a:hover{color:#000;}
	.link-style a:visited{color:#000;}
	.padding0{padding:0}
	label{padding: 0;
		margin: 0;
		font-weight: 300;
	}
		body{
			min-height: 600px;
		}
</style>

<body>
	<!----------------------------------- bootstarp 布局容器 开始-------------------------------->	
	<div class="container-fluid link-style">
		<!--顶部   开始-->
		<div class="row rowpadding3">
			<div class="col-md-12">
				<h3 class="page-title bottomLine">
					一键更新网站
				</h3>
			</div>
		</div>
		<!--顶部  结束-->
		<hr>
		<div class="row ">
			<div class="col-md-12 col-xs-12" >
					<div class="form-group">
						<p class="alert alert-info" role="alert" style="margin:0">
				            	<span class="glyphicon glyphicon-pushpin text-lef "></span>
				            		<a  class="alert-link text-lef"  style="margin-left: 12px;">
				            			一键更新所有页面,系统提示“更新中...”请不要刷新页面或点击其他菜单。
				            		</a>
						</p>
					</div>
					
					<div class="form-group" id="beginTime" >
						<div class="col-md-1 col-xs-1" style="padding: 0;line-height: 33px;">
							 起始时间
						 </div>
						 <div class="col-md-11 col-xs-11" style="padding: 0;">
						 		<div class="input-prepend input-group">
									<span class="add-on input-group-addon">
										<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
									</span>
									<input type="text" style="width:250px" name="updateTime" id="birthday" class="form-control" value="" />
								</div>
						 </div>
					</div>
					
					<div class="form-group text-left">
							<label for="" class="control-label  col-md-1 col-xs-1" style="padding: 0;"></label>
							<div class="col-md-2 col-xs-2" style="padding: 0;">					
								<button type="button" class="btn btn-primary" id="startUpdate">开始更新</button>
							</div>
					</div>					
					
			</div>
	</div>
	<script type="text/javascript">
		$(function(){
			// 获取系统当前时间
			var date=new Date()
			var time = date.getFullYear()+"-";
			if(date.getMonth()+1<10){
				time = time +"0" +(date.getMonth()+1)+"-";
			}else{
				time = time + (date.getMonth()+1)+"-";
			}
			if(date.getDate()+1<10){
				time = time +"0" +date.getDate();
			}else{
				time = time +date.getDate();
			}
			$("#birthday").val(time);
			// 应用日历
			$('#birthday').daterangepicker({
					singleDatePicker: true
			},
			function(start, end, label) {
				console.log(start.toISOString(), end.toISOString(), label);
			});
			
			//点击开始更新，进行ajax请求实现
			$("#startUpdate").click(function(){
					$(this).html("更新中..").attr("disabled","disabled");
					$.ajax({
			   			type: "post",
			   			url: "${managerPath}/cms/generate/generateAll.do",
			   			dataType:"json",
			   			success: function(msg){
			     			if(msg.result){
			     				$("#view").show();
			     				alert("更新成功");
			     				$(this).html("开始更新").removeAttr("disabled");
			     			}else{
			     				alert("更新失败");
			     			}
			   			}
					});
			});
			
		});
		
	</script>
</body>
</html>