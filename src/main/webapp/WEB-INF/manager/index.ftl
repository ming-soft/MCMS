<!DOCTYPE html>
<html>
   <head>
      <title></title>
          <!-- <#include "/include/head-file.ftl"/> 
         <#include "/reset-password.ftl"/>
        <#include "/exit-system.ftl"/>  -->
        <link rel="stylesheet" href="${base}/static/ms-admin/4.7.0/css/index.css">
     
    <!--#include virtual="include/head-file.ftl" -->
    <!--#include virtual="./reset-password.ftl" -->
    <!--#include virtual="./exit-system.ftl" --> 
    <!--
    <link rel="stylesheet" href="../../../static/ms-admin/4.7.0/css/index.css">

   </head>
   <body>
      <div id="app" class="index">
         <el-container>
            <!--头部-->
            <el-header class="ms-admin-header">
               <el-aside width="200px" class="ms-admin-logo">
                  <img :src="ms.base+'/static/ms-admin/4.7.0/images/logo.png'" />
                  <div>
                     <img :src="ms.base+'/static/ms-admin/4.7.0/images/version.png'" />
                     <span>v4.6.3</span>
                  </div>
               </el-aside>

               <!--头部menu-->
               <el-menu class="ms-admin-header-menu" :default-active="0+''" mode="horizontal" >
                  <el-menu-item 
                    class="ms-admin-menu-item" 
                    :index="i+''" 
                    v-for="(menu,i) in mainParentMenuList" 
                    :key='i'
                    @click="openMenu(menu,i)"
                    v-text="menu.modelTitle"
                ></el-menu-item>
                  <el-menu-item class="ms-admin-menu-item" :index="menuList.length+''" @click=''>
                     <i class="iconfont icon-gengduo" @click.stop.self='shortcutMenu = !shortcutMenu'></i>
                  </el-menu-item>
                   <!-- 快捷菜单 -->
                   <ul class="ms-admin-shortcut-menu" v-show='shortcutMenu'>
                        <li v-for="(item,index) of parentMenuList" 
                            :key='index'
                             v-text='item.modelTitle' 
                             @click='openMenu(item,index)'
                             ></li>
                        <i class="iconfont icon-gengduo" @click.stop.self='shortcutMenu = !shortcutMenu'></i>
                    </ul>
               </el-menu>

               <!--头部右侧-->
               <el-main class="ms-admin-mstore">
                  <!--登录-->
                  <el-dropdown trigger="click" class="ms-admin-login" placement="top-start" @visible-change="loginDown = !loginDown">
                     <span class="el-dropdown-link" :class="{'active':loginDown}">
                        <img src="http://cdn.mingsoft.net/global/static/ms-admin/4.7.0//msheader.png" />
                        <span v-text='peopleInfo.managerName'></span>
                     </span>
                     <el-dropdown-menu class="ms-admin-login-down" slot="dropdown" @click.native='openModal'>
                        <el-dropdown-item>修改密码</el-dropdown-item>
                        <el-dropdown-item>退出</el-dropdown-item>
                     </el-dropdown-menu>
                  </el-dropdown>
                  <!--mstore按钮-->
                  <div class="ms-admin-mstore-icon">
                     <i class="iconfont icon-gengduo1"></i>
                  </div>
               </el-main>

            </el-header>
            <el-container class="ms-admin-container">
               <!--菜单-->
               <el-aside :class="['ms-admin-menu-aside',{'ms-admin-menu-aside-active':collapseMenu}]">
                  <el-menu 
                    :class="['ms-admin-menu',{'ms-admin-menu-active':collapseMenu}]" 
                    :default-active="menuActive"
                    :collapse="collapseMenu" 
                    mode='vertical' 
                    :collapse-transition='true' 
                    :unique-opened='true' 
                    ref='menu'
                    :default-openeds='subMenuList'
                    >
                     <el-submenu 
                        :index="i+''" 
                        v-for="(menu,i) in parentMenuList"
                        :key='i'
                        >
                        <template slot="title">
                           <i class="iconfont" :class="iconType(menu.modelTitle)"></i>
                           <span v-text="menu.modelTitle"></span>
                        </template>
                        <!-- 子菜单 -->
                        <el-menu-item 
                            :index="i+'-'+index" 
                            v-for="(sub,index) in getSubMenu(menu.modelId)" 
                            :key='sub.modelModelId'
                            v-text="sub.modelTitle"
                            @click.self='open(sub.modelTitle,sub.modelUrl)'
                        ></el-menu-item>
                     </el-submenu>
                     <!-- 收缩按钮 -->
                     <div :class="['ms-menu-expand',{'ms-menu-expand-active':collapseMenu}]" @click='collapseMenu = !collapseMenu'>
                        <i class="iconfont icon-shousuo"></i>
                     </div>
                  </el-menu>
               </el-aside>
               <!--内容-->
               <el-main class="ms-admin-main">
                  <!--选项卡-->
                  <el-tabs 
                    class="ms-admin-tabs" 
                    v-model="currentTab" 
                    type="card" 
                    closable 
                    @tab-remove="closeTab"
                    >
                     <el-tab-pane 
                        v-for="(item, index) in editableTabs" 
                        :key="index" 
                        :label="item.title" 
                        :name="item.title"
                    >
                        <iframe :src='ms.manager+"/"+item.url'></iframe>
                     </el-tab-pane>
                  </el-tabs>
               </el-main>
            </el-container>
         </el-container>
      </div>
   </body>
</html>
<script>
   var indexVue = new Vue({
      el: "#app",
      data: {
        // 预置菜单图标
        icon:{
            '消息管理':'icon-xiaoxiguanli',
            '评论管理':'icon-pinglunguanli',
            '内容管理':'icon-bianji1',
            '会员中心':'icon-huiyuan',
            '自定义管理':'icon-gengduo-2',
            '权限管理':'icon-UPMSquanxianicon-',
            '系统管理':'icon-xitong',
        },
        menuList:[],//菜单接口数据
        parentMenuList:[],//一级菜单
        subMenuList:[],//二级菜单 所有
        mainParentMenuList:[],//头部菜单显示主要的选项
        loginDown: false, //登录下拉
        menuActive: "", //选中菜单
        editableTabsValue: '',
        editableTabs: [],//当前打开的tab页面
        shortcutMenu:false,//快捷菜单显示状态
        collapseMenu:false,//菜单折叠，false不折叠
        currentTab:'',//当前激活tab的name
        tabIndex: 2,
        //登录用户信息
        peopleInfo:{
        	managerName:''//账号
        },
        subMenuList:[],//
      },
      watch:{
          menuList:function(n,o){
              var that = this;
            n && n.forEach(function(item,index){
                item.modelModelId == 0 ? that.parentMenuList.push(item) : that.subMenuList.push(item)
            })
          },
          parentMenuList:function(n,o){
             this.mainParentMenuList = n.slice(0,5);
          },
          subMenuList:function(n,o){
              console.log('zicai',n);
          }
      },
      methods: {
        // 菜单列表
        list:function(){
            var that = this;
            ms.http.post(ms.manager + "/model/list.do")
                .then((data)=>{
                    that.menuList = data.rows
                }, (err) => {
                    that.$message.error(err);
                })	
        },
        // 菜单打开页面
        open:function(title,url){
            var result = '';
            result = this.editableTabs.some(function (item,index) {return item.title == title})
            !result ?　this.editableTabs.push({title:title,url:url}) : ""
            this.currentTab = title;
            // 处理其他逻辑
        },
        // 获取当前菜单的子菜单
        getSubMenu:function (modelId) {
            var result = [];
            var that = this;
            that.subMenuList && that.subMenuList.forEach(function (item) {
                item.modelModelId == modelId ? result.push(item) : ''
            })
            return result;
        },
        // 匹配图标
        iconType:function (title) {
            return this.icon[title] || 'icon-xitongpeizhi'
        },
         //关闭tab标签页
         closeTab(targetName) {
            var that = this;
            // 关闭的面板是当前激活面板
            if(that.currentTab == targetName){
                that.editableTabs.forEach(function (tab,index,arr) {
                    if(tab.title == targetName){
                        var nextTab = arr[index + 1] || arr[index - 1];
                        if(nextTab){
                            that.currentTab = nextTab.title
                        }
                    }
                })
            }
            // 关闭的不是当前面板
            that.editableTabs = that.editableTabs.filter(function (tab) {
                return tab.title !== targetName
            })
         },
        //  头部导航打开菜单
         openMenu:function(menu,index){
             this.$refs.menu.open(index);
             var children = [];
             this.menuList.forEach(function (tab) {
                 if(tab.modelModelId == menu.modelId){
                    children.push(tab)
                 }
             })
             this.currentTab = children[0] && children[0].modelTitle;
             this.open(children[0].modelTitle,children[0].modelUrl);
             var that = this;
             setTimeout(function(){
                that.shortcutMenu = false
             },50)
         },
         managerGet:function(){
         	var that = this;
         	ms.http.get(ms.manager + "/basic/manager/get.do")
               .then((data)=>{
                   that.peopleInfo = data
                   resetPasswordVue.resetPasswordForm.managerName = that.peopleInfo.managerName
               }, (err) => {
                   that.$message.error(err);
               })	
         },
        //  打开修改密码，退出的模态框
         openModal:function(){
            event.target.innerText.indexOf('修改密码')>-1
            ? resetPasswordVue.isShow=true : exitSystemVue.isShow=true
         }
      },
      mounted:function(){
            // 菜单列表
            this.list();
            //获取登录用户信息
            this.managerGet();
      },
   })
</script>