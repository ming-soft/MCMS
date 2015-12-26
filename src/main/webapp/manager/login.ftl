<!DOCTYPE html>
<html lang="zh">
<head>
	<title><#if app?has_content>${app.appName}<#else>MS</#if>管理系统</title>
	<link rel="shortcut icon" href="/images/ms.ico"/>     
	<link rel="bookmark" href="/images/ms.ico"/> 
	<#include "/manager/include/meta.ftl"/>
	<link rel="stylesheet" type="text/css" href="${base}/css/login.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${base}/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${base}/css/supersized.css">
	<link rel="stylesheet" type="text/css" href="${base}/css/style.css">
	<script type="text/javascript" src="${base}/jquery/supersized.3.2.7.min.js"></script>
	<script type="text/javascript" src="${base}/jquery/supersized-init.js"></script>
	<script type="text/javascript" src="${base}/jquery/scripts.js"></script>
	<script>
		if(top.location != location){  
		    top.location.href= location.href;  
		}  
	</script>
</head>
<style>
	.gray{background:#92908E}
</style>
<body>
	<div class="page-container">
		<#if app?has_content>
        <h1>MS<#if app?has_content>-${app.appName}</#if></h1>
        <div class="row" style="margin:0px;">
        
	        <form class="form-horizontal" id="loginForm" action="${base}/ms/checkLogin.do">
	            <input type="text" name="managerName" class="managerName"  placeholder="用户名" value="" autofocus/>
                <div style="color:#F00; margin-top:10px; display:none;" id="show">用户名不能为空</div>
	            <input type="password" name="managerPassword" style="  margin-top: 10px;" class="managerPassword" placeholder="密&nbsp;&nbsp;&nbsp;&nbsp;码"  value=""/>
	            <div style="color:#F00; margin-top:10px; display:none;" id="show1">密码不能为空</div>
	            
	            <button id="loginBtn" type="button">登录</button>
	        </form>
        </div>
        <#else>
        	系统配置错误！详细看论坛常见问题贴:<a href="http://ms.ming-soft.com/mbbs/13000/detail.do" target="_blank">点击查看</a>
        </#if>
    </div>
	
	<script type="text/javascript">    	
		//统计错误次数
		var count = 0;
		//验证表单是否正确
		var flag = false;
		var webUrl = "<#if app?has_content>${app.appName}</#if>";
			
		function login(){
			
			if(flag){
				$("button").addClass("gray");
				$(this).postForm("#loginForm",{loadingText:"正在登录中..",func:function(data) {
    				if(data.result){
    					location.href=base+"/manager/index.do";
    				}else{
    					alert("登陆失败，请检查帐号密码是否正确。");
    					count++;
    					$("button").css("background","#EF4300");
				   		$("button").html("登录");
				    	$(".managerName").val(null);
				    	if(count >=4){
								$("input").val(null);
								$("button").css("background","#EF4300");
				   				$("button").html("登录");
								$("input").attr("readonly","readonly");
								alert("您输入次数太多，请10秒后再输 ...");
								setTimeout(function(){
									$("input").removeAttr("readonly")
								},1000*10); 
						} 	
    				}
				}});
			}
		}
			
		$(function(){	
			//检测浏览器版本
			if (navigator.userAgent.toLowerCase().indexOf("msie") > 0) {
				    alert("您当前的浏览器版本太低，建议使用IE8以上版本浏览器，推荐使用Chrome浏览器");
			}	
			//验证表单
			$(".managerName").focus(function(){
				$("#show").hide();flag = true;
			});
			$(".managerName").blur(function(){
				var managerName = $(".managerName").val();
				if(managerName.replace(/\s+/g,"") == ""){
					$("#show").show();$(this).val(null);flag = false;
				}else if(managerName.length > 20){
					$("#show").show();$("#show").html("用户名长度介于1-12个字符");flag = false;
				} else {
					$("#show").hide();flag = true;
				}
			 });
			 $(".managerPassword").focus(function(){
				$("#show1").hide();flag = true;
			 });
			 $(".managerPassword").blur(function(){
				var managerPassword = $(".managerPassword").val();
				if(managerPassword.replace(/\s+/g,"") == ""){
					$("#show1").show();$(this).val(null);flag = false;
				}else if(managerPassword.length > 20){
					$("#show1").show();$("#show1").html("密码长度介于1-16个字符");flag = false;
				} else {
					$("#show1").hide();flag = true;
				}
			});
			
			//js监听回车键 
			document.onkeydown = function(e) {
				e = e ? e : window.event;
				var keyCode = e.which ? e.which : e.keyCode;
				if (keyCode == 13) {
					login(); 
				}
			}
			
			//点击登录
			$("#loginBtn").click(function() {
				login();
			});	
			
		})
	</script>
	
</body>
</html>
