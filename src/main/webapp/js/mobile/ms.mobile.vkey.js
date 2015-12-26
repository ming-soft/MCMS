;(function($){
  $.extend($.fn, {
   //v 键
   //cfg:JSON配置
   //主题
   //生成后的代码格式
   //     <div class="ms-widget-menu-key red">
   //      <div class="ms-square ms-widget-main ms-w15 ms-text-vcenter" style="border: 2px #CCC solid;" data-isopen="false">V</div>
   //      <a class="ms-widget-child ms-square" style="border:3px #FF3E5A solid;" href="/people/expressOrder.do"><i class="icon iconfont ms-font-size2">&#xe901;</i></a>
   //      <a class="ms-widget-child ms-square" style="border:3px #FF3E5A solid;"   href="{ms:global.url/}/2767/2765/index.html"><i class="icon iconfont ms-font-size2">&#xe8df;</i></a>
   //      <div class="ms-widget-child ms-square" style="border:3px #FF3E5A solid;"   data-toggle="modal"  data-target="#myQ"><i class="icon iconfont ms-font-size2">&#xe699;</i></div>
   //      <div class="ms-widget-child ms-square" style="border:3px #FF3E5A solid;"  id="share"><i class="icon iconfont ms-font-size2">&#xe710;</i></div>
   // </div>
   vkey: function(cfg){ 
	var theme = "red";
	if (typeof(cfg) != "undefined") {
		alert("c");
		//主题
		if (typeof(cfg.theme)!="undefined") {
			theme  = cfg.theme;
		}
	}
	//主要图标
	this.addClass('ms-widget-menu-key').addClass(theme);
	//小图标
	//展示方式
	//生成html

     
    }
  })
})(Zepto)