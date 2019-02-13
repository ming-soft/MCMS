<link rel="stylesheet" href="../../../static/mdiy/css/model-list.css">

<div id="model-list" class="ms-mdiy-model-list" v-if="href == '列表'">
   <el-container>
      <el-header class="ms-header" height="50px">
         <el-row>
            <el-button size="small" icon="el-icon-plus" type="primary">保存</el-button>
            <el-button type="danger" size="small" icon="el-icon-delete">删除</el-button>
            <el-button class="ms-fr" size="small" icon="el-icon-refresh">刷新</el-button>
         </el-row>
      </el-header>
      <el-container>
         <el-header class="ms-tr ms-header">
            <el-select v-model="value" placeholder="请选择" size="small">
            </el-select>
            <el-button size="small" icon="el-icon-search" type="primary">查询</el-button>
         </el-header>
         <el-main>
            <el-table :data="tableData" border style="width: 100%">
               <el-table-column label="规则名">
                  <template slot-scope="scope">
                     <el-button type="text" v-text="scope.row.data" @click="href='表单'"></el-button>
                  </template>
               </el-table-column>
               <el-table-column prop="name" label="发送对象">
               </el-table-column>
            </el-table>
         </el-main>
      </el-container>
   </el-container>
</div>

<script>
   var modelListVue = new Vue({
      el: "#model-list",
      data: {
         value: "", //
         tableData: [{
            data: '项目玩法',
            name: '王小虎',
         }, {
            data: '综合评估',
            name: '王小虎',
         }, {
            data: '产权出售',
            name: '王小虎',
         }, {
            data: '兵不匹配移动端',
            name: '王小虎',
         }],
         href: '列表', //
      },
      methods: {}
   })
</script>