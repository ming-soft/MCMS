var Ms = {
	devWidth : 640,// 参考界面大小,即制作页面是的屏幕尺寸大小
	width : 0,
	heigth : 0,
	msIscroll : new Array(),//幻灯片
	msModal:new Array(),//模态框
	"isJson":function(obj) {
		var isjson = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length;
		return isjson;
	},
	"msg" : function(str,url,cfg) { // 提示消息 Ms.msg()调用
		
		var obj = $("<div class='ms-msg'></div>");
		var hideTime = 1000;
		var showTime = 500;
		var autoHide = true;
		var _url = null;
		var style = null;

		//如果url为json格式
		if (this.isJson(url)) {
			rJson(url);		 
		}
		
		if (cfg!=undefined) {
			rJson(cfg);
		}
		if (style!=null) {
			obj.css(style);
		}
		$("body").append(obj);
		obj.html(str).show();
		obj.animate({
			opacity : 1,
		}, showTime, 'ease', function() {
			if (autoHide) {
				$(this).animate({
					opacity : 0,
				}, hideTime, 'ease', function() {
					$(this).remove();
					if (typeof (_url) != "undefined" && _url!=null) {
						Ms.loadUrl(_url);
					}
				});				
			} else {
				$("body").tap(function() {
					obj.animate({
						opacity : 0,
					}, hideTime, 'ease', function() {
						obj.remove();
						if (typeof (_url) != "undefined" && _url!=null) {
							Ms.loadUrl(_url);
						}
					});						
				});
			}

		});
		
		function rJson(json) {
			if (json.hideTime!=undefined) {
				hideTime =parseInt(json.hideTime);
			}
			if (json.showTime!=undefined) {
				showTime = parseInt(json.showTime);
			}			
			if (json.url!=undefined) {
				_url = json.url;
			}			
			if (json.autoHide!=undefined) {
				autoHide = json.autoHide;
			}				
			if (json.style!=undefined) {
				style = json.style;
			}			
		}
	},
	"loadUrl" : function(url) {
		location.href = url;
	},
	"post" : function(url, params, func) { // 会员中心ajax请求类
		$.ajax({
			type : "POST",
			url : url,
			dataType : 'json',
			data : params,
			beforeSend : function() {
				Ms.msg("加载中...");
			},
			success : function(json) {
				func(json);
			},
			error : function(xhr, type) { // 服务器异常提示
				Ms.msg("服务器繁忙稍后重试！");
			}
		});
	},
	"postForm" : function(formId,func,cfg) { 
		var _data = $(formId).serialize();
		var _loadMsg = "加载中...";
		if (cfg!=undefined) {
			if (cfg.data!=undefined) {
				if (_data!=undefined) {
					_data+="&";
				}
				_data+=cfg.data;
			}
			if (cfg.loadingText!=undefined) {
				_loadMsg = cfg.loadingText;
			}
		}
		$.ajax({
			type : "POST",
			url : $(formId).attr("action"),
			dataType : 'json',
			data : _data,
			beforeSend : function() {
				Ms.msg(_loadMsg,cfg);
			},
			success : function(json) {
				func(json);
			},
			error : function(xhr, type) { // 服务器异常提示
				Ms.msg("服务器繁忙稍后重试！");
			}
		});
	},	
	"get" : function(url, params, func) { // 会员中心ajax请求类
		var target = this;
		var _params ;
		var _func = func;
		var _loadMsg = "加载中...";
		if (this.isJson(params)) {
			rJson(params);		 
		} else if (params!="") {
			_params = params;
		}
		
		$.ajax({
			type : "GET",
			url : url,
			dataType : 'json',
			data : _params,
			beforeSend : function() {
				if (target.isJson(params)) {
					Ms.msg(_loadMsg,params);
				} else {
					Ms.msg(_loadMsg);
				}
			},
			success : function(json) {
				_func(json);
			},
			error : function(xhr, type) { // 服务器异常提示
				Ms.msg("服务器繁忙稍后重试！");
			}
		});
		
		function rJson(json) {
			if (json.params!=undefined) {
				_params = json.params;
			}
			if (json.func!=undefined) {
				_func = json.func;
			}			
			if (json.loadingText!=undefined) {
				_loadMsg = json.loadingText;
			}		
		}
	},
	"load" : function(url, method, params, func) { // 非会员中心ajax请求类
		$.ajax({
			type : method,
			url : url,
			dataType : 'json',
			data : params,
			beforeSend : function() {
				Ms.msg("加载中...");
			},
			success : function(json) {
				if (func != null && func != undefined) {
					func(json);
				}
			},
			error : function(xhr, type) { // 服务器异常提示
				Ms.msg("服务器繁忙稍后重试！");
			}
		});
	},
	"setCookie" : function(key, value, time) { // 依赖zepto.cookie.min.js
		// time单位为天数字
		$.fn.cookie(key, value, {
			path : '/',
			expires : time
		});
	},
	"getCookie" : function(key) { // 读取cookie
		return decodeURIComponent($.fn.cookie(key));
	},
	"delCookie" : function(key) {
		$.fn.cookie(key, null);
	},
	"queryString" : function(param) {
		var svalue = location.search.match(new RegExp("[\?\&]" + param + "=([^\&]*)(\&?)", "i"));
		return svalue ? svalue[1] : svalue;
	},
	"initCss" : function(classKey) {
		// 更新字体
		var rowObj = $("*[class*=" + classKey + "]");
		if (typeof (rowObj) != "undefined") {
			for (k = 0; k < rowObj.length; k++) {
				var target = rowObj[k];
				var cls = $(target).attr("class");
				var clsO = cls.split(" ");
				for (i = 0; i < clsO.length; i++) {
					if (typeof (clsO[i]) != "undefined" && clsO[i].indexOf(classKey) > -1) {
						var v = clsO[i].replace(classKey, "");
						updateStyle(classKey, v);
					}
				}
			}
		}

		function updateStyle(key, value) {
			if ($(target).html().trim() == "") {
				if ($(target).attr("ms-empty")==undefined) {
					$(target).html("&nbsp;");
				}
			}
			if (key == "ms-w") {
				$(target).width(value + "%").css('float', 'left');
			} else if (key == "ms-h") {
				$(target).height(value + "%").css('float', 'left');
			} else if (key == "ms-font-size") {
				var pi = $(window).width() / Ms.devWidth;
				var v = eval(value * pi);
				$(target).css('font-size', v + 'rem');
			}

		}
	},
	"initFunc":function() {//属性绑定事件
//		$("body").on("tap","*[data-func]",function() {
//				
//		})
		
	},	
	"initScroll" : function() { // 滚动条
		// 滚动条
		if ($(".ms-scroll").size() > 0) {
			$(".ms-scroll").css("position", "absolute");
			var myScroll = new IScroll(".ms-scroll", {
				scrollbars : true,
				mouseWheel : true,
				interactiveScrollbars : false,
				shrinkScrollbars : 'scale',
				fadeScrollbars : false
			});

			document.addEventListener('touchmove', function(e) {
				e.preventDefault();
			}, false);
		}
	},
	"initSlide" : function() { // 初始化幻灯片
		var target = this;
		 $(".ms-slide-panel").each(function() {
			// 获取控件显示的宽度
			var w = parseInt($(this).attr("data-scroll-width")) / 100 * $(this).parent().width();
			var sel = 0;
			if ($(this).attr("data-scroll-sel")!=undefined) {
				sel = parseInt($(this).attr("data-scroll-sel"));
			}
			
			// 计算控件内容的宽度 显示宽度*元素个数
			$(this).find(".ms-slide-content").children(".ms-slide").css("width", w);
			var cw = $(this).find(".ms-slide-content").children(".ms-slide").length * w;
			$(this).find(".ms-slide-content").css("width", cw);
			var dot = null;
			var dot = $(this).find(".ms-slide-dot-btn");
			dot.find(".ms-slide-dot").width((100 / $(this).find(".ms-slide").length) + "%");
			slide(this,{"dot":dot,"sel":sel});
			
		});

		 /**
		  * 基于iscroll5的幻灯实现
		  * @param obj　幻灯目标，dom 对象
		  * @param cfg　json配置文件　
		  * {
		  * dot:幻灯点，dom对象
		  * }
		  */
		function slide(obj, cfg) {
			// 重置幻灯div大小,注意是让宽度高度适配
			var myScroll;
			if (cfg.dot != undefined) {
				myScroll = new IScroll(obj, {
					scrollX : true,
					scrollY : true,
					momentum : false,
					snap : true,
					snapSpeed : 400
				});
			} else {
				myScroll = new IScroll(obj, {
					scrollX : true,
					scrollY : true,
					momentum : false,
					snap : true,
					snapSpeed : 400,
					keyBindings : true
				});
			}
			// setInterval(myScroll.scrollTo(00),1000);
			// document.addEventListener('touchmove', function(e) {
			// e.preventDefault();
			// }, false);
			// JavaScript Document
			if (typeof(cfg.sel)!="undefined") {
				myScroll.scrollToElement($(".ms-slide-panel .ms-slide").eq(parseInt(cfg.sel))[0]);	
			}
			//实例后加入数组
			target.msIscroll.push(myScroll);
		}
	},
	//模态框组件
	"initModal" : function() { // 初始化模态框
		var target = this;
		// 弹出框处理
		$("body").on("tap","*[data-toggle='modal']",function() {
			target.openModal($(this).attr("data-target"));
		})

	},
	"openModal":function(modalId,cfg) {//打开模态框
		var target = this;
		$(modalId).show();
		// Ms.init(this.width, this.heigth);
		if (!$(modalId).parent().hasClass("modalMask")) {
			$(modalId).wrap("<div class='modalMask' style='width:" + target.width + "px;height:" + target.heigth + "px;position: absolute;background:rgba(0, 0, 0, 0.6) none repeat scroll 0 0 !important;filter:Alpha(opacity=80); background:#fff;z-index: 9997;top: 0;'>");
		} else {
			$(modalId).parent().show();
		}
		$(modalId).find(".ms-modal-button").css("line-height", "200%");
		$(modalId).css("margin-left", ($(modalId).parent().width() - $(modalId).width()) / 2 + "px");
		$(modalId).css("margin-top", "10%");
		$(modalId).on("tap", ".close", function() {
			target.hideModal(modalId);
		});		
	},
	"hideModal":function( modalId,cfg) {
		$(modalId).parent().hide();
		$(modalId).hide();
	},
	

	"init" : function() {
		// 获取当前屏幕高度
		this.width = $(window).width();
		this.heigth = $(window).height();
		$("body").height(this.heigth);

		this.initFunc();
		this.initSlide();
		this.initModal();
		this.initCss("ms-w");
		this.initCss("ms-h");
		this.initCss("ms-font-size");
		this.initVkey();

		// 矩形尺寸
		$(".ms-square").each(function(index) {
			
			//	$(this).height($(this).width() - parseInt($(this).css("border-width")) * 2);
			if (parseInt($(this).css("border-width")) > 0) {
				$(this).height($(this).width() - parseInt($(this).css("border-width")) * 2);
			} else {
				$(this).height($(this).width());
			}
		});

		$(".ms-text-vcenter").each(function() {
			if ($(this).height() > 0) {
				$(this).css("line-height", $(this).height() + "px");
			}
		});
	},
	"browser" : {
		versions : function() {
			var u = navigator.userAgent, app = navigator.appVersion;
			return {
				android4 : u.indexOf('Android 4') > -1 && u.indexOf('Linux') > -1,
				android2 : u.indexOf('Android 2') > -1 && u.indexOf('Linux') > -1,
				iPhone : u.indexOf('iPhone') > -1,
				iPad : u.indexOf('iPad') > -1,
				iPod : u.indexOf('iPod') > -1,
			};
		}(),
		language : (navigator.browserLanguage || navigator.language).toLowerCase()
	},
	"initVkey" : function() {
		if ($(".ms-widget-child") == undefined) {
			return;
		}
		// 悬浮一键插件开始
		$(".ms-widget-child").hide();
		$(".ms-widget-main").tap(function() {
			if ($(this).attr("data-isopen") == "false") {
				$(".ms-widget-child").show();
				$(this).animate({
					rotate : '360deg'
				}, "fast", 'ease', function() {
					$(this).attr("data-isopen", "true");
				});

				$(".ms-widget-child").each(function(index, item) {
					var x = 0;
					var y = 0;
					switch (index) {
					case 0:
						y = -100;
						break;
					case 1:
						x = 47;
						y = -81;
						break;
					case 2:
						x = 81;
						y = -45;
						break;
					case 3:
						x = 100;
						break;
					}
					$(this).animate({
						translate : '' + x + 'px,' + y + 'px'
					}, "fast", 'ease');

				});

			} else {
				$(this).animate({
					rotate : '0deg'
				}, "slow", 'ease', function() {
					$(this).attr("data-isopen", "false");
				});
				$(".ms-widget-child").each(function(index, item) {
					$(this).animate({
						translate : '0,0'
					}, "fast", 'ease', function() {
						$(this).hide();
					});
				});
			}
		});
		// //悬浮一键插件结束
	},
	"copyright":function(target,text){
		var str = "技术支持:铭飞科技";
		if (text!=undefined) {
			str = text;
		}
		var copy = '<div class="ms-copyright">'+str+'</div>';
		if (target!=undefined) {
			$("body").append($(copy));
		} else {
			$(target).append($(copy));
		}
		
	}
};

/**
 * 重写hide方法，
 */
(function($){
	  $.extend($.fn, {
	    hide: function(){
	      if (this.hasClass(".ms-modal")) {
	    	  this.css('display', 'none'); 
	    	  this.parent().css('display', 'none'); 
	      } else {
	    	 // this.hide();
	    	  this.css('display', 'none'); 
	      }
	    },
	    fadeOut:function(cfg) {
	    	this.animate({
	    		  opacity: 0,
	    		}, 500, 'ease-out',function() {
	    			if (cfg!=undefined) {
	    				if (cfg.func!=undefined) {
	    					cfg.func();
	    				}
	    			} else {
	    				this.remove();
	    			}
	    			
	    		} )
	    }
	  })
	})(Zepto)
	

Zepto(function($) {
	//addcloud();


	Ms.init();
	Ms.init();
	// 遮罩效果
	//document.onreadystatechange = subSomething; // 监听加载状态改变
	
});

function addcloud() {
	var bodyWidth = document.documentElement.clientWidth;
	var bodyHeight = Math.max(document.documentElement.clientHeight, document.body.scrollHeight);
	var bgObj = document.createElement("div");
	bgObj.setAttribute('id', 'bgDiv');
	bgObj.style.position = "absolute";
	bgObj.style.top = "0";
	bgObj.style.background = "#000000";
	bgObj.style.filter = "progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
	bgObj.style.opacity = "0.5";
	bgObj.style.left = "0";
	bgObj.style.width = bodyWidth + "px";
	bgObj.style.height = bodyHeight + "px";
	bgObj.style.zIndex = "10000"; // 设置它的zindex属性，让这个div在z轴最大，用户点击页面任何东西都不会有反应|
	document.body.appendChild(bgObj); // 添加遮罩
	var loadingObj = document.createElement("div");
	loadingObj.setAttribute('id', 'loadingDiv');
	loadingObj.style.position = "absolute";
	loadingObj.style.top = bodyHeight / 2 - 32 + "px";
	loadingObj.style.left = bodyWidth / 2 + "px";
	//loadingObj.style.background = "url(../../images/loading.gif)";
	loadingObj.style.width = "32px";
	loadingObj.style.height = "32px";
	loadingObj.style.zIndex = "10000";
	loadingObj.innerHTML = "load...";
	document.body.appendChild(loadingObj); // 添加loading动画-
}
function removecloud() {
	$("#loadingDiv").remove();
	$("#bgDiv").remove();
}
function subSomething() {
	if (document.readyState == "complete") // 当页面加载完毕移除页面遮罩，移除loading动画-
	{
		removecloud();
	}
}
