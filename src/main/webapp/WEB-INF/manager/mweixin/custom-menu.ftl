<!-- 自定义菜单 -->
<!DOCTYPE html>
<html lang="">
<head>
    <title></title>
    <!-- <#include "/include/head-file.ftl"/> -->
    <!--#include virtual="../include/head-file.ftl" --> 
</head>
<body>
    <div id="custom-menu" class="ms-custom-menu">
        <el-container class="ms-custom-container">
            <el-aside>
                <el-container>
                    <el-header>公众号</el-header>
                    <el-main></el-main>
                    <el-footer>
                        <el-button icon="el-icon-date"></el-button>
                        <div class="ms-create-menu">
                            <el-dropdown placement='top' :hide-on-click='false'>
                                <el-button type="primary">新建菜单</el-button>
                                <el-dropdown-menu slot="dropdown">
                                    <el-dropdown-item>
                                        <el-button type="text" icon='el-icon-plus'></el-button>
                                    </el-dropdown-item>
                                </el-dropdown-menu>
                            </el-dropdown>
                            <el-button icon="el-icon-plus"></el-button>
                        </div>
                    </el-footer>
            </el-aside>
            <el-main>
                <el-card class="custom-menu-card" shadow="never">
                    <div slot="header" class="clearfix">
                        <span>新建菜单</span>
                    </div>
                    <el-form ref="customMenuForm" :rule='customMenuFormRules' :model="customMenuForm" label-width="80px">
                        <el-form-item label="菜单名称" prop='name' class="ms-custom-menu-name">
                            <el-input v-model="customMenuForm.name" size='mini'></el-input>
                            <span>菜单名称字数不多于5个汉字或10个字母</span>
                        </el-form-item>
                        <el-form-item label="菜单内容" prop='content'>
                            <el-input v-model="customMenuForm.content"></el-input>
                            <el-tabs v-model="activeName" @tab-click="handleClick">
                                <el-tab-pane label="图片" name="first">
                                    <span slot="label"><i class="el-icon-picture"></i>图片</span>
                                    <el-upload action="https://jsonplaceholder.typicode.com/posts/" list-type="picture-card"
                                        :on-preview="handlePictureCardPreview" :on-remove="handleRemove">
                                        <i class="el-icon-plus"></i>
                                    </el-upload>
                                    <el-dialog :visible.sync="dialogVisible">
                                        <img width="100%" :src="dialogImageUrl" alt="">
                                    </el-dialog>
                                    <el-upload action="https://jsonplaceholder.typicode.com/posts/" list-type="picture-card"
                                        :on-preview="handlePictureCardPreview" :on-remove="handleRemove">
                                        <i class="el-icon-plus"></i>
                                    </el-upload>
                                    <el-dialog :visible.sync="dialogVisible">
                                        <img width="100%" :src="dialogImageUrl" alt="">
                                    </el-dialog>
                                </el-tab-pane>
                                <el-tab-pane label="图文管理" name="second">
                                    <span slot="label"><i class="el-icon-picture"></i>图文管理</span>
                                </el-tab-pane>
                            </el-tabs>
                        </el-form-item>
                    </el-form>
                </el-card>
            </el-main>
        </el-container>
    </div>
</body>

</html>
<script>
    var customMenuVue = new Vue({
        el: "#custom-menu",
        data: {
            customMenuForm: {
                name: '',
                content: "",
            },
            customMenuFormRules: {
                name: [{
                        required: true,
                        message: '请输入菜单名称',
                        trigger: 'blur'
                    },
                    {
                        min: 1,
                        max: 5,
                        message: '长度在 1 到 5 个字符',
                        trigger: 'blur'
                    }
                ],
                // content:[{ required: true, message: '请输入菜单名称', trigger: 'blur' },
                //      { min: 1, max: 5, message: '长度在 1 到 5 个字符', trigger: 'blur' }]
            },
            dialogImageUrl: '',
            dialogVisible: false,
            activeName: 'first'
        },
        methods: {
            handleRemove(file, fileList) {
                console.log(file, fileList);
            },
            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            handleClick(tab, event) {
                console.log(tab, event);
            }
        }

    })
</script>