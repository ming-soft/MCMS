<!-- 主页 -->
<!DOCTYPE html>
<html>
<head>
    <title>${app.appName}</title>
    <#include '/include/head-file.ftl'/>
    <script src="${base}/static/plugins/sockjs/1.4.0/sockjs.min.js"></script>
    <script src="${base}/static/plugins/stomp/2.3.3/stomp.min.js"></script>
    <!-- 此部分是铭飞平台MStroe的客户端（MStore不在铭飞开源产品范围），如果不需要使用MStore可以删除掉 -->
    <script src="https://cdn.mingsoft.net/ms/1.0/ms-web.umd.min.js"></script>
    <style>
        .to-ele {
            font-size: 18px;
            margin: -2px 9px 0px 3px
        }
    </style>
</head>
<body>
<#include "/reset-password.ftl"/>
<#include "/exit-system.ftl"/>
<div id="app" class="index" :class="theme">
    <el-container>
        <!--左侧菜单-->
        <el-aside class="ms-admin-menu-aside" v-cloak>
            <el-scrollbar style="height:100%">
                <el-menu :default-active="asideMenuActive" class="el-menu-vertical-demo"
                         text-color="rgba(255,255,255,1)" active-text-color="rgba(255,255,255,1)"
                         :collapse="collapseMenu" :unique-opened='true' ref='menu' @open="asideMenuOpen">
                    <div class="ms-admin-logo" :style="{display: 'flex','padding-left': (collapseMenu?'5px':'22px')}">
                        <img :src="ms.base+'/static/images/logo.png'"/>
                        <div class="class-1" v-show="!collapseMenu">
                            <div class="class-2">v</div>
                            5.1
                        </div>
                    </div>
                    <el-submenu :popper-class="['ms-admin-menu-aside-submenu',theme]" :index="menu.id+''"
                                :data-index="menu.id+''" v-for="(menu,i) in asideMenuList" :key='i'>
                        <template slot="title">
                            <i class='ms-admin-icon iconfont' :class="menu.modelIcon"></i>
                            <span>{{menu.modelTitle}}</span>
                        </template>
                        <!-- 子菜单 -->
                        <el-menu-item :index="sub.id+''" :data-index="sub.id"
                                      v-for="(sub,index) in getSubMenu(menu.id)"
                                      :key='sub.modelId' v-text="sub.modelTitle"
                                      @click.self='open(sub)'></el-menu-item>
                    </el-submenu>
                    <!-- 收缩按钮 -->
                </el-menu>
            </el-scrollbar>
        </el-aside>
        <#--右侧内容-->
        <el-container class="ms-admin-container" v-cloak>
            <!--头部-->
            <el-header class="ms-admin-header" v-cloak>
                <#--展示合并菜单-->
                <div class="ms-admin-header-menu-shrink" @click="collapseMenu = !collapseMenu">
                    <i class="iconfont"
                       :class="collapseMenu?'icon-liebiaoxiangyou':'icon-shousuo'"></i>
                </div>
                <!--头部menu-->
                <el-menu menu-trigger="hover" class="ms-admin-header-menu" :default-active="headMenuActive"
                         mode="horizontal">
                    <el-submenu style="height: 100%;">

                        <template slot="title">
                            <i class="iconfont icon-gezi" style="font-size: 17px;margin-right:8PX"></i>
                            <span>功能大全</span>
                        </template>
                        <div class="ms-admin-header-menu-all">
                            <li class="ms-admin-header-menu-all-item" v-for="(item,index) of parentMenuList"
                                :key='index' @click='openMenu(item,index)'>
                                <i class="iconfont" :class="item.modelIcon" style="padding-right: 4px"></i>
                                <div style="width:80px">{{item.modelTitle}}</div>
                                <div style="float: right;width: 18px;">
                                    <template>
                                        <i v-if="markList.find(function(x) {
                    return x.title == item.modelTitle
                })!=undefined" @click="cancelMarkMenu(item.modelTitle)"
                                           class='el-icon-star-on'></i>
                                        <i v-else class='el-icon-star-off '
                                           @click="markMenu(item.modelTitle,item.modelIcon)"></i>
                                    </template>
                                </div>

                            </li>
                        </div>
                    </el-submenu>
                </el-menu>
                <!--头部右侧-->
                <div class="ms-admin-header-right">
                    <el-menu menu-trigger="hover" class="ms-admin-header-menu"
                             mode="horizontal">
                        <el-submenu style="height: 100%;" popper-class="ms-admin-header-menu-item">
                            <template slot="title">
                                <i class="iconfont icon-pifu" style="font-size: 18px"></i>
                            </template>
                            <el-menu-item @click="handleCommand('ms-theme-light')"
                                          style="display: flex;align-items: center">
                                <div style="height: 18px;width: 18px;background-color: rgba(64,158,255,1);margin-right: 7px;border-radius: 2px;"></div>
                                <span>浅色系</span>
                            </el-menu-item>
                            <el-menu-item @click="handleCommand('ms-theme-dark')"
                                          style="display: flex;align-items: center">
                                <div style="height: 18px;width: 18px;background-color: rgba(56,58,63,1);margin-right: 7px;border-radius: 2px;"></div>
                                <span>深色系</span>
                            </el-menu-item>
                        </el-submenu>
                    </el-menu>
                    <#--                    语言切换-->
                    <#--                    <el-dropdown @command="handleLanguageClick">-->
                    <#--                      <span class="el-dropdown-link" >-->
                    <#--                         {{locale.text}}<i class="el-icon-arrow-down el-icon--right"></i>-->
                    <#--                      </span>-->
                    <#--                        <el-dropdown-menu slot="dropdown">-->
                    <#--                            <el-dropdown-item v-for="(item,index) in localeCommands" :command="item">{{item.text}}</el-dropdown-item>-->
                    <#--                        </el-dropdown-menu>-->
                    <#--                    </el-dropdown>-->

                    <el-menu menu-trigger="hover" class="ms-admin-header-menu " mode="horizontal">
                        <el-submenu popper-class="ms-admin-header-menu-item">
                            <template slot="title">
                                <span class="ms-admin-people-head"
                                      v-text="peopleInfo.managerName && peopleInfo.managerName.substr(0, 2)"></span>
                                <span v-text='peopleInfo.managerName'></span>
                            </template>
                            <el-menu-item @click="handleCommand('ms-theme-light')"
                                          style="display: flex;align-items: center" @click.native='openModal'>
                                <i class="el-icon-key"></i>
                                <span slot="title">修改密码</span>

                            </el-menu-item>
                            <el-menu-item @click="handleCommand('ms-theme-dark')"
                                          style="display: flex;align-items: center" @click.native='openModal'>
                                <i class="el-icon-switch-button"></i>
                                <span slot="title">退出</span>
                            </el-menu-item>
                        </el-submenu>
                    </el-menu>
                    <!--mstore按钮-->
                    <ms-store client="${client}"></ms-store>
                </div>

            </el-header>
            <!--内容-->
            <el-main class="ms-admin-main">
                <!--选项卡-->
                <el-tabs class="ms-admin-tabs" v-model="currentTab" type="card" closable @tab-remove="closeTab"
                         @tab-click='tabClick'>
                    <el-tab-pane v-for="(item, index) in editableTabs" :key="index" :label="item.modelTitle"
                                 :name="item.modelTitle"
                                 :data-id='item.id' :data-modelId='item.modelId'>
                        <keep-alive>
                            <iframe :src='item.isStore?item.modelUrl:ms.manager+"/"+item.modelUrl+(item.modelUrl.indexOf("?")==-1?"?":"&")+"id="+item.id+"&modelCode="+item.modelCode+"&modelTitle="+encodeURI(item.modelTitle)'
                                    :ref="item.modelTitle"></iframe>
                        </keep-alive>
                    </el-tab-pane>
                </el-tabs>
            </el-main>
        </el-container>
    </el-container>
</div>
</body>

</html>
<script>
    var indexVue = new Vue({
        el: "#app",
        data: {
            code: '',
            locale: {
                text: '中文',
                language: 'ch',
            },
            localeCommands: [
                {
                    text: '中文',
                    language: 'ch',
                },
                {
                    text: 'English',
                    language: 'en',
                }
            ],
            menuList: [], //菜单接口数据
            asideMenuList: [], //侧边菜单
            parentMenuList: [], //一级菜单
            subMenuList: [], //二级菜单 所有
            unreadTotal: 0,//未读消息数量
            messageList: [],//消息列表
            mainParentMenuList: [], //头部菜单显示主要的选项
            loginDown: false, //登录下拉
            asideMenuActive: "", //左侧选中菜单
            headMenuActive: '', //头部菜单激活
            editableTabsValue: '',
            messageTypeList: [],
            editableTabs: [{"modelTitle": "工作台", "modelUrl": "main.do"}], //当前打开的tab页面
            shortcutMenu: false, //快捷菜单显示状态
            collapseMenu: false, //菜单折叠，false不折叠
            currentTab: '工作台', //当前激活tab的name
            tabIndex: 1,
            markList: [
                {title: "权限管理", icon: "icon-wode", hide: true},
                {title: "系统设置", icon: "icon-xitongguanli", hide: true},
                {title: "内容管理", icon: "icon-neirongguanli", hide: true},
                {title: "会员中心", icon: "icon-huiyuanzhongxin", hide: true},
                {title: "自定义管理", icon: "icon-zidingyiguanli", hide: true},
            ],
            //登录用户信息
            peopleInfo: {
                managerName: '', //账号
                managerNickName: '',
            },
            mstore: {},
            theme: 'ms-theme-light',
            callbackFun: {},
        },
        computed: {
            messageType: function (type) {
                var that = this
                return function (type) {
                    var dict = that.messageTypeList.find(function (x) {
                        return x.dictValue == type;
                    });
                    if (dict) {
                        return dict.dictLabel;
                    }
                    return '';

                }
            }
        },
        watch: {
            menuList: function (n, o) {
                var that = this;
                n && n.forEach(function (item, index) {
                    item.modelId ? that.subMenuList.push(item) : that.parentMenuList.push(item)
                })
            },
            parentMenuList: function (n, o) {
                var that = this
                this.mainParentMenuList = n.slice(0, 5);
                this.asideMenuList = n.filter(function (f) {
                    return that.markList.find(
                        function (x) {
                            return x.title == f['modelTitle']
                        }) != undefined
                })
            },
            editableTabs: {
                handler: function (n, o) {
                    if (n.length) {
                        var that = this;
                        if (!document.querySelector('.el-icon-refresh')) {
                            var i = document.createElement('i');
                            i.className = "el-icon-refresh ms-admin-refresh"
                            i.title = "点击刷新当前页"
                            i.addEventListener('click', function () {
                                var index = null
                                Object.keys(that.$refs).forEach(function (item, i) {
                                    item.indexOf(that.currentTab) > -1 ? index = i : ''
                                }, that)
                                that.$refs[Object.keys(that.$refs)[index]][0].contentDocument.location.reload(true)
                            })
                            document.querySelector('.el-tabs__header').insertBefore(i, document.querySelector('.el-tabs__nav-wrap'))
                        }
                    } else {
                        if (document.querySelector('.ms-admin-refresh')) {
                            document.querySelector('.el-tabs__header').removeChild(document.querySelector('.ms-admin-refresh'))
                        }
                    }
                },
                deep: true
            }
        },
        methods: {
            handleLanguageClick: function (val) {
                this.locale.text = val.text
                this.locale.language = val.language
                //语言切换
                console.log(val)
            },
            getAuthorization: function () {

            },

            markMenu: function (title, icon) {
                var menu = {
                    title: title,
                    icon: icon,
                }
                this.markList.push(menu);
                localStorage.setItem("markList", JSON.stringify(this.markList))
                this.callbackFun();
            },
            cancelMarkMenu: function (title) {
                var index = this.markList.findIndex(function (x) {
                    return x.title == title
                });
                this.markList.splice(index, 1);
                localStorage.setItem("markList", JSON.stringify(this.markList))
            },
            handleMessage: function () {
                this.openMenuInTitle('收到消息')
            },
            handleCommand: function (theme) {
                this.theme = theme;
                localStorage.setItem("theme", theme);
            },
            // 菜单列表
            list: function () {
                var that = this;
                ms.http.get(ms.manager + "/model/list.do")
                    .then(function (data) {
                        that.menuList = data.data.rows
                    }, function (err) {
                        that.$message.error(err);
                    })
            },
            asideMenuOpen: function (index, indexPath) {
            },
            // 菜单打开页面
            open: function (sub) {
                var that = this
                var result = '';
                result = this.editableTabs.some(function (item, index) {
                    return item.modelTitle == sub.modelTitle
                })

                if (sub.syncStoreUrl) {
                    //sub.modelUrl = "http://store.web.i.mingsoft.net/#/?client=localhost:8080//ms";
                    sub.modelUrl = sub.syncStoreUrl;
                    sub.modelTitle = 'mstore';
                    sub.isStore = true;
                    !result ? this.editableTabs.push(sub) : ""
                } else {
                    !result ? this.editableTabs.push(sub) : ""
                }

                this.currentTab = sub.modelTitle;
                this.headMenuActive = sub.modelId
                this.$nextTick(function () {
                    that.asideMenuActive = sub.id;
                })
                // 处理其他逻辑
                setTimeout(function () {
                    if (document.querySelector('.el-tabs__nav-prev')) {
                        document.querySelector('.el-tabs__nav-wrap').style.padding = '0 40px'
                    } else {
                        document.querySelector('.el-tabs__nav-wrap').style.padding = '0'
                    }
                }, 16)
            },
            tabClick: function (tab) {
                this.asideMenuActive = tab.$el.dataset.id
                this.headMenuActive = tab.$el.dataset.modelId
                console.log(this.editableTabs)
            },
            // 获取当前菜单的子菜单
            getSubMenu: function (id) {
                var result = [];
                var that = this;
                that.subMenuList && that.subMenuList.forEach(function (item) {
                    item.modelId == id ? result.push(item) : ''
                })
                return result;
            },
            //关闭tab标签页
            closeTab: function (targetName) {
                var that = this;
                // 关闭的面板是当前激活面板
                if (that.currentTab == targetName) {
                    var modelId = null
                    that.editableTabs.forEach(function (tab, index, arr) {
                        if (tab.modelTitle == targetName) {
                            modelId = arr[index].modelId
                            var nextTab = arr[index + 1] || arr[index - 1];
                            if (nextTab) {
                                that.currentTab = nextTab.modelTitle
                                that.asideMenuActive = nextTab.id
                                that.headMenuActive = nextTab.modelId
                            }
                        }
                    })
                }
                // 去掉关闭的tab
                that.editableTabs = that.editableTabs.filter(function (tab) {
                    return tab.modelTitle !== targetName
                })

                // 关闭左侧父菜单
                if (that.editableTabs.length) {
                    var result = that.editableTabs.every(function (item) {
                        return item.modelId !== modelId
                    })
                    if (result) {
                        that.asideMenuList.forEach(function (menu, index, arr) {
                            if (menu.id == modelId) {
                                var flag = false;
                                that.markList.forEach(function (item, index, array) {
                                    if (item.title == menu.modelTitle) {
                                        flag = true;
                                    }
                                })
                                if (!flag) {
                                    arr.splice(index, 1);
                                }
                            }
                        })
                    }
                } else {
                    that.asideMenuList = []
                }

                // 判断是否出现左右箭头
                setTimeout(function () {
                    if (document.querySelector('.el-tabs__nav-prev')) {
                        document.querySelector('.el-tabs__nav-wrap').style.padding = '0 40px'
                    } else {
                        document.querySelector('.el-tabs__nav-wrap').style.padding = '0'
                    }
                }, 16)
            },
            openParentMenuInTitle: function (title) {
                var data = this.parentMenuList.find(function (menu) {
                    return menu.modelTitle == title
                })
                data && this.openMenu(data)
            },
            // 头部导航打开菜单
            openMenu: function (menu, index) {
                this.asideMenuList.some(function (item, index) {
                    return item.id == menu.id
                }) || this.asideMenuList.push(menu)
                // this.getSubMenu(menu.id)[0] && this.$refs.menu.open(this.getSubMenu(menu.id)[0].modelTitle);
                var children = [];
                this.menuList.forEach(function (tab) {
                    if (tab.modelId == menu.id) {
                        children.push(tab)
                    }
                })
                this.currentTab = children[0] && children[0].modelTitle;
                this.open(children[0]);
                var that = this;
                setTimeout(function () {
                    that.shortcutMenu = false
                }, 50)
                that.$nextTick(function () {
                    that.$refs.menu.open(String(menu.id))
                })
            },
            managerGet: function () {
                var that = this;
                ms.http.get(ms.manager + "/basic/manager/get.do")
                    .then(function (data) {
                        that.peopleInfo = data.data
                        resetPasswordVue.resetPasswordForm.managerName = that.peopleInfo.managerName
                    }, function (err) {
                        that.$message.error(err);
                    })
            },
            exitSystem: function () {
                this.$confirm('是否确认退出账号？', '退出系统', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    cancelButtonClass: 'el-button--mini',
                    confirmButtonClass: 'el-button--mini',
                    type: 'warning'
                }).then(function () {
                    ms.http.get(ms.manager + "/loginOut.do")
                        .then(function (data) {
                            isShow = false;
                            location.href = ms.manager + "/login.do";
                        }, function (err) {
                            that.$message.error(err.msg);
                        })
                })
            },
            //  打开修改密码，退出的模态框
            openModal: function () {
                event.target.innerText.indexOf('修改密码') > -1 ?
                    resetPasswordVue.isShow = true : this.exitSystem();
            },
            // 显示图标
            formmateIcon: function (icon) {
                return "<i class='ms-admin-icon iconfont'></i>"
            },
            //打开指定标题
            openMenuInTitle: function (title) {
                this.open(this.menuList.find(function (x) {
                    return x.modelTitle == title
                }))
            },
            //消息显示
            getMessage: function () {
                var that = this
                ms.http.post(ms.manager + "/message/myMessage/list.do", {pageSize: 9999, mlStatus: 'unread'})
                    .then(function (res) {
                        if (res.result) {
                            that.messageList = res.data.rows.splice(0, 5);
                            that.unreadTotal = res.data.total;
                        }
                    }, function (err) {
                        that.$message.error(err);
                    })

            },
            dictList: function () {
                var that = this;
                ms.http.get(ms.base + '/mdiy/dict/list.do', {dictType: '消息类型', pageSize: 99999}).then(function (res) {
                    if(res.result){
                        res = res.data;
                        that.messageTypeList = res.rows;
                    }
                }).catch(function (err) {
                    console.log(err);
                });
            },
            addCallBackFun: function (fun) {
                this.callbackFun = fun;
            }
        },
        created: function () {
            this.getAuthorization();
            var markList = localStorage.getItem("markList");
            if (markList) {
                this.markList = JSON.parse(markList)
            }
            localStorage.setItem("markList", JSON.stringify(this.markList))
        },
        mounted: function () {
            // this.getMessage();
            this.dictList();
            if (localStorage.getItem("theme")) {
                this.theme = localStorage.getItem("theme");
            }
            //setInterval(this.getMessage,3000)
            // 菜单列表
            this.list();
            //获取登录用户信息
            this.managerGet();
        },
    })
</script>
<style>

    .ms-admin-logo {
        display: flex;
        align-items: center;
        overflow: hidden;
    }

    .ms-admin-logo img {
        padding: 14px 0;
        width: 50px;
    }

    .ms-admin-logo > div {
        display: flex;
        align-items: center;
    }

    .ms-admin-logo > div span {
        margin-top: -6px;
        position: absolute;
        margin-left: 10px;
        font-size: 12px;

    }

    .ms-admin-logo .iconfont {
        color: #fff;
        margin-left: auto;
        margin-right: 20px;
        cursor: pointer;
    }


    .ms-admin-header-right {
        margin-left: auto;
        min-width: 200px;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        padding: 0;
        line-height: 1;
    }

    .ms-admin-header-right .ms-admin-people-head {
        width: 30px !important;
        height: 30px !important;
        margin-right: 10px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #0099ff;
        color: #fff;
    }

    .ms-admin-header-menu-shrink {
        width: 64px;
        display: flex;
        justify-content: center;
        align-items: center;
        line-height: 50px;
        border-right: 1px solid rgba(238, 238, 238, 1);
        cursor: pointer;
    }

    .ms-admin-header-menu-shrink:hover {
        background: rgba(250, 250, 250, 0.2);
    }

    .el-menu-vertical-demo:not(.el-menu--collapse) {
        width: 180px;
        height: 100vh;
    }

    .el-menu--collapse {
        height: 100vh;
    }

    .ms-admin-menu-aside {
        width: auto !important;
        height: 100%;
        position: relative;
        overflow: visible;
    }


    .ms-admin-menu-aside .ms-admin-menu .el-menu--inline .is-active {
        border-left: 2px solid #0099ff;
    }




    .ms-admin-menu-aside .ms-menu-expand i {
        font-weight: bolder;
        font-size: 14px;
        color: #333;
        position: absolute;
        transform: rotate(90deg);
        right: 40%;
    }

    .ms-admin-menu-aside .ms-menu-expand::before {
        border-color: transparent transparent #eee;
        border-style: none solid solid;
        border-width: 0 30px 22px;
        content: "";
        display: block;
        height: 0;
        left: -10px;
        width: 30px;
    }



    .ms-admin-menu-aside .el-submenu__title,
    .ms-admin-menu-aside .el-menu-item {
        color: rgba(255, 255, 255, 1);
        height: 40px;
        line-height: 40px;
    }

    .ms-admin-menu-aside .el-submenu__title i {
        color: inherit;
    }

    .ms-admin-menu-aside .el-submenu__title .iconfont {
        font-size: 19px !important;
    }

    .ms-admin-menu-aside .el-submenu.is-active .el-submenu__title {
        color: rgba(255, 255, 255, 1) !important;
    }


    .ms-admin-header {
        display: flex;
        padding: 0;
        background-color: rgba(255, 255, 255, 1);
        height: 50px !important;
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
        z-index: 1;
    }

    .ms-admin-header .ms-admin-header-menu {
        border-bottom: none;
        position: relative;
    }

    .ms-admin-header .ms-admin-header-menu > .ms-admin-menu-item > * {
        height: 50px !important;
        line-height: 50px !important;
        border-bottom: none !important;
        font-size: 1em;
    }



    .ms-admin-header .ms-admin-header-menu .ms-admin-shortcut-menu > li {
        margin: 0;
        padding: 0 20px;
        text-align: left;
        display: -webkit-inline-box;
        display: inline-block;
        height: 50px;
        line-height: 50px;
        font-weight: normal;
        font-size: 14px;
        color: #333;
    }

    .ms-admin-header .ms-admin-header-menu .ms-admin-shortcut-menu > li:hover {
        cursor: pointer;
        color: #0099ff;
    }



    .ms-admin-header-menu .el-submenu__title {
        height: 50px !important;
        line-height: 50px !important;
        display: flex;
        align-items: center;

    }


    .ms-admin-header-menu .el-submenu__title:hover {
        background-color: #F2F6FC !important;
        color: #409EFF !important;
    }

    .ms-admin-header-menu .el-submenu__title:hover i {
        color: #409EFF !important;
    }

    .ms-admin-header-menu .el-submenu__icon-arrow {
        margin-top: 4px !important;
    }

    .ms-admin-header-menu-item .el-menu-item:hover {
        background-color: #F2F6FC !important;
        color: #409EFF !important;
    }

    .ms-admin-header-menu-item .el-menu-item:hover i {
        color: #409EFF !important;
    }


    .ms-admin-header-menu-all {
        width: 560px;
        height: auto;
        background: rgba(255, 255, 255, 1);
        border-radius: 2px;
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        line-height: 40px;
    }

    .ms-admin-header-menu-all .iconfont {
        font-size: 17px;
    }

    .ms-admin-header-menu-all .ms-admin-header-menu-all-item {
        display: flex;
        width: 25%;
        justify-content: center;
        align-items: center;
        cursor: pointer;
    }

    .ms-admin-header-menu-all .ms-admin-header-menu-all-item .el-icon-star-on {
        color: #ccc;
        font-size: 17px;
        margin-left: -1px;
        margin-top: 1px;
    }

    .ms-admin-header-menu-all .ms-admin-header-menu-all-item .el-icon-star-on:hover {
        color: rgba(64, 158, 255, 1);
    }

    .ms-admin-header-menu-all .ms-admin-header-menu-all-item .el-icon-star-off {
        color: #ccc;
    }

    .ms-admin-header-menu-all .ms-admin-header-menu-all-item .el-icon-star-off:hover {
        color: rgba(64, 158, 255, 1);
    }

    .ms-admin-header-menu-all .ms-admin-header-menu-all-item:hover {
        color: rgba(64, 158, 255, 1);
    }


    .ms-admin-menu-aside-submenu .el-menu-item {
        line-height: 40px;
        height: 40px;
    }

    .el-submenu__title * {
        vertical-align: top;
    }

    .ms-admin-login-theme .el-dropdown-menu__item {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
    }

    .el-tabs__nav .el-tabs__item:nth-child(1) span {
        display: none;
    }

    .el-tabs__item.is-active {
        background-color: rgba(255, 255, 255, 1);
    }

    .el-menu {
        border-right: 0px;
    }

    .ms-admin-logo .class-1 {
        color: white;
        padding-top: 8px;
        color: #FFFFFF;
        word-wrap: break-word;
        font-family: MicrosoftYaHei-Bold;
        font-weight: bold;
        font-style: italic;
    }

    .ms-admin-logo .class-2 {
        font-size: 12px;
        font-weight: normal;
    }


    .top-operate-select .el-menu--popup {
        width: 162px;
        min-width: 162px;
    }


    .ms-admin-container {
        height: auto;
    }

    .ms-admin-container > .ms-admin-main {
        padding: 0;
        background-color: #fff;
        z-index: 0;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs {
        height: calc(100vh - 50px);
        display: flex;
        flex-direction: column;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .el-tabs__content {
        height: 100%;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .el-tabs__content .el-tab-pane {
        height: 100%;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .el-tabs__header {
        background: #fafafa;
        margin-bottom: 0;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .el-tabs__header .el-tabs__nav-scroll .el-tabs__nav {
        border-left: none;
        border-radius: 0;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .ms-admin-refresh {
        float: right;
        width: 40px;
        height: 40px;
        text-align: center;
        border-left: 1px solid #e6e6e6;
        cursor: pointer;
        position: relative;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .ms-admin-refresh::before {
        position: absolute;
        left: 34%;
        top: 50%;
        transform: translateY(-50%);
        color: #999;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .el-tabs__nav-next,
    .ms-admin-container > .ms-admin-main .ms-admin-tabs .el-tabs__nav-prev {
        width: 40px;
        height: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .el-tabs__nav-next {
        border-left: 1px solid #e6e6e6;
    }

    .ms-admin-container > .ms-admin-main .ms-admin-tabs .el-tabs__nav-prev {
        border-right: 1px solid #e6e6e6;
    }

    .ms-admin-container > .ms-admin-main iframe {
        width: 100%;
        height: 100%;
        border: none !important;
    }
</style>
