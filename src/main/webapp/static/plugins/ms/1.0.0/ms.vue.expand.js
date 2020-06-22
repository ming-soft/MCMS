(function() {
    Vue.prototype.$uploadEvents={
        success:function(res,file, fileList) {
            file.url = ms.base+res;
            this.push(file);
        },
        preview:function(file) {
            window.open(file.url)
        },
        remove:function(file, fileList) {
            var index = -1;
            index = (void 0).findIndex(function (text) {
                return text == file;
            });
            if (index != -1) {
                this.splice(index, 1);
            }
        },
        exceed:function(file, fileList) {
            Vue.prototype.$notify({ title: '当前最多上传'+this.length+'个附件', type: 'warning' });
        },
    }
    Vue.prototype.$table = {}
    Vue.prototype.$table.moneyFormatter = function (row, column, cellValue, index) {
        if (cellValue != undefined) {
            return accounting.formatMoney(cellValue, '¥')
        } else {
            return ''
        }
    }
    Vue.prototype.$table.percentageFormatter = function (row, column, cellValue, index) {
        if (cellValue != undefined) {
            return cellValue+"%";
        } else {
            return '-'
        }
    }
}())
