<!-- 自定义菜单 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/custom-menu.css">
<div id="custom-menu" class="ms-custom-menu ms-weixin-content" v-if="menuVue.menuActive == '自定义菜单'">
   <el-container class="ms-custom-container">
      <el-aside>
         <el-container>
            <el-header>公众号</el-header>
            <el-main></el-main>
            <el-footer>
               <el-button icon="el-icon-date"></el-button>
               <div class="ms-create-menu">
                  <div class="ms-create-sub-menu">
                     <el-button type="primary" @click='addSubMenuShow = !addSubMenuShow'>新建菜单</el-button>
                     <el-button icon="el-icon-plus" v-show='addSubMenuShow'></el-button>
                  </div>
                  <el-button icon="el-icon-plus"></el-button>
               </div>
            </el-footer>
         </el-container>
      </el-aside>
      <el-main>
         <el-card class="custom-menu-card" shadow="never">
            <div slot="header" class="clearfix">
               <span>新建菜单</span>
            </div>
            <el-form ref="customMenuForm" :rule='customMenuFormRules' :model="customMenuForm" label-width="80px">
               <el-form-item label="菜单名称" prop='name' class="ms-custom-menu-name">
                  <el-input v-model="customMenuForm.name" size='mini'></el-input>
                  <span>菜单名称字数不多于5个汉字或10个字母</span>
               </el-form-item>
               <el-form-item label="菜单内容" class="ms-custom-menu-content">
                  <el-tabs v-model="activeName" @tab-click="">
                     <el-tab-pane label="图片" name="picture">
                        <span slot="label">
                           <i class="el-icon-picture"></i>图片</span>
                        <div onclick="materialBankFormVue.open()">
                           <i class="el-icon-picture-outline"></i>
                           <span>从素材库选择</span>
                        </div>
                        <div onclick="newPicFormVue.open()">
                           <i class="el-icon-plus"></i>
                           <span>新建图片</span>
                        </div>
                     </el-tab-pane>
                     <el-tab-pane label="图文管理" name="article">
                        <span slot="label">
                           <i class="el-icon-picture"></i>图文管理</span>
                     </el-tab-pane>
                  </el-tabs>
               </el-form-item>
            </el-form>
         </el-card>
      </el-main>
   </el-container>
</div>
<script>
   var customMenuVue = new Vue({
      el: "#custom-menu",
      data: {
         customMenuForm: {
            name: '',
         },
         customMenuFormRules: {
            name: [{
                  required: true,
                  message: '请输入菜单名称',
                  trigger: ['blur', 'change']
               },
               {
                  min: 1,
                  max: 5,
                  message: '长度在 1 到 5 个字符',
                  trigger: ['blur', 'change']
               }
            ],
         },
         addSubMenuShow: false, //子菜单添加弹窗
         activeName: 'picture'
      },
      methods: {
         
      }

   })
</script>