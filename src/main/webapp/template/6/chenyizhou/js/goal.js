// 将页面居中显示
 $(window).resize(function(){
	if($(window).width()>1140 && $(window).height()>550){
		$('.contentFixed').css({
			position:'absolute',
			left: ($(window).width() - $('.contentFixed').width())/2,
			top: ($(window).height() - $('.contentFixed').height())/2
		});	
	}else if($(window).width()>1140){
			$('.contentFixed').css({
				position:'absolute',
				left: ($(window).width() - $('.contentFixed').width())/2
			});	
		}else if($(window).height()>550){
			$('.contentFixed').css({
				position:'absolute',
				top: ($(window).height() - $('.contentFixed').height())/2
			});	
		}
 	});

 // To initially run the function:
 $(window).resize();
 // 将页面居中显示结束
