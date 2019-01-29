<!-- 消息回复 && 关注回复 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/message-reply.css">
<div id="message-reply" class="ms-message-reply ms-weixin-content" v-if="menuVue.menuActive == '消息回复'||menuVue.menuActive == '关注时回复'">
   <el-container class="ms-admin-message-reply">
      <el-header class="ms-header" height="50px">
         <el-row>
            <el-button class="ms-fr" size="small" icon="el-icon-refresh">重置</el-button>
            <el-button type="success" class="ms-fr" size="small" icon="el-icon-tickets">保存</el-button>
         </el-row>
      </el-header>
      <el-container>
         <el-header class="ms-tr ms-header">
            <el-input size="medium" placeholder="请输入内容" suffix-icon="el-icon-search">
            </el-input>
         </el-header>
         <em-main class="ms-container">
            <div>回复内容</div>
            <el-tabs v-model="activeName" @tab-click="" class="message-reply-tabs">
               <el-tab-pane label="文字" name="text">
                  <el-form ref="messageReplyForm" :rules='messageReplyFormRules' :model="messageReplyForm">
                     <el-form-item class="ms-message-reply-content">
                        <el-input type="textarea" v-model="messageReplyForm.reply" :autosize="{ minRows: 4, maxRows: 4}" resize='none'>
                        </el-input>
                        <i class="el-icon-delete" @click="messageReplyForm.reply = ''"></i>
                        <div class="footer">
                           <i class="el-icon-star-off"></i>
                           <a>插入超链接</a>
                        </div>
                     </el-form-item>
                  </el-form>
                  </el-form>
               </el-tab-pane>
               <el-tab-pane label="图片" name="picture">
               </el-tab-pane>
               <el-tab-pane label="图文" name="article">
               </el-tab-pane>
            </el-tabs>
         </em-main>
      </el-container>
   </el-container>
</div>
<script>
   var messageReplyVue = new Vue({
      el: "#message-reply",
      data: {
         messageReplyForm: {
            reply: '',
         },
         messageReplyFormRules: {
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
         activeName: 'text',
      },
      methods: {

      }

   })
</script>