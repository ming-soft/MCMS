<html>
<head>
  <meta charset="utf-8" />
  <title>后台主界面</title>
  <meta http-equiv="content-type" content="text/html" />
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache" />
  <meta name="viewport"
        content="initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,width=device-width"/>
  <meta name="format-detection" content="telephone=no"/>
  <meta name="app-mobile-web-app-capable" content="yes"/>
  <meta name="app-mobile-web-app-status-bar-style" content="black-translucent"/>
  <script src="${base}/static/plugins/vue/2.6.9/vue.min.js"></script>
  <!--通用图标-->
  <link rel="stylesheet" href="${base}/static/plugins/iconfont/1.0.0/iconfont.css" />
  <script src="${base}/static/plugins/element-ui/2.12.0/index.js"></script>
  <link rel="stylesheet" href="${base}/static/plugins/element-ui/2.12.0/index.css" />
  <!--网络请求框架-->
  <script src="${base}/static/plugins/axios/0.18.0/axios.min.js"></script>
  <script src="${base}/static/plugins/qs/6.6.0/qs.min.js"></script>
  <!--铭飞-->
  <script src="${base}/static/plugins/ms/1.0.0/ms.js"></script>
  <script src="${base}/static/plugins/ms/1.0.0/ms.http.js"></script>
  <script src="${base}/static/plugins/ms/1.0.0/ms.util.js"></script>
  <link rel="stylesheet" href="${base}/static/plugins/minireset/0.0.2/minireset.min.css" />
  <script>
    ms.base = '${base}';
    ms.manager = '${managerPath}';
  </script>
  <style>
    [v-cloak]{
      display: none;
    }
  </style>
</head>
<body class="custom-body">
<div id="app" v-cloak>
  <div  class="class-1" >
    <div  class="class-2" >
      <div  class="class-3" >
        <div  class="class-4" >
        </div>
        <div  class="class-5" >
        </div>
        <div  class="class-6" >
        </div>
        <div  class="panel" >
            <div  v-if="alwaysList.length>0" class="panel-title">
              常用功能
            </div>
            <div class="v-space"></div>
            <div class="panel-content" style="flex-direction: row;flex-wrap: wrap; flex: unset">
              <div class="mitem"
                   @click="window.parent.indexVue.openParentMenuInTitle(item.title)"
                   v-for="item in alwaysList">
                <!--图标开始-->
                <i :class="['iconfont',item.icon]"></i>
                <div class="item-title">
                  {{ item.title }}
                </div>
                <!--文本结束-->
              </div>
            </div>
        </div>
        <!--大容器开始-->
        <div  class="class-43" >
          <!--大容器开始-->
          <div  class="class-44" >
            <!--文本开始-->
            <div class="class-45">
              MMall
            </div>
            <!--文本结束-->
            <!--文本开始-->
            <div class="class-46">
              单商户、多商户、社区商城
            </div>
            <!--文本结束-->
          </div>
          <!--大容器结束-->
          <!--大容器开始-->
          <div  class="class-47" >
            <!--文本开始-->
            <div class="class-48">
              微信
            </div>
            <!--文本结束-->
            <!--文本开始-->
            <div class="class-49">
              可管理多个公众号
            </div>
            <!--文本结束-->
          </div>
          <!--大容器结束-->
          <!--大容器开始-->
          <div  class="class-50" >
            <!--文本开始-->
            <div class="class-51">
              MApp
            </div>
            <!--文本结束-->
            <!--文本开始-->
            <div class="class-52">
              安卓、IOS、小程序
            </div>
            <!--文本结束-->
          </div>
          <!--大容器结束-->
          <!--大容器开始-->
          <div  class="class-53" >
            <!--文本开始-->
            <div class="class-54">
              二次开发
            </div>
            <!--文本结束-->
            <!--文本开始-->
            <div class="class-55">
              更优质的服务体验,高效率的开发团队
            </div>
            <!--文本结束-->
          </div>
          <!--大容器结束-->
        </div>
        <!--大容器结束-->
      </div>
    </div>
    <div  class="class-56" >
      <div  class="class-57" @click="openMCMSNews">
        <div  class="class-58" >
          <div  class="class-59" >
          </div>
          <div class="class-60">
            {{ msNewsLast }}
          </div>
        </div>
      </div>
      <div  class="class-61" @click="jumpMCMSDocument">
        <div  class="class-62" >
        </div>
        <div class="class-63">
          铭飞MCms在线文档
        </div>
      </div>
      <!--小容器开始-->
      <div  class="class-64" >
        <div  class="class-65" @click="enterQQOneGroup">
          <div  class="class-66" >
            <!--图片开始-->
            <img
                    src="${base}/static/images/1577687056305.png"
                    class="class-67" />
            <!--图片结束-->
          </div>
          <div  class="class-68" >
            <div class="class-69">
              铭飞MS平台（一）
            </div>
            <div class="class-70">
              231212174
            </div>
          </div>
        </div>
        <div  class="class-71" @click="enterQQTwoGroup">
          <div  class="class-72" >
            <!--图片开始-->
            <img
                    src="${base}/static/images/1577687056305.png"
                    class="class-73" />
            <!--图片结束-->
          </div>
          <div  class="class-74" >
            <div class="class-75">
              铭飞MS平台（二）
            </div>
            <div class="class-76">
              221335098
            </div>
          </div>
        </div>
        <div  class="class-77" @click="enterQQThreeGroup">
          <div  class="class-78" >
            <!--图片开始-->
            <img
                    src="${base}/static/images/1577687056305.png"
                    class="class-79" />
            <!--图片结束-->
          </div>
          <div  class="class-80" >
            <div class="class-81">
              铭飞MS平台（三）
            </div>
            <div class="class-82">
              242805203
            </div>
          </div>
        </div>
        <div  class="class-83" @click="enterQQFourGroup">
          <div  class="class-84" >
            <!--图片开始-->
            <img
                    src="${base}/static/images/1577687056305.png"
                    class="class-85" />
            <!--图片结束-->
          </div>
          <div  class="class-86" >
            <div class="class-87">
              铭飞MS平台（四）
            </div>
            <div class="class-88">
              881894877
            </div>
          </div>
        </div>
      </div>
      <!--小容器结束-->
      <div  class="class-89" >
        <div  class="class-90" >
          <div class="class-91">
            商务技术支持
          </div>
        </div>
        <div  class="class-92" >
        </div>
        <div  class="class-93" >
        </div>
        <div  class="class-94" >
          <div  class="class-95" >
            <div  class="class-96" >
            </div>
            <div class="class-97">
              功能更丰富
            </div>
          </div>
          <div  class="class-98" >
            <div  class="class-99" >
            </div>
            <div class="class-100">
              审批
            </div>
          </div>
          <div  class="class-101" >
            <div  class="class-102" >
            </div>
            <div class="class-103">
              在线Office
            </div>
          </div>
          <div  class="class-104" >
            <div  class="class-105" >
            </div>
            <div class="class-106">
              远程协助
            </div>
          </div>
          <div  class="class-107" >
            <div  class="class-108" >
            </div>
            <div class="class-109">
              语音协助
            </div>
          </div>
          <div  class="class-110" >
            <div  class="class-111" >
            </div>
            <div class="class-112">
              专属VIP群
            </div>
          </div>
          <div  class="class-113" >
            <div  class="class-114" >
            </div>
            <div class="class-115">
              提供发票
            </div>
          </div>
          <div  class="class-116" >
            <div  class="class-117" >
            </div>
            <div class="class-118">
              终身授权
            </div>
          </div>
          <div  class="class-119" >
            <div  class="class-120" >
            </div>
            <div class="class-121">
              授权证明书
            </div>
          </div>
        </div>
        <div  class="class-122" >
          <!--横分割线开始-->
          <div class="class-123"></div>
          <!--横分割线结束-->
          <!--小容器开始-->
          <div  class="class-124" >
            <div  class="class-125" >
              <div  class="class-126" >
                <!--图片开始-->
                <img
                        src="${base}/static/images/1577687023678.png"
                        class="class-127" />
                <!--图片结束-->
              </div>
              <div  class="class-128" >
                <div class="class-129">
                  商务电话
                </div>
                <div class="class-130">
                  19970180163
                </div>
              </div>
            </div>
            <div  class="class-131" @click="addBusinessQQ">
              <div  class="class-132" >
                <!--图片开始-->
                <img
                        src="${base}/static/images/1577687056305.png"
                        class="class-133" />
                <!--图片结束-->
              </div>
              <div  class="class-134" >
                <div class="class-135">
                  商务QQ
                </div>
                <div class="class-136">
                  3336073455
                </div>
              </div>
            </div>
          </div>
          <!--小容器结束-->
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
<script>
  var app = new Vue({
    el: '#app',
    watch: {},
    data: {
      base: ms.base,
      msNewsLast: '',
      msNewsPath: '',
      alwaysList: [], //常用功能列表
    },
    methods: {
      jumpArtcleManager: function () {
        window.parent.indexVue.openMenu({
          modelId: 706,
          modelTitle: '文章管理',
          modelIcon: "icon-neirongguanli"
        });
      },
      //栏目管理
      jumpCategorymanager: function () {
        window.parent.indexVue.open({
          "modelId": 708,
          "modelTitle": "栏目管理",
          "modelId": 706,
          "modelUrl": "cms/category/index.do"
        });
      },
      //静态化
    jumpStaticManager: function () {
        window.parent.indexVue.open({"modelId":709,"modelTitle":"静态化","modelId":706,"modelUrl":"cms/generate/index.do"});
      },
      //管理员管理
      jumpAdmininstatorManager: function () {
        window.parent.indexVue.open({
          "modelId": 411,
          "modelTitle": "管理员管理",
          "modelId": 23,
          "modelUrl": "basic/manager/index.do"
        });
      },
      //角色管理
      jumpUserManager: function () {
        window.parent.indexVue.open({
          "modelId": 406,
          "modelTitle": "角色管理",
          "modelId": 23,
          "modelUrl": "basic/role/index.do"
        });
      },
      //菜单管理
      jumpMenuManager: function () {
        window.parent.indexVue.open({
          "modelId": 183,
          "modelTitle": "菜单管理",
          "modelId": 23,
          "modelUrl": "model/index.do"
        });
      },
      getAlwaysList: function () {
        var markList = localStorage.getItem("markList");
        if (markList) {
          this.alwaysList = JSON.parse(markList)
        }
      },
      //模板管理
      jumpTemplateManager: function () {
        window.parent.indexVue.open({
          "modelId": 87,
          "modelTitle": "模板管理",
          "modelId": 84,
          "modelUrl": "template/index.do"
        });
      },
      setCallBackFun: function () {
        window.parent.indexVue.addCallBackFun(this.getAlwaysList);
      },
      //应用管理
      jumpApplicationManager: function () {
        window.parent.indexVue.open({
          "modelId": 86,
          "modelTitle": "应用管理",
          "modelId": 84,
          "modelUrl": "app/-1/edit.do"
        });
      },
      //铭飞开发文档
      jumpMCMSDocument: function () {
        window.open("http://doc.mingsoft.net/plugs-cms/");
      },
      enterQQOneGroup: function () {
        window.open("https://shang.qq.com/wpa/qunwpa?idkey=ebf251dc9758de6b9c78c499956431cba73e28b3f0b72c0fc28242e98b20fca2");
      },
      enterQQTwoGroup: function () {
        window.open("http://shang.qq.com/wpa/qunwpa?idkey=cfb32b0f47d89d7ef1c3a9493984d4ffbdfe14049fdedd90c517a072e90d68b9");
      },
      enterQQThreeGroup: function () {
        window.open("http://shang.qq.com/wpa/qunwpa?idkey=5dd11fdb492c4ded090fa1f78a166583978e33c4a61301b136d31e9e3eb7df72");
      },
      enterQQFourGroup: function () {
        window.open("http://shang.qq.com/wpa/qunwpa?idkey=565f1e4c4fabeee42947f6c6b96ac7ca4853dece16559d3d78e944ca2931b7f5");
      },
      addBusinessQQ: function () {
        window.open("http://wpa.qq.com/msgrd?v=3&uin=3336073455&site=qq&menu=yes");
      },
      //打开铭飞消息页面
      openMCMSNews: function () {
        window.open(this.msNewsPath);
      },
      getNewsLast: function () {
        var that = this;
        axios.create({
          withCredentials: true
        }).get("https://mingsoft.net/cms/content/list.do?categoryId=202").then(function (res) {
          that.msNewsLast = res.data.data.rows[0].contentTitle.toString();
          that.msNewsPath = 'https://mingsoft.net/html/1/203/202/' + res.data.data.rows[0].id + '.html';
        });
        this.setCallBackFun();
      }
    },
    created: function () {
      this.getNewsLast();
      this.getAlwaysList();
    }
  });
</script>
<style>
  .panel {
    margin-top:10px;
    color: #333333;
    padding-right:20px;
    padding-top:20px;
    max-width:100%;
    padding-left:20px;
    outline-offset: -1px;
    background-color: rgba(255, 255, 255, 1);
    flex-direction: column;
    display: flex;
    animation-duration: 1s;
    background-repeat: no-repeat;
  }
  .panel .panel-content .mitem:hover i ,.panel .panel-content .mitem:hover .item-title{
    color:#409EFF
  }
  .panel-content .mitem i {
    font-size: 40px;
  }
  .panel-content .mitem {
    color: #333333;
    cursor: pointer;
    outline-offset: -1px;
    max-width:100%;
    flex-direction: column;
    display: flex;
    animation-duration: 1s;
    width: 25%;
    background-repeat: no-repeat;
    align-items: center;
    margin-bottom:20px;
  }
  .panel .panel-title {
    color: #333333;
    word-wrap: break-word;
    font-weight: bold;
    display: inline-block;
    animation-duration: 1s;
    font-size: 16px;
  }
  .panel .panel-content {
    color: #333333;
    padding-right: 10px;
    padding-bottom: 10px;
    outline-offset: -1px;
    flex: 1;
    padding-top: 10px;
    max-width: 100%;
    flex-direction: column;
    display: flex;
    animation-duration: 1s;
    width: 100%;
    padding-left: 10px;
    background-repeat: no-repeat;
  }
  .panel .panel-content .mitem .item-title{
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
  }
  .custom-body {
  }
  .class-1
  {
    color:#333333;
    padding-right:10px;
    min-height:720px;
    outline:none;
    padding-bottom:10px;
    overflow:visible;
    outline-offset:-1px;
    flex:6;
    padding-top:10px;
    height:100%;
    background-color:rgba(238, 238, 238, 1);
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:100%;
    padding-left:10px;
    background-repeat:no-repeat;
  }
  .class-2
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    flex:7;
    height:100%;
    max-width:100%;
    flex-direction:column;
    display:flex;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-3
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    flex:4;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    flex-direction:column;
    display:flex;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-4
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-5
  {
    color:#333333;
    margin-right:20px;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-6
  {
    color:#333333;
    margin-right:20px;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-7
  {
    color:#333333;
    padding-right:20px;
    outline:none;
    outline-offset:-1px;
    padding-top:20px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    flex-direction:column;
    display:flex;
    animation-duration:1s;
    padding-left:20px;
    background-repeat:no-repeat;
    margin-top:10px;
  }
  .class-8
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:flex-start;
    animation-duration:1s;
    width:100%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-9
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
  }
  .class-10
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    flex-wrap:wrap;
    max-width:100%;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:100%;
    background-repeat:no-repeat;
  }
  .class-11
  {
    cursor:pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    text-align:left;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:25%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-12
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    background-color:rgba(17, 205, 110, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-13
  {
    height:30px;
    animation-duration:1s;
    width:30px;
  }
  .class-14
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-15
  {
    cursor:pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    text-align:left;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:25%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-16
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    background-color:rgba(0, 153, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-17
  {
    height:24px;
    animation-duration:1s;
    width:24px;
  }
  .class-18
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-19
  {
    cursor:pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    text-align:left;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:25%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-20
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    background-color:rgba(255, 68, 68, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-21
  {
    height:26px;
    animation-duration:1s;
    width:30px;
  }
  .class-22
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-23
  {
    cursor:pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    text-align:left;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:25%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-24
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:40px;
    max-width:100%;
    background-color:rgba(0, 153, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-25
  {
    height:28px;
    animation-duration:1s;
    width:28px;
  }
  .class-26
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-27
  {
    cursor:pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    text-align:left;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:25%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-28
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    background-color:rgba(255, 68, 68, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-29
  {
    height:32px;
    animation-duration:1s;
    width:32px;
  }
  .class-30
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-31
  {
    cursor:pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    text-align:left;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:25%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-32
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    background-color:rgba(17, 205, 110, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-33
  {
    height:32px;
    animation-duration:1s;
    width:32px;
  }
  .class-34
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-35
  {
    cursor:pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    text-align:left;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:25%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-36
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    background-color:rgba(0, 153, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-37
  {
    height:28px;
    animation-duration:1s;
    width:28px;
  }
  .class-38
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-39
  {
    cursor:pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    text-align:left;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:25%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-40
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    background-color:rgba(17, 205, 110, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-41
  {
    height:28px;
    animation-duration:1s;
    width:28px;
  }
  .class-42
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-43
  {
    color:#333333;
    padding-right:20px;
    outline:none;
    outline-offset:-1px;
    flex:1;
    height:300px;
    max-width:100%;
    flex-direction:row;
    display:flex;
    justify-content:space-between;
    animation-duration:1s;
    width:100%;
    margin-bottom:20px;
    padding-left:20px;
    background-repeat:no-repeat;
    margin-top:20px;
  }
  .class-44
  {
    color:#333333;
    background-image:url(${base}/static/images/1578104008987.png);
    outline:none;
    outline-offset:-1px;
    background-size:cover;
    background-position:center;
    height:200px;
    max-width:100%;
    background-color:rgba(119, 54, 242, 1);
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:24%;
    background-repeat:no-repeat;
  }
  .class-45
  {
    color:#FFFFFF;
    word-wrap:break-word;
    text-shadow:#666 3px 4px 5px;
    font-weight:bold;
    z-index:1;
    display:inline-block;
    animation-duration:1s;
    font-size:32px;
    line-height:1.4;
  }
  .class-46
  {
    color:#FFFFFF;
    word-wrap:break-word;
    text-shadow:#666 3px 4px 5px;
    z-index:1;
    display:inline-block;
    animation-duration:1s;
    font-size:24px;
    line-height:1.4;
  }
  .class-47
  {
    color:#333333;
    background-image:url(${base}/static/images/1578367666376.png);
    outline:none;
    outline-offset:-1px;
    background-size:cover;
    background-position:center;
    height:200px;
    max-width:100%;
    background-color:rgba(119, 54, 242, 1);
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:24%;
    background-repeat:no-repeat;
  }
  .class-48
  {
    color:#FFFFFF;
    word-wrap:break-word;
    text-shadow:#666 3px 4px 5px;
    font-weight:bold;
    z-index:1;
    display:inline-block;
    animation-duration:1s;
    font-size:32px;
    line-height:1.4;
  }
  .class-49
  {
    color:#FFFFFF;
    word-wrap:break-word;
    text-shadow:#666 3px 4px 5px;
    z-index:1;
    display:inline-block;
    animation-duration:1s;
    font-size:24px;
    line-height:1.4;
  }
  .class-50
  {
    color:#333333;
    background-image:url(${base}/static/images/1578366770290.png);
    outline:none;
    outline-offset:-1px;
    background-size:cover;
    background-position:center;
    height:200px;
    max-width:100%;
    background-color:rgba(119, 54, 242, 1);
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:24%;
    background-repeat:no-repeat;
  }
  .class-51
  {
    color:#FFFFFF;
    word-wrap:break-word;
    text-shadow:#666 3px 4px 5px;
    font-weight:bold;
    z-index:1;
    display:inline-block;
    animation-duration:1s;
    font-size:32px;
    line-height:1.4;
  }
  .class-52
  {
    color:#FFFFFF;
    word-wrap:break-word;
    text-shadow:#666 3px 4px 5px;
    z-index:1;
    display:inline-block;
    animation-duration:1s;
    font-size:24px;
    line-height:1.4;
  }
  .class-53
  {
    color:#333333;
    background-image:url(${base}/static/images/1578368816112.png);
    outline:none;
    outline-offset:-1px;
    background-size:cover;
    background-position:center;
    height:200px;
    max-width:100%;
    background-color:rgba(119, 54, 242, 1);
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:24%;
    background-repeat:no-repeat;
  }
  .class-54
  {
    color:#FFFFFF;
    word-wrap:break-word;
    text-shadow:#666 3px 4px 5px;
    font-weight:bold;
    z-index:1;
    display:inline-block;
    animation-duration:1s;
    font-size:32px;
    line-height:1.4;
  }
  .class-55
  {
    color:#FFFFFF;
    word-wrap:break-word;
    text-shadow:#666 3px 4px 5px;
    z-index:1;
    display:inline-block;
    animation-duration:1s;
    font-size:24px;
    line-height:1.4;
  }
  .class-56
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    flex:1;
    height:100%;
    flex-direction:column;
    display:flex;
    min-width:390px;
    margin-left:10px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-57
  {
    cursor: pointer;
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    background-color:rgba(253, 246, 236, 1);
    align-items:flex-start;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:100%;
    padding-left:20px;
    background-repeat:no-repeat;
  }
  .class-58
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-59
  {
    color:#333333;
    background-image:url(${base}/static/images/1577257489392.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:20px;
    max-width:100%;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:20px;
    background-repeat:no-repeat;
  }
  .class-60
  {
    color:#E6A23C;
    word-wrap:break-word;
    display:inline-block;
    margin-left:10px;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
  }
  .class-61
  {
    cursor:pointer;
    color:#333333;
    padding-right:20px;
    outline:none;
    padding-bottom:20px;
    outline-offset:-1px;
    padding-top:20px;
    height:80px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    padding-left:20px;
    background-repeat:no-repeat;
    margin-top:10px;
  }
  .class-62
  {
    color:#333333;
    background-image:url(${base}/static/images/1577151868190.png);
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-63
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    margin-left:20px;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
  }
  .class-64
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    flex-wrap:wrap;
    max-width:100%;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    background-repeat:no-repeat;
    margin-top:10px;
  }
  .class-65
  {
    cursor:pointer;
    color:#333333;
    padding-right:15px;
    outline:none;
    padding-bottom:20px;
    outline-offset:-1px;
    padding-top:20px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:50%;
    padding-left:15px;
    background-repeat:no-repeat;
  }
  .class-66
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    align-items:center;
    flex-direction:row;
    display:flex;
    min-width:40px;
    justify-content:center;
    animation-duration:1s;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-67
  {
    animation-duration:1s;
  }
  .class-68
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-69
  {
    color:#999999;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:12px;
    line-height:1.4;
  }
  .class-70
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
    margin-top:5px;
  }
  .class-71
  {
    cursor:pointer;
    color:#333333;
    padding-right:15px;
    outline:none;
    padding-bottom:20px;
    outline-offset:-1px;
    padding-top:20px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:50%;
    padding-left:15px;
    background-repeat:no-repeat;
  }
  .class-72
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    align-items:center;
    flex-direction:row;
    display:flex;
    min-width:40px;
    justify-content:center;
    animation-duration:1s;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-73
  {
    animation-duration:1s;
  }
  .class-74
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-75
  {
    color:#999999;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:12px;
    line-height:1.4;
  }
  .class-76
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
    margin-top:5px;
  }
  .class-77
  {
    cursor:pointer;
    color:#333333;
    padding-right:15px;
    outline:none;
    padding-bottom:20px;
    outline-offset:-1px;
    padding-top:20px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:50%;
    padding-left:15px;
    background-repeat:no-repeat;
  }
  .class-78
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    align-items:center;
    flex-direction:row;
    display:flex;
    min-width:40px;
    justify-content:center;
    animation-duration:1s;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-79
  {
    animation-duration:1s;
  }
  .class-80
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-81
  {
    color:#999999;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:12px;
    line-height:1.4;
  }
  .class-82
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
    margin-top:5px;
  }
  .class-83
  {
    cursor:pointer;
    color:#333333;
    padding-right:15px;
    outline:none;
    padding-bottom:20px;
    outline-offset:-1px;
    padding-top:20px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:50%;
    padding-left:15px;
    background-repeat:no-repeat;
  }
  .class-84
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    align-items:center;
    flex-direction:row;
    display:flex;
    min-width:40px;
    justify-content:center;
    animation-duration:1s;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-85
  {
    animation-duration:1s;
  }
  .class-86
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-87
  {
    color:#999999;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:12px;
    line-height:1.4;
  }
  .class-88
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
    margin-top:5px;
  }
  .class-89
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    flex:1;
    padding-top:20px;
    height:980px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    flex-direction:column;
    display:flex;
    animation-duration:1s;
    background-repeat:no-repeat;
    margin-top:10px;
  }
  .class-90
  {
    color:#333333;
    margin-right:20px;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:flex-start;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-91
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
  }
  .class-92
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    flex-wrap:wrap;
    max-width:100%;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:100%;
    background-repeat:no-repeat;
  }
  .class-93
  {
    color:#333333;
    margin-right:20px;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    width:100%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-94
  {
    color:#333333;
    outline:none;
    overflow:visible;
    outline-offset:-1px;
    flex-wrap:wrap;
    max-width:100%;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:100%;
    background-repeat:no-repeat;
  }
  .class-95
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-96
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031206821.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-97
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-98
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-99
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031321635.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-100
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-101
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-102
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031484700.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-103
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-104
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-105
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031264207.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-106
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-107
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-108
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031682848.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-109
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-110
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-111
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031639173.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-112
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-113
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-114
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031215338.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-115
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-116
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-117
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031228196.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-118
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-119
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    align-items:center;
    flex-direction:column;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    width:33%;
    margin-bottom:20px;
    background-repeat:no-repeat;
  }
  .class-120
  {
    color:#333333;
    background-image:url(${base}/static/images/1578031234719.png);
    outline:none;
    outline-offset:-1px;
    background-size:contain;
    background-position:center;
    height:30px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    justify-content:center;
    animation-duration:1s;
    border-radius:4px;
    width:30px;
    background-repeat:no-repeat;
  }
  .class-121
  {
    color:#333333;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
    margin-top:10px;
  }
  .class-122
  {
    color:#333333;
    box-sizing:center-box;
    outline:none;
    overflow:visible;
    outline-offset:-1px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    flex-direction:column;
    display:flex;
    animation-duration:1s;
    width:100%;
    background-repeat:no-repeat;
    margin-top:10px;
  }
  .class-123
  {
    margin-right:auto;
    animation-duration:1s;
    background-color:rgba(250, 250, 250, 1);
    border-radius:1px;
    width:100%;
    height:1px;
    margin-left:auto;
  }
  .class-124
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    flex-wrap:wrap;
    max-width:100%;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-125
  {
    color:#333333;
    padding-right:20px;
    outline:none;
    padding-bottom:20px;
    outline-offset:-1px;
    flex-wrap:nowrap;
    padding-top:20px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:50%;
    padding-left:20px;
    background-repeat:no-repeat;
  }
  .class-126
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    max-width:100%;
    align-items:center;
    flex-direction:row;
    display:flex;
    min-width:40px;
    justify-content:center;
    animation-duration:1s;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-127
  {
    animation-duration:1s;
  }
  .class-128
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-129
  {
    color:#999999;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
  }
  .class-130
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
    margin-top:5px;
  }
  .class-131
  {
    cursor:pointer;
    color:#333333;
    padding-right:20px;
    outline:none;
    padding-bottom:20px;
    outline-offset:-1px;
    padding-top:20px;
    max-width:100%;
    background-color:rgba(255, 255, 255, 1);
    align-items:center;
    flex-direction:row;
    display:flex;
    animation-duration:1s;
    width:50%;
    padding-left:20px;
    background-repeat:no-repeat;
  }
  .class-132
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    height:40px;
    align-items:center;
    flex-direction:row;
    display:flex;
    min-width:40px;
    justify-content:center;
    animation-duration:1s;
    width:40px;
    background-repeat:no-repeat;
  }
  .class-133
  {
    animation-duration:1s;
  }
  .class-134
  {
    color:#333333;
    outline:none;
    outline-offset:-1px;
    max-width:100%;
    flex-direction:column;
    display:flex;
    margin-left:20px;
    animation-duration:1s;
    background-repeat:no-repeat;
  }
  .class-135
  {
    color:#999999;
    word-wrap:break-word;
    display:inline-block;
    animation-duration:1s;
    font-size:14px;
    line-height:1.4;
  }
  .class-136
  {
    color:#333333;
    word-wrap:break-word;
    font-weight:bold;
    display:inline-block;
    animation-duration:1s;
    font-size:16px;
    line-height:1.4;
    margin-top:5px;
  }
  @media (max-width: 768px){
    .class-1
    {
      padding-right:12px;
      box-sizing:border-box;
      margin-right:auto;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:12px;
      flex-wrap:wrap;
      padding-top:12px;
      height:200px;
      max-width:100%;
      flex-direction:column;
      margin-left:auto;
      padding-left:12px;
    }
    .class-2
    {
      padding-right:12px;
      box-sizing:border-box;
      margin-right:auto;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:12px;
      flex-wrap:wrap;
      padding-top:12px;
      height:200px;
      margin-left:auto;
      padding-left:12px;
    }
    .class-3
    {
      padding-right:8px;
      box-sizing:border-box;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:8px;
      padding-top:8px;
      height:80px;
      width:80px;
      padding-left:8px;
    }
    .class-4
    {
    }
    .class-5
    {
    }
    .class-6
    {
    }
    .class-7
    {
    }
    .class-8
    {
    }
    .class-9
    {
    }
    .class-10
    {
    }
    .class-11
    {
    }
    .class-12
    {
    }
    .class-13
    {
    }
    .class-14
    {
    }
    .class-15
    {
    }
    .class-16
    {
    }
    .class-17
    {
    }
    .class-18
    {
    }
    .class-19
    {
    }
    .class-20
    {
    }
    .class-21
    {
    }
    .class-22
    {
    }
    .class-23
    {
    }
    .class-24
    {
    }
    .class-25
    {
    }
    .class-26
    {
    }
    .class-27
    {
    }
    .class-28
    {
    }
    .class-29
    {
    }
    .class-30
    {
    }
    .class-31
    {
    }
    .class-32
    {
    }
    .class-33
    {
    }
    .class-34
    {
    }
    .class-35
    {
    }
    .class-36
    {
    }
    .class-37
    {
    }
    .class-38
    {
    }
    .class-39
    {
    }
    .class-40
    {
    }
    .class-41
    {
    }
    .class-42
    {
    }
    .class-43
    {
    }
    .class-44
    {
    }
    .class-45
    {
      text-shadow:#000 3px 4px 5px;
    }
    .class-46
    {
      text-shadow:#000 3px 4px 5px;
      font-size:32px;
    }
    .class-47
    {
    }
    .class-48
    {
      text-shadow:#000 3px 4px 5px;
    }
    .class-49
    {
      text-shadow:#000 3px 4px 5px;
      font-size:32px;
    }
    .class-50
    {
    }
    .class-51
    {
      text-shadow:#000 3px 4px 5px;
    }
    .class-52
    {
      text-shadow:#000 3px 4px 5px;
      font-size:32px;
    }
    .class-53
    {
    }
    .class-54
    {
      text-shadow:#000 3px 4px 5px;
    }
    .class-55
    {
      text-shadow:#000 3px 4px 5px;
      font-size:32px;
    }
    .class-56
    {
      padding-right:8px;
      box-sizing:border-box;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:8px;
      padding-top:8px;
      height:80px;
      max-width:100%;
      width:80px;
      padding-left:8px;
    }
    .class-57
    {
      padding-right:8px;
      box-sizing:border-box;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:8px;
      padding-top:8px;
      height:80px;
      max-width:100%;
      width:80px;
      padding-left:8px;
    }
    .class-58
    {
      padding-right:8px;
      box-sizing:border-box;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:8px;
      padding-top:8px;
      height:80px;
      flex-direction:column;
      width:80px;
      padding-left:8px;
    }
    .class-59
    {
      padding-right:8px;
      box-sizing:border-box;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:8px;
      padding-top:8px;
      height:80px;
      flex-direction:column;
      width:80px;
      padding-left:8px;
    }
    .class-60
    {
      color:#333333;
      font-size:16px;
      line-height:1.5;
    }
    .class-61
    {
    }
    .class-62
    {
    }
    .class-63
    {
    }
    .class-64
    {
    }
    .class-65
    {
      padding-right:20px;
      padding-left:20px;
    }
    .class-66
    {
    }
    .class-67
    {
    }
    .class-68
    {
    }
    .class-69
    {
      font-size:14px;
    }
    .class-70
    {
    }
    .class-71
    {
      padding-right:20px;
      padding-left:20px;
    }
    .class-72
    {
    }
    .class-73
    {
    }
    .class-74
    {
    }
    .class-75
    {
      font-size:14px;
    }
    .class-76
    {
    }
    .class-77
    {
      padding-right:20px;
      padding-left:20px;
    }
    .class-78
    {
    }
    .class-79
    {
    }
    .class-80
    {
    }
    .class-81
    {
      font-size:14px;
    }
    .class-82
    {
    }
    .class-83
    {
      padding-right:20px;
      padding-left:20px;
    }
    .class-84
    {
    }
    .class-85
    {
    }
    .class-86
    {
    }
    .class-87
    {
      font-size:14px;
    }
    .class-88
    {
    }
    .class-89
    {
      padding-right:12px;
      box-sizing:border-box;
      margin-right:auto;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:12px;
      flex-wrap:wrap;
      padding-top:12px;
      height:200px;
      margin-left:auto;
      padding-left:12px;
    }
    .class-90
    {
      padding-right:8px;
      box-sizing:border-box;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:8px;
      padding-top:8px;
      height:80px;
      flex-direction:column;
      width:80px;
      padding-left:8px;
    }
    .class-91
    {
      line-height:1.5;
    }
    .class-92
    {
      padding-right:8px;
      box-sizing:border-box;
      outline:1px dashed hsla(0, 0%, 66.7%, .7);
      padding-bottom:8px;
      padding-top:8px;
      height:80px;
      flex-direction:column;
      width:80px;
      padding-left:8px;
    }
    .class-93
    {
    }
    .class-94
    {
    }
    .class-95
    {
    }
    .class-96
    {
    }
    .class-97
    {
    }
    .class-98
    {
    }
    .class-99
    {
    }
    .class-100
    {
    }
    .class-101
    {
    }
    .class-102
    {
    }
    .class-103
    {
    }
    .class-104
    {
    }
    .class-105
    {
    }
    .class-106
    {
    }
    .class-107
    {
    }
    .class-108
    {
    }
    .class-109
    {
    }
    .class-110
    {
    }
    .class-111
    {
    }
    .class-112
    {
    }
    .class-113
    {
    }
    .class-114
    {
    }
    .class-115
    {
    }
    .class-116
    {
    }
    .class-117
    {
    }
    .class-118
    {
    }
    .class-119
    {
    }
    .class-120
    {
    }
    .class-121
    {
    }
    .class-122
    {
    }
    .class-123
    {
    }
    .class-124
    {
    }
    .class-125
    {
    }
    .class-126
    {
    }
    .class-127
    {
    }
    .class-128
    {
    }
    .class-129
    {
    }
    .class-130
    {
    }
    .class-131
    {
    }
    .class-132
    {
    }
    .class-133
    {
    }
    .class-134
    {
    }
    .class-135
    {
    }
    .class-136
    {
    }
  }
  #app{
    overflow-x: hidden;
  }
</style>
