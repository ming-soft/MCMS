<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/>
</head>
<style>
	.container{margin:0;padding:0;width:auto}
	hr{margin-top:9px;margin-bottom:9px;padding:0;}
	.rowpadding3{padding-bottom: 3px;}
	.ms-button-group{padding:0px 0px 8px 0px}
	.row {margin-left:0;margin-right:0}
	td{word-break : break-all ;}
	.form-horizontal .form-group{margin-left:0;margin-right:0}
	.form-group{overflow: hidden;}
	.bs-example>.dropdown>.dropdown-menu {position: static;margin-bottom: 5px;clear: left;}
	.bs-example>.dropdown>.dropdown-toggle {float: left;}
	.padding-zero{padding:0;}
	.link-style a{color:#428bca;}
	.form-inline .form-group {display: inline-block;margin-bottom: 0;vertical-align: middle;}
	.dedeteRight{width: 32%;margin: 0 auto;overflow: hidden;}
	/*弹出窗口样式*/
	#WindowDialog .modal-dialog{width:auto;}
	.has-error .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#A94442;}
	.has-success .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#3C763D;}
</style>
<body>
	
	<div class="container-fluid link-style">
		<!--顶部   开始-->
		<div class="row rowpadding3">
			<div class="col-md-12">
				<h3 class="page-title bottomLine">
					站点管理
					<small>站点列表</small>
				</h3>
			</div>
		</div>
		<!--顶部  结束-->
		<hr>
		<!--------内容 部分  开始-------->
		<div class="row">
			<!--功能按键部分 开始-->
			<div class="form-group">
				<#if managerSession?has_content && managerSession.managerRoleID ==1>
				<button  type="button" class="btn btn-success col-md" id="addWebsite" >新增站点&nbsp;<span class="glyphicon glyphicon-plus"></span></button>
				</#if>
			</div>
			<table class="table table-bordered">
				<thead>
		        	<tr>
		        		<td colspan="6" class="text-left">
	                     	<i class="glyphicon glyphicon-pushpin"></i>
	                     	站点列表
		        		</td>
		        	</tr>
			        <tr>
			            <th class="col-md-1 text-center">站点编号</th>
			            <th class="col-md-4 text-center">标题</th>
			            <th class="col-md-2 text-center">模板</th>
			            <th class="col-md-3 text-center">域名</th>
			            <th class="col-md-2 text-center">操作</th>
			        </tr>
		        </thead>
		        <tbody>
		        	<#if listWebsite?has_content>
		           		<#list listWebsite as listWebsite>
		        	<tr> 
			           	<td class="text-center basicId">${listWebsite.basicId?c?default(0)}</td>
			            <td class="text-center" id="name">${listWebsite.basicTitle?default(0)}</td>
			            <td class="text-center">${listWebsite.websiteStyle?default("暂无模板")}</td>
			            <td class="text-center">${listWebsite.websiteUrl?default(0)}</td>
			            <td class="text-center">
			            	
			            	<#if listWebsite.websiteManagerId==0>
	                    	<a class="btn btn-xs red tooltips updateModalBtn" data-toggle="tooltip" data-original-title="增加管理员" >
	                     		<i class="glyphicon glyphicon-plus"></i>
	                    	</a>
	                    	<#else>
                    		<input type="hidden" class="managerId" name="managerId"  value="${listWebsite.websiteManagerId?c?default(0)}"/>
                    		<a class="btn btn-xs red tooltips updateModalBtn" data-toggle="tooltip" data-original-title="编辑管理员" data-id="">
                     			<i class="glyphicon glyphicon-user"></i>
                    		</a>
	                    	</#if>
	                    	<#if managerSession?has_content && managerSession.managerRoleID ==1>
	                    	<a class="btn btn-xs red tooltips del-btn " data-toggle="tooltip" data-original-title="删除站点" data-id="${listWebsite.basicId?c?default(0)}">
	                     		<i class="glyphicon glyphicon-trash"></i>
	                    	</a>
	                    	</#if>
		                    <a class="btn btn-xs red tooltips" data-rid="" data-toggle="tooltip"  data-original-title="编辑站点" href="${base}/manager/cms/website/${listWebsite.basicId?default(0)}/edit.do" data-id="${listWebsite.basicId?c?default(0)}">
	                     		<i class="glyphicon glyphicon-pencil"></i>
	                    	</a>
	                    	
						</td>
			        </tr>
			        </#list>
		           	<#else>
		           	
		           	<td colspan="6" class="text-center">
		            	<p class="alert alert-info" role="alert" style="margin:0">
		            		<span class="glyphicon glyphicon-plus"></span>
		            		<a href="${base}/manager/cms/website/add.do" class="alert-link">
		            		您还没有添加站点，点击添加站点
		            		</a>
					  	</p>
					</td>
		          	</#if>
		        </tbody>
			</table>
		</div>
	</div>

	<#if page?has_content>
	<@showPage page=page/>
	</#if>
	<!--增加/更新管理员模态框-->
	<@modalDialog modalName="addModel"/>
	<!--删除模态框-->
	<@warnModal modalName="deleteWarn"/>
	
	<!--增加管理员开始-->
  	<div class="row" style="display:none;" id="managerModel">	
		  <form action="" class="form-horizontal" role="form" id="managerForm">
			<div class="form-group">
				<label class="col-md-4 control-label col-xs-3" for="managerName">帐号:</label>
				<div class="col-md-4  col-xs-4">
					<input type="text" class=" form-control managerName" placeholder="请输入帐号" name="managerName">
				</div>
			</div> 
			<div class="form-group">
				<label class="col-md-4 control-label col-xs-3" for="nickName">昵称:</label>
				<div class="col-md-4  col-xs-4">
					<input type="text" class=" form-control managerNickName" placeholder="请输入昵称" name="managerNickName">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label col-xs-3" for="password">密码:</label>
				<div class="col-md-4  col-xs-4">
					<input type="password" class=" form-control managerPassword " placeholder="请输入密码" name="managerPassword">
				</div>
			</div>
			<input type="hidden" name="oldRoleName" value=""/>
			<div class="row">
		  	   <label class="col-md-4 control-label col-xs-3">模块:</label>
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
			<input type="hidden" name="basicId" value=""/>
			<input type="hidden" class="managerPeopleID" name="managerPeopleID" value="0"/>
			<input type="hidden" class="oldManagerName" name="oldManagerName" value=""/>
		</form>
        <button type="button" id="save" class="btn btn-primary" style="float:right;">保存</button>
        <button type="button" class="btn btn-default closeModal" data-dismiss="modal" style="float:right; margin-right:10px;">关闭</button>
        <div style="clear:both;"></div>
	</div>
	<!--增加管理员结束-->
	
	<script>	
	
	//引入表单验证框架
	var bootstrapValidator;var zTree;
	
	//表单验证
	function checkForm(){
		$("#managerForm").bootstrapValidator({
			feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
	       	fields: {
	           managerName: {
	                validators: {
	                    notEmpty: { message: '帐号不能为空'},
	                    stringLength: {min: 1,max: 12,message: '帐号长度介于1-12个字符'},
	                    regexp: {regexp: /^[a-zA-Z0-9_\.]+$/,message: '帐号只能由英文字母，数字，点和下划线组成'}
	                }
	            },
	            managerNickName: {
	                validators: {
	                    notEmpty: {message: '昵称不能为空'},
	                    stringLength: {min: 2,max: 15,message: '昵称长度介于2-15个字符'}
	                }
	            },
	            managerPassword: {
	                validators: {
	                    notEmpty: { message: '密码不能为空'},
	                    stringLength: {min: 1, max: 16,message: '密码长度介于1-16个字符'},
	                    regexp: {regexp: /^[a-zA-Z0-9_\.]+$/,message: '密码只能由英文字母，数字，点和下划线组成'}
	                }
	            }
	        }
	    });
		bootstrapValidator = $("#addModelDialog").find("form:first").data('bootstrapValidator');
	}
	
	//增加/更新管理员模态框
	function addModel(obj){
		var editManagerId; 
		var URL = "";
		var basicId=$(obj).parent().parent().find("td:first").html();
		$("#save").attr("disabled", false);
		//如果是点击的保存则弹出保存按钮
		if($(obj).attr("data-original-title")=="增加管理员"){
			$("#save").html("保存");
			$(".closeModal").click();
			$("input[name='managerName']").removeAttr("readonly"); 
			openaddModel($("#managerModel"),"增加管理员");
			$("input[name='basicId']").val(basicId);
			URL = "${base}/manager/manager/add.do"
		}else {
			$("#save").html("更新");
			$("input[name='managerName']").attr("readonly","readonly");
			openaddModel($("#managerModel"),"更新管理员");
			$("input[name='basicId']").val(basicId);
			editManagerId = $(obj).parent().find("input[name='managerId']").val();
			URL = base+"/manager/manager/"+editManagerId+"/edit.do";
		}
		//管理员表单验证
		checkForm();
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
		obj.attr("disabled","true");
		var nodes = zTree.getCheckedNodes(true);
		for(var i=0; i<nodes.length; i++){
			modelIds[i] = nodes[i].id;
		}
		var formData = $("#managerForm").serialize();
		var URL = "";
		if($("#save").html() == "保存"){
			URL = "${base}/manager/manager/save.do";
		} else {
			URL = "${base}/manager/manager/update.do?managerId="+$('.managerId').val();
		}
		$.ajax({
		   type: "post",
		   dataType: "json",
		   url:  URL,
		   data: formData + "&modelIds=" + modelIds, 
		   success: function(msg){
		     	if(msg.result) {
		    		if($("#save").html() == "保存"){
		     			alert("保存管理员成功");
		     		} else {
		     			alert("更新管理员成功");
		     		}		     		
		     		location.href = "${base}/manager/cms/website/listForSuper.do?pageNo="+parseInt(msg.resultMsg);
		    	} else {
		    		alert(msg.resultMsg); 
		    		if(msg.resultMsg.indexOf("尚未更新管理员") > 0){
		    			$(".closeModal").click();
		    		}
		    	}
		    	$("#save").attr("disabled", true);
		   }
		});
	}
	
	//删除站点的ajax
	function deleteWebsite(basicId){
		var actionUrl="${base}/manager/cms/website/"+basicId+"/delete.do";
		$.ajax({
			type: "post",
			url:actionUrl,
			dataType:"json",
			success:function(msg){
				alert("删除成功");
				$("#warndeleteWarnOk").attr("disabled", true);
				if($("tbody tr").length==1){
					if(msg==1){
						location.href="${base}/manager/cms/website/listForSuper.do?pageNo=1";
					}else{
						location.href="${base}/manager/cms/website/listForSuper.do?pageNo="+(msg-1);
					}
				}else{
					location.href="${base}/manager/cms/website/listForSuper.do?pageNo="+msg;
				}
			}
		});
	}
	
	
	$(function(){
		//前端验证帐号是否存在
		$("input[name='managerName']").blur(function(){
			var oldManagerName = $(".oldManagerName").val();
			var managerName = $(this).val();
			if((oldManagerName.length != 0 && oldManagerName != managerName) || (oldManagerName.length == 0)){
				$.ajax({
				   type: "post",
				   dataType: "json",
				   url:  "${base}/manager/manager/judgeManagerNameExist.do",
				   data: "managerName=" + managerName,
				   success: function(msg){
				     	if(msg){
				     		alert("该帐号已存在，请再次输入");
				     		$("input[name='managerName']").val(null);
				     	} 
				   }
				});
			}
		});
		//管理员表单验证
		checkForm();
		
		//通用增加/更新管理员模态框
		$(".updateModalBtn").on("click",function(){
			addModel(this);
		});
		
		//增加/更新管理员
		$("#addModelDialog").delegate("#save","click",function(){
			var password = $(".managerPassword").val();
			//若密码值为空，则不验证密码框
			if(password == ""){
				bootstrapValidator.removeField('managerPassword');
				if(bootstrapValidator.validate().isValid()){
					addEdit($(this));
				}
			} else if(bootstrapValidator.validate().isValid()){
				addEdit($());
			}
		});
		
		//点击新增按钮
		$("#addWebsite").click(function(){
			location.href="${base}/manager/cms/website/add.do";
		});
		
		//点击删除按钮
		$(".del-btn").click(function(){
			var basicId=$(this).attr("data-id");
			$("#warndeleteWarnOk").attr("disabled", false);
			warndeleteWarn("是否删除该站点？","删除站点","deleteWebsite("+basicId+")");
		});
		//取消按钮
		$("#addModelDialog").delegate(".closeModal","click",function(){
			$(".managerName").val(null);
	   		$(".managerNickName").val(null);
	   		$(".managerPassword").val(null);
	   		$(".oldManagerName").val(null);
		   	bootstrapValidator.resetForm();
		});
		
		 //启用工具提示
		$("[data-toggle='tooltip']").tooltip();
	});
	</script>
</body>

</html>

