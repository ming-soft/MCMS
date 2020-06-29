;(function($){
$.fn.DB_gallery=function(options){
	var opt={
		thumWidth:138,              //芥匙老啊肺
		thumGap:8,                  //芥匙老埃拜
		thumMoveStep:4,             //芥匙老捞悼肮荐
		moveSpeed:300,              //捞悼加档
		fadeSpeed:300,              //拳搁傈券加档
		end:''
	}
	$.extend(opt,options);
	return this.each(function(){
		var $this=$(this);
		var $imgSet=$this.find('.DB_imgSet');
		var $imgWin=$imgSet.find('.DB_imgWin');
		var $page=$this.find('.DB_page');
		var $pageCurrent=$page.find('.DB_current');
		var $pageTotal=$page.find('.DB_total');
		var $thumSet=$this.find('.DB_thumSet');
		var $thumMove=$thumSet.find('.DB_thumMove');
		var $thumList=$thumMove.find('li');
		var $thumLine=$this.find('.DB_thumLine');
		var $nextBtn=$this.find('.DB_nextBtn');
		var $prevBtn=$this.find('.DB_prevBtn');
		var $nextPageBtn=$this.find('.DB_nextPageBtn');
		var $prevPageBtn=$this.find('.DB_prevPageBtn');
		var objNum=$thumList.length;
		var currentObj=0;
		var fixObj=0;
		var currentPage=0;
		var totalPage=Math.floor(objNum/opt.thumMoveStep);
		var oldImg;
		init();
	 
		function init(){
			setInit();
			setMouseEvent();
			changeImg();
		}

		function setInit(){
			//芥匙老 扼牢 困摹函版
			$thumMove.append($thumLine.get())
		}

		//官牢爹
		function setMouseEvent(){
			$thumList.bind('click',function(e){
				e.preventDefault();
				currentObj=$(this).index();
				changeImg();
			});
			$nextBtn.bind('click',function(){
				currentObj++;
				changeImg();
				currentPage=Math.floor(currentObj/opt.thumMoveStep);
				moveThum();

			});
			$prevBtn.bind('click',function(){
				currentObj--;
				changeImg();
				currentPage=Math.floor(currentObj/opt.thumMoveStep);
				moveThum();
			});
			$nextPageBtn.bind('click',function(){
				currentPage++;
				moveThum();
			});
			$prevPageBtn.bind('click',function(){
				currentPage--;
				moveThum();
			});
		
		}
		
		//芥匙老 捞悼
		function moveThum(){
			var pos=((opt.thumWidth+opt.thumGap)*opt.thumMoveStep)*currentPage
			$thumMove.animate({'left':-pos},opt.moveSpeed);
			//
			setVisibleBtn();
		}

		//捞固瘤函版俊 蝶弗 滚瓢贸府
		function setVisibleBtn(){
			$prevPageBtn.show();
			$nextPageBtn.show();
			$prevBtn.show();
			$nextBtn.show();
			if(currentPage==0)$prevPageBtn.hide();
			if(currentPage==totalPage-1)$nextPageBtn.hide();
			if(currentObj==0)$prevBtn.hide();
			if(currentObj==objNum-1)$nextBtn.hide();
		}

		//捞固瘤函版
		function changeImg(){
			if(oldImg!=null){
				//何靛矾款 傈券阑 困秦 硅版俊 扁粮捞固瘤甫 硅摹
				$imgWin.css('background','url('+oldImg+') no-repeat');
			}
			//努腐捞固瘤
			var $thum=$thumList.eq(currentObj)
			var _src=oldImg=$thum.find('a').attr('href');
			var _id=oldId=$thum.find('a').attr('id');
			//var _id=oldId=$thum.find('a').attr('id');//取得链接
			//var _datid=oldId=$thum.find('a').attr('datid');//取得ajax的id
			//var _title=oldTitle=$thum.find('a').attr('title');//取得标题
			//var _content=oldContent=$thum.find('a').attr('content');//取得简介
			$imgWin.find('img').hide().attr('src',_src).fadeIn(opt.fadeSpeed);
			$imgWin.find('a').hide().attr('href',_id).fadeIn(opt.fadeSpeed);//写进链接
			//$imgSet.find('.cpsc').hide().attr('data-id',_datid).fadeIn(opt.fadeSpeed);//写进链接
			//document.getElementById('aa').innerHTML=_title;//写进标题
			//document.getElementById('bb').innerHTML=_content;//写进简介
			oldImg=_src

			//芥匙老扼牢 困摹函版
			$thumLine.css({'left':$thum.position().left})

			//其捞瘤函版
			$pageCurrent.text(currentObj+1);
			$pageTotal.text(objNum);
			//alert(2);return;
			setVisibleBtn();
		}
	})
}
})(jQuery)