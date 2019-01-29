<!-- 关键字列表 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/keyword-list.css">

<div id="keyword-list" class="keyword-list ms-weixin-content" v-if="menuVue.menuActive == '关键词回复'">
   <el-container>
      <!--右侧头部-->
      <el-header class="ms-header" height="50px">
         <el-row>
            <el-button type="primary" size="small" icon="el-icon-plus" @click="menuVue.menuActive = '关键词表单'">添加</el-button>
            <el-button class="ms-fr" size="small" icon="el-icon-refresh">重置</el-button>
         </el-row>
      </el-header>
      <el-container>
         <!--内容头部-->
         <el-header class="ms-tr ms-header">
            <el-input size="medium" placeholder="请输入内容" suffix-icon="el-icon-search">
            </el-input>
         </el-header>
         <!--素材列表-->
         <el-main class="ms-admin-picture-list ms-container">
            <el-table :data="tableData" border style="width: 100%">
               <el-table-column prop="date" label="规则名" width="180" align='center'>
               </el-table-column>
               <el-table-column prop="name" label="关键词" width="180" align='center'>
               </el-table-column>
               <el-table-column prop="address" label="消息回复类型" align='center'>
               </el-table-column>
               <el-table-column prop="address" label="发送对象" align='center'>
               </el-table-column>
               <el-table-column prop="address" label="回复方式" align='center'>
               </el-table-column>
            </el-table>
         </el-main>
      </el-container>
   </el-container>
</div>

<script>
   var keywordListVue = new Vue({
      el: '#keyword-list',
      data: {
         tableData: [{
            date: '2016-05-02',
            name: '王小虎',
            address: '上海市普陀区金沙江路 1518 弄'
         }, {
            date: '2016-05-04',
            name: '王小虎',
            address: '上海市普陀区金沙江路 1517 弄'
         }, {
            date: '2016-05-01',
            name: '王小虎',
            address: '上海市普陀区金沙江路 1519 弄'
         }, {
            date: '2016-05-03',
            name: '王小虎',
            address: '上海市普陀区金沙江路 1516 弄'
         }]
      },
      methods: {
         // 获取关键词列表
         list: function() {

         }
      }
   })
</script>