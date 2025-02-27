(function(f,c){typeof exports=="object"&&typeof module<"u"?c(exports,require("axios"),require("qs"),require("element-plus")):typeof define=="function"&&define.amd?define(["exports","axios","qs","element-plus"],c):(f=typeof globalThis<"u"?globalThis:f||self,c(f.ms={},f.axios,f.Qs))})(this,function(f,c,y){"use strict";function v(t){if(t!=null){var n=c.create({baseURL:t.baseURL==null?c.defaults.baseURL:t.baseURL,timeout:t.timeout==null?c.defaults.timeout:t.timeout,headers:t.headers==null?null:t.headers});return n.interceptors.response.use(function(e){return e},function(e){if(e.response){let i;if(e.response.status==401?i="登录超时":e.response.status==400?i="客户端错误":e.response.status==403?i="您的权限不足":e.response.status==423?i="账号被锁定！":e.response.status==500?i="服务器异常,请刷新页面重试！":e.response.status==501?i="您的操作被取消或不允许提交,请刷新页面重试！":e.response.status==423?i="服务器正在开小差,请刷新页面重试！":e.response.status==404&&(i="资源不存在,请刷新页面重试！"),i){if(!o){var o=document.createElement("div");o.id="tempVue",document.body.appendChild(o)}typeof ElementPlus>"u"?alert(`系统提示
`+e.response.data.msg||i):ElementPlus.ElNotification.error({title:"系统提示",message:e.response.data.msg||i,duration:3e3}),e.response.status==401&&(window.ms.login?location.href=window.ms.login:console.log(i))}return Promise.reject(e)}else typeof ElementPlus>"u"?alert(`系统提示
不能请求到服务器，请检查网络是否正常或系统是否正常运行！`):ElementPlus.ElNotification.error({title:"系统提示",message:"不能请求到服务器，请检查网络是否正常或系统是否正常运行！",duration:3e3})}),n.interceptors.request.use(function(e){return e.headers||(e.headers={}),e.headers=Object.assign(e.headers,{"Cache-Control":"no-cache",Pragma:"no-cache","X-Requested-With":"XMLHttpRequest"}),sessionStorage.getItem("token")!=""&&(e.headers.token=sessionStorage.getItem("token")),e.method==="post"&&e.headers["Content-Type"]==="application/x-www-form-urlencoded"&&(e.data=y.stringify(e.data,{allowDots:!0})),e},function(e){return Promise.reject(e)}),n}return c}function M(t,n,e){return n==null&&(n={}),e==null&&(e={headers:{"X-Requested-With":"XMLHttpRequest"}}),new Promise(function(o,i){v(e).get(t,{params:n},e).then(function(r){o(r?r.data:void 0)}).catch(function(r){i(r)})})}function E(t,n,e){return n==null&&(n={}),e==null&&(e={headers:{"Content-Type":"application/x-www-form-urlencoded","X-Requested-With":"XMLHttpRequest"}}),new Promise(function(o,i){v(e).post(t,n,e).then(function(r){o(r.data?r.data:void 0)},function(r){i(r)})})}function D(t,n,e){return n==null&&(n={}),new Promise(function(o,i){v(e).patch(t,n,e).then(function(r){o(r)},function(r){i(r)})})}function R(t,n,e){return n==null&&(n={}),new Promise(function(o,i){v(e).put(t,n,e).then(function(r){o(r.data)},function(r){i(r)})})}function x(t,n,e,o){return n==null&&(n={}),new Promise(function(i,r){c({method:"post",url:t,data:n,timeout:e||1e3*60*5,responseType:"blob",headers:{Accept:"application/vnd.openxmlformats-officedocument"},onDownloadProgress:function(s){o&&o(s)}}).then(function(s){const p=s.data,l=new Blob([p]),g=s.headers["content-disposition"].split(";"),h=g[2].slice(11,g[2].length-1);if("download"in document.createElement("a")){const a=document.createElement("a");a.download=h,a.style.display="none",a.href=URL.createObjectURL(l),document.body.appendChild(a),a.click(),URL.revokeObjectURL(a.href),document.body.removeChild(a)}else navigator.msSaveBlob(l,h);i(s)},function(s){r(s)})})}const P={get:M,post:E,put:R,patch:D,download:x};function F(t,n){n?t.indexOf("?")>0?window.location.href=ms.manager+t+"&isBack="+n:window.location.href=ms.manager+t+"?isBack="+n:window.location.href=ms.manager+t}function O(t){try{var n=new RegExp("(^|&)"+t+"=([^&]*)(&|$)"),e=window.location.search.substr(1).match(n);return e!=null?decodeURI(e[2]):null}catch(o){X(o.message)}}function q(t,n,e,o){var i=JSON.parse(JSON.stringify(t));return i.filter(function(r){var s=i.filter(function(p){return r[n]==p[e]});return s.length>0&&(r[o]=s),!r[e]||r[e]=="0"||r[e]==null})}function S(t,n,e,o,i){var r=t.find(function(s){return s[o]==e});return r&&r[i]!=="0"&&r[i]?n==r[i]?!1:S(t,n,r[i],o,i):!0}function L(t){return accounting.formatMoney(t,"¥",2)}var I={fmt:function(t,n){var e;e=new Date(typeof t=="string"?t.replace(/-/g,"/"):t),e instanceof Date&&isNaN(e.getTime())&&(e=moment(t,n).toDate()),n=n.replaceAll("Y","y").replaceAll("D","d"),n||(n="yyyy-MM-dd");var o={"M+":e.getMonth()+1,"d+":e.getDate(),"h+":e.getHours(),"H+":e.getHours(),"m+":e.getMinutes(),"s+":e.getSeconds(),"q+":Math.floor((e.getMonth()+3)/3),S:e.getMilliseconds()};/(y+)/.test(n)&&(n=n.replace(RegExp.$1,(e.getFullYear()+"").substr(4-RegExp.$1.length)));for(var i in o)new RegExp("("+i+")").test(n)&&(n=n.replace(RegExp.$1,RegExp.$1.length==1?o[i]:("00"+o[i]).substr((""+o[i]).length)));return n},diyFmt:function(t){Object.prototype.toString.call(new Date)!==Object.prototype.toString.call(t)&&(t=new Date(t));var n=new Date().getTime(),e=(n-t)/1e3,o="";return e<60?o="刚刚":e<3600?o=moment(t).format("A")+moment(t).format("H:mm"):e<86400?o="昨天":e<172800?o=moment(t).format("dddd"):e<31536e3?o=moment(t).format("MMM Do").replace(" ",""):o=moment(t).subtract(10,"days").calendar(),o}},T={unique:function(t,n){if(t.length!=0){for(var e=[t[0]],o=1;o<t.length;o++){for(var i=t[o],r=!1,s=0;s<e.length;s++)if(i[n]==e[s][n]){if(i.write&&e[s].write==!1)break;r=!0;break}r||e.push(i)}return e}}},U={byte:function(t){if(isNaN(t))return"";var n=["bytes","KB","MB","GB","TB","PB","EB","ZB","YB"],e=Math.floor(Math.log(t)/Math.log(2));e<1&&(e=0);var o=Math.floor(e/10);return t=t/Math.pow(2,10*o),t.toString().length>t.toFixed(2).toString().length&&(t=t.toFixed(2)),t+" "+n[o]},distance:function(t,n,e,o){var i=3.14159265359,r=6.28318530712,s=.01745329252,p=63706935e-1,l,g,h,a,m,u,d,w;return l=t*s,g=n*s,h=e*s,a=o*s,d=l-h,d>i?d=r-d:d<-i&&(d=r+d),m=p*Math.cos(g)*d,u=p*(g-a),w=Math.sqrt(m*m+u*u).toFixed(0),w}};function X(t){window.ms.debug&&console.log(t)}var B={set:function(t,n){window.sessionStorage.setItem(t,n)},get:function(t){return window.sessionStorage.getItem(t)},remove:function(t){window.sessionStorage.removeItem(t)}};function C(t,n,e,o){var i=XLSX.utils.table_to_book(t),r=[],s=[],p=[];o.column.forEach(function(a){p.push(a.label),r.push({wpx:a.width})}),s.push(p);var l=new Array(o.column.length);e.map(function(a){var m=[];return o.column.forEach(function(u){if(a.hasOwnProperty(u.filed))if(u.dictDataOptions!=null&&u.dictDataOptions.length>0){var d=u.dictDataOptions.find(function(w){return a[u.filed]==w.dictValue});m.push(d?d.dictLabel:"")}else m.push(a[u.filed]),o.countFiled!=null&&o.countFiled.indexOf(u.filed)>=0&&(l[0]="总计",o.column.findIndex(function(w,b){w.filed==u.filed&&(l[b]=l[b]==null?a[u.filed]:l[b]+a[u.filed])}));else m.push("")}),m}).forEach(function(a,m){s.push(a)}),s.push(l);var g=XLSX2.utils.aoa_to_sheet(s);i.Sheets.Sheet1=g,i.Sheets.Sheet1["!cols"]=r;var h=XLSX.write(i,{bookType:"xlsx",bookSST:!0,type:"array"});try{saveAs(new Blob([h],{type:"application/octet-stream"}),n+".xlsx")}catch(a){typeof console<"u"&&console.log(a,h)}return h}function N(t,n){t!==""&&t!=null&&t!=null?ms.http.get(ms.manager+"/mprint/printTemplate/get.do",{name:t}).then(function(e){n!=null&&n!=null&&e.data!=null?printVue.open(e.data,n):console.error("未定义数据,或没有模板数据")}).catch(function(e){console.log(e)}):console.error("未定义模板名称")}function j(t){const n=t.toLowerCase().split("_");for(let e=1;e<n.length;e++)n[e]=n[e].charAt(0).toUpperCase()+n[e].slice(1);return n.join("")}function A(){var t=navigator,n=t.appVersion,e=n.split(";"),o=e[1].replace(/[ ]/g,"");if(t.appName=="Microsoft Internet Explorer"){if(o.indexOf("MSIE")>-1&&o!=="MSIE10.0")return"MSIE9.0";if(o.indexOf("MSIE10.0")>-1)return"MSIE10.0"}else return"other"}const H={browserVersion:A,getParameter:O,treeData:q,childValidate:S,moneyFormatter:L,openSystemUrl:F,date:I,array:T,convert:U,store:B,exportTable:C,printFile:N,camelCaseString:j};f.http=P,f.util=H,Object.defineProperty(f,Symbol.toStringTag,{value:"Module"})});
