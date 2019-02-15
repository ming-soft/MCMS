<link rel="stylesheet" href="../../../static/mdiy/css/model-form.css">
<div id="model-form" class="ms-mdiy-model-form" v-if="modelListVue.href == '表单'">
   <el-container>
      <el-header class="ms-header" height="50px">
         <el-row class="ms-row">
            <el-button class="ms-fr" type="success" size="small" icon="el-icon-back" @click="modelListVue.href = '列表'">返回</el-button>
            <el-button class="ms-fr" size="small" icon="el-icon-plus">保存</el-button>
         </el-row>
      </el-header>
      <el-container>
         <el-aside class="ms-editor-type-layout">
            <div class="ms-header-title">自定义表单项</div>
            <div id="ms-type-list" class="ms-type-list">
               <li v-for="type in typeList" :data-id="type.id" :data-title="type.title">
                  <i class="iconfont" :class="type.icon"></i>
                  <span v-text="type.title"></span>
               </li>
            </div>
         </el-aside>
         <el-main class="ms-editor-body-layout">
            <el-form id="ms-input-list" size="mini" class="form">
               <!--控件类型下拉-->
               <el-form-item @click.native="controlTypeActive = selected" class="ms-form-item" :class="{'active':controlTypeActive == selected}" :label="selected.title" :label-width="'90px'" v-for="(selected,index) in selectedList">
                  <!--单行-->
                  <el-input v-if="selected.id == '1' && selected.fieldType != '1-2' && selected.fieldType != '1-3'" maxlength="20" type="text" v-model="selected.default" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                  <!--多行-->
                  <el-input v-if="selected.fieldType == '1-2'" maxlength="20" type="textarea" :rows="4" v-model="selected.default" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                  <div v-show="selected.fieldType == '1-3'" style="width: 100%;">
                     <script id="ms-ueditor" type="text/plain" name="taskDescription"></script>
                  </div>
                  <!--号码-->
                  <el-input v-if="selected.id == '2'" maxlength="11" type="text" v-model="selected.default" placeholder="选填，1-11，数字" autocomplete="off"></el-input>
                  <!--金额-->
                  <el-input class="unit-input" v-if="selected.id == '3'" maxlength="20" type="number" v-model="selected.default" placeholder="选填" autocomplete="off">
                     <template :slot="selected.fieldType == '3-1'?'prepend':'append'">{{selected.unit}}</template>
                  </el-input>

                  <!--数值-->
                  <el-input v-if="selected.id == '4'" max="9999" type="number" v-model="selected.default" placeholder="选填，数字" autocomplete="off"></el-input>

                  <!--日期和时间-->
                  <el-date-picker v-if="selected.id == '5' && selected.fieldType != '5-2' && selected.fieldType != '5-3'" style="width: 100%;" v-model="selected.default" type="datetime" placeholder="选择日期时间">
                  </el-date-picker>
                  <!--仅日期-->
                  <el-date-picker v-if="selected.fieldType == '5-2'" style="width: 100%;" v-model="selected.default" type="date" placeholder="选择日期">
                  </el-date-picker>
                  <!--仅时间-->
                  <el-time-picker v-if="selected.fieldType == '5-3'" style="width: 100%;" v-model="selected.default" placeholder="选择时间">
                  </el-time-picker>

                  <!--选项-->
                  <!--单选-->
                  <template v-if="selected.id == '6' && selected.fieldType != '6-2'">
                     <el-radio v-for="(down,index) in selected.downList" v-model="selected.downActive" :label="index">{{down.value}}</el-radio>
                  </template>

                  <!--多选-->
                  <el-checkbox-group v-model="selected.downActiveList" v-if="selected.fieldType == '6-2'">
                     <el-checkbox v-for="(down,index) in selected.downList" :label="index">{{down.value}}</el-checkbox>
                  </el-checkbox-group>
                  <!--下拉菜单-->
                  <!--单选-->
                  <el-select style="width: 100%;" v-model="selected.downActive" placeholder="请选择" v-if="selected.id == '7' && selected.fieldType != '7-2'">
                     <el-option v-for="(down,index) in selected.downList" :value="index" :label="down.value">
                     </el-option>
                  </el-select>

                  <!--多选-->
                  <el-select style="width: 100%;" multiple v-model="selected.downActiveList" placeholder="请选择" v-if="selected.fieldType == '7-2'">
                     <el-option v-for="(down,index) in selected.downList" :value="index" :label="down.value">
                     </el-option>
                  </el-select>

                  <!--上传图片-->
                  <el-upload v-if="selected.id == '8'" action="https://jsonplaceholder.typicode.com/posts/" multiple>
                     <el-button icon="el-icon-upload">上传附件</el-button>
                  </el-upload>

                  <!--上传附件-->
                  <el-upload v-if="selected.id == '9'" action="https://jsonplaceholder.typicode.com/posts/" multiple list-type="picture-card">
                     <i class="el-icon-plus"></i>
                  </el-upload>
                  <!--删除按钮-->
                  <el-button class="del-but" type="text" @click.stop="selectedList.splice(index,1)">删除</el-button>
               </el-form-item>
            </el-form>
         </el-main>
         <el-aside class="ms-editor-attr-layout">
            <div class="ms-header-title">属性</div>
            <div id="ms-editor-attr" class="ms-editor-attr">
               <el-form label-position="top" size="mini" class="form">
                  <!--字段名-->
                  <el-form-item label="标题" :label-width="'70px'">
                     <el-input maxlength="5" v-model="controlTypeActive.title" placeholder="选填，1-5，字符" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--数字类型-->
                  <!--数值-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive.id === '4'">
                     <el-input max="9999" type="number" v-model="controlTypeActive.default" placeholder="选填，数字" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--时间类型-->
                  <el-form-item label="字段类型" :label-width="'70px'" v-if="controlTypeActive.id === '5'">
                     <el-radio v-model="controlTypeActive.fieldType" label="5-1">日期和时间</el-radio>
                     <el-radio v-model="controlTypeActive.fieldType" label="5-2">仅日期</el-radio>
                     <el-radio v-model="controlTypeActive.fieldType" label="5-3">仅时间</el-radio>
                  </el-form-item>
                  <!--日期和时间-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive.id === '5' && controlTypeActive.fieldType != '5-2' && controlTypeActive.fieldType != '5-3'">
                     <el-date-picker style="width: 100%;" v-model="controlTypeActive.default" type="datetime" placeholder="选择日期时间">
                     </el-date-picker>
                  </el-form-item>
                  <!--仅日期-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive.fieldType == '5-2'">
                     <el-date-picker style="width: 100%;" v-model="controlTypeActive.default" type="date" placeholder="选择日期">
                     </el-date-picker>
                  </el-form-item>
                  <!--仅时间-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive.fieldType == '5-3'">
                     <el-time-picker style="width: 100%;" v-model="controlTypeActive.default" placeholder="选择时间">
                     </el-time-picker>
                  </el-form-item>

                  <!--字符串类型-->
                  <!--文本-->
                  <el-form-item label="字段类型" :label-width="'70px'" v-if="controlTypeActive.id === '1'">
                     <el-radio v-model="controlTypeActive.fieldType" label="1-1">单行</el-radio>
                     <el-radio v-model="controlTypeActive.fieldType" label="1-2">多行</el-radio>
                     <el-radio v-model="controlTypeActive.fieldType" label="1-3">带格式</el-radio>
                  </el-form-item>
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive.id === '1'">
                     <!--输入框判断选中的是多行还是单行-->
                     <el-input v-if="controlTypeActive.fieldType != '1-2' && controlTypeActive.fieldType != '1-3'" maxlength="20" type="text" v-model="controlTypeActive.default" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                     <el-input v-if="controlTypeActive.fieldType == '1-2' || controlTypeActive.fieldType == '1-3'" maxlength="20" type="textarea" :rows="4" v-model="controlTypeActive.default" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--号码-->
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive.id === '2'">
                     <el-input maxlength="11" type="text" v-model="controlTypeActive.default" placeholder="选填，1-11，数字" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--金额-->
                  <el-form-item label="单位" :label-width="'70px'" v-if="controlTypeActive.id === '3'">
                     <el-input autocomplete="off" placeholder="选填" maxlength="20" type="text" v-model="controlTypeActive.unit" class="input-with-select">
                        <el-select v-model="controlTypeActive.fieldType" slot="append" placeholder="请选择">
                           <el-option label="前缀" value="3-1"></el-option>
                           <el-option label="后缀" value="3-2"></el-option>
                        </el-select>
                     </el-input>
                  </el-form-item>
                  <el-form-item label="保留几位小数" :label-width="'70px'" v-if="controlTypeActive.id === '3'">
                     <el-input min="0" max="9" type="number" v-model="controlTypeActive.data4" placeholder="选填，数字" autocomplete="off"></el-input>
                  </el-form-item>
                  <el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive.id === '3'">
                     <el-input max="9999" type="number" v-model="controlTypeActive.default" placeholder="选填，数字" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--选项和下拉菜单-->
                  <el-form-item label="字段类型" :label-width="'70px'" v-if="controlTypeActive.id === '6' || controlTypeActive.id === '7'">
                     <el-radio v-model="controlTypeActive.fieldType" :label="controlTypeActive.id+'-1'">单选</el-radio>
                     <el-radio v-model="controlTypeActive.fieldType" :label="controlTypeActive.id+'-2'">多选</el-radio>
                  </el-form-item>

                  <el-form-item label="添加选项" :label-width="'70px'" v-show="(controlTypeActive.id === '6' || controlTypeActive.id === '7') && (controlTypeActive.fieldType == controlTypeActive.id+'-1' || controlTypeActive.fieldType == controlTypeActive.id+'-2')">
                     <ul class="ms-down-list" id="ms-down-list">
                        <!--单选-->
                        <li class="ms-down-item" v-for="(down,index) in controlTypeActive.downList" v-show="controlTypeActive.fieldType == controlTypeActive.id+'-1'">
                           <i class="iconfont icon-tuodong"></i>
                           <el-radio class="ms-radio" v-model="controlTypeActive.downActive" :label="index">默认</el-radio>
                           <el-input maxlength="20" class="ms-input" v-model="down.value" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                           <i class="el-icon-delete" @click="controlTypeActive.downList.splice(index,1)"></i>
                        </li>
                        <!--多选-->
                        <el-checkbox-group id="ms-down-checkbox-list" v-model="controlTypeActive.downActiveList" v-show="controlTypeActive.fieldType == controlTypeActive.id+'-2'">
                           <li class="ms-down-item" v-for="(down,index) in controlTypeActive.downList">
                              <i class="iconfont icon-tuodong"></i>
                              <el-checkbox class="ms-radio" :label="index">默认</el-checkbox>
                              <el-input maxlength="20" class="ms-input" v-model="down.value" placeholder="选填，1-20，字符" autocomplete="off"></el-input>
                              <i class="el-icon-delete" @click="controlTypeActive.downList.splice(index,1)"></i>
                           </li>
                        </el-checkbox-group>
                        <div class="ms-plus" @click="controlTypeActive.downList.push({})" v-if="controlTypeActive.fieldType == controlTypeActive.id+'-1' || controlTypeActive.fieldType == controlTypeActive.id+'-2'">
                           <i class="el-icon-plus"></i>添加
                        </div>
                     </ul>
                  </el-form-item>

                  <!--上传图片-->
                  <el-form-item label="图片数量限制" :label-width="'70px'" v-if="controlTypeActive.id === '9'">
                     <el-input max="9" type="number" v-model="controlTypeActive.default" placeholder="选填，数字" autocomplete="off"></el-input>
                  </el-form-item>

                  <!--上传附件-->
                  <!--<el-form-item label="默认值" :label-width="'70px'" v-if="controlTypeActive === '3-7'">
            </el-form-item>-->

                  <!--设置-->
                  <el-form-item label="设置" :label-width="'70px'">
                     <el-checkbox-group v-model="controlTypeActive.set">
                        <el-checkbox label="必填"></el-checkbox>
                        <el-checkbox label="唯一" v-if="controlTypeActive.id != 5"></el-checkbox>
                     </el-checkbox-group>
                  </el-form-item>

                  <!--说明-->
                  <el-form-item label="填写说明" :label-width="'70px'">
                     <el-input type="textarea" :rows="2" placeholder="请输入内容" v-model="controlTypeActive.explain">
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
   var modelFormVue = new Vue({
      el: "#model-form",
      data: {
         typeList: [{
            title: "文本",
            icon: "icon-guidang",
            id: "1",
         }, {
            title: "号码",
            icon: "icon-plus-numberfill",
            id: "2",
         }, {
            title: "金额",
            icon: "icon-jine",
            id: "3",
         }, {
            title: "数值",
            icon: "icon-sifaleizhibanshi",
            id: "4",
         }, {
            title: "日期和时间",
            icon: "icon-riqi",
            id: "5",
         }, {
            title: "选项",
            icon: "icon-shaixuan",
            id: "6",
         }, {
            title: "下拉菜单",
            icon: "icon-xiala",
            id: "7",
         }, {
            title: "附件",
            icon: "icon-fujian",
            id: "8",
         }, {
            title: "图片",
            icon: "icon-tupian",
            id: "9",
         }],
         selectedList: [{
            title: "文本",
            value: "",
            id: "1",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, {
            title: "号码",
            value: "",
            id: "2",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, {
            title: "金额",
            value: "",
            id: "3",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, {
            title: "数值",
            value: "",
            id: "4",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, {
            title: "日期和时间",
            value: "",
            id: "5",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, {
            title: "选项",
            value: "",
            id: "6",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, {
            title: "下拉菜单",
            value: "",
            id: "7",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, {
            title: "附件",
            value: "",
            id: "8",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, {
            title: "图片",
            value: "",
            id: "9",
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }], //选中的
         controlTypeActive: {
            downList: [], //下拉列表
            downActiveList: [], //多选列表
            set: [], //设置
            unit: '', //金额单位
            fieldType: '', //字段类型
         }, //选中类型
      },
      watch: {
         controlTypeActive: function(data) {
            //切换控件类型时
            if(data.id == '6' || data.id == '7') {
               this.$nextTick(function() {
                  if(this.downListSortable == null) {
                     this.downListSortable = new Sortable(document.getElementById("ms-down-list"), {
                        animation: 150,
                        draggable: '.ms-down-item',
                        handle: '.icon-tuodong', //设置只有小图标可以拖动
                        ghostClass: 'sortable-ghost', //设置拖动时候显示的样式
                     });
                  }
                  if(this.downListCheckboxSortable == null) {
                     this.downListCheckboxSortable = new Sortable(document.getElementById("ms-down-checkbox-list"), {
                        animation: 150,
                        draggable: '.ms-down-item',
                        handle: '.icon-tuodong', //设置只有小图标可以拖动
                        ghostClass: 'sortable-ghost', //设置拖动时候显示的样式
                     });
                  }
               })
            }
            if(data.id == '1') {
               let that = this;
               //富文本加载
               var URL = window.UEDITOR_HOME_URL || "http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/";
               if(this.editor == null) {
                  this.editor = UE.getEditor('ms-ueditor', {
                     toolbars: [
                        ['fullscreen', 'undo', 'redo', '|', 'bold', 'italic', 'underline', 'strikethrough',
                           'removeformat', 'blockquote',
                           '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|', 'attachment', 'simpleupload', 'link'
                        ]
                     ],
                     imageScaleEnabled: true,
                     // 服务器统一请求接口路径
                     serverUrl: URL + "jsp/msController.jsp?jsonConfig=%7BvideoUrlPrefix:'http://mpm.mingsoft.net/',fileUrlPrefix:'http://mpm.mingsoft.net/',imageUrlPrefix:'http://mpm.mingsoft.net/',imagePathFormat:'/upload/pm/editor/%7Btime%7D',filePathFormat:'/upload/pm/editor/%7Btime%7D',videoPathFormat:'/upload/pm/editor/%7Btime%7D'%7D",
                     autoHeightEnabled: true,
                     autoFloatEnabled: true,
                     scaleEnabled: false,
                     compressSide: 0,
                     maxImageSideLength: 2000,
                     maximumWords: 80000,
                     zIndex: 10000,
                     elementPathEnabled: false,
                     wordCount: false,
                     initialFrameWidth: '100%',
                     initialFrameHeight: 200,
                  });
                  this.editor.ready(function() {
                     var a = $("#ueditor_0").contents()[0].activeElement;
                     $(a).addClass("ms-webkit-scrollbar").before("<style>.ms-webkit-scrollbar::-webkit-scrollbar,::-webkit-scrollbar{width:10px;/*滚动条宽度*/height:1.5%;/*滚动条高度*/}/*定义滚动条轨道内阴影+圆角*/.ms-webkit-scrollbar::-webkit-scrollbar-track,::-webkit-scrollbar-track{border-radius:10px;/*滚动条的背景区域的圆角*/background-color:#eeeeee;/*滚动条的背景颜色*/}.ms-task-content::-webkit-scrollbar-track{border-radius:10px;background-color:#FFFFFF;}/*定义滑块内阴影+圆角*/.ms-webkit-scrollbar::-webkit-scrollbar-thumb,::-webkit-scrollbar-thumb{border-radius:10px;/*滚动条的圆角*/background-color:#dddddd;/*滚动条的背景颜色*/}</style>");
                  });
               }
            }
         }
      },
      methods: {},
   })
</script>