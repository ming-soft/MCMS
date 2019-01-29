//点击页面其他位置头部菜单收缩
$(document).bind("click",function(e){
    var target = $(e.target);
    if(target.closest(".menu-default").length == 0){
        manager.topMenu.initTop();
    }
})
//浏览器窗口调整事件
$(window).resize(function () {  
    $(".categoryTree").height($(document).height());
    $("#listFrame").height($(document).height());

     $('.easyui-tabs').tabs("resize",{
        width: $('.easyui-tabs').parent().width(),
        fit:true,
        scrollDuration:1000
     });  
 }) 
$(function(){
    //左侧菜单滚动条，鼠标上移显示
    $(".ms-menu,.ms-content-menu").mouseover(function () {
        $(this).css("overflow-y","auto");
    });
    $(".ms-menu,.ms-content-menu").mouseleave(function () {
        $(this).css("overflow-y","hidden");
    });

    //收缩左侧菜单
    $(".slideMenu").click(function(){
        var obj = $(this);
        if ($(".ms-menu").css("left") == "0px") {
            //修改图标
            obj.children(".icon-open").show();
            obj.children(".icon-close").hide();
            $(".ms-menu-div").css("position","absolute");
            $(".ms-menu,.ms-menu-div").animate({left:'-180px'},100)
            //改变右侧部分宽度
            $('.easyui-tabs').tabs("resize",{
                width:$('.easyui-tabs').parent().width()
            });
        } else {
            //修改图标
            obj.children(".icon-open").hide();
            obj.children(".icon-close").show();
            $(".ms-menu-div").css("position","relative");
            $(".ms-menu,.ms-menu-div").animate({left:'0px'},50)

            //恢复右侧部分宽度
            $('.easyui-tabs').tabs("resize",{
                width:$('.easyui-tabs').parent().width(),
                fit:true,
                scrollDuration:1000
            });
        }
    })

    //点击左侧菜单添加选项卡
    $(".ms-menu").delegate(".ms-menu-child a","click",function(){
        $(".easyui-tabs").show();
        $(".wellcome").hide();
        $(".ms-menu-child a").removeClass("active");
        $(this).addClass("active");
        var title=$(this).data("title");
        var content=$(this).data("url");
        var id=$(this).data("id");
        if (!$('.easyui-tabs').tabs('exists', title)) {
            $('.easyui-tabs').tabs('add', {
                title: title,
                content: '<iframe src='+content+' frameborder="0" height="100%" width="100%" id="mainFrame'+id+'" name="mainFrame'+id+'"></iframe>',
                closable: true,
                tools:[{
                    iconCls:'icon-mini-refresh',
                    title:"刷新当前选项卡",
                    handler:function(){
                       $('#mainFrame'+id).attr('src', $('#mainFrame'+id).attr('src'));
                    }
                }]
            });

            
        } else {
            $('.easyui-tabs').tabs('select', title);
        }
    })


    //用户在切换选项卡时，和导航树保持同步
    $('.easyui-tabs').tabs({
        onSelect: function(title){
            var _select = $(".easyui-tabs").tabs("getSelected");
            var obj = _select.panel("options").tab;
            //循环左侧菜单里每个菜单的text进行选项卡的title进行对比
            $(".ms-menu").find("li").each(function(){
                var target = $(this);
                if(target.text() == obj.text()){
                    $(".ms-menu-child a").removeClass("active");
                    //左侧对应菜单展开选中
                    $(".ms-menu-none").hide();
                    target.parent().parent().slideDown();
                    target.parent().slideDown();
                    target.find("a").addClass("active");
                    //头部对应一级菜单进行选中
                    $(".ms-menu-list").find("li").removeClass("active").each(function(){
                        if(target.parent().parent().data("model-id") == $(this).data("model-id")){
                            $(this).addClass("active");
                        }
                    })
                }
            })
        }
    });
    
    
    //当关闭最后一个选项卡时，隐藏选项卡页面显示主界面
    $('.easyui-tabs').tabs({
        onClose:function(){
            if($('.easyui-tabs').tabs('tabs').length==0){
                $(".wellcome").show();
                $(".easyui-tabs").hide();
                $(".ms-menu-child a").removeClass("active");
                $(".ms-menu-list").find("li").removeClass("active")
            }
            
        }
    })
})

//MStore做的计时循环特效
window.setInterval(showMstore, 1000); 
function showMstore(){ 
    $(".ms-top-mstore").find(".animated").addClass("rubberBand")
} 
window.setInterval(hiddenMstore, 1500); 
function hiddenMstore(){ 
    $(".ms-top-mstore").find(".animated").removeClass("rubberBand")
}   

var manager = {
    /*头部菜单操作*/
    topMenu:{
        initEvent: function() {
            $("*[data-ms-*]").each()
        },
        /*追加头部菜单*/
        initMenu: function(json) {
            $("#ms-menu-list-tmpl").tmpl(json).appendTo(".ms-menu-list");
            if($(".ms-menu-list").children().length>5){
                $(".openMenu").show();
            }


            //将左侧菜单追加，只是隐藏了
            $("#ms-menu-tmpl").tmpl(json).appendTo(".ms-menu");
            $(".ms-menu-parent").each(function(n) {
                var arr = new Array;
                for (i = 0; i < json.length; i++)  json[i].modelModelId == $(this).data("model-id") && arr.push(json[i])
                        //alert(arr)
                $("#ms-menu-child-tmpl").tmpl(arr).appendTo($(this).find("ul:first"))
                
            })
        },

        /*头部菜单点击收缩效果*/
        topMenuOpen: function(target,menuShow){
            var _height=$(".ms-menu-list").height();
            if(target.parent().hasClass(menuShow)){
                this.initTop();
            }else{
                target.parent().addClass(menuShow);
                $('.'+menuShow).height(_height);
            }
        },
        /*初始化头部菜单*/
        initTop:function(){
            $(".menu-default").height("50px");
            $(".menu-default").removeClass("menu-show");
        },
        /*点击头部菜单展示二级菜单*/
        showChildMenu:function(target,json){
            var _json = {"modelTitle":target.text(),"modelIcon":target.data("model-icon"),"modelId":target.data("model-id")};
            var arr = new Array;
            $(".ms-menu-list").find("li").removeClass("active");
            target.addClass("active");

            //显示左侧菜单
            if ($(".ms-menu").css("display") == "none") {
                $(".slideMenu").children(".icon-open").hide();
                $(".slideMenu").children(".icon-close").show();
                $(".ms-menu,.ms-menu-div").show();
                //恢复右侧部分宽度
                $('.easyui-tabs').tabs("resize",{
                    width:$('.easyui-tabs').parent().width(),
                    fit:true,
                    scrollDuration:1000
                });
            }

            $(".ms-menu-parent").each(function(){
                if(target.data("model-id")==$(this).data("model-id")){
                    $(this).show();
                    $(".ms-menu-parent").find("ul").slideUp();
                    $(this).find("ul").slideDown();

                    //默认打开当前模块的第一个菜单项
                    $(".easyui-tabs").show();
                    $(".wellcome").hide();
                    var title=$(this).find("ul li:eq(0) a").data("title");
                    var content=$(this).find("ul li:eq(0) a").data("url");
                    var id = $(this).find("ul li:eq(0) a").data("id");
                    if (!$('.easyui-tabs').tabs('exists', title)) {
                        $('.easyui-tabs').tabs('add', {
                            title: title,
                            content: '<iframe src='+content+' frameborder="0" height="100%" width="100%" id="mainFrame'+id+'" name="mainFrame'+id+'"></iframe>',
                            closable: true,
                            tools:[{
                                iconCls:'icon-mini-refresh',
                                handler:function(){
                                    $('#mainFrame'+id).attr('src', $('#mainFrame'+id).attr('src'));
                                }
                            }]
                        });                
                    } else {
                        $('.easyui-tabs').tabs('select', title);
                    }
                }
            })
            this.initTop();
        },

    },
        
    /*左侧菜单操作*/
    leftMenu:{
        /*左侧菜单点击收缩效果*/
        leftMenuOpen:function(target,menu){
            menu.slideToggle();

        },

    },

        
}

$(function(){

    //当头部菜单超过5个时，点击展开头部菜单
    $(".openMenu").click(function(){
        manager.topMenu.topMenuOpen($(this),"menu-show");
    })
    
    //点击展开左侧菜单子菜单
    $(".ms-menu").delegate(".ms-menu-parent-title","click",function(){
        var menu = $(this).parent().siblings(".ms-menu-child");
        manager.leftMenu.leftMenuOpen($(this),menu);
    })

    //移除左侧菜单
    $(".ms-menu").delegate(".ms-menu-parent","mouseover",function(){
        $(".closeMenu").hide();
        $(this).find(".closeMenu").show();
    })
    $(document).bind("mouseover",function(e){
        var target = $(e.target);
        if(target.closest(".ms-menu-parent").length == 0){
            $(".closeMenu").hide();
        }
    })
    //关闭左侧菜单
    $(".ms-menu").delegate(".closeMenu","click",function(){
        $(this).parent().parent().hide();
        var menu = $(this).parent().siblings(".ms-menu-child");
        manager.leftMenu.leftMenuOpen($(this),menu);
        var index=0;
        $(".ms-menu-parent").each(function(){
            var target = $(this)
            $(".ms-menu-list li").each(function(){
                if(target.data("model-id")==$(this).data("model-id")){
                    $(this).removeClass("active");
                }
            })
                
            if($(this).css("display") == "none"){
                index++;
                if(index == $(".ms-menu-parent").length){
                    $(".ms-menu-list li").removeClass("active");
                    $(".ms-menu-none").show();
                }
            }
        })
    })
})