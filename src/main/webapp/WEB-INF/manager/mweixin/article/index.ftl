<!-- 新建图文 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/article.css">
<div id='article' class="ms-article ms-container" v-show="menuVue.menuActive == '新建图文'">
    <el-container>
        <el-aside width="280px">
            <div class="ms-main-article">
                <img :src='mainArticle.basicPic'>
                <div class="ms-main-article-mask"></div>
                <span v-text='mainArticle.basicTitle'></span>
            </div>
            <draggable v-model="subArticleList" :options="{draggable:'.ms-article-item'}">
                <div v-for="(element,index) in subArticleList" :key="index" class="ms-article-item">
                    <p><span v-text='element.basicTitle'></span></p>
                    <img :src='element.basicThumbnailsl'>
                </div>
            </draggable>
            <div class="ms-article-footer">
                <el-button size='medium' icon='el-icon-plus' @click='addArticle'>添加图文</el-button>
            </div>
        </el-aside>
        <el-main>
            <div class="ms-main-header">
                <el-upload class="ms-pic-upload" :show-file-list="false">
                    <img v-if="false" :src="false" class="avatar">
                    <i v-else class="el-icon-picture"></i>
                    <span>添加封面</span>
                </el-upload>
                <el-form label-width='40px'>
                    <el-form-item label="标题" prop="">
                        <el-input size='small' placeholder="请输入图文标题" v-model='articleForm.basicTitle' @input="resetWordNum('title')">
                            <span slot='suffix' v-text="titleWordNumber+'/64'"></span>
                        </el-input>
                    </el-form-item>
                    <el-form-item label="作者" prop="">
                        <el-input size='small' placeholder="请输入图文作者" v-model='articleForm.articleAuthor' @input="resetWordNum('author')">
                            <span slot='suffix' v-text="authorWordNumber+'/8'"></span>
                        </el-input>
                    </el-form-item>
                    <el-form-item label="摘要" prop="">
                        <el-input 
                            size='small'
                            type='textarea' 
                            placeholder="选填，如果不写会默认抓取正文前54个字"
                            :autosize="{ minRows: 2, maxRows: 2}"
                            resize='none'
                            v-model='articleForm.basicDescription'
                            @input="resetWordNum('desc')"
                        >
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
</div>
<script>
    var articleVue = new Vue({
        el: '#article',
        data: {
            mainArticle: {
                basicPic: 'https://img03.sogoucdn.com/app/a/100520091/20190125112329', //主图
                basicTitle: '国足0-3不敌伊朗被淘汰，赛后还有一个消息', //标题
            },
            // 文章列表
            subArticleList: [{
                basicTitle: '硬核！年会当着老板面唱，“干活的干不过写PPT的……',
                basicThumbnailsl: 'https://img01.sogoucdn.com/app/a/100520091/20190125112509'
            }, {
                basicTitle: '知否知否，党组织犯错，处理有多严?',
                basicThumbnailsl: 'https://img01.sogoucdn.com/app/a/100520091/20190125112509'
            }, {
                basicTitle: '没有奇迹，国足0-3不敌伊朗止步八强!',
                basicThumbnailsl: 'https://img03.sogoucdn.com/app/a/100520091/20190125113148'
            }],
            titleWordNumber: 64, //图文标题剩余字数
            authorWordNumber: 8, //图文作者剩余字数
            descWordNumber:54,//摘要
            editor: null, //富文本实例
            articleForm:{
                basicTitle:'',//标题
                articleAuthor:'',//作者
                basicDescription:'', //摘要
                articleContent:'', //正文
            }
        },
        methods: {
            // 添加文章
            addArticle: function () {
                this.subArticleList.push({
                    basicTitle: '新增文章标题',
                    basicThumbnailsl: 'https://img03.sogoucdn.com/app/a/100520091/20190125113148'
                })
            },
            // 计算剩余字数
            resetWordNum:function(type){
               
            }
        },
        mounted: function () {
            let that = this;
            //富文本加载
            var URL = window.UEDITOR_HOME_URL || "http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/";
            if (this.editor == null) {
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
                this.editor.ready(function () {
                    var a = $("#ueditor_0").contents()[0].activeElement;
                    $(a).addClass("ms-webkit-scrollbar").before(
                        "<style>.ms-webkit-scrollbar::-webkit-scrollbar,::-webkit-scrollbar{width:10px;/*滚动条宽度*/height:1.5%;/*滚动条高度*/}/*定义滚动条轨道内阴影+圆角*/.ms-webkit-scrollbar::-webkit-scrollbar-track,::-webkit-scrollbar-track{border-radius:10px;/*滚动条的背景区域的圆角*/background-color:#eeeeee;/*滚动条的背景颜色*/}.ms-task-content::-webkit-scrollbar-track{border-radius:10px;background-color:#FFFFFF;}/*定义滑块内阴影+圆角*/.ms-webkit-scrollbar::-webkit-scrollbar-thumb,::-webkit-scrollbar-thumb{border-radius:10px;/*滚动条的圆角*/background-color:#dddddd;/*滚动条的背景颜色*/}</style>"
                    );
                });
            }
        }
    })
</script>