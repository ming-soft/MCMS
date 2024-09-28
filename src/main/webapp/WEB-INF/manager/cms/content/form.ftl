
<template type="text/x-template" id="content-form">
    <div id="form" v-cloak>
        <el-header class="ms-header ms-tr" height="50px" >
            <el-row type="flex" justify="space-between" align="middle" style="width: 100%;">
                <el-col :span=12 style="display:flex;align-items:center;">
                    <el-tooltip v-if="form.id && categoryType=='2'" class="item" effect="dark" :content="form.id" placement="top-start">
                        <span  style="float: left; " class="header-info">编号：{{form.id}}</span>
                    </el-tooltip>
                    <el-button v-if="form.id && categoryType=='2'" type="primary" link style="float: left" class="el-icon-document-copy copyBtn" circle :data-clipboard-text="form.id" @click="copyString()"></el-button>
                </el-col>
                <el-col :span="12"  class="ms-tr">
                    <@shiro.hasPermission name="cms:content:save">
                        <el-button type="primary" class="iconfont icon-baocun" size="default" @click="save()" :loading="saveDisabled">保存
                        </el-button>
                    </@shiro.hasPermission>
                    <el-button v-if="categoryType!='2' || id!=null" size="default" class="iconfont icon-fanhui" plain @click="back()">返回
                    </el-button>
                    <el-button v-if="form.id && categoryType=='2'" size="default" type="danger" class="el-icon-delete" @click="del()" :disabled="!form.id" >删除
                    </el-button>
                </el-col>
            </el-row>
        </el-header>
        <el-main class="ms-container" style="position:relative;">
            <el-scrollbar class="ms-scrollbar" style="height: 100%;">
                <el-tabs v-model="activeName" style="height: calc(100% - 10px);">
                    <el-tab-pane style="position:relative;" v-for="(item, index) in editableTabs" :key="index"
                                 :label="item.title" :name="item.name">
                        <el-form v-if="item.title=='文章编辑'" ref="form" :model="form" :rules="rules" label-width="120px"
                                 size="default">
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
                                        <el-tree-select
                                                v-model="form.categoryId"
                                                :disabled="!categoryChangeEnabled"
                                                :data="contentCategoryIdOptions"
                                                :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                                                :render-after-expand="false"
                                                :check-strictly="false"
                                                :default-expand-all="false"
                                                @change="categoryChange"
                                                filterable
                                        ></el-tree-select>
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
                                                format="YYYY-MM-DD HH:mm:ss"
                                                value-format="YYYY-MM-DD HH:mm:ss"
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
                                                      :value="item.value"
                                                      v-for='(item, index) in contentDisplayOptions'
                                                      :key="item.value + index">
                                                {{true? item.label : item.value}}
                                            </el-radio>
                                        </el-radio-group>
                                        <div class="ms-form-tip">
                                            选择否后前端将不显示，需要重新生成才有效果。单篇文章显示是由栏目控制。
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
                                                :on-preview="contentImgHandLePreview"
                                                accept="image/*"
                                                list-type="picture-card">
                                            <i class="el-icon-plus"></i>
                                            <template #tip>
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
                            <el-form-item label="文章内容" prop="contentDetails" v-loading="editorHiden">
                                <vue-ueditor-wrap style="line-height: 0px"
                                                  v-if="!editorHiden"
                                                  v-model="form.contentDetails"
                                                  :config="editorConfig"></vue-ueditor-wrap>
                                <div class="ms-form-tip">
                                    标签：<a href="http://doc.mingsoft.net/mcms/biao-qian/wen-zhang-lie-biao-ms-arclist.html" target="_blank">${'$'}{field.content}</a> <br/>
                                    温馨提示：推荐使用高级版本编辑器，<a href='http://store.mingsoft.net/#/detail?id=299&type=plugin' target="_blank">新版富文本编辑器</a>
                                </div>
                            </el-form-item>
                        </el-form>
                        <div :id="'model'+index" v-else>
                            <ms-mdiy-form v-if="modelName!=null" ref="modelForm" type="model" :model-name="modelName" :model-id="modelId" :id="form.id"></ms-mdiy-form>
                        </div>
                    </el-tab-pane>
                </el-tabs>
            </el-scrollbar>
        </el-main>
    </div>
</template>

<script>
    var contentForm = Vue.defineComponent({
        template: '#content-form',
        props:["categoryId","categoryType","id"],
        data: function () {
            var checkTags = function (rule, value, callback){
                if (value.length > 5){
                    return callback(new Error('文章标签最多选择5个'));
                }
                callback();
            }
            return {
                editorHiden:true,
                saveDisabled: false,
                activeName: 'form',
                //自定义模型实例
                model: undefined,
                modelName:null,
                modelId:null,
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
                categoryChangeEnabled: true,
                // type: '',
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
                        "message": "请输入文章标题"
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
                    // 文章外链接
                    contentOutLink: [{
                        "pattern":/(((http|ftp|https):\/\/)?)([a-zA-Z0-9.-])\/[a-zA-Z0-9&%.\/-~-]*/,
                        "message":"文章外链接格式不匹配"},{"min":0,"max":200,"message":"文章外链接长度必须为0-200"}],
                    // 文章标签
                    contentTags: [{
                        validator: checkTags, trigger: 'blur'
                    }]
                },
                historyKey:"cms_content_history"
            };
        },
        watch: {
            "categoryId":function(n,o) {
                var that = this;
                that.activeName = "form";
                that.$refs.form[0].resetFields();

                that.contentCategoryIdOptionsGet();
            },

        },
        computed: {
        },
        methods: {
            back:function() {
                //如果没有back方法，说明不是从文章管理里面打开的文章表单
                //是文章管理的就放回对应的栏目列表
                //不是就路由会退一下
                if(this.$attrs.onBack) {
                    this.$emit('back');
                } else {
                    this.$router.go(-1);
                }
            },

            async save () {
                var that = this; //自定义模型需要验证



                let formValid = false;

                if(that.$refs.modelForm && that.$refs.modelForm.length > 0) {
                    await that.$refs.modelForm[0].$refs.form.$refs.form.validate((valid,fields) => {
                        formValid = valid;
                    })

                    if(!formValid) {
                        this.activeName = 'custom-name';
                        return;
                    }
                }

                var url = ms.manager + "/cms/content/save.do";

                if (that.form.id > 0) {
                    url = ms.manager + "/cms/content/update.do";
                } else {
                    //新增数据重置到列表第一页
                    sessionStorage.setItem(that.historyKey,JSON.stringify({form:{},page: {pageNo:1}}));
                }

                this.$refs.form[0].validate(function (valid) {
                    if (valid) {
                        that.saveDisabled = true; //判断

                        var data = JSON.parse(JSON.stringify(that.form));
                        // 固定属性顺序为字典顺序
                        if (data.contentType && data.contentType.length > 0) {
                            var orderTypes = [];
                            that.contentTypeOptions.forEach(function (dict) {
                                var orderType = data.contentType.find(function (type) {
                                    return type==dict.dictValue
                                })
                                if (orderType){
                                    orderTypes.push(orderType);
                                }
                            })
                            data.contentType = orderTypes;
                        }
                        if (data.contentType) {
                            data.contentType = data.contentType.join(',');
                        }
                        if (data.contentTags) {
                            data.contentTags = data.contentTags.join(',');
                        }

                        data.contentImg = JSON.stringify(data.contentImg);
                        ms.http.post(url, data).then(function (res) {
                            if (res.result) {
                                if(that.$refs.modelForm && that.$refs.modelForm.length > 0) {
                                    that.$refs.modelForm[0].$refs.form.form.linkId = res.data.id;
                                    that.$refs.modelForm[0].getForm().save(function (resModel) {
                                        if (resModel.result) {
                                            //模型保存成功
                                            // 这里会有异步问题，所以这里分别用了两个保存提示
                                            that.$notify({
                                                title: '成功',
                                                message: '保存成功',
                                                type: 'success',
                                                duration: 1000,
                                                onClose: function () {
                                                    if (that.categoryChangeEnabled) { //如果列表新增就需要返回的列表
                                                        that.$emit("back");
                                                    }
                                                    //为了让上传控件不显示类型警告
                                                    if(res.data.contentImg=="") {
                                                        res.data.contentImg =[];
                                                    }
                                                }
                                            });
                                        } else {
                                            //模型保存失败
                                            that.$notify({
                                                title: '失败',
                                                message: that.$refs.modelForm[0].modelName + '拓展模型保存失败，' + resModel.msg,
                                                type: 'warning'
                                            });
                                        }
                                    })
                                } else {
                                    that.$notify({
                                        title: '成功',
                                        message: '保存成功',
                                        type: 'success',
                                        duration: 1000,
                                        onClose: function () {
                                            if (that.categoryChangeEnabled) { //如果列表新增就需要返回的列表
                                                that.$emit("back");
                                            }
                                            //为了让上传控件不显示类型警告
                                            if(res.data.contentImg=="") {
                                                res.data.contentImg =[];
                                            }
                                        }
                                    });
                                }

                                that.saveDisabled = false;

                            } else {
                                that.$notify({
                                    title: '失败',
                                    message: res.msg,
                                    type: 'warning'
                                });
                                that.saveDisabled = false;
                            }

                        })
                    } else {
                        that.activeName = 'form';
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
                    formData.contentImg = "";
                    formData.contentType = "";
                    formData.contentTags = "";
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
                            // 单篇删除 保留所属栏目
                            var categoryId = that.form.categoryId;
                            that.$refs.form[0].resetFields();
                            that.form.id = "";
                            that.form.categoryId = categoryId;
                            that.activeName = "form";
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
            categoryChange: function (node) {
                // 新组件node就是节点id
                this.changeModel(node);
            },
            changeModel: function (categoryId) {
                var that = this;
                that.editableTabs = [that.editableTabs[0]];

                var _category = this.categoryIdOptions.filter(function (value) {
                    return value.id === categoryId;
                })


                //如果存在自定义模型
                if(_category.length == 1 && _category[0].mdiyModelId) {
                    ms.http.get(ms.manager + "/mdiy/model/get.do", {id: _category[0].mdiyModelId}).then(function (res) {
                        if (res.result && res.data) {
                            that.editableTabs.push({title: '加载中...',name: 'custom-name'});
                            that.modelId = res.data.id;
                            that.modelName = res.data.modelName;
                            that.editableTabs[1].title = res.data.modelName
                        }
                    });
                }
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
                            that.changeModel(category[0].id);
                        }

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

                            if (res.data.contentTags && res.data.contentTags != '') {
                                res.data.contentTags = res.data.contentTags.split(',');
                            } else {
                                res.data.contentTags = [];
                            }

                            that.form = res.data;

                            // 左侧树选择单篇
                            var category = that.categoryIdOptions.filter(function (f) {
                                return f['id'] == that.form.categoryId;
                            });
                            if (category.length > 0) {
                                that.categoryChangeEnabled = false;
                                that.changeModel(category[0].id);
                            }
                        }
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
                ms.http.get(ms.manager + "/cms/category/list.do").then(function (res) {
                    if (res.result) {
                        res.data.rows.forEach(function (item) {
                            if (item.categoryType == '2' || item.categoryType == '3') {
                                item.disabled = true;
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
            contentImgHandLePreview:function (file) {
                window.open(file.url)
            },
            contentImghandleRemove: function (file, files) {
                var index = -1;
                index = this.form.contentImg.findIndex(function (text) {
                    return text.uid == file.uid;
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
            contentImgHandLePreview:function (file) {
                window.open(file.url)
            },
            //只有在渲染完栏目数据之后才会初始化
            init: function () {
				var that = this;
                this.form.id = this.id;
                this.editorHiden = true;

                //在指定栏目下新增或编辑文章时
                if (this.categoryId) {
                    this.form.categoryId = this.categoryId;
                    //如果是封面栏目直接跳转
                    if (this.categoryType=="2") { //封面
                        this.getFromFengMian(this.form.categoryId);
                        this.categoryChangeEnabled = false;
                        //指定非封面栏目编辑文章
                    }else if (this.form.id) {
                        this.get(this.form.id);
                        //指定栏目新增文章渲染自定义模型
                    }else {
                        this.changeModel(this.categoryId);
                    }
                    //不指定栏目编辑文章
                }else if (this.form.id) {
                    this.get(this.form.id);
                }//else 如果即不指定栏目新增文章，又不是编辑文章就不渲染自定义模型

                setTimeout(()=>{
                    //显示编辑器
                    that.editorHiden = false;
                },200)
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
<style scoped>
    .el-select {
        width: 100%;
    }

    body {
        overflow: hidden;
    }

    #form {
        overflow: hidden;
        width: 100%;
    }
    .el-scrollbar__bar.is-vertical{
        width: 6px!important;
    }
    #form >>> .el-tabs__item {
        background-color: unset;
    }
    /** 解决上传组件点击冒泡，因为图片是镂空的 **/
    :deep(.el-icon--zoom-in),:deep(.el-icon--delete)  {
        background-color: rgba(0, 0, 0, 0.167);
    }
</style>
