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
function _1(_2){
var _3=$.data(_2,"dialog").options;
_3.inited=false;
$(_2).window($.extend({},_3,{onResize:function(w,h){
if(_3.inited){
_b(this);
_3.onResize.call(this,w,h);
}
}}));
var _4=$(_2).window("window");
if(_3.toolbar){
if($.isArray(_3.toolbar)){
$(_2).siblings("div.dialog-toolbar").remove();
var _5=$("<div class=\"dialog-toolbar\"><table cellspacing=\"0\" cellpadding=\"0\"><tr></tr></table></div>").appendTo(_4);
var tr=_5.find("tr");
for(var i=0;i<_3.toolbar.length;i++){
var _6=_3.toolbar[i];
if(_6=="-"){
$("<td><div class=\"dialog-tool-separator\"></div></td>").appendTo(tr);
}else{
var td=$("<td></td>").appendTo(tr);
var _7=$("<a href=\"javascript:void(0)\"></a>").appendTo(td);
_7[0].onclick=eval(_6.handler||function(){
});
_7.linkbutton($.extend({},_6,{plain:true}));
}
}
}else{
$(_3.toolbar).addClass("dialog-toolbar").appendTo(_4);
$(_3.toolbar).show();
}
}else{
$(_2).siblings("div.dialog-toolbar").remove();
}
if(_3.buttons){
if($.isArray(_3.buttons)){
$(_2).siblings("div.dialog-button").remove();
var _8=$("<div class=\"dialog-button\"></div>").appendTo(_4);
for(var i=0;i<_3.buttons.length;i++){
var p=_3.buttons[i];
var _9=$("<a href=\"javascript:void(0)\"></a>").appendTo(_8);
if(p.handler){
_9[0].onclick=p.handler;
}
_9.linkbutton(p);
}
}else{
$(_3.buttons).addClass("dialog-button").appendTo(_4);
$(_3.buttons).show();
}
}else{
$(_2).siblings("div.dialog-button").remove();
}
_3.inited=true;
var _a=_3.closed;
_4.show();
$(_2).window("resize");
if(_a){
_4.hide();
}
};
function _b(_c,_d){
var t=$(_c);
var _e=t.dialog("options");
var _f=_e.noheader;
var tb=t.siblings(".dialog-toolbar");
var bb=t.siblings(".dialog-button");
tb.insertBefore(_c).css({position:"relative",borderTopWidth:(_f?1:0),top:(_f?tb.length:0)});
bb.insertAfter(_c).css({position:"relative",top:-1});
tb.add(bb)._outerWidth(t._outerWidth()).find(".easyui-fluid:visible").each(function(){
$(this).triggerHandler("_resize");
});
if(!isNaN(parseInt(_e.height))){
t._outerHeight(t._outerHeight()-tb._outerHeight()-bb._outerHeight());
}
var _10=$.data(_c,"window").shadow;
if(_10){
var cc=t.panel("panel");
_10.css({width:cc._outerWidth(),height:cc._outerHeight()});
}
};
$.fn.dialog=function(_11,_12){
if(typeof _11=="string"){
var _13=$.fn.dialog.methods[_11];
if(_13){
return _13(this,_12);
}else{
return this.window(_11,_12);
}
}
_11=_11||{};
return this.each(function(){
var _14=$.data(this,"dialog");
if(_14){
$.extend(_14.options,_11);
}else{
$.data(this,"dialog",{options:$.extend({},$.fn.dialog.defaults,$.fn.dialog.parseOptions(this),_11)});
}
_1(this);
});
};
$.fn.dialog.methods={options:function(jq){
var _15=$.data(jq[0],"dialog").options;
var _16=jq.panel("options");
$.extend(_15,{width:_16.width,height:_16.height,left:_16.left,top:_16.top,closed:_16.closed,collapsed:_16.collapsed,minimized:_16.minimized,maximized:_16.maximized});
return _15;
},dialog:function(jq){
return jq.window("window");
}};
$.fn.dialog.parseOptions=function(_17){
var t=$(_17);
return $.extend({},$.fn.window.parseOptions(_17),$.parser.parseOptions(_17,["toolbar","buttons"]),{toolbar:(t.children(".dialog-toolbar").length?t.children(".dialog-toolbar").removeClass("dialog-toolbar"):undefined),buttons:(t.children(".dialog-button").length?t.children(".dialog-button").removeClass("dialog-button"):undefined)});
};
$.fn.dialog.defaults=$.extend({},$.fn.window.defaults,{title:"New Dialog",collapsible:false,minimizable:false,maximizable:false,resizable:false,toolbar:null,buttons:null});
})(jQuery);

