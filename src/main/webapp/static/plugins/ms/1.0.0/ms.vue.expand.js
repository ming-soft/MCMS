/**
 * vue 扩展属性方法
 * 表格中的数字需要格式化金钱类型或百分数
 */
(function() {
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
