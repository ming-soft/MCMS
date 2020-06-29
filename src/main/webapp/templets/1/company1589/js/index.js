// JavaScript Document
$(document).ready(function(){
	
	$('.works_list .work_img').lazyload({effect : "fadeIn"});
	
	mainMenu();
	sns();
	footerEliteGroup();
	workList();
	aboutContent();
	
//Move();
	$(window).resize(Move);
	$(window).bind('scroll',Move);
	
	$('.header_bg').css("opacity","0");
	
	//開啟計時器計算時間
	setInterval(dateCount,1000);
	
	//scrollDownBtn();
	
	//控制window scroll
	$('#main').mousewheel(
		function(event, delta){
			var po =$(window).scrollTop()-100*delta;
			$('html, body').stop().animate({scrollTop: po},550);
			return false;
		}
	)
	//---------------------------------------------------------------
	$("body").waitForImages({
		finished: function() {
			$("#main").waitForImages({
				finished: function() {
					$("#main_loading").fadeOut("slow"); 
					$("#main").fadeIn("slow");
				},
				waitForAll: true
			});
		},
		waitForAll: true
	});
	
})


function scrollDownBtn(){
	var scroll_top = $(window).scrollTop()
	
	$('.scroll_down').click(
		function(){
			scroll_top = $(window).scrollTop()
			$('html, body').stop().animate({scrollTop: scroll_top+=200},500);
		}
	)
	
	function ani(){
		//$('html, body').stop().animate({scrollTop: scroll_top+=5},1,ani);
		scroll_top = $(window).scrollTop();
		$('html, body').stop().animate({scrollTop: scroll_top+=3},1,ani);
	}
}



function aboutContent(){
	$('#main_content #service .serviceBall a').css("opacity","0");
	
	$('#main_content #service .serviceBall').hover(
		function(){
			$(this).find("a").show().stop().animate({opacity:'1'},{ duration: 600});
			$(this).find(".out").stop().animate({opacity:'0'},{ duration: 600});
		},function(){
			$(this).find("a").stop().animate({opacity:'0'},{ duration: 600});
			$(this).find(".out").stop().animate({opacity:'1'},{ duration: 600});
		}
	)
}

function Move(){
	var windowH = $(window).height();
	var allH = $(document).height();
	var aniDistance = allH-windowH;
	var scrollTop = $(window).scrollTop();
	var banner = $('#main_container #banner'),
		bannerH = banner.height();
	var mainContent = $('#main_container #main_content'),
		mainContentH = mainContent.height();
	var finalContent = $('#final #final_content #equation_content'),
		finalContentH = finalContent.height();
		
	var bannerAniDis = bannerH-windowH/5;
	var mainAniDis = aniDistance-windowH/4;
	
	
	if(scrollTop>300){
		$('.header_bg').show().stop().animate({opacity:'1'},{ duration: 400, easing: 'easeOutExpo'});
	}else{
		$('.header_bg').stop().animate({opacity:'0'},{ duration: 400, easing: 'easeOutExpo'});
	}
	
	if(scrollTop >= $(document).height()-windowH){
		$('.scroll_down').stop().animate({opacity:'0'},{ duration: 400, easing: 'easeOutExpo'});
	}else{
		$('.scroll_down').stop().animate({opacity:'1'},{ duration: 400, easing: 'easeOutExpo'});
	}
	
	
	//判斷三個動畫區塊時間點
	if(scrollTop<=bannerAniDis){
		var persent = scrollTop/bannerAniDis;
		
		//隱藏main_content遮罩圖片
		$('#main_content_cover').css({visibility:"hidden"});
		//關閉main_content動畫圖片
		mainContent.find("div").each(
			function(i){
				if(mainContent.find("div").eq(i).attr("data-type")=="movable"){
					mainContent.find("div").eq(i).hide();
				}
			}
		)
		//------------------------------------------------------------------
		
		bannerAction(banner,persent);
		mainAction(mainContent,0);
			
	}else if(scrollTop>bannerAniDis && scrollTop<=mainAniDis){
		var persent = (scrollTop-bannerAniDis)/(mainAniDis-bannerAniDis);
		
		//顯示main_content遮罩圖片
		$('#main_content_cover').css({visibility:"visible"});
		
		bannerAction(banner,1);
		mainAction(mainContent,persent);
		finalAction(finalContent,0);
		
	}else{
		var persent = (scrollTop-mainAniDis)/(aniDistance-mainAniDis);
		
		bannerAction(banner,1);
		mainAction(mainContent,1);
		finalAction(finalContent,persent);
	}
}

//banner 動態控制
function bannerAction(obj,num){
	var persent = num;
	var moveObjContent = obj;
	
	moveObjContent.find('div').each(
		function(i){
			var speed = 300;
			
			if(moveObjContent.find('div').eq(i).attr("data-type")=="movable"){
				var offsetY = moveObjContent.find('div').eq(i).attr("data-offsetY");
				
				//moveObjContent.find('div').eq(i).stop().animate({top:offsetY*persent +'px'},speed);
				//moveObjContent.find('div').eq(i).stop().animate({backgroundPosition:'50% '+offsetY*persent +'px'},speed);
				moveObjContent.find('div').eq(i).stop().css({backgroundPosition:'50% '+offsetY*persent +'px'});
			}
		}
	)	
}

//main_content 動態控制
function mainAction(obj,num){
	var persent = num;
	var moveObjContent = obj;
	
	moveObjContent.find('div').each(
		function(i){
			var speed = 300;
			
			if(moveObjContent.find('div').eq(i).attr("data-type")=="movable"){
				var offsetY = moveObjContent.find('div').eq(i).attr("data-offsetY");
				//移動位置
				var y = offsetY*persent-moveObjContent.find('div').eq(i).attr("data-oriset");
				//打開main_content動畫圖片
				moveObjContent.find('div').eq(i).show();
				
				//moveObjContent.find('div').eq(i).stop().animate({backgroundPosition:"'50% "+y +'px"'},speed);
				moveObjContent.find('div').eq(i).css({backgroundPosition:'50% '+y +'px'});
			}
		}
	)
}

//final_equation 動態控制
function finalAction(obj,num){
	var persent = num;
	var moveObjContent = obj;
	
	moveObjContent.find('div').each(
		function(i){
			var speed;
			
			if(moveObjContent.find('div').eq(i).attr("data-type")=="movable"){
				var offsetY = moveObjContent.find('div').eq(i).attr("data-offsetY");
				//移動位置
				var y = offsetY*persent-moveObjContent.find('div').eq(i).attr("data-oriset");
				speed = moveObjContent.find('div').eq(i).attr("data-speed");
				
				moveObjContent.find('div').eq(i).stop().animate({top:y +'px'},{ duration: speed});
			}
		}
	)
}

/*------------------------------------------------------------------*/
var startDate = new Date('2008/08/08 08:00');
var nowDate
var total
var hr
var hrFormate

function dateCount(){
	nowDate = new Date();
	total = (nowDate-startDate)/1000;
	hr = Math.floor(total/60/60);
	hrFormate = formatNumber(String(hr));
	
	$('#time_content #big_time').text(hrFormate);
	$('#time_content #note span').text(hrFormate);
}

function formatNumber(str) {
	if(str.length <= 3){ 
		return str;
	}else{
		return formatNumber(str.substr(0,str.length-3))+','+str.substr(str.length-3);
	}
}
/*--------------------------------------------------------------------*/