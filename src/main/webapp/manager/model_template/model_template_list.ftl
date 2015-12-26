<!DOCTYPE html>
<html lang="zh">
 <head>
<#include "/manager/include/macro.ftl"/>
<#include "/manager/include/meta.ftl"/>
</head>

<body>	
<@ms.content>
<@ms.contentBody >
	<@ms.contentNav title="自定义页面模块管理" ></@ms.contentNav >
	<@ms.contentPanel>
		<@ms.panelNav >
			<@ms.panelNavBtnGroup>
				<@ms.panelNavBtnAdd/>
			</@ms.panelNavBtnGroup>
		</@ms.panelNav>
		<@ms.table head=['名称','模版路径','访问路径','操作']>
			<#if list?has_content>
				<#list list as item>
					<tr>
			   			<td class="text-center" >${item.modelTemplateTitle?default("")}</td>
						<td class="text-center">${item.modelTemplatePath?default("")}</td>
						<td class="text-center">${item.modelTemplateKey?default("")}</td>
						<td class="text-center">
							<a class="btn btn-xs red tooltips del-btn" data-toggle="tooltip" data-id="${item.modelTemplateId?c?default(0)}"  data-original-title="删除">
								<i class="glyphicon glyphicon-trash"></i>
							</a>
							<a class="btn btn-xs red tooltips editModel" data-toggle="tooltip" data-id="${item.modelTemplateId?c?default(0)}"  data-original-title="编辑" >
								<i class="glyphicon glyphicon-pencil"></i>
							</a>
						</td>
			   		</tr>
				</#list>
			<#else>
			<tr>
	       	<td colspan="4" class="text-center">
	          		<@ms.nodata content="暂无自定义页面！"/>
				</td>
	       </tr>
			</#if>
		</@ms.table>
		
		 <!--添加模块-->    
		<@ms.modal modalName="addEditModel" title="添加模块">
			<@ms.modalBody>
				<@ms.form isvalidation=true name="addEditForm"  action="" method="post"  >
					<@ms.text name="modelTemplateTitle" style="width: 40%;" label="标题" title="标题" placeholder="请输入标题" value=""/>
					<@ms.text name="modelTemplateKey" style="width: 40%;" label="访问路径" title="访问路径" placeholder="请输入访问路径" value=""/>
					<div class="form-group">
				    	<label for="selectRole">选择模版</label>
						<select class="template templateSelect" style="width:40%" name="modelTemplatePath"></select>
					</div>
				</@ms.form>
			</@ms.modalBody>
			<@ms.modalButton>
				<@ms.button  value=""  id="addEditBtn"/>
			</@ms.modalButton>
		</@ms.modal>
		
		
		<@ms.modal modalName="delete" title="删除提示!">
			<@ms.modalBody>
			  		确认删除？？
			</@ms.modalBody>
			<@ms.modalButton>
				<@ms.button value="确认" id="rightDelete" class="btn btn-danger" value="删除"/>
			</@ms.modalButton>
		</@ms.modal>
			
			
				
	
	<!--删除的模态框结束-->
	</@ms.contentPanel>
</@ms.contentBody>
</@ms.content>        

<script>

var tmplModelId;
var postUrl;
$(function(){
	//加载选择模块列表
	$(".templateSelect").request({url:"${base}/manager/cms/templet/queryTempletFileForColumn.do",type:"json",method:"post",func:function(msg) {
		if(msg.length != 0 && ($(".template").html() == "" || $(".template").html() == "")){
   			for(var i=0; i<msg.length; i++){
	   			$(".templateSelect").append($("<option>").val(msg[i]).text(msg[i]));
	   		}
   		} else {
   			$(".templateSelect").append("<option>暂无文件</option>");
   		}
   		//使用select2插件
		$(".templateSelect").select2()
	}});
		
	
	//添加模块
	$("#addButton").on("click",function(){
		postUrl= "${base}/manager/modeltemplate/save.do";
		$("#addEditBtn").text("保存");
		$("#addEditModelTitle").text("添加模块");
		$("#addEditForm")[0].reset();
		$(".addEditModel").modal();
	});
	
	//编辑模块
	$(".editModel").on("click",function(){
		tmplModelId=$(this).attr("data-id");	//获取点击的id
		var actionUrl="${base}/manager/modeltemplate/"+tmplModelId+"/edit.do";	//编辑请求地址
		$(".editModel").request({url:actionUrl,type:"json",method:"post",func:function(data) {
			var model=eval("("+data.resultData+")");
			// 给表单赋值
			if(model!=null){
				$("input[name='modelTemplateTitle']").val(model.modelTemplateTitle);
				$("input[name='modelTemplateKey']").val(model.modelTemplateKey); 
				$(".templateSelect").find("option[value='"+model.modelTemplatePath+"']").attr("selected",true);
				$("#select2-chosen-2").text($(".templateSelect").find("option[value='"+model.modelTemplatePath+"']").text());
				$(".addEditModel").modal();
				postUrl="${base}/manager/modeltemplate/"+tmplModelId+"/update.do",
				$("#addEditBtn").text("更新");
				$("#addEditModelTitle").text("编辑模块");
			}	
		}});
		
		
	});
	
	//删除模块
	$(".del-btn").on("click",function(){
		tmplModelId=$(this).attr("data-id");
		$(".delete").modal();
	});
	
	//确认删除
	$("#rightDelete").on("click",function(){
		var actionUrl="${base}/manager/modeltemplate/"+tmplModelId+"/delete.do";
		$("#rightDelete").request({url:actionUrl,type:"json",method:"post",func:function(data) {
			alert("删除成功");
			location.reload();
		}});
	});
	
	//保存或更新
	$("#addEditBtn").on("click",function(){
		$("#addEditForm").attr("action",postUrl);
		$("#addEditForm").postForm("#addEditForm",{func:function(msg){
			if (msg.result) {
	     		if($("#addEditBtn").text()=="保存"){
	     			alert("保存成功");
	     		}else{
	     			alert("更新成功");
	     		}
	    		location.reload();
	    	}else{
	    		alert(msg);
	    	}
		}});
	});
});


</script>


</body>
</html>













