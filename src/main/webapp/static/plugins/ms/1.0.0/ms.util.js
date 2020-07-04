/**
 * 通用工具方法
 */
(function() {

    /**
     * 地址栏获取参数
     * @param name 参数名称
     * @return {*}
     */
    function getParameter(name) {
        try {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) {
                return decodeURI(r[2]);
            }
            return null;
        } catch (e) {
            log(e.message);
        }
    }

    /**
     * 列表数据转化为树形结构的列表
     * @param source 数据源list
     * @param id 编号
     * @param parentId 父级编号
     * @param children 树形子集变量
     * @returns {*}
     * 支持父级编号为 0或null
     * 原始数据[{id:1,titile:"标题",pid:0},{id:2,titile:"标题",pid:1}]
     * 转化树形数据：[{id:1,titile:"标题",pid:0,children:[{id:2,titile:"标题",pid:1}]}]
     */
    function treeData(source, id, parentId, children) {
        var cloneData = JSON.parse(JSON.stringify(source));
        return cloneData.filter(function (father) {
            var branchArr = cloneData.filter(function (child) {
                return father[id] == child[parentId];
            });
            branchArr.length > 0 ? father[children] = branchArr : '';
            return !father[parentId] || father[parentId] == '0' ||  father[parentId] == null ;
        });
    }
    //验证是否为子集
    function childValidate(sourceList, id, parentId, key, parentKey) {
        var data = sourceList.find(function (x) {
            return x[key] == parentId;
        });
        if (data && data[parentKey] != '0' && data[parentKey]) {
            if (id == data[parentKey]) {
                return false;
            }
            return childValidate(sourceList, id, data[parentKey], key, parentKey);
        }
        return true;
    }
    /**
     * 数字转金额
     * */
    function moneyFormatter(cellValue) {
        return accounting.formatMoney(cellValue, '¥',2)
    }

    //日期工具
    var date = {
        //格式化时间
        fmt: function(de, fmt) {
            var date = new Date(typeof de == "string"?de.replace(/-/g, "/"):de);
            if (!fmt) {
                fmt = "yyyy-MM-dd";
            }
            var o = {
                "M+": date.getMonth() + 1, //月份
                "d+": date.getDate(), //日
                "h+": date.getHours(), //小时
                "m+": date.getMinutes(), //分
                "s+": date.getSeconds(), //秒
                "q+": Math.floor((date.getMonth() + 3) / 3), //季度
                "S": date.getMilliseconds() //毫秒
            };
            if (/(y+)/.test(fmt))
                fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt))
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        },
        diyFmt: function (time) {
            //如果传进来的是字符串，转成时间
            if(Object.prototype.toString.call(new Date()) != Object.prototype.toString.call(time) ){
                time = new Date(time);
            }
            var nowDate = new Date().getTime();
            var dif = (nowDate - time)/1000;
            //时间字符串
            var timestr ="";
            if(dif<60){
                timestr = "刚刚";
            }else if(dif<3600){
                timestr = moment(time).format('A') + moment(time).format('H:mm');
            }else if(dif<86400){
                timestr = "昨天";
            }else if(dif<172800){
                timestr = moment(time).format("dddd");
            }else if(dif<31536000){
                timestr = moment(time).format("MMM Do").replace(" ","");
            }else{
                timestr = moment(time).subtract(10, 'days').calendar();
            }
            return timestr;
        }
    }

    //数组工具
    var array = {

        //根据key清理arr里面重复的值
        unique: function(arr, key) {
            if (arr.length == 0) {
                return;
            }
            var result = [arr[0]];
            for (var i = 1; i < arr.length; i++) {
                var item = arr[i];
                var repeat = false;
                var repeat = false;
                for (var j = 0; j < result.length; j++) {
                    if (item[key] == result[j][key]) {
                        if (item['write'] && result[j]['write'] == false) {
                            break;
                        }
                        repeat = true;
                        break;
                    }
                }
                if (!repeat) {
                    result.push(item);
                }
            }
            return result;
        }

    }

    var convert = {
        byte: function(bytes) {
            if (isNaN(bytes)) {
                return '';
            }
            var symbols = ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
            var exp = Math.floor(Math.log(bytes) / Math.log(2));
            if (exp < 1) {
                exp = 0;
            }
            var i = Math.floor(exp / 10);
            bytes = bytes / Math.pow(2, 10 * i);

            if (bytes.toString().length > bytes.toFixed(2).toString().length) {
                bytes = bytes.toFixed(2);
            }
            return bytes + ' ' + symbols[i];
        },

        //根据经纬度计算记录
        distance: function(lon1, lat1, lon2, lat2) {
            var DEF_PI = 3.14159265359; // PI
            var DEF_2PI = 6.28318530712; // 2*PI
            var DEF_PI180 = 0.01745329252; // PI/180.0
            var DEF_R = 6370693.5; // radius of earth

            var ew1, ns1, ew2, ns2;
            var dx, dy, dew;
            var distance;
            // 角度转换为弧度
            ew1 = lon1 * DEF_PI180;
            ns1 = lat1 * DEF_PI180;
            ew2 = lon2 * DEF_PI180;
            ns2 = lat2 * DEF_PI180;
            // 经度差
            dew = ew1 - ew2;
            // 若跨东经和西经180 度，进行调整
            if (dew > DEF_PI)
                dew = DEF_2PI - dew;
            else if (dew < -DEF_PI)
                dew = DEF_2PI + dew;
            dx = DEF_R * Math.cos(ns1) * dew; // 东西方向长度(在纬度圈上的投影长度)
            dy = DEF_R * (ns1 - ns2); // 南北方向长度(在经度圈上的投影长度)
            // 勾股定理求斜边长
            distance = Math.sqrt(dx * dx + dy * dy).toFixed(0);
            return distance;
        }



    }



    var log = function(msg) {
        if (ms.debug) {
            console.log(msg);
        }
    }

    /**
     * window.sessionStorage方法封装
     * @type {{set: set, get: (function(*=): string), remove: remove}}
     */
    var store = {
        set: function(key, value) {
            window.sessionStorage.setItem(key, value);
        },
        get: function(key) {
            return window.sessionStorage.getItem(key);
        },
        remove: function(key) {
            window.sessionStorage.removeItem(key);
        }
    }

    /**
     *
     * 引入js-xlsx/xlsx.full.min.js
     * @param dom dom 数据对象
     * @param fileName 文件名
     * @param data 数据
     * @param format
     * var tableNead = {
                    column:[
                        {filed: "projectName",label:"项目名称",width:50},
                        {filed: "managerNickName",label:"成员名称",width:50},
                        {filed: "pdmType",label:"种类",width:50,dictDataOptions: []},
                        {filed: "pdmMoney",label:"收入金额",width:50},
                    ],
                    countFiled:["pdmMoney"],
                };
     * @returns {*}
     */
    function exportTable(dom, fileName, data,format) {
        /* 从表生成工作簿对象 */
        var wb = XLSX.utils.table_to_book(dom);
        var columnWidth = [];
        var table = [];
        var tableHead = [];
        //初始化头部字段
        format.column.forEach(function (value) {
            tableHead.push(value.label);
            columnWidth.push({
                "wpx": value.width
            });
        });
        table.push(tableHead);
        var tableFoot = new Array(format.column.length);

        //遍历，将数据整理重新返回
        data.map(function (x) {
            var a = [];

            //遍历中设定需要的那些字段数据
            format.column.forEach(function (value) {
                if (x.hasOwnProperty(value.filed)){
                    //替换字典数据
                    if (value.dictDataOptions != undefined && value.dictDataOptions.length > 0){
                        //遍历字典数据，有就替换
                        var dict = value.dictDataOptions.find(function (val) {
                            return x[value.filed] == val.dictValue;
                        })
                        a.push(dict?dict.dictLabel:"");
                    }else {
                        a.push(x[value.filed]);
                        if (format.countFiled != undefined && format.countFiled.indexOf(value.filed) >= 0) {
                            tableFoot[0] = '总计';
                            format.column.findIndex(function (value1, index) {
                                if (value1.filed == value.filed){
                                    tableFoot[index] = tableFoot[index] == undefined ? x[value.filed] : tableFoot[index] + x[value.filed];
                                }
                            });
                        }
                    }
                }else {
                    a.push("");
                }
            });
            return a
        }).forEach(function (v, i) {
            // 遍历整理后的数据加入table
            table.push(v)
        });
        table.push(tableFoot);
        var sheet = XLSX2.utils.aoa_to_sheet(table);
        wb.Sheets.Sheet1 = sheet;
        wb.Sheets.Sheet1['!cols'] = columnWidth;
        /* 获取二进制字符串作为输出 */
        var wbout = XLSX.write(wb, {
            bookType: 'xlsx',
            bookSST: true,
            type: "array"
        });

        try {
            //保存文件
            saveAs(
                //Blob 对象表示一个不可变、原始数据的类文件对象。
                //Blob 表示的不一定是JavaScript原生格式的数据。
                //File 接口基于Blob，继承了 blob 的功能并将其扩展使其支持用户系统上的文件。
                //返回一个新创建的 Blob 对象，其内容由参数中给定的数组串联组成。
                new Blob([wbout], {type: "application/octet-stream"}),
                //设置导出文件名称
                fileName + '.xlsx'
            );
        } catch (e) {
            if (typeof console !== "undefined") console.log(e, wbout);
        }
        return wbout;
    };

    /**
     * 打印方法
     * @param name 模板的名字
     * @param data 需要绑定的数据
     */
    function printFile(name,data){
        if (name != "" && name != null && name != undefined){
            ms.http.get(ms.manager+ "/mprint/printTemplate/get.do", {
                name: name
            }).then(function (res) {
                if(data != null && data != undefined && res.data != null){
                    printVue.open(res.data,data);
                }else {
                    console.error("未定义数据,或没有模板数据");
                }
            }).catch(function (err) {
                console.log(err);
            });
        }else {
            console.error("未定义模板名称");
        }
    };

    var util = {
        getParameter: getParameter,
        treeData:treeData,
        childValidate:childValidate,
        moneyFormatter:moneyFormatter,
        date: date,
        array: array,
        log: log,
        convert: convert,
        store: store,
        exportTable:exportTable,
        printFile:printFile,
    }




    if (typeof ms != "object") {
        window.ms = {};
    }
    window.ms.util = util;
    window.ms.debug = false
}());
