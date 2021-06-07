// 异步同载   begin
function about(url,obj,sel0,sel1) {
	$.ajax({
		type:"get",
		url:url,
		beforeSend: function(data,textStatus){
			$("#abouts").html("<div style='text-align:center'><div style='height:250px;'></div><img  src='/templets/1520/yangchao/images/ajax-loader.gif'/><div>");
		},
		
		success:function(data,textStauts){
			$("#abouts").html($("#picList").html());
			$(".picture").html("");
			for(var i=0 ;i<data.count;i++){
				$('#picTmp').tmpl(data.list[i]).appendTo('.picture');
				
			}
			scrollBar();
			$("#abouts").fadeTo(3000, 1);
			
		},			
		error:function(){
			$("#abouts").text("失败");
		}	
	});
	setClass(obj,sel0,sel1);
}

//ajax请求文章内容详细信息
function ajaxContact(url,obj,sel0,sel1){
	$.ajax({
		type:"get",
		url:url,
		beforeSend: function(data,textStatus){
			$("#abouts").html("<div style='text-align:center'><div style='height:250px;'></div><img  src='/templets/1520/yangchao/images/ajax-loader.gif'/><div>");
		},
		
		success:function(data,textStauts){
			$("#abouts").html("");
			$("#abouts").html($("#contentDetail").html());
			$(".contentbody").html(data.articleContent);
			scrollBar();
		},			
		error:function(){
			$("#abouts").text("失败");
		}	
	});
	setClass(obj,sel0,sel1);
}

function scrollBar() {
	$(".content").mCustomScrollbar({
		setWidth:false,
		setHeight:false,
		setTop:0,
		setLeft:0,
		axis:"y",
		scrollbarPosition:"inside",
		scrollInertia:950,
		autoDraggerLength:true,
		autoHideScrollbar:false,
		autoExpandScrollbar:false,
		alwaysShowScrollbar:0,
		snapAmount:null,
		snapOffset:0,
		mouseWheel:{
			enable:true,
			scrollAmount:"auto",
			axis:"y",
			preventDefault:false,
			deltaFactor:"auto",
			normalizeDelta:false,
			invert:false
		},
		scrollButtons:{
			enable:false,
			scrollType:"stepless",
			scrollAmount:"auto"
		},
		keyboard:{
			enable:true,
			scrollType:"stepless",
			scrollAmount:"auto"
		},
		contentTouchScroll:25,
		advanced:{
			autoExpandHorizontalScroll:false,
			autoScrollOnFocus:"input,textarea,select,button,datalist,keygen,a[tabindex],area,object,[contenteditable='true']",
			updateOnContentResize:true,
			updateOnSelectorLength:false
		},
		theme:"light",
		callbacks:{
			onScrollStart:false,
			onScroll:false,
			onTotalScroll:false,
			onTotalScrollBack:false,
			whileScrolling:false,
			onTotalScrollOffset:0,
			onTotalScrollBackOffset:0,
			alwaysTriggerOffsets:true
		},
		live:false
	});	
	
}


// 异步同载   begin
function ajaxNews(url) {
	$.ajax({
		type:"get",
		url:url,
		beforeSend: function(data,textStatus){
			$("#abouts").html("<div style='text-align:center'><div style='height:250px;'></div><img  src='templets/yangchao/images/ajax-loader.gif'/><div>");
		},
		success:function(data,textStauts){
			$("#abouts").css("display","none");
			$("#abouts").html(data);
			$("#abouts").html(data);
			$("#abouts").fadeTo(3000, 1);
		},
		error:function(){
			$("#abouts").text("失败");
		}	
	});
	
}


//name:当前页数,value:上一页,a;一下页,b;
function pic(url,name,value ) {
	var num;
	num = $("#curNum").html()
	if(value==null){
		
		if(url!="#"){
			$.ajax({
				type:"get",
				url:url,
				
				beforeSend: function(data,textStatus){
					$("#abouts").html("<div style='text-align:center '><div style='height:250px;'></div><img  src='templets/yangchao/images/ajax-loader.gif'/><div>");
				},
				
				success:function(data,textStauts) {
					$("#abouts").css("display","none");
					$("#abouts").html(data);
					$("#abouts").html(data);
					
					$("#abouts").fadeTo(3000, 1);
					scrollBar();
					setTimeout(function() {$("#curNum").html(name);},100)
				},
				
				error:function() {
					$("#abouts").text("失败");
				}	
			});
		}
	}else{
		if(value=="a"){
			num--;
		}else{
			num++;
		}
	}
	$.ajax({
		type:"get",
		url:url,
		
		beforeSend: function(data,textStatus){
			$("#abouts").html("<div style='text-align:center '><div style='height:250px;'></div><img  src='templets/yangchao/images/ajax-loader.gif'/><div>");
		},
		
		success:function(data,textStauts) {
			$("#abouts").css("display","none");
			$("#abouts").html(data);
			$("#abouts").html(data);
			$(".list").prepend(num);
			scrollBar();
			$("#abouts").fadeTo(3000, 1);
		},
		
		error:function() {
			$("#abouts").text("失败");
		}	
	});

}


// 异步同载   end

/**
*菜单鼠标点击
*obj:点击对象
*sel:
*/
function setClass(obj,sel0,sel1) {
	$("#menuLi li").each(function(i){		
		if (i!=parseInt(sel0)) {
			$(this).mouseover(function(){
				$(this).attr("class","selabout"+i);
			});
			$(this).mouseout(function(){
				$(this).attr("class","about"+i);
			});
			$(this).attr("class","about"+i);
		}
	});
	
	$(obj).unbind("mouseover");
	$(obj).unbind("mouseout");	
	$(obj).attr("class","selabout"+sel0);
	
	$(sel1).unbind("mouseover");
	$(sel1).unbind("mouseout");	
	$(sel1).attr("class","selabout2");
}
