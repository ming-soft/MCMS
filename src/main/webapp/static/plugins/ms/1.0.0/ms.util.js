/**
 * 通用工具类
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

    //日期处理
    var date = {
        //格式化时间
        fmt: function(de, fmt) {
            var date = new Date(typeof de == "string"?de.replace(/-/g, "/"):de);
            if (!fmt) {
                fmt = "yyyy-mm-dd";
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
        },
        //根据pro属性与value移除arr对应的值
        remove: function(arr, attr, value) {
            for (var j = 0; j < arr.length; j++) {
                if (arr[j][attr] == value) {
                    arr.splice(j, 1);
                    break;
                }
            }
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

    var cookie = {

    }

    var util = {
        getParameter: getParameter,
        treeData:treeData,
        childValidate:childValidate,
        date: date,
        array: array,
        log: log,
        convert: convert,
        store: store,
    }




    if (typeof ms != "object") {
        window.ms = {};
    }
    window.ms.util = util;
    window.ms.debug = false
}());
