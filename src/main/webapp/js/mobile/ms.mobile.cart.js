//购物车控件
Ms.cart = {
	"button" : function() {
		$.ajax({
			type : "GET",
			url : "/js/mobile/cart/goods-cart-button.html",
			success : (function(button) {
				$(".ms-container").append(button);
				// 显示加入购物窗口，１、显示遮罩 ２、显示表单
				$(".ms-shop-fixed-button").on(
						"tap",".ms-shop-cart-panel-show",
						function() {
							// 获取商品名称
							$(".ms-clear .title").text(
									$(".ms-goods-title").text());
							// 获取商品价格
							$(".ms-clear .price").text(
									$(".ms-goods-price").text());
							// 获取商品图片
							$(".ms-clear img").attr("src",
									$(".ms-goods-img img").attr("src"));

							// 还原按钮颜色
							$(".addToCart").removeAttr("disabled");

							$(".ms-mask").show();
							$(".addToCart").text("加入购物车");
							$(".addToCart").unbind("tap");
							$(".addToCart").tap(
									function() {
										$(this).unbind("tap");
										$(this).html("正在加入购物车");
										$(this).attr("disabled", true);
										// 获取用户选择的商品数量
										var cartNum = $(".ms-shop-cart-number .number").val();
										Ms.cart.save($(".ms-goods-title").attr("data-id"), cartNum,$(".ms-goods-price").text(),$(".ms-goods-discount").text());
									});
							Ms.cart.show();// 显示面板
							
							//自定义型号
							$(".ms-shop-cart-diy-category ul").on("tap","li",function(){
								$(this).toggleClass("active");
							});
						});

						//立即购买，主要将按钮的文章和事件进行更改
						$(".ms-shop-fixed-button").on(
								"tap",
								".ms-shop-buy", function() {
								//获取商品名称
								$(".ms-clear .title").text($(".ms-goods-title").text());
								//获取商品价格
								$(".ms-clear .price").text($(".ms-goods-price").text());
								//获取商品图片
								$(".ms-clear img").attr("src",$(".ms-goods-img img").attr("src"));
									
								//还原按钮颜色
								$(".addToCart").removeAttr("disabled");		
								$(".ms-mask").show();
								$(".addToCart").text("下一步");
								$(".addToCart").unbind("tap");
								$(".addToCart").tap(function() {
									$(this).html("提交中...");
									$(this).attr("disabled",true);
									 Ms.cart.pay();
								});
								
								Ms.cart.show();// 显示面板
		
						});							
				
			}),
		});
	},
	"pay":function(){ //立即购买按钮
	  	//获取用户收货地址
		$.ajax({
			type:"POST",
			url:"/people/user/getEntity.do",
			success:function(msg){
				if($.parseJSON(msg).result == true){
					var peopleInfo = $.parseJSON($.parseJSON(msg).resultData);
					//判断用户手机号
					if(peopleInfo.peoplePhone != null && peopleInfo.peoplePhone != "" ){
						//将商品提交到购物车							
						$.ajax({
							type : "POST",
							url : "/people/cart/" + $(".ms-goods-title").attr("data-id") + "/save.do", //basicId(商品ID)需要处理
							data : "cartNum=" + $(".ms-shop-cart-number .number").val()+"&cartPrice="+$(".ms-goods-price").text()+"&cartDiscount="+$(".ms-goods-discount").text(), //商品数量
							success : (function(msg) {
								if($.parseJSON(msg).result == true){
									var cartId = $.parseJSON(msg).resultMsg;
									
									//执行提交订单
									$.ajax({
										type:"POST",
										url:"/people/order/save.do",
										data:"orderPayment=3&orderCategoryId=2908&orderPhone="+peopleInfo.peoplePhone+"&cartIds="+cartId,//(orderCategoryId需要处理)
										success:function(msg){
											if($.parseJSON(msg).result == true){//(需要处理)
												var orderNo = $.parseJSON($.parseJSON(msg).resultMsg).orderNo;
												//当peopleUserPeopeId为0时表示不存在用户详细信息,此时执行添加
												if(peopleInfo.peopleUserPeopleId == 0){
													//跳转到修改用户地址页面携带订单号orderNo//(需要处理)
													Ms.loadUrl("/people/address.do?no={no/}");
												}else{
													//跳转到付款页面携带订单号orderNo//(需要处理)
													Ms.loadUrl("/people/orderPay.do?no="+orderNo);
												}														
											}else{
												Ms.msg("系统繁忙，请稍后重试！");
											}
										},
									});										
									
								}else{
									//立即购买失败,原因加入购物车失败(需要处理) 
									Ms.msg("系统繁忙，请稍后重试！");
								};
							}),
						});
						
					}else{
						//没有手机号暂时不能提交订单跳转到修改用户地址页面//(需要处理)
							Ms.loadUrl("/people/address.do?no=");
					}
				}else{
					//跳转到登录页面//(需要处理)
						Ms.loadUrl("/people.do");
				}
			},
		});		
	},
	"save" : function(basicId, cartNum,price,discount) { // basicId:编号 cartNum数量 price价格  discount折扣
		$.ajax({
			type : "POST",
			url : "/people/cart/" + basicId + "/save.do",
			data : "cartNum=" + cartNum+"&cartPrice="+price+"&cartDiscount="+discount,
			success : (function(msg) {
				if ($.parseJSON(msg).result == true) {
					Ms.cart.hide();
					Ms.msg("已成功添加到购物车");
				} else {
					Ms.msg("系统繁忙添加失败");
				}
			}),
			error : (function(xhr, errorType, error) {
				Ms.loadUrl("/people.do");
			})
		});
	},
	"show" : function() {
		$("body").append('<div class="ms-mask"  style="width:100%;height:100%;background-color: rgba(0, 0, 0, 0.901961)">');
		$(".ms-mask").animate({
			opacity : 1
		}, 200, 'ease', function() {
			var y = $(window).height() - $(".ms-shop-cart-panel").height();
			console.log("高度差:" + y);
			$(".ms-shop-cart-panel").height();
			$(".ms-shop-cart-panel").animate({
				bottom : '0px'
			}, 300, 'ease', function() {
				
			});
		});
	},
	"hide" : function() {
		$(".ms-shop-cart-panel").animate({
			bottom : '-' + $(".ms-shop-cart-panel").height() + 'px'
		}, 600, 'ease', function() {
			$(".ms-mask").animate({
				opacity : 0
			}, 300, 'ease', function() {
				$(this).hide();
			});
		});
	}

};

$(function() {
	$(".ms-shop-cart-panel").css("bottom",-$(".ms-shop-cart-panel").height());
	//自定义型号
	$(".ms-shop-cart-diy-category ul").on("tap","li",function(){
		$(this).toggleClass("active");
	});


	//数量减少
	$("body").on("tap",".ms-shop-cart-minus",function() {
		var text = parseInt($(this).next().val());
		if (text>1){
			$(this).next().val(text-1);
		}
	});

	//数量增加
	$("body").on("tap",".ms-shop-cart-plus",function() {
		var text = parseInt($(this).prev().val());
		if (text<90){
			$(this).prev().val(text+1);
		}		
	});
	
	//关闭购物车　１、向下滑动，影藏遮罩
	$(".ms-shop-cart-panel").on("tap",".ms-shop-cart-panel-close",function() {
		Ms.cart.hide();
		$(".ms-mask").remove();//移除遮罩
	});		
	

	//用户收藏
	$(".ms-user-fav").tap(function() {
		var basicId = $(this).attr("data-id");
		$.ajax({
			type:"POST",
			url:"/people/attention/save.do",
			data:"basicAttentionType=1&basicAttentionBasicId="+basicId,
			success:function(msg){
				if($.parseJSON(msg).result == true){
					Ms.msg("收藏成功!");
				}else{
					Ms.msg("您已经收藏过该商品了!");
				}
			}
		});	
	});	
	
});