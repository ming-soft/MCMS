<!-- 退出系统 -->
<div id="exit-system" class="exit-system">
    <el-dialog title="退出提示" :visible.sync="isShow">
        确认退出
        <div slot="footer" class="dialog-footer">
            <el-button @click="isShow = false">取 消</el-button>
            <el-button type="primary" @click="loginOut">确认退出</el-button>
        </div>
    </el-dialog>
</div>
<script>
    var exitSystemVue = new Vue({
        el: '#exit-system',
        data: {
            isShow: false, // 模态框的显示
        },
        methods: {
            loginOut: function () {
                var that = this;
                ms.http.get(ms.manager + "/loginOut.do")
                    .then((data) => {
                        isShow = false;
                        location.href = ms.manager + "/login.do";
                    }, (err) => {
                        that.$message.error(data.resultMsg);
                    })
            }
        }
    })
</script>