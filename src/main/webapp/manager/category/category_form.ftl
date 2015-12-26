<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/>
</head>
<body>	
	<#assign action="/manager/category/save.do"/>
	<#assign name="添加"/>
	<#if category?has_content>
		<#assign action="/manager/category/update.do"/>
		<#assign name="更新"/>
	</#if>
	<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="栏目管理">
				<@ms.savebutton id="saveFormButton" value="${name}"/>
				<@ms.contentNavBack value="返回栏目列表"/>
			</@ms.contentNav>
				<@ms.contentPanel>
	    			<@ms.form isvalidation=true name="saveForm" style="width: 60%" class="form-inline" action="">
				    		<@ms.text name="categoryTitle" label="名称:" title="类别名称" maxlength="30" style=" width:35%" placeholder="类别名称"  validation={"required":"true", "data-bv-notempty-message":"请填写栏目类别"}/>
				    		<@ms.textarea id="description" name="categoryDescription" label="描述:" style=" width:50%" title="栏目描述" placeholder="栏目描述" maxlength="150"/>
				    		
				    		<input type="hidden" name="categoryId" id="categoryId" value="" disabled="true"/>
				    		<div class="form-group margin15">
			        			<label class="col-md-3 control-label col-xs-3">栏目缩略图:</label>
			        			<div class="col-md-4 uploadImg col-xs-4" style="padding:0">
						    		<#if category?has_content> 
										<@uploadImg path="upload/${manager_session.basicId?default('0')}/app/" inputName="categorySmallImg" size="15" filetype="" msg=""  maxSize="1" imgs="${category.categorySmallImg?default('')}" />
									<#else> 
										<@uploadImg path="upload/${manager_session.basicId?default('0')}/app/" inputName="categorySmallImg" size="15" filetype="" msg=""  maxSize="1" imgs="" />
									</#if>
							    </div>
			            	</div>	
			            	<div class="form-group margin15" style="overflow: inherit">
					    		<!-- 树形模块菜单开始 -->
					    		<label class="col-md-3 control-label col-xs-3">关联:</label>
					    		<div class="col-md-4 uploadImg col-xs-4" style="padding:0">
								<#if listCategory?has_content>
										<@ms.treeInput  treeId="inputTree" json="${listCategory?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" buttonText="顶级栏目" inputName="categoryCategoryId"  showIcon="true" expandAll="true" addNodesName="顶级栏目" inputValue="${categoryCategoryId?default('0')}"/>
			    				<#else> 
										<@ms.treeInput  treeId="errorTree"  buttonText="暂无数据"/>
			    				</#if>
			    				<!-- 树形模块菜单结束 -->	
		    					</div>
			            	</div>
	    			</@ms.form>			
	        	</@ms.contentPanel>		
		</@ms.contentBody>
	</@ms.content>
</body>

<script>
	//从后台得到值之后，显示在输入框中
	<#if category?has_content>
		$("input[name='categoryTitle']").val("${category.categoryTitle?default('')}");
		$("#description").text("${category.categoryDescription?default('')}");	
		$("input[name='categoryId']").val(${category.categoryId?default(0)});
		$("#categoryId").attr("disabled",false);
	</#if>

	$("input[name=categoryCategoryId]").val("${categoryCategoryId?default('0')}");
	//点击修改或保存时,先判断验证是否通过,再提交信息
	$("#saveFormButton").click(function(){
		if($("#saveForm").data('bootstrapValidator').validate().isValid()){
			var formdata = $("#saveForm").serialize();
			
			$(this).request({url:"${base}${action}",data:formdata,type:"json",method:"post",func:function(msg) {
				if (msg.result) {
		     			alert("操作成功");
		    			location.href=base+"/manager/category/list.do?categoryCategoryId="+msg.resultData+"&modelId=${modelId}&modelTitle="+encodeURIComponent('${modelTitle?default("栏目")}');
		    	}else{
		    			alert(msg.resultMsg);
		    	}
			}});
		}
	});
	
	
</script>
	
</body>
</html>
