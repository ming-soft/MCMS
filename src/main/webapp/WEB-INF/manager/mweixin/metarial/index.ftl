<!--图文素材页-->
<link rel="stylesheet" href="../../../static/mweixin/css/material-list.css">
<div id="material-list-vue" v-if="menuVue.menuActive == '图文'" class="ms-weixin-content">
   <el-container>
      <!--右侧头部-->
      <el-header class="ms-header" height="52px">
         <el-row>
            <el-button type="primary" size="small">
               <i class="el-icon-plus"></i>添加</el-button>
            <el-button class="ms-fr" size="small">
               <i class="el-icon-refresh"></i>刷新</el-button>
            <el-button class="ms-fr" size="small">同步微信素材</el-button>
         </el-row>
      </el-header>
      <el-main>
         <!--内容同步-->
         <el-container>
            <el-header class="ms-tr ms-header">

            </el-header>
            <!--素材列表-->
            <el-main class="ms-admin-material-list">
               <div class="ms-admin-material-item">

               </div>
            </el-main>
         </el-container>
      </el-main>
   </el-container>
</div>

<script>
   new Vue({
      el: "#material-list-vue",
      data: {},
      methods: {},
      mounted: function() {}
   })
</script>