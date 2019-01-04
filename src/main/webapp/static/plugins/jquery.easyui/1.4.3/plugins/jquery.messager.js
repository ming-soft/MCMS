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
function _1(){
$(document).unbind(".messager").bind("keydown.messager",function(e){
if(e.keyCode==27){
$("body").children("div.messager-window").children("div.messager-body").each(function(){
$(this).window("close");
});
}else{
if(e.keyCode==9){
var _2=$("body").children("div.messager-window").children("div.messager-body");
if(!_2.length){
return;
}
var _3=_2.find(".messager-input,.messager-button .l-btn");
for(var i=0;i<_3.length;i++){
if($(_3[i]).is(":focus")){
$(_3[i>=_3.length-1?0:i+1]).focus();
return false;
}
}
}
}
});
};
function _4(){
$(document).unbind(".messager");
};
function _5(_6){
var _7=$.extend({},$.messager.defaults,{modal:false,shadow:false,draggable:false,resizable:false,closed:true,style:{left:"",top:"",right:0,zIndex:$.fn.window.defaults.zIndex++,bottom:-document.body.scrollTop-document.documentElement.scrollTop},title:"",width:250,height:100,showType:"slide",showSpeed:600,msg:"",timeout:4000},_6);
var _8=$("<div class=\"messager-body\"></div>").html(_7.msg).appendTo("body");
_8.window($.extend({},_7,{openAnimation:(_7.showType),closeAnimation:(_7.showType=="show"?"hide":_7.showType),openDuration:_7.showSpeed,closeDuration:_7.showSpeed,onOpen:function(){
_8.window("window").hover(function(){
if(_7.timer){
clearTimeout(_7.timer);
}
},function(){
_9();
});
_9();
function _9(){
if(_7.timeout>0){
_7.timer=setTimeout(function(){
if(_8.length&&_8.data("window")){
_8.window("close");
}
},_7.timeout);
}
};
if(_6.onOpen){
_6.onOpen.call(this);
}else{
_7.onOpen.call(this);
}
},onClose:function(){
if(_7.timer){
clearTimeout(_7.timer);
}
if(_6.onClose){
_6.onClose.call(this);
}else{
_7.onClose.call(this);
}
_8.window("destroy");
}}));
_8.window("window").css(_7.style);
_8.window("open");
return _8;
};
function _a(_b){
_1();
var _c=$("<div class=\"messager-body\"></div>").appendTo("body");
_c.window($.extend({},_b,{doSize:false,noheader:(_b.title?false:true),onClose:function(){
_4();
if(_b.onClose){
_b.onClose.call(this);
}
setTimeout(function(){
_c.window("destroy");
},100);
}}));
if(_b.buttons&&_b.buttons.length){
var tb=$("<div class=\"messager-button\"></div>").appendTo(_c);
$.map(_b.buttons,function(_d){
$("<a href=\"javascript:void(0)\" style=\"margin-left:10px\"></a>").appendTo(tb).linkbutton(_d);
});
}
_c.window("window").addClass("messager-window");
_c.window("resize");
_c.children("div.messager-button").children("a:first").focus();
return _c;
};
$.messager={show:function(_e){
return _5(_e);
},alert:function(_f,msg,_10,fn){
var _11=typeof _f=="object"?_f:{title:_f,msg:msg,icon:_10,fn:fn};
var cls=_11.icon?"messager-icon messager-"+_11.icon:"";
_11=$.extend({},$.messager.defaults,{content:"<div class=\""+cls+"\"></div>"+"<div>"+_11.msg+"</div>"+"<div style=\"clear:both;\"/>",buttons:[{text:$.messager.defaults.ok,onClick:function(){
win.window("close");
_11.fn();
}}]},_11);
var win=_a(_11);
return win;
},confirm:function(_12,msg,fn){
var _13=typeof _12=="object"?_12:{title:_12,msg:msg,fn:fn};
_13=$.extend({},$.messager.defaults,{content:"<div class=\"messager-icon messager-question\"></div>"+"<div>"+_13.msg+"</div>"+"<div style=\"clear:both;\"/>",buttons:[{text:$.messager.defaults.ok,onClick:function(){
win.window("close");
_13.fn(true);
}},{text:$.messager.defaults.cancel,onClick:function(){
win.window("close");
_13.fn(false);
}}]},_13);
var win=_a(_13);
return win;
},prompt:function(_14,msg,fn){
var _15=typeof _14=="object"?_14:{title:_14,msg:msg,fn:fn};
_15=$.extend({},$.messager.defaults,{content:"<div class=\"messager-icon messager-question\"></div>"+"<div>"+_15.msg+"</div>"+"<br/>"+"<div style=\"clear:both;\"/>"+"<div><input class=\"messager-input\" type=\"text\"/></div>",buttons:[{text:$.messager.defaults.ok,onClick:function(){
win.window("close");
_15.fn(win.find(".messager-input").val());
}},{text:$.messager.defaults.cancel,onClick:function(){
win.window("close");
_15.fn();
}}]},_15);
var win=_a(_15);
win.find("input.messager-input").focus();
return win;
},progress:function(_16){
var _17={bar:function(){
return $("body>div.messager-window").find("div.messager-p-bar");
},close:function(){
var win=$("body>div.messager-window>div.messager-body:has(div.messager-progress)");
if(win.length){
win.window("close");
}
}};
if(typeof _16=="string"){
var _18=_17[_16];
return _18();
}
var _19=$.extend({},{title:"",content:undefined,msg:"",text:undefined,interval:300},_16||{});
var win=_a($.extend({},$.messager.defaults,{content:"<div class=\"messager-progress\"><div class=\"messager-p-msg\">"+_19.msg+"</div><div class=\"messager-p-bar\"></div></div>",closable:false,doSize:false},_19,{onClose:function(){
if(this.timer){
clearInterval(this.timer);
}
if(_16.onClose){
_16.onClose.call(this);
}else{
$.messager.defaults.onClose.call(this);
}
}}));
var bar=win.find("div.messager-p-bar");
bar.progressbar({text:_19.text});
win.window("resize");
if(_19.interval){
win[0].timer=setInterval(function(){
var v=bar.progressbar("getValue");
v+=10;
if(v>100){
v=0;
}
bar.progressbar("setValue",v);
},_19.interval);
}
return win;
}};
$.messager.defaults=$.extend({},$.fn.window.defaults,{ok:"Ok",cancel:"Cancel",width:300,height:"auto",modal:true,collapsible:false,minimizable:false,maximizable:false,resizable:false,fn:function(){
}});
})(jQuery);

