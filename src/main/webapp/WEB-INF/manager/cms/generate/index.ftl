<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>静态化</title>
    <#include "../../include/head-file.ftl">
    <style>
        [v-cloak]{
            display: none;
        }
    </style>
</head>
<body class="custom-body">
<div id="app" class="ms-index" v-cloak>
    <el-form ref="form" label-width="100px" size="mini">
        <div class="class-2" >
            <div class="class-3 panel" >
                <div class="class-4" >
                    <el-form-item label="主页模板" >
                        <el-select v-model="template"
                                   :filterable="true"
                                   :clearable="false"
                                   placeholder="请选择主页模板">
                            <el-option v-for='item in templateOptions' :key="item" :value="item"
                                       :label="item"></el-option>
                        </el-select>
                        <div class="ms-form-tip">
                            一般选择<i>index.htm</i>模板
                        </div>
                    </el-form-item>
                </div>
                <div class="class-7" >
                    <el-form-item label="主页位置">
                        <el-input v-model="position"
                                  :disabled="false"
                                  :style="{width:  '100%'}"
                                  :clearable="true"
                                  placeholder="请输入主页位置">
                        </el-input>
                        <div class="ms-form-tip">
                            一般为index.html或default.html,
                            如果是<i>引导页面->首页</i>，可以手动调整主页模板与主页设置，先生成引导页，再生成首页。一般default.html为引导页面index.html为主页(需要服务器容器配置好对应默认页)。<br/>
                            点击“预览主页”可跳转到网站首页进行预览网站首页<br/>
                            不能选择有分页标签的页面生成，例如news-list.htm、search.htm<br/>
                            如果下拉没有出现模板，请检查应用设置是否绑定了模板<br/>
                        </div>
                    </el-form-item>
                </div>
                <div class="class-10" >
                    <el-form-item>
                        <@shiro.hasPermission name="cms:generate:index">
                            <el-button type="primary" @click="updataIndex" :loading="homeLoading">{{homeLoading?'更新中':'生成主页'}}</el-button>
                        </@shiro.hasPermission>
                            <el-button plain @click="viewIndex">预览主页</el-button>
                    </el-form-item>
                </div>
            </div>
            <div class="class-13 panel" >
                <div class="class-14" >
                    <el-form-item label="文章栏目">
                        <ms-tree-select v-model:value="contentSection"
                                     :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                                     :options="treeList" :style="{width:'100%'}"
                                     placeholder="请选择文章栏目">
                        </ms-tree-select>
                        <div class="ms-form-tip">
                            生成指定栏目下的文章内容
                        </div>
                    </el-form-item>
                </div>
                <div class="class-17" >
                    <el-form-item label="指定时间">
                        <el-date-picker
                                v-model="time"
                                placeholder="请选择指定时间"
                                start-placeholder=""
                                en.class-3d-placeholder=""
                                :readonly="false"
                                :disabled="false"
                                :editable="false"
                                :clearable="false"
                                format="yyyy-MM-dd"
                                value-format="yyyy-MM-dd"
                                :style="{width:'100%'}"
                                type="date">
                        </el-date-picker>
                        <div class="ms-form-tip">
                            根据内容的更新时间来生成，例如：2021-01-01，则生成21年01月01号以后更新过的文章，如果遇到内容没有生成或者内容样式没有更新可以调整时间
                        </div>
                    </el-form-item>
                </div>
                <div class="class-20" >
                    <@shiro.hasPermission name="cms:generate:article">
                        <el-form-item>
                            <el-button type="primary" @click="updateArticle" :loading="articleLoading">{{articleLoading?'更新中':'生成文章'}}</el-button>
                        </el-form-item>
                    </@shiro.hasPermission>

                </div>
            </div>
            <div class="class-23 panel" >
                <div class="class-24" >
                    <el-form-item label="生成栏目">
                        <ms-tree-select v-model:value="section"
                                     :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                                     :options="treeList" :style="{width:'100%'}"
                                     placeholder="请选择文章栏目">
                        </ms-tree-select>
                        <div class="ms-form-tip">
                            生成<b>栏目类型</b>为列表的数据，例如：新闻列表、产品列表
                        </div>
                    </el-form-item>
                </div>

                <div class="class-30" >
                    <@shiro.hasPermission name="cms:generate:column">
                    <el-form-item>
                        <el-button type="primary" @click="updateColumn" :loading="columnLoading">{{columnLoading?'更新中':'生成栏目'}}</el-button>
                    </el-form-item>
                    </@shiro.hasPermission>

                </div>
            </div>
        </div>
    </el-form>
</div>
</body>
</html>
<script>
    "use strict";

    var app = new Vue({
        el: '#app',
        watch: {},
        data: function () {
            return {
                homeLoading: false,
                articleLoading: false,
                columnLoading: false,
                template: '',
                //主题模板
                templateOptions: [],
                position: 'index',
                //位置
                contentSection: '0',
                //文章栏目
                section: '0',
                //栏目
                time: ms.util.date.fmt(new Date(), "yyyy-MM-dd"),
                treeList: [{
                    id: '0',
                    categoryTitle: '顶级栏目',
                    children: []
                }]
            }
        },
        methods: {
            //更新主页
            updataIndex: function () {
                var that = this;
                if (!that.position || that.position == '') {
                    this.$notify({
                        title: '失败',
                        message: '请输入主页位置！',
                        type: 'warning'
                    });
                    return;
                }
                that.homeLoading = true;
                ms.http.post(ms.manager + '/cms/generate//generateIndex.do', {
                    url: that.template,
                    position: that.position
                }).then(function (data) {
                    if (data.result) {
                        that.$notify({
                            title: '成功',
                            message: '更新成功！',
                            type: 'success'
                        });
                    } else {
                        that.$notify({
                            title: '失败',
                            message: data.msg,
                            type: 'error'
                        });
                    }
                }).finally(function () {
                    that.homeLoading = false;
                });
            },
            //预览主页
            viewIndex: function () {
                if (!this.position || this.position == '') {
                    this.$notify({
                        title: '失败',
                        message: '请输入主页位置！',
                        type: 'warning'
                    });
                    return;
                }
                window.open(ms.manager + "/cms/generate/" + this.position + "/viewIndex.do");
            },
            //更新栏目
            updateColumn: function () {
                var that = this;
                that.columnLoading = true;
                ms.http.get(ms.manager + '/cms/generate/' + (that.section ? that.section : 0) + '/generateColumn.do').then(function (data) {
                    if (data.result) {
                        that.$notify({
                            title: '成功',
                            message: '更新成功！',
                            type: 'success'
                        });
                    }else {
                        that.$notify({
                            title: '生成失败',
                            message:data.msg,
                            type: 'error'
                        });
                    }
                }).finally(function () {
                    that.columnLoading = false;
                });
            },
            //生成文章栏目
            updateArticle: function () {
                var that = this;
                that.articleLoading = true;
                ms.http.post(ms.manager + '/cms/generate/' + (that.contentSection ? that.contentSection : 0) + '/generateArticle.do', {
                    dateTime: that.time
                }).then(function (data) {
                    if (data.result) {
                        that.$notify({
                            title: '成功',
                            message:'更新成功！',
                            type: 'success'
                        });
                    }else {
                        that.$notify({
                            title: '生成失败！',
                            message:data.msg,
                            type: 'error'
                        });
                    }
                }).finally(function () {
                    that.articleLoading = false;
                });
            },
            //获取主题模板数据源
            templateOptionsGet: function () {
                var that = this;
                ms.http.get(ms.manager + '/basic/template/queryTemplateFileForColumn.do', {
                    pageSize: 99999
                }).then(function (data) {
                    that.templateOptions = data.data; //寻找主页

                    var template = that.templateOptions.find(function (x) {
                        return x.indexOf("index") != -1 || x.indexOf("default") != -1;
                    }); //没有就找其他的

                    that.template = template || (that.templateOptions.length > 0 ? that.templateOptions[0] : "");
                });
            },
            getTree: function () {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/list.do", {
                    pageSize: 9999
                }).then(function (res) {
                    if (res.result) {
                        //res.data.rows.push({id:0,categoryId: null,categoryTitle:'顶级栏目管理'});
                        that.treeList[0].children = ms.util.treeData(res.data.rows, 'id', 'categoryId', 'children');
                    }
                });
            }
        },
        created: function () {
            this.getTree();
            this.templateOptionsGet();
        }
    });
</script>
<style>
    #app {
        background-color: white;
    }
    #app .panel {
        background-color: white;
        padding: 20px 40px 20px 40px;
        border: 1px solid #EBEEF5;
    }
    input{
        width: 100%!important;
    }
    .class-1
    {
        color:#333333;
        outline:none;
        outline-offset:-1px;
        max-width:100%;
        background-color:#FFFFFF;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        width:100%;
        background-repeat:no-repeat;
        padding: 14px;
    }
    .class-2
    {
        color:#333333;
        outline:none;
        outline-offset:-1px;
        height:500px;
        max-width:100%;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        width:100%;
        background-repeat:no-repeat;
    }
    .class-3
    {
        color:#333333;
        padding:20px;
        outline:none;
        outline-offset:-1px;
        min-height:250px;
        max-width:100%;
        background-color:#FFFFFF;
        flex-direction:column;
        display:flex;
        margin: 12px 6px 12px 12px;
        animation-duration:1s;
        width:100%;
        padding-left:20px;
        background-repeat:no-repeat;
    }
    .class-4
    {
        color:#333333;
        outline:none;
        outline-offset:-1px;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-5
    {
        color:#333333;
        word-wrap:break-word;
        display:inline-block;
        animation-duration:1s;
        font-size:14px;
        line-height:1.4;
    }
    .class-6
    {
        border-color:#EEEEEE;
        color:#606266;
        padding-right:15px;
        box-sizing:boredr-box;
        outline:none;
        border-width:1px;
        border-style:solid;
        height:40px;
        margin-left:20px;
        animation-duration:1s;
        background:none;
        width:320px;
        font-size:12px;
        line-height:40px;
        padding-left:15px;
    }
    .class-7
    {
        border-color:#EEEEEE;
        color:#333333;
        outline:none;
        outline-offset:-1px;
        border-width:1px;
        border-style:none;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-8
    {
        color:#333333;
        word-wrap:break-word;
        display:inline-block;
        animation-duration:1s;
        font-size:14px;
        line-height:1.4;
    }
    .class-9
    {
        border-color:#EEEEEE;
        color:#606266;
        padding-right:15px;
        box-sizing:boredr-box;
        outline:none;
        border-width:1px;
        border-style:solid;
        height:40px;
        margin-left:20px;
        animation-duration:1s;
        background:none;
        width:320px;
        font-size:12px;
        line-height:40px;
        padding-left:15px;
    }
    .class-10
    {
        border-color:#EEEEEE;
        color:#333333;
        outline:none;
        outline-offset:-1px;
        border-width:1px;
        border-style:none;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-11
    {
        cursor:pointer;
        color:#ffffff;
        box-sizing:border-box;
        height:34px;
        background-color:#0099ff;
        text-align:center;
        display:inline-block;
        animation-duration:1s;
        border-radius:4px;
        width:98px;
        line-height:34px;
        font-size:14px;
    }
    .class-12
    {
        cursor:pointer;
        border-color:#0099FF;
        color:#0099FF;
        box-sizing:border-box;
        border-width:1px;
        border-style:solid;
        height:34px;
        background-color:#FFFFFF;
        text-align:center;
        display:inline-block;
        margin-left:10px;
        animation-duration:1s;
        border-radius:4px;
        width:98px;
        line-height:34px;
        font-size:14px;
    }
    .class-13
    {
        color:#333333;
        padding:20px;
        outline:none;
        outline-offset:-1px;
        min-height:250px;
        max-width:100%;
        background-color:#FFFFFF;
        flex-direction:column;
        display:flex;
        margin: 12px 6px;
        animation-duration:1s;
        width:100%;
        padding-left:20px;
        background-repeat:no-repeat;
    }
    .class-14
    {
        color:#333333;
        outline:none;
        outline-offset:-1px;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-15
    {
        color:#333333;
        word-wrap:break-word;
        display:inline-block;
        animation-duration:1s;
        font-size:14px;
        line-height:1.4;
    }
    .class-16
    {
        border-color:#EEEEEE;
        color:#606266;
        padding-right:15px;
        box-sizing:boredr-box;
        outline:none;
        border-width:1px;
        border-style:solid;
        height:40px;
        margin-left:20px;
        animation-duration:1s;
        background:none;
        width:320px;
        font-size:12px;
        line-height:40px;
        padding-left:15px;
    }
    .class-17
    {
        border-color:#EEEEEE;
        color:#333333;
        outline:none;
        outline-offset:-1px;
        border-width:1px;
        border-style:none;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-18
    {
        color:#333333;
        word-wrap:break-word;
        display:inline-block;
        animation-duration:1s;
        font-size:14px;
        line-height:1.4;
    }
    .class-19
    {
        border-color:#EEEEEE;
        color:#606266;
        padding-right:15px;
        box-sizing:boredr-box;
        outline:none;
        border-width:1px;
        border-style:solid;
        height:40px;
        margin-left:20px;
        animation-duration:1s;
        background:none;
        width:320px;
        font-size:12px;
        line-height:40px;
        padding-left:15px;
    }
    .class-20
    {
        color:#333333;
        outline:none;
        outline-offset:-1px;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-21
    {
        cursor:pointer;
        color:#ffffff;
        box-sizing:border-box;
        height:34px;
        background-color:#0099ff;
        text-align:center;
        display:inline-block;
        animation-duration:1s;
        border-radius:4px;
        width:98px;
        line-height:34px;
        font-size:14px;
    }
    .class-22
    {
        cursor:pointer;
        border-color:#0099FF;
        color:#0099FF;
        box-sizing:border-box;
        border-width:1px;
        border-style:solid;
        height:34px;
        background-color:#FFFFFF;
        text-align:center;
        display:inline-block;
        margin-left:10px;
        animation-duration:1s;
        border-radius:4px;
        width:98px;
        line-height:34px;
        font-size:14px;
    }
    .class-23
    {
        color:#333333;
        padding:20px;
        outline:none;
        outline-offset:-1px;
        min-height:250px;
        max-width:100%;
        background-color:#FFFFFF;
        flex-direction:column;
        display:flex;
        margin: 12px 12px 12px 6px;
        animation-duration:1s;
        width:100%;
        padding-left:20px;
        background-repeat:no-repeat;
    }
    .class-24
    {
        color:#333333;
        outline:none;
        outline-offset:-1px;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-25
    {
        color:#333333;
        word-wrap:break-word;
        display:inline-block;
        animation-duration:1s;
        font-size:14px;
        line-height:1.4;
    }
    .class-26
    {
        border-color:#EEEEEE;
        color:#606266;
        padding-right:15px;
        box-sizing:boredr-box;
        outline:none;
        border-width:1px;
        border-style:solid;
        height:40px;
        margin-left:20px;
        animation-duration:1s;
        background:none;
        width:320px;
        font-size:12px;
        line-height:40px;
        padding-left:15px;
    }
    .class-27
    {
        border-color:#EEEEEE;
        color:#333333;
        outline:none;
        outline-offset:-1px;
        border-width:1px;
        border-style:none;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-28
    {
        color:#333333;
        word-wrap:break-word;
        display:inline-block;
        animation-duration:1s;
        font-size:14px;
        line-height:1.4;
    }
    .class-29
    {
        border-color:#EEEEEE;
        color:#606266;
        padding-right:15px;
        box-sizing:boredr-box;
        outline:none;
        border-width:1px;
        border-style:solid;
        height:40px;
        margin-left:20px;
        animation-duration:1s;
        background:none;
        width:320px;
        font-size:12px;
        line-height:40px;
        padding-left:15px;
    }
    .class-30
    {
        color:#333333;
        outline:none;
        outline-offset:-1px;
        max-width:100%;
        align-items:center;
        flex-direction:row;
        display:flex;
        animation-duration:1s;
        background-repeat:no-repeat;
    }
    .class-31
    {
        cursor:pointer;
        color:#ffffff;
        box-sizing:border-box;
        height:34px;
        background-color:#0099ff;
        text-align:center;
        display:inline-block;
        animation-duration:1s;
        border-radius:4px;
        width:98px;
        line-height:34px;
        font-size:14px;
    }
    .class-32
    {
        cursor:pointer;
        border-color:#0099FF;
        color:#0099FF;
        box-sizing:border-box;
        border-width:1px;
        border-style:solid;
        height:34px;
        background-color:#FFFFFF;
        text-align:center;
        display:inline-block;
        margin-left:10px;
        animation-duration:1s;
        border-radius:4px;
        width:98px;
        line-height:34px;
        font-size:14px;
    }
    .el-select,
    .el-input,
    .el-form-item,
    .el-date-editor{
        width: 100%;
    }
</style>
