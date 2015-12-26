//退出登录
function exitLogin() {
	ms.people.quit({"func":function(json){
        $.cookies.del('PEOPLE_COOKIE');
        location.href = "/html/1549/index.html";
	}});
}
