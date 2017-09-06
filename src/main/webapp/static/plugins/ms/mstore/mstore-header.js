//加载头部css
document.domain="mingsoft.net";
var link = document.createElement("link");
link.rel = "stylesheet";
link.type = "text/css";
link.href = "http://cdn.mingsoft.net/plugins/ms/mstore/mstore-header.css";
document.getElementsByTagName("head")[0].appendChild(link);

$(function(){
	//判断是否存在key
	if(document.querySelector('meta[name="mstore-key"]') != null){
		//将key值取出
		var mstoreKey = document.querySelector('meta[name="mstore-key"]').getAttribute('content');
		//判断Key值是否有效，有效即进行数据请求返回用户头像与昵称
		if(mstoreKey != null){
			$.ajax({ 
				type: "POST", 
				url : "http://ms.mingsoft.net/mstore/upgraderPeopleVersion/info.do", 
				dataType:'jsonp',
				jsonp:'callback',
				jsonpCallback:"jsonpcallback",
				data: "mstore-key="+mstoreKey,		
				success: function(json){
					if(json!=null){
						//判断昵称是否存在
						if(json.upgraderVersionPeopleName != null){
							$("#mstore_sharer").text(json.upgraderVersionPeopleName);
						}
						//判断头像是第三方提供的还是后台上传的
						if(json.upgraderVersionPeopleIcon != null){
							if(json.upgraderVersionPeopleIcon.substr(0,7)=="http://"){
								$("#mstore_userIcon").attr("src",json.upgraderVersionPeopleIcon)
							}else{
								$("#mstore_userIcon").attr("src","http://ms.mingsoft.net"+json.upgraderVersionPeopleIcon)
							}
						}
					}
					
				}
			})
		}

	}
  	
	//支付宝二维码显示隐藏
  	$(".mstore-support").hover(function(){
    	$(".mstore-support-pay").slideDown();
  	},function(){
    	$(".mstore-support-pay").slideUp();
  	});

 	//图片加载失败的默认图
	$("img").error(function(){
		$(this).attr("src","http://cdn.mingsoft.net/global/images/no-goods.jpg")
	})
	
	
})


//追加头部html
document.write('<a href="http://mb.mstore.mingsoft.net" style="background:url(http://cdn.mingsoft.net/images/mstore-top.jpg) no-repeat center;width: 100%;min-width: 1100px;height: 50px;display: block;"></a><div style="width:100%;height:30px;"></div><div id="mstore-header"><div class="mstore-headbody"><div class="mstore-title">价值来源于分享-MS平台</div><ul class="mstore-menu"><li><span>分享者：</span><img class="mstore-user-head" id="mstore_userIcon" src="http://cdn.mingsoft.net/global/images/msheader.png"><span id="mstore_sharer">外星人</span></li><li class="mstore-support"><img class="alipay-img" src="http://cdn.mingsoft.net/global/images/alipay.png"/>赞助Ta<div class="mstore-support-pay"><img src="http://cdn.mingsoft.net/global/images/mstore-pay.png"/></div></li><li><a href="http://ms.mingsoft.net/mbbs/main.do" target="_blank" style="margin-left:0px">开发者社区</a></li></ul></div></div>');
