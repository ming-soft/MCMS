// JavaScript Document
(function($) {

	/**
	 * ajax提交表单
	 * 
	 * @form 表单 格式:#表单id
	 * @config 配置扩展用,可包含参数:func,回调方法
	 */
	$.fn.postForm = function(form, config) {
		var target = $(this);
		if (isEmpty($(form).attr("action")) && isEmpty(config.action)) {
			alert("配置错误：from表单不存在action属性");
			return;
		}
		var func;
		var action = $(form).attr("action");
		var data_type = "json";
		if (config != undefined) {
			if (config.func != undefined) {
				func = config.func;
			}
			if (config.action != undefined) {
				action = config.action;
			}
		}
		$.ajax({
			type : "POST",
			url : action,
			dataType : data_type,
			data : $(form).serialize(),
			beforeSend : function() {
				target.attr("disabled", true);
			},
			success : function(data) {
				if (typeof (func) == "string") {
					eval(func + "(data)");
				} else if (typeof (func) == "function") {
					func.call(this, data);
				}
				target.removeAttr("disabled");
			}
		});
	}

	/**
	 * 发起ajax连接请求
	 * 
	 * @config(优先) 配置扩展用,可包含参数:func,回调方法
	 *             config格式：{url:请求地址,data:请求参数,loadingText:加载时文字}
	 *             调用该方法的元素必须存在data-ajax-url参数； 参数：data-ajax-url必须
	 *             data-ajax-data 可选
	 */
			$.fn.request = function(config) {
				var target = $(this);
				if (isEmpty(target.attr("data-ajax-url"))
						&& isEmpty(config.url)) {
					alert(target.selector + "配置错误：data-ajax-url属性不存在");
					return;
				}
				var method = "POST";
				var data_type = "json";
				var func = null;
				var _url = isEmpty(target.attr("data-ajax-url")) ? null
						: target.attr("data-ajax-url");// 请求地址
				var _data = isEmpty(target.attr("data-ajax-data")) ? null
						: target.attr("data-ajax-data");// 请求参数
				var _loadingText = isEmpty(target
						.attr("data-ajax-loading-text")) ? null : target
						.attr("data-ajax-loading-text");// 加载状态;
				var data_type = isEmpty(target.attr("data-ajax-type")) ? null
						: target.attr("data-ajax-type");// 返回数据类型
				var text = target.text();
				if (config != undefined) {
					// 请求方法
					if (config.method != undefined) {
						var _method = config.method;
						if (_method.toLowerCase() != "post"
								|| _method.toLowerCase() != "get") {
							method = _method;
						}
					}
					// 回调方法
					if (config.func != undefined) {
						func = config.func;
					}
					// 返回数据类型
					if (config.type != undefined) {
						var _type = config.type.toLowerCase();
						if (_type == "xml" || _type == "html"
								|| _type == "script" || _type == "jsonp"
								|| _type == "json" || _type == "text") {
							data_type = _type;
						}

					}
					if (config.url != undefined) {
						_url = config.url;
					}
					if (config.data != undefined) {
						_data = config.data;
					}
					if (config.loadingText != undefined) {
						_loadingText = config.loadingText;
					}
				}
				$.ajax({
					type : method,
					url : _url,
					dataType : data_type,
					data : _data,
					beforeSend : function() {
						if (target[0].nodeName == "INPUT") {
							if (!isEmpty(_loadingText)) {
								target.text(_loadingText);
							}
							target.attr("disabled", true);
						}

					},
					success : function(data) {

						if (typeof (func) == "string") {
							eval(func + "(data)");
						} else if (typeof (func) == "function") {
							func.call(this, data);
						}
						if (target[0].nodeName == "INPUT") {
							target.removeAttr("disabled");
							target.text(text);
						}
					}
				});
			},

			$.fn.noDataMsg = function(config) {
				if (config != undefined) {

				}
			}

	/**
	 * 判断是否为空， target:判断对象 message:提示信息 true:为空 false:不为空
	 */
	function isEmpty(target, message) {
		if (target == undefined || target == null || target.trim() == ""
				|| target.trim().length == 0) {
			if (message != undefined) {
				alert(message);
			}
			return true;
		}
		return false;
	}

})(jQuery);

var Ms = {
	_target : this,
	"msg" : function(str, url) { // 提示消息 Ms.msg()调用
		var obj = $("<div class='ms-msg'></div>");
		$("body").append(obj);
		obj.html(str).show();
		obj.animate({
			opacity : 1,
		}, 500, 'ease', function() {
			$(this).animate({
				opacity : 0,
			}, 800, 'ease', function() {
				if (typeof (url) != "undefined") {
					_target.loadUrl(url);
				}
			});
		});
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
				try {
					_target.msg("加载中..."); 
				} catch (e) {

				}
			},
			success : function(json) {
				func(json);
			},
			error : function(xhr, type) { // 服务器异常提示
				try {
					_target.msg("服务器繁忙稍后重试！");
				} catch (e) {

				}
			}
		});
	},
	"get" : function(url, params, func) { // 会员中心ajax请求类
		$.ajax({
			type : "GET",
			url : url,
			dataType : 'json',
			data : params,
			beforeSend : function() {
				try{
					_target.msg("加载中...");
				}catch(e){}
			},

			success : function(json) {
				func(json);
			},
			error : function(xhr, type) { // 服务器异常提示
				try{
					_target.msg("服务器繁忙稍后重试！");
				}catch(e){}
			}
		});
	},
	"load" : function(url, method, params, func) { // 非会员中心ajax请求类
		$.ajax({
			type : method,
			url : url,
			dataType : 'json',
			data : params,
			beforeSend : function() {
				_target.msg("加载中...");
			},
			success : function(json) {
				if (func != null && func != undefined) {
					func(json);
				}
			},
			error : function(xhr, type) { // 服务器异常提示
				_target.msg("服务器繁忙稍后重试！");
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
		var svalue = location.search.match(new RegExp("[\?\&]" + param
				+ "=([^\&]*)(\&?)", "i"));
		return svalue ? svalue[1] : svalue;
	},
	"initModal" : function() { // 初始化模态框
		// 弹出框处理
		if ($("*[data-toggle='modal']").size() > 0) {
			$("*[data-toggle='modal']").each(
					function(index) {
						$("body").on(
								"tap",
								"[data-target=\"" + $(this).attr("data-target")
										+ "\"]",
								function() {
									if ($(this).attr("data-target") != "") {
										openModal($(this).attr("data-target"),
												w, h);
									}
								})
					});
		}

		function openModal(modalId, w, h) {

			$(modalId).show();
			Ms.init(w, h);

			if (!$(modalId).parent().hasClass("modalMask")) {
				$(modalId)
						.wrap(
								"<div class='modalMask' style='width:"
										+ w
										+ "px;height:"
										+ h
										+ "px;position: absolute;background:rgba(0, 0, 0, 0.6) none repeat scroll 0 0 !important;filter:Alpha(opacity=80); background:#fff;z-index: 9997;top: 0;'>");
			} else {
				$(modalId).parent().show();
			}
			$(modalId).find(".ms-modal-button").css("line-height", "200%");
			$(modalId).css(
					"margin-left",
					($(modalId).parent().width() - $(modalId).width()) / 2
							+ "px");
			$(modalId).css("margin-top", "10%");
			$(modalId).on("tap", ".close", function() {
				// $(modalId).hide();
				// $(modalId).unwrap().parent();
				hideModal(modalId);
			})
		}

		function hideModal(modalId) {

			$(modalId).parent().hide();
			$(modalId).hide();
		}
	},
	"browser" : {
		versions : function() {
			var u = navigator.userAgent, app = navigator.appVersion;
			return {
				android4 : u.indexOf('Android 4') > -1
						&& u.indexOf('Linux') > -1,
				android2 : u.indexOf('Android 2') > -1
						&& u.indexOf('Linux') > -1,
				iPhone : u.indexOf('iPhone') > -1,
				iPad : u.indexOf('iPad') > -1,
				iPod : u.indexOf('iPod') > -1,
			};
		}(),
		language : (navigator.browserLanguage || navigator.language)
				.toLowerCase()
	}
};
var ms = Ms;
