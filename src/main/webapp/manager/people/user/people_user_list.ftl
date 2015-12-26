<!DOCTYPE html>
<html lang="en">
<head>
<#include "/manager/include/meta.ftl"/> 
</head>
<body>
<@ms.content>
		<@ms.contentBody>
			<@ms.contentNav title="用户管理"/>
			
			<@ms.contentPanel>
					<@ms.panelNav>
					<@ms.panelNavBtnGroup>
						<@ms.panelNavBtnAdd/>
						<@ms.panelNavBtnDel/>
					</@ms.panelNavBtnGroup>
				</@ms.panelNav>
					<@ms.table head=['<input type="checkbox" name="allCheck">','编号','头像','帐号','真实姓名','昵称','手机','邮箱','注册时间','用户状态']>
						<#if listPeople?has_content>
		        			<#list listPeople as people>
		           				<tr>
		           					<td class="text-center">
										<input type="checkbox" name="ids" value="${people.peopleId?c?default(0)}">
			            			</td>
						            <td class="text-center commentId">${people.peopleId?c?default(0)}</td>
						            <td class="text-center"><#if people.peopleUser?has_content><img src="${people.peopleUser.peopleUserIcon?default("暂无")}" width="25" height="25"/></#if></td>
						            <td class="text-center">  <a class="btn btn-xs tooltips editPeople" data-id="${people.peopleId?c?default(0)}"  href="${base}/manager/people/user/${people.peopleId?c?default(0)}/edit.do" data-original-title="编辑用户信息" data-toggle="tooltip">${people.peopleName?default("暂无")}</a></td>
						            <td class="text-center">${people.peoplePhone?default("暂无")}</td>
					            	<td class="text-center"><#if people.peopleUser?has_content>${people.peopleUser.peopleUserNickName?default("暂无")}</#if></td>
					             	<td class="text-center"><#if people.peopleUser?has_content>${people.peopleUser.peopleUserRealName?default("暂无")}</#if></td>
						            <td class="text-center">${people.peopleMail?default("暂无")}</td>
						            <td class="text-center">${people.peopleDateTime?string("yyyy-MM-dd HH:mm:ss")}</td>
						            <td class="text-center">
						            <span class="switch switch-mini " data-id="${people.peopleId?c?default(0)}" data-status="${people.peopleState?default(0)}" data-status="${people.peopleState?default(0)}" >
				                    		<input type="checkbox" name="peopleState" data-size="mini" data-on-text="已审" data-id="${people.peopleId?c?default(0)}" data-status="${people.peopleState?default(0)}" data-off-text="未审"/>
				                    </span>
						            
						            
						            </td>
						        	
						        </tr>
		           			</#list>
		           		<#else>	
			           			<tr>
						            <td colspan="10" class="text-center">
						            	<@ms.nodata/>
									</td>
					          	</tr>
		           		</#if>
					</@ms.table>
					<!--分页样式 开始-->
					<@showPage page=page/>
			</@ms.contentPanel>
		</@ms.contentBody>
		<!--=================模态框部分开始=================-->
		<!--删除的模态框开始-->
		<@ms.modal modalName="peopleInfoModel" title="查看用户状态">
			 <@ms.modalBody>
					<!-- 用户详信信息载体开始 -->
				<div id="peopleUserInfo">
						<div class="row">
								 <div class="col-md-6">
									 <div class="form-group">
									    	<label>昵称:</label>
									    	<span class="nickName"></span>
									 </div>
									 <div class="form-group">
									    	<label>用户名:</label>
									    	<span class="userName"></span>
									 </div>
									 <div class="form-group">
									    	<label>手机:</label>
									    	<span class="phone"></span>
									 </div>
									 <div class="form-group">
									    	<label>邮箱:</label>
									    	<span class="mail"></span>
									 </div>				 
								 </div>
								 
								 <div class="col-md-6">
									 <div class="form-group">
									    	<label>姓名:</label>
									    	<span class="realName"></span>
									 </div>
									 <div class="form-group">
									    	<label>性别:</label>
									    	<span class="sex"></span>
									 </div>						 
									<div class="form-group">
									    	<label>生日:</label>
									    	<span class="birthday"></span>
									 </div>							 
									 <div class="form-group">
									    	<label>注册时间:</label>
									    	<span class="dateTime"></span>
									 </div>
								 </div>
								 
								 <div class="col-md-12">
								 		<label>地址:</label>
								 		<span class="address"></span>
								 </div>							 
							</div>	
				</div>
		<!-- 用户详细信息载体结束 -->	
		     </@ms.modalBody>
		      <@ms.modalButton>
	    		<@ms.button value="返回" id="closeDelete"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--保存的模态框结束-->
		<!--删除用户-->    
		<@ms.modal modalName="delete" title="删除用户">
			  <@ms.modalBody>
			  		确定要删除所选的用户吗?
		     </@ms.modalBody>
			 <@ms.modalButton>
		 		<@ms.button class="btn btn-danger rightDelete" value="确定"/>
		 	</@ms.modalButton>
		</@ms.modal>
		<!--=================模态框部分结束=================-->
</@ms.content>
	<script>
		$(function(){
			//初始化Switch按钮
			$("input[name='peopleState']").bootstrapSwitch();
			//遍历所有用户状态
			$("input[name=peopleState]").each(function() {
					var status = $(this).attr("data-status");//当前门店用户状态
					if (status=="1") {
						$(this).bootstrapSwitch('state', true);
					} else if(status=="0") {
					$(this).bootstrapSwitch('state', false);
				}
		});
		//点击事件,更新用户的的状态
		$(".switch-mini").click(function() {
			//用户ID
			var peopleId = $(this).attr("data-id");
			var obj = $(this);
			//用户当前状态
			var peopleState = $(this).attr("data-status");
			//开始更新门店用户状态
			$("body").request({
				method:"post",
				url:"${base}/manager/people/updateState.do",
				data:"peopleId="+peopleId+"&peopleState="+peopleState+"&t="+new Date(),
				func:function(msg) {
					if(peopleState == "1"){
						obj.attr("data-status","0");
					}else{
						obj.attr("data-status","1");
					}
				}
			})
		});	
			
			//全选
   			$("input[name='allCheck']").on("click",function(){  
				if(this.checked){   
					$("input[name='ids']").each(function(){this.checked=true;});
				}else{   
					$("input[name='ids']").each(function(){this.checked=false;});   
				}
			});
			//多选删除
			$("#delButton").click(function(){
				ids = $("input[name='ids']").serialize();
				if(ids!=""){
					$(".delete").modal();
				}else{
					alert("请选择要删除的用户!");
				}
			});
			//点击确认删除，对用户信息进行删除
			$(".rightDelete").click(function(){
				if(ids=="" && articleId!="" ){
					ids= "ids="+articleId;
				}
				deletes(ids);
			});
			
			//点击新增
			$("#addButton").click(function(){
				$(".updatePeopleUser").modal();
				$("#peopleForm input").val("");
				//
				location.href="${basePath}/manager/people/user/add.do";
			})
			
			//查看用户详细信息
			$(".zoom").click(function(){
				var peopleId = $(this).attr("data-id");
				$.ajax({
					type:"POST",
					url:"${base}/manager/people/user/getEntity.do",
					data:"peopleId="+peopleId,
					success:function(msg){
						if($.parseJSON(msg).result == true){
							var peopleUserInfo = $.parseJSON($.parseJSON(msg).resultData);
							$("#peopleUserInfo .nickName").html(isBlank(peopleUserInfo.peopleUserNickName));
							$("#peopleUserInfo .userName").html(isBlank(peopleUserInfo.peopleName));
							$("#peopleUserInfo .phone").html(isBlank(peopleUserInfo.peoplePhone));
							$("#peopleUserInfo .mail").html(isBlank(peopleUserInfo.peopleMail));
							$("#peopleUserInfo .realName").html(isBlank(peopleUserInfo.peopleUserRealName));
							//判断用户性别
							var sex = peopleUserInfo.peopleUserSex;
							if(sex == 1){
								$("#peopleUserInfo .sex").html("男");
							}else if(sex == 2){
								$("#peopleUserInfo .sex").html("女");
							}else{
								$("#peopleUserInfo .sex").html("未知");
							}
							$("#peopleUserInfo .birthday").html(changeDateTime(peopleUserInfo.peopleUserBirthday));
							$("#peopleUserInfo .dateTime").html(changeDateTime(peopleUserInfo.peopleDateTime));
							$("#peopleUserInfo .address").html(isBlank(peopleUserInfo.peopleUserAddress));
							$("#peopleInfoModel .modal-body").html(isBlank($("#peopleUserInfo").html()));
						}else{
							$("#peopleInfoModel .modal-body").html('<p class="alert alert-info" role="alert" style="margin:0; cursor:pointer;">该用户未还未填写详细信息!<p>');
						}
					},
				});
				$(".peopleInfoModel").modal();
			});
			
				$("#closeDelete").click(function(){
					$(".peopleInfoModel").modal("hide");//关闭
				});
			
			
		});
		
		/**
		 * 时间转换
		 * date:需要转换的时间
		 */
		function changeDateTime(date){
			if(date == null || date == ""){
				return "暂无";
			}
			var now = new Date(date)
			var year=now.getFullYear();   
			var month=now.getMonth()+1;   
			var date=now.getDate();   
			var hour=now.getHours();   
			var minute=now.getMinutes();   
			var second=now.getSeconds();   
			return year+"-"+month+"-"+date+"   "+hour+":"+minute+":"+second;   
		}
		
		/**
		 * 判断参数是否为空
		 * str 需要判断的值
		 * return 不为空返回原值,为空返回"暂无" 
		 */
		function isBlank(str){
			if(str == null || str == ""){
				return "暂无";
			}else{
				return str;
			}
		}
		
		//删除用户
		function deletes(ids){
			if(ids!=""){
				$(this).request({url:base+"/manager/people/user/delete.do",type:"json",data:ids,method:"post",func:function(msg) {
					if (msg.result) {
						alert("删除成功！")
						location.href=msg.resultMsg; 
					} else {
						alert("删除失败");
					}
				}});
			}else{
    			alert("请选择用户！");
  			  }
		}
	</script>	
</body>
</html>	