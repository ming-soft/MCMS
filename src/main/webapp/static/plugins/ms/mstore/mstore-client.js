$(function() {
	var title = "MStore"
	if($.cookie() != null){
		if($.cookie('ms_cookie') != "ms_value"){
			$(".ms-top-mstore").after('<div class="popover bottom ms-top-menuchildTit"><div class="arrow"></div><h3 class="popover-title">MStore<button type="button" class="close" style="line-height: 16px;" data-dismiss="popover" aria-hidden="true">×</button></h3><div class="popover-content"><p>为您提供大量优质插件及免费企业模板</p></div></div>')

	    	$(".ms-top-mstore .badge").hide();
	    	$(".ms-top-mstore .badge").text(""); 
	    }
    }
 	$(".close").click(function(){
        $(this).parent().parent(".popover").remove()
    });
    
    /*扫描二维码后获取当前地址栏地址后面url的参数，如果有的话 就传一个地址进入模块商城*/
    var msurl = ms.queryString("url");
    if (msurl) {
    	/*if (!$('.easyui-tabs').tabs('exists', title)) {
	        $('.easyui-tabs').tabs('add', {
	            title: title,
	            content: '<iframe src="'+msurl+'" frameborder="0" height="100%" width="100%" id="mainFrame" name="mainFrame"></iframe>',
	            closable: true,
	        });
    	}*/
    }
    var msotreClientPath = base+"/manager";
    if (typeof managerPath != "undefined") {
    	msotreClientPath = managerPath;
    }
	$.ajax({
	    type:"post",
	    dataType: "json",
	    url: msotreClientPath+"/upgrader/sync.do",
	    beforeSend:function(){
	        //$(".ms-content").css("background","url(http://static.ming-soft.net/loading.gif) no-repeat center")
	    },
	    success: function(msg){
	        var content = $.parseJSON(msg.resultMsg);
	        if(content.syncNum > 0){
	            $(".ms-top-mstore .badge").show().html(content.syncNum);
	        }
	        
	        //点击进入MStore
		    $(".ms-top-mstore").click(function(){
		        $(".wellcome").hide();
		        $(".easyui-tabs").show();
		        var title = "MStore";
		        if (!$('.easyui-tabs').tabs('exists', title)) {
		            $('.easyui-tabs').tabs('add', {
		                title: title,
		                content: '<iframe src="'+content.syncStoreUrl+'?c='+encodeURIComponent(location.href)+'" frameborder="0" height="100%" width="100%" id="mainFrame" name="mainFrame"></iframe>',
		                closable: true,
		            });
		        } else {
		            $('.easyui-tabs').tabs('select', title);
		        }
		        /*设置cookie*/
	            $.cookie('ms_cookie', 'ms_value', { expires: 7});
	            
		    })

	    }
	})
})