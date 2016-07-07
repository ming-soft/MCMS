<@ms.html5>
	<@ms.nav title="文章管理" back=true>
		<@ms.saveButton  id="saveUpdate" /> 
	</@ms.nav>
	<@ms.panel>
		<@ms.form isvalidation=true name="articleForm" action="${managerPath}/cms/article/${autoCURD}.do">
			<@ms.text name="basicTitle" width="400" label="文章标题"	title="文章标题" size="5"  placeholder="请输入文章标题"  value="${article.basicTitle?default('')}"  validation={"maxlength":"300","required":"true", "data-bv-notempty-message":"文章标题不能为空","data-bv-stringlength-message":"标题在300个字符以内!"}/>
			<@ms.text name="basicSort"  width="200" label="自定义顺序" title="自定义顺序" size="5"  placeholder="请输入文章顺序" value="${article.basicSort?c?default(0)}" validation={"data-bv-between":"true","data-bv-between-message":"自定义顺序必须大于0","data-bv-between-min":"0", "data-bv-between-max":"99999999","data-bv-notempty-message":"自定义顺序不能为空"}/>
			<#if articleType?has_content>
				<@ms.checkboxlist name="checkbox" label="文章属性" list=articleType listKey="key"  listValue="value" />
			</#if>
			<@ms.formRow label="文章缩略图" width="400">
					<@ms.uploadImg path="upload/article/${appId}/" inputName="basicThumbnails" size="1" msg="提示:文章缩略图,支持jpg格式"  maxSize="2" imgs="${article.basicThumbnails?default('')}"  />
			</@ms.formRow>
			<@ms.text name="articleSource" width="200" label="文章来源" title="文章来源" size="5"  placeholder="请输入文章来源"  value="${article.articleSource?default('')}" />
			<@ms.text name="articleAuthor" width="200" label="文章作者" title="文章作者" size="5"  placeholder="请输入文章作者"  value="${article.articleAuthor?default('')}" />
			<#if !isEditCategory><!-- 如果不是单篇 -->
	            <@ms.formRow label="所属栏目" width="300">
	            	<@ms.treeInput treeId="inputTree" json="${listColumn?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" inputName="basicCategoryId" inputValue="${categoryId}" buttonText="${categoryTitle?default('选择栏目')}" clickZtreeId="clickZtreeId(event,treeId,treeNode);" expandAll="true"  showIcon="true"/>
				</@ms.formRow>
            </#if>
			<@ms.textarea name="basicDescription" label="描述" width="600" wrap="Soft" rows="4"  size=""  value="${article.basicDescription?default('')}" placeholder="请输入对该文章的简短描述，以便用户查看文章简略"/>
			<@ms.textarea name="articleKeyword" label="关键字" width="600" wrap="Soft" rows="4"  size="" placeholder="请输入文章关键字"   value="${article.articleKeyword?default('')}"/>
			<!--新填字段内容开始-->
			<div id="addFieldForm">		
			</div>
			<@ms.hidden name="articleTypeJson" />
			<@ms.editor name="articleContent" label="文章内容" content="${article.articleContent?default('')}"  appId="${appId?default(0)}"/>			
		</@ms.form>
	</@ms.panel>
</@ms.html5>	      
<script>
var articleBasicId=0;
$(function(){
	//页面标题
	var articleTitle="<#if categoryTitle?has_content>${categoryTitle}&nbsp;</#if><#if article.basicId !=0><small>编辑文章</small><#else><small>添加文章</small></#if>";
	$(".ms-content-body-title>span").html(articleTitle);	
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
	$(this).request({url:url,data:articleId,method:"post",func:function(data) {
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
			var buttonText=$(this).text(); //按钮中的值
			
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
					alert("自定义排序必须是数字");
					$("input[name=basicSort]").val(0);
					return;
				}
				$("#saveUpdate").attr("disabled",true);
				$(this).request({url:actionUrl,data:dataMsg,loadingText:seeMsg,method:"post",type:"json",func:function(obj) {
					if(obj.result){
						var generateUrl =  base+"${baseManager}/cms/generate/"+obj.resultMsg+"/genernateForArticle.do";
						$(this).request({url:generateUrl,loadingText:"生成中....",method:"post",type:"json",func:function(re) {
							if(re.result){
				   				<#if article.basicId !=0>
					   				alert("更新文章成功，并已生成" );
					   			<#else>
					   				alert("保存文章成功，并已生成" );
					   			</#if>
				   				if (obj.resultData!="") {
				   					location.href=managerPath+"/cms/article/"+obj.resultData+"/list.do";
				   				} 
				   				$("#saveUpdate").removeAttr("disabled");
				   			}else{
				   				//生产失败则将按钮信息返回默认
				   				alert("生成文件失败");
				   				$("#saveUpdate").removeAttr("disabled");
				   			}
						}}); 
				   		location.href=managerPath+"/cms/article/${categoryId?default(0)}/list.do";
				   		<@ms.notify msg="文章保存成功" type="success"/>
				   		$("#saveUpdate").removeAttr("disabled");
					}else{
				   		alert(obj.resultMsg);
				   		$("#saveUpdate").removeAttr("disabled");
					}
				}});
			}
		}else{
			alert("请选择文章所属栏目");
			$("#saveUpdate").removeAttr("disabled");
		}
	});	
});


//选择栏目后查询自定义模型
function clickZtreeId(event,treeId,treeNode){
	if(treeNode.columnType == 2){
		<@ms.notify msg="不能选择单篇栏目" />
		return false;
	}
	var url="${managerPath}/mdiy/contentModel/contentModelField/"+treeNode.categoryId+"/queryField.do";
	var basicId="basicId=${article.basicId?c?default(0)}";
	$(this).request({url:url,data:basicId,method:"post",func:function(data) {
		$("#addFieldForm").html("");
		$("#addFieldForm").html(data);
		$("select").select2();
	}});
} 
</script>