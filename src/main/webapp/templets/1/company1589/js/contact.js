// JavaScript Document

$(document).ready(function(){
	$("#main_nav ul li").not( $(".selected") ).hover(
		function(){
			$(this).stop().css({'background-position': '0px 0px'},100);
		},function(){
			$(this).stop().css({'background-position': '0px -6px'},100);
		}
	);
});

function bind_fun(){
	//���ͷs�����ҽX
	$("img#ckcodeimg").bind("click",function(){
		new_ck_code_fun();
	});
}

function unbind_fun(){
	$("img#ckcodeimg").unbind("click");
}
function new_ck_code_fun(){
	unbind_fun();
	
	//Ajax�B�z
	$.ajax({
		url: 'js/page/template/newCkCodeNu.php',
		cache: false,
		dataType: 'html',
		type:'POST',
		data: {},
		//error: function(xhr) {
		//		alert('Ajax request �o�Ϳ��~');
		//	},
		success: function(response) {
				codenu=response;
			}
	});
	
	$("img#ckcodeimg").attr("src","template/CkCodeNu.php?rnd="+ Math.random());
	
	bind_fun();
}
