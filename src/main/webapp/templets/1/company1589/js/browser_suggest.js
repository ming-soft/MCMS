// JavaScript Document

/*判斷瀏覽器版本-------------------------*/
var browserName = navigator.appName;
var browserVersion = navigator.appVersion;
var locationHref = location.href

if(browserName.charAt(0) =='M'){
	if(browserVersion.indexOf('MSIE 6') != -1){
		location.href = 'http://www.design-ebg.com/tw/js/no_ie6.html';
	}
}


/*---------------------------------------*/