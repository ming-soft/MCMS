var autoLb = false;          //autoLb=true为开启自动轮播
var autoLbtime = 1;         //autoLbtime为轮播间隔时间（单位秒）
var touch = true;           //touch=true为开启触摸滑动
var slideBt = true;         //slideBt=true为开启滚动按钮
var slideNub;               //轮播图片数量

//窗口大小改变时改变轮播图宽高
/*$(window).resize(function(){
$(".slide").height($(".slide").width()*0.56);
});*/


$(function(){
/*$(".slide").height($(".slide").width()*0.56);*/
slideNub = $(".slide .img").size();             //获取轮播图片数量
for(i=0;i<slideNub;i++){
	$(".slide .img:eq("+i+")").attr("data-slide-imgId",i);
}

//根据轮播图片数量设定图片位置对应的class
if(slideNub==1){
	for(i=0;i<slideNub;i++){
		$(".slide .img:eq("+i+")").addClass("img3");
	}
}
if(slideNub==2){
	for(i=0;i<slideNub;i++){
		$(".slide .img:eq("+i+")").addClass("img"+(i+3));
	}
}
if(slideNub==3){
	for(i=0;i<slideNub;i++){
		$(".slide .img:eq("+i+")").addClass("img"+(i+2));
	}
}
if(slideNub>3&&slideNub<6){
	for(i=0;i<slideNub;i++){
		$(".slide .img:eq("+i+")").addClass("img"+(i+1));
	}
}
if(slideNub>=6){
	for(i=0;i<slideNub;i++){
		if(i<5){
		   $(".slide .img:eq("+i+")").addClass("img"+(i+1)); 
		}else{
			$(".slide .img:eq("+i+")").addClass("img5"); 
		}
	}
}

//根据轮播图片数量设定轮播图按钮数量
if(slideBt){
	for(i=1;i<=slideNub;i++){
		$(".slide-bt").append("<span data-slide-bt='"+i+"' onclick='tz("+i+")'></span>");
	}
	$(".slide-bt").width(slideNub*34);
	$(".slide-bt").css("margin-left","-"+slideNub*17+"px");
}

//自动轮播
if(autoLb){
	setInterval(function(){
	right();
}, autoLbtime*500);
}


if(touch){
	k_touch();
}
slideLi();
imgClickFy();
})

//右滑动
function right(){
var fy = new Array();
for(i=0;i<slideNub;i++){
	fy[i]=$(".slide .img[data-slide-imgId="+i+"]").attr("class");
}
for(i=0;i<slideNub;i++){
	if(i==0){
		$(".slide .img[data-slide-imgId="+i+"]").attr("class",fy[slideNub-1]);
	}else{
	   $(".slide .img[data-slide-imgId="+i+"]").attr("class",fy[i-1]); 
	}
}
imgClickFy();
slideLi();
}

//左滑动
function left(){
var fy = new Array();
for(i=0;i<slideNub;i++){
	fy[i]=$(".slide .img[data-slide-imgId="+i+"]").attr("class");
}
for(i=0;i<slideNub;i++){
	if(i==(slideNub-1)){
		$(".slide .img[data-slide-imgId="+i+"]").attr("class",fy[0]);
	}else{
	   $(".slide .img[data-slide-imgId="+i+"]").attr("class",fy[i+1]); 
	}
}
imgClickFy();
slideLi();
}

//轮播图片左右图片点击翻页
function imgClickFy(){
$(".slide .img").removeAttr("onclick");
$(".slide .img2").attr("onclick","left()");
$(".slide .img4").attr("onclick","right()");
}

//修改当前最中间图片对应按钮选中状态
function slideLi(){
var slideList = parseInt($(".slide .img3").attr("data-slide-imgId")) + 1;
$(".slide-bt span").removeClass("on");
$(".slide-bt span[data-slide-bt="+slideList+"]").addClass("on");
}

//轮播按钮点击翻页
function tz(id){
var tzcs = id - (parseInt($(".slide .img3").attr("data-slide-imgId")) + 1);
if(tzcs>0){
	for(i=0;i<tzcs;i++){
		setTimeout(function(){
		  right();  
		},1);
	}
}
if(tzcs<0){
	tzcs=(-tzcs);
	for(i=0;i<tzcs;i++){
		setTimeout(function(){
		  left();  
		},1);
	}
}
slideLi();
}


//触摸滑动模块
function k_touch() {
var _start = 0, _end = 0, _content = document.getElementById("slide");
_content.addEventListener("touchstart", touchStart, false);
_content.addEventListener("touchmove", touchMove, false);
_content.addEventListener("touchend", touchEnd, false);
function touchStart(event) {
	var touch = event.targetTouches[0];
	_start = touch.pageX;
}
function touchMove(event) {
	var touch = event.targetTouches[0];
	_end = (_start - touch.pageX);
}

function touchEnd(event) {
	if (_end < -100) {
		left();
		_end=0;
	}else if(_end > 100){
		right();
		_end=0;
	}
}
}