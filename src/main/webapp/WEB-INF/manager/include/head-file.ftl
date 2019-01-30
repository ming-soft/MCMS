    
    <meta charset="utf-8">
    <!--浏览器小图标-->
    <link rel="icon" href="http://cdn.mingsoft.net/global/images/ms.ico" type="x-icon">
    <script type="text/javascript" src="https://unpkg.com/vue@2.5.21/dist/vue.min.js"></script>
    <!--小图标-->
    <link rel="stylesheet" href="//at.alicdn.com/t/font_847907_mkdvd7gopsg.css">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_974973_42u7cwycwta.css">
    <link rel="stylesheet" href="//at.alicdn.com/t/font_1035189_ddqz6fpwzxb.css">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <!--网络请求框架-->
    <script src="https://cdn.bootcss.com/axios/0.18.0/axios.min.js"></script>
    <script src="https://cdn.bootcss.com/qs/6.5.2/qs.min.js"></script>
    <!--铭飞-->
    <script src="http://cdn.mingsoft.net/ms/1.0/ms.js"></script>
    <script src="http://cdn.mingsoft.net/ms/1.0/ms.http.js"></script>
    <script src="http://cdn.mingsoft.net/ms/1.0/ms.util.js"></script>

    <!--jquery-->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <!--百度富文本-->
    <script type="text/javascript" charset="utf-8" src="http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/ueditor.parse.js"></script>
    <script type="text/javascript" charset="utf-8" src="http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="http://mpm.mingsoft.net/static/plugins/ueditor/1.4.3.1/lang/zh-cn/zh-cn.js"></script>
    <!--图片懒加载-->
	<script src="https://cdn.bootcss.com/vue-lazyload/1.2.6/vue-lazyload.js"></script>
	
    <!-- 拖拽 -->
    <script src="//cdn.jsdelivr.net/npm/sortablejs@1.7.0/Sortable.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/Vue.Draggable/2.17.0/vuedraggable.min.js"></script>
 
    <link rel="stylesheet" href="${base}/static/ms-admin/4.7.0/css/login.css"> 
    <link rel="stylesheet" href="${base}/static/mweixin/css/custom-menu.css"> 
    <link rel="stylesheet" href="${base}/static/mweixin/css/message-reply.css">

   
    <script>
        ms.base = "${base}";
        ms.manager = "${managerPath}";
        ms.web = ms.base;

        // ms.base = "http://192.168.0.54:85";
        // ms.manager = "http://192.168.0.54:85/apis/ms";
        // ms.web = "http://192.168.0.54:85/apis";
        //图片懒加载
		  Vue.use(VueLazyload, {
		    error: ms.base + '/images/ic_image_deault.png',
		    loading: ms.base + '/images/ic_image_deault.png',
		  })
    </script>