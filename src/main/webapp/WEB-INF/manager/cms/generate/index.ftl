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
<div id="app" v-cloak>
    <el-form ref="form" label-width="100px" size="mini">
        <div class="class-2" >
            <div class="class-3" >
                <div class="class-4" >
                    <el-form-item >
                        <template slot='label'>主页模板
                            <el-popover slot="label" placement="top-start" title="提示" width="200" trigger="hover" content="更新主页，如果系统存在引导页面可以手动修改主页位置文件名,default.html引导页面index.html主页。">
                                <i class="el-icon-question" slot="reference"></i>
                            </el-popover>
                        </template>

                        <el-select v-model="template"
                                   :filterable="true"
                                   :clearable="false"
                                   placeholder="请选择主页模板">
                            <el-option v-for='item in templateOptions' :key="item" :value="item"
                                       :label="item"></el-option>
                        </el-select>
                    </el-form-item>
                </div>
                <div class="class-7" >
                    <el-form-item>
                        <template slot='label'>主页位置
                            <el-popover slot="label" placement="top-start" title="提示" width="200" trigger="hover" content="主页位置htm文件名一般为index.html或default.html">
                                <i class="el-icon-question" slot="reference"></i>
                            </el-popover>
                        </template>
                        <el-input v-model="position"
                                  :disabled="false"
                                  :style="{width:  '100%'}"
                                  :clearable="true"
                                  placeholder="请输入主页位置">
                        </el-input>
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
            <div class="class-13" >
                <div class="class-14" >
                    <el-form-item>
                        <template slot='label'>文章栏目
                            <el-popover slot="label" placement="top-start" title="提示" width="200" trigger="hover" content="生成对应栏目属性为列表的内容数据，例如：新闻详情、产品详情">
                                <i class="el-icon-question" slot="reference"></i>
                            </el-popover>
                        </template>

                        <tree-select v-model="contentSection"
                                     :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                                     :options="treeList" :style="{width:'100%'}"
                                     placeholder="请选择文章栏目">
                        </tree-select>
                    </el-form-item>
                </div>
                <div class="class-17" >
                    <el-form-item>
                        <template slot='label'>指定时间
                            <el-popover slot="label" placement="top-start" title="提示" width="200" trigger="hover" content="根据内容的发布时间来生成，例如：2020-10-10，则生成10月10号以后发布的内容">
                                <i class="el-icon-question" slot="reference"></i>
                            </el-popover>
                        </template>
                        <el-date-picker
                                v-model="time"
                                placeholder="请选择指定时间"
                                start-placeholder=""
                                end-placeholder=""
                                :readonly="false"
                                :disabled="false"
                                :editable="false"
                                :clearable="false"
                                format="yyyy-MM-dd"
                                value-format="yyyy-MM-dd"
                                :style="{width:'100%'}"
                                type="date">
                        </el-date-picker>
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
            <div class="class-23" >
                <div class="class-24" >
                    <el-form-item>

                        <template slot='label'>生成栏目
                            <el-popover slot="label" placement="top-start" title="提示" width="200" trigger="hover" content="生成栏目属性为列表、封面的内容数据，例如：关于我们、公司介绍、新闻列表、产品列表">
                                <i class="el-icon-question" slot="reference"></i>
                            </el-popover>
                        </template>

                        <tree-select v-model="section"
                                     :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                                     :options="treeList" :style="{width:'100%'}"
                                     placeholder="请选择文章栏目">
                        </tree-select>
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
        data: {
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
        },
        methods: {
            //更新主页
            updataIndex: function () {
                var that = this;
                if (!that.position || that.position == '') {
                    this.$notify({
                        title: '请输入主页位置！',
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
                            title: '更新成功！',
                            type: 'success'
                        });
                    } else {
                        that.$notify({
                            title: '更新失败！',
                            message: "错误",
                            type: 'error'
                        });
                    }
                }).catch(function (err) {
                    that.$notify({
                        title: '更新失败！',
                        message: err,
                        type: 'error'
                    });
                    console.log(err);
                }).finally(function () {
                    that.homeLoading = false;
                });
            },
            //预览主页
            viewIndex: function () {
                if (!this.position || this.position == '') {
                    this.$notify({
                        title: '请输入主页位置！',
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
                ms.http.get(ms.manager + '/cms/generate/' + (that.section ? that.section : 0) + '/genernateColumn.do').then(function (data) {
                    if (data.result) {
                        that.$notify({
                            title: '更新成功！',
                            type: 'success'
                        });
                    }else {
                        that.$notify({
                            title: '生成失败',
                            message:data.msg,
                            type: 'error'
                        });
                    }
                }).catch(function (err) {
                    that.$notify({
                        title: '更新失败！',
                        message: err,
                        type: 'error'
                    });
                    console.log(err);
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
                            title: '更新成功！',
                            type: 'success'
                        });
                    }else {
                        that.$notify({
                            title: '生成失败！',
                            message:data.msg,
                            type: 'error'
                        });
                    }
                }).catch(function (err) {
                    that.$notify({
                        title: '更新失败！',
                        message: err,
                        type: 'error'
                    });
                    console.log(err);
                }).finally(function () {
                    that.articleLoading = false;
                });
            },
            //获取主题模板数据源
            templateOptionsGet: function () {
                var that = this;
                ms.http.get(ms.manager + '/template/queryTemplateFileForColumn.do', {
                    pageSize: 99999
                }).then(function (data) {
                    that.templateOptions = data.data; //寻找主页

                    var template = that.templateOptions.find(function (x) {
                        return x.indexOf("index") != -1 || x.indexOf("default") != -1;
                    }); //没有就找其他的

                    that.template = template || (that.templateOptions.length > 0 ? that.templateOptions[0] : "");
                }).catch(function (err) {
                    console.log(err);
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
                }).catch(function (err) {
                    console.log(err);
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
        height:200px;
        max-width:100%;
        background-color:#FFFFFF;
        flex-direction:column;
        display:flex;
        justify-content:end;
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
        height:200px;
        max-width:100%;
        background-color:#FFFFFF;
        flex-direction:column;
        display:flex;
        justify-content:end;
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
        height:200px;
        max-width:100%;
        background-color:#FFFFFF;
        flex-direction:column;
        display:flex;
        justify-content:end;
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
