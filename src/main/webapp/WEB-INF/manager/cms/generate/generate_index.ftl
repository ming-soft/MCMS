<@ms.html5>
	<@ms.nav title="更新主页">	<@ms.button class="btn btn-primary" id="updateIndex" value="生成主页" /> 	<@ms.panelNavBtnSave title="" id="viewIndex" value="预览主页" /></@ms.nav>
	<@ms.panel>
						<p class="alert alert-info" role="alert">
							<span class="glyphicon glyphicon-pushpin text-lef "></span>
							<a class="alert-link text-lef" style="margin-left: 12px;">
			            		更新主页，如果系统存在引导页面可以手动修改主页位置文件名,default.html引导页面index.html主页。
							</a>
						</p>		
		<@ms.form name="generateIndex">
			<@ms.formRow label="选择主页模板" width="200">
					<select class="form-control" id="select_id"></select>
					<input type="hidden" name="url"/>				
			</@ms.formRow>
			<@ms.text  id="position" label="选择主页位置" width="200" value="index.html" placeholder="输入主页位置" name="position"  help="注:主页位置htm文件名一般为index.html或default.html"/>
		</@ms.form>
	</@ms.panel>
</@ms.html5>	

		<!--点击进行按钮提交-->
		<script>
			$(function(){
				var URL="${managerPath}/template/queryTemplateFileForColumn.do";
				var DATA = "";
				$(this).request({url:URL,data:DATA,type:"json",method:"get",func:function(msg) {
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
				
				
				//选择的主页模板名称和主页位置
				var url = $("#select_id").val();
				var position =$("input[name='position']").val();
				
				//封装ajax请求参数
				var URL="${managerPath}/cms/generate//generateIndex.do";
				var DATA = "url="+url+"&position="+position;
				$(this).html("更新中..").attr("disabled", "disabled");
				
				$(this).request({url:URL,data:DATA,type:"json",method:"post",func:function(msg) {
					$("#updateIndex").html("更新主页").removeAttr("disabled");
					if(msg){
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
				window.open("${managerPath}/cms/generate/"+position+"/viewIndex.do");
			});
		</script>
