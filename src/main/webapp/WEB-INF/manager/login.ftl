<!DOCTYPE html>
<html lang="">

<head>
    <meta charset="UTF-8">
    <title></title>
    <meta charset="utf-8">
    <!--浏览器小图标-->
    <link rel="icon" href="http://cdn.mingsoft.net/global/images/ms.ico" type="x-icon">
    <script type="text/javascript" src="https://unpkg.com/vue@2.5.21/dist/vue.min.js"></script>
    <!--小图标-->
    <link rel="stylesheet" href="//at.alicdn.com/t/font_847907_mkdvd7gopsg.css">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <!--网络请求框架-->
    <script src="https://cdn.bootcss.com/axios/0.18.0/axios.min.js"></script>
    <script src="https://cdn.bootcss.com/qs/6.5.2/qs.min.js"></script>
    <!--铭飞-->
    <script src="http://cdn.mingsoft.net/ms/1.0/ms.js"></script>
    <script src="http://cdn.mingsoft.net/ms/1.0/ms.http.js"></script>
    <script src="http://cdn.mingsoft.net/ms/1.0/ms.util.js"></script>
    <link rel="stylesheet" href="${base}/static/ms-admin/4.7.0/less/ms.less">
    <link rel="stylesheet" href="${base}/static/ms-admin/4.7.0/css/login.css">
    <script>
        ms.base = "${base}";
        ms.manager = "${managerPath}";
    </script>
</head>

<body>
    <div id="login" class="login">
        <el-container class="ms-admin-login-container">
            <el-main class="ms-admin-login-main">
                <div class="ms-admin-login-warp">
                    <img :src="ms.base+'/static/ms-admin/4.7.0/images/login-slogn.png'">
                    <el-form :model="loginForm" status-icon :rules="loginFormRule" ref="loginForm" label-width="100px" class="ms-admin-login-form">
                        <h1><span>账户登录 / </span>User login</h1>
                        <el-form-item prop="name" class="ms-admin-form-item">
                            <el-input type="text" placeholder='用户名' v-model="loginForm.managerName" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item prop="pass" class="ms-admin-form-item">
                            <el-input type="password" placeholder='密码' v-model="loginForm.managerPassword" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item prop="code" class="ms-admin-form-item ms-admin-form-item-code">
                            <el-input type="text" placeholder='验证码' v-model="loginForm.rand_code" autocomplete="off"></el-input>
                            <img :src="code" class="code-img" @click="code" />
                            <p><span>看不清?</span><span>换一张</span></p>
                        </el-form-item>
                        <el-form-item class="ms-admin-form-item ms-admin-form-item-checkout">
                            <el-checkbox v-model="rememberPass">记住密码</el-checkbox>
                        </el-form-item>
                        <el-form-item class="ms-admin-form-item">
                            <el-button type="primary" @click="checkLogin" class="ms-admin-login-btn">登录</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </el-main>
        </el-container>
    </div>
</body>

</html>
<script>
var loginVue = new Vue({
    el: '#login',
    data: {
        loginForm: {
            managerName: '',
            managerPassword: "",
            rand_code: '',
        },
        code: ms.base + "/code?t=" + new Date().getTime(),
        rememberPass: '',
        loginFormRule: {
            managerName: [{
                    required: true,
                    message: '请输入用户名',
                    trigger: 'blur'
                },
                {
                    min: 3,
                    max: 6,
                    message: '长度在 3 到 5 个字符',
                    trigger: 'blur'
                }
            ],
            managerPassword: [{
                    required: true,
                    message: '请输入密码',
                    trigger: 'blur'
                },
                {
                    min: 6,
                    max: 20,
                    message: '长度在 6 到 20 个字符',
                    trigger: 'blur'
                }
            ],
            rand_code: [{
                    required: true,
                    message: '请填写验证码',
                    trigger: 'blur'
                },
                {
                    min: 1,
                    max: 4,
                    message: '长度在1 到 4 个字符',
                    trigger: 'blur'
                }
            ],
        }
    },
    methods: {
        // 登录
        checkLogin: function(form) {
            var that = this;
            ms.http.post(ms.base + "/ms/checkLogin.do", form).then(function(data) {
                if (data.result) {
                    that.$notify({
                        title: '成功',
                        message: '登录成功',
                        type: 'success'
                    });
                    location.href = ms.manager+"/index.do";
                } else {
                    that.$notify({
                        title: '失败',
                        message: data.resultMsg,
                        type: 'warning'
                    });
                }
            }, (err) => {
                that.$message.error(data.resultMsg);
            })
        },
        code: function() {
            code: ms.base + "/code?t=" + new Date().getTime();
        },

    },
    mounted: {


    }
})
</script>