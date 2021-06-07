$(function(){
	$("#menuLi > li").hover(function(){
		var backNo = $(this).attr("data-back");
		var style = "about"+backNo;
		var newStyle = "selabout"+backNo;
		$(this).removeClass(style);
		$(this).addClass(newStyle);
	},function(){
		var backNo = $(this).attr("data-back");
		var style = "about"+backNo;
		var newStyle = "selabout"+backNo;
		$(this).removeClass(newStyle);
		$(this).addClass(style);
	})
})