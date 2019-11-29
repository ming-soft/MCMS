<!DOCTYPE html>
<html>
<head>
	 <title>分类</title>
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
            <el-form-item  label="栏目管理名称" prop="categoryTitle">
                <el-input v-model="form.categoryTitle"
                          :disabled="false"
                          :style="{width:  '100%'}"
                          :clearable="true"
                          placeholder="请输入栏目管理名称">
                </el-input>
            </el-form-item>
                                </el-col>
                                <el-col span="12">
            <el-form-item  label="所属栏目" prop="categoryId">
            <tree-select :props="{value: 'id',label: 'categoryTitle',children: 'children'}"
                         :options="treeList" :style="{width:'100%'}"
                         v-model="form.categoryId"></tree-select>
            </el-form-item>
                                </el-col>
                        </el-row>
                        <el-row
                                gutter="0"
                                justify="start" align="top">
                                <el-col span="12">
            <el-form-item  label="栏目管理属性" prop="categoryType">
                    <el-radio-group v-model="form.categoryType"
                                    :style="{width: ''}"
                                    :disabled="false">
                        <el-radio :style="{display: true ? 'inline-block' : 'block'}" :label="item.value"
                                  v-for='(item, index) in categoryTypeOptions' :key="item.value + index">
                            {{true? item.label : item.value}}
                        </el-radio>
                    </el-radio-group>
            </el-form-item>
                                </el-col>
                                <el-col span="12">
            <el-form-item  label="自定义顺序" prop="categorySort">
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
                                    <el-form-item  :label="form.categoryType =='1'? '内容模板' : '封面模板'" prop="categoryUrl">
                                        <el-select v-model="form.categoryUrl"
                                                   :style="{width: '100%'}"
                                                   :filterable="false"
                                                   :disabled="false"
                                                   :multiple="false" :clearable="true"
                                                   placeholder="请选择内容模板">
                                            <el-option v-for='item in categoryUrlOptions' :key="item" :value="item"
                                                       :label="item"></el-option>
                                        </el-select>
                                    </el-form-item>
                                </el-col>
                                <el-col span="12">
                                    <el-form-item  label="列表模板" prop="categoryListUrl" v-if="form.categoryType == '1'">
                                        <el-select v-model="form.categoryListUrl"
                                                   :style="{width: '100%'}"
                                                   :filterable="false"
                                                   :disabled="false"
                                                   :multiple="false" :clearable="true"
                                                   placeholder="请选择列表模板">
                                            <el-option v-for='item in categoryListUrlOptions' :key="item" :value="item"
                                                       :label="item"></el-option>
                                        </el-select>
                                    </el-form-item>
                                </el-col>
                        </el-row>
            <el-form-item  label="栏目管理关键字" prop="categoryKeyword">
                <el-input
                        type="textarea" :rows="5"
                        :disabled="false"

                        v-model="form.categoryKeyword"
                        :style="{width: '100%'}"
                        placeholder="栏目管理关键字，有助于搜索">
                </el-input>
            </el-form-item>
            <el-form-item  label="栏目管理描述" prop="categoryDescrip">
                <el-input
                        type="textarea" :rows="5"
                        :disabled="false"

                        v-model="form.categoryDescrip"
                        :style="{width: '100%'}"
                        placeholder="栏目管理描述，对栏目管理关键字的扩展">
                </el-input>
            </el-form-item>
            <el-form-item  label="" prop="categoryImg">
                <template slot='label'>缩略图
                    <el-popover slot="label" placement="top-start" title="提示" width="200" trigger="hover" content="提示：栏目缩略图,最多可上传1张">
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
                    :data="{uploadPath:'/cms/category','isRename':true}"
                    :on-success="categoryImgSuccess"
                    accept="image/*"
                    list-type="picture-card">
                <i class="el-icon-plus"></i>
                <div slot="tip" class="el-upload__tip">最多上传1张图片</div>
            </el-upload>
            </el-form-item>
            <el-form-item  label="自定义链接" prop="categoryDiyUrl">
                <el-input
                        type="textarea" :rows="5"
                        :disabled="false"

                        v-model="form.categoryDiyUrl"
                        :style="{width: '100%'}"
                        placeholder="请输入自定义链接">
                </el-input>
            </el-form-item>
            <el-form-item  label="栏目管理的内容模型id" prop="mdiyModelId">
                    <el-select v-model="form.mdiyModelId"
                               :style="{width: '100%'}"
                               :filterable="false"
                               :disabled="false"
                               :multiple="false" :clearable="true"
                               placeholder="请选择栏目管理的内容模型id">
                        <el-option v-for='item in mdiyModelIdOptions' :key="item.value" :value="item.value"
                                   :label="false?item.label:item.value"></el-option>
                    </el-select>
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
                treeList:[],
                saveDisabled: false,
                //表单数据
                form: {
                    // 栏目管理名称
                    categoryTitle:'',
                    // 所属栏目
                    categoryId:'',
                    // 栏目管理属性
                    categoryType:'1',
                    // 自定义顺序
                    categorySort:0,
                    // 列表模板
                    categoryListUrl:'',
                    // 内容模板
                    categoryUrl:'',
                    // 栏目管理关键字
                    categoryKeyword:'',
                    // 栏目管理描述
                    categoryDescrip:'',
                    // 缩略图
                    categoryImg: [],
                    // 自定义链接
                    categoryDiyUrl:'',
                    // 栏目管理的内容模型id
                    mdiyModelId:'',
                },
                categoryTypeOptions:[{"value":"1","label":"列表"},{"value":"2","label":"封面"}],
                categoryListUrlOptions:[],
                categoryUrlOptions:[],
                mdiyModelIdOptions:[],
                rules:{
                // 栏目管理名称
                categoryTitle: [{"required":true,"message":"请选择栏目管理名称"},{"pattern":/^[^[!@#$%^&*()_+-/~?！@#￥%…&*（）——+—？》《：“‘’]+$/,"message":"栏目管理名称格式不匹配"}],
                },

            }
        },
        watch:{
        },
        computed:{
        },
        methods: {
            getTree(){
                var that = this;
                ms.http.get(ms.manager+"/cms/category/list.do",{pageSize:9999}).then(function(res){
                    if(res.result){
                        //res.data.rows.push({id:0,categoryId: null,categoryTitle:'顶级栏目管理'});
                        that.treeList = ms.util.treeData(res.data.rows,'id','categoryId','children');
                    }
                }).catch(function(err){
                    console.log(err);
                });
            },
            save() {
                var that = this;
                var url = ms.manager + "/cms/category/save.do"
                if (that.form.id > 0) {
                    url = ms.manager + "/cms/category/update.do";
                }
                this.$refs.form.validate((valid) => {
                    if (valid) {
                        //栏目属性为封面则不需要列表模板
                        if(that.form.categoryType == '2'){
                            that.form.categoryListUrl = '';
                        }
                        that.saveDisabled = true;
                        var data = JSON.parse(JSON.stringify(that.form));
                        if(data.id&&data.id==data.categoryId){
                            that.$message.error('所属栏目不能为自身')
                            that.saveDisabled = false;
                            return
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
                })
            },

            //获取当前分类
            get(id) {
                var that = this;
                ms.http.get(ms.manager + "/cms/category/get.do", {"id":id}).then(function (res) {
                    if(res.result&&res.data){
                    if(res.data.categoryImg){
                        res.data.categoryImg = JSON.parse(res.data.categoryImg);
                        res.data.categoryImg.forEach(function(value){
                        value.url= ms.base + value.path
                        })
                    }else{
                        res.data.categoryImg=[]
                    }
                        that.form = res.data;
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取categoryListUrl数据源
            categoryListUrlOptionsGet() {
                var that = this;
                ms.http.get(ms.manager+"/template/queryTemplateFileForColumn.do", {}).then(function (data) {
                    that.categoryListUrlOptions = data;
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //获取categoryUrl数据源
            categoryUrlOptionsGet() {
                var that = this;
                ms.http.get(ms.manager+"/template/queryTemplateFileForColumn.do", {}).then(function (data) {
                    that.categoryUrlOptions = data;
                }).catch(function (err) {
                    console.log(err);
                });
            },
            //categoryImg文件上传完成回调
            categoryImgSuccess:function(response, file, fileList) {
                this.form.categoryImg.push({url:file.url,name:file.name,path:response,uid:file.uid});
            },
            categoryImghandleRemove:function(file, files) {
                var index = -1;
                index = this.form.categoryImg.findIndex(text => text == file);
                if (index != -1) {
                    this.form.categoryImg.splice(index, 1);
                }
            },
            //categoryImg文件上传完成回调
            categoryImgSuccess:function(response, file, fileList) {
                this.form.categoryImg.push({url:file.url,name:file.name,path:response,uid:file.uid});
            },
            //上传超过限制
            categoryImghandleExceed:function(files, fileList) {
                this.$notify({ title: '当前最多上传1个文件', type: 'warning' });
            },
            categoryImghandleRemove:function(file, files) {
                var index = -1;
                index = this.form.categoryImg.findIndex(text => text == file);
                if (index != -1) {
                    this.form.categoryImg.splice(index, 1);
                }
            },
        },
        created() {
            this.getTree()
            this.categoryListUrlOptionsGet();
            this.categoryUrlOptionsGet();
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