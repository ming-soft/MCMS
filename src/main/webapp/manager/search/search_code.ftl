<@ms.html5>
	<@ms.nav title="搜索代码">
		<@ms.button class="btn btn-primary" id="saveSoftButton" value="生成查询表单代码" />
	</@ms.nav> 
	<@ms.panel>
				<@ms.panelNav/>
				<!----------------------------搜索生成器表单开始------------------------------------->
					<!--如果当前为创建搜索，则搜索生成器为隐藏状态-->
					<@ms.form isvalidation=true name="" id="fieldForm">
						<!--选择更新的栏目-->
							<@ms.hidden  name="searchId" value="${searchId}"/>
							<@ms.formRow label="基本搜索">
								<label class="checkbox-inline"><input type="checkBox" value="1" name="basic_title">标题</label>
								<label class="checkbox-inline"><input type="checkBox" value="10" name="article_type">属性</label>
								<label class="checkbox-inline"><input type="checkBox" value="7" name="basic_thumbnails">缩略图</label>
								<label class="checkbox-inline"><input type="checkBox" value="1" name="article_source">来源</label>
								<label class="checkbox-inline"><input type="checkBox" value="4" name="article_freeorder">自定义顺序</label>
								<label class="checkbox-inline"><input type="checkBox" value="1" name="article_author">作者</label>
								<label class="checkbox-inline"><input type="checkBox" value="2" name="basic_description">描述</label>
								<label class="checkbox-inline"><input type="checkBox" value="2" name="article_keyword">关键字</label>
								<label class="checkbox-inline"><input type="checkBox" value="2" name="article_content">内容</label>
							</@ms.formRow>
							<@ms.formRow label="高级搜索" width="300">
										<#if columnList?has_content>
											<@ms.treeInput treeId="inputTree" json="${columnList?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" buttonText="选择更新的栏目" inputName="columnId" showIcon="true" expandAll="true" clickZtreeId="clickZtreeId(event,treeId,treeNode);"/>
										<#else>
											<@ms.treeInput treeId="errorTree" buttonText="暂无数据" />
										</#if>							
							</@ms.formRow>
							<@ms.formRow>
									<div id="addField"></div>									
							</@ms.formRow>
						<!--生成查询表单代码按钮-->
					</@ms.form>
	</@ms.panel>
</@ms.html5>					
	<!--生成代码的模态框开始-->
	<@ms.modal modalName="softModal" title="提示框标题" style="">
		<@ms.modalBody height="400">
			<textarea name="softCode" style="width:100%;height:100%"></textarea>
		</@ms.modalBody>
		<@ms.modalButton><!--模态框按钮组-->
			<@ms.button value="关闭" id="closeModal"/>
		</@ms.modalButton>
	</@ms.modal>
	<!--生成代码的模态框结束-->
	<script>
		//选择栏目后实现高级搜索
		function clickZtreeId(event,treeId,treeNode){
			var url = "${base}/manager/search/"+treeNode.categoryId+"/queryFieldName.do";
			$(this).request({url:url,method:"post",func:function(msg){
					if(msg.listField.length != 0){
						$("#addField").html("");
						for(var i=0; i<msg.listField.length; i++){
				     		$("#addField").append("<label class='checkbox-inline'><input type='checkBox' id='"+msg.listField[i].fieldTipsName+"' class='diyField' style='margin-top:-2px;' value="+msg.listField[i].fieldType+"  name="+msg.listField[i].fieldFieldName+">"+msg.listField[i].fieldTipsName+"  </div>");
				     	}
			     	} else {
			     	 	$("#addField").html("");
			    	}
			}});		
		}
		
		
		//点击保存生成器按钮
	 	$("#saveSoftButton").on("click",function(){ 		
			//生成搜索表的html代码
	 		$.ajax({
				type: "post",
				url:"${base}/manager/search/generateSreachFormHtml.do",
				data:$("#fieldForm").serialize(),
				success:function(msg){
					$("textarea[name='softCode']").html(msg);
					$(".softModal").modal();
				}
			})
	 	});
	 	
	 	//点击关闭模态框
	 	$("#closeModal").on("click",function(){
	 		$(".softModal").modal("hide");
	 		$("textarea[name='softCode']").html("");
	 		$("#searchDataForm").prepend("<input type='hidden' name='basicCategoryId' value="+categoryId+"/>");
	 	});
	 	
	 	 	
	</script>