<!--图文素材页-->
<link rel="stylesheet" href="../../../static/mweixin/css/material-list.css">
<div id="material-list-vue" v-if="menuVue.menuActive == '图文'">
   <el-container>
      <!--右侧头部-->
      <el-header height="50px">
         <el-row class="ms-fr">
            <el-button type="success">保存</el-button>
            <el-button>更新</el-button>
            <el-button>返回</el-button>
         </el-row>
      </el-header>
      <el-main>
         <!--内容同步-->
         <el-container>
            <el-header height="50px">

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