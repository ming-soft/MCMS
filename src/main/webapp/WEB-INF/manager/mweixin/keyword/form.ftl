<!-- 关键词回复 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/keyword-reply.css">

<div id="keyword-reply" class="keyword-reply ms-container ms-content" v-if="menuVue.menuActive == '关键词表单'">
   <el-form :model="keywordReplyForm" status-icon :rules="keywordReplyFormRules" ref="keywordReplyForm" label-width="100px">
      <el-form-item label="关键词" prop="keyword" class="ms-keyword-input">
         <el-row type='flex' justify='space-between' align='center'>
            <el-col :span='12'>
               <el-input placeholder="请输入内容" v-model="keywordReplyForm.keyword" class="input-with-select" size='mini' maxlength='30' @input='resetWord'>
                  <el-select v-model="keywordReplyForm.select" slot="prepend" placeholder="请选择">
                     <el-option label="模糊匹配" value="1"></el-option>
                     <el-option label="全匹配" value="2"></el-option>
                  </el-select>
                  <span slot='suffix' v-text="wordNumber+'/30'"></span>
               </el-input>
            </el-col>
            <el-col>
               <i class="el-icon-plus" @click='addKeyWord'></i>
            </el-col>
         </el-row>
      </el-form-item>
      <el-form-item class="ms-keyword-reply-content" label="回复内容">
         <el-tabs v-model="activeName" @tab-click="" class="keyword-reply-tabs">
            <el-tab-pane label="文字" name="text">
               <el-input type="textarea" v-model="keywordReplyForm.reply" :autosize="{ minRows: 4, maxRows: 4}" resize='none'>
               </el-input>
               <i class="el-icon-delete" @click="keywordReplyForm.reply = ''"></i>
               <div class="footer">
                  <i class="el-icon-star-off"></i>
                  <a>插入超链接</a>
               </div>
            </el-tab-pane>
            <el-tab-pane label="图片" name="picture">
            </el-tab-pane>
            <el-tab-pane label="图文" name="article">
            </el-tab-pane>
         </el-tabs>
      </el-form-item>
   </el-form>
</div>

<script>
   var keywordReplyVue = new Vue({
      el: '#keyword-reply',
      data: {
         keywordReplyForm: {
            keyword: "", //关键词
            select: '',
            reply: "",
         },
         keywordReplyFormRules: {

         },
         activeName: 'text',
         wordNumber: 30, //剩余字数
      },
      methods: {
         // 添加关键词
         addKeyWord: function() {

         },
         // 计算剩余字数
         resetWord: function(value) {
            if(!value) return 30;
            if(value.length >= 30) {
               this.$message.error('任务名称不得超过30个字');
               // 这里涉及到获取数据更新之后的DOM，需要用$nextTick
               this.$nextTick(function() {
                  this.keywordReplyForm.keyword = event.target.value = value.slice(0, 30);
               })
               this.wordNumber = 0
            } else {
               this.wordNumber = 30 - value.length
            }
         }
      }
   })
</script>