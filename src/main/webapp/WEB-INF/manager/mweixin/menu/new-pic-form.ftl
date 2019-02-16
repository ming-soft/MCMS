<!-- 新建图片表单 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/new-pic-form.css">
<div id='new-pic-form' v-show='isShow' class="new-pic-form">
    <el-dialog title="选择图片" :visible.sync="isShow" custom-class='ms-weixin-dialog'>
        <el-form :model="newPicForm">
            <el-form-item label="上传图片" label-width="100px">
                <el-upload class="new-pic-upload" :on-preview="handlePreview" :on-remove="handleRemove" :file-list="picList"
                    list-type="picture">
                    <el-button size="small" type="primary">本地上传</el-button>
                    <div slot="tip" class="el-upload__tip">
                        <dl>
                            <dt>注意：1.图片上传仅支持bmp、png、jpeg、jpg、gif格式</dt>
                            <dd>2.同步至微信公众平台的图片最大2M,存在铭飞本地，最大支持5M的图片</dd>
                        </dl>
                    </div>
                </el-upload>
            </el-form-item>
            <el-form-item label="选择分组" label-width="100px">
                <el-popover placement="top-start" width="350" trigger="click" v-model='popoverShow'>
                    <el-form label-width="81px" :model="groupForm" ref="groupForm" :rules='groupRule'>
                        <el-form-item label="创建分组" prop='name'>
                            <el-input v-model="groupForm.name" size='mini'></el-input>
                        </el-form-item>
                        <div class="dialog-footer" style="float:right">
                            <el-button @click="cancel" size='mini'>取消</el-button>
                            <el-button type="primary" @click="saveGroup" size='mini'>确定</el-button>
                        </div>
                    </el-form>
                    <el-button slot="reference" icon='el-icon-plus' size='mini'>添加分组</el-button>
                </el-popover>
                <el-select v-model="selectedOption" placeholder="请选择分组" size='mini'>
                    <el-option v-for="item in picGroup" :key="item.value" :label="item.label" :value="item.value">
                    </el-option>
                </el-select>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="isShow = false" size='mini'>取 消</el-button>
            <el-button type="primary" @click="isShow = false" size='mini'>确 定</el-button>
        </div>
    </el-dialog>
</div>
<script>
    var newPicFormVue = new Vue({
        el: '#new-pic-form',
        data: {
            isShow: false,
            newPicForm: {

            },
            picGroup: [{
                    value: 'default',
                    label: '默认分组'
                }, {
                    value: 'yun',
                    label: '云创'
                },
                {
                    value: 'pm',
                    label: 'PM管理系统'
                }
            ],
            selectedOption: '', //被选中的选项
            picList: [], //图片列表
            popoverShow: false,
            groupForm: { //创建分组
                name: ''
            },
            // 规则
            groupRule: {
                name: [{
                        required: true,
                        message: '请输入分组名称',
                        trigger: ['blur', 'change']
                    },
                    {
                        min: 1,
                        max: 5,
                        message: '长度在 1 到 5 个字符',
                        trigger: ['blur', 'change']
                    }
                ]
            }
        },
        methods: {
            // 表单打开
            open: function () {
                this.isShow = true;
            },
            // 图片刚加载完
            handlePreview: function () {

            },
            // 图片删除
            handleRemove: function () {

            },
            saveGroup: function () {
                var that = this;
                that.$refs.groupForm.validate(function (pass, object) {
                    if (pass) {
                        // 校验成功
                    }
                })
            },
            cancel: function () {
                this.popoverShow = false
                this.$refs.groupForm.resetFields()
            },

        },
    })
</script>