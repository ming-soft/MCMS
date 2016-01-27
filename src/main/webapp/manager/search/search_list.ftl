<@ms.html5>
	<@ms.nav title="自定义搜索"></@ms.nav>
	<@ms.panel>
				<@ms.panelNav>
					<@ms.buttonGroup>					
						<@ms.addButton openModal="searchModal"/>
					</@ms.buttonGroup>
				</@ms.panelNav>
					<@ms.table head=['编号,50','搜索名称,200','搜索结果模版,200',"操作"]>
						<#if searchList?has_content>
		        			<#list searchList as search>
		           				<tr>
					            	<td>${search.searchId?c?default(0)}</td>
						            <td>
						            	<a style="cursor: pointer;">
							            	<span class="updateSearch" data-toggle="tooltip"  data-original-title="点击修改搜索模块" data-id="${search.searchId?c?default(0)}">
							            			${search.searchName?default("暂无")}
						            		</span>
						            	</a>
						            </td>
						            <td>${search.searchTemplets?default("暂无")}</td>
						            <td>
					                    <a class="btn btn-xs tooltips deleteImg" data-toggle="tooltip" data-id="${search.searchId?c?default(0)}" data-original-title="删除">
					                        <i class="glyphicon glyphicon-trash"></i>
					                    </a>
					                    <a href="${base}/manager/search/${search.searchId}/searchCode.do">
					                    查看搜索代码
					                    </a>			                    
									</td>
						        </tr>
		           			</#list>
		           		<#else>	
		           			<tr>
					            <td colspan="4" class="text-center">
					            	<@ms.nodata/>
								</td>
				          	</tr>
		           		</#if>
					</@ms.table>
					<@ms.showPage page=page/>
	</@ms.panel>
</@ms.html5>					


		<!--=================模态框部分开始=================-->
		<!--删除的模态框开始-->
		<@ms.modal modalName="delete" title="删除搜索模板">
			 <@ms.modalBody>
				确定删除该条搜索吗？
		     </@ms.modalBody>
		     <@ms.modalButton>
	 			<@ms.button class="btn btn-danger" id="deleteButton" value="删除"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
		<!--删除的模态框结束-->
		
		<@ms.modal modalName="searchModal" title="搜索设置">
			 <@ms.modalBody>
			 	<@ms.form isvalidation=true name="searchForm" action="${base}/manager/search/save.do" redirect="${base}/manager/search/list.do">
						<@ms.hidden name="searchId" value="0"/>
						<@ms.text label="搜索名称"  id="searchName" title="搜索名称"  placeholder="请输入搜索名称" name="searchName" 
							      validation={"minlength":"1","maxlength":"10","required":"true","data-bv-notempty-message":"必填项目", "data-bv-stringlength-message":"长度在1到10个字符以内!"} 
						
						/>
						<!--搜索结果模板-->
						<@ms.select  name="searchTemplets" label="结果模版"/>			 	
				</@ms.form>
		     </@ms.modalBody>
		     <@ms.modalButton>
	 			<@ms.saveButton postForm="searchForm"/>  
	 		 </@ms.modalButton>
		</@ms.modal>
				
		<!--=================模态框部分结束=================-->
	<!--删除模态框-->
	<@ms.warnModal modalName="deleteWarn"/>
	<script type="text/javascript">	
		//全选
	   	$("#allCheck").on("click",function(){   
			if(this.checked){
			      $("input[name='searchId']").each(function(){this.checked=true;});
			}else{
			      $("input[name='searchId']").each(function(){this.checked=false;});   
			}   
		}); 
	
		//var ids = $("input[name='searchId']").serialize();
		//删除评论 
		function deleteSearch(id){
			var URL="${base}/manager/search/"+id+"/delete.do"
			$("#deleteButton").text("删除中");
			$("#deleteButton").attr("disabled",true);
			$(this).request({url:URL,type:"json",method:"post",func:function(msg) {
				//回调处理方式
				if(msg != 0) {
					alert("删除搜索成功");
		    		if($("tbody tr").length==0 && msg != 1){
		    			location.href = base+"/manager/search/list.do?pageNo="+(msg-1);
					}else{
						location.href = base+"/manager/search/list.do?pageNo="+msg;
					}
		    	} else {
					alert("删除搜索失败");
					$("#deleteButton").text("删除");
					$("#deleteButton").attr("disabled",false);
		    	}
			}});
		}
				
		$(function () {				
			//删除搜索模态框
			$(".deleteImg").on("click",function(){
				$(".delete").modal();//打开
				var basicId=$(this).attr("data-id");
				$(".delete").modal();//打开				
				$("#deleteButton").click(function(){
					deleteSearch(basicId);
				});
			});
			//修改搜索器
			$(".updateSearch").on("click",function(){
				var searchId = $(this).attr("data-id");
				$(this).request({url:"${base}/manager/search/"+searchId+"/edit.do",func:function(search) {
					if (search.searchId > 0) {
						$("#searchForm").attr("action","${base}/manager/search/update.do");
						$("#searchForm input[name='searchId']").val(search.searchId);
						$("#searchForm input[name='searchName']").val(search.searchName);
						$("#searchForm select[name='searchTemplets']").val(search.searchTemplets);
						$("#searchModal").modal();
					}					
				}});
			});			
			//关闭删除模态框
			$("#closeDelete").click(function(){
				$(".delete").modal("hide");//关闭
			});		

			//获取模板下的htm文件
			$.ajax({
				type: "post",
				url:"${base}/manager/cms/templet/queryTempletFileForColumn.do",
				dataType:"json",
				success:function(msg){
					if(msg.length==0){
						$("select[name='searchTemplets']").append("<option value=''>暂无模板文件</option>")
					}
					for(var i = 0;i<msg.length;i++) {
						$("select[name='searchTemplets']").append("<option value="+msg[i]+">"+msg[i]+"</option>");
					}							
				}
			});			
				
		});		
	</script>	
