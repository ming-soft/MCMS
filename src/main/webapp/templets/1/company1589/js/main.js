// JavaScript Document

$(function(){

	/*测试事件*/
	var $window = $(window);
    var position = "top";
    var posScroll = 0;
	var $design = $("#design");
	var $web = $("#web");
	var $mobile = $("#mobile");
	var indexshow = false;
	/************************************初始化**********************************************/
	var ww = $window.width();
	var wh = $window.height();
	
	posScroll = $window.scrollTop();
	//var rebondFleche = true;
	if(posScroll>20)
	{
		$(".bannerV").hide();
		//rebondFleche = false;
	}

	//jQuery("#clients").slide({mainCell:"#bd",effect:"leftLoop",vis:1,scroll:1,autoPlay:false,delayTime :2000});
	/************************************滚轮事件********************************************/
	$window.scroll(function() {
        posScroll = $window.scrollTop();				//获取当前滚动高度\
		if(posScroll>20)
		{
			if($(".bannerV").css("display") == "block")
			$(".bannerV").fadeOut();
		}
		else
		{
			if($(".bannerV").css("display") == "none")
			$(".bannerV").fadeIn();
		}

		if(posScroll>0 && posScroll<1755)
		{
			$("section#client").css("background-position","0 " + (posScroll/2- 600) + "px");
		}
		
		
		if(posScroll>560){
		$("section#contact").css("background-position","0 " + (posScroll/3- 800) + "px");
			var iii = 0;
			$(".index_news_list .index_news").each(function(){
				//$(this).delay(iii*100).addClass("index_newss");
				var obj = $(this);
				obj.delay(iii*200).queue(function(){
					obj.addClass("index_newss");
				});
				iii++;
			});
		}
		
		
		
		if(posScroll>200)
		{
			$(".servies_index_itemb").addClass("servies_index_show");
			$(".ffonts").delay(400).animate({"padding-top":20,"-moz-opacity":1,"opacity":1},450);
		}
		
		var iii = 0;
		if(posScroll>3300)
		{
			$(".weixinitem").each(function(){
				$(this).delay(iii*100).animate({"margin-top":0},600,"easeOutBack");
				iii++;							
			});
		}
		
        //测试用显示数字
        $("#text").html(posScroll + "|" + indexshow);
	});
    $("#text").html(posScroll);
});



		
		





