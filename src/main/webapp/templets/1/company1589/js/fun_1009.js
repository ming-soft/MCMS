// JavaScript Document
//ͷ��������
function mainMenu(){
	$("#main_nav ul li").not( $(".selected") ).hover(
		function(){
			$(this).stop().css({'background-position': '0px 0px'},100);
		},function(){
			$(this).stop().css({'background-position': '0px -6px'},100)
		}
	);
	
	$(".seemore").click(function(){
	$(this).stop().animate({width:'0px',height:'0px'},20);
	$(".index_news_list div").removeClass("youshiyc")
    })
}
//���s����
function sns(){
	$(".sns_share li").hover(
		function(){
			$(this).find(".sns_content").show().stop().animate({left: '40px', opacity:'1'},250);
		},function(){
			$(this).find(".sns_content").stop().animate({left: '0px', opacity:'0'},250);
		}
	)
}

//footer ebg&emg btn
function footerEliteGroup(){
	$("#elite_group_btn li a img").css("opacity","0");
	
	$("#elite_group_btn li a").hover(
		function(){
			$(this).find("img").stop().animate({opacity:'1'},350);
		},function(){
			$(this).find("img").stop().animate({opacity:'0'},350);
		}
	)
}

//�@�~�C��
function workList(){
	$(".works_list li a").hover(
		function(){
			$(this).find(".lighten").stop().animate({'opacity':'1'},{ duration: 900, easing: 'easeOutExpo'});
		},function(){
			$(this).find(".lighten").stop().animate({'opacity':'0'},{ duration: 500, easing: 'easeOutExpo'});
		}
	)
}



//===================================================================================================================================================================


//show get id work
function show_work_get_id_content_fun(){
	
	$(".show_area").css('visibility','hidden');
	show_work_content_fun();//���}
	$('.show_area .img').waitForImages(function() {
		resizeWorkcontentImgW();
	});
	//workContent();
}

//�@�~���e
function workContent(){
	
	//�@�~���e��l��
	workContentInit();
	
	//���s���s
	work_content_sns();
		
	//�Ϥ�slide ������s
	work_content_imgSlide();
}

//�@�~���e��l��
function workContentInit(){
	$(".work_content_img .show_area").css({"margin-left":0});
	
	//�P�_�O�_���v��,�����e�W�[�Ϥ�����e��
	if($(".work_content_img .video").width() !== null){
		$(".work_content_img .img").css({"margin-left":"660px"});
	}
	
	//resizeWorkcontentImgW();
}

//�@�~���s����
function work_content_sns(){
	$(".work_content_sns li").hover(
		function(){
			$(this).find(".sns_content").show().stop().animate({top: '-25px', opacity:'1'},250);
		},function(){
			$(this).find(".sns_content").stop().animate({top: '0px', opacity:'0'},250);
		}
	)
}


//�M�Ÿ��
function clear_work_content_fun(){
	$(".img").children("img").attr("src","");//$(".img").children("img").remove();
	$("#work_title").children("h2").text("");
	$("#work_title").children("h3").text("");
	$(".info").text("");
	//css�]�w
	$(".work_content_selection ul li a").css("display","none");
	$(".work_content_img a").hide();
	$(".work_content_sns ul li").hide();
}

//���}
function show_work_content_fun(){
	$(".work_content").slideDown({ duration: 1200, easing: 'easeOutExpo'});
	$("html, body").animate({ scrollTop: 0 }, { duration: 1200, easing: 'easeOutExpo'});
	$(".sns_share").hide();
}


//�@�~�Iback����function
function work_content_back_fun(e){
	$(".work_content").slideUp({ duration: 1200, easing: 'easeOutExpo'});
	$(".sns_share").show();
}


//�Ϥ�slide ������s
function work_content_imgSlide(){
	var windowW;
	var imgContentW;
	var nowImgPo = parseInt($(".work_content_img .show_area").css("margin-left"));;
	var count = 0;
	var imgContent = $(".work_content_img .show_area");
	
	imgContent.mousewheel(
		function(event, delta){
			nowImgPo = parseInt($(".work_content_img .show_area").css("margin-left"));;
			windowW = $("#main").width();
			imgContentW = $(".work_content_img .show_area").width();
			nowImgPoTo = nowImgPo+200*delta;
			
			if (nowImgPoTo>0){
				nowImgPoTo= 0;
			}else if(nowImgPoTo<windowW-imgContentW){
				nowImgPoTo = windowW-imgContentW;
			}
			
			$(".work_content_img .show_area").stop().animate({ 'margin-left': nowImgPoTo+'px' }, { duration: 1200, easing: 'easeOutExpo'});
				
			return false;
		}
	)
	
	$(".po_ctrl_left").hover(
		function(){
			$(this).stop().animate({ 'margin-left': '-25px' }, { duration: 300});
		},function(){
			$(this).stop().animate({ 'margin-left': '-40px' }, { duration: 300});
		}
	)
	
	$(".po_ctrl_right").hover(
		function(){
			$(this).stop().animate({ 'margin-right': '-25px' }, { duration: 300});
		},function(){
			$(this).stop().animate({ 'margin-right': '-40px' }, { duration: 300});
		}
	)
	
	$(".po_ctrl_left, .po_ctrl_right").click(
		function(){
			windowW = $("#main").width();
			imgContentW = $(".work_content_img .show_area").width();
			nowImgPo = parseInt($(".work_content_img .show_area").css("margin-left"));
			
			if($(this).attr("class") == "po_ctrl_left"){
				if(nowImgPo<0){
					if(nowImgPo> -660){
						$(".work_content_img .show_area").stop().animate({ 'margin-left': 0 }, { duration: 1200, easing: 'easeOutExpo'});
					}else{
						$(".work_content_img .show_area").stop().animate({ 'margin-left': nowImgPo+660+'px' }, { duration: 1200, easing: 'easeOutExpo'});
					}
				}
			}else if($(this).attr("class") == "po_ctrl_right"){
				if(nowImgPo>windowW-imgContentW){
					if(nowImgPo<windowW-imgContentW+660){
						$(".work_content_img .show_area").stop().animate({ 'margin-left': windowW-imgContentW+'px' }, { duration: 1200, easing: 'easeOutExpo'});
					}else{
						$(".work_content_img .show_area").stop().animate({ 'margin-left': nowImgPo-660+'px' }, { duration: 1200, easing: 'easeOutExpo'});
					}
				}
			}
		}
	)
}


//�@�~�I�}����function
function works_list_click_fun(e,fname){
	
	//clear_work_content_fun();//�M�Ÿ��
	
	unbind_fun();
	
	show_work_content_fun();//���}
	
	//ajax��ť(loading��)
	$(".loading").bind("ajaxSend", function(){
	  $(this).show();
	});
	
	//ajax�����
	$.ajax({
		url: 'template/'+fname,
		cache: false,
		dataType: 'html',
		type:'POST',
		data: {i: e.attr("id"),p:get_page,t:get_type},
		/*error: function(xhr) {
				alert('Ajax request �o�Ϳ��~');
			},*/
		success: function(response) {
				//alert(response);
				$(".show_area").fadeOut("slow"); //$(".img").children("img").fadeOut("slow"); 
				$(".work_content_container").remove();
				$(".work_content").children("script").remove();
				$(".work_content").append(response);
				$(".show_area").css('visibility','hidden');//$(".show_area").hide();//$(".img").children("img").hide();
				
				$('.show_area .img').waitForImages(function() {
					resizeWorkcontentImgW();
				});
				
			}
	});
	
}


function fade_fun_1(){
	$(".loading").fadeOut("slow"); 
	workContent();
	bind_fun();
}
function fade_fun_3(){
	$(".show_area").fadeIn("slow"); //$(".img").children("img").fadeIn("slow"); 
	fade_fun_1();
}
//��������
function page_click_fun(e,fname){
	get_page=e.attr("id");
	var get_str = get_str_fun();
	location.href=fname+get_str;
}

function get_str_fun(){
	var str='';
	if(get_type){
		if(str){
			str=str+"&t="+get_type;
		}else{
			str="?t="+get_type;
		}
	}
	if(get_page){
		if(str){
			str=str+"&p="+get_page;
		}else{
			str="?p="+get_page;
		}
	}
	return str;
}

//resize�@�~���e�Ϥ��`�e
var workContentWorkW;
function resizeWorkcontentImgW(){
	workContentWorkW = 0;
	$(".work_content_img .img img").each(
		function(i){
			workContentWorkW+=$(this).width();
		}
	);
	
	$(".work_content_img .img").width(workContentWorkW);
	$(".show_area").hide();
	$(".show_area").css('visibility','visible');
	setTimeout("fade_fun_3()",200);
}
