<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>登录</title>
      <#include "/include/head-file.ftl"/>
	  <script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
	  <link rel="stylesheet" href="${base}/static/css/login.css">
   </head>
   <body>
      <div id="app">
         <el-container>
            <el-header class="ms-header" height="100px">
               <img src="${base}/static/images/logo.png">
               <p>铭飞科技</p>
               <em></em>
               <span>欢迎登录</span>
            </el-header>
            <el-main class="ms-body">
               <div class="ms-login">
                  <div class="ms-login-tab">
                     <span @click="loginActive='1'" :class="{'active':loginActive=='1'}">账号登录</span>
                     <em></em>
                     <span @click="loginActive='2'" :class="{'active':loginActive=='2'}">扫码登录</span>
                  </div>
                  <!--账号登录-->
                  <el-form ref="form" :model="form" :rules="loginFormRule" label-width="0px" v-if="loginActive=='1'">
                     <el-form-item prop="username">
                        <el-input type="text" v-model="form.username" placeholder="用户名">
                        	<template slot="append">@qq.com</template>
                        </el-input>
                     </el-form-item>
                     <el-form-item prop="password">
                        <el-input type="password" v-model="form.password" placeholder="密码"></el-input>
                     </el-form-item>
                     <el-form-item>
                        <el-button type="primary" width="100%" @click="login()" class="ms-login-but">登录</el-button>
                     </el-form-item>
                  </el-form>
                  <!--扫码登录-->
                  <div v-show="loginActive=='2'" class="ms-login-code" id="login_container">
                     <img src="${base}/static/images/code.png"/>
                     <span>请使用微信扫码二维码登录</span>
                     <a>" 铭飞MS平台 "</a>
                  </div>

                  <!--扫码登录成功-->
                  <div v-if="loginActive=='3'" class="ms-login-code-success">
                     <img class="phone" src="${base}/static/images/phone.png" />
                     <img class="success" src="${base}/static/images/success.png" />
                     <span>扫码成功!</span>
                     <span>请在手机上确认登录</span>
                     <a @click="loginActive='2'">返回二维码</a>
                  </div>
               </div>
            </el-main>
            <el-footer class="ms-footer">
               <div>
                  <span>关于我们</span>
                  <em></em>
                  <span>发展历程</span>
                  <em></em>
                  <span>联系我们</span>
               </div>
               <div>
                  版权所有 ©铭飞科技有限公司2012-2019 保留一切权利。
               </div>
            </el-footer>
         </el-container>
      </div>
   </body>
</html>
<script>
   new Vue({
      el: "#app",
      data: {
    	  form: {
            username: "",
            password: "",
         },
         loginActive: "1", //登录方式选中
         loginFormRule: {
            username: [{
               required: true,
               message: '请输入用户名',
               trigger: 'change'
            }, ],
            password: [{
               required: true,
               message: '请输入密码',
               trigger: 'change'
            }, ], //表单验证
         }
      },
      methods: {
         //点击登录
         login: function() {
        	var that = this;
            //调用表单验证
            this.$refs.form.validate(function(valid) {
            	if(valid) {
                  	//验证成功
                  	var people = {
                  		username : that.form.username + "@qq.com",
                  		password : that.form.password
                  	}
                  	ms.http.post(ms.base + "/sso/login.do", people)
					.then(function(json) {
			            if(json.result){
			            	window.location.href=decodeURIComponent(ms.util.getParameter("backurl"));
		            	}else{
		            		alert("登陆失败，\n1、账号或密码错\n2、或账号没有设置密码，请先扫描登陆后设置密码后重试");   
		            	}
			         }), function(err) {
						console.log(err)
					 }
               } else {
                  //验证失败
               }
            });
         }
      },
	  mounted: function(){
		var obj = new WxLogin({
               id:"login_container", 
               appid: "wx8c96aa3db4611395", 
               scope: "snsapi_login", 
               redirect_uri: "http%3A%2F%2Fms.mingsoft.net%2Fsso%2Fweixin.do%3Fbackurl%3D"+decodeURIComponent(ms.util.getParameter("backurl")), 
               state:"",
               style: "black", 
               href: "" 
             });
	  }
   })
</script>