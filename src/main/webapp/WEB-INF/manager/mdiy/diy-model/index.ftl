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
         href: '列表', //切换页面
         addInputType: {}, //添加中的表单项
      },
      watch: {
         href: function(data) {
            var that = this;
            if(data == '表单') {
               this.$nextTick(function() {
                  new Sortable(document.getElementById("ms-type-list"), {
                     group: {
                        name: 'shared',
                        pull: 'clone',
                        ghostClass: 'sortable-ghost', //设置拖动时候显示的样式
                     },
                     animation: 150,
                     sort: false,
                     onStart: function(event) {
                        //准备拖动时保存拖动选项的数据
                        that.addInputType = {
                           id: event.item.dataset.id,
                           title: event.item.dataset.title,
                           downList: [], //下拉列表
                           downActiveList: [], //多选列表
                           set: [], //设置
                           unit: '', //金额单位
                           fieldType: '', //字段类型
                        };
                     },
                  });
                  new Sortable(document.getElementById("ms-input-list"), {
                     group: {
                        name: 'shared',
                        pull: false,
                        ghostClass: 'sortable-ghost', //设置拖动时候显示的样式
                     },
                     animation: 150,
                     onAdd: function(event) {
                        //拖动成功后删除拖动过来的元素
                        event.item.parentNode.removeChild(event.item);
                        //想素组添加拖动过来的选项选项
                        modelFormVue.selectedList.push(that.addInputType);
                        //modelFormVue.selectedList.splice(0, 0, that.addInputType);
                     },
                  });
               })
            }
         }
      },
      methods: {},
   })
</script>