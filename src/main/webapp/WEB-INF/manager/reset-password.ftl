<!-- 修改密码 -->
<div id="reset-password" class="reset-password">
        <el-dialog title="修改密码" :visible.sync="isShow">
            <el-form :model="resetPasswordForm" label-width='80px'>
                <el-form-item label="账号">
                    <el-input v-model="resetPasswordForm.managerName" autocomplete="off" readonly disabled></el-input>
                </el-form-item>
                <el-form-item label="旧密码">
                    <el-input v-model="resetPasswordForm.oldManagerPassword" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="新密码">
                    <el-input v-model="resetPasswordForm.newManagerPassword" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="isShow = false">取 消</el-button>
                <el-button type="primary" @click="updatePassword">更新密码</el-button>
            </div>
    </el-dialog>
</div>
<script>
    var resetPasswordVue = new Vue({
        el: '#reset-password',
        data: {
            // 模态框的显示
            isShow: false,
            resetPasswordForm: {
                managerName: '',
                oldManagerPassword: '',
                newManagerPassword: '',
            }
        },
        methods: {
            // 更新密码
            updatePassword: function () {
            	var that = this;
            	ms.http.post(ms.manager + "/updatePassword.do",that.resetPasswordForm)
               .then((data)=>{
                	that.resetPasswordForm.oldManagerPassword = '';
                	that.resetPasswordForm.newManagerPassword = '';
                	that.isShow = false;
               }, (err) => {
                   that.$message.error(err);
               })	
            }
        }
    })
</script>