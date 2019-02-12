<!-- 新建图文 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/article.css">
<div id='article' class="ms-article" v-show="menuVue.menuActive == '新建图文'">
   <el-container class="ms-admin-picture">
      <!--右侧头部-->
      <el-header class="ms-header" height="50px">
         <el-row>
            <!-- 添加隐藏按钮，主要是为了产生间距 -->
            <el-button size="small" type="text"></el-button>
            <el-button class="ms-fr" size="small" icon="el-icon-arrow-left" @click="menuVue.menuActive = '关键词回复'">返回</el-button>
            <el-button class="ms-fr" size="small" icon="el-icon-refresh">更新</el-button>
            <el-button class="ms-fr" type="success" size="small" icon="el-icon-tickets" @click="newsSave">保存</el-button>
         </el-row>
      </el-header>
      <el-container class="ms-container">
         <el-aside width="280px">
             <!-- 主图文章 -->
            <div class="ms-main-article" @click='openMainArticle'>
               <img :src="mainArticle.thumbnailUrl ||　ms.base+'/WEB-INF/manager/images/article-default.png'">
               <div class="ms-article-mask"></div>
               <span v-text='mainArticle.basicTitle'></span>
            </div>
            <draggable v-model="subArticleList" :options="{draggable:'.ms-article-item'}">
               <div v-for="(element,index) in subArticleList" :key="index" class="ms-article-item" @click='updateSubArticle(element,index)'>
                  <p>
                     <span v-text='element.basicTitle'></span>
                  </p>
                  <img :src="element.basicThumbnails ||　ms.base+'/WEB-INF/manager/images/article-default-thumb.jpg'">
                  <div class="ms-article-item-mask"><i class="el-icon-delete" @click='subArticleList.splice(index,1)'></i></div>
               </div>
            </draggable>
            <div class="ms-article-footer">
               <el-button size='medium' icon='el-icon-plus' @click='addArticle'>添加图文</el-button>
            </div>
         </el-aside>
         <el-main>
            <div class="ms-main-header">
               <el-upload 
                    class="ms-pic-upload" 
                    :show-file-list="false" 
                    :on-success="basicPicSuccess"
                    :before-upload='beforeBasicPicUpload'
                    :action="ms.web + '/file/upload.do'"
                    :limit='1'
                    :disabled='uploadDisable'
                    :data={uploadFloderPath:"/mweixin/news"}
                >
                <div class="ms-article-mask" v-show='headMask' @mouseover='headMask=true;' @mouseleave='headMask=false'>
                    <i class="el-icon-delete" @click="articleForm.thumbnailUrl=mainArticle.basicPic='';uploadDisable=thumbnailShow=false"></i>
                </div>
                <img v-if="thumbnailShow" :src="articleForm.thumbnailUrl"
                class="article-thumbnail" @mouseover='headMask=true;' @mouseleave='headMask=false;'>
                <template v-else>
                    <i class="el-icon-picture"></i>
                    <span>添加封面</span>
                </template>
               </el-upload>
               <el-form label-width='40px'>
                  <el-form-item label="标题" prop="">
                     <el-input size='small' placeholder="请输入图文标题" v-model='articleForm.basicTitle' class='basic-title-input' @input.self="resetWordNum('basicTitle',64)">
                        <span slot='suffix' v-text="titleWordNumber+'/64'"></span>
                     </el-input>
                  </el-form-item>
                  <el-form-item label="作者" prop="">
                     <el-input size='small' placeholder="请输入图文作者" v-model='articleForm.articleAuthor' @input.self="resetWordNum('articleAuthor',8)">
                        <span slot='suffix' v-text="authorWordNumber+'/8'"></span>
                     </el-input>
                  </el-form-item>
                  <!-- @input="resetWordNum(120)" -->
                  <el-form-item label="摘要" prop="">
                     <el-input size='small' type='textarea' placeholder="选填，如果不写会默认抓取正文前54个字" :autosize="{ minRows: 2, maxRows: 2}" resize='none' v-model='articleForm.basicDescription'>
                        <span slot='suffix' v-text="descWordNumber+'/54'"></span>
                     </el-input>
                  </el-form-item>
               </el-form>
            </div>
            <div class="ms-main-body">
               <!-- 百度编辑器 -->
               <script id="ueditorArticle" type="text/plain" name="articleContent"></script>
            </div>
         </el-main>
      </el-container>
   </el-container>
</div>
<script>
   var articleVue = new Vue({
      el: '#article',
      data: {
         mainArticle: {
            basicTitle: '', //标题
            articleAuthor: '', //作者
            basicDescription: '', //摘要
            articleContent: '', //正文
            basicThumbnails:'',//上传封面图片的url
            thumbnailUrl:'',//缩略图全路径
         },
         defaultMainArticle:'',//拷贝主图信息
         subArticleList: [],// 子文章列表
         titleWordNumber: 64, //图文标题剩余字数
         authorWordNumber: 8, //图文作者剩余字数
         descWordNumber: 54, //摘要
         editor: null, //富文本实例
         editorCurrentContent: null, //当前百度编辑器输入的内容
         articleForm: {
            basicTitle: '', //标题
            articleAuthor: '', //作者
            basicDescription: '', //摘要
            articleContent: '', //正文
            basicThumbnails:'',//上传封面图片的url
            thumbnailUrl:'',//缩略图全路径
         },
        //  文章素材，包括主图文，子图文
         articleList:[],
         defaultArticleForm:'',//拷贝表单值
         thumbnailShow:false,//显示缩略图
         headMask:false,//缩略图删除
         uploadDisable:false,//是否禁止上传
         newsCategoryId:'',//微信分类编号
      },
      watch:{
            articleForm:{
                handler:function(n,o){
                    this.articleList.length || (this.mainArticle.basicTitle = n.basicTitle)
                    console.log('n文章',n);
                },
                deep:true,
            },
            editorCurrentContent:{
                handler:function(n,o){
                    console.log('n文章',n);
                    this.articleForm.articleContent = n
                },
                deep:true,
            },
            mainArticle:{
                handler:function(n,o){
                    console.log('n文章444444444444444',n);
                },
                deep:true,
            },
      },
      methods: {
          open:function(material){
                menuVue.menuActive = '新建图文';
                material && material.newsId>0 ?　this.resetForm(material) : this.resetForm()
          },
        //   图片上传之前进行数据校验
        beforeBasicPicUpload:function(file){
            var fileType = null;
            ['image/jpeg','image/png','image/jpg'].indexOf(file.type)>-1 ? fileType = true : fileType = false
	        var isLt2M = file.size / 1024 / 1024 < 2;
	        !fileType && this.$message.error('文章配图只能是 JPG、JPEG、PNG 格式!');
	        !isLt2M && this.$message.error('文章配图大小不能超过 2MB!');
	        return fileType && isLt2M;
        },
        //   图片上传成功函数
        basicPicSuccess:function(url){
            this.thumbnailShow = this.uploadDisable = true
            this.mainArticle.thumbnailUrl = this.articleForm.thumbnailUrl = ms.web + url
            this.articleForm.basicThumbnails = url
        },
         // 添加文章
         addArticle: function() {
            console.log('this.articleForm1111111',this.articleForm);
            if(this.subArticleList.length > 6) {
                return this.$notify({
                  title: '添加失败',
                  message: '最大图文数量为7',
                  type: 'warning'
               });
            }
            // 将主图文单独存于数组中
            if(!this.articleList.length){
                this.mainArticle = this.articleForm
            }
            console.log('this.articleForm99999999999999',this.articleForm);
            // 清空百度编辑器
            this.editor.setContent('')
            // 将左侧表单的内容存放到数组中
            this.articleList.push(this.articleForm)
            // 清空表单
            console.log('this.articleForm',this.articleForm);
            console.log('this.articleList',this.articleList);
            this.articleForm = {
                basicTitle: '', 
                articleAuthor: '', 
                basicDescription: '', 
                articleContent: '', 
                basicThumbnails:'',
                thumbnailUrl:'',
            }
            this.thumbnailShow = false //显示上传图标
            this.subArticleList.push({
                basicTitle: '', 
                articleAuthor: '', 
                basicDescription: '', 
                articleContent: '', 
                basicThumbnails:'',
                thumbnailUrl:'',
            })
         },
        // 打开修改子文章
         updateSubArticle:function(element,index){
             this.articleForm = element
         },
          // 打开 主文章
        openMainArticle:function(){
            this.thumbnailShow = true //显示上传图标
            this.articleForm = this.mainArticle
        },
         // 计算剩余字数
         resetWordNum: function(type,limit) {
             var target = event.target
             type.indexOf('Title') > -1 ? this.titleWordNumber = limit - event.target.value.length : this.authorWordNumber = limit - event.target.value.length
             if(event.target.value.length >= limit){
                 this.$message.error('超出字数限制，请输入不超过'+limit+'字符');
                 this.$nextTick(function(){
                    //  这里的event的type是message
                     this.articleForm[type] = target.value.slice(0,limit-1);
                     console.log('this.articleForm[type]',this.articleForm[type]);
                 })
             }
         },
        //  保存微信文章
        newsSave:function(){
            var that = this;
            console.log('that.articleForm',that.articleForm);
            console.log('that.articleList',that.articleList);
            // 获取百度编辑器内容
            // this.editorCurrentContent = ''
            ms.http.post(ms.manager + "/weixin/news/save.do",{
                newsArticle:that.mainArticle,
                articleList:JSON.stringify(that.articleList),
                newsCategoryId:that.newsCategoryId,
                newsIsSyn:false,
                newsType:1
            }).then(function (res) {
                   console.log('res',res); 
            }, function (err) {
                that.$message.error(err);
            })
        },
        // 表单重置 新建和修改场景
        resetForm:function(material){
            this.thumbnailShow = material ? true : false
            this.articleForm.thumbnailUrl = material ?  material.newsArticle.basicPic : ''

            this.mainArticle.basicPic = material ? material.newsArticle.basicPic : ''
            this.mainArticle.basicTitle = material ? material.newsArticle.basicTitle : ''

            // 打开界面默认显示主文章详情
            this.articleForm.basicTitle = material ? material.newsArticle.basicTitle : ''
            this.articleForm.articleAuthor = material ? material.newsArticle.articleAuthor : ''
            this.articleForm.basicDescription = material ? material.newsArticle.basicDescription : ''
            var result = '';
            result = (material && material.newsArticle.articleContent) ? material.newsArticle.articleContent : ''
            this.editor.setContent(result)

            this.subArticleList = material ? material.articleList : [];
            this.$forceUpdate();  
        },
      },
      mounted: function() {
         let that = this;
         //富文本加载
         var URL = window.UEDITOR_HOME_URL || "http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/";
         if(this.editor == null) {
            this.editor = UE.getEditor('ueditorArticle', {
               toolbars: [
                  ['fullscreen', 'undo', 'redo', '|', 'bold', 'italic', 'underline',
                     'strikethrough',
                     'removeformat', 'blockquote',
                     '|', 'forecolor', 'backcolor', 'insertorderedlist',
                     'insertunorderedlist', '|', 'attachment', 'simpleupload', 'link'
                  ]
               ],
               imageScaleEnabled: true,
               // 服务器统一请求接口路径
               serverUrl: URL +
                  "jsp/msController.jsp?jsonConfig=%7BvideoUrlPrefix:'http://mpm.mingsoft.net/',fileUrlPrefix:'http://mpm.mingsoft.net/',imageUrlPrefix:'http://mpm.mingsoft.net/',imagePathFormat:'/upload/pm/editor/%7Btime%7D',filePathFormat:'/upload/pm/editor/%7Btime%7D',videoPathFormat:'/upload/pm/editor/%7Btime%7D'%7D",
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
               initialFrameHeight: 500,
            });
            this.editor.ready(function() {
               var a = $("#ueditor_0").contents()[0].activeElement;
               $(a).addClass("ms-webkit-scrollbar").before(
                  "<style>.ms-webkit-scrollbar::-webkit-scrollbar,::-webkit-scrollbar{width:10px;/*滚动条宽度*/height:1.5%;/*滚动条高度*/}/*定义滚动条轨道内阴影+圆角*/.ms-webkit-scrollbar::-webkit-scrollbar-track,::-webkit-scrollbar-track{border-radius:10px;/*滚动条的背景区域的圆角*/background-color:#eeeeee;/*滚动条的背景颜色*/}.ms-task-content::-webkit-scrollbar-track{border-radius:10px;background-color:#FFFFFF;}/*定义滑块内阴影+圆角*/.ms-webkit-scrollbar::-webkit-scrollbar-thumb,::-webkit-scrollbar-thumb{border-radius:10px;/*滚动条的圆角*/background-color:#dddddd;/*滚动条的背景颜色*/}</style>"
               );
            });
            this.editor.addListener('contentChange',function() {
                that.editorCurrentContent = that.editor.getContent();
                that.$message.success(that.editor.getContent());
            });
         }
      }
   })
</script>