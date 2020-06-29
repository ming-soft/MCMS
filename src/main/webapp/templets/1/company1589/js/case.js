// JavaScript Document
function wordks(id,images_url,show_title){
	//alert(id);
    if(id!=null){	
		var $this = $(this), url = $this.prop('href'); //id = $this.data('id');
			document.getElementById("tpd").innerHTML='<div id="DB_gallery"><div class="DB_imgSet"><div class="DB_imgWin"><img src="'+images_url+'" alt="" width="1170" height="440"/></div></div></div>';
		$("#work_title").children("h3").html(show_title);
	}
}

			
function wordks2(id,images_url,show_title){
	//alert(id);
    if(id!=null){	
		var $this = $(this), url = $this.prop('href'); //id = $this.data('id');
			document.getElementById("tpd").innerHTML='<div id="DB_gallery"><div class="DB_imgSet"><div class="DB_imgWin"><img src="'+images_url+'" alt="" width="1170" height="440"/></div></div></div>';
		$("#work_title").children("h3").html(show_title);
	}
}		
	     		
		



		
	


$(document).ready(function(){
	
	//$("#main_nav ul li").eq(2).attr("class","selected");//�w�]menu
	
	$('.works_list .work_img').lazyload({effect : "fadeIn"});
	
	mainMenu();//�D���
	sns();//���s����-��
	footerEliteGroup();//footer ebg&emg btn
	
	workList();//�@�~�C��
	
	if(get_id||get_sid){
		setTimeout("show_work_get_id_content_fun()",600);//���}�@�~
	}else{
		bind_fun();
	}
	
	
	//��ť
	$(".page_nav .page_nav_control tbody tr").children().children().bind("click",function(){
		page_click_fun($(this),"js/page/case.php");//��������
	});
	
});




function bind_fun(){
	
	$(".works_list li a").bind("click",function(){
		works_list_click_fun($(this),"js/page/case_content.php");//list�I�}�@�~
	});
	$(".work_content_selection #backBtn").bind("click",function(){
		work_content_back_fun($(this));//back
	});
	$(".work_content_selection #prevBtn a").bind("click",function(){
		works_list_click_fun($(this),"js/page/case_content.php");//�W�@�ӧ@�~
	});
	$(".work_content_selection #nextBtn a").bind("click",function(){
		works_list_click_fun($(this),"js/page/case_content.php");//�U�@�ӧ@�~
	});
	
	$(".youtube").colorbox({iframe:true, innerWidth:640, innerHeight:480});
	
	//resizeWorkcontentImgW();
	
}

function unbind_fun(){
	/*$(".works_list li a").unbind("click");
	$(".work_content_selection #backBtn").unbind("click");*/
	$(".work_content_selection #prevBtn a").unbind("click");
	$(".work_content_selection #nextBtn a").unbind("click");
}


	


