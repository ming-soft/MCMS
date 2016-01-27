<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/macro.ftl"/>
<#include "/manager/include/meta.ftl"/>
</head>

<body>
<@ms.content>
<@ms.contentBody>
	<@ms.contentNav title="站点管理"></@ms.contentNav >
	<@ms.contentPanel>
		<@ms.panelNav empty=false>
			<!--列表操作按钮，添加和删除-->
			<@ms.panelNavBtnGroup>
				<@ms.panelNavBtnAdd id="addButton" value="" />
			</@ms.panelNavBtnGroup>													
		</@ms.panelNav>	
		<@ms.table head=["<th style='width:10%'>站点编号</th>",'标题','模板','域名',"<th style='text-align:center;'>操作</th>"]>
       			<#if listApp?has_content>
	           		<#list listApp as listApp>
					<tr>
                        <td class="basicId">${listApp.appId?c?default(0)}</td>
			            <td style="width:40%" id="name">${listApp.appName?default(0)}</td>
			            <td style="width:15%">${listApp.appStyle?default("暂无模板")}</td>
			            <td style="width:20%">${listApp.appUrl?default(0)}</td>
			            <td class="text-center">          		
                			<#if listApp.appManagerId==0>
	                    	<a class="btn btn-xs red tooltips addManagerBtn"  data-toggle="tooltip" data-original-title="增加管理员" >
	                     		<i class="glyphicon glyphicon-plus"></i>
	                    	</a>
	                    	<#else>
                    		<a class="btn btn-xs red tooltips editManagerBtn" data-toggle="tooltip" data-original-title="编辑管理员" data-id="${listApp.appManagerId?c?default(0)}">
                     			<i class="glyphicon glyphicon-user"></i>
                    		</a>
	                    	</#if>
	                    	
	                    	
	                    	<#if managerSession?has_content && managerSession.managerRoleID ==1>
	                    	<a class="btn btn-xs red tooltips deleteManagerBtn" data-toggle="tooltip" data-original-title="删除站点" data-id="${listApp.appId?c?default(0)}">
	                     		<i class="glyphicon glyphicon-trash"></i>
	                    	</a>
	                    	</#if>
		                    <a class="btn btn-xs red tooltips" data-rid="" data-toggle="tooltip"  data-original-title="编辑站点" href="${base}/manager/app/${listApp.appId?default(0)}/edit.do" data-id="${listApp.appId?c?default(0)}">
	                     		<i class="glyphicon glyphicon-pencil"></i>
	                    	</a>
	                    	
                		</td>
                	</tr>
             		</#list>
             	<#else>
	  			 	<tr>
			            <td colspan="5" class="text-center">
			            	<@ms.nodata ontent="您还没有添加站点，请添加站点" />
						</td>
		          	</tr>
    			</#if>  
        </@ms.table>
	</@ms.contentPanel>		
</@ms.contentBody>


<!--删除版主-->    
<@ms.modal modalName="appDelete" title="删除站点!">
	  <@ms.modalBody>
	  		确认删除该站点？
     </@ms.modalBody>
	 <@ms.modalButton>
 		<@ms.button class="btn btn-danger deleteAppBtn" value="确定"/>
 	</@ms.modalButton>
</@ms.modal>

<!--添加或编辑站点管理员-->
<@ms.modal modalName="addAndEdit" title="">
	 <@ms.modalBody >
		<@ms.form isvalidation=true name="managerForm" class="form-inline" action="">	
			<@ms.text name="managerName" label="帐号：" title="管理员帐号" style="width: 50%;" maxlength="12" placeholder="请输入管理员帐号" validation={"required":"true", "data-bv-notempty-message":"请输入管理员帐号!","data-bv-regexp":"true","data-bv-regexp-regexp":"^[a-zA-Z0-9_]+$","data-bv-regexp-message":"帐号只能由英文字母，数字，下划线组成!","data-bv-stringLength-message":"帐号长度最长为12个字符！"}/>
    		<@ms.text name="managerNickName" label="昵称：" title="管理员昵称" style="width: 50%;" maxlength="15" placeholder="请输入管理员昵称" validation={"required":"true", "data-bv-notempty-message":"请输入管理员昵称!"} />
    		<@ms.password name="managerPassword" label="密码：" title="管理员密码" style="width: 71%;"   maxlength="16" validation={"data-bv-regexp":"true","data-bv-regexp-regexp":"^[a-zA-Z0-9_]+$","data-bv-regexp-message":"密码只能由英文字母，数字，下划线组成!"}  />
    		<!--模块树形结构-->
    		<div class="form-group">
		  	   <label>模块：</label>
		  	   <div class="col-md-5">	
				 	 <!--模块树型菜单开始-->
					  <div class="content_wrap">
							<div class="zTreeDemoBackground left">
								<ul id="treeDemo" class="ztree"></ul>
							</div>
					  </div>
					  <!--模块树型菜单结束-->
				</div>
		    </div>
			<@ms.hidden name="basicId" value="" />
			<@ms.hidden name="oldRoleName" value="" />
			<@ms.hidden name="managerPeopleID" value="0" />
			<@ms.hidden name="oldManagerName" value="" />
    	</@ms.form>
     </@ms.modalBody>
     <@ms.modalButton>
 			<@ms.savebutton id="saveUpdateButton"/>  
 	</@ms.modalButton>
</@ms.modal>


</@ms.content>     

<script>	


$(function(){
	
	//点击新增按钮
	$("#addButton").click(function(){
		location.href="${base}/manager/app/add.do";
	});
		
	//添加站点管理员
	$(".addManagerBtn").click(function(){
		$("#addAndEditTitle").text("添加管理员");
		$("#saveUpdateButton").text("保存");
		var URL = "${base}/manager/manager/add.do";
		var basicId=$(this).parent().parent().find("td:first").html();
		$("input[name='basicId']").val(basicId);
		//调用树形结构
		treeManager(URL);
		$("input[name='managerName']").attr("readonly",false);
		$(".addAndEdit").modal();//打开该模态框
	});
	
	//编辑站点管理员
	$(".editManagerBtn").click(function(){
		$("#addAndEditTitle").text("编辑管理员");
		$("#saveUpdateButton").text("编辑");
		var basicId=$(this).parent().parent().find("td:first").html();
		$("input[name='basicId']").val(basicId);
		//管理员id
		var managerId = $(this).attr("data-id");
		//
		var URL = base+"/manager/manager/"+managerId+"/edit.do";
		//调用树形结构
		treeManager(URL);
		$(".addAndEdit").modal();//打开该模态框
	});
	
	//保存或更新
	$("#saveUpdateButton").click(function(){
		addEdit(this);
	});
	
	//站点id
	var appId;
	//删除站点
	$(".deleteManagerBtn").click(function(){
		appId= $(this).attr("data-id");
		$(".appDelete").modal();
	});
	
	
	$(".deleteAppBtn").click(function(){
		deleteWebsite(appId);
	});
	
});

	//展开添加管理员或编辑管理员可以分配的模块
	function treeManager(URL){
		//获取管理员信息
		$.ajax({
			type: "post",
			dataType:"json",
			url: URL,
			success: function(msg){
				//树型菜单框架
				var zNodes = new Array();
				var setting = {check: {enable: true},data: {simpleData: {enable: true}}};
				//列出所有模块，并勾选出该角色所拥有的模块
				if(msg.listSelModel == "" || msg.listSelModel.size == 0 || msg.listSelModel == null){
					for(var i=0; i<msg.listModel.length; i++){
						zNodes[i] = {id:msg.listModel[i].modelId, pId:msg.listModel[i].modelModelId, name:msg.listModel[i].modelTitle}
					}
				} else {
					for(var i=0; i<msg.listModel.length; i++){
						for(var j=0; j<msg.listSelModel.length; j++){
							if(msg.listModel[i].modelId == msg.listSelModel[j].modelId){
								zNodes[i] = {id:msg.listModel[i].modelId, pId:msg.listModel[i].modelModelId, name:msg.listModel[i].modelTitle, checked:true}
								break;
							} else {
								zNodes[i] = {id:msg.listModel[i].modelId, pId:msg.listModel[i].modelModelId, name:msg.listModel[i].modelTitle}
							}
						}
					} 
				}
			  	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			  	zTree = $.fn.zTree.getZTreeObj("treeDemo");
				setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
				
				//若为更新管理员则执行
				if(msg.manager != null){
					$("input[name='managerName']").val(msg.manager.managerName);
					$("input[name='managerName']").attr("readonly",true);
					$("input[name='oldManagerName']").val(msg.manager.managerName);
					$("input[name='oldRoleName']").val(msg.manager.managerName);
					$("input[name='managerNickName']").val(msg.manager.managerNickName);
				}
			}
		});
	}

//增加/更新管理员
function addEdit(obj){
	var modelIds = new Array();
	$(obj).attr("disabled","true");
	var nodes = zTree.getCheckedNodes(true);
	for(var i=0; i<nodes.length; i++){
		modelIds[i] = nodes[i].id;
	}
	var formData = $("#managerForm").serialize();
	var URL = "";
	if($(obj).text() == "保存"){
		URL = "${base}/manager/manager/save.do";
	} else {
		var managerId = $(".editManagerBtn").attr("data-id");
		URL = "${base}/manager/manager/update.do?managerId="+managerId;
	}
	$.ajax({
	   type: "post",
	   dataType: "json",
	   url:  URL,
	   data: formData + "&modelIds=" + modelIds, 
	   success: function(msg){
	     	if(msg.result) {
	    		if($("#saveUpdateButton").text() == "保存"){
	     			alert("保存管理员成功");
	     		} else {
	     			alert("更新管理员成功");
	     		}		     		
	     		location.href = "${base}/manager/app/list.do?pageNo="+parseInt(msg.resultMsg);
	    	} else {
	    		alert(msg.resultMsg);
	    	}
	    	$("#saveUpdateButton").attr("disabled", false);
	   }
	});
}

//删除站点的ajax
function deleteWebsite(basicId){
	var actionUrl="${base}/manager/app/"+basicId+"/delete.do";
	$.ajax({
		type: "post",
		url:actionUrl,
		dataType:"json",
		success:function(msg){
			alert("删除成功");
			$("#warndeleteWarnOk").attr("disabled", true);
			if($("tbody tr").length==1){
				if(msg==1){
					location.href="${base}/manager/app/list.do?pageNo=1";
				}else{
					location.href="${base}/manager/app/list.do?pageNo="+(msg-1);
				}
			}else{
				location.href="${base}/manager/app/list.do?pageNo="+msg;
			}
		}
	});
}
</script>
</body>

</html>

