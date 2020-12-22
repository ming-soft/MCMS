<!DOCTYPE html>
<html>
<head>
    <title>文章主体</title>
    <#include "../../include/head-file.ftl">

</head>
<body>
<div id="main" class="ms-index" v-cloak>
    <ms-search ref="search" @search="search" :condition-data="conditionList" :conditions="conditions"></ms-search>
    <el-header class="ms-header" height="50px">
        <el-col :span="12">
            <@shiro.hasPermission name="cms:content:save">
                <el-button type="primary" icon="el-icon-plus" size="mini" @click="save()">新增</el-button>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="cms:content:del">
                <el-button type="danger" icon="el-icon-delete" size="mini" @click="del(selectionList)"  :disabled="!selectionList.length">删除</el-button>
            </@shiro.hasPermission>
        </el-col>
    </el-header>
    <div class="ms-search">
        <el-row>
            <el-form :model="form"  ref="searchForm"  label-width="120px" size="mini">
                <el-row>
                    <el-col :span="8">
                        <el-form-item  label="文章标题" prop="contentTitle">
                            <el-input v-model="form.contentTitle"
                                      :disabled="false"
                                      :style="{width:  '100%'}"
                                      :clearable="true"
                                      placeholder="请输入文章标题">
                            </el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item  label="文章类型" prop="contentType">
                            <el-select v-model="form.contentType"
                                       :style="{width: '100%'}"
                                       :filterable="false"
                                       :disabled="false"
                                       :multiple="true" :clearable="true"
                                       placeholder="请选择文章类型">
                                <el-option v-for='item in contentTypeOptions' :key="item.dictValue" :value="item.dictValue"
                                           :label="item.dictLabel"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8" style="text-align: right;padding-right: 10px;">
                        <el-button type="primary" icon="el-icon-search" size="mini" @click="form.sqlWhere=null;currentPage=1;list()">查询</el-button>
                        <el-button @click="rest"  icon="el-icon-refresh" size="mini">重置</el-button>
                        <el-button type="primary" size="mini" @click="$refs.search.open()"><i class="iconfont icon-shaixuan"></i>筛选</el-button>
                    </el-col>
                </el-row>
            </el-form>
        </el-row>
    </div>
    <el-main class="ms-container">
        <el-table height="calc(100vh - 68px)" v-loading="loading" ref="multipleTable" border :data="dataList" tooltip-effect="dark" @selection-change="handleSelectionChange">
            <template slot="empty">
                {{emptyText}}
            </template>
            <el-table-column type="selection" width="40"></el-table-column>
            <el-table-column label="编号" width="200" prop="id">
                <template slot='header'>编号
                    <el-popover placement="top-start" title="提示" trigger="hover" >
                        <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.id}</a>
                        <i class="el-icon-question" slot="reference"></i>
                    </el-popover>
                </template>
            </el-table-column>
            <el-table-column label="栏目名" align="left" prop="categoryId" :formatter="contentCategoryIdFormat" width="180">
            </el-table-column>
            <el-table-column label="文章标题" align="left" prop="contentTitle" show-overflow-tooltip>
            </el-table-column>
            <el-table-column label="作者" align="left" prop="contentAuthor" width="100" show-overflow-tooltip>
            </el-table-column>
            <el-table-column label="排序" width="55" align="right" prop="contentSort">
            </el-table-column>
            <el-table-column label="点击量" width="90" align="right" prop="contentHit">
                <template slot='header'>点击量
                    <el-popover placement="top-start" title="提示" trigger="hover" >
                        <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.hit}</a>
                        <i class="el-icon-question" slot="reference"></i>
                    </el-popover>
                </template>
                <template slot-scope="scope">
                    {{scope.row.contentHit?scope.row.contentHit:0}}
                </template>
            </el-table-column>
            <el-table-column label="发布时间" align="center" prop="contentDatetime" :formatter="dateFormat" width="120">
            </el-table-column>
            <el-table-column label="操作" width="120" align="center">
                <template slot-scope="scope">
                    <@shiro.hasPermission name="cms:content:update">
                        <el-link type="primary" :underline="false" @click="save(scope.row.id)">编辑</el-link>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="cms:content:del">
                        <el-link type="primary" :underline="false" @click="del([scope.row])">删除</el-link>
                    </@shiro.hasPermission>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
                background
                :page-sizes="[10,20,30,40,50,100]"
                layout="total, sizes, prev, pager, next, jumper"
                :current-page="currentPage"
                :page-size="pageSize"
                :total="total"
                class="ms-pagination"
                @current-change='currentChange'
                @size-change="sizeChange">
        </el-pagination>
    </el-main>
</div>
</body>

</html>
<script>
    var indexVue = new Vue({
        el: '#main',
        data: {
            conditionList: [{
                action: 'and',
                field: 'content_title',
                el: 'eq',
                model: 'contentTitle',
                name: '文章标题',
                type: 'input'
            }, {
                action: 'and',
                field: 'category_id',
                el: 'eq',
                model: 'categoryId',
                name: '所属栏目',
                key: 'id',
                title: 'categoryTitle',
                type: 'cascader',
                multiple: false
            }, {
                action: 'and',
                field: 'content_type',
                el: 'eq',
                model: 'contentType',
                name: '文章类型',
                key: 'dictValue',
                title: 'dictLabel',
                type: 'checkbox',
                label: false,
                multiple: true
            }, {
                action: 'and',
                field: 'content_display',
                el: 'eq',
                model: 'contentDisplay',
                name: '是否显示',
                type: 'radio',
                label: true,
                multiple: false
            }, {
                action: 'and',
                field: 'content_author',
                el: 'eq',
                model: 'contentAuthor',
                name: '文章作者',
                type: 'input'
            }, {
                action: 'and',
                field: 'content_source',
                el: 'eq',
                model: 'contentSource',
                name: '文章来源',
                type: 'input'
            }, {
                action: 'and',
                field: 'content_datetime',
                model: 'contentDatetime',
                el: 'gt',
                name: '发布时间',
                type: 'date'
            }, {
                action: 'and',
                field: 'content_sort',
                el: 'eq',
                model: 'contentSort',
                name: '自定义顺序',
                type: 'number'
            }, {
                action: 'and',
                field: 'content_description',
                el: 'eq',
                model: 'contentDescription',
                name: '描述',
                type: 'textarea'
            }, {
                action: 'and',
                field: 'content_keyword',
                el: 'eq',
                model: 'contentKeyword',
                name: '关键字',
                type: 'textarea'
            }, {
                action: 'and',
                field: 'content_details',
                el: 'like',
                model: 'contentDetails',
                name: '文章内容',
                type: 'input'
            }, {
                action: 'and',
                field: 'content_url',
                el: 'eq',
                model: 'contentUrl',
                name: '文章跳转链接地址',
                type: 'input'
            }, {
                action: 'and',
                field: 'appid',
                el: 'eq',
                model: 'appid',
                name: '文章管理的应用id',
                type: 'number'
            }, {
                action: 'and',
                field: 'create_date',
                el: 'eq',
                model: 'createDate',
                name: '创建时间',
                type: 'date'
            }, {
                action: 'and',
                field: 'update_date',
                el: 'eq',
                model: 'updateDate',
                name: '修改时间',
                type: 'date'
            }],
            conditions: [],
            contentCategoryIdOptions: [],
            dataList: [],
            //文章列表
            selectionList: [],
            //文章列表选中
            total: 0,
            //总记录数量
            pageSize: 10,
            //页面数量
            currentPage: 1,
            //初始页
            manager: ms.manager,
            loadState: false,
            loading: true,
            //加载状态
            emptyText: '',
            //提示文字
            contentTypeOptions: [],
            contentDisplayOptions: [{
                "value": "0",
                "label": "是"
            }, {
                "value": "1",
                "label": "否"
            }],
            //搜索表单
            form: {
                sqlWhere: null,
                // 文章标题
                contentTitle: null,
                // 文章类型
                contentType: null,
                categoryId: ''
            }
        },
        methods: {
            //查询列表
            list: function () {
                var that = this;
                that.loading = true;
                that.loadState = false;
                var page = {
                    pageNo: that.currentPage,
                    pageSize: that.pageSize
                };
                var form = JSON.parse(JSON.stringify(that.form));

                if (form.contentType.length > 0) {
                    form.contentType = form.contentType.join(',');
                }

                for (var key in form) {
                    if (!form[key]) {
                        delete form[key];
                    }
                }

                history.replaceState({
                    form: form,
                    page: page
                }, "");
                //筛选栏目类型，1=列表
                that.form.categoryType = '1';
                ms.http.post(ms.manager + "/cms/content/list.do", form.sqlWhere ? Object.assign({}, {
                    categoryType: '1',
                    sqlWhere: form.sqlWhere
                }, page) : Object.assign({}, that.form, page)).then(function (res) {
                    if (that.loadState) {
                        that.loading = false;
                    } else {
                        that.loadState = true;
                    }

                    if (!res.result || res.data.total <= 0) {
                        that.emptyText = '暂无数据';
                        that.dataList = [];
                        that.total = 0;
                    } else {
                        that.emptyText = '';
                        that.total = res.data.total;
                        that.dataList = res.data.rows;
                    }
                }).catch(function (err) {
                    that.loading = false;
                    console.log(err);
                });
                setTimeout(function () {
                    if (that.loadState) {
                        that.loading = false;
                    } else {
                        that.loadState = true;
                    }
                }, 500);
            },
            //文章列表选中
            handleSelectionChange: function (val) {
                this.selectionList = val;
            },
            //删除
            del: function (row) {
                var that = this;
                that.$confirm('此操作将永久删除所选内容, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    ms.http.post(ms.manager + "/cms/content/delete.do", row.length ? row : [row], {
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    }).then(function (res) {
                        if (res.result) {
                            that.$notify({
                                type: 'success',
                                message: '删除成功!'
                            }); //删除成功，刷新列表

                            that.list();
                        } else {
                            that.$notify({
                                title: '失败',
                                message: res.msg,
                                type: 'warning'
                            });
                        }
                    });
                }).catch(function () {
                    that.$notify({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            //新增
            save: function (id) {
                //id有值时编辑
                if (id) {
                    location.href = this.manager + "/cms/content/form.do?id=" + id;
                }else {
                    //根据当前栏目新增时自动选中栏目
                    var categoryId = this.form.categoryId;
                    if (categoryId) {
                        location.href = this.manager + "/cms/content/form.do?categoryId=" + this.form.categoryId;
                    }else {
                        //如果栏目id没有值就单纯的新增，不自动选定栏目
                        location.href = this.manager + "/cms/content/form.do";
                    }
                }
            },
            //表格数据转换
            contentCategoryIdFormat: function (row, column, cellValue, index) {
                var value = "";

                if (cellValue) {
                    var data = this.contentCategoryIdOptions.find(function (value) {
                        return value.id == cellValue;
                    });

                    if (data && data.categoryTitle) {
                        value = data.categoryTitle;
                    }
                }

                return value;
            },
            dateFormat: function (row, column, cellValue, index) {
                if (cellValue) {
                    return ms.util.date.fmt(cellValue, 'yyyy-MM-dd');
                } else {
                    return '';
                }
            },
            contentDisplayFormat: function (row, column, cellValue, index) {
                var value = "";

                if (cellValue) {
                    var data = this.contentDisplayOptions.find(function (value) {
                        return value.value == cellValue;
                    });

                    if (data && data.label) {
                        value = data.label;
                    }
                }

                return value;
            },
            //pageSize改变时会触发
            sizeChange: function (pagesize) {
                this.loading = true;
                this.pageSize = pagesize;
                this.list();
            },
            //currentPage改变时会触发
            currentChange: function (currentPage) {
                this.loading = true;
                this.currentPage = currentPage;
                this.list();
            },
            search: function (data) {
                this.form.sqlWhere = JSON.stringify(data);
                this.list();
            },
            //重置表单
            rest: function () {
                this.form.sqlWhere = null;
                this.$refs.searchForm.resetFields();
                this.list();
            },
            //获取contentCategoryId数据源
            contentCategoryIdOptionsGet: function () {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/list.do", {
                    pageSize: 9999
                }).then(function (res) {
                    if (res.result) {
                        that.contentCategoryIdOptions = res.data.rows;
                    }

                    that.list();
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取contentType数据源
            contentTypeOptionsGet: function () {
                var that = this;
                ms.http.get(ms.base + '/mdiy/dict/list.do', {
                    dictType: '文章属性',
                    pageSize: 99999
                }).then(function (data) {
                    if(data.result){
                        data = data.data;
                        that.contentTypeOptions = data.rows;
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            }
        },
        mounted: function () {
            this.contentCategoryIdOptionsGet();
            this.contentTypeOptionsGet();
            this.form.categoryId = ms.util.getParameter("categoryId");
            if (history.hasOwnProperty("state")) {
                this.form = history.state.form;
                this.currentPage = history.state.page.pageNo;
                this.pageSize = history.state.page.pageSize;
            }
        }
    });
</script>
<style>
    #main .ms-search {
        padding: 20px 0 0;
    }
    #main .ms-container {
        height: calc(100vh - 141px);
    }
    body{
        overflow: hidden;
    }
</style>
