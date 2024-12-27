    $(document).ready(function(){
     $(".touch-toggle a").click(function(event){

      var className = $(this).attr("data-drawer");

      if( $("."+className).css('display') == 'none' ){      

       $("."+className).slideDown().siblings(".drawer-section").slideUp();
	   $(".touch_bg").slideDown();//20170419
      }else{

       $(".drawer-section").slideUp(); 
	   $(".touch_bg").slideUp();//20170419

      }
      event.stopPropagation();
	  
     });
 
	$(".touch_bg").click(function(){
			 $(".drawer-section").slideUp();   	
			  $(".touch_bg").slideUp();//20170419
		 })	
	$(".closetitle").click(function(){
			 $(".drawer-section").slideUp();   	
			  $(".touch_bg").slideUp();//20170419
		 })	
		
     //$(document).click(function(){
//
//      $(".drawer-section").slideUp();   
//	  
//     })

     $('.touch-menu a').click(function(){     

      if( $(this).next().is('ul') ){

       if( $(this).next('ul').css('display') == 'none' ){
		$('.touch-menu ul li').find("ul").slideUp();
		$('.touch-menu ul li').find("a").find('i').attr("class","touch-arrow-down");
        $(this).next('ul').slideDown();

        $(this).find('i').attr("class","touch-arrow-up");     
		//$(".touch-top").css("position","absolute");
       }else{

        $(this).next('ul').slideUp();

        $(this).next('ul').find('ul').slideUp();

        $(this).find('i').attr("class","touch-arrow-down");
		//$(".touch-top").css("position","fixed");

       }   

      }

     });


    });
	
	  
  
    // 导航显示与隐藏
  var NavHeight = false;
  $(window).scroll(function(){
    Nav();
  })
  Nav();
  function Nav(){
    if( $(window).scrollTop() > $(window).height() && NavHeight == false ){
      $("body").addClass("nav-hide");
      NavHeight = true;
    }else if($(window).scrollTop() <= $(window).height() && NavHeight == true ){
      NavHeight = false;
      $("body").removeClass("nav-hide");
    }
  }

    window.onmousewheel = document.onmousewheel = document.onmousewheel = function(e){
      e = e || window.event;
      var delta = 0;
      if (e.wheelDelta) {
        delta = e.wheelDelta/120;
      } else if (e.detail) {
        delta = -e.detail/3;
      }
      if (delta > 0) {
        $("body").removeClass("nav-hide");
      } else if (delta < 0) {
       $("body").addClass("nav-hide");
      }
     }
