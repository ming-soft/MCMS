<@ms.html5>
	<@ms.nav title="文章管理" back=true>
		<#if article.basicId == 0>
	 		<@ms.saveButton id="saveUpdate" value="保存"/>
	 	<#else>
	 		<@ms.updateButton id="saveUpdate" value="更新"/>
	 	</#if>
	</@ms.nav>
	<@ms.panel>
		<@ms.form isvalidation=true name="articleForm" action="${managerPath}/cms/article/${action}.do">
			<@ms.text name="basicTitle" colSm="2" width="400" label="文章标题"	title="文章标题" size="5"  placeholder="请输入文章标题"  value="${article.basicTitle?default('')}"  validation={"maxlength":"300","required":"true", "data-bv-notempty-message":"文章标题不能为空","data-bv-stringlength-message":"标题在300个字符以内!", "data-bv-notempty-message":"必填项目"}/>
			<@ms.text name="basicSort"  colSm="2" width="200" label="自定义顺序" title="自定义顺序" size="5"  placeholder="请输入文章顺序" value="${article.basicSort?c?default(0)}" validation={"data-bv-between":"true","required":"true", "data-bv-between-message":"自定义顺序必须大于0","data-bv-between-min":"0", "data-bv-between-max":"99999999","data-bv-notempty-message":"自定义顺序不能为空"}/>
			<#if articleType?has_content>
				<@ms.checkboxlist colSm="2" name="checkbox" label="文章属性" list=articleType listKey="dictValue"  listValue="dictLabel" />
			</#if>
			<@ms.radio name="basicDisplay" 
			    list=[{"id":"0","value":"是"},{"id":"1","value":"否"}] value="${article.basicDisplay?c?default()}" 
			    listKey="id" listValue="value" label="是否显示" help="选择否后前端将不显示，需要重新生成才有效果"
			/>
			<@ms.formRow colSm="2" label="文章缩略图" width="400" >
					<@ms.uploadImg path="article" uploadFloderPath="${articleImagesUrl?default('')}" inputName="basicThumbnails" size="1" msg="提示:文章缩略图,支持jpg格式"  imgs="${article.basicThumbnails?default('')}"  />
			</@ms.formRow>
			<@ms.text name="articleSource" colSm="2" width="200" label="文章来源" title="文章来源" size="5"  placeholder="请输入文章来源"  value="${article.articleSource?default('')}" validation={"maxlength":"300", "data-bv-stringlength-message":"文章来源在300个字符以内!"} />
			<@ms.text name="articleAuthor" colSm="2" width="200" label="文章作者" title="文章作者" size="5"  placeholder="请输入文章作者"  value="${article.articleAuthor?default('')}" validation={"maxlength":"12", "data-bv-stringlength-message":"文章作者在12个字符以内!"} />
			<#if !isEditCategory><!-- 如果不是单篇 -->
	            <@ms.formRow colSm="2" label="所属栏目" width="300">
	            <#if categoryTitle=="">
	            	<@ms.treeInput treeId="inputTree" json="${listColumn?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" inputName="basicCategoryId" inputValue="${categoryId}" buttonText="选择栏目" clickZtreeId="clickZtreeId(event,treeId,treeNode);" expandAll="true"  showIcon="true"/>
	            <#else>
	            	<@ms.treeInput treeId="inputTree" json="${listColumn?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" inputName="basicCategoryId" inputValue="${categoryId}" buttonText="${(categoryTitle)!}" clickZtreeId="clickZtreeId(event,treeId,treeNode);" expandAll="true"  showIcon="true"/>
				</#if>
				</@ms.formRow>
            </#if>
            <@ms.hidden id="basicDateTime" name="basicDateTime" value=""/>
            <@ms.date id="articleDateTime" name="articleDateTime" time=true label="发布时间" single=true readonly="readonly" width="300" value="${(article.basicDateTime?default(.now))?string('yyyy-MM-dd HH:mm')}" validation={"required":"true", "data-bv-notempty-message":"必填项目"} placeholder="点击该框选择时间段"  />
			<@ms.textarea colSm="2" name="basicDescription" label="描述" wrap="Soft" rows="4"  size=""  value="${article.basicDescription?default('')}" placeholder="请输入对该文章的简短描述，以便用户查看文章简略" validation={"maxlength":"400","data-bv-stringlength-message":"文章描述在400个字符以内!"}/>
			<@ms.textarea colSm="2" name="articleKeyword" label="关键字" wrap="Soft" rows="4"  size="" placeholder="请输入文章关键字"   value="${article.articleKeyword?default('')}" validation={"maxlength":"155", "data-bv-stringlength-message":"文章作者在155个字符以内!"}/>
			<!--新填字段内容开始-->
			<div id="addFieldForm">		
			</div>
			<@ms.hidden name="articleTypeJson" />
			<@ms.editor colSm="2" name="articleContent" label="文章内容" content="${article.articleContent?default('')}"  appId="${appId?default(0)}"/>			
			<@ms.hidden name="modelId"  value="${Session.model_id_session?default('0')}" />
		</@ms.form>
	</@ms.panel>
</@ms.html5>     
<script>
//重写时间控件
$('#articleDateTime').daterangepicker({
	format:'YYYY-MM-DD HH:mm',
	singleDatePicker: true,
	showDropdowns: true,
	timePickerIncrement: 1,
  	timePicker: true,
  	timePicker12Hour: true,
  	startDate: moment().hours(0).minutes(0).seconds(0),
   	showDropdowns: true,
    showWeekNumbers: true,
  });
$('#articleDateTime').on('apply.daterangepicker', function(ev, picker) {
		$('#articleDateTime').parents("form:first").data('bootstrapValidator').revalidateField('articleDateTime');
});
var articleBasicId=0;
$(function(){
	//页面标题
	var articleTitle="<#if categoryTitle?has_content>${categoryTitle}&nbsp;</#if><#if article.basicId !=0><small>编辑文章</small><#else><small>添加文章</small></#if>";
	$(".ms-weixin-content-body-title>span").html(articleTitle);	
	//隐藏跳转地址
	$("input[name='articleUrl']").parent().hide();
	
	//文章属性
	var actionUrl="";
	
	<#if article.basicId !=0>
	actionUrl = "${managerPath}/cms/article/${article.basicId?c?default(0)}/update.do";
	var type="${article.articleType?default('')}";
	var articleType = new Array;
	//文章属性
	$("#articleForm input[name='checkbox']").each(function(){
		if(type!=""){
			articleType = type.split(",");
		  	for(i=0;i<articleType.length;i++){
				if($(this).val()==articleType[i]){
					$(this).attr("checked",'true');
				}
			}
		}
	});
	articleBasicId=${article.basicId?c?default(0)};
	<#else>
	actionUrl = "${managerPath}/cms/article/save.do";
	</#if>	
	
	//获取当前栏目的自定义模型
	var url="${managerPath}/mdiy/contentModel/contentModelField/"+${categoryId?default(0)}+"/queryField.do";
	var articleId="basicId="+${article.basicId?c?default(0)};
	$(this).request({url:url,data:articleId,method:"get",func:function(data) {
		$("#addFieldForm").html(data);
	}});

	//显示跳转地址
	$("input[name='checkbox']").click(function(){
		$("input[name='checkbox']").each(function(){
			if( $(this).val() == 'j'){
				if($(this).is(":checked") ){
					$("input[name='articleUrl']").parent().show();
				}else{
					$("input[name='articleUrl']").parent().hide();
				}
			}
		});
	});	
	
	//更新或保存				
	$("#saveUpdate").click(function(){
		//禁用按钮
		$("#saveUpdate").attr("disabled",true);
		//获取按钮值
		var bottonText = $("#saveUpdate").text().trim();
		//设置按钮加载状态值
		$("#saveUpdate").attr("data-loading-text",bottonText+"中");
		
		var articleDateTimeValue = $("#articleDateTime").val()+":00";//让时间能精确到秒与后台对应
		$("#basicDateTime").val(articleDateTimeValue); //给basicDateTime字段赋值
		//获取所有栏目属性被选中的值
		var typeJson=""
		$("#articleTypeField").find("select").each(function(index){ 
			var typeValue=0;
			if($(this).find("option:selected").val()==undefined){
				return;
			}
			var typeValue=$(this).find("option:selected").val();
			if($("#articleTypeField").find("select").length==index){
				typeJson =typeJson+ "{bcCategoryId:\"" + typeValue + "\",bcBasicId:'${article.basicId?default(0)}'}"
			}else{
				typeJson =typeJson+ "{bcCategoryId:\"" + typeValue + "\",bcBasicId:'${article.basicId?default(0)}'},"
			}
			
		})
		$("input[name=articleTypeJson]").val("["+typeJson+"]");
		var basicCategoryId="";
		<#if !isEditCategory><!-- 如果不是单篇 -->
			basicCategoryId=$("input[name='basicCategoryId']").val(); //多篇时的文章栏目
		<#else>
			basicCategoryId=${categoryId}; //单篇时的文章栏目
		</#if>
		//文章所属栏目是数字且不能为0
		if(basicCategoryId !=0 && !isNaN(basicCategoryId) ){
			//将表单序列化
			var saveArticle = $("#articleForm").serialize();
			saveArticle += "&basicCategoryId="+basicCategoryId;
			//文章属性
			var checkboxType="";
			$("input[name='checkbox']").each(function(){
				if($(this).is(":checked")){
					checkboxType+=$(this).val()+",";
				}
			});
			var dataMsg = saveArticle+"&checkboxType="+checkboxType;
			var seeMsg = "";
			<#if article.basicId !=0>
	   			seeMsg="更新中....";
	   		<#else>
	   			seeMsg="保存中....";
	   		</#if>
	   		var vobj = $("#articleForm").data('bootstrapValidator').validate();
			if(vobj.isValid()){
				if(isNaN($("input[name=basicSort]").val())){
					<@ms.notify msg="自定义排序必须是数字" type="warning"/>
					$("input[name=basicSort]").val(0);
					//启用按钮
					$("#saveUpdate").button('reset');
					return;
				}
				$(this).request({url:actionUrl,data:dataMsg,loadingText:seeMsg,method:"post",type:"json",func:function(obj) {
					//执行加载状态
					$("#saveUpdate").button('loading');
					if(obj.result){
						<#if article.basicId !=0>
		   					<@ms.notify msg="更新文章成功" type="success"/>
			   			<#else>
			   				<@ms.notify msg="保存文章成功" type="success"/>
			   			</#if>
			   			var columnType = ${columnType?default(0)};
		   			    if(columnType == 1){
		   			    	//更新并生成之后路径进行跳转
					    	location.href=managerPath+"/cms/article/${categoryId?default(0)}/main.do";
		   			    }else{
		   			    	var dataId = obj.resultData;
		   			    	if(dataId!=""){
		   			    		location.href = "${managerPath}/cms/article/"+dataId+"/edit.do";
		   			    	}
		   			    };
		   			    $("#saveUpdate").button('reset');
					}else{
						$('.ms-notifications').offset({top:43}).notify({
					    	type:'warning',
					    	message: { text:obj.resultMsg }
					 	}).show();
					}
				}});
			}
		}else{
			<@ms.notify msg="请选择文章所属栏目" type="warning"/>
			//启用按钮
			$("#saveUpdate").attr("disabled",false);
		}
		 //启用按钮
		 $("#saveUpdate").button('reset');
	     $("#saveUpdate").attr("disabled",false);
	});	
});

//选择栏目后查询自定义模型
function clickZtreeId(event,treeId,treeNode){
	if(treeNode.columnType == 2){
		<@ms.notify msg="不能选择单篇栏目" />
		return false;
	}
	if(treeNode.isParent==true){
		<@ms.notify msg="不能选择父级栏目" />
		return false;
	}
	var url="${managerPath}/mdiy/contentModel/contentModelField/"+treeNode.categoryId+"/queryField.do";
	var basicId="basicId=${article.basicId?c?default(0)}";
	$(this).request({url:url,data:basicId,method:"get",func:function(data) {
		$("#addFieldForm").html("");
		$("#addFieldForm").html(data);
	}});
} 
</script>