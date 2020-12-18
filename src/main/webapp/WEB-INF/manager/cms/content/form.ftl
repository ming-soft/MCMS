<!DOCTYPE html>
<html>
<head>
    <title>文章</title>
    <#include "../../include/head-file.ftl">
</head>
<body>
<div id="form" v-cloak>
    <el-header class="ms-header ms-tr" height="50px">
        <el-button type="primary" icon="iconfont icon-baocun" size="mini" @click="save()" :loading="saveDisabled">保存
        </el-button>
        <el-button size="mini" icon="iconfont icon-fanhui" plain onclick="javascript:history.go(-1)">返回
        </el-button>
    </el-header>
    <el-main class="ms-container" style="position:relative;">
        <el-scrollbar style="height: 100%;">
            <el-tabs v-model="activeName" style="height: calc(100% - 10px);">
                <el-tab-pane style="position:relative;" v-for="(item, index) in editableTabs" :key="index"
                             :label="item.title" :name="item.name">
                    <el-form v-if="item.title=='文章编辑'" ref="form" :model="form" :rules="rules" label-width="120px"
                             size="mini">
                        <el-row gutter="0" justify="start" align="top">
                            <el-col :span="returnIsShow?'12':'24'">
                                <el-form-item label="文章标题" prop="contentTitle">
                                    <template slot='label'>文章标题
                                        <el-popover placement="top-start" title="提示" trigger="hover">
                                            <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                               target="_blank">${'$'}{field.title}</a>
                                            <i class="el-icon-question" slot="reference"></i>
                                        </el-popover>
                                    </template>
                                    <el-input v-model="form.contentTitle"
                                              :disabled="false"
                                              :style="{width:  '100%'}"
                                              :clearable="true"
                                              placeholder="请输入文章标题">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                            <el-col span="12" v-if="returnIsShow">
                                <el-form-item label="所属栏目" prop="categoryId">
                                    <template slot='label'>所属栏目
                                        <el-popover placement="top-start" title="提示" trigger="hover">
                                            <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                               target="_blank">${'$'}{field.typetitle}</a><br/>
                                            不能为链接和封面类型新建文章
                                            <i class="el-icon-question" slot="reference"></i>
                                        </el-popover>
                                    </template>
                                    <tree-select :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                                                 :options="contentCategoryIdOptions" :style="{width:'100%'}"
                                                 @change="categoryChange"
                                                 v-model="form.categoryId"></tree-select>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row
                                gutter="0"
                                justify="start" align="top">
                            <el-col span="12">
                                <el-form-item label="文章类型" prop="contentType">
                                    <template slot='label'>文章类型
                                        <el-popover placement="top-start" title="提示" trigger="hover">
                                            用于筛选文章，在自定义字典添加
                                            <i class="el-icon-question" slot="reference"></i>
                                        </el-popover>
                                    </template>
                                    <el-select v-model="form.contentType"
                                               :style="{width: '100%'}"
                                               :filterable="false"
                                               :disabled="false"
                                               :multiple="true" :clearable="true"
                                               placeholder="请选择文章类型">
                                        <el-option v-for='item in contentTypeOptions' :key="item.dictValue"
                                                   :value="item.dictValue"
                                                   :label="item.dictLabel"></el-option>
                                    </el-select>
                                </el-form-item>
                            </el-col>
                            <el-col span="12">
                                <el-form-item label="发布时间" prop="contentDatetime">
                                    <template slot='label'>发布时间
                                        <el-popover placement="top-start" title="提示" trigger="hover">
                                            <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                               target="_blank">${'$'}{field.date?string("yyyy-MM-dd")}</a>
                                            <i class="el-icon-question" slot="reference"></i>
                                        </el-popover>
                                    </template>
                                    <el-date-picker
                                            v-model="form.contentDatetime"
                                            placeholder="请选择发布时间"
                                            start-placeholder=""
                                            end-placeholder=""
                                            :readonly="false"
                                            :disabled="false"
                                            :editable="true"
                                            :clearable="true"
                                            format="yyyy-MM-dd HH:mm:ss"
                                            value-format="yyyy-MM-dd HH:mm:ss"
                                            :style="{width:'100%'}"
                                            type="datetime">
                                    </el-date-picker>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row
                                gutter="0"
                                justify="start" align="top">
                            <el-col span="12">
                                <el-form-item label="文章作者" prop="contentAuthor">
                                    <template slot='label'>文章作者
                                        <el-popover placement="top-start" title="提示" trigger="hover">
                                            <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                               target="_blank">${'$'}{field.author}</a>
                                            <i class="el-icon-question" slot="reference"></i>
                                        </el-popover>
                                    </template>
                                    <el-input v-model="form.contentAuthor"
                                              :disabled="false"
                                              :style="{width:  '100%'}"
                                              :clearable="true"
                                              placeholder="请输入文章作者">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                            <el-col span="12">
                                <el-form-item label="文章来源" prop="contentSource">
                                    <template slot='label'>文章来源
                                        <el-popover placement="top-start" title="提示" trigger="hover">
                                            <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                               target="_blank">${'$'}{field.source}</a>
                                            <i class="el-icon-question" slot="reference"></i>
                                        </el-popover>
                                    </template>
                                    <el-input v-model="form.contentSource"
                                              :disabled="false"
                                              :style="{width:  '100%'}"
                                              :clearable="true"
                                              placeholder="请输入文章来源">
                                    </el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row
                                gutter="0"
                                justify="start" align="top">
                            <el-col span="12">
                                <el-form-item label="" prop="contentDisplay">
                                    <template slot='label'>是否显示
                                        <el-popover slot="label" placement="top-start" title="提示" width="200"
                                                    trigger="hover"
                                                    content="选择否后前端将不显示，需要重新生成才有效果">
                                            <i class="el-icon-question" slot="reference"></i>
                                        </el-popover>
                                    </template>
                                    <el-radio-group v-model="form.contentDisplay"
                                                    :style="{width: ''}"
                                                    :disabled="false">
                                        <el-radio :style="{display: true ? 'inline-block' : 'block'}"
                                                  :label="item.value"
                                                  v-for='(item, index) in contentDisplayOptions'
                                                  :key="item.value + index">
                                            {{true? item.label : item.value}}
                                        </el-radio>
                                    </el-radio-group>
                                </el-form-item>
                            </el-col>
                            <el-col span="12">
                                <el-form-item label="自定义顺序" prop="contentSort">
                                    <el-input-number
                                            v-model="form.contentSort"
                                            :disabled="false"
                                            controls-position="">
                                    </el-input-number>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-form-item label="" prop="contentImg">
                            <template slot='label'>文章缩略图
                                <el-popover placement="top-start" title="提示" trigger="hover">
                                    文章缩略图,支持jpg格式
                                    <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                       target="_blank">${'$'}{field.litpic}</a>
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <el-upload
                                    :file-list="form.contentImg"
                                    :action="ms.base+'/file/upload.do'"
                                    :on-remove="contentImghandleRemove"
                                    :style="{width:''}"
                                    :limit="1"
                                    :on-exceed="contentImghandleExceed"
                                    :disabled="false"
                                    :data="{uploadPath:'/cms/content','isRename':true ,'appId':true}"
                                    :on-success="contentImgSuccess"
                                    accept="image/*"
                                    list-type="picture-card">
                                <i class="el-icon-plus"></i>
                                <div slot="tip" class="el-upload__tip">最多上传1张图片</div>
                            </el-upload>
                        </el-form-item>
                        <el-form-item label="关键字" prop="contentKeyword">
                            <template slot='label'>关键字
                                <el-popover placement="top-start" title="提示" trigger="hover">
                                    <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                       target="_blank">${'$'}{field.keyword}</a>
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <el-input
                                    type="textarea" :rows="5"
                                    :disabled="false"
                                    v-model="form.contentKeyword"
                                    :style="{width: '100%'}"
                                    placeholder="请输入文章关键字">
                            </el-input>
                        </el-form-item>
                        <el-form-item label="描述" prop="contentDescription">
                            <template slot='label'>描述
                                <el-popover placement="top-start" title="提示" trigger="hover">
                                    <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                       target="_blank">${'$'}{field.descrip}</a>
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <el-input
                                    type="textarea" :rows="5"
                                    :disabled="false"
                                    v-model="form.contentDescription"
                                    :style="{width: '100%'}"
                                    placeholder="请输入对该文章的简短描述，以便用户查看文章简略">
                            </el-input>
                        </el-form-item>
                        <el-form-item label="文章内容" prop="contentDetails">
                            <template slot='label'>文章内容
                                <el-popover placement="top-start" title="提示" trigger="hover">
                                    <a href="http://doc.mingsoft.net/plugs-cms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                       target="_blank">${'$'}{field.content}</a>
                                    <i class="el-icon-question" slot="reference"></i>
                                </el-popover>
                            </template>
                            <vue-ueditor-wrap style="line-height: 0px" v-model="form.contentDetails"
                                              :config="editorConfig"></vue-ueditor-wrap>
                        </el-form-item>
                    </el-form>
                    <div :id="'model'+index" v-else></div>
                </el-tab-pane>
            </el-tabs>
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
                saveDisabled: false,
                activeName: 'form',
                //自定义模型实例
                model: undefined,
                editableTabs: [{
                    title: '文章编辑',
                    name: 'form'
                }],
                editorConfig: {
                    imageScaleEnabled: true,
                    autoHeightEnabled: true,
                    autoFloatEnabled: false,
                    scaleEnabled: true,
                    compressSide: 0,
                    maxImageSideLength: 1000,
                    maximumWords: 2000,
                    initialFrameWidth: '100%',
                    initialFrameHeight: 400,
                    serverUrl: ms.base + "/static/plugins/ueditor/1.4.3.1/jsp/editor.do?jsonConfig=%7BvideoUrlPrefix:\'" + ms.base + "\',fileUrlPrefix:\'" + ms.base + "\',imageUrlPrefix:\'" + ms.base + "\',imagePathFormat:\'/upload/${appId}/cms/content/editor/%7Btime%7D\',filePathFormat:\'/upload/${appId}/cms/content/editor/%7Btime%7D\',videoPathFormat:\'/upload/${appId}/cms/content/editor/%7Btime%7D\'%7D",
                    UEDITOR_HOME_URL: ms.base + '/static/plugins/ueditor/1.4.3.1/'
                },
                contentCategoryIdOptions: [],
                returnIsShow: true,
                type: '',
                //表单数据
                form: {
                    // 文章标题
                    contentTitle: '',
                    // 所属栏目
                    categoryId: undefined,
                    // 文章类型
                    contentType: [],
                    // 是否显示
                    contentDisplay: '0',
                    // 文章作者
                    contentAuthor: '',
                    // 文章来源
                    contentSource: '',
                    // 自定义顺序
                    contentSort: 0,
                    // 文章缩略图
                    contentImg: [],
                    // 描述
                    contentDescription: '',
                    // 关键字
                    contentKeyword: '',
                    // 文章内容
                    contentDetails: '',

                    contentDatetime: ms.util.date.fmt(Date.now(),"yyyy-MM-dd hh:mm:ss"),
                },
                contentTypeOptions: [],
                categoryIdOptions: [],
                contentDisplayOptions: [{
                    "value": "0",
                    "label": "是"
                }, {
                    "value": "1",
                    "label": "否"
                }],
                rules: {
                    // 文章标题
                    contentTitle: [{
                        "required": true,
                        "message": "请选择文章标题"
                    }],
                    // 发布时间
                    contentDatetime: [{
                        "required": true,
                        "message": "发布时间不能为空"
                    }],
                    categoryId: [{
                        "required": true,
                        "message": "所属栏目不能为空"
                    }]
                }
            };
        },
        watch: {},
        computed: {
            currCategory: function () {
                var that = this;
                return this.categoryIdOptions.find(function (value) {
                    return value.id === that.form.categoryId;
                });
            }
        },
        methods: {
            save: function () {
                var _this = this;

                var that = this; //自定义模型需要验证

                if (this.model && !this.model.validate()) {
                    this.activeName = 'custom-name';
                    return;
                }

                var url = ms.manager + "/cms/content/save.do";

                if (that.form.id > 0) {
                    url = ms.manager + "/cms/content/update.do";
                }

                this.$refs.form[0].validate(function (valid) {
                    if (valid) {
                        that.saveDisabled = true; //判断

                        // if (that.categoryIdOptions.filter(function (f) {
                        //     return f['id'] == that.form.categoryId;
                        // })[0].categoryType == '2' && that.returnIsShow) {
                        //     that.$notify({
                        //         title: '提示',
                        //         message: '所属栏目不能为封面',
                        //         type: 'error'
                        //     });
                        //     that.saveDisabled = false;
                        //     return;
                        // }

                        var data = JSON.parse(JSON.stringify(that.form));

                        if (data.contentType) {
                            data.contentType = data.contentType.join(',');
                        }

                        data.contentImg = JSON.stringify(data.contentImg);
                        ms.http.post(url, data).then(function (data) {
                            if (data.result) {
                                //保存时需要赋值关联ID
                                if (that.model) {
                                    that.model.form.linkId = data.data.id;
                                    that.model.save();
                                }
                                that.$notify({
                                    title: '成功',
                                    message: '保存成功',
                                    type: 'success',
                                    duration: 1000,
                                    onClose: function () {
                                        if (that.returnIsShow) {
                                            javascript: history.go(-1);
                                        } else {
                                            //如果是顶级封面或封面，则重新加载,避免文章和自定义模型重复保存
                                            location.reload();
                                        }
                                        that.saveDisabled = false;
                                    }
                                });

                            } else {
                                that.$notify({
                                    title: '失败',
                                    message: data.msg,
                                    type: 'warning'
                                });
                                that.saveDisabled = false;
                            }

                        });
                    } else {
                        _this.activeName = 'form';
                        return false;
                    }
                });
            },
            removeModel: function () {
                var that = this;
                var model = document.getElementById('model1');
                var custom = document.getElementById('c_model');

                if (custom) {
                    model.removeChild(custom);
                }

                that.model = undefined;
            },
            categoryChange: function () {
                this.changeModel();
            },
            changeModel: function () {
                var that = this;
                that.editableTabs = [that.editableTabs[0]];
                this.removeModel();

                if (this.currCategory) {
                    if (this.currCategory.mdiyModelId) {
                        ms.http.get(ms.manager + "/mdiy/model/get.do", {
                            id: this.currCategory.mdiyModelId
                        }).then(function (data) {
                            if (data.data && data.data.id) {
                                that.rederModel(data.data, JSON.parse(data.data.modelJson));
                            }
                        });
                    }
                }
            },
            rederModel: function (modelEntity, data) {
                var that = this;
                that.editableTabs.push({
                    title: modelEntity.modelName,
                    name: 'custom-name'
                });
                this.removeModel();
                that.$nextTick(function () {
                    var div = document.createElement('div');
                    div.id = 'c_model';
                    var model = document.getElementById('model1');
                    model.appendChild(div);
                    var s = document.createElement('script');
                    s.innerHTML = data.script;
                    var con = document.createElement('div');
                    con.id = 'custom-model';
                    con.innerHTML = data.html;
                    div.appendChild(s);
                    div.appendChild(con); //初始化自定义模型并传入关联参数

                    that.model = new custom_model({
                        data: {
                            title: modelEntity.modelName,
                            modelId: modelEntity.id,
                            form: {
                                linkId: that.form.id
                            }
                        }
                    });
                });
            },
            getValue: function (data) {
                this.form.categoryId = data.id;
            },
            //获取当前文章
            get: function (id) {
                var that = this;
                ms.http.get(ms.manager + "/cms/content/get.do", {
                    "id": id
                }).then(function (res) {
                    if (res.result && res.data) {
                        if (res.data.contentType && res.data.contentType != '') {
                            res.data.contentType = res.data.contentType.split(',');
                        } else {
                            res.data.contentType = [];
                        }

                        if (res.data.contentImg) {
                            res.data.contentImg = JSON.parse(res.data.contentImg);
                            res.data.contentImg.forEach(function (value) {
                                value.url = ms.base + value.path;
                            });
                        } else {
                            res.data.contentImg = [];
                        }

                        that.form = res.data;
                        var category = that.categoryIdOptions.filter(function (f) {
                            return f['id'] == that.form.categoryId;
                        });

                        if (category.length == 1) {
                            if (category[0].categoryType == '2') {
                                that.returnIsShow = false;
                            }
                        }
                        that.changeModel();
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //根据封面获取当前文章
            getFromFengMian: function (categoryId) {
                var that = this;
                ms.http.get(ms.manager + "/cms/content/getFromFengMian.do", {
                    "categoryId": categoryId
                }).then(function (res) {
                    if (res.result) {
                        if (res.data != null) {
                            if (res.data.contentType && res.data.contentType != '') {
                                res.data.contentType = res.data.contentType.split(',');
                            } else {
                                res.data.contentType = [];
                            }

                            if (res.data.contentImg) {
                                res.data.contentImg = JSON.parse(res.data.contentImg);
                                res.data.contentImg.forEach(function (value) {
                                    value.url = ms.base + value.path;
                                });
                            } else {
                                res.data.contentImg = [];
                            }

                            that.form = res.data;
                            var category = that.categoryIdOptions.filter(function (f) {
                                return f['id'] == that.form.categoryId;
                            });

                            if (category.length == 1) {
                                if (category[0].categoryType == '2') {
                                    that.returnIsShow = false;
                                }
                            }
                        }
                        that.changeModel();
                    } else {
                        that.$notify({
                            title: '失败',
                            message: "获取错误",
                            type: 'warning'
                        });
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取contentCategoryId数据源
            contentCategoryIdOptionsGet: function () {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/list.do", {
                    pageSize: 9999
                }).then(function (res) {
                    if (res.result) {
                        res.data.rows.forEach(function (item) {
                            if (item.categoryType == '2' || item.categoryType == '3') {
                                item.isDisabled = true;
                            }
                        });
                        that.contentCategoryIdOptions = ms.util.treeData(res.data.rows, 'id', 'categoryId', 'children');
                        that.categoryIdOptions = res.data.rows;

                        //获取到栏目数据之后再进行初始化
                        that.init();
                    }
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
            },
            //contentImg文件上传完成回调
            contentImgSuccess: function (response, file, fileList) {
                if(response.result){
                    this.form.contentImg.push({
                        url: file.url,
                        name: file.name,
                        path: response.data,
                        uid: file.uid
                    });
                }else {
                    this.$notify({
                        title: response.msg,
                        type: 'warning'
                    });
                }

            },
            contentImghandleRemove: function (file, files) {
                var index = -1;
                index = this.form.contentImg.findIndex(function (text) {
                    return text == file;
                });

                if (index != -1) {
                    this.form.contentImg.splice(index, 1);
                }
            },
            //上传超过限制
            contentImghandleExceed: function (files, fileList) {
                this.$notify({
                    title: '当前最多上传1个文件',
                    type: 'warning'
                });
            },
            //查询列表
            list: function (categoryId) {
                var that = this;
                ms.http.post(ms.manager + "/cms/content/list.do", {
                    categoryId: categoryId
                }).then(function (res) {
                    if (res.result && res.data.total > 0) {
                        if (res.data.rows[0].contentType) {
                            res.data.rows[0].contentType = res.data.rows[0].contentType.split(',');
                        }

                        if (res.data.rows[0].contentImg) {
                            res.data.rows[0].contentImg = JSON.parse(res.data.rows[0].contentImg);
                            res.data.rows[0].contentImg.forEach(function (value) {
                                value.url = ms.base + value.path;
                            });
                        } else {
                            res.data.rows[0].contentImg = [];
                        }

                        that.form = res.data.rows[0];
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //只有在渲染完栏目数据之后才会初始化
            init: function () {
                this.form.id = ms.util.getParameter("id");
                this.type = ms.util.getParameter("type");

                //在指定栏目下新增或编辑文章时
                var categoryId = ms.util.getParameter("categoryId");
                if (categoryId) {
                    this.form.categoryId = categoryId;
                    //如果是封面栏目直接跳转
                    if (this.type) {
                        this.getFromFengMian(this.form.categoryId);
                        this.returnIsShow = false;
                        //指定非封面栏目编辑文章
                    }else if (this.form.id) {
                        this.get(this.form.id);
                        //指定栏目新增文章渲染自定义模型
                    }else {
                        this.changeModel();
                    }
                    //不指定栏目编辑文章
                }else if (this.form.id) {
                    this.get(this.form.id);
                }//else 如果即不指定栏目新增文章，又不是编辑文章就不渲染自定义模型

            }
        },
        created: function () {
            this.contentCategoryIdOptionsGet();
            this.contentTypeOptionsGet();
        }
    });
</script>
<style>
    .el-select {
        width: 100%;
    }

    body {
        overflow: hidden;
    }

    #form {
        overflow: hidden;
    }
    .el-scrollbar__bar.is-vertical{
        width: 6px!important;
    }
</style>
