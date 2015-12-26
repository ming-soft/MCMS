<!DOCTYPE html>
<html lang="en">

	<head>
		<!--调用head内样式信息-->
		<#include "/manager/include/macro.ftl"/>
		<#include "/manager/include/meta.ftl"/>
	</head>
	<style>
		hr{margin-top:9px;margin-bottom:9px;padding:0;}
		.form-horizontal .form-group{margin-left:0;margin-right:0}
		.form-group{overflow: hidden;}
		
		/*链接样式*/
		.link-style a:hover{color:#000;}
		.link-style a:visited{color:#000;}
		
		/*弹出窗口样式*/
		.control-label{font-weight:normal;font-size:14px;}
	</style>

	<body>

		<@ms.content>
			<@ms.contentBody>

				<div class="form-group">
					<label class="col-md-3 control-label col-xs-3 ">
						<h4 class="page-title bottomLine">搜索管理  <small><#if flag=true>创建<#else>更新</#if>搜索</small></h4>
					</label>
					<@ms.contentNav title="">
						<@ms.panelNavFilter>
							<@ms.contentNavBack onclick="location.href='${base}/manager/cms/search/list.do'" value="返回搜索列表" />
						</@ms.panelNavFilter>
					</@ms.contentNav>
				</div>

				<@ms.contentPanel>
					<div class="form-group">
						<label class="col-md-2 control-label col-xs-2 ">
							<h4 class="page-title bottomLine"><strong>搜索管理</strong></h4>
						</label>
					</div>
					<@ms.form isvalidation=true name="" id="searchForm">
						<!--输入表单名称-->
						<@ms.row>
							
							<#if flag=false>
								<input type="hidden" value="${search.searchId}" name="searchId" class="searchId"/>
							</#if>								
							
							<@ms.col style="width: 12%;height: 20px;text-align: right;">搜索名称：</@ms.col>
							<@ms.col size="4">
								<#if flag=true>
									<@ms.text  id="searchName" title="搜索名称" size="3" placeholder="请输入搜索名称" name="searchName" />
								<#else>
									<@ms.text  id="searchName" title="搜索名称" size="3" placeholder="请输入搜索名称" value="${search.searchName}" name="searchName" />
								</#if>
							</@ms.col>
							
							<@ms.col size="4" style=" height:30px; line-height:30px; color:#F00;font-weight:bold;"></@ms.col>
							<@ms.col size="12"></@ms.col>

							<!--搜索结果模板-->
							<div class="form-group">
								<@ms.col style="width: 12%;height: 20px;text-align: right;">搜索结果模板：</@ms.col>
								<div class="col-md-4  col-xs-4">
									<select class="col-md-4 form-control searchTemplets" name="searchTemplets">
										<#if flag=true>
										<#else>
											<option value="${search.searchTemplets}">${search.searchTemplets}</option>
										</#if>
									</select>
								</div>
							</div>
							<@ms.col size="12"></@ms.col>

							<@ms.col style="width:12%;height: 20px;"></@ms.col>
							<@ms.col size="2">
								<@ms.buttonarea label="">
									<#if flag=true>
										<@ms.panelNavBtnSave title="保存搜索" id="saveSearchForm" value="保存搜索" />
									<#else>
										<@ms.panelNavBtnSave title="更新搜索" id="updateSearchForm" value="更新搜索" />
									</#if>
								</@ms.buttonarea>
							</@ms.col>

						</@ms.row>
					</@ms.form>

					<!----------------------------搜索生成器表单开始------------------------------------->
					<!--如果当前为创建搜索，则搜索生成器为隐藏状态-->
						<span id="fieldFormTitle" style="display: none;">
							<hr/>
							<div class="form-group">
								<label class="col-md-2 control-label col-xs-2 ">
									<h4 class="page-title bottomLine"><strong>搜索生成器</strong></h4>
								</label>
							</div>
						</span>
						
						
						<@ms.form isvalidation=true name="" id="fieldForm" style="min-height: 500px;display: none;">
							<!--选择更新的栏目-->
							<@ms.row>
	
								<#if flag=false>
									<input type="hidden" value="${search.searchId}" name="searchId" class="searchId"/>
								</#if>
								<!--基本搜索多选框-->
								<@ms.col style="height:100px;width:12%;text-align: right;">基本搜索：</@ms.col>
								
								<!--第一行-->
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="1" name="basic_title">标题
								</@ms.col>
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="10" name="article_type">属性
								</@ms.col>
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="7" name="basic_thumbnails">缩略图
								</@ms.col>
								<@ms.col size="5" style="height:24px;"></@ms.col>
								
								<!--第二行-->
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="1" name="article_source">来源
								</@ms.col>
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="4" name="article_freeorder">自定义顺序
								</@ms.col>
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="1" name="article_author">作者
								</@ms.col>
								<@ms.col size="5" style="height:24px;"></@ms.col>
								
								<!--第三行-->
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="2" name="basic_description">描述
								</@ms.col>
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="2" name="article_keyword">关键字
								</@ms.col>
								<@ms.col style="width: 15%;">
									<input type="checkBox" value="2" name="article_content">内容
								</@ms.col>
	
								<@ms.col size="12" style="">
									<@ms.col style="width:11%;text-align: right;">高级搜索：</@ms.col>
									<div class="form-group" style="overflow: inherit;width: 51%;">
										<div class="col-md-8  col-xs-8">
											<#if columnList?has_content>
												<@ms.treeInput treeId="inputTree" json="${columnList?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" buttonText="选择更新的栏目" inputName="columnId" showIcon="true" expandAll="true" clickZtreeId="clickZtreeId(event,treeId,treeNode);"/>
											<#else>
												<@ms.treeInput treeId="errorTree" buttonText="暂无数据" />
											</#if>
										</div>
									</div>
								</@ms.col>
								<@ms.col size="12" style="">
									<@ms.col style="width:11%;text-align: right;"></@ms.col>
									<div class="form-group" style="overflow: inherit;width: 51%;">
										
											<div id="addField"></div>
										
									</div>
								</@ms.col>
								<@ms.col style="width:12%;"></@ms.col>
								<@ms.col size="8" style="text-align:left">
										<@ms.panelNavBtnSave title="生成查询表单代码" id="saveSoftButton" value="生成查询表单代码" />
								</@ms.col>
	
							</@ms.row>
							<!--生成查询表单代码按钮-->
						</@ms.form>
						<!----------------------------搜索生成器表单结束------------------------------------->
						
						<!--生成代码的模态框开始-->
						<@ms.modal modalName="softModal" title="提示框标题" style="">
							<@ms.modalBody>
									<textarea class="softCode" style='width:100%;height:500px' ></textarea>
							</@ms.modalBody>
							<@ms.modalButton><!--模态框按钮组-->
								<@ms.button value="关闭" id="closeModal"/>
							</@ms.modalButton>
						</@ms.modal>
						<!--生成代码的模态框结束-->
				</@ms.contentPanel>
			</@ms.contentBody>
		</@ms.content>

		<script>
			//选择栏目后实现高级搜索
			function clickZtreeId(event,treeId,treeNode){
				var url = "${base}/manager/cms/search/"+treeNode.categoryId+"/queryFieldName.do";
				$(this).request({url:url,method:"post",func:function(msg){
						if(msg.listField.length != 0){
							$("#addField").html("");
							for(var i=0; i<msg.listField.length; i++){
					     		$("#addField").append("<input type='checkBox' id='"+msg.listField[i].fieldTipsName+"' class='diyField' style='margin-top:-2px; margin-left:15px;' value="+msg.listField[i].fieldType+"  name="+msg.listField[i].fieldFieldName+">"+msg.listField[i].fieldTipsName);
					     	}
				     	} else {
				     	 	$("#addField").html("");
				    	}
				}});		
			}
			
			//页面加载执行
			$(function(){
				
				//更新搜索时生成代码文件显示
				var flag = ${flag?c}
				if(flag == false){
					$("#fieldFormTitle").show();
					$("#fieldForm").show();
				}
				
				//获取模板下的htm文件
				$.ajax({
						type: "post",
						url:"${base}/manager/cms/templet/queryTempletFileForColumn.do",
						dataType:"json",
						success:function(msg){
							if(msg.length==0){
								$(".searchTemplets").append("<option value='' >暂无模板文件</option>")
							}
							for(var i = 0;i<msg.length;i++){
								$(".searchTemplets").append("<option value="+msg[i]+">"+msg[i]+"</option>");
							}							
						}
				});  
			})
		
			//点击保存生成器按钮
		 	$("#saveSoftButton").on("click",function(){
		 		
				//生成搜索表的html代码
		 		$.ajax({
					type: "post",
					url:"${base}/manager/cms/search/generateSreachFormHtml.do",
					data:$("#fieldForm").serialize(),
					success:function(msg){
						$(".softCode").html(msg);
						$(".softModal").modal();
					}
				})
		 	});
		 	
		 	//点击关闭模态框
		 	$("#closeModal").on("click",function(){
		 		$(".softModal").modal("hide");
		 		$(".softCode").html("");
		 		$("#searchDataForm").prepend("<input type='hidden' name='basicCategoryId' value="+categoryId+"/>");
		 	});
		 	
		 	//点击保存搜索按钮
		 	$("#saveSearchForm").bind("click",function(){
		 		saveSearchForm();
		 	});
		 	
		 	//保存搜索方法
		 	function saveSearchForm() {
		 		 $.ajax({
					type: "post",
					dataType:"json",
					url:"${base}/manager/cms/search/save.do",
					data:$("#searchForm").serialize(),
					 beforeSend:function() {
		   				$("#saveSearchForm").html("正在保存...");
		   				$("#saveSearchForm").attr("disabled","disabled");
		   				$("#saveSearchForm").unbind("click");
		  			 },
					success:function(msg){
						if(msg.result){
							$("#fieldForm").css("display","block");
							$("input[name='searchId']").val(msg.resultMsg);
							$("#saveSearchForm").html("更新搜索");
							$("#saveSearchForm").removeAttr("disabled");
						 	$("#saveSearchForm").bind("click",function(){
						 		updateSearchForm();
						 	});								
						}else {
							alert(msg.resultMsg);
						}
					}
				})	 		
		 	}
		 	
		 	//点击更新搜索按钮
		 	$("#updateSearchForm").on("click",function(){
					updateSearchForm();
		 	});
		 	
		 	//更新搜素方法
		 	function updateSearchForm() {
		 		 $.ajax({
						type: "post",
						dataType:"json",
						url:"${base}/manager/cms/search/update.do",
						data:$("#searchForm").serialize(),
						success:function(msg){
							if(msg.result){
								alert("更新成功");
							}else {
								alert("更新失败");
								
							}
						}
					})		 	
		 	}
			
		</script>
	</body>

</html>