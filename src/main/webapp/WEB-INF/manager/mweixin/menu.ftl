<!DOCTYPE html>
<html>
   <head>
      <title></title>
      <!-- <#include "/include/head-file.ftl"/> -->
      <!--#include virtual="../include/head-file.ftl" -->
      <link rel="stylesheet" href="../../../static/mweixin/css/menu.css">
   </head>
   <body>
      <div id="app">
         <!--左侧-->
         <div class="ms-admin-title">
            <i></i> 吕小布微信号
         </div>
         <el-menu class="ms-weixin-menu" default-active="0">
            <el-submenu :index="i+''" v-for="(menu,i) in menuList" @click="menuActive = menu">
               <template slot="title">
                  <span v-text="menu.title"></span>
               </template>
               <el-menu-item-group>
                  <el-menu-item class="ms-weixin-menu-item" :index="i+'-'+index" v-for="(sub,index) in menu.sub" v-text="sub.title"></el-menu-item>
               </el-menu-item-group>
            </el-submenu>
         </el-menu>
      </div>
   </body>
</html>

<script>
   new Vue({
      el: "#app",
      data: {
         menuList: [{
            title: '图文素材',
            sub: [{
               title: '图文'
            }, {
               title: '图片'
            }],
         }, {
            title: '自定义菜单',
            sub: [{
               title: '文章管理'
            }, {
               title: '栏目管理'
            }]
         }, {
            title: '自动回复',
            sub: [{
               title: '关注时回复'
            }, {
               title: '消息回复'
            }, {
               title: '关键字回复'
            }]
         }, ], //左侧导航列表
      }
   })
</script>