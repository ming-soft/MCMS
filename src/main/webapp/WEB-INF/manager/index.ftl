<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://unpkg.com/vue@next"></script>
    <!-- import CSS -->
    <link rel="stylesheet" href="https://unpkg.com/element-plus/dist/index.css">
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-plus"></script>

</head>
<body>
<div id="app">


    <el-table :data="tableData" style="width: 100%">
        <el-table-column fixed prop="date" label="Date" width="150" > </el-table-column>
        <el-table-column prop="name" label="Name" width="120" > </el-table-column>
        <el-table-column prop="state" label="State" width="120" > </el-table-column>
        <el-table-column prop="city" label="City" width="120" > </el-table-column>
        <el-table-column prop="address" label="Address" width="600" > </el-table-column>
        <el-table-column prop="zip" label="Zip" width="120" > </el-table-column>
        <el-table-column fixed="right" label="Operations" width="120">

        </el-table-column>
    </el-table>
    <el-button type="text" @click="visible = true"
    >click to open the Dialog</el-button
    >

    <el-dialog
            v-model="visible"
            title="Tips"
            width="30%"
    >
        <span>This is a message</span>

        <template #footer>
      <span class="dialog-footer">
        <el-button @click="visible = false">Cancel</el-button>
        <el-button type="primary" @click="visible = false"
        >Confirm</el-button
        >
      </span>
        </template>
    </el-dialog>
</div>
</body>
<script>
    var app = Vue.createApp({
        data: function() {
            return {
                visible: false,
                tableData: [
                    {
                        date: '2016-05-03',
                        name: 'Tom',
                        state: 'California',
                        city: 'Los Angeles',
                        address: 'No. 189, Grove St, Los Angeles',
                        zip: 'CA 90036',
                        tag: 'Home',
                    },
                    {
                        date: '2016-05-02',
                        name: 'Tom',
                        state: 'California',
                        city: 'Los Angeles',
                        address: 'No. 189, Grove St, Los Angeles',
                        zip: 'CA 90036',
                        tag: 'Office',
                    },
                    {
                        date: '2016-05-04',
                        name: 'Tom',
                        state: 'California',
                        city: 'Los Angeles',
                        address: 'No. 189, Grove St, Los Angeles',
                        zip: 'CA 90036',
                        tag: 'Home',
                    },
                    {
                        date: '2016-05-01',
                        name: 'Tom',
                        state: 'California',
                        city: 'Los Angeles',
                        address: 'No. 189, Grove St, Los Angeles',
                        zip: 'CA 90036',
                        tag: 'Office',
                    },
                ]
            }
        }
    });
    app.use(ElementPlus).mount("#app");
</script>
</html>
