$(function(){
  // 出场动画
  var anim = $(".anim");
  setTimeout(function(){//规避页面加载不完整高度获取异常
    $(window).scroll(function() {
        roll();
      })
      $(window).resize(function() {
        roll();
      })
      roll();
  },6)
  function roll() { //滚动执行动画
    var oHeight = $(window).height();
    var ScrVal = $(window).scrollTop();
    anim.each(function(i) {
      if (ScrVal + oHeight > anim.eq(i).offset().top + 100 ){
        anim.eq(i).addClass("anim-show");
      }
    })
  }
     



})