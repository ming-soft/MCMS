<!DOCTYPE html>
<html lang="zh">
 <head>
<#include "/manager/include/macro.ftl"/>
<#include "/manager/include/meta.ftl"/>
</head>

<body>	
<@ms.content>
<@ms.contentBody width="" >
	<@ms.contentNav title="" >
		<@ms.savebutton  id="saveUpdate" value=""/>
		<@ms.contentNavBack  class="btn btn-default returnList" value="返回列表" />
	</@ms.contentNav >
	<@ms.contentPanel>
		<@ms.form class="aritcleForm searchForm" isvalidation=true name="articleForm" action="">

			<@ms.text name="basicTitle"  style="width: 30%;"  label="文章标题" title="文章标题" size="5"  placeholder="请输入文章标题"  value="${article.basicTitle?default('')}" labelStyle="width:15%" validation={"maxlength":"300","required":"true", "data-bv-notempty-message":"文章标题不能为空","data-bv-stringlength-message":"标题在300个字符以内!"}/>
			<@ms.text name="basicSort"   style="width: 10%;"  label="自定义顺序" title="自定义顺序" size="5"  placeholder="请输入文章顺序" value="${article.basicSort?c?default(0)}" labelStyle="width:15%" validation={"data-bv-between":"true","data-bv-between-message":"自定义顺序必须大于0","data-bv-between-min":"0", "data-bv-between-max":"99999999","data-bv-stringlength-message":"自定义顺序不能为空"}/>
			<#if articleType?has_content>
				<@ms.checkboxlist name="checkbox" label="文章属性" style="position: relative;"  list=articleType listKey="key"  listValue="value"   labelStyle="width:15%"/>
			</#if>
			<div class="form-group">
        			<label class="col-md-3  col-xs-3" style="width:15%">文章缩略图</label>
        			<div class="col-md-4  col-xs-4" style="padding: 0;">
						<@uploadImg path="upload/article/${websiteId}/" inputName="basicThumbnails" size="1" filetype="" msg="提示:文章缩略图,支持jpg格式"  maxSize="2" imgs="${article.basicThumbnails?default('')}"  />
					</div>
            </div>
			<@ms.text name="articleSource"  style="width: 20%;"  label="文章来源" title="文章来源" size="5"  placeholder="请输入文章来源"  value="${article.articleSource?default('')}"  labelStyle="width:15%"/>
			<@ms.text name="articleAuthor"   style="width: 15%;" label="文章作者" title="文章作者" size="5"  placeholder="请输入文章作者"  value="${article.articleAuthor?default('')}"  labelStyle="width:15%"/>
			<@ms.text name="articleUrl"   style="width: 20%;"  label="跳转网址" title="跳转网址" size="5"  placeholder="http://"  value="${article.articleUrl?default('')}"  labelStyle="width:15%"/>
			<#if !isEditCategory><!-- 如果不是单篇 -->
			<div class="form-group" style="overflow: inherit; min-height: 39px;">
        		<label class="col-md-3  col-xs-3" style="width:15%;">所属栏目</label>
        		<div class="col-md-4  col-xs-4" style="padding: 0;">
					<@ms.treeInput treeId="inputTree" json="${listColumn?default('')}" jsonId="categoryId" jsonPid="categoryCategoryId" jsonName="categoryTitle" buttonText="${categoryTitle?default('选择栏目')}" clickZtreeId="clickZtreeId(event,treeId,treeNode);" inputName="basicCategoryId"  inputValue="${categoryId}" expandAll="true" showIcon="true"/>
 				</div>
            </div>
            </#if>
			<@ms.textarea name="basicDescription" label="描述"  wrap="Soft" rows="4"  size=""  value="${article.basicDescription?default('')}" placeholder="请输入对该文章的简短描述，以便用户查看文章简略" labelStyle="width:15%"/>
			<@ms.textarea name="articleKeyword" label="关键字" wrap="Soft" rows="4"  size="" placeholder="请输入文章关键字"   value="${article.articleKeyword?default('')}" labelStyle="width:15%"/>
			<!--新填字段内容开始-->
			<div id="addFieldForm">
					
			</div>
			<!--新增属性开始-->
			<div id="articleTypeField">
			</div>
			<input name="articleTypeJson" type="hidden" value=""/>
			<@ms.editor name="articleContent" label="文章内容" content="${article.articleContent?default('')}" labelStyle="width:15%" width="688px;"/>			
		</@ms.form>
	</@ms.contentPanel>
</@ms.contentBody>
</@ms.content>        

</body>


<script>
var articleBasicId=0;
$(function(){
	//页面标题
	var articleTitle="<#if categoryTitle?has_content>${categoryTitle}&nbsp;</#if><#if article.basicId !=0><small>编辑文章</small><#else><small>添加文章</small></#if>";
	$(".ms-content-body-title>span").html(articleTitle);	
	//隐藏跳转地址
	$("input[name='articleUrl']").parent().hide();
	//返回列表
	$(".returnList").click(function(){
		location.href = base+"/manager/cms/article/${categoryId}/list.do";
	});	
	
	//文章属性
	var actionUrl="";
	
	<#if article.basicId !=0>
	$("#saveUpdate").text("更新");
	actionUrl = "${base}/manager/cms/article/${article.basicId?c?default(0)}/update.do";
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
	$("#saveUpdate").text("保存");
	actionUrl = "${base}/manager/cms/article/save.do";
	</#if>	
	
	//获取当前栏目的自定义模型
	var url="${base}/manager/cms/field/"+${categoryId?default(0)}+"/queryField.do";
	var articleId="basicId="+${article.basicId?c?default(0)};
	$(this).request({url:url,data:articleId,method:"post",func:function(data) {
		$("#addFieldForm").html(data);
		$("select").select2();
	}});
	//获取当前栏目的自定义属性
	var url="${base}/manager/cms/type/"+${categoryId?default(0)}+"/"+articleBasicId+"/queryByCategoryId.do";
	$(this).request({url:url,method:"post",func:function(data) {
		$("#articleTypeField").html(data);
		$("select").select2();
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
		$("#saveUpdate").attr({"disabled":"disabled"});
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
				$(this).request({url:actionUrl,data:dataMsg,loadingText:seeMsg,method:"post",type:"json",func:function(obj) {
					if(obj.result){
						var generateUrl =  base+"/manager/cms/generate/"+obj.resultMsg+"/genernateForArticle.do";
						$(this).request({url:generateUrl,loadingText:"生成中....",method:"post",type:"json",func:function(re) {
							if(re.result){
				   				<#if article.basicId !=0>
					   				alert("更新文章成功，并已生成" );
					   			<#else>
					   				alert("保存文章成功，并已生成" );
					   			</#if>
				   				if (obj.resultData!="") {
				   					location.href=base+obj.resultData;
				   				} else {
				   					$("#saveUpdate").text("更新");
				   				}
				   				$("#saveUpdate").removeAttr("disabled");
				   			}else{
				   				//生产失败则将按钮信息返回默认
				   				$("#saveUpdate").text(buttonText);
				   				alert("生成文件失败");
				   				$("#saveUpdate").removeAttr("disabled");
				   			}
						}});
					}else{
						$("#saveUpdate").text(buttonText);
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
		alert("不能选择单篇栏目");
		return false;
	}
	var url="${base}/manager/cms/field/"+treeNode.categoryId+"/queryField.do";
	var basicId="basicId=${article.basicId?c?default(0)}";
	$(this).request({url:url,data:basicId,method:"post",func:function(data) {
		$("#addFieldForm").html("");
		$("#addFieldForm").html(data);
		$("select").select2();
	}});
	//获取当前栏目的自定义属性
	var url="${base}/manager/cms/type/"+treeNode.categoryId+"/"+articleBasicId+"/queryByCategoryId.do";
	$(this).request({url:url,method:"post",func:function(data) {
		$("#articleTypeField").html("");
		$("#articleTypeField").html(data);
		$("select").select2();
	}});
} 
</script>
</html>














