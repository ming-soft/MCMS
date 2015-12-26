<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/> <!--调用head内样式信息-->
<script type="text/javascript" src="${base}/js/ms.web.js"></script>
<script type="text/javascript" src="${base}/js/ms.validate.js"></script>
</head>
<body>
	<div class="container-fluid link-style">
			<!--右侧内容编辑区域开始-->
				<!--顶部   开始-->
				<div class="row ">
					<div class="col-md-12">
						<h3 class="page-title bottomLine">
						<#assign basicTitle="">
						<#assign basicId="0">
						<#assign basicDescription="">
						<#assign action="/manager/basic/save.do">
						<#if basic?has_content>
							编辑<small>编辑数据</small>
							<#assign basicTitle="${basic.basicTitle?default('')}">
							<#assign basicDescription="${basic.basicDescription?default('')}">
							<#assign basicId="${basic.basicId}">
							<#assign action="/manager/basic/update.do">
						<#else>
							新增<small>新增数据</small>
						</#if>		            
						</h3>
					</div>
				</div>
				<!--顶部  结束-->
				<hr>
				<!--------内容 部分  开始-------->
				<div class="row">
						<@ms.form action="${action}" name="basicForm">
							<div class="col-md-10">
								<@ms.hidden  name="basicId" value="${basicId?default('')}"/>
								<@ms.hidden  name="basicCategoryId" value="${categoryId?default('0')}"/>
								<@ms.text label="标题" name="basicTitle" value="${basicTitle?default('')}" size="33" style="width:40%" maxlength="120" />
							</div>
							<div class="col-md-10">
								<@ms.textarea label="描述" name="basicDescription" value="${basicDescription?default('')}" cols="110" rows="5" maxlength="1000" />
							</div>
									
							<div class="col-md-10">
									<div class="form-group">
										<div class="col-md-3"></div>
									    <div class="col-md-9">
									     	<button type="button" class="btn btn-success" id="basicFormSubmit">保存</button>
									    </div>
									 </div>					
							</div>
						</@ms.form>
				</div>
	
	</div>
	<script>
		$("#basicFormSubmit").click(function() {
			$(this).postForm("#basicForm",{func:"callBack"});
		});
		
		function callBack(json) {
			if (json.result) {
				alert("保存成功");
				location.href="${base}/manager/basic/${categoryId?default('0')}/list.do"
			}
		}
	</script>
</body>
</html>
