/**
 * jQuery EasyUI 1.4.3
 * 
 * Copyright (c) 2009-2015 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the GPL license: http://www.gnu.org/licenses/gpl.txt
 * To use it on other terms please contact us at info@jeasyui.com
 *
 */
(function($){
function _1(_2,_3){
var _4=$.data(_2,"window");
if(_3){
if(_3.left!=null){
_4.options.left=_3.left;
}
if(_3.top!=null){
_4.options.top=_3.top;
}
}
$(_2).panel("move",_4.options);
if(_4.shadow){
_4.shadow.css({left:_4.options.left,top:_4.options.top});
}
};
function _5(_6,_7){
var _8=$.data(_6,"window").options;
var pp=$(_6).window("panel");
var _9=pp._outerWidth();
if(_8.inline){
var _a=pp.parent();
_8.left=Math.ceil((_a.width()-_9)/2+_a.scrollLeft());
}else{
_8.left=Math.ceil(($(window)._outerWidth()-_9)/2+$(document).scrollLeft());
}
if(_7){
_1(_6);
}
};
function _b(_c,_d){
var _e=$.data(_c,"window").options;
var pp=$(_c).window("panel");
var _f=pp._outerHeight();
if(_e.inline){
var _10=pp.parent();
_e.top=Math.ceil((_10.height()-_f)/2+_10.scrollTop());
}else{
_e.top=Math.ceil(($(window)._outerHeight()-_f)/2+$(document).scrollTop());
}
if(_d){
_1(_c);
}
};
function _11(_12){
var _13=$.data(_12,"window");
var _14=_13.options;
var win=$(_12).panel($.extend({},_13.options,{border:false,doSize:true,closed:true,cls:"window",headerCls:"window-header",bodyCls:"window-body "+(_14.noheader?"window-body-noheader":""),onBeforeDestroy:function(){
if(_14.onBeforeDestroy.call(_12)==false){
return false;
}
if(_13.shadow){
_13.shadow.remove();
}
if(_13.mask){
_13.mask.remove();
}
},onClose:function(){
if(_13.shadow){
_13.shadow.hide();
}
if(_13.mask){
_13.mask.hide();
}
_14.onClose.call(_12);
},onOpen:function(){
if(_13.mask){
_13.mask.css($.extend({display:"block",zIndex:$.fn.window.defaults.zIndex++},$.fn.window.getMaskSize(_12)));
}
if(_13.shadow){
_13.shadow.css({display:"block",zIndex:$.fn.window.defaults.zIndex++,left:_14.left,top:_14.top,width:_13.window._outerWidth(),height:_13.window._outerHeight()});
}
_13.window.css("z-index",$.fn.window.defaults.zIndex++);
_14.onOpen.call(_12);
},onResize:function(_15,_16){
var _17=$(this).panel("options");
$.extend(_14,{width:_17.width,height:_17.height,left:_17.left,top:_17.top});
if(_13.shadow){
_13.shadow.css({left:_14.left,top:_14.top,width:_13.window._outerWidth(),height:_13.window._outerHeight()});
}
_14.onResize.call(_12,_15,_16);
},onMinimize:function(){
if(_13.shadow){
_13.shadow.hide();
}
if(_13.mask){
_13.mask.hide();
}
_13.options.onMinimize.call(_12);
},onBeforeCollapse:function(){
if(_14.onBeforeCollapse.call(_12)==false){
return false;
}
if(_13.shadow){
_13.shadow.hide();
}
},onExpand:function(){
if(_13.shadow){
_13.shadow.show();
}
_14.onExpand.call(_12);
}}));
_13.window=win.panel("panel");
if(_13.mask){
_13.mask.remove();
}
if(_14.modal==true){
_13.mask=$("<div class=\"window-mask\" style=\"display:none\"></div>").insertAfter(_13.window);
}
if(_13.shadow){
_13.shadow.remove();
}
if(_14.shadow==true){
_13.shadow=$("<div class=\"window-shadow\" style=\"display:none\"></div>").insertAfter(_13.window);
}
if(_14.left==null){
_5(_12);
}
if(_14.top==null){
_b(_12);
}
_1(_12);
if(!_14.closed){
win.window("open");
}
};
function _18(_19){
var _1a=$.data(_19,"window");
_1a.window.draggable({handle:">div.panel-header>div.panel-title",disabled:_1a.options.draggable==false,onStartDrag:function(e){
if(_1a.mask){
_1a.mask.css("z-index",$.fn.window.defaults.zIndex++);
}
if(_1a.shadow){
_1a.shadow.css("z-index",$.fn.window.defaults.zIndex++);
}
_1a.window.css("z-index",$.fn.window.defaults.zIndex++);
if(!_1a.proxy){
_1a.proxy=$("<div class=\"window-proxy\"></div>").insertAfter(_1a.window);
}
_1a.proxy.css({display:"none",zIndex:$.fn.window.defaults.zIndex++,left:e.data.left,top:e.data.top});
_1a.proxy._outerWidth(_1a.window._outerWidth());
_1a.proxy._outerHeight(_1a.window._outerHeight());
setTimeout(function(){
if(_1a.proxy){
_1a.proxy.show();
}
},500);
},onDrag:function(e){
_1a.proxy.css({display:"block",left:e.data.left,top:e.data.top});
return false;
},onStopDrag:function(e){
_1a.options.left=e.data.left;
_1a.options.top=e.data.top;
$(_19).window("move");
_1a.proxy.remove();
_1a.proxy=null;
}});
_1a.window.resizable({disabled:_1a.options.resizable==false,onStartResize:function(e){
if(_1a.pmask){
_1a.pmask.remove();
}
_1a.pmask=$("<div class=\"window-proxy-mask\"></div>").insertAfter(_1a.window);
_1a.pmask.css({zIndex:$.fn.window.defaults.zIndex++,left:e.data.left,top:e.data.top,width:_1a.window._outerWidth(),height:_1a.window._outerHeight()});
if(_1a.proxy){
_1a.proxy.remove();
}
_1a.proxy=$("<div class=\"window-proxy\"></div>").insertAfter(_1a.window);
_1a.proxy.css({zIndex:$.fn.window.defaults.zIndex++,left:e.data.left,top:e.data.top});
_1a.proxy._outerWidth(e.data.width)._outerHeight(e.data.height);
},onResize:function(e){
_1a.proxy.css({left:e.data.left,top:e.data.top});
_1a.proxy._outerWidth(e.data.width);
_1a.proxy._outerHeight(e.data.height);
return false;
},onStopResize:function(e){
$(_19).window("resize",e.data);
_1a.pmask.remove();
_1a.pmask=null;
_1a.proxy.remove();
_1a.proxy=null;
}});
};
$(window).resize(function(){
$("body>div.window-mask").css({width:$(window)._outerWidth(),height:$(window)._outerHeight()});
setTimeout(function(){
$("body>div.window-mask").css($.fn.window.getMaskSize());
},50);
});
$.fn.window=function(_1b,_1c){
if(typeof _1b=="string"){
var _1d=$.fn.window.methods[_1b];
if(_1d){
return _1d(this,_1c);
}else{
return this.panel(_1b,_1c);
}
}
_1b=_1b||{};
return this.each(function(){
var _1e=$.data(this,"window");
if(_1e){
$.extend(_1e.options,_1b);
}else{
_1e=$.data(this,"window",{options:$.extend({},$.fn.window.defaults,$.fn.window.parseOptions(this),_1b)});
if(!_1e.options.inline){
document.body.appendChild(this);
}
}
_11(this);
_18(this);
});
};
$.fn.window.methods={options:function(jq){
var _1f=jq.panel("options");
var _20=$.data(jq[0],"window").options;
return $.extend(_20,{closed:_1f.closed,collapsed:_1f.collapsed,minimized:_1f.minimized,maximized:_1f.maximized});
},window:function(jq){
return $.data(jq[0],"window").window;
},move:function(jq,_21){
return jq.each(function(){
_1(this,_21);
});
},hcenter:function(jq){
return jq.each(function(){
_5(this,true);
});
},vcenter:function(jq){
return jq.each(function(){
_b(this,true);
});
},center:function(jq){
return jq.each(function(){
_5(this);
_b(this);
_1(this);
});
}};
$.fn.window.getMaskSize=function(_22){
var _23=$(_22).data("window");
var _24=(_23&&_23.options.inline);
return {width:(_24?"100%":$(document).width()),height:(_24?"100%":$(document).height())};
};
$.fn.window.parseOptions=function(_25){
return $.extend({},$.fn.panel.parseOptions(_25),$.parser.parseOptions(_25,[{draggable:"boolean",resizable:"boolean",shadow:"boolean",modal:"boolean",inline:"boolean"}]));
};
$.fn.window.defaults=$.extend({},$.fn.panel.defaults,{zIndex:9000,draggable:true,resizable:true,shadow:true,modal:false,inline:false,title:"New Window",collapsible:true,minimizable:true,maximizable:true,closable:true,closed:false});
})(jQuery);

