var ms = {}
/**
 * 需要用户登陆的地方引入此文件,依赖juery
 */
ms.user = {
		/**
		 * 对需要用户登陆才能看到的界面进行过滤 config:如果存在，必须包含user-login-page登陆界面
		 */
		filter:function(config) {
			if (config==undefined || config.user-login-page==undefined) {
				var temp = {loginPath:"/people.do"};
				config = temp;
			}
			$.ajax({
		 		type:"POST",
		 		dataType:"json",
		 		url:"/people/user/getEntity.do",
		 		beforeSend:function() {
		 			$("body").hide();
		 		},
		 		success:function(msg){
		 			if(msg.result==false){// 没有登陆或获取用户信息出错
		 						 location.href=config.loginPath;
		 			} else {
		 				$("body").show();
		 			}
		 		}
			});
		}
}

$(function() {
	ms.user.filter();
})