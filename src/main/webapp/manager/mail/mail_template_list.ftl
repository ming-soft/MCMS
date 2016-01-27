<!DOCTYPE html>
<html lang="zh">
 <head>
  	<#include "/manager/include/macro.ftl"/>
  	<#include "/manager/include/meta.ftl"/>   
</head>
<style>
	#inputTree{
  		  margin-bottom: 3%;
	}
	#treeDomeinputTree{
			  width: 30%;
			  margin-left: 30%;
	}
	#modelId{
			  width: 30%;
			  color: #666;
			  text-align: center;
			    margin-bottom: 17px;
			  float: left;
			  line-height: 34px;
			  padding-right: 8px;
			  font-weight: 400;
	}
	#treeDomeerrorTree{
			 display:none;
	}
	.modal{
			z-index:400;
	}
</style>
<body>	
	<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="邮箱模板管理"></@ms.contentNav >
			<@ms.contentPanel>
				<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						<@ms.panelNavBtnAdd  id="totalAdd"/>
						<@ms.panelNavBtnDel  id="totalDelete"/>
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
	              <@ms.table head=['<input type="checkbox" id="allCheck" value="全选" data-original-title="全选删除" data-toggle="tooltip"/>','ID','模块编号','模板标题','模板内容']>
	           			<#if mailTemplateList?has_content>
	           				<#list mailTemplateList as mailTemplateList>
	                    	<tr class="on-focus">
	                    		<td class="text-center">
	                    			<input type="checkbox" name="radioCategoryId" value="${mailTemplateList.mailTemplateId?c?default(0)}"/> 
	                            </td>
	                            <td class="text-center mailTemplateId"><a href="#"><span data-original-title="点击编辑" data-toggle="tooltip" style="cursor:pointer">${mailTemplateList.mailTemplateId?c?default(0)}</span></a></td>
	                            <td class="text-center mailTemplateModelId">${mailTemplateList.mailTemplateModelId?c?default(0)}</td>
	                            <td class="text-center mailTemplateTitle">${mailTemplateList.mailTemplateTitle?default("")}</td>
	                            <td class="text-center mailTemplateContent">${mailTemplateList.mailTemplateContent?default("")}</td>
	                    	</tr>  
	                    	
	                    	</#list>
	                 		<#else>
	                 			<tr>
						            <td colspan="5" class="text-left">
						            	<@ms.nodata/>
									</td>
					          	</tr>
	        			</#if>
	        			</@ms.table>
	
			</@ms.contentPanel>		
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
		
		<!--修改/保存的模态框开始-->
				<@ms.modal modalName="update" title="" style="width:80%">
						 <@ms.modalBody>
							<@ms.form isvalidation=true name="updateSms" class="form-inline" action="">	
								<!-- 树形模块菜单开始 -->
								<label id="modelId">模板id</label>
								<#if modelEntityList?has_content>
										<#assign treeJson= '${modelEntityList?default("")}'/>
										<@ms.treeInput  treeId="inputTree" json="${treeJson?default('')}" jsonId="modelId" jsonPid="modelModelId" jsonName="modelTitle" buttonText="选择模块名称" inputName="mailTemplateModelId"  showIcon="true" expandAll="true" />
			    					<#else> 
										<@ms.treeInput  treeId="errorTree"  buttonText="暂无数据"/>
			    				</#if>	
			    				<!-- 树形模块菜单结束 -->
			    				
					    		<@ms.text name="mailTemplateTitle"  style="width:55%"  label="模板标题" title="模板标题" size="5" maxlength="30" validation={"required":"true", "data-bv-notempty-message":"模板标题不能为空"}/>
					    		<@ms.editor name="mailTemplateContent"   label="模板内容"    validation={"required":"true", "data-bv-notempty-message":"模板内容不能为空"}/>
					    	</@ms.form>		          	
					     </@ms.modalBody>
					     <@ms.modalButton>
				    		<@ms.button value="返回" id="closeUpdate"/>  
				 			<@ms.savebutton id="updateButton"/>  
				 		 </@ms.modalButton>
					</@ms.modal>
		<!--修改/保存的模态框结束-->
		
		<!--删除的模态框开始-->
		<@ms.modal modalName="delete" title="删除手机接口">
			 <@ms.modalBody>
				您确定删除您所勾选的模块么？
		     </@ms.modalBody>
		     <@ms.modalButton>
	    		<@ms.button value="返回" id="closeDelete"/>  
	 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--保存的模态框结束-->
		<!--=================模态框部分结束=================-->
	</@ms.content>
</body>
</html>

<script>
	//按钮打开模态框	
	$("#totalAdd").click(function(){ 
	   $("#updateTitle").text("添加邮箱模板");
	    UE.getEditor('editor_mailTemplateContent').setContent("");
		$("#updateSms").attr("action","${base}/manager/mail/template/save.do");	
		$(".update").modal();//打开
	})
	$("#totalDelete").click(function(){
		var radioData = $("input[name='radioCategoryId']").serialize();
		if(radioData!=""){
			$(".delete").modal();//打开
			}else{
				alert("请选择需要删除的模板！");
			}
	})
	//点击每一条数据的id
	$(".mailTemplateId").click(function(){
		UE.getEditor('editor_mailTemplateContent').execCommand('insertHtml','');
		$("#updateTitle").text("修改邮箱模板");
		//在点击页面上每条记录的id时，获取整条记录的值。分别是模板id、模板编号、内容模板			
		var mailTemplateId =  $(this).find("span").text();
		
		//ajax把模板id传给后台，查找相应的模板实体，赋值给模态框
		$.ajax({ 
				type: "POST", 
				url: base+"/manager/mail/template/getEntity.do",
				data:"mailTemplateId="+mailTemplateId,
				dataType:"json",
    			success:function(msg){
					var json =JSON.parse(msg.resultMsg);
					
					
					$(".update input[name='mailTemplateModelId']").val(json.mailTemplateModelId);
					$(".update input[name='mailTemplateTitle']").val(json.mailTemplateTitle);				

					UE.getEditor('editor_mailTemplateContent').setContent(json.mailTemplateContent);
    				$("#updateSms").attr("action","${base}/manager/mail/template/"+mailTemplateId+"/update.do");	

    				$(".update").modal();//打开
    				
    			}
    		})				
		
		//打开模态框
        $(".update").modal();//打开	
	})
	
	
	
	//按钮关闭模态框
	$("#closeUpdate").click(function(){
		$(".update").modal("hide");//关闭
	})
	$("#closeDelete").click(function(){
		$(".delete").modal("hide");//关闭
	})
	$("#loginOutBtn").click(function() {	
			$(this).request({func:function(data) {
		 		location.reload();
			}});	
		});
		
	 //全选或取消
	   	$("#allCheck").on("click",function(){   
			if(this.checked){   
				$("input[name='radioCategoryId']").each(function(){this.checked=true;});
			}else{   
				$("input[name='radioCategoryId']").each(function(){this.checked=false;});   
			}   
		}); 
	
	
	 //点击更新按钮
	 $("#updateButton").click(function() {
			//序列化开始
			var vobj = $("#updateSms").data('bootstrapValidator').validate();
			if(vobj.isValid()){
					// idValid()：功能检查对象变量是否已经实例化
				$(this).postForm("#updateSms",{func:function(msg) {
				if(msg.result==true){
					$(".update").modal("hide");//关闭
						alert("保存成功");
					}else{
						alert("保存失败，一个模块不能存在两个模板");
					}
					location.reload();
				}})
			} else {
				alert("保存失败");
			}    	
	 });

	 
	 //点击删除按钮
	 $("#deleteButton").click(function(){
	 	var ids = $("input[name='radioCategoryId']").serialize();
	 	if(ids!=""){
				$.ajax({ 
					type: "POST", 
					url: base+"/manager/mail/template/delete.do",
					data:ids,
					dataType:"Json",
	    			success: function(msg){
	    				if (msg.result) {
	    					location.reload();
	    					alert("删除成功！");
	    				}    				
	    			}
	    		});
	    	}else{
	    		$(".delete").modal("hide");
	        	alert("请选择模块！");
	        }
	 })
</script>










