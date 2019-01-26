<!--图文素材页-->

<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title></title>
      <!-- <#include "/include/head-file.ftl"/> -->
      <!--#include virtual="../include/head-file.ftl" -->
      <link rel="stylesheet" href="../../../static/mweixin/css/material-list.css">
   </head>
   <body>
      <div id="app">
         <el-container>
            <!--左侧meun-->
            <el-aside width="140px">
               <!--#include virtual="../include/menu.ftl" -->
            </el-aside>
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
         </el-container>
      </div>
   </body>
</html>

<script>
   new Vue({
      el: "#app",
      data: {},
      methods: {},
      mounted: function() {}
   })
</script>