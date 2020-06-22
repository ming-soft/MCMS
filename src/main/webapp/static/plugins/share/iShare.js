/**
 * iShare.js
 * @author singsong
 * @email	zhansingsong@gmail.com
 * @date 2016.3.6
 */
;
(function (root, factory) {
	if (typeof define === 'function' && define.amd) {
		define([], factory(root));
	} else if (typeof exports === 'object') {
		module.exports = factory(root);
	} else {
		root.iShare = factory(root);
	}
})(typeof global !== 'undefined' ? global : this.window || this.global, function (root) {
	/**
	 * 严格模式
	 */
	'use strict';

	/**
	 * Util 单例工具类
	 */
	var Util = {
		/**
		 * event 事件注册与注销
		 * addEvent 注册事件
		 * removeEvent 注销事件
		 */
		event: {
			addEvent: function (element, type, handler) {
				if (element.addEventListener) {
					element.addEventListener(type, handler, false);
				} else if (element.attachEvent) {
					element.attachEvent('on' + type, handler);
				} else {
					element['on' + type] = handler;
				}
			},
			removeEvent: function (element, type, handler) {
				if (element.removeEventListener) {
					element.removeEventListener(type, handler, false);
				} else if (element.detachEvent) {
					element.detachEvent('on' + type, handler);
				} else {
					element['on' + type] = null;
				}
			},
			stopPropagation: function (event) {
				if (event.stopPropagation) {
					event.stopPropagation();
				} else {
					event.cancelBubble = true;
				}
			},
			preventDefault: function (event) {
				if (event.preventDefault) {
					event.preventDefault();
				} else {
					event.returnValue = false;
				}
			}
		},
		/**
		 * trim 		
		 * @param  {String} str 字符串
		 * @return {String}    
		 */
		trim: function (str) {
			if (String.prototype.trim) {
				return str.trim();
			}
			return str.replace(/^\s+|s+$/g, '');
		},

		/**
		 * indexOf 
		 * @param  {Array} 	arr  数组
		 * @param  {Object} item 项
		 * @return {Number}      索引
		 */
		indexOf: function (arr, item) {
			if (!this.isArray(arr)) {
				throw new Error(arr.toString() + ' is a non-Array！');
			}
			if (Array.prototype.indexOf) {
				return arr.indexOf(item);
			}
			for (var i = 0, len = arr.length; i < len; i++) {
				if (arr[i] === item) {
					return i;
				}
			}
		},

		/**
		 * isArray 判断是否是数组
		 * @param  {Ojbect}  arr 被判断对象
		 * @return {Boolean}     
		 */
		isArray: function (arr) {
			if (Array.isArray) {
				return Array.isArray(arr);
			}
			return Object.prototype.toString.call(arr) === '[object Array]';
		},

		/**
		 * validate 验证用户输入的有效性
		 * @param  {Object} ref 参考对象
		 * @param  {Object} o   验证对象
		 * @return {Array}     	错误队列
		 */
		validate: function (ref, o) {
			var _key,
				_result = [];

			if (this.isArray(o)) {
				for (var i = 0, item; item = o[i++];) {
					if (this.indexOf(ref, item) < 0) {
						_result.push(item);
					}
				}
			} else {
				for (_key in o) {
					if (!(_key in ref)) {
						_result.push(_key);
					}
				}
			}
			if (_result.length !== 0) {
				throw new Error('there is such no property: ' + _result.join(', '));
			}
		},

		/**
		 * getElementTop 获取元素的offsetTop
		 * @param  {DOMObject} element 元素
		 * @return {Number}    offsetTop值
		 */
		getElementTop: function (element) {
			var _actualTop = element.offsetTop,
				_current = element.offsetParent;
			while (_current !== null) {
				_actualTop += _current.offsetTop;
				_current = _current.offsetParent;
			}
			return _actualTop;
		},

		/**
		 * getElementLeft 获取元素的offsetLeft
		 * @param  {DOMObject} element 元素
		 * @return {Number}    offsetLeft值
		 */
		getElementLeft: function (element) {
			var _actualTop = element.offsetLeft,
				_current = element.offsetParent;
			while (_current !== null) {
				_actualTop += _current.offsetLeft;
				_current = _current.offsetParent;
			}
			return _actualTop;
		},
		/**
		 * handleParameters 处理URL参数
		 * @param  {Object} options 配置项
		 * @return {String}  
		 */
		handleParameters: function (options) {
			var _str = '';
			for (var key in options) {
				_str = _str + key + '=' + encodeURIComponent(options[key]) + '&';
			}
			return _str;
		},

		/**
		 * extend mix-in
		 * @return {Ojbect} 
		 */
		extend: function () {
			var _arg,
				_prop,
				_child = {};
			for (_arg = 0; _arg < arguments.length; _arg++) {
				for (_prop in arguments[_arg]) {
					if (arguments[_arg].hasOwnProperty(_prop)) {

						_child[_prop] = arguments[_arg][_prop];
					}
				}
			}
			return _child;
		},

		/**
		 * each 遍历数组
		 * @param  {Array}   	o       		数组
		 * @param  {Function} callback		回调函数
		 * @return {Object}
		 */
		each: function (o, callback) {
			if (!o) {
				return;
			}
			var _r;
			for (var i = 0, l = o.length; i < l; i++) {
				_r = callback.call(o[i], i, o[i]);
			}
			return _r;
		},

		/**
		 * getElementByclassN 通过class获取元素
		 * @param  {String} classNameStr 类名
		 * @param  {Node} parent 父元素
		 * @return {DOMObject}
		 *
		 * @example
		 * getElementByclassN('.test');
		 */
		getElementByclassN: function (classNameStr, parent) {
			if (!classNameStr) {
				return;
			}
			var _result = [];

			if (!parent && document.querySelectorAll) {
				_result = document.querySelectorAll(classNameStr);
				if (_result.length > 0) {
					return _result;
				}
			}
			var _cnArr = classNameStr.split('.'),
				_prefix = _cnArr[0] || '*',
				_suffix = _cnArr[1],
				_parent = parent ? parent : document.body,
				_elements = _parent.getElementsByTagName(_prefix),
				_classNames,
				_target;
			var _me = this;
			this.each(_elements, function (index, item) {
				if (item.nodeType === 1) {
					_classNames = item.className.split(/\s+/g);
					_target = item;
					_me.each(_classNames, function (cindex, citem) {
						if ((citem + '') === _suffix) {
							_result.push(_target);
						}
					});
				}
			});
			return _result;
		},

		/**
		 * getmeta 通过name获取对应meta的content值
		 * @param  {String} name meta的name
		 * @return {String}
		 */
		getmeta: function (name) {
			var _metas = document.getElementsByTagName('meta');
			for (var i = 0, _item; _item = _metas[i++];) {
				if (_item.getAttribute('name') && _item.getAttribute('name').toLowerCase() === name) {
					return _item.content;
				}
			}
		},

		/**
		 * getimg 获取页面中第一张图片的URL
		 * @return {String}
		 */
		getimg: function () {
			var _imgs = this.convertToArray(document.body.getElementsByTagName('img'));
			if (_imgs.length === 0) {
				return;
			}
			return encodeURIComponent(_imgs[0].src);
		},

		/**
		 * getElement 获取指定元素
		 * @param {String}  selector 选择器(仅支持class和id)
		 */
		getElement: function (selector) {
			var _node;
			if (selector.charAt(0) === '#') {
				_node = document.getElementById(selector);
			} else {
				_node = this.getElementByclassN(selector)[0];
			}
			return _node;
		},

		/**
		 * parseUrl 解析URL
		 * @param  {Object}	tpl  模板
		 * @param  {Object} data 数据 
		 * @return {Object}
		 */
		parseUrl: function (tpl, data) {
			var _tplStr = {};
			for (var _name in tpl) {
				_tplStr[_name] = tpl[_name].replace(/{{([A-Z]*)}}/g, function (match, p1) {
					var _key = p1.toLowerCase();
					if (data[_key]) {
						return encodeURIComponent(data[_key]);
					} else {
						return '';
					}
				});
			}
			return _tplStr;
		},

		/**
		 * isWeixinBrowser 判断是否在微信中
		 * @return {Boolean}
		 */
		isWeixinBrowser: function () {
			var _ua = navigator.userAgent.toLowerCase();
			return (/micromessenger/.test(_ua)) ? true : false;
		},

		/**
		 * convertToArray 转换为数组
		 * @param  {NodeList} nodes Nodes数组
		 * @return {Array}      
		 */
		convertToArray: function (nodes) {
			var _array = null;
			try {
				_array = Array.prototype.slice.call(nodes, 0);
			} catch (ex) {
				// 针对IE8及之前版本
				_array = new Array();
				for (var i = 0, len = nodes.length; i < len; i++) {
					_array.push(nodes[i]);
				}
			}
			return _array;
		},

		/**
		 * parseClassName 解析类名
		 * @param  {String} className 类名
		 * @param  {Object} tpl       模板数据
		 * @return {String}           
		 */
		parseClassName: function (className, tpl) {
			var _result = null;
			var _arr = className.split(/\s+/);
			for (var i = 0, item; item = _arr[i++];) {
				if (item in tpl) {
					return tpl[item];
				}
			}
		},

		/**
		 * getWinDimension 获取可视页面的尺寸
		 * @return {Object} 
		 */
		getWinDimension: function () {
			var _pageWidth = window.innerWidth,
				_pageHeight = window.innerHeight;
			if (typeof _pageWidth !== 'number') {
				if (document.compatMode === 'CSS1Compat') {
					_pageWidth = document.documentElement.clientWidth;
					_pageHeight = document.documentElement.clientHeight;
				} else {
					_pageWidth = document.body.clientWidth;
					_pageHeight = document.body.clientHeight;
				}
			}
			return { pageWidth: _pageWidth, pageHeight: _pageHeight };
		},
		/**
		 * throttle 节流优化
		 * @param  {Function} fn    回调函数
		 * @param  {Number}   delay 时间间隔
		 */
		throttle: function (fn, delay) {
			var timer = null;
			return function () {
				var context = this, args = arguments;
				clearTimeout(timer);
				timer = setTimeout(function () {
					fn.apply(context, args);
				}, delay);
			};
		},
		/**
		 * loadjs 加载js文件
		 * @param {String} url 路径
		 * @param {Function} callback 回调函数
		 */
		loadjs: function () {
			var ready = false,
				cb = [];
			return function (url, callback) {
				var head = document.getElementsByTagName('head')[0],
					node = document.createElement('script'),
					isLoaded = document.getElementById('loaded'),
					W3C = document.dispatchEvent;
				cb.push(callback);
				if (!ready) {
					node.setAttribute('type', 'text/javascript');
					node.setAttribute('id', 'loaded');
					node.setAttribute('src', url);

					node[W3C ? 'onload' : 'onreadystatechange'] = function () {
						if (ready) {
							return;
						}
						if (W3C || /loaded|complete/i.test(node.readyState)) {
							ready = true;
							var temp;
							while (temp = cb.pop()) {
								temp();
							}
						}
					};
					(!isLoaded) && (head.appendChild(node));
				} else {
					if (callback) {
						callback();
					}
				}
			}
		}()
	};

	/**
	 * WX 微信类
	 * @param {DOMObject} element 微信按钮节点
	 * @param {object} 		options 配置项
	 * 
	 */
	function WX(element, URL, options) {
		this.element = element;
		this.wxbox = document.createElement('div');
		// 配置项
		this.URL = URL;
		this.settings = options;
		this.style = options.style;
		this.bgcolor = options.bgcolor;
		this.evenType = options.evenType || 'mouseover'; // 默认触发方式
		this.isTitleVisibility = (options.isTitleVisibility === void (0)) ? true : options.isTitleVisibility; // 是否有标题
		this.title = options.title || '分享到微信';
		this.isTipVisibility = (options.isTipVisibility === void (0)) ? true : options.isTipVisibility; // 是否有提示
		this.tip = options.tip || '“扫一扫” 即可将网页分享到朋友圈。';
		this.upDownFlag = '';// 保存up|down
		this.status = false; // 保存状态
		this.visibility = false;// 保存可见性
		this.qrcode = null; // 保存二维码
	}
	WX.prototype.qrcode = null;// 保存二维码
	WX.prototype = function () {
		return {
			constructor: WX,
			init: function () {
				//this.render();
				this.init = this.show;
				this.bindEvent();
			},
			loadQrcode: function () {
				// 加载qrcode库
				var js = document.scripts;
				var path = "";
				var c = js.length;
				for (var i = 0; i < c; i++) {
					var it = js[i];
					var src = it.src;
					if (src.indexOf("iShare") >= 0) {
						path = src.substring(0, src.lastIndexOf('/') + 1)
					}
				}
				Util.loadjs(path + 'qrcode.min.js', this.startQR());
			},
			render: function () {
				var _upFlag = '',
					_downFlag = '',
					// _widthStyle = (!this.isTitleVisibility || !this.isTipVisibility) ? 'width: 110px;' : 'width : 150px;',
					_imgStyle = '',//待定
					_titleStyle = '',//待定
					_tipStyle = '', //待定
					_bgcolor = this.bgcolor ? this.bgcolor : '#ddd',
					_radius = '';

				// 判断上下
				if (Util.getWinDimension().pageHeight / 2 < Util.getElementTop(this.element)) {
					_downFlag = '';
					_upFlag = 'display:none;';
					this.upDownFlag = 'down';
					_radius = 'border-bottom-left-radius: 0;';
				} else {
					_downFlag = 'display:none;';
					_upFlag = '';
					this.upDownFlag = 'up';
					_radius = 'border-top-left-radius: 0;';
				}

				var _containerHTML = '<div style="text-align: center;background-color: ' + _bgcolor + ';box-shadow: 1px 1px 4px #888888;padding: 8px 8px 4px;border-radius: 4px;' + _radius + '">',
					_titleHTML = this.isTitleVisibility ? '<p class="tt" style="line-height:30px;margin:0; text-shadow: 1px 1px rgba(0,0,0,0.1);font-weight: 700;margin-bottom: 4px;' + _titleStyle + '">' + this.title + '</p>' : '',
					_imgHTML = '<div class="qrcode" style="width:' + this.settings.qrcodeW + 'px; height:' + this.settings.qrcodeH + 'px; overflow:hidden;"></div>',
					_tipHTML = this.isTipVisibility ? '<p style="line-height:20px;font-size: 12px; margin: 4px auto;width: 120px;' + _tipStyle + '">' + this.tip + '</p>' : '',
					_upArrowHTML = '<div style="' + _upFlag + 'position: relative;height: 0;width: 0;border-style: solid;border-width: 12px;border-color: transparent;border-bottom-color: ' + _bgcolor + ';border-top: none;"></div>',
					_downArrowHTML = '</div><div style="' + _downFlag + 'position: relative;height: 0;width: 0;border-style: solid;border-width: 12px;border-color: transparent;border-top-color: ' + _bgcolor + ';border-bottom: none;"></div>';
				// 拼接WXHTML
				var WXSTR = _upArrowHTML + _containerHTML + _titleHTML + _imgHTML + _tipHTML + _downArrowHTML;

				this.wxbox.innerHTML = WXSTR;
				this.wxbox.style.cssText = 'position:absolute; left: -99999px;';
				this.element.appendChild(this.wxbox);
				this.loadQrcode();
			},
			setLocation: function (flag) {
				var _boxH = this.wxbox.offsetHeight,
					_eW = this.element.offsetWidth,
					_eH = this.element.offsetHeight,
					_boxStyle = 'position:absolute; color: #000;z-index: 99999;';
				_boxStyle = _boxStyle + 'left: ' + (_eW / 2 - 12) + 'px;';
				if (this.upDownFlag === 'down') {
					_boxStyle = _boxStyle + 'bottom: ' + (_eH) + 'px;';
				} else {
					_boxStyle = _boxStyle + 'top: ' + (_eH) + 'px;';
				}
				this.wxbox.style.cssText = _boxStyle + this.style;
				flag && (this.hide());
			},
			bindEvent: function () {
				var _me = this;
				if (this.evenType === 'click') {
					Util.event.addEvent(this.element, 'click', function (e) {
						var event = e || window.event;
						Util.event.stopPropagation(event);
						Util.event.preventDefault(event);
						if (!_me.visibility) {
							_me.show();
						} else {
							_me.hide();
						}
					});
				} else {
					Util.event.addEvent(this.element, 'mouseover', function (e) {
						var event = e || window.event;
						// Util.event.stopPropagation(event);
						_me.show();
					});
					Util.event.addEvent(this.element, 'mouseout', function (e) {
						var event = e || window.event;
						// Util.event.stopPropagation(event);
						_me.hide();
					});
				}
			},
			startQR: function () {
				var me = this;
				return function () {
					if (!me.qrcode) {
						me.qrcode = new QRCode(Util.getElementByclassN('.qrcode', me.wxbox)[0], {
							text: me.URL,
							width: me.settings.qrcodeW,
							height: me.settings.qrcodeH,
							colorDark: me.settings.qrcodeFgc,
							colorLight: me.settings.qrcodeBgc
						});
					}
				}
			},
			show: function () {
				this.status = true;
				this.render();
				this.setLocation(true);
				this.wxbox.style.display = 'block';
				this.visibility = true;
				this.show = function () {
					this.wxbox.style.display = 'block';
					this.visibility = true;
				}
			},
			hide: function () {
				this.wxbox.style.display = 'none';
				this.visibility = false;
			}
		};
	}();


	/**
	 * iShare 分享
	 * @param  {Object} options 配置项
	 * @property container
	 * @property config
	 *
	 * @description 提供两种初始化方式
	 * #1 单例模式
	 * #2 实例化模式 
	 */
	function iShare(options) {
		var defaults = {
			title: document.title,
			url: location.href,
			host: location.origin || '',
			description: Util.getmeta('description'),
			image: Util.getimg(),
			sites: ['iShare_weibo', 'iShare_qq', 'iShare_wechat', 'iShare_tencent', 'iShare_douban', 'iShare_qzone', 'iShare_renren', 'iShare_youdaonote', 'iShare_facebook', 'iShare_linkedin', 'iShare_twitter', 'iShare_googleplus', 'iShare_tumblr', 'iShare_pinterest'],
			initialized: true,
			isTitle: true,
			isAbroad: false,
			WXoptions: {
				qrcodeW: 120,
				qrcodeH: 120,
				qrcodeBgc: '#fff',
				qrcodeFgc: '#000',
				bgcolor: '#2BAD13'
			}
		};

		var configuration = options || window.iShare_config;
		if (configuration) {
			if (configuration.container) {
				if (Util.getElement(configuration.container)) {
					this.container = Util.getElement(configuration.container);
				} else {
					throw new Error('there is such no className|id: "' + configuration.container + '".');
				}
			} else {
				throw new Error('container property is required.');
			}
		} else {
			throw new Error('container property is required.');
		}

		var dataSites = this.container.getAttribute('data-sites'),
			dataSitesArr = dataSites ? dataSites.split(/\s*,\s*/g) : null;

		/* 验证用户输入的有效性 */
		(dataSitesArr) && (Util.validate(defaults.sites, dataSitesArr));
		(configuration.config) && (Util.validate(defaults, configuration.config));
		(configuration.config.sites) && (Util.validate(defaults.sites, configuration.config.sites));

		/* WX */
		this.wx = null;

		/* 保存defaults */
		this.defaults = defaults;
		this.dataSites = dataSitesArr ? { sites: dataSitesArr } : {};
		this.config = configuration.config ? configuration.config : {};

		// 处理isAbroad
		if ((this.config.isAbroad === void (0))) {
			this.config.sites = this.defaults.sites; // 默认
		} else {
			if (this.config.isAbroad) {
				this.config.sites = defaults.sites.slice(8); // 国外
			} else {
				this.config.sites = defaults.sites.slice(0, 8); // 国内
			}
		}

		/* 验证是否在微信中 */
		if (Util.isWeixinBrowser()) {
			(this.defaults.indexOf('iShare_wechat') > -1) && (this.defaults.splice(this.defaults.indexOf('iShare_wechat'), 1));
			(this.dataSites.indexOf('iShare_wechat') > -1) && (this.dataSites.splice(this.dataSites.indexOf('iShare_wechat'), 1));
			(this.config.indexOf('iShare_wechat') > -1) && (this.config.splice(this.config.indexOf('iShare_wechat'), 1));
		}

		this.settings = Util.extend(defaults, this.config, this.dataSites);
		this.settings.WXoptions = Util.extend(defaults.WXoptions, this.config.WXoptions);
		this.init();
	}
	iShare.prototype = (function () {
		// 接口模板
		var _templates = {
			iShare_qq: 'http://connect.qq.com/widget/shareqq/index.html?url={{URL}}&title={{TITLE}}&desc={{DESCRIPTION}}&summary=&pics={{IMAGE}}',
			iShare_qzone: 'http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={{URL}}&title={{TITLE}}&summary={{DESCRIPTION}}&pics={{IMAGE}}&desc=&site=',
			iShare_tencent: 'http://share.v.t.qq.com/index.php?c=share&a=index&title={{TITLE}}&url={{URL}}&pic={{IMAGE}}',
			iShare_weibo: 'http://service.weibo.com/share/share.php?url={{URL}}&title={{TITLE}}&pic={{IMAGE}}',
			iShare_wechat: '',
			iShare_douban: 'http://shuo.douban.com/!service/share?href={{URL}}&name={{TITLE}}&text={{DESCRIPTION}}&image={{IMAGE}}',
			iShare_renren: 'http://widget.renren.com/dialog/share?resourceUrl={{URL}}&title={{TITLE}}&pic={{IMAGE}}&description={{DESCRIPTION}}',
			iShare_youdaonote: 'http://note.youdao.com/memory/?title={{TITLE}}&pic={{IMAGE}}&summary={{DESCRIPTION}}&url={{URL}}',
			iShare_linkedin: 'http://www.linkedin.com/shareArticle?mini=true&ro=true&title={{TITLE}}&url={{URL}}&summary={{DESCRIPTION}}&armin=armin',
			iShare_facebook: 'https://www.facebook.com/sharer/sharer.php?s=100&p[title]={{TITLE}}p[summary]={{DESCRIPTION}}&p[url]={{URL}}&p[images]={{IMAGE}}',
			iShare_twitter: 'https://twitter.com/intent/tweet?text={{TITLE}}&url={{URL}}',
			iShare_googleplus: 'https://plus.google.com/share?url={{URL}}&t={{TITLE}}',
			iShare_pinterest: 'https://www.pinterest.com/pin/create/button/?url={{URL}}&description={{DESCRIPTION}}&media={{IMAGE}}',
			iShare_tumblr: 'https://www.tumblr.com/widgets/share/tool?shareSource=legacy&canonicalUrl=&url={{URL}}&title={{TITLE}}'
		},
			_names = {
				iShare_qq: 'QQ好友',
				iShare_qzone: 'QQ空间',
				iShare_tencent: '腾讯微博',
				iShare_weibo: '新浪微博',
				iShare_wechat: '微信',
				iShare_douban: '豆瓣',
				iShare_renren: '人人',
				iShare_youdaonote: '有道笔记',
				iShare_linkedin: 'Linkedin',
				iShare_facebook: 'Facebook',
				iShare_twitter: 'Twitter',
				iShare_googleplus: 'Google+',
				iShare_pinterest: 'Pinterest',
				iShare_tumblr: 'Tumblr'
			},
			_icons = {
				iShare_qq: '<i class="iconfont qq">&#xe60f;</i>',
				iShare_qzone: '<i class="iconfont qzone">&#xe610;</i>',
				iShare_tencent: '<i class="iconfont tencent" style="vertical-align: -2px;">&#xe608;</i>',
				iShare_weibo: '<i class="iconfont weibo">&#xe609;</i>',
				iShare_wechat: '<i class="iconfont wechat" style="vertical-align: -2px;">&#xe613;</i>',
				iShare_douban: '<i class="iconfont douban" style="vertical-align: -2px;">&#xe612;</i>',
				iShare_renren: '<i class="iconfont renren">&#xe603;</i>',
				iShare_youdaonote: '<i class="iconfont youdaonote" style="vertical-align: -2px;">&#xe604;</i>',
				iShare_linkedin: '<i class="iconfont linkedin" style="vertical-align: 1px;">&#xe607;</i>',
				iShare_facebook: '<i class="iconfont facebook" style="vertical-align: 1px;">&#xe601;</i>',
				iShare_twitter: '<i class="iconfont twitter" style="vertical-align: 1px;">&#xe60a;</i>',
				iShare_googleplus: '<i class="iconfont googleplus" style="vertical-align: -2px;">&#xe60b;</i>',
				iShare_pinterest: '<i class="iconfont pinterest" style="vertical-align: -2px;">&#xe60c;</i>',
				iShare_tumblr: '<i class="iconfont tumblr" style="vertical-align: 0px;">&#xe600;</i>'
			};
    /**
     * _updateUrl 更新添加分享的A标签
     */
		function _updateUrl() {
			if (!this.container.hasChildNodes()) {
				return;
			}
			var _children = this.container.childNodes,
				_tempURL;

			for (var i = 0, item; item = _children[i++];) {
				if (item.nodeType === 1) {
					_tempURL = Util.parseClassName(item.className, Util.parseUrl(_templates, this.settings));
					if ((item.className).indexOf('iShare_wechat') > -1) {
						// this.wx = new WX(item, _tempURL, this.settings.WXoptions);
						this.wx = new WX(item, this.settings.url, this.settings.WXoptions);
					} else {
						_tempURL && (item.href = _tempURL);
						item.target = '_blank';
					}
				}
			}
		}
		/**
		 * _createShareElements 创建分享元素
		 * @param  {String}  url      分享接口
		 * @param  {String}  item     key
		 * @param  {Boolean} isWechat 是否是微信
		 * @return {DOMObject}           
		 */
		function _createShareElements(url, item, isWechat) {
			var _e = document.createElement('a');
			_e.innerHTML = _icons[item];
			if (this.settings.isTitle) {
				_e.title = _names[item];
			}
			if (isWechat) {
				this.wx = new WX(_e, url, this.settings.WXoptions);
				_e.href = 'javascript:void(0);';
			} else {
				_e.href = url;
				_e.target = '_blank';
			}
			return _e;
		}
		/**
		 * _autoUpdate 动态创建分享
		 */
		function _autoUpdate() {
			var _docfrag = document.createDocumentFragment(),
				_tpls = Util.parseUrl(_templates, this.settings),
				_element,
				_me = this;

			Util.each(_me.settings.sites, function (index, item) {
				if (item === 'iShare_wechat') {
					// _element = _createShareElements.call(_me, _tpls[item], item, true);
					_element = _createShareElements.call(_me, _me.settings.url, item, true);
				} else {
					_element = _createShareElements.call(_me, _tpls[item], item);
				}
				_docfrag.appendChild(_element);
			});
			this.container.innerHTML = '';
			this.container.appendChild(_docfrag);
		}

		//prototype
		return {
			constructor: iShare,
			init: function () {
				if (this.settings.initialized) {
					_autoUpdate.call(this);
				} else {
					_updateUrl.call(this);
				}
				if (this.wx) {
					this.bindEvent();
					this.wx.init();
				}
			},
			bindEvent: function () {
				var me = this;
				// 只绑定一次，进行初始化
				function mouseenterCB() {
					Util.event.removeEvent(me.container, 'mouseover', mouseenterCB);
				}
				Util.event.addEvent(this.container, 'mouseover', mouseenterCB);
			}
		}
	})();
	if (window.iShare_config) {
		return (new iShare());
	} else {
		return iShare;
	}
});