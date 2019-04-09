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

    //日期处理
    var date = {
        //格式化时间
        fmt: function(date, fmt) {
            var date = new Date(date);
            log(fmt);
            if (fmt == undefined || validator.isEmpty(fmt)) {
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
}());