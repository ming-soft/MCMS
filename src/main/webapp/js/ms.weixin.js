//微信通用js
Ms.weixin = {
	"share" : function(config) { // 分享
		var imgUrl, shareTitle, lineLink, descContent, appid;
		if (config.imgUrl != undefined) {
			imgUrl = config.imgUrl;
		}
		if (config.lineLink != undefined) {
			lineLink = config.lineLink;
		}
		if (config.descContent != undefined) {
			descContent = config.descContent;
		}
		if (config.shareTitle != undefined) {
			shareTitle = config.shareTitle;
		}
		if (config.appid != undefined) {
			appid = config.appid;
		}
		// 朋友圈分享
		function shareFriend() {
			WeixinJSBridge.invoke('sendAppMessage', {
				"appid" : appid,
				"img_url" : imgUrl,
				"img_width" : "200",
				"img_height" : "200",
				"link" : lineLink,
				"desc" : descContent,
				"title" : shareTitle
			}, function(res) {
				// _report('friend', res.err_msg);
			});
		}
		function shareTimeline() {
			WeixinJSBridge.invoke('shareTimeline', {
				"img_url" : imgUrl,
				"img_width" : "200",
				"img_height" : "200",
				"link" : lineLink,
				"desc" : descContent,
				"title" : shareTitle
			}, function(res) {
				// _report('timeline', res.err_msg);
			});
		}
		function shareWeibo() {
			WeixinJSBridge.invoke('shareWeibo', {
				"content" : descContent,
				"url" : lineLink,
			}, function(res) {
				// _report('weibo', res.err_msg);
			});
		}
		// 当微信内置浏览器完成内部初始化后会触发WeixinJSBridgeReady事件。
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
			// 发送给好友
			WeixinJSBridge.on('menu:share:appmessage', function(argv) {
				shareFriend();
			});

			// 分享到朋友圈
			WeixinJSBridge.on('menu:share:timeline', function(argv) {
				shareTimeline();
			});

			// 分享到微博
			WeixinJSBridge.on('menu:share:weibo', function(argv) {
				shareWeibo();
			});
		}, false);
	},
	//config: 表单的数据，target绑定的click对象
	"initPay" : function(config,target) {//生成支付表单,body,r,host,notify_url,total_fee
			if (config==undefined) {
				return;
			}
			var body = config.body;
			var r = config.r;
			var host = config.host;
			var notify_url = config.notify_url;
			var total_fee = config.total_fee;
			var body = config.body;
			var trade_type = config.trade_type;
			if (trade_type==undefined || trade_type=="") {
				trade_type = "JSAPI";
			}
			if(body==undefined || body=="" || r==undefined || r=="" || host==undefined || host=="" || notify_url==undefined || notify_url=="" || total_fee==undefined || total_fee=="" || body==undefined || body=="" ) {
				Ms.msg("关键参数错误,检查参数:body,r,host,notify_url,total_fee")
				return;
			}
			
			
//		   <form action="/weixin/pay/pay.do" id="payForm">
//		   <input type="hidden" name="body" value="{ms:field.title/}" />
//		  <input type="hidden" name="img" value="{ms:field.litpic/}" />
//		   <input type="hidden" name="r" value="order.do" />
//		   <input type="hidden" name="host" value="www.pyqsly.com" />
//		   <input type="hidden" name="notify_url" value="orderSuccess.do" />
//		   <input type="hidden" name="total_fee" value="{ms:cfield.price/}" />
//		   <input type="hidden" name="trade_type" value="JSAPI" />
//		    </form>
		    
		    var form = document.createElement("form");
		    $(form).attr("action","/weixin/pay/pay.do").attr("method","post");
		  
		    for(var key in config){  
                if("undefined"!=typeof(config[key])){
                	var input = document.createElement("input");
   		    	 $(input).attr("type","hidden");
   		    	 $(input).attr("name",key);
   		    	 $(input).attr("value",config[key]);               
   		    	 $(input).appendTo(form);
                }
            }  		    
		    var tradeInput = document.createElement("input");
	    	 $(tradeInput).attr("type","hidden");
	    	 $(tradeInput).attr("name","trade_type");
	    	 $(tradeInput).attr("value",trade_type);
		    $(tradeInput).appendTo(form);
		    //$(form).appendTo("body");
		    //提交表单
		    target.tap(function() {
		    	$(form).submit();
		    });
		    
	},
	
	"pay" : function(config) {
		WeixinJSBridge.invoke('getBrandWCPayRequest', { // 微信公众号支付接口文档
			"appId" : config.appId,// 公众号名称，由商户传入
			"timeStamp" : config.timeStamp, // 时间戳，自 1970 年以来的秒数
			"nonceStr" : config.nonceStr, // 随机串
			"package" : "prepay_id="+config.prepayId,
			"signType" : "MD5", // 微信签名方式:
			"paySign" : config.paySign
		// 微信签名
		}, function(res) {
			if (res.err_msg == "get_brand_wcpay_request:ok") {
				if (config.returnUrl!=undefined) {
					Ms.msg("支付成功",config.returnUrl);
				} else {
					Ms.msg("支付成功","/");
				}
			} else {
				if (res.err_msg=="get_brand_wcpay_request:cancel") {
					Ms.msg("已取消支付!");
					
				} else {
					Ms.msg("支付失败!"+res.err_msg);
				}
			}
			// 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg 将在用户支付成功后返回
			// ok，但幵丌保证它绝对可靠。
		});

	}

};
