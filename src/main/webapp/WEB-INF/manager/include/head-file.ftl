<meta charset="utf-8">
<!--浏览器小图标-->
<link rel="icon" href="/logo.ico" type="x-icon">
<script type="text/javascript" src="${base}/static/plugins/vue/2.6.9/vue.min.js"></script>
<script src="${base}/static/plugins/vue-i18n/8.18.2/vue-i18n.js"></script>
<!-- 图标 -->
<link rel="stylesheet" type="text/css" href="${base}/static/plugins/iconfont/1.0.0/iconfont.css" />
<script src="${base}/static/plugins/iconfont/1.0.0/iconfont.js"></script>

<!-- 引入样式 -->
<link rel="stylesheet" href="${base}/static/plugins/element-ui/2.15.7/theme-chalk/index.min.css">
<!-- 引入组件库 -->
<script src="${base}/static/plugins/element-ui/2.15.7/index.min.js"></script>
<script src="${base}/static/plugins/element-ui/2.15.7/local/en.min.js"></script>
<script src="${base}/static/plugins/element-ui/2.15.7/local/zh-CN.min.js"></script>
<!--图片懒加载-->
<script src="${base}/static/plugins/vue.lazyload/1.2.6/vue-lazyload.js"></script>
<!--网络请求框架-->
<script src="${base}/static/plugins/axios/0.18.0/axios.min.js"></script>
<script src="${base}/static/plugins/qs/6.6.0/qs.min.js"></script>
<!--金额转换-->
<script src="${base}/static/plugins/accounting/0.4.1/accounting.js"></script>
<!--时间转换-->
<script src="${base}/static/plugins/moment/2.24.0/moment.min.js"></script>
<!--铭飞-->
<script src="${base}/static/plugins/ms/2.0/ms.umd.js"></script>
<script src="${base}/static/plugins/ms/2.0/ms-el-form.umd.js"></script>
<script src="${base}/static/plugins/vue-ueditor-wrap/vue-ueditor-wrap.min.js"></script>

<#--复制-->
<script src="${base}/static/plugins/clipboard/clipboard.js"></script>
<#-- 树形下拉-->
<script src="${base}/static/plugins/tree-select/tree.js"></script>
<!--通用样式-->
<link rel="stylesheet" href="${base}/static/css/app.css"/>
<#--主题-->
<link rel="stylesheet" href="${base}/static/css/theme.css">
<![if IE]>
<script src="${base}/static/plugins/babel-polyfill/7.8.3/polyfill.min.js"></script>
<![endif]>

<#--语言文件-->
<script src="${base}/static/locale/lang/base/zh_CN.js"></script>
<script src="${base}/static/locale/lang/base/en_US.js"></script>

<script src="${base}/static/mdiy/index.js"></script>

<#--下拉框-->
<script src="${base}/static/plugins/vue-treeselect/0.4.0/vue-treeselect.umd.min.js"></script>
<link rel="stylesheet" href="${base}/static/plugins/vue-treeselect/0.4.0/vue-treeselect.min.css">

<#--代码预览-->
<script src="${base}/static/plugins/clipboard/clipboard.js"></script>
<script src="${base}/static/plugins/codemirror/5.48.4/codemirror.js"></script>
<link href="${base}/static/plugins/codemirror/5.48.4/codemirror.css" rel="stylesheet">
<script src="${base}/static/plugins/codemirror/5.48.4/mode/css/css.js"></script>
<script src="${base}/static/plugins/vue-codemirror/vue-codemirror.js"></script>
<script src="${base}/static/plugins/codemirror/5.48.4/addon/scroll/annotatescrollbar.js"></script>
<script src="${base}/static/plugins/codemirror/5.48.4/mode/xml/xml.js"></script>
<script src="${base}/static/plugins/codemirror/5.48.4/mode/javascript/javascript.js"></script>

<script>
    ms.base = "${base}";
  	ms.login = "${managerPath}/login.do";
    ms.manager = "${managerPath}";
    ms.web = ms.base;
    //百度编辑器默认配置
    ms.editorConfig={
        imageScaleEnabled :true,
        autoHeightEnabled: true,
        autoFloatEnabled: false,
        scaleEnabled: true,
        compressSide:0,
        maxImageSideLength:1000,
        maximumWords: 2000,
        initialFrameWidth: '100%',
        initialFrameHeight: 400,
        serverUrl: ms.base + "/static/plugins/ueditor/1.4.3.3/jsp/editor.do?jsonConfig=%7BvideoUrlPrefix:\'\',fileManagerListPath:\'\',imageMaxSize:204800000,videoMaxSize:204800000,fileMaxSize:204800000,fileUrlPrefix:\'\',imageUrlPrefix:\'\',imagePathFormat:\'/${appId}/cms/content/editor/%7Btime%7D\',filePathFormat:\'/${appId}/cms/content/editor/%7Btime%7D\',videoPathFormat:\'/${appId}/cms/content/editor/%7Btime%7D\'%7D",
        UEDITOR_HOME_URL: ms.base + '/static/plugins/ueditor/1.4.3.3/'
    }

    //ms.base = "http://192.168.0.54:90/";
    //ms.manager = "http://192.168.0.54:90/apis/ms/";
    //ms.web = "http://192.168.0.54:90/apis/";
    //图片懒加载
    Vue.use(VueLazyload, {
        error: ms.base + '/static/images/error.png',
        loading: ms.base + '/static/images/loading.png',
    })
    Vue.component('treeselect', VueTreeselect.Treeselect)
    Vue.component('vue-ueditor-wrap', VueUeditorWrap);

</script>
<style>
    .ms-admin-menu .is-active {
        border: 0px !important;
    }
    .vue-treeselect__placeholder,.vue-treeselect__single-value {
        font-size: 12px;
        padding-top: -8px;
    }
    .vue-treeselect__control {
        height: 28px;
    }
    .vue-treeselect__label {
        font-size: 12px;
    }

    .vue-treeselect__menu-container {
        z-index: 9999!important;
    }
</style>


