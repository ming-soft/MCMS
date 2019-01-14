<!DOCTYPE html>
<html lang="en">
<head>
<#include "${managerViewPath}/include/meta.ftl"/>
<title><#if app?has_content>${app.appName}<#else>MS</#if>管理系统${managerViewPath}</title>
<link rel="shortcut icon" href="${static}/global/images/ms.ico"/>     
<link rel="bookmark" href="${static}/global/images/ms.icoo"/> 
<script type="text/javascript" src="http://cdn.mingsoft.net/plugins/vue/2.3.3/vue.min.js"></script>
<script type="text/javascript" src="http://cdn.mingsoft.net/plugins/validator/5.5.0/validator.min.js"></script>
<link rel="stylesheet/less" type="text/css" href="${static}/skin/manager/${manager_ui}/less/login.less" media="all" />
<script type="text/javascript" src="http://cdn.mingsoft.net/plugins/less/2.5.3/less.min.js" ></script>
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
        <#if app?has_content>
        <div id="mcms-login">
            <img src="${static}/skin/manager/${manager_ui}/images/pic.png" class="login-images login-float" />
            <div class="login-form-container login-float">
                <div class="login-title">
                    <span class="login-chinese-title">账号登录 /</span>
                    <span class="login-english-title">User login</span>
                </div>
				<div class="ms-login-error-text">
					<img src="${static}/skin/manager/${manager_ui}/images/error.png" v-show="errorText != ''" />
					<span v-text="errorText" v-show="errorText != ''"></span>
				</div>
                <form class="form-horizontal" id="loginForm" action="${managerPath}/checkLogin.do">
                    <input type="text" maxlength="12" class="login-people-name" :class="{'ms-error':error == 'peopleName'}" id="managerName" name="managerName" @blur="checkPeopleName" @keyup="chanageBackgroundColor" placeholder="用户名" v-model="peopleName" />
                    <input type="password" maxlength="20" class="login-people-name" :class="{'ms-error':error == 'peoplePassword'}" id="managerPassword" name="managerPassword" @blur="checkPeoplePassword" @keyup="chanageBackgroundColor" placeholder="密码" v-model="peoplePassword" />
                    <div class="login-code">
                        <input type="text" onKeyUp ="value=value.replace(/[\W]/g,'')" maxlength="4" class="login-float login-code-input" :class="{'ms-error':error == 'rand_code'}" id="rand_code" name="rand_code" @blur="checkCode" @keyup="chanageBackgroundColor" placeholder="验证码" v-model="code" />
                        <img id="ms-login-code" class="login-code-img login-float" src="${basePath}/code" @click="changeCode"/>
                        <p class="login-float login-code-text">
                            <span>看不清?</span><br/>
                            <spna class="login-code-change" @click="changeCode">换一张</span>
                        </p>
                    </div>
                    <p  class="login-remmember-password">
                        <input id="remember" type="checkbox" name="" />
                        <label class="login-remember" for="remember">记住密码</label>
                    </p>
                    <div  id="login-button" class="login-button"  v-on:click="toLogin">登录</div>
                </form>
            </div>
        </div>
        <#else>
            <div id="errorDisplay">
        	    <img src="${static}/skin/manager/${manager_ui}/images/errorDisplay.png"/>
        	    <div class="errorData">
        	    <p >系统配置异常，请手动去掉WEB-INF/ms.install.bak文件的后缀.bak，再重启系统进入登录界面进行初始化</p>
        	    </div>
        	<div>

        </#if>
    </body>
   
	<script>
	    
        var loginForm = new Vue({
            el:'#mcms-login',
            data:{
                isRight: true,
                errorText:"",//错误提示
                error:"",//输入框错误的显示
                peopleName:"",//用户名输入框
                peoplePassword:"",//密码输入框
				code:"",//验证码
            },
            watch: {
				peopleName: function() {
                    var pattern = /[^\w\u4E00-\u9FA5]/ig;
                    if(!validator.isNull(this.peopleName) && this.peopleName.indexOf(" ") < 0 && validator.isLength(this.peopleName, {min:6,max:20}) && pattern.test(this.peopleName) == false && this.error == 'peopleName'){
                        this.errorText = "";
                        this.error = "";
					}
				},
                peoplePassword: function() {
                    if(!validator.isNull(this.peoplePassword) && this.peoplePassword.indexOf(" ") < 0 && validator.isLength(this.peoplePassword, {min:6,max:20}) && this.error == 'peoplePassword'){
                        this.errorText = "";
                        this.error = "";
					}
				},
				code: function(){
					if(!validator.isNull(this.code) && this.code.length == 4 && this.error == 'rand_code'){
						this.errorText = "";
                        this.error = "";
					}
				}
			},
			mounted: function() {
			      var _this = this;
		          //页面初始化时，如果帐号密码cookie存在则填充
                  if($.cookie('managerName') && $.cookie('managerPassword')){
                      _this.peopleName = $.cookie('managerName');
                      _this.peoplePassword = $.cookie('managerPassword');
                      $("#remember").attr("checked",true);
                  }
			      //检测浏览器版本
			      if (navigator.userAgent.toLowerCase().indexOf("msie") > 0) {
			      	    alert("您当前的浏览器版本太低，建议使用IE8以上版本浏览器，推荐使用Chrome浏览器");
			      }
			      
			      //js监听回车键 
			      document.onkeydown = function(e) {
			      	e = e ? e : window.event;
			      	var keyCode = e.which ? e.which : e.keyCode;
			      	if (keyCode == 13) {
			      		_this.login(); 
			      	}
			      }
			},
            methods:{
                //错误提示显示
                errorShow:function(msg,type){
                    this.errorText = msg;
                    this.error = type;
                },
                changeCode:function(){
                	$("#ms-login-code").attr("src","${basePath}/code?t="+new Date().getTime())
                },
                //判断用户名
                checkPeopleName:function(){
                    var pattern = /[^\w\u4E00-\u9FA5]/ig;
					if(validator.isNull(this.peopleName)){
						this.errorShow("用户名不能为空",'peopleName');
						this.isRight = false;
						return;
					}else if(this.peopleName.indexOf(" ") >= 0) {
						this.errorShow("用户名不能包含空格",'peopleName');
						this.isRight = false;
						return;
					}else if(!validator.isLength(this.peopleName, {min:3,max:12})){
						this.errorShow("用户名为3~12个字符",'peopleName');
						this.isRight = false;
						return;
					}else if(pattern.test(this.peopleName)){
                        this.errorShow("用户名不能包含特殊字符",'peopleName');
                        this.isRight = false;
						return;
                    }
                },
                //判断密码
                checkPeoplePassword:function(){
                    if(validator.isNull(this.peoplePassword)){
						this.errorShow("密码不能为空",'peoplePassword');
						this.isRight = false;
						return;
					}else if(!validator.isLength(this.peoplePassword, {min: 6,max: 20})){
						this.errorShow("密码长度在6~20位之间!",'peoplePassword');
						this.isRight = false;
						return;
					}else if(this.peoplePassword.indexOf(" ") >=0){
                        this.errorShow("密码是不能包含空格",'peoplePassword');
                        this.isRight = false;
						return;
					}
                },
				//判断验证码
                checkCode:function(){
                    if(validator.isNull(this.code)){
						this.errorShow("验证码不能为空",'rand_code');
						this.isRight = false;
						return;
					}else if(this.code.length != 4){
						this.errorShow("验证码为4位!",'rand_code');
						this.isRight = false;
						return;
					}
                },
                //登录判断验证
                checkLogin:function(){
                    this.checkPeoplePassword();
                    this.checkPeopleName();
                    this.checkCode();
                },
                //验证登录数据
                login:function(){
                    loginForm.checkLogin(); 
		            if(this.isRight){
		                $("#login-button").html("正在登录");
		                $("#login-button").attr("style","pointer-events: none;");
				        $(this).postForm("#loginForm",{loadingText:"正在登录中..",func:function(data) {
    				        if(data.result){
    					    location.href=base+"${baseManager}/index.do";
    				            }else{
    				        alert(data.resultMsg);
    				        $("#ms-login-code").attr("src","${basePath}/code?t="+new Date().getTime())
    				        $("#login-button").html("登录");
    				        $("#login-button").attr("style","pointer-events: auto;");
    				        $("#login-button").css({"background-color":"#0099ff"});
				        };
				        }});
				     }else{
				         this.isRight=true;
				        
				          }
                     },
                   //删除cookies
                delCookies: function(names){
                     for(i=0;i<names.length;i++){
                     $.cookie(names[i],null,{ expires: -1 });
                     }
                  },
                  //删除并且修改cookies
                delAndSetCookies: function(names,values,date){
                     this.delCookies(names);
                     for(i=0;i<values.length;i++){
                        $.cookie(names[i], values[i], { expires: date });
                     }
                  },
                  //改变登录按钮背景色
                chanageBackgroundColor: function(){
                     if($("#managerName").val().length >= 3 &&　$("#managerPassword").val().length >= 6 && $("#rand_code").val().length == 4){
                         $("#login-button").css({"background-color":"#0099ff"});
                     }else{
                          $("#login-button").css({"background-color":"#eeeeee"});
                     }
                  },
                  //点击登录方法
                toLogin: function(){
                     var names=new Array('managerName','managerPassword');
			         var values=new Array($("#managerName").val(),$("#managerPassword").val());
			         if($("#remember").is(":checked")){ 
                         this.delAndSetCookies(names,values,1);
                     }else{
                         this.delCookies(names);
                     }
                         this.login();
                     }
                 
                       
            }
            
			
        })
		
	</script>
   
</html>
