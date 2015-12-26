<!DOCTYPE html>
<html lang="en">
<head>
	<#include "/manager/include/meta.ftl"/>
</head>
<style>
	.container{margin:0;padding:0;width:auto}
	hr{margin:0;padding:0;}
	.ms-button-group{padding:0px 0px 8px 0px}
	.margin20{margin-top:20px;}
	.row {margin-left:0;margin-right:0;padding-bottom:4px;}
	.form-horizontal .form-group{margin-left:0;margin-right:0}
	.control-label{font-weight:normal;font-size:14px;}
	.popover-content{min-width:205px;line-height:20px;}
	.control-label{width:15%;}
	.padding0{padding: 0;}
	.red{
		color:red;
	}
	.has-error .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#A94442;}
	.has-success .form-control-feedback{float:right; margin-top:-24px; margin-right:5px; color:#3C763D;}
</style>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-10 col-xs-10">
				<h3 class="page-title bottomLine">站点管理&nbsp;
					<#if website?has_content>
					<small>编辑站点</small>
					<#else>
					<small>添加站点</small>
					</#if>
				</h3>
			</div>
			<div class="col-md-2 col-xs-2 text-right">
				<button class="btn btn-default" role="button" onclick="javascript:history.go(-1)">返回站点列表</button>
			</div>
		</div>
		<hr>
		<div class="row margin20">	
			<form action="" class="form-horizontal" role="form" id="websiteForm">
				<!--网站标题-->
				<div class="form-group">
					<#if website?has_content>
					<input type="hidden" class="form-control" name="basicId"  value="">
					<input type="hidden" name="websiteManagerId" value="0"/>
					<#else>
					</#if>
					<label class="col-md-3 control-label col-xs-2" for="title">网站标题:</label>
					<div class="col-md-5  col-xs-5">
						<input type="text" class="form-control"  name="basicTitle"  data-toggle="popover" data-placement="right" data-content="网站标题，在30字以内">
					</div>
				</div>
				<!--网站logo-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-3">网站logo:</label>
					<div class="col-md-4 uploadImg  col-xs-6">
						<#if website?has_content> 
							<@uploadImg path="upload/website/${website.basicId?default(0)}/" inputName="basicThumbnails" size="1" filetype="" msg="提示:网站logo图片"  maxSize="1" imgs="${website.basicThumbnails?default('')}" />
						<#else> 
							<@uploadImg path="upload/website/" inputName="basicThumbnails" size="1" filetype="" msg="提示:网站logo图片"  maxSize="1" imgs="" />
						</#if>
					</div>
				</div>
				<!--域名:-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-3" for="url">域 名:</label>
					<div class="col-md-3  col-xs-4">
						<input type="text"  class="form-control" name="websiteUrl">
					</div>
				</div>
				<#if websiteStyle?has_content> 
				<#else>
					<!--模板风格-->
					<div class="form-group">
						<label class="col-md-2 control-label col-xs-3" for="style">模板风格:</label>
						<div class="col-md-3  col-xs-4">
							<input type="hidden" name="websiteStyle"/>
							<select class="form-control websiteStyle" ></select>
						</div>
					</div>
				</#if>
				<!--关键字-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-3" for="keyword">关键字:</label>
					<div class="col-md-6  col-xs-9">
						<textarea type="text" id="keyword" rows="4" class="form-control" name="websiteKeyword" ><#if website?has_content>${website.websiteKeyword}</#if></textarea>
					</div>
				</div>
				<!--描述-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-4">描述:</label>
					<div class="col-md-6  col-xs-9">
						<textarea class="form-control" rows="4" name="basicDescription"><#if website?has_content>${website.basicDescription}</#if></textarea>
					</div>
				</div>
				<!--版权信息-->
				<div class="form-group">
					<label class="col-md-2 control-label col-xs-4">版权信息:</label>
					<div class="col-md-6  col-xs-9">
						<textarea class="form-control" rows="4" name="websiteCopyright"><#if website?has_content>${website.websiteCopyright}</#if></textarea>
					</div>
				</div>
				<!--按钮组-->
				<div class="form-group">
					<div class="col-xs-2 col-md-2"></div>
					<div class="col-xs-2 col-md-1 padding0">
						<#if website?has_content>
							<button id="updateWebsite" type="button"  class="btn btn-success">修改</button>
						<#else>
							<button id="saveWebsite" type="button"  class="btn btn-success">保存</button>
						</#if>
	    				
	    			</div>
	    			
				</div>
			<form>
		</div>
	</div>
	
</body>
</html>
<script>

	//表单验证
	function checkForm(id){
		$(id).bootstrapValidator({
			feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
	       	fields: {
	       		//标题
	            basicTitle: {
	                validators: {
	                    notEmpty: { message: '网站标题不能为空'},
	                    stringLength: {min: 1,max: 50,message: '网站标题长度介于1-50个字符'},
	                }
	            },
	            websiteUrl: {
	                validators: {
	                	uri: {allowLocal: true,message: 'http://必须填写,请输入正确的网址'},
	                	stringLength: {min:8,max:40,message: '网站域名长度介于8-40个字符'}
	                }
	            },
	        }
	     });
	}
	var golbUrl =$("input[name='websiteUrl']").val();
	$(function() {
		//给各文本框赋值
		<#if website?has_content>
			$("input[name='basicId']").val("${website.basicId?default()}");
			$("input[name='websiteManagerId']").val("${website.websiteManagerId?default()}");
			//网站标题
			$("input[name='basicTitle']").val("${website.basicTitle?default('')}");
			//网站域名
			$("input[name='websiteUrl']").val("${website.websiteUrl?default('')}");
			//网站模板风格
			$(".websiteStyle").find("option:selected").text("${website.websiteStyle?default('')}");
			$("input[name='websiteStyle']").val("${website.websiteStyle?default('')}");
			golbUrl="${website.websiteUrl?default('')}"
		</#if>
		<#if websiteStyle?has_content> 
		<#else>
			//ajax请求让用户要选择的模板风格
			$.ajax({
			   type: "post",
			   dataType: "json",
			   url:  "${base}/manager/cms/templet/queryTempletSkinForWebsiteStyle.do",
			   success: function(msg){
			     	if(msg.fileName != null && msg.fileName.length != 0 && $(".websiteStyle").html() == ""){
			   			for(var i=0; i<msg.fileName.length; i++){
				   			$(".websiteStyle").append("<option>"+msg.fileName[i]+"</option>")
				   		}
			   		} else {
			   			$(".websiteStyle").append("<option>暂无模版</option>");
			   		}
			   }
			});
		</#if>
		
		//判断域名是否重复
		$("input[name='websiteUrl']").blur(function(){
			if(golbUrl!=$("input[name='websiteUrl']").val() && $("input[name='websiteUrl']").val()!=""){
				var websiteUrl= $("input[name='websiteUrl']").val();
				$.ajax({
				   	type: "post",
				   	url: "${base}/manager/cms/website/checkUrl.do",
				   	dataType:"json",
				   	data:"websiteUrl="+websiteUrl,
				   	success: function(msg){
				   		if(msg){
				   			alert("域名已存在,请重新输入");
				   			$("input[name='websiteUrl']").val("");
				   		}
				   	}
				});
			}
			
		});
		checkForm("#websiteForm");
		$("#updateWebsite").click(function(){
			if($("#websiteForm").data('bootstrapValidator').validate().isValid()){
				if($(".websiteStyle").find("option:selected").text()=="暂无模版"){
					$("input[name='websiteStyle']").val();
				}else{
					$("input[name='websiteStyle']").val($(".websiteStyle").find("option:selected").text());
				}
				var formdata = $("#websiteForm").serialize();
				$.ajax({
				   	type: "post",
				   	url: "${base}/manager/cms/website/update.do",
				   	data: formdata,
				   	dataType:"json",
				   	success: function(msg){
				   		
				   		if(msg.result){
				   			
				   			alert("更新成功");
				   			$("#updateWebsite").attr("disabled", true);
				   			if(msg.resultData==1){
				    			location.href="${base}/manager/cms/website/listForSuper.do?pageNo="+msg.resultMsg;
				    		}else{
				    			location.href="${base}/manager/cms/website/listManager.do";
				    		}
				   		}else{
				   			alert(msg.resultMsg);
				   		}
				    	
				   	}
				});
			}
		});
		
		
		//点击保存时,先判断验证是否通过,再提交信息
		$("#saveWebsite").click(function(){	
			if($("#websiteForm").data('bootstrapValidator').validate().isValid()){
				if($(".websiteStyle").find("option:selected").text()=="暂无模版"){
					$("input[name='websiteStyle']").val();
				}else{
					$("input[name='websiteStyle']").val($(".websiteStyle").find("option:selected").text());
				}
				var formdata = $("#websiteForm").serialize();
				$.ajax({
			   		type: "post",
			   		url: "${base}/manager/cms/website/save.do",
			   		dataType:"json",
			   		data: formdata,
			   		success: function(msg){
			     		if (msg.result) {
			     			alert("保存成功");
			     			$("saveWebsite").attr("disabled", true);
			    			location.href="${base}/manager/cms/website/listForSuper.do";
			    		}else {
			    			alert(msg.resultMsg);
			    		}
			   		}
				});
			}
		});
	});
</script>
