<!-- 素材库 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/material-bank-form.css">
<div id="material-bank-form" class="material-bank-form">
    <el-dialog title="选择图片" :visible.sync="isShow" custom-class='ms-weixin-dialog'>
        <el-tabs tab-position="left">
            <el-tab-pane :label="group.label+'(2)'" v-for='(group,index) of materialGroup' :key='index'>
                <el-upload :file-list='fileList' action="" list-type="picture-card" :on-preview="handlePictureCardPreview"
                    :on-remove="handleRemove">
                    <i class="el-icon-plus"></i>
                </el-upload>
                <el-dialog :visible.sync="dialogVisible">
                    <img width="100%" :src="dialogImageUrl" alt="">
                </el-dialog>
            </el-tab-pane>
        </el-tabs>
    </el-dialog>

</div>
<script>
    var materialBankFormVue = new Vue({
        el: '#material-bank-form',
        data: {
            isShow: false,
            materialGroup: [{
                    label: '未分组',
                },
                {
                    label: '云创',
                },
                {
                    label: 'PM管理',
                },
            ],
            fileList: [], //文件列表
            dialogImageUrl: '',
            dialogVisible: false
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
            handlePictureCardPreview:function(){

            },
            handleRemove:function(){

            }
        }
    })
</script>