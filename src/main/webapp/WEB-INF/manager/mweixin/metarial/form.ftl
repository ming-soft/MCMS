<!-- 新建图文 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/article.css">
<div id='article' class="ms-article" v-show="menuVue.menuActive == '新建图文'">
   <el-container class="ms-admin-picture">
      <!--右侧头部-->
      <el-header class="ms-header" height="50px">
         <el-row>
            <el-button class="ms-fr" size="small" icon="el-icon-arrow-left" @click="menuVue.menuActive = '关键词回复'">返回</el-button>
            <el-button class="ms-fr" size="small" icon="el-icon-refresh">更新</el-button>
            <el-button class="ms-fr" type="success" size="small" icon="el-icon-tickets" @click="newsSave">保存</el-button>
         </el-row>
      </el-header>
      <el-container class=" ms-container">
         <el-aside width="280px">
             <!-- 主图文章 -->
            <div class="ms-main-article">
               <img :src="mainArticle.basicPic ||　ms.base+'/WEB-INF/manager/images/data/article-default.png'">
               <div class="ms-article-mask"></div>
               <span v-text='mainArticle.basicTitle'></span>
            </div>
            <draggable v-model="subArticleList" :options="{draggable:'.ms-article-item'}">
               <div v-for="(element,index) in subArticleList" :key="index" class="ms-article-item">
                  <p>
                     <span v-text='element.basicTitle'></span>
                  </p>
                  <img :src='element.basicThumbnails'>
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
                    <i class="el-icon-delete" @click="thumbnailUrl=mainArticle.basicPic='';uploadDisable=thumbnailShow=false"></i>
                </div>
                <img v-if="thumbnailShow" :src="thumbnailUrl"
                class="article-thumbnail" @mouseover='headMask=true;' @mouseleave='headMask=false;'>
                <template v-else>
                    <i class="el-icon-picture"></i>
                    <span>添加封面</span>
                </template>
               </el-upload>
               <el-form label-width='40px'>
                  <el-form-item label="标题" prop="">
                     <el-input size='small' placeholder="请输入图文标题" v-model='articleForm.basicTitle' @input="resetWordNum('basicTitle',64)">
                        <span slot='suffix' v-text="titleWordNumber+'/64'"></span>
                     </el-input>
                  </el-form-item>
                  <el-form-item label="作者" prop="">
                     <el-input size='small' placeholder="请输入图文作者" v-model='articleForm.articleAuthor' @input="resetWordNum('articleAuthor',8)">
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
            basicPic: '', //主图
            basicTitle: '', //标题
         },
         defaultMainArticle:'',//拷贝主图信息
         subArticleList: [],// 子文章列表
         titleWordNumber: 64, //图文标题剩余字数
         authorWordNumber: 8, //图文作者剩余字数
         descWordNumber: 54, //摘要
         editor: null, //富文本实例
         articleForm: {
            basicTitle: '', //标题
            articleAuthor: '', //作者
            basicDescription: '', //摘要
            articleContent: '', //正文
         },
         defaultArticleForm:'',//拷贝表单值
         thumbnailShow:false,//显示缩略图
         thumbnailUrl:'',//缩略图路径
         headMask:false,//缩略图删除
         uploadDisable:false,//是否禁止上传
      },
      watch:{
            articleForm:{
                handler:function(n,o){
                    this.mainArticle.basicTitle = n.basicTitle
                },
                deep:true,
            }
      },
      methods: {
          open:function(material){
                menuVue.menuActive = '新建图文';
                if(material && material.newsId>0){
                    // 编辑
                    this.subArticleList = material.articleList
                    this.mainArticle = material.newsArticle
                }else{
                    // 新增
                    console.log('this.defaultArticleForm',this.defaultArticleForm);
                    this.articleForm = this.defaultArticleForm
                    this.mainArticle = this.defaultMainArticle
                }
                console.log('"material',material);
          },
        //   图片上传之前的钩子
        beforeBasicPicUpload:function(file){
            var fileType = false;
	    	if(file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/jpg'){
	    		fileType = true;
	    	}
	        const isLt2M = file.size / 1024 / 1024 < 2;
	        if (!fileType) {
	          this.$message.error('文章配图只能是 JPG、JPEG、PNG 格式!');
	        }
	        if (!isLt2M) {
	          this.$message.error('文章配图大小不能超过 2MB!');
	        }
	        return fileType && isLt2M;
        },
        //   图片上传成功函数
        basicPicSuccess:function(url){
            this.thumbnailShow = this.uploadDisable = true
            this.thumbnailUrl = ms.web + url
            this.mainArticle.basicPic = this.thumbnailUrl

        },
         // 添加文章
         addArticle: function() {
            if(this.subArticleList.length > 6) {
               this.$notify({
                  title: '添加失败',
                  message: '最大图文数量为7',
                  type: 'warning'
               });
               return;
            }
            this.subArticleList.push({
               basicTitle: '新增文章标题',
               basicThumbnailsl: 'https://img03.sogoucdn.com/app/a/100520091/20190125113148'
            })
         },
         // 计算剩余字数
         resetWordNum: function(type,limit) {
             var result = event.target.value;
             if(type.indexOf('Title') > -1){
                this.titleWordNumber = limit - result.length
             }else{
                 this.authorWordNumber = limit - result.length
             }
             if(result.length >= limit){
                 this.$message.error('超出字数限制，请输入不超过'+limit+'字符');
                 this.$nextTick(function(){
                     this.articleForm[type] = result.slice(0,limit);
                 })
             }
         },
        //  保存微信文章
        newsSave:function(){

        }
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
         }

        //  初始化默认值
        this.defaultArticleForm = JSON.parse(JSON.stringify(this.articleForm))
        this.defaultMainArticle = JSON.parse(JSON.stringify(this.mainArticle))
      }
   })
</script>