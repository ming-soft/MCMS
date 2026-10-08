<!DOCTYPE html>
<html>
<head>
    <title>分类</title>
    <#include "../../include/head-file.ftl">
    <script src="${base}/static/plugins/clipboard/clipboard.js"></script>
</head>
<body>
<div id="index" class="ms-index" v-cloak>
    <el-header class="ms-header" height="50px">
        <el-col :span=12>
            <@shiro.hasPermission name="cms:category:save">
                <el-button type="primary" class="el-icon-plus" size="default" @click="save()">新增</el-button>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="cms:category:del">
                <el-button type="danger" class="el-icon-delete" size="default" @click="del(selectionList)"
                           :disabled="!selectionList.length">删除
                </el-button>
            </@shiro.hasPermission>
        </el-col>
    </el-header>
    <el-main class="ms-container">
        <el-table ref="multipleTable" :indent="6"
                  height="calc(100vh - 100px)"
                  border :data="dataList"
                  row-key="id"
                  v-loading="loading"
                  :default-expand-all=true
                  :tree-props="{children: 'children'}"
                  :default-sort="tableDefaultSort"
                  tooltip-effect="dark"
                  @sort-change="handleSortChange"
                  @selection-change="handleSelectionChange">
            <template #empty>
                {{emptyText}}
            </template>
            <el-table-column type="selection" width="40"></el-table-column>
            <el-table-column label="编号" width="100" prop="id" show-overflow-tooltip>
                <template #title>编号
                    <el-popover placement="top-start" title="提示" trigger="hover">
                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/lan-mu-lie-biao-ms-channel.html"
                              target="_blank">${'$'}{field.id}</a>
                        <template #reference>
                            <i class="el-icon-question" ></i>
                        </template>
                    </el-popover>
                </template>
                <template #default="scope">
                    <span style="cursor: pointer" class="copyBtn" :data-clipboard-text="scope.row.id"
                          @click="copyContent(true)">{{scope.row.id}}</span>
                </template>
            </el-table-column>
            <el-table-column label="标题" align="left" prop="categoryTitle" :show-overflow-tooltip="true">
            </el-table-column>
            <el-table-column label="副标题" align="left" prop="categoryShortTitle" width="120" :show-overflow-tooltip="true">
            </el-table-column>
            <el-table-column label="类型" align="center" prop="categoryType" :formatter="categoryTypeFormat" width="70">
            </el-table-column>
            <el-table-column label="排序" align="center" prop="categorySort" sortable="custom" width="100">
                <template #header>排序
                    <el-popover placement="top-start" title="提示" trigger="hover" >
                        前台模板标签需设置orderby属性为sort才能生效，<a href="https://doc.mingsoft.net/mcms/biao-qian/lan-mu-lie-biao-ms-channel.html#orderby-%E7%A4%BA%E4%BE%8B" target="_blank">参考</a>
                        <template #reference>
                            <i class="el-icon-question"></i>
                        </template>
                    </el-popover>
                </template>
                <template #default="scope">
                    {{scope.row.categorySort?scope.row.categorySort:0}}
                </template>
            </el-table-column>
            <el-table-column label="链接地址" align="left" prop="categoryPath" min-width="200" show-overflow-tooltip>
                <template #default="scope">
                    <a v-if="scope.row.categoryType == '1' || scope.row.categoryType == '2'"
                       :href="scope.row.url" target="_blank" style="color: #409EFF;">{{scope.row.url}}</a>
                    <a v-if="scope.row.categoryType == '3'"
                       :href="scope.row.categoryDiyUrl" target="_blank" style="color: #409EFF;">{{scope.row.categoryDiyUrl}}</a>
                </template>
            </el-table-column>
            <el-table-column label="列表模板" align="left" prop="categoryListUrl" width="100" show-overflow-tooltip>
            </el-table-column>
            <el-table-column label="内容模板" align="left" prop="categoryUrl" width="100" show-overflow-tooltip>
                <template #default="scope">
                    {{scope.row.categoryType == '1'?scope.row.categoryUrl:''}}
                    {{scope.row.categoryType == '2'?scope.row.categoryUrl:''}}
                </template>
            </el-table-column>
            <el-table-column label="栏目属性" align="left" prop="categoryFlag" width="82" show-overflow-tooltip>
                <template #default="scope">
                    {{getDictLabel(scope.row.categoryFlag)}}
                </template>
            </el-table-column>
            <el-table-column label="操作" width="240" align="center">
                <template #default="scope">
                    <el-link type="primary" :underline="false" v-if="scope.row.categoryType != '3'" @click="preview(scope.row)">预览</el-link>
                    <@shiro.hasPermission name="cms:category:save">
                        <el-link type="primary" :underline="false" @click="save(scope.row.id, scope.row.id)"><i
                                    class="el-icon-plus"></i>子栏目
                        </el-link>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="cms:category:save">
                        <el-link type="primary" :underline="false" @click="copyCategory(scope.row.id)">克隆</el-link>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="cms:category:update">
                        <el-link type="primary" :underline="false" @click="save(scope.row.id)">编辑</el-link>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="cms:category:del">
                        <el-link type="primary" :underline="false" @click="del([scope.row])">删除</el-link>
                    </@shiro.hasPermission>
                </template>
            </el-table-column>
        </el-table>
    </el-main>
</div>
</body>

</html>
<script>
    "use strict";

    var indexVue = new _Vue({
        el: '#index',
        data: function () {
            return {
                //分类列表
                dataList: [],
                //未排序的原始树，用于取消排序时还原
                originDataList: [],
                //分类列表选中
                selectionList: [],
                //加载状态
                loading: true,
                //提示文字
                emptyText: '',
                //排序偏好：ascending / descending，空表示不排序
                sortOrder: '',
                categorySortStorageKey: 'cms-category-sort-order',
                categoryFlagOptions: [],
                manager: ms.manager,
                loadState: false,
                categoryTypeOptions: [{
                    "value": "1",
                    "label": "列表"
                }, {
                    "value": "2",
                    "label": "单篇"
                }, {
                    "value": "3",
                    "label": "链接"
                }],
                //搜索表单
                form: {
                    // 栏目管理名称
                    categoryTitle: '',
                    // 栏目管理名称
                    categoryShortTitle: '',
                    // 所属栏目
                    categoryId: '',
                    // 栏目管理属性
                    categoryType: '2',
                    // 自定义顺序
                    categorySort: 0,
                    // 列表模板
                    categoryListUrl: '',
                    // 内容模板
                    categoryUrl: '',
                    // 栏目管理关键字
                    categoryKeyword: '',
                    // 栏目管理描述
                    categoryDescrip: '',
                    // 缩略图
                    categoryImg: [],
                    // 自定义链接
                    categoryDiyUrl: '',
                    // 栏目管理的内容模型id
                    mdiyModelId: ''
                }
            }
        },
        computed: {
            tableDefaultSort: function () {
                if (this.sortOrder === 'ascending' || this.sortOrder === 'descending') {
                    return {prop: 'categorySort', order: this.sortOrder};
                }
                return undefined;
            }
        },
        methods: {
            //复制栏目
            copyCategory: function (id) {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/copyCategory.do", {
                    id: id
                }).then(function (res) {
                    if (res.result) {
                        that.$notify({
                            title: '成功',
                            message: '复制成功',
                            type: 'success'
                        });
                        that.list();
                    } else {
                        that.$notify({
                            title: '失败',
                            message: res.msg,
                            type: 'warning'
                        });
                    }
                });
            },
            //应用子栏目模板
            updateTemplate: function (id) {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/updateTemplate.do", {
                    id: id
                }).then(function (res) {
                    if (res.result) {
                        that.$notify({
                            title: '成功',
                            message: '应用成功',
                            type: 'success'
                        });
                        that.list();
                    } else {
                        that.$notify({
                            title: '失败',
                            message: res.msg,
                            type: 'warning'
                        });
                    }
                });
            },
            //根据字典数据值获取字典标签名
            getDictLabel: function (v) {
                var that = this;
                var labels = [];
                if (v) {
                    v.split(",").forEach(function (item) {
                        for (var key in that.categoryFlagOptions) {
                            if (item == that.categoryFlagOptions[key].dictValue) {
                                labels.push(that.categoryFlagOptions[key].dictLabel);
                                break;
                            }
                        }
                    });
                }
                return labels.toString();
            },
            //按排序字段整理树，每一级栏目都参与排序，空值按 0
            sortTree: function (list, order) {
                if (!list || !list.length) {
                    return list || [];
                }
                var desc = order !== 'ascending';
                list.sort(function (a, b) {
                    var sa = Number(a.categorySort || 0);
                    var sb = Number(b.categorySort || 0);
                    return desc ? (sb - sa) : (sa - sb);
                });
                for (var i = 0; i < list.length; i++) {
                    if (list[i].children && list[i].children.length) {
                        this.sortTree(list[i].children, order);
                    }
                }
                return list;
            },
            //根据本地偏好排序；无偏好时保持接口原顺序
            applySortPreference: function () {
                var list = JSON.parse(JSON.stringify(this.originDataList || []));
                if (this.sortOrder === 'ascending' || this.sortOrder === 'descending') {
                    this.dataList = this.sortTree(list, this.sortOrder);
                } else {
                    this.dataList = list;
                }
            },
            //点击排序列：保存偏好，并同步调整各级栏目顺序；取消排序则还原
            handleSortChange: function (column) {
                if (column.prop !== 'categorySort') {
                    return;
                }
                if (column.order === 'ascending' || column.order === 'descending') {
                    this.sortOrder = column.order;
                } else {
                    this.sortOrder = '';
                }
                try {
                    if (this.sortOrder) {
                        localStorage.setItem(this.categorySortStorageKey, this.sortOrder);
                    } else {
                        localStorage.removeItem(this.categorySortStorageKey);
                    }
                } catch (e) {
                    console.log(e)
                }
                // 数据未就绪时只记偏好，等 list 返回后再应用
                if (!this.originDataList.length) {
                    return;
                }
                this.applySortPreference();
            },
            //查询列表
            list: function () {
                var that = this;
                this.loadState = false;
                this.loading = true;
                ms.http.get(ms.manager + "/cms/category/list.do").then(function (res) {
                    if (that.loadState) {
                        that.loading = false;
                    } else {
                        that.loadState = true;
                    }

                    if (!res.result || res.data.total <= 0) {
                        that.emptyText = '暂无数据';
                        that.originDataList = [];
                        that.dataList = [];
                    } else {
                        that.emptyText = '';
                        that.originDataList = ms.util.treeData(res.data.rows, 'id', 'categoryId', 'children');
                        that.applySortPreference();
                    }
                });
                setTimeout(function () {
                    if (that.loadState) {
                        that.loading = false;
                    } else {
                        that.loadState = true;
                    }
                }, 500);
            },
            copyContent: function (id) {
                var msg = "链接地址已保存到剪切板";
                if (id == true) {
                    msg = "编号已保存到剪切板";
                }
                var clipboard = new ClipboardJS('.copyBtn');
                var self = this;
                clipboard.on('success', function (e) {
                    self.$notify({
                        title: '提示',
                        message: msg,
                        type: 'success'
                    });
                    clipboard.destroy();
                });
            },
            //分类列表选中
            handleSelectionChange: function (val) {
                this.selectionList = val;
            },
            //删除
            del: function (row) {
                var that = this;
                that.$confirm('此操作将永久删除分类和分类下的文章, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    ms.http.post(ms.manager + "/cms/category/delete.do", row.length ? row : [row], {
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    }).then(function (res) {
                        if (res.result) {
                            that.$notify({
                                title: '成功 ',
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
                })
            },
            //预览栏目
            preview: function (row) {
                window.open(row["url"]);
            },
            //获取categoryFlag数据源
            categoryFlagOptionsGet: function () {
                var that = this;
                ms.http.get(ms.base + '/mdiy/dict/list.do', {
                    dictType: '栏目属性',
                    pageSize: 99999
                }).then(function (res) {
                    if (res.result) {
                        res = res.data;
                        that.categoryFlagOptions = res.rows;
                    }
                });
            },
            //表格数据转换
            categoryTypeFormat: function (row, column, cellValue, index) {
                var value = "";

                if (cellValue) {
                    var data = this.categoryTypeOptions.find(function (value) {
                        return value.value == cellValue;
                    });

                    if (data && data.label) {
                        value = data.label;
                    }
                }

                return value;
            },
            //新增
            save: function (id, childId) {
                if (id) {
                    // location.href = this.manager + "/cms/category/form.do?id=" + id + "&childId=" + childId;
                    ms.util.openSystemUrl("/cms/category/form.do?id=" + id + "&childId=" + childId);
                } else {
                    // location.href = this.manager + "/cms/category/form.do";
                    ms.util.openSystemUrl("/cms/category/form.do");
                }
            },
            //重置表单
            rest: function () {
                this.$refs.searchForm.resetFields();
            }
        },
        created: function () {
            /* this.categoryListUrlOptionsGet();
             this.categoryUrlOptionsGet();*/
            try {
                var order = localStorage.getItem(this.categorySortStorageKey) || '';
                this.sortOrder = (order === 'ascending' || order === 'descending') ? order : '';
            } catch (e) {
                console.log(e)
                this.sortOrder = '';
            }
            this.categoryFlagOptionsGet();
            this.list();
        }
    });
</script>
