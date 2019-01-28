<!-- 素材库 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/material-bank-form.css">
<div id="material-bank-form" class="material-bank-form">
    <el-dialog title="选择图片" :visible.sync="isShow" custom-class='ms-weixin-dialog'>
        <el-tabs tab-position="left">
            <el-tab-pane :label="group.label + '('+group.total+')'" v-for='(group,index) of materialGroup' :key='index'>
                <el-upload :file-list='fileList' action="" list-type="picture-card" :on-preview="handlePictureCardPreview"
                    :on-remove="handleRemove">
                    <i class="el-icon-plus"></i>
                </el-upload>
                <el-dialog :visible.sync="dialogVisible" :modal='false' :title='flieName' custom-class='ms-weixin-dialog'>
                    <!-- 这是图片放大 -->
                    <img width="100%" :src="dialogImageUrl" alt="">
                </el-dialog>
                <el-row type='flex' justify='end'>
                    <el-col :span='11'>
                            <el-pagination 
                            @size-change="handleSizeChange" 
                            background
                            :pager-count="1"
                            @current-change="handleCurrentChange" 
                            :current-page.sync="currentPage" 
                            :page-size="10" 
                            layout="prev, pager, next, jumper" 
                            :total="50">
                        </el-pagination>
                    </el-col>
                </el-row>
            </el-tab-pane>
        </el-tabs>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="isShow = false" size='mini'>确 定</el-button>
            <el-button @click="isShow = false" size='mini'>取 消</el-button>
        </div>
    </el-dialog>
</div>
<script>
    var materialBankFormVue = new Vue({
        el: '#material-bank-form',
        data: {
            isShow: false,
            materialGroup: [{
                    label: '未分组',
                    total:36,
                },
                {
                    label: '云创',
                    total:12,
                },
                {
                    label: 'PM管理',
                    total:16,
                },
            ],
            fileList: [], //文件列表
            dialogImageUrl: '',//点击放大，触发弹窗里面的图片地址
            dialogVisible: false,
            flieName:"",//放大图片的文件名
            currentPage:'',//当前页数
        },
        watch:{
            fileList:{
                handler:function(n,o){
                    console.log('文件列表',n);
            },
                deep:true
            }
        },
        methods: {
            // 表单打开
            open: function () {
                this.isShow = true;
            },
            handlePictureCardPreview:function(file){
                // 点击预览大图触发的钩子函数
                console.log('file',file);
                this.dialogVisible = true;
                this.dialogImageUrl = file.url
                this.flieName = file.name
            },
            handleRemove:function(){

            },
            handleSizeChange:function(){

            },
            handleCurrentChange:function(){

            }
        }
    })
</script>