<!-- 新建图文 -->
<!--#include virtual="../../include/head-file.ftl" -->
<script src="//cdn.jsdelivr.net/npm/sortablejs@1.7.0/Sortable.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Vue.Draggable/2.17.0/vuedraggable.min.js"></script>
<link rel="stylesheet" href="../../../../static/mweixin/css/article.css">
<!-- v-if="menuVue.menuActive == '新建图文'" -->
<div id='article' class="ms-article">
    <el-container>
        <el-aside width="280px">
            <div class="ms-main-article">
                <img src='https://img03.sogoucdn.com/app/a/100520091/20190125112329'>
                <div class="ms-main-article-mask"></div>
                <span>国足0-3不敌伊朗被淘汰，赛后还有一个消息</span>
            </div>
            <draggable v-model="subArticleList" :options="{draggable:'.item'}">
                <div v-for="(element,index) in subArticleList" :key="index" class="ms-article-item">
                    <p><span v-text='element.title'></span></p>
                    <img :src='element.thumbnail'>
                </div>
            </draggable>
            <el-button size='mini'>添加图文</el-button>
        </el-aside>
        <el-main>Main</el-main>
    </el-container>
</div>
<script>
    var articleVue = new Vue({
        el: '#article',
        data: {
            // 文章列表
            subArticleList: [{
                title: '硬核！年会当着老板面唱，“干活的干不过写PPT的……',
                desc: '001100',
                thumbnail:'https://img01.sogoucdn.com/app/a/100520091/20190125112509'
            }, {
                title: '个问题grew',
                desc: '001100',
                thumbnail:'https://img01.sogoucdn.com/app/a/100520091/20190125112509'
            }, {
                title: '跟他玩过任务',
                desc: '001100',
                thumbnail:'https://img01.sogoucdn.com/app/a/100520091/20190125112509'
            }, {
                title: '供热外国人',
                desc: '001100',
                thumbnail:'https://img01.sogoucdn.com/app/a/100520091/20190125112509'
            }, {
                title: '天文台认为',
                desc: '001100',
                thumbnail:'https://img01.sogoucdn.com/app/a/100520091/20190125112509'
            }]
        },
        watch: {
            subArticleList: function (n, o) {
                console.log('n', n);
            }
        },
        methods: {
            addPeople: function () {

            }
        }
    })
</script>