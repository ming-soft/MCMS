<!DOCTYPE html>
<html>
<head>
    <title>分类</title>
    <#include "../../include/head-file.ftl">
</head>
<body>
<div id="form" v-cloak>
    <el-header class="ms-header ms-tr" height="50px">
        <el-button type="primary" icon="iconfont icon-baocun" size="mini" @click="save()" :loading="saveDisabled">保存
        </el-button>
        <el-button size="mini" icon="iconfont icon-fanhui" plain onclick="javascript:history.go(-1)">返回</el-button>
    </el-header>
    <el-main class="ms-container">
        <el-scrollbar class="ms-scrollbar" style="height: 100%;">
            <el-form ref="form" :model="form" :rules="rules" label-width="130px" size="mini">
                <el-row
                        gutter="0"
                        justify="start" align="top">
                    <el-col span="12">
                        <el-form-item label="栏目管理名称" prop="categoryTitle">
                            <template slot='label'>栏目管理名称
                                <el-popover slot="label" placement="top-start" title="提示" trigger="hover">
                                    <a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/nei-rong-biao-qian-ms-field.html"
                                       target="_blank">{ms:field.typetitle/}</a>
                                    <a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/lan-mu-lie-biao-ms-channel.html"
                                       target="_blank">[field.typetitle/]</a>
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <el-input v-model="form.categoryTitle"
                                      :disabled="false"
                                      :style="{width:  '100%'}"
                                      :clearable="true"
                                      placeholder="请输入栏目管理名称">
                            </el-input>
                        </el-form-item>
                    </el-col>
                    <el-col span="12">
                        <el-form-item label="所属栏目" prop="categoryId">
                            <tree-select ref="tree" :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                                         :options="treeList" :style="{width:'100%'}"
                                         v-model="form.categoryId"></tree-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row
                        gutter="0"
                        justify="start" align="top">
                    <el-col span="12">
                        <el-form-item prop="categoryType">
                            <template slot='label'>栏目类型
                                <el-popover slot="label" placement="top-start" title="提示" trigger="hover">
                                    列表：常用于带列表、详情的业务，例如：新闻列表、图片列表<br>封面：常用单篇文章显示，例如：关于我们、公司介绍<br>修改栏目时如果该栏目存在文章则不能修改栏目类型
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <el-radio-group v-model="form.categoryType"
                                            :style="{width: ''}"
                                            :disabled="categoryTypeDisabled">
                                <el-radio :style="{display: true ? 'inline-block' : 'block'}" :label="item.value"
                                          v-for='(item, index) in categoryTypeOptions' :key="item.value + index">
                                    {{true? item.label : item.value}}
                                </el-radio>
                            </el-radio-group>
                        </el-form-item>
                    </el-col>
                    <el-col span="12">
                        <el-form-item label="自定义顺序" prop="categorySort">
                            <el-input-number
                                    v-model="form.categorySort"
                                    :disabled="false"
                                    controls-position="">
                            </el-input-number>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row
                        gutter="0"
                        justify="start" align="top">
                    <el-col span="12">
                        <el-form-item prop="categoryUrl" :label="form.categoryType =='1'? '内容模板' : '封面模板'">
                            <el-select v-model="form.categoryUrl"
                                       :style="{width: '100%'}"
                                       :filterable="true"
                                       :disabled="false"
                                       :multiple="false" :clearable="true"
                                       placeholder="请选择内容模板">
                                <el-option v-for='item in categoryUrlOptions' :key="item" :value="item"
                                           :label="item"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col span="12">
                        <el-form-item prop="mdiyModelId">
                            <template slot='label'>自定义模型
                                <el-popover slot="label" placement="top-start" title="提示" width="400" trigger="hover"
                                            content="如果发布时候文章字段信息不够，可以采用铭飞代码生成器生成自定义模型，再通过“自定义管理->自定义模型->导入”功能导入模型，注意类型是cms">
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <el-select v-model="form.mdiyModelId"
                                       :style="{width: '100%'}"
                                       :filterable="false"
                                       :disabled="false"
                                       :multiple="false" :clearable="true"
                                       placeholder="请选择栏目的自定义模型">
                                <el-option v-for='item in mdiyModelIdOptions' :key="item.id" :value="item.id"
                                           :label="item.modelName"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row gutter="0" justify="start" align="top">
                    <el-col span="12">
                        <el-form-item prop="categoryListUrl" v-if="form.categoryType == '1'">
                            <template slot='label'>列表模板
                                <el-popover slot="label" placement="top-start" title="提示" trigger="hover"
                                            content="当栏目类型为列表时有效">
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <el-select v-model="form.categoryListUrl"
                                       :style="{width: '100%'}"
                                       :filterable="true"
                                       :disabled="false"
                                       :multiple="false" :clearable="true"
                                       placeholder="请选择列表模板">
                                <el-option v-for='item in categoryListUrlOptions' :key="item" :value="item"
                                           :label="item"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col span="12">
                        <el-form-item  label="栏目属性" prop="categoryFlag">
                            <template slot='label'>栏目属性
                                <el-popover placement="top-start" title="提示" trigger="hover" content="类型不满足可以在自定义字典菜单中新增,字段类型为“栏目属性”">
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <el-select v-model="form.categoryFlag"
                                       :style="{width: '100%'}"
                                       :filterable="false"
                                       :disabled="false"
                                       :multiple="true" :clearable="true"
                                       placeholder="请选择栏目属性">
                                <el-option v-for='item in categoryFlagOptions' :key="item.dictValue" :value="item.dictValue"
                                           :label="item.dictLabel"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-form-item label="栏目管理关键字" prop="categoryKeyword">
                    <template slot='label'>栏目关键字
                        <el-popover slot="label" placement="top-start" title="提示" trigger="hover">
                            <a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/lan-mu-lie-biao-ms-channel.html"
                               target="_blank">[field.typekeyword/]</a>
                            <i class="el-icon-question" slot="reference"></i>
                        </el-popover>
                    </template>
                    <el-input
                            type="textarea" :rows="5"
                            :disabled="false"
                            v-model="form.categoryKeyword"
                            :style="{width: '100%'}"
                            placeholder="栏目管理关键字，有助于搜索">
                    </el-input>
                </el-form-item>
                <el-form-item label="栏目管理描述" prop="categoryDescrip">
                    <template slot='label'>栏目描述
                        <el-popover slot="label" placement="top-start" title="提示" trigger="hover">
                            <a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/lan-mu-lie-biao-ms-channel.html"
                               target="_blank">[field.typedescrip/]</a>
                            <i class="el-icon-question" slot="reference"></i>
                        </el-popover>
                    </template>
                    <el-input
                            type="textarea" :rows="5"
                            :disabled="false"
                            v-model="form.categoryDescrip"
                            :style="{width: '100%'}"
                            placeholder="栏目管理描述，对栏目管理关键字的扩展">
                    </el-input>
                </el-form-item>
                <el-form-item label="" prop="categoryImg">
                    <template slot='label'>缩略图
                        <el-popover slot="label" placement="top-start" title="提示"  trigger="hover">
                            <a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/nei-rong-biao-qian-ms-field.html"
                               target="_blank">{ms:field.typelitpic/}</a>
                            <a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/lan-mu-lie-biao-ms-channel.html"
                               target="_blank">[field.typelitpic/]</a>
                            <i class="el-icon-question" slot="reference"></i>
                        </el-popover>
                    </template>
                    <el-upload
                            :file-list="form.categoryImg"
                            :action="ms.base+'/file/upload.do'"
                            :on-remove="categoryImghandleRemove"
                            :style="{width:''}"
                            :limit="1"
                            :on-exceed="categoryImghandleExceed"
                            :disabled="false"
                            :data="{uploadPath:'/${appId}/cms/category','isRename':true}"
                            :on-success="categoryImgSuccess"
                            accept="image/*"
                            list-type="picture-card">
                        <i class="el-icon-plus"></i>
                        <div slot="tip" class="el-upload__tip">最多上传1张图片</div>
                    </el-upload>
                </el-form-item>
                <el-form-item prop="categoryDiyUrl">
                    <template slot='label'>自定义链接
                        <el-popover slot="label" placement="top-start" title="提示" trigger="hover">
                            <a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/lan-mu-lie-biao-ms-channel.html"
                               target="_blank">[field.typeurl/]</a>
                            <i class="el-icon-question" slot="reference"></i>
                        </el-popover>
                    </template>
                    <el-input
                            :disabled="false"
                            v-model="form.categoryDiyUrl"
                            :style="{width: '100%'}"
                            placeholder="请输入自定义链接">
                    </el-input>
                </el-form-item>
            </el-form>
        </el-scrollbar>
    </el-main>
</div>
</body>
</html>
<script>
    var form = new Vue({
        el: '#form',
        data: function () {
            return {
                treeList: [{
                    id: '0',
                    categoryTitle: '顶级栏目',
                    children: []
                }],
                categoryList: [],
                saveDisabled: false,
                categoryTypeDisabled: true,
                //表单数据
                form: {
                    // 栏目管理名称
                    categoryTitle: '',
                    // 所属栏目
                    categoryId: '',
                    // 栏目管理属性
                    categoryType: '1',
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
                    mdiyModelId: '',
                    //栏目字典
                    categoryFlag: []
                },
                categoryTypeOptions: [{
                    "value": "1",
                    "label": "列表"
                }, {
                    "value": "2",
                    "label": "封面"
                }],
                categoryListUrlOptions: [],
                categoryUrlOptions: [],
                mdiyModelIdOptions: [],
                categoryFlagOptions: [],
                rules: {
                    // 栏目管理名称
                    categoryTitle: [{
                        "required": true,
                        "message": "请选择栏目管理名称"
                    }, {
                        "pattern": /^[^[!@#$%^&*()_+-/~?！@#￥%…&*（）——+—？》《：“‘’]+$/,
                        "message": "栏目管理名称格式不匹配"
                    }],
                    categoryListUrl: [{
                        "required": true,
                        "message": "请选择列表模板"
                    }],
                    // 内容模板
                    categoryUrl: [{
                        "required": true,
                        "message": "请选择内容模板"
                    }]
                }
            };
        },
        watch: {
            'form.categoryId': function (n, o) {
                var _this = this;

                if (n == this.form.id) {
                    this.$notify({
                        title: '提示',
                        message: '所属栏目不能为自身',
                        type: 'error'
                    });
                    return;
                }

                this.categoryList.forEach(function (item) {
                    if (item.categoryParentId != null && item.categoryParentId != "" && item.categoryParentId.indexOf(_this.form.id) != -1) {
                        if (item.id == n) {
                            _this.form.categoryId = null;

                            _this.$refs.tree.clearHandle();

                            _this.$notify({
                                title: '提示',
                                message: '不能选择子分类',
                                type: 'warning'
                            });
                        }
                    }
                });
            }
        },
        computed: {},
        methods: {
            getTree: function () {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/list.do", {
                    pageSize: 9999
                }).then(function (res) {
                    if (res.result) {
                        //res.data.rows.push({id:0,categoryId: null,categoryTitle:'顶级栏目管理'});
                        that.categoryList = res.data.rows;
                        that.treeList[0].children = ms.util.treeData(res.data.rows, 'id', 'categoryId', 'children');
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            save: function () {
                var that = this;
                var url = ms.manager + "/cms/category/save.do";

                if (that.form.id > 0) {
                    url = ms.manager + "/cms/category/update.do";
                }

                this.$refs.form.validate(function (valid) {
                    if (valid) {
                        //栏目属性为封面则不需要列表模板
                        if (that.form.categoryType == '2') {
                            that.form.categoryListUrl = '';
                        }

                        that.saveDisabled = true;
                        var data = JSON.parse(JSON.stringify(that.form));

                        if (data.id && data.id == data.categoryId) {
                            that.$notify({
                                title: '提示',
                                message: '所属栏目不能为自身',
                                type: 'error'
                            });
                            that.saveDisabled = false;
                            return;
                        }

                        if (data.categoryId == '0') {
                            data.categoryId = '';
                        }

                        if (data.categoryFlag) {
                            data.categoryFlag = data.categoryFlag.join(',');
                        }

                        data.categoryImg = JSON.stringify(data.categoryImg);
                        ms.http.post(url, data).then(function (data) {
                            if (data.result) {
                                that.$notify({
                                    title: '成功',
                                    message: '保存成功',
                                    type: 'success'
                                });
                                location.href = ms.manager + "/cms/category/index.do";
                            } else {
                                that.$notify({
                                    title: '失败',
                                    message: data.msg,
                                    type: 'warning'
                                });
                            }

                            that.saveDisabled = false;
                        });
                    } else {
                        return false;
                    }
                });
            },
            //获取分类内容模型
            getColumnContentModelId: function () {
                var that = this;
                ms.http.get(ms.manager + "/mdiy/model/list.do", {
                    modelType: 'zdymx_wz'
                }).then(function (data) {
                    that.mdiyModelIdOptions = data.data.rows;
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取当前分类
            get: function (id) {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/get.do", {
                    "id": id
                }).then(function (res) {
                    if (res.result && res.data) {
                        if (res.data.categoryFlag) {
                            res.data.categoryFlag = res.data.categoryFlag.split(',');
                        }

                        if (res.data.categoryImg) {
                            res.data.categoryImg = JSON.parse(res.data.categoryImg);
                            res.data.categoryImg.forEach(function (value) {
                                value.url = ms.base + value.path;
                            });
                        } else {
                            res.data.categoryImg = [];
                        }

                        if (!res.data.categoryId) {
                            res.data.categoryId = '0';
                        }

                        that.form = res.data; //判断该分类是否存在文章，存在则不能修改栏目属性

                        that.contentList(that.form.id);
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            contentList: function (id) {
                var that = this;
                ms.http.post(ms.manager + "/cms/content/list.do", {
                    contentCategoryId: id
                }).then(function (data) {
                    if (data.data.total > 0) {
                        that.categoryTypeDisabled = true;
                    } else {
                        that.categoryTypeDisabled = false;
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取categoryListUrl数据源
            categoryListUrlOptionsGet: function () {
                var that = this;
                ms.http.get(ms.manager + "/template/queryTemplateFileForColumn.do", {}).then(function (data) {
                    that.categoryListUrlOptions = data.data;
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取categoryUrl数据源
            categoryUrlOptionsGet: function () {
                var that = this;
                ms.http.get(ms.manager + "/template/queryTemplateFileForColumn.do", {}).then(function (data) {
                    that.categoryUrlOptions = data.data;
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取categoryFlag数据源
            categoryFlagOptionsGet: function () {
                var that = this;
                ms.http.get(ms.base + '/mdiy/dict/list.do', {
                    dictType: '栏目属性',
                    pageSize: 99999
                }).then(function (res) {
                    that.categoryFlagOptions = res.rows;
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //categoryImg文件上传完成回调
            categoryImgSuccess: function (response, file, fileList) {
                this.form.categoryImg.push({
                    url: file.url,
                    name: file.name,
                    path: response,
                    uid: file.uid
                });
            },
            //上传超过限制
            categoryImghandleExceed: function (files, fileList) {
                this.$notify({
                    title: '当前最多上传1个文件',
                    type: 'warning'
                });
            },
            categoryImghandleRemove: function (file, files) {
                var index = -1;
                index = this.form.categoryImg.findIndex(function (text) {
                    return text == file;
                });

                if (index != -1) {
                    this.form.categoryImg.splice(index, 1);
                }
            }
        },
        created: function () {
            this.getColumnContentModelId();
            this.getTree();
            this.categoryListUrlOptionsGet();
            this.categoryUrlOptionsGet();
            this.categoryFlagOptionsGet();
            this.form.id = ms.util.getParameter("id");

            if (this.form.id) {
                this.get(this.form.id);
            } else {
                this.categoryTypeDisabled = false;
            }
        }
    });
</script>
<style>
    .el-select {
        width: 100%;
    }
</style>
