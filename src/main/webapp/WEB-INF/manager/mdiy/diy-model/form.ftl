<link rel="stylesheet" href="../../../static/mdiy/css/model-form.css">

<div id="model-form" class="ms-mdiy-model-form" v-if="modelListVue.href == '表单'">
   <el-container>
      <el-header class="ms-header" height="50px">
         <el-row class="ms-row">
            <el-button class="ms-fr" type="success" size="small" icon="el-icon-back">返回</el-button>
            <el-button class="ms-fr" size="small" icon="el-icon-plus">保存</el-button>
         </el-row>
      </el-header>
      <el-container>
         <el-aside class="ms-editor-type-layout">
            <div class="ms-header-title">自定义表单项</div>
            <ul>
               <li v-for="type in typeList">
                  <i></i>
                  <span v-text="type.title"></span>
               </li>
            </ul>
         </el-aside>
         <el-main class="ms-editor-body-layout">
            <div class="ms-header-title">自定义表单项</div>
            <el-form :model="form" size="mini" class="form">
               <!--控件类型下拉-->
               <el-form-item :label="selected.title" :label-width="'90px'" v-for="selected in selectedList" @click="attrForm == selected">
                  <!--单行-->
                  <el-input v-if="selected.id == '1'" maxlength="20" type="text" v-model="form.default" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                  <!--多行-->
                  <el-input v-if="selected.id == '1'" maxlength="20" type="textarea" :rows="4" v-model="form.default" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                  <!--号码-->
                  <el-input v-if="selected.id == '2'" maxlength="11" type="text" v-model="form.default" placeholder="选填，1-11，数字" autocomplete="off"></el-input>
                  <!--金额-->
                  <el-input v-if="selected.id == '3'" maxlength="20" type="text" v-model="form.default" placeholder="选填" autocomplete="off"></el-input>

                  <!--数值-->
                  <el-input v-if="selected.id == '4'" max="9999" type="number" v-model="form.default" placeholder="选填，数字" autocomplete="off"></el-input>

                  <!--日期和时间-->
                  <el-date-picker v-if="selected.id == '5'" style="width: 100%;" v-model="form.default" type="datetime" placeholder="选择日期时间">
                  </el-date-picker>
                  <!--仅日期-->
                  <el-date-picker v-if="selected.id == '5'" style="width: 100%;" v-model="form.default" type="date" placeholder="选择日期">
                  </el-date-picker>
                  <!--仅时间-->
                  <el-time-picker v-if="selected.id == '5'" style="width: 100%;" v-model="form.default" placeholder="选择时间">
                  </el-time-picker>

                  <!--单选-->
                  <template v-if="selected.id == '6'">
                     <el-radio v-model="selected.default" label="1">备选项</el-radio>
                     <el-radio v-model="selected.default" label="2">备选项</el-radio>
                  </template>

                  <!--多选-->
                  <el-checkbox-group v-model="form.downList" v-if="selected.id == '6'">
                     <el-checkbox v-for="city in 4" :label="city" :key="city">{{city}}</el-checkbox>
                  </el-checkbox-group>

                  <!--下拉菜单-->
                  <el-select style="width: 100%;" v-model="controlTypeActive" placeholder="请选择" v-if="selected.id == '7'">
                     <el-option v-for="item in 2" :key="item" :label="item" :value="item">
                     </el-option>
                  </el-select>

                  <!--上传图片-->
                  <el-form-item v-if="selected.id == '8'">
                     <el-button icon="el-icon-upload">上传附件</el-button>
                  </el-form-item>

                  <!--上传附件-->
                  <el-form-item v-if="selected.id == '9'">
                     <el-button icon="el-icon-upload">上传附件</el-button>
                  </el-form-item>

               </el-form-item>
            </el-form>
         </el-main>
         <el-aside class="ms-editor-attr-layout">
            <div class="ms-header-title">属性</div>
            <div id="ms-editor-attr" class="ms-editor-attr">
               <el-form :model="form" label-position="top" size="mini" class="form">
                  <!--字段名-->
                  <el-form-item label="字段名" :label-width="'70px'">
                     <el-input v-model="form.tableName" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--数字类型-->
                  <!--数值-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '1-1'">
                     <el-input max="9999" type="number" v-model="form.default" placeholder="选填，数字" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--时间类型-->
                  <!--日期和时间-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '2-1'">
                     <el-date-picker style="width: 100%;" v-model="form.default" type="datetime" placeholder="选择日期时间">
                     </el-date-picker>
                  </el-form-item>
                  <!--仅日期-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '2-2'">
                     <el-date-picker style="width: 100%;" v-model="form.default" type="date" placeholder="选择日期">
                     </el-date-picker>
                  </el-form-item>
                  <!--仅时间-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '2-3'">
                     <el-time-picker style="width: 100%;" v-model="form.default" placeholder="选择时间">
                     </el-time-picker>
                  </el-form-item>

                  <!--字符串类型-->
                  <!--文本-->
                  <el-form-item label="字段类型" :label-width="'70px'" v-if="controlTypeActive === '3-1'">
                     <el-radio v-model="form.fieldType" label="3-1-1">单行</el-radio>
                     <el-radio v-model="form.fieldType" label="3-1-2">多行</el-radio>
                     <el-radio v-model="form.fieldType" label="3-1-3">带格式</el-radio>
                  </el-form-item>
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '3-1'">
                     <!--输入框判断选中的是多行还是单行-->
                     <el-input v-if="form.fieldType == '3-1-1' || form.fieldType == ''" maxlength="20" type="text" v-model="form.default" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                     <el-input v-if="form.fieldType == '3-1-2' || form.fieldType == '3-1-3'" maxlength="20" type="textarea" :rows="4" v-model="form.default" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--号码-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '3-2'">
                     <el-input maxlength="11" type="text" v-model="form.default" placeholder="选填，1-11，数字" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--金额-->
                  <el-form-item label="单位" :label-width="'70px'" v-if="controlTypeActive === '3-3'">
                     <el-input maxlength="20" type="text" v-model="form.fieldType" placeholder="选填" autocomplete="off"></el-input>
                     <el-radio v-model="form.fieldType" label="3-3-1">前缀</el-radio>
                     <el-radio v-model="form.fieldType" label="3-3-2">后缀</el-radio>
                  </el-form-item>
                  <el-form-item label="保留几位小数" :label-width="'70px'" v-if="controlTypeActive === '3-3'">
                     <el-input min="0" max="9" type="number" v-model="form.data4" placeholder="选填，数字" autocomplete="off"></el-input>
                  </el-form-item>
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '3-3'">
                     <el-input max="9999" type="number" v-model="form.default" placeholder="选填，数字" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--下拉菜单-->
                  <el-form-item label="字段类型" :label-width="'70px'" v-if="controlTypeActive === '3-5'">
                     <el-radio v-model="form.fieldType" label="3-5-1">单选</el-radio>
                     <el-radio v-model="form.fieldType" label="3-5-2">多选</el-radio>
                  </el-form-item>

                  <el-form-item label="添加选项" :label-width="'70px'" v-show="controlTypeActive === '3-4' || controlTypeActive === '3-5'">
                     <ul class="ms-down-list" id="ms-down-list">
                        <!--单选-->
                        <li class="ms-down-item" v-for="(down,index) in form.downList" v-show="form.fieldType == '3-5-1'">
                           <i class="iconfont icon-tuodong"></i>
                           <el-radio class="ms-radio" v-model="form.downActive" :label="index">默认</el-radio>
                           <el-input class="ms-input" v-model="down.value" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                           <i class="el-icon-delete" @click="form.downList.splice(index,1)"></i>
                        </li>
                        <!--多选-->
                        <el-checkbox-group id="ms-down-checkbox-list" v-model="form.downActiveList" v-show="form.fieldType == '3-5-2'">
                           <li class="ms-down-item" v-for="(down,index) in form.downList">
                              <i class="iconfont icon-tuodong"></i>
                              <el-checkbox class="ms-radio" :label="index">默认</el-checkbox>
                              <el-input class="ms-input" v-model="down.value" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                              <i class="el-icon-delete" @click="form.downList.splice(index,1)"></i>
                           </li>
                        </el-checkbox-group>
                        <div class="ms-plus" @click="form.downList.push({})" v-if="form.fieldType == '3-5-1' || form.fieldType == '3-5-2'">
                           <i class="el-icon-plus"></i>添加
                        </div>
                     </ul>
                  </el-form-item>

                  <!--上传图片-->
                  <el-form-item label="图片数量限制" :label-width="'70px'" v-if="controlTypeActive === '3-6'">
                     <el-input max="9" type="number" v-model="form.default" placeholder="选填，数字" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--上传附件-->
                  <!--<el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '3-7'">
            </el-form-item>-->

                  <!--设置-->
                  <el-form-item label="设置" :label-width="'70px'" v-if="">
                     <el-checkbox-group v-model="form.set">
                        <el-checkbox label="必填"></el-checkbox>
                        <el-checkbox label="唯一"></el-checkbox>
                     </el-checkbox-group>
                  </el-form-item>

                  <!--说明-->
                  <el-form-item label="填写说明" :label-width="'70px'">
                     <el-input type="textarea" :rows="2" placeholder="请输入内容" v-model="form.explain">
                     </el-input>
                  </el-form-item>
               </el-form>
               <div class="footer">
                  <el-button size="mini" type="primary">保存</el-button>
               </div>
            </div>
         </el-aside>
      </el-container>
   </el-container>
</div>

<script>
   new Vue({
      el: "#model-form",
      data: {
         typeList: [{
            title: "文本",
            icon: "",
            id: "1",
         }, {
            title: "号码",
            icon: "",
            id: "2",
         }, {
            title: "金额",
            icon: "",
            id: "3",
         }, {
            title: "数值",
            icon: "",
            id: "4",
         }, {
            title: "日期和时间",
            icon: "",
            id: "5",
         }, {
            title: "选项",
            icon: "",
            id: "6",
         }, {
            title: "下拉菜单",
            icon: "",
            id: "7",
         }, {
            title: "附件",
            icon: "",
            id: "8",
         }, {
            title: "图片",
            icon: "",
            id: "9",
         }],
         selectedList: [{
            title: "文本",
            value: "",
            id: "1",
         }, {
            title: "号码",
            value: "",
            id: "2",
         }, {
            title: "金额",
            value: "",
            id: "3",
         }, {
            title: "数值",
            value: "",
            id: "4",
         }, {
            title: "日期和时间",
            value: "",
            id: "5",
         }, {
            title: "选项",
            value: "",
            id: "6",
         }, {
            title: "下拉菜单",
            value: "",
            id: "7",
         }, {
            title: "附件",
            value: "",
            id: "8",
         }, {
            title: "图片",
            value: "",
            id: "9",
         }], //选中的
         form: {}, //表单数据
         controlTypeActive: '', //选中类型
      },
      watch: {
         controlTypeActive: function() {
            //切换控件类型时
            this.form = [];
            this.$forceUpdate();
            this.sortable();
         }
      },
      methods: {
         sortable: function() {
            Sortable.create(document.getElementById("ms-down-list"), {
               animation: 150,
               draggable: '.ms-down-item',
               handle: '.ms-down-item',
            });
            Sortable.create(document.getElementById("ms-down-checkbox-list"), {
               animation: 150,
               draggable: '.ms-down-item',
               handle: '.ms-down-item',
            });
         },
         //判断字段类型
      },
   })
</script>