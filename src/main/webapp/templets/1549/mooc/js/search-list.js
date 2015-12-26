
	//搜索文章方法
	function searchArticle(){
		$.ajax({
			   type: "POST",
			   url: $("#searchForm").attr("action"),
			   data:$("#searchForm").serialize(),
			   success: function(msg){
				  //移除掉显示的数据代码
				  $("#courseList").remove();
				  //移除掉之前的分页代码
				  $(".pagination").remove();
				  $(".search-sub-tabs").remove();
				  //将搜索结果的html代码替换掉之前显示的数据代码
				  $(".wrap").append(msg);
				  //获取搜索的文章的总数
				  var articleCount = $(".search-sub-tabs").attr("data-count");
				  //如果文章总数少于5则隐藏分页标签
				  if(articleCount<5){
					  $(".pagination").hide();
				  }else{
					  $(".pagination").show();
				  }
			   }
		});
	}
	$(function(){
		$(".search-list li").click(function(){
			//获取当前点击对象的data-id值
			var values = $(this).find("a").attr("data-id");
			//获取当前点击对象在自定义模型中对应的字段名
			var field = $(this).find("a").attr("data-type");
			//去掉之前选中的样式
			$(this).parent().find("li").removeClass("active");
			//添加当前选中样式
			$(this).addClass("active");
			
			//给对应的搜索表单值赋值
			$("#searchForm input[name="+field+"]").val(values);
			//ajax提交数据获取搜索结果的html代码
			searchArticle();
		});
		
		//点击上一页下一页时
		$("body").delegate('.pagination li', 'click', function(){
			//获取当前页码值
			var curPageNo = parseInt($("#searchForm input[name=pageNo]").val());
			//如果点击的是首页
			if($(this).attr("data-type")=="index"){
				$("#searchForm input[name=pageNo]").val(1);
			}
			//如果点击的上一页
			if($(this).attr("data-type")=="pre"){
				if(curPageNo>1){
					$("#searchForm input[name=pageNo]").val(curPageNo-1);
				}
			}
			//点击下一页时,判断当前页面是否为1
			if($(this).attr("data-type")=="next"){
				//点击下一页时，当前页不能超过总页数
				if(curPageNo<$(".pagination").attr("data-page-count")){
					$("#searchForm input[name=pageNo]").val(curPageNo+1);
				}
				
			}
			//如果点击的是末页
			if($(this).attr("data-type")=="last"){
				$("#searchForm input[name=pageNo]").val($(".pagination").attr("data-page-count"));
			}
			searchArticle();
		});
	})
