<@ms.html5>
	<@ms.nav title="用户管理">
		<@ms.panelNavBtnGroup>
			<@ms.addButton url="${managerPath}/people/user/add.do"/>
			<@ms.delButton fieldName="ids" url="${managerPath}/people/user/delete.do" />
		</@ms.panelNavBtnGroup>
	</@ms.nav>
	<@ms.searchForm  name="searchForm" id="searchForm" action="${managerPath}/people/user/list.do">
		<@ms.text label="账号"  name="peopleName"  title="请输入用户昵称"  placeholder="请输入用户账号" value="${peopleName?default('')}"   />			  
		<@ms.text label="昵称"  name="peopleUserNickName"  title="请输入用户昵称"  placeholder="请输入用户昵称" value="${peopleUserNickName?default('')}"   />			  
		<@ms.text label="真实姓名"   name="peopleUserRealName"  title="请输入真实姓名"  placeholder="请输入真实姓名" value="${peopleUserRealName?default('')}"   />			  
		<#assign status=[{"id":"-1","name":"全部"},{"id":"1","name":"男"},{"id":"2","name":"女"}]>
		<@ms.select label="性别" list=status listValue="name" listKey="id"    name="peopleUserSex" value="${peopleUser_peopleUserSex?default(-1)}" />
		<#assign status=[{"id":"-1","name":"全部"},{"id":"0","name":"未审核"},{"id":"1","name":"已审核"}]>
		<@ms.select label="审核状态" list=status listValue="name" listKey="id"    name="peopleState" value="${peopleState?default(-1)}" />
		<@ms.date label="注册时间" name="peopleDateTimeWhere"     value="${peopleDateTimeWhere?default('')}" />
		<@ms.searchFormButton>
				<@ms.queryButton form="searchForm"/>								
		</@ms.searchFormButton>
	</@ms.searchForm>
	<@ms.panel>
		<@ms.table head=['<th ><input type="checkbox" name="allCheck"></th>','<th >头像</th>','帐号,120','真实姓名','昵称','手机,100','邮箱','注册时间','用户状态']>
			<#if listPeople?has_content>
    			<#list listPeople as people>
       				<tr>
       					<td >
							<input type="checkbox" name="ids" value="${people.peopleId?c?default(0)}">
            			</td>
			            <td ><#if people.peopleUser?has_content><img src="${base}${people.peopleUser.peopleUserIcon?default("暂无")}" width="25" height="25"/></#if></td>
			            <td>  <a class="btn btn-xs tooltips editPeople" data-id="${people.peopleId?c?default(0)}"  href="${managerPath}/people/user/${people.peopleId?c?default(0)}/edit.do" data-original-title="编辑用户信息" data-toggle="tooltip">${people.peopleName?default("暂无")}</a></td>
			            <td><#if people.peopleUser?has_content>${people.peopleUser.peopleUserRealName?default("暂无")}</#if></td>
		            	<td ><#if people.peopleUser?has_content>${people.peopleUser.peopleUserNickName?default("暂无")}</#if></td>
		             	<td >${people.peoplePhone?default("暂无")}</td>
			            <td >${people.peopleMail?default("暂无")}</td>
			            <td >${people.peopleDateTime?string("yyyy-MM-dd HH:mm:ss")}</td>
			            <td >
			            <span class="switch switch-mini " data-id="${people.peopleId?c?default(0)}" data-status="${people.peopleState?default(0)}" data-status="${people.peopleState?default(0)}" >
	                    		<input type="checkbox" name="peopleState" data-size="mini" data-on-text="已审" data-id="${people.peopleId?c?default(0)}" data-status="${people.peopleState?default(0)}" data-off-text="未审"/>
	                    </span>
			            </td>
			        </tr>
       			</#list>
       		<#else>	
           		<tr>
			         <td colspan="12" class="text-center">
			            <@ms.nodata/>
					</td>
		        </tr>
       		</#if>
		</@ms.table>
		<!--分页样式 开始-->
		<#if page?has_content>
			<@ms.pagehelper page=page url="${managerPath}/people/user/list.do?${params}"/>
		</#if>	
	</@ms.panel>
</@ms.html5>
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
				$(this).on('switchChange.bootstrapSwitch',changeStatus)
			});
			
			//点击事件,更新用户的的状态
			function changeStatus(){
				//用户ID
				var peopleId = $(this).attr("data-id");
				var obj = $(this);
				//用户当前状态
				var peopleState = $(this).attr("data-status");
				//开始更新门店用户状态
				$("body").request({
					method:"post",
					url:"${managerPath}/people/updateState.do",
					data:"peopleId="+peopleId+"&peopleState="+peopleState+"&t="+new Date(),
					func:function(msg) {
						if(peopleState == "1"){
							obj.attr("data-status","0");
						}else{
							obj.attr("data-status","1");
						}
					}
				})
			}
		});
		
	</script>	
