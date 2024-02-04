<!DOCTYPE html>
<html>
<head>
    <title>文章</title>
    <#include "../../include/head-file.ftl">
    <script src="${base}/static/mdiy/index.js"></script>
</head>
<body>
<div id="form" v-cloak>
    <el-header class="ms-header ms-tr" height="50px" >
        <el-row type="flex" justify="space-between" align="middle">
            <el-col :xs=12 :sm=14 :md=16 :lg=18 :xl=18 style="display:flex;align-items:center;">
                <el-tooltip class="item" effect="dark" :content="form.id" placement="top-start">
                    <span v-if="form.id && categoryType=='2'" style="float: left; max-width:calc(30% - 40px);" class="header-info">编号：{{form.id}}</span>
                </el-tooltip>
                <el-button v-if="form.id && categoryType=='2'" type="text" link style="float: left" icon="el-icon-document-copy" circle :data-clipboard-text="form.id" @click="copyString()" class="copyBtn"></el-button>
            </el-col>
            <el-col :xs=12 :sm=10 :md=8 :lg=6 :xl=6 class="ms-tr">
                <@shiro.hasPermission name="cms:content:save">
                    <el-button type="primary" class="iconfont icon-baocun" size="mini" @click="save()" :loading="saveDisabled">保存
                    </el-button>
                </@shiro.hasPermission>
                <el-button v-if="categoryType==1" size="mini" class="iconfont icon-fanhui" plain onclick="javascript:history.go(-1)">返回
                </el-button>
                <el-button v-if="categoryType==2" size="mini" type="danger" icon="el-icon-delete" @click="del()">删除
                </el-button>
            </el-col>
        </el-row>
    </el-header>
    <el-main class="ms-container" style="position:relative;">
        <el-scrollbar class="ms-scrollbar" style="height: 95vh">
            <el-tabs v-model="activeName" style="height: calc(100vh - 10px);">
                <el-tab-pane style="position:relative;" v-for="(item, index) in editableTabs" :key="index"
                             :label="item.title" :name="item.name">
                    <el-form v-if="item.title=='文章编辑'" ref="form" :model="form" :rules="rules" label-width="120px"
                             size="mini">
                        <el-row :gutter=0 justify="start" align="top">
                            <el-col :span=12>
                                <el-form-item label="文章标题" prop="contentTitle">
                                    <el-input v-model="form.contentTitle"
                                              :disabled="false"
                                              :style="{width:  '100%'}"
                                              :clearable="true"
                                              placeholder="请输入文章标题">
                                    </el-input>
                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.title}</a>
                                    </div>
                                </el-form-item>
                            </el-col>
                            <el-col :span=12 >
                                <el-form-item label="所属栏目" prop="categoryId">
                                    <treeselect v-model="form.categoryId"
                                                :disabled="!returnIsShow"
                                                :disable-branch-nodes="true"
                                                :normalizer="function(node){
                                                return {
                                                    id: node.id,
                                                    label: node.categoryTitle,
                                                    children: node.children
                                                }}"
                                                @select="categoryChange"
                                                :options="contentCategoryIdOptions" placeholder="请选择"></treeselect>

                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.typetitle}</a>
                                        不能选择封面、链接栏目类型，不能选择父栏目
                                    </div>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row
                                :gutter=0
                                justify="start" align="top">
                            <el-col :span=12>
                                <el-form-item label="文章副标题" prop="contentShortTitle">
                                    <el-input v-model="form.contentShortTitle"
                                              :disabled="false"
                                              :style="{width:  '100%'}"
                                              :clearable="true"
                                              placeholder="请输入文章副标题">
                                    </el-input>
                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.shorttitle}</a>
                                    </div>
                                </el-form-item>
                            </el-col>
                            <el-col :span=12>
                                <el-form-item label="文章外链接" prop="contentOutLink">
                                    <el-input v-model="form.contentOutLink"
                                              :disabled="false"
                                              :style="{width:  '100%'}"
                                              :clearable="true"
                                              placeholder="请输入文章外链接">
                                    </el-input>
                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html"
                                              target="_blank">${'$'}{field.outlink}</a> 文章外链接必须以http或者https等开头
                                    </div>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row
                                :gutter=0
                                justify="start" align="top">
                            <el-col :span=12>
                                <el-form-item label="文章类型" prop="contentType">
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
                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{flag}</a>
                                        通过自定义字典可扩展，通常用在 arclist标签的flag属性上进行过滤文章
                                    </div>
                                </el-form-item>
                            </el-col>
                            <el-col :span=12>
                                <el-form-item label="发布时间" prop="contentDatetime">
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
                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.date?string("yyyy-MM-dd")}</a>
                                    </div>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row
                                :gutter=0
                                justify="start" align="top">
                            <el-col :span=12>
                                <el-form-item label="文章作者" prop="contentAuthor">
                                    <el-input v-model="form.contentAuthor"
                                              :disabled="false"
                                              :style="{width:  '100%'}"
                                              :clearable="true"
                                              placeholder="请输入文章作者">
                                    </el-input>
                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.author}</a>
                                    </div>
                                </el-form-item>
                            </el-col>
                            <el-col :span=12>
                                <el-form-item label="文章来源" prop="contentSource">
                                    <el-input v-model="form.contentSource"
                                              :disabled="false"
                                              :style="{width:  '100%'}"
                                              :clearable="true"
                                              placeholder="请输入文章来源">
                                    </el-input>
                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.source}</a>
                                    </div>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row
                                :gutter=0
                                justify="start" align="top">
                            <el-col :span=12>
                                <el-form-item label="是否显示" prop="contentDisplay">
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
                                    <div class="ms-form-tip">
                                        选择否后前端将不显示，需要重新生成才有效果
                                    </div>
                                </el-form-item>
                            </el-col>
                            <el-col :span=12>
                                <el-form-item label="自定义顺序" prop="contentSort">
                                    <el-input-number
                                            v-model="form.contentSort"
                                            :disabled="false"
                                            controls-position="">
                                    </el-input-number>
                                    <div class="ms-form-tip">
                                        提示：前台模板标签需要设置orderby属性为sort才能生效
                                    </div>
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row
                                :gutter=0
                                justify="start" align="top">
                            <el-col :span=12>
                                <el-form-item label="文章缩略图" prop="contentImg">
                                    <el-upload
                                            :file-list="form.contentImg"
                                            :action="ms.manager+'/file/upload.do'"
                                            :on-remove="contentImghandleRemove"
                                            :style="{width:''}"
                                            :limit="10"
                                            :on-exceed="contentImghandleExceed"
                                            :disabled="false"
                                            :data="{uploadPath:'/cms/content','isRename':true ,'appId':true}"
                                            :on-success="contentImgSuccess"
                                            :on-error="contentImgError"
                                            accept="image/*"
                                            list-type="picture-card">
                                        <i class="el-icon-plus"></i>
                                        <template slot="tip">
                                            <div class="ms-form-tip">
                                                标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'{@ms:file field.litpic/}'}</a><br/>
                                                最多可上传10张图片，文章缩略图,支持jpg格式；多图情况下，{@ms:file field.litpic/}会只取第一张缩略图，其他用法参考文档arclist标签
                                            </div>
                                        </template>
                                    </el-upload>
                                </el-form-item>
                            </el-col>
                            <el-col :span=12>
                                <el-form-item label="文章标签" prop="contentTags">
                                    <el-select v-model="form.contentTags"
                                               :style="{width: '100%'}"
                                               :filterable="false"
                                               :disabled="false"
                                               :multiple="true" :clearable="true"
                                               placeholder="请选择文章标签">
                                        <el-option v-for='item in contentTagsOptions' :key="item.dictValue"
                                                   :value="item.dictValue"
                                                   :label="item.dictLabel"></el-option>
                                    </el-select>
                                    <div class="ms-form-tip">
                                        标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.tags}</a>
                                        通过自定义字典可扩展数据；字典类型：文章标签
                                    </div>
                                </el-form-item>
                            </el-col>
                        </el-row>

                        <el-form-item label="关键字" prop="contentKeyword">
                            <el-input
                                    type="textarea" :rows="5"
                                    :disabled="false"
                                    v-model="form.contentKeyword"
                                    :style="{width: '100%'}"
                                    placeholder="请输入文章关键字">
                            </el-input>
                            <div class="ms-form-tip">
                                标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.keyword}</a>，用于SEO优化
                            </div>
                        </el-form-item>
                        <el-form-item label="描述" prop="contentDescription">
                            <el-input
                                    type="textarea" :rows="5"
                                    :disabled="false"
                                    v-model="form.contentDescription"
                                    :style="{width: '100%'}"
                                    placeholder="请输入对该文章的简短描述，以便用户查看文章简略">
                            </el-input>
                            <div class="ms-form-tip">
                                标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.descrip}</a>，用于SEO优化
                            </div>
                        </el-form-item>
                        <el-form-item label="文章内容" prop="contentDetails">
                            <vue-ueditor-wrap style="line-height: 0px" v-model="form.contentDetails"
                                              :config="editorConfig"></vue-ueditor-wrap>
                            <div class="ms-form-tip">
                                标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.content}</a>
                            </div>
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
    var formVue = new Vue({
        el: '#form',
        data: function () {
            var checkTags = function (rule, value, callback){
                if (value.length > 5){
                    return callback(new Error('文章标签最多选择5个'));
                }
                callback();
            }
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
                    imageScaleEnabled :true,
                    autoHeightEnabled: true,
                    autoFloatEnabled: false,
                    scaleEnabled: true,
                    compressSide:0,
                    maxImageSideLength:1000,
                    maximumWords: 2000,
                    initialFrameWidth: '100%',
                    initialFrameHeight: 400,
                    serverUrl: ms.base + "/static/plugins/ueditor/1.4.3.3/jsp/editor.do?jsonConfig=%7BvideoUrlPrefix:\'\',fileManagerListPath:\'\',imageMaxSize:204800000,videoMaxSize:204800000,fileMaxSize:204800000,fileUrlPrefix:\'\',imageUrlPrefix:\'\',imagePathFormat:\'/${app.id}/editor/%7Btime%7D\',filePathFormat:\'/${app.id}/editor/%7Btime%7D\',videoPathFormat:\'/${app.id}/editor/%7Btime%7D\'%7D",
                    UEDITOR_HOME_URL: ms.base + '/static/plugins/ueditor/1.4.3.3/'
                },
                contentCategoryIdOptions: [],
                returnIsShow: true,
                type: '',
                //表单数据
                form: {
                    // 文章标题
                    contentTitle: '',
                    // 文章副标题
                    contentShortTitle: '',
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
                    // 文章标签
                    contentTags: [],
                    // 文章缩略图
                    contentImg: [],
                    // 描述
                    contentDescription: '',
                    // 关键字
                    contentKeyword: '',
                    // 文章内容
                    contentDetails: '',
                    //文章外链接
                    contentOutLink: '',
                    contentDatetime: ms.util.date.fmt(Date.now(),"yyyy-MM-dd hh:mm:ss"),
                },
                categoryType: '1',
                contentTypeOptions: [],
                contentTagsOptions: [],
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
                    }],
                    contentTags: [{
                        validator: checkTags, trigger: 'blur'
                    }]
                }
            };
        },
        watch: {

        },
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

                var model = null;
                if (that.currCategory && that.currCategory.mdiyModelId && String(that.currCategory.mdiyModelId )!="0"){
                    try {
                        model = ms.mdiy.model.modelForm();
                    } catch (e) {
                        console.log(e)
                    }
                }
                if (model && !model.validate()) {
                    this.activeName = 'custom-name';
                    return;
                }
                var url = ms.manager + "/cms/content/save.do";

                if (that.form.id > 0) {
                    url = ms.manager + "/cms/content/update.do";
                }
                //若缩略图为空则赋值为空串
                if (that.form.contentImg.length == 0){
                    that.form.contentImg = [];
                }

                this.$refs.form[0].validate(function (valid) {
                    if (valid) {
                        that.saveDisabled = true; //判断

                        var data = JSON.parse(JSON.stringify(that.form));
                        // 固定属性顺序为字典顺序
                        if (data.contentType) {
                            var orderTypes = [];
                            that.contentTypeOptions.forEach(function (dict) {
                                var orderType = data.contentType.find(function (type) {
                                    return type==dict.dictValue
                                })
                                if (orderType){
                                    orderTypes.push(orderType)
                                }
                            })
                            data.contentType = orderTypes.join(',');
                        }
                        if (data.contentTags) {
                            data.contentTags = data.contentTags.join(',');
                        }
                        if (data.contentImg == []) {
                            data.contentImg = ""
                        }else {
                            data.contentImg = JSON.stringify(data.contentImg);
                        }
                        ms.http.post(url, data).then(function (data) {
                            if (data.result) {
                                //保存时需要赋值关联ID
                                if (window.model) {
                                    window.model.form.linkId = data.data.id;
                                    window.model.save();
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
            //删除
            del: function () {
                var that = this;
                that.$confirm('此操作将永久删除所选内容, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    var formData = that.form;
                    formData.contentType = ""
                    formData.contentImg = ""
                    formData.contentTags = ""
                    ms.http.post(ms.manager + "/cms/content/delete.do",  [formData], {
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    }).then(function (res) {
                        if (res.result) {
                            that.$notify({
                                title:'成功',
                                type: 'success',
                                message: '删除成功!'
                            });
                            //	刷新列表
                            window.parent.location.reload();
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
            categoryChange: function () {
                this.changeModel();
            },
            changeModel: function () {
                var that = this;
                that.editableTabs = [that.editableTabs[0]];

                if (this.currCategory) {
                    if (this.currCategory.mdiyModelId) {
                        that.rederModel(this.currCategory.mdiyModelId)
                    }
                }
            },
            rederModel: function (modelId) {
                var that = this;
                that.editableTabs.push({
                    title: '加载中...',
                    name: 'custom-name'
                });
                window.formVue = this;
                this.$nextTick(function () {
                    ms.mdiy.model.extend("model1", {id:modelId},{ linkId: that.form.id },true).then(function(obj) {
                        window.model = obj;
                        that.editableTabs[1].title = obj.modelName
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

                        if (res.data.contentTags && res.data.contentTags != '') {
                            res.data.contentTags = res.data.contentTags.split(',');
                        } else {
                            res.data.contentTags = [];
                        }

                        if (res.data.contentImg && res.data.contentImg != '') {
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

                        if (category.length > 0) {
                            that.categoryType = category[0].categoryType
                            if (category[0].categoryType == '2' || category[0].categoryType == '3') {
                                that.returnIsShow = false;
                            }
                        }
                        that.changeModel();
                    }
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

                            if (res.data.contentImg && res.data.contentImg != '') {
                                res.data.contentImg = JSON.parse(res.data.contentImg);
                                res.data.contentImg.forEach(function (value) {
                                    value.url = ms.base + value.path;
                                });
                            } else {
                                res.data.contentImg = [];
                            }

                            if (res.data.contentTags && res.data.contentTags != '') {
                                res.data.contentTags = res.data.contentTags.split(',');
                            } else {
                                res.data.contentTags = [];
                            }

                            that.form = res.data;
                            var category = that.categoryIdOptions.filter(function (f) {
                                return f['id'] == that.form.categoryId;
                            });

                            if (category.length > 0) {
                                that.categoryType = category[0].categoryType
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
                });
            },
            //获取contentCategoryId数据源
            contentCategoryIdOptionsGet: function () {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/list.do").then(function (res) {
                    if (res.result) {
                        res.data.rows.forEach(function (item) {
                            // 栏目为单篇或链接且无子栏目 则不可选
                            if ( (item.categoryType == '2' || item.categoryType == '3') && item.leaf) {
                                item.isDisabled = true;
                            }
                        });
                        that.contentCategoryIdOptions = ms.util.treeData(res.data.rows, 'id', 'categoryId', 'children');
                        that.categoryIdOptions = res.data.rows;

                        //获取到栏目数据之后再进行初始化
                        that.init();
                    }
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
                });
            },
            //获取contentTag数据源
            contentTagsOptionsGet: function () {
                var that = this;
                ms.http.get(ms.base + '/mdiy/dict/list.do', {
                    dictType: '文章标签',
                    pageSize: 99999
                }).then(function (data) {
                    if(data.result){
                        data = data.data;
                        that.contentTagsOptions = data.rows;
                    }
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
                        title: '失败',
                        message: response.msg,
                        type: 'warning'
                    });
                }

            },
            //contentImg文件上传失败回调
            contentImgError: function (response, file, fileList) {
                response = response.toString().replace("Error: ","")
                response = JSON.parse(response);
                this.$notify({
                    title: '失败',
                    message: response.msg,
                    type: 'warning'
                });
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
                    title: '失败',
                    message: '当前最多上传10个文件',
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

                        if (res.data.rows[0].contentImg && res.data.rows[0].contentImg != '') {
                            res.data.rows[0].contentImg = JSON.parse(res.data.rows[0].contentImg);
                            res.data.rows[0].contentImg.forEach(function (value) {
                                value.url = ms.base + value.path;
                            });
                        } else {
                            res.data.rows[0].contentImg = [];
                        }

                        that.form = res.data.rows[0];
                    }
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

            },
            //复制文章id
            copyString: function () {
                var clipboard = new ClipboardJS('.copyBtn');
                var self = this;
                clipboard.on('success', function (e) {
                    self.$notify({
                        title: '提示',
                        message: '已成功复制到剪切板',
                        type: 'success'
                    });
                    clipboard.destroy();
                });
            },
        },
        created: function () {
            this.contentCategoryIdOptionsGet();
            this.contentTypeOptionsGet();
            this.contentTagsOptionsGet();
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
    .header-info {
        white-space: nowrap;
        display:inline-block;
        overflow: hidden;
        text-overflow: ellipsis;
    }
</style>
