<!DOCTYPE html>
<html>
<head>
	 <title>文章</title>
        <#include "../../include/head-file.ftl">
</head>
<body>
	<div id="form" v-cloak>
		<el-header class="ms-header ms-tr" height="50px">
			<el-button type="primary" icon="iconfont icon-baocun" size="mini" @click="save()" :loading="saveDisabled">保存</el-button>
			<el-button size="mini" icon="iconfont icon-fanhui" plain onclick="javascript:history.go(-1)">返回</el-button>
		</el-header>
		<el-main class="ms-container">
            <el-form ref="form" :model="form" :rules="rules" label-width="120px" size="mini">
                        <el-row
                                gutter="0"
                                justify="start" align="top">
                                <el-col span="12">
            <el-form-item  label="文章标题" prop="contentTitle">
                <el-input v-model="form.contentTitle"
                          :disabled="false"
                          :style="{width:  '100%'}"
                          :clearable="true"
                          placeholder="请输入文章标题">
                </el-input>
            </el-form-item>
                                </el-col>
                                <el-col span="12">
            <el-form-item  label="所属栏目" prop="contentCategoryId">
                <tree-select :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                             :options="contentCategoryIdOptions" :style="{width:'100%'}"
                             v-model="form.contentCategoryId"></tree-select>
            </el-form-item>
                                </el-col>
                        </el-row>
                        <el-row
                                gutter="0"
                                justify="start" align="top">
                                <el-col span="12">
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
                                <el-col span="12">
                                    <el-form-item  label="发布时间" prop="contentDatetime">
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
            <el-form-item  label="文章作者" prop="contentAuthor">
                <el-input v-model="form.contentAuthor"
                          :disabled="false"
                          :style="{width:  '100%'}"
                          :clearable="true"
                          placeholder="请输入文章作者">
                </el-input>
            </el-form-item>
                                </el-col>
                                <el-col span="12">
            <el-form-item  label="文章来源" prop="contentSource">
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
                                    <el-form-item  label="" prop="contentDisplay">
                                        <template slot='label'>是否显示
                                            <el-popover slot="label" placement="top-start" title="提示" width="200" trigger="hover" content="选择否后前端将不显示，需要重新生成才有效果">
                                                <i class="el-icon-question" slot="reference"></i>
                                            </el-popover>
                                        </template>
                                        <el-radio-group v-model="form.contentDisplay"
                                                        :style="{width: ''}"
                                                        :disabled="false">
                                            <el-radio :style="{display: true ? 'inline-block' : 'block'}" :label="item.value"
                                                      v-for='(item, index) in contentDisplayOptions' :key="item.value + index">
                                                {{true? item.label : item.value}}
                                            </el-radio>
                                        </el-radio-group>
                                    </el-form-item>
                                </el-col>
                                <el-col span="12">
            <el-form-item  label="自定义顺序" prop="contentSort">
                <el-input-number
                        v-model="form.contentSort"
                        :disabled="false"
                        controls-position="">
                </el-input-number>
            </el-form-item>
                                </el-col>
                        </el-row>
            <el-form-item  label="" prop="contentImg">
                <template slot='label'>文章缩略图
                    <el-popover slot="label" placement="top-start" title="提示" width="200" trigger="hover" content="文章缩略图,支持jpg格式">
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
                    :data="{uploadPath:'/cms/content','isRename':true}"
                    :on-success="contentImgSuccess"
                    accept="image/*"
                    list-type="picture-card">
                <i class="el-icon-plus"></i>
                <div slot="tip" class="el-upload__tip">最多上传1张图片</div>
            </el-upload>
            </el-form-item>
            <el-form-item  label="描述" prop="contentDescription">
                <el-input
                        type="textarea" :rows="5"
                        :disabled="false"

                        v-model="form.contentDescription"
                        :style="{width: '100%'}"
                        placeholder="请输入对该文章的简短描述，以便用户查看文章简略">
                </el-input>
            </el-form-item>
            <el-form-item  label="关键字" prop="contentKeyword">
                <el-input
                        type="textarea" :rows="5"
                        :disabled="false"

                        v-model="form.contentKeyword"
                        :style="{width: '100%'}"
                        placeholder="请输入文章关键字">
                </el-input>
            </el-form-item>
            <el-form-item  label="文章内容" prop="contentDetails">
            <vue-ueditor-wrap style="line-height: 0px" v-model="form.contentDetails" :config="editorConfig"></vue-ueditor-wrap>
            </el-form-item>
            </el-form>
		</el-main>
	</div>
	</body>
	</html>
<script>
        var form = new Vue({
        el: '#form',
        data() {
            return {
                date1574910623000_52656:null,
                saveDisabled: false,
                editorConfig:{
                    imageScaleEnabled :true,
                    autoHeightEnabled: true,
                    autoFloatEnabled: false,
                    scaleEnabled: true,
                    compressSide:0,
                    maxImageSideLength:1000,
                    maximumWords: 2000,
                    initialFrameWidth: '100%',
                    initialFrameHeight: 400,
                    serverUrl:  ms.base+"/static/plugins/ueditor/1.4.3.1/jsp/editor.do?jsonConfig=%7BvideoUrlPrefix:\'"+ms.base+"\',fileUrlPrefix:\'"+ms.base+"\',imageUrlPrefix:\'"+ms.base+"\',imagePathFormat:\'/upload/cms/content/editor/%7Btime%7D\',filePathFormat:\'/upload/cms/content/editor/%7Btime%7D\',videoPathFormat:\'/upload/cms/content/editor/%7Btime%7D\'%7D",
                    UEDITOR_HOME_URL: ms.base+'/static/plugins/ueditor/1.4.3.1/'
                },
                contentCategoryIdOptions:[],
                //表单数据
                form: {
                    // 文章标题
                    contentTitle:'',
                    // 所属栏目
                    contentCategoryId: '',
                    // 文章类型
                    contentType: [],
                    // 是否显示
                    contentDisplay:'0',
                    // 文章作者
                    contentAuthor:'',
                    // 文章来源
                    contentSource:'',
                    // 自定义顺序
                    contentSort:0,
                    // 文章缩略图
                    contentImg: [],
                    // 描述
                    contentDescription:'',
                    // 关键字
                    contentKeyword:'',
                    // 文章内容
                    contentDetails:'',
                },
                contentTypeOptions:[],
                contentDisplayOptions:[{"value":"0","label":"是"},{"value":"1","label":"否"}],
                rules:{
                // 文章标题
                contentTitle: [{"required":true,"message":"请选择文章标题"}],
                // 发布时间
                contentDatetime: [{"required":true,"message":"发布时间不能为空"}],
                },

            }
        },
        watch:{
        },
        methods: {
            save() {
                var that = this;
                var url = ms.manager + "/cms/content/save.do"
                if (that.form.id > 0) {
                    url = ms.manager + "/cms/content/update.do";
                }
                this.$refs.form.validate((valid) => {
                    if (valid) {
                        that.saveDisabled = true;
                        var data = JSON.parse(JSON.stringify(that.form));
                        data.contentType = data.contentType.join(',');
                        data.contentImg = JSON.stringify(data.contentImg);
                        ms.http.post(url, data).then(function (data) {
                            if (data.result) {
                                that.$notify({
                                    title: '成功',
                                    message: '保存成功',
                                    type: 'success'
                                });
                                location.href = ms.manager + "/cms/content/main.do";
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
                })
            },
            getValue(data){
                this.form.contentCategoryId = data.id;
            },
            //获取当前文章
            get(id) {
                var that = this;
                ms.http.get(ms.manager + "/cms/content/get.do", {"id":id}).then(function (res) {
                    if(res.result&&res.data){
                        if(res.data.contentType){
                            res.data.contentType = res.data.contentType.split(',');
                        }
                    if(res.data.contentImg){
                        res.data.contentImg = JSON.parse(res.data.contentImg);
                        res.data.contentImg.forEach(function(value){
                        value.url= ms.base + value.path
                        })
                    }else{
                        res.data.contentImg=[]
                    }
                        that.form = res.data;
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取contentCategoryId数据源
            contentCategoryIdOptionsGet() {
                var that = this;
                ms.http.get(ms.manager+"/cms/category/list.do",{pageSize:9999}).then(function(res){
                    if(res.result){
                        that.contentCategoryIdOptions = ms.util.treeData(res.data.rows,'id','categoryId','children');
                    }
                }).catch(function(err){
                    console.log(err);
                });
            },
            //获取contentType数据源
            contentTypeOptionsGet() {
                    var that = this;
                    ms.http.get(ms.base+'/mdiy/dict/list.do', {dictType:'文章属性',pageSize:99999}).then(function (data) {
                        that.contentTypeOptions = data.rows;
                    }).catch(function (err) {
                        console.log(err);
                    });
                },
            //contentImg文件上传完成回调
            contentImgSuccess:function(response, file, fileList) {
                this.form.contentImg.push({url:file.url,name:file.name,path:response,uid:file.uid});
            },
            contentImghandleRemove:function(file, files) {
                var index = -1;
                index = this.form.contentImg.findIndex(text => text == file);
                if (index != -1) {
                    this.form.contentImg.splice(index, 1);
                }
            },
            //contentImg文件上传完成回调
            contentImgSuccess:function(response, file, fileList) {
                this.form.contentImg.push({url:file.url,name:file.name,path:response,uid:file.uid});
            },
            //上传超过限制
            contentImghandleExceed:function(files, fileList) {
                this.$notify({ title: '当前最多上传1个文件', type: 'warning' });
            },
            contentImghandleRemove:function(file, files) {
                var index = -1;
                index = this.form.contentImg.findIndex(text => text == file);
                if (index != -1) {
                    this.form.contentImg.splice(index, 1);
                }
            },
        },
        created() {
            this.contentCategoryIdOptionsGet();
                this.contentTypeOptionsGet();
            this.form.id = ms.util.getParameter("id");
            if (this.form.id) {
                this.get(this.form.id);
            }
        }
    });
</script>
<style>
    .el-select{
        width: 100%;
    }
</style>