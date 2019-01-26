<!-- 新建图文 -->
<!--#include virtual="../../include/head-file.ftl" -->
<script src="//cdn.jsdelivr.net/npm/sortablejs@1.7.0/Sortable.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Vue.Draggable/2.17.0/vuedraggable.min.js"></script>
<link rel="stylesheet" href="../../../../static/mweixin/css/article.css">
<!--jquery-->
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8" src="http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/ueditor.parse.js"></script>
<script type="text/javascript" charset="utf-8" src="http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/lang/zh-cn/zh-cn.js"></script>
<!-- v-if="menuVue.menuActive == '新建图文'" -->
<div id='article' class="ms-article ms-container">
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
                <el-upload class="ms-pic-uploader" :show-file-list="false">
                    <img v-if="false" :src="false" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
                <el-form>
                    <el-form-item label="标题" prop="name">
                        <el-input size='mini' placeholder="请输入图文标题">
                            <span slot='suffix' v-text="titleWordNumber+'/64'"></span>
                        </el-input>
                    </el-form-item>
                    <el-form-item label="作者" prop="region">
                        <el-input size='mini' placeholder="请输入图文作者">
                            <span slot='suffix' v-text="authorWordNumber+'/8'"></span>
                        </el-input>
                    </el-form-item>
                    <el-form-item label="摘要" prop="region">
                        <el-input size='mini' type='textarea' placeholder="选填，如果不写会默认抓取正文前54个字">
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
            titleWordNumber: '', //图文标题剩余字数
            authorWordNumber: '', //图文作者剩余字数
            editor: null, //富文本实例
        },
        watch: {
            subArticleList: function (n, o) {
                console.log('n', n);
            }
        },
        methods: {
            // 添加文章
            addArticle: function () {
                this.subArticleList.push({
                    basicTitle: '新增文章标题',
                    basicThumbnailsl: 'https://img03.sogoucdn.com/app/a/100520091/20190125113148'
                })
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
                    initialFrameWidth: 600,
                    initialFrameHeight: 240,
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