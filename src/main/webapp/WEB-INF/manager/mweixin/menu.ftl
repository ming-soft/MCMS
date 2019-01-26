<link rel="stylesheet" href="../../../static/mweixin/css/menu.css">

<div id="menu-vue">
   <!--左侧-->
   <el-container class="ms-admin-menu">
      <!--右侧头部-->
      <el-header class="ms-header" height="50px">
         <div>
            <i class="el-icon-arrow-left"></i>
            <span>
               吕小布微信号
            </span>
         </div>
      </el-header>
      <el-main>
         <el-menu class="ms-admin-menu-menu" default-active="0-0">
            <template v-for="(menu,i) in menuList">
               <!--单个选项-->
               <el-menu-item :index="i" @click="menuActive = menu.title" v-if="!menu.sub" v-text="menu.title"></el-menu-item>
               <!--多个选项-->
               <el-submenu :index="i+''" v-if="menu.sub">
                  <template slot="title">
                     <span v-text="menu.title"></span>
                  </template>
                  <el-menu-item class="ms-admin-menu-menu-item" @click="menuActive = sub.title" :index="i+'-'+index" v-for="(sub,index) in menu.sub" v-text="sub.title"></el-menu-item>
               </el-submenu>
            </template>
         </el-menu>
      </el-main>
   </el-container>
</div>

<script>
   var menuVue = new Vue({
      el: "#menu-vue",
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
         }, {
            title: '自动回复',
            sub: [{
               title: '关注时回复'
            }, {
               title: '消息回复'
            }, {
               title: '关键词回复'
            }]
         },{
             title:'新建图文'
         }
        ], //左侧导航列表
         menuActive: '图文', //选中
      }
   })
</script>