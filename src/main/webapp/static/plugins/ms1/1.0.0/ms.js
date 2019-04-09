(function(window) {
	var ms = {
		base: null, //主机地址
		login:"/login.htm", //登录页面
		debug:true, //测试模式
		log:function(msg) {
			console.log(msg);
		}
	}
	window.ms = ms;
})(window); 