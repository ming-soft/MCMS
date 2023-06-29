function g(o){return document.getElementById(o);}
//window.onload=function()
//{
	$(".top_search").find("em").click(function(){
		if($(".search_con").css("display")=="none")
		{
			$(".search_con").css("display","block");
			$(".search_con").animate({"height":"39px"},"fast");
		}
		else
		{$(".search_con").css("display","none");	
		$(".search_con").animate({"height":"0px"},"fast");
		}
	});
	$(".search_con").hover(function(){},function(){
		$(".search_con").css("display","none");	 
	})
	
//$(".side ul li").hover(function(){
//				$(this).find(".sidebox").stop().animate({"width":"180px"},200).find("img").css({"opacity":"1","filter":"Alpha(opacity=100)"});
//			},function(){
//				$(this).find(".sidebox").stop().animate({"width":"56px",},200).find("img").css({"opacity":"0.8","filter":"Alpha(opacity=80)"});
//			});
//	 $('.sideewm').hover(function(){
//				$('.ewBox').stop().show();
//			},function(){
//				$('.ewBox').stop().hide();
//			});
	
	
	
	

//}

//回到顶部
function goTop(){
	$('html,body').animate({'scrollTop':0},600);
}

function inewsc(objs,src)
{
$(objs).attr("src",src);
}

