<!-- 关键字列表 -->
<!DOCTYPE html>
<html lang="">
<head>
    <title></title>
    <!-- <#include "/include/head-file.ftl"/> -->
    <!--#include virtual="../include/head-file.ftl" -->
    <link rel="stylesheet" href="../../../static/mweixin/css/keyword-list.css">
    <!-- <link rel="stylesheet" href="${base}/static/mweixin/css/keyword-list.css"> -->
</head>

<body>
    <div id="keyword-list" class="keyword-list ms-container">
        <el-table :data="tableData" border style="width: 100%">
            <el-table-column prop="date" label="规则名" width="180" align='center'>
            </el-table-column>
            <el-table-column prop="name" label="关键词" width="180" align='center'>
            </el-table-column>
            <el-table-column prop="address" label="消息回复类型" align='center'>
            </el-table-column>
            <el-table-column prop="address" label="发送对象" align='center'>
            </el-table-column>
            <el-table-column prop="address" label="回复方式" align='center'>
            </el-table-column>
        </el-table>
    </div>
</body>

</html>
<script>
    var keywordListVue = new Vue({
        el: '#keyword-list',
        data: {
            tableData: [{
                date: '2016-05-02',
                name: '王小虎',
                address: '上海市普陀区金沙江路 1518 弄'
            }, {
                date: '2016-05-04',
                name: '王小虎',
                address: '上海市普陀区金沙江路 1517 弄'
            }, {
                date: '2016-05-01',
                name: '王小虎',
                address: '上海市普陀区金沙江路 1519 弄'
            }, {
                date: '2016-05-03',
                name: '王小虎',
                address: '上海市普陀区金沙江路 1516 弄'
            }]
        },
        methods:{
            // 获取关键词列表
            list:function(){
                
            }
        }
    })
</script>