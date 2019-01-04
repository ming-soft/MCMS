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
var _3=$.data(_2,"treegrid");
var _4=_3.options;
$(_2).datagrid($.extend({},_4,{url:null,data:null,loader:function(){
return false;
},onBeforeLoad:function(){
return false;
},onLoadSuccess:function(){
},onResizeColumn:function(_5,_6){
_16(_2);
_4.onResizeColumn.call(_2,_5,_6);
},onBeforeSortColumn:function(_7,_8){
if(_4.onBeforeSortColumn.call(_2,_7,_8)==false){
return false;
}
},onSortColumn:function(_9,_a){
_4.sortName=_9;
_4.sortOrder=_a;
if(_4.remoteSort){
_15(_2);
}else{
var _b=$(_2).treegrid("getData");
_2f(_2,0,_b);
}
_4.onSortColumn.call(_2,_9,_a);
},onClickCell:function(_c,_d){
_4.onClickCell.call(_2,_d,_37(_2,_c));
},onDblClickCell:function(_e,_f){
_4.onDblClickCell.call(_2,_f,_37(_2,_e));
},onRowContextMenu:function(e,_10){
_4.onContextMenu.call(_2,e,_37(_2,_10));
}}));
var _11=$.data(_2,"datagrid").options;
_4.columns=_11.columns;
_4.frozenColumns=_11.frozenColumns;
_3.dc=$.data(_2,"datagrid").dc;
if(_4.pagination){
var _12=$(_2).datagrid("getPager");
_12.pagination({pageNumber:_4.pageNumber,pageSize:_4.pageSize,pageList:_4.pageList,onSelectPage:function(_13,_14){
_4.pageNumber=_13;
_4.pageSize=_14;
_15(_2);
}});
_4.pageSize=_12.pagination("options").pageSize;
}
};
function _16(_17,_18){
var _19=$.data(_17,"datagrid").options;
var dc=$.data(_17,"datagrid").dc;
if(!dc.body1.is(":empty")&&(!_19.nowrap||_19.autoRowHeight)){
if(_18!=undefined){
var _1a=_1b(_17,_18);
for(var i=0;i<_1a.length;i++){
_1c(_1a[i][_19.idField]);
}
}
}
$(_17).datagrid("fixRowHeight",_18);
function _1c(_1d){
var tr1=_19.finder.getTr(_17,_1d,"body",1);
var tr2=_19.finder.getTr(_17,_1d,"body",2);
tr1.css("height","");
tr2.css("height","");
var _1e=Math.max(tr1.height(),tr2.height());
tr1.css("height",_1e);
tr2.css("height",_1e);
};
};
function _1f(_20){
var dc=$.data(_20,"datagrid").dc;
var _21=$.data(_20,"treegrid").options;
if(!_21.rownumbers){
return;
}
dc.body1.find("div.datagrid-cell-rownumber").each(function(i){
$(this).html(i+1);
});
};
function _22(_23){
return function(e){
$.fn.datagrid.defaults.rowEvents[_23?"mouseover":"mouseout"](e);
var tt=$(e.target);
var fn=_23?"addClass":"removeClass";
if(tt.hasClass("tree-hit")){
tt.hasClass("tree-expanded")?tt[fn]("tree-expanded-hover"):tt[fn]("tree-collapsed-hover");
}
};
};
function _24(e){
var tt=$(e.target);
if(tt.hasClass("tree-hit")){
var tr=tt.closest("tr.datagrid-row");
var _25=tr.closest("div.datagrid-view").children(".datagrid-f")[0];
_26(_25,tr.attr("node-id"));
}else{
$.fn.datagrid.defaults.rowEvents.click(e);
}
};
function _27(_28,_29){
var _2a=$.data(_28,"treegrid").options;
var tr1=_2a.finder.getTr(_28,_29,"body",1);
var tr2=_2a.finder.getTr(_28,_29,"body",2);
var _2b=$(_28).datagrid("getColumnFields",true).length+(_2a.rownumbers?1:0);
var _2c=$(_28).datagrid("getColumnFields",false).length;
_2d(tr1,_2b);
_2d(tr2,_2c);
function _2d(tr,_2e){
$("<tr class=\"treegrid-tr-tree\">"+"<td style=\"border:0px\" colspan=\""+_2e+"\">"+"<div></div>"+"</td>"+"</tr>").insertAfter(tr);
};
};
function _2f(_30,_31,_32,_33){
var _34=$.data(_30,"treegrid");
var _35=_34.options;
var dc=_34.dc;
_32=_35.loadFilter.call(_30,_32,_31);
var _36=_37(_30,_31);
if(_36){
var _38=_35.finder.getTr(_30,_31,"body",1);
var _39=_35.finder.getTr(_30,_31,"body",2);
var cc1=_38.next("tr.treegrid-tr-tree").children("td").children("div");
var cc2=_39.next("tr.treegrid-tr-tree").children("td").children("div");
if(!_33){
_36.children=[];
}
}else{
var cc1=dc.body1;
var cc2=dc.body2;
if(!_33){
_34.data=[];
}
}
if(!_33){
cc1.empty();
cc2.empty();
}
if(_35.view.onBeforeRender){
_35.view.onBeforeRender.call(_35.view,_30,_31,_32);
}
_35.view.render.call(_35.view,_30,cc1,true);
_35.view.render.call(_35.view,_30,cc2,false);
if(_35.showFooter){
_35.view.renderFooter.call(_35.view,_30,dc.footer1,true);
_35.view.renderFooter.call(_35.view,_30,dc.footer2,false);
}
if(_35.view.onAfterRender){
_35.view.onAfterRender.call(_35.view,_30);
}
if(!_31&&_35.pagination){
var _3a=$.data(_30,"treegrid").total;
var _3b=$(_30).datagrid("getPager");
if(_3b.pagination("options").total!=_3a){
_3b.pagination({total:_3a});
}
}
_16(_30);
_1f(_30);
$(_30).treegrid("showLines");
$(_30).treegrid("setSelectionState");
$(_30).treegrid("autoSizeColumn");
_35.onLoadSuccess.call(_30,_36,_32);
};
function _15(_3c,_3d,_3e,_3f,_40){
var _41=$.data(_3c,"treegrid").options;
var _42=$(_3c).datagrid("getPanel").find("div.datagrid-body");
if(_3e){
_41.queryParams=_3e;
}
var _43=$.extend({},_41.queryParams);
if(_41.pagination){
$.extend(_43,{page:_41.pageNumber,rows:_41.pageSize});
}
if(_41.sortName){
$.extend(_43,{sort:_41.sortName,order:_41.sortOrder});
}
var row=_37(_3c,_3d);
if(_41.onBeforeLoad.call(_3c,row,_43)==false){
return;
}
var _44=_42.find("tr[node-id=\""+_3d+"\"] span.tree-folder");
_44.addClass("tree-loading");
$(_3c).treegrid("loading");
var _45=_41.loader.call(_3c,_43,function(_46){
_44.removeClass("tree-loading");
$(_3c).treegrid("loaded");
_2f(_3c,_3d,_46,_3f);
if(_40){
_40();
}
},function(){
_44.removeClass("tree-loading");
$(_3c).treegrid("loaded");
_41.onLoadError.apply(_3c,arguments);
if(_40){
_40();
}
});
if(_45==false){
_44.removeClass("tree-loading");
$(_3c).treegrid("loaded");
}
};
function _47(_48){
var _49=_4a(_48);
if(_49.length){
return _49[0];
}else{
return null;
}
};
function _4a(_4b){
return $.data(_4b,"treegrid").data;
};
function _4c(_4d,_4e){
var row=_37(_4d,_4e);
if(row._parentId){
return _37(_4d,row._parentId);
}else{
return null;
}
};
function _1b(_4f,_50){
var _51=$.data(_4f,"treegrid").options;
var _52=$(_4f).datagrid("getPanel").find("div.datagrid-view2 div.datagrid-body");
var _53=[];
if(_50){
_54(_50);
}else{
var _55=_4a(_4f);
for(var i=0;i<_55.length;i++){
_53.push(_55[i]);
_54(_55[i][_51.idField]);
}
}
function _54(_56){
var _57=_37(_4f,_56);
if(_57&&_57.children){
for(var i=0,len=_57.children.length;i<len;i++){
var _58=_57.children[i];
_53.push(_58);
_54(_58[_51.idField]);
}
}
};
return _53;
};
function _59(_5a,_5b){
if(!_5b){
return 0;
}
var _5c=$.data(_5a,"treegrid").options;
var _5d=$(_5a).datagrid("getPanel").children("div.datagrid-view");
var _5e=_5d.find("div.datagrid-body tr[node-id=\""+_5b+"\"]").children("td[field=\""+_5c.treeField+"\"]");
return _5e.find("span.tree-indent,span.tree-hit").length;
};
function _37(_5f,_60){
var _61=$.data(_5f,"treegrid").options;
var _62=$.data(_5f,"treegrid").data;
var cc=[_62];
while(cc.length){
var c=cc.shift();
for(var i=0;i<c.length;i++){
var _63=c[i];
if(_63[_61.idField]==_60){
return _63;
}else{
if(_63["children"]){
cc.push(_63["children"]);
}
}
}
}
return null;
};
function _64(_65,_66){
var _67=$.data(_65,"treegrid").options;
var row=_37(_65,_66);
var tr=_67.finder.getTr(_65,_66);
var hit=tr.find("span.tree-hit");
if(hit.length==0){
return;
}
if(hit.hasClass("tree-collapsed")){
return;
}
if(_67.onBeforeCollapse.call(_65,row)==false){
return;
}
hit.removeClass("tree-expanded tree-expanded-hover").addClass("tree-collapsed");
hit.next().removeClass("tree-folder-open");
row.state="closed";
tr=tr.next("tr.treegrid-tr-tree");
var cc=tr.children("td").children("div");
if(_67.animate){
cc.slideUp("normal",function(){
$(_65).treegrid("autoSizeColumn");
_16(_65,_66);
_67.onCollapse.call(_65,row);
});
}else{
cc.hide();
$(_65).treegrid("autoSizeColumn");
_16(_65,_66);
_67.onCollapse.call(_65,row);
}
};
function _68(_69,_6a){
var _6b=$.data(_69,"treegrid").options;
var tr=_6b.finder.getTr(_69,_6a);
var hit=tr.find("span.tree-hit");
var row=_37(_69,_6a);
if(hit.length==0){
return;
}
if(hit.hasClass("tree-expanded")){
return;
}
if(_6b.onBeforeExpand.call(_69,row)==false){
return;
}
hit.removeClass("tree-collapsed tree-collapsed-hover").addClass("tree-expanded");
hit.next().addClass("tree-folder-open");
var _6c=tr.next("tr.treegrid-tr-tree");
if(_6c.length){
var cc=_6c.children("td").children("div");
_6d(cc);
}else{
_27(_69,row[_6b.idField]);
var _6c=tr.next("tr.treegrid-tr-tree");
var cc=_6c.children("td").children("div");
cc.hide();
var _6e=$.extend({},_6b.queryParams||{});
_6e.id=row[_6b.idField];
_15(_69,row[_6b.idField],_6e,true,function(){
if(cc.is(":empty")){
_6c.remove();
}else{
_6d(cc);
}
});
}
function _6d(cc){
row.state="open";
if(_6b.animate){
cc.slideDown("normal",function(){
$(_69).treegrid("autoSizeColumn");
_16(_69,_6a);
_6b.onExpand.call(_69,row);
});
}else{
cc.show();
$(_69).treegrid("autoSizeColumn");
_16(_69,_6a);
_6b.onExpand.call(_69,row);
}
};
};
function _26(_6f,_70){
var _71=$.data(_6f,"treegrid").options;
var tr=_71.finder.getTr(_6f,_70);
var hit=tr.find("span.tree-hit");
if(hit.hasClass("tree-expanded")){
_64(_6f,_70);
}else{
_68(_6f,_70);
}
};
function _72(_73,_74){
var _75=$.data(_73,"treegrid").options;
var _76=_1b(_73,_74);
if(_74){
_76.unshift(_37(_73,_74));
}
for(var i=0;i<_76.length;i++){
_64(_73,_76[i][_75.idField]);
}
};
function _77(_78,_79){
var _7a=$.data(_78,"treegrid").options;
var _7b=_1b(_78,_79);
if(_79){
_7b.unshift(_37(_78,_79));
}
for(var i=0;i<_7b.length;i++){
_68(_78,_7b[i][_7a.idField]);
}
};
function _7c(_7d,_7e){
var _7f=$.data(_7d,"treegrid").options;
var ids=[];
var p=_4c(_7d,_7e);
while(p){
var id=p[_7f.idField];
ids.unshift(id);
p=_4c(_7d,id);
}
for(var i=0;i<ids.length;i++){
_68(_7d,ids[i]);
}
};
function _80(_81,_82){
var _83=$.data(_81,"treegrid").options;
if(_82.parent){
var tr=_83.finder.getTr(_81,_82.parent);
if(tr.next("tr.treegrid-tr-tree").length==0){
_27(_81,_82.parent);
}
var _84=tr.children("td[field=\""+_83.treeField+"\"]").children("div.datagrid-cell");
var _85=_84.children("span.tree-icon");
if(_85.hasClass("tree-file")){
_85.removeClass("tree-file").addClass("tree-folder tree-folder-open");
var hit=$("<span class=\"tree-hit tree-expanded\"></span>").insertBefore(_85);
if(hit.prev().length){
hit.prev().remove();
}
}
}
_2f(_81,_82.parent,_82.data,true);
};
function _86(_87,_88){
var ref=_88.before||_88.after;
var _89=$.data(_87,"treegrid").options;
var _8a=_4c(_87,ref);
_80(_87,{parent:(_8a?_8a[_89.idField]:null),data:[_88.data]});
var _8b=_8a?_8a.children:$(_87).treegrid("getRoots");
for(var i=0;i<_8b.length;i++){
if(_8b[i][_89.idField]==ref){
var _8c=_8b[_8b.length-1];
_8b.splice(_88.before?i:(i+1),0,_8c);
_8b.splice(_8b.length-1,1);
break;
}
}
_8d(true);
_8d(false);
_1f(_87);
$(_87).treegrid("showLines");
function _8d(_8e){
var _8f=_8e?1:2;
var tr=_89.finder.getTr(_87,_88.data[_89.idField],"body",_8f);
var _90=tr.closest("table.datagrid-btable");
tr=tr.parent().children();
var _91=_89.finder.getTr(_87,ref,"body",_8f);
if(_88.before){
tr.insertBefore(_91);
}else{
var sub=_91.next("tr.treegrid-tr-tree");
tr.insertAfter(sub.length?sub:_91);
}
_90.remove();
};
};
function _92(_93,_94){
var _95=$.data(_93,"treegrid");
$(_93).datagrid("deleteRow",_94);
_1f(_93);
_95.total-=1;
$(_93).datagrid("getPager").pagination("refresh",{total:_95.total});
$(_93).treegrid("showLines");
};
function _96(_97){
var t=$(_97);
var _98=t.treegrid("options");
if(_98.lines){
t.treegrid("getPanel").addClass("tree-lines");
}else{
t.treegrid("getPanel").removeClass("tree-lines");
return;
}
t.treegrid("getPanel").find("span.tree-indent").removeClass("tree-line tree-join tree-joinbottom");
t.treegrid("getPanel").find("div.datagrid-cell").removeClass("tree-node-last tree-root-first tree-root-one");
var _99=t.treegrid("getRoots");
if(_99.length>1){
_9a(_99[0]).addClass("tree-root-first");
}else{
if(_99.length==1){
_9a(_99[0]).addClass("tree-root-one");
}
}
_9b(_99);
_9c(_99);
function _9b(_9d){
$.map(_9d,function(_9e){
if(_9e.children&&_9e.children.length){
_9b(_9e.children);
}else{
var _9f=_9a(_9e);
_9f.find(".tree-icon").prev().addClass("tree-join");
}
});
if(_9d.length){
var _a0=_9a(_9d[_9d.length-1]);
_a0.addClass("tree-node-last");
_a0.find(".tree-join").removeClass("tree-join").addClass("tree-joinbottom");
}
};
function _9c(_a1){
$.map(_a1,function(_a2){
if(_a2.children&&_a2.children.length){
_9c(_a2.children);
}
});
for(var i=0;i<_a1.length-1;i++){
var _a3=_a1[i];
var _a4=t.treegrid("getLevel",_a3[_98.idField]);
var tr=_98.finder.getTr(_97,_a3[_98.idField]);
var cc=tr.next().find("tr.datagrid-row td[field=\""+_98.treeField+"\"] div.datagrid-cell");
cc.find("span:eq("+(_a4-1)+")").addClass("tree-line");
}
};
function _9a(_a5){
var tr=_98.finder.getTr(_97,_a5[_98.idField]);
var _a6=tr.find("td[field=\""+_98.treeField+"\"] div.datagrid-cell");
return _a6;
};
};
$.fn.treegrid=function(_a7,_a8){
if(typeof _a7=="string"){
var _a9=$.fn.treegrid.methods[_a7];
if(_a9){
return _a9(this,_a8);
}else{
return this.datagrid(_a7,_a8);
}
}
_a7=_a7||{};
return this.each(function(){
var _aa=$.data(this,"treegrid");
if(_aa){
$.extend(_aa.options,_a7);
}else{
_aa=$.data(this,"treegrid",{options:$.extend({},$.fn.treegrid.defaults,$.fn.treegrid.parseOptions(this),_a7),data:[]});
}
_1(this);
if(_aa.options.data){
$(this).treegrid("loadData",_aa.options.data);
}
_15(this);
});
};
$.fn.treegrid.methods={options:function(jq){
return $.data(jq[0],"treegrid").options;
},resize:function(jq,_ab){
return jq.each(function(){
$(this).datagrid("resize",_ab);
});
},fixRowHeight:function(jq,_ac){
return jq.each(function(){
_16(this,_ac);
});
},loadData:function(jq,_ad){
return jq.each(function(){
_2f(this,_ad.parent,_ad);
});
},load:function(jq,_ae){
return jq.each(function(){
$(this).treegrid("options").pageNumber=1;
$(this).treegrid("getPager").pagination({pageNumber:1});
$(this).treegrid("reload",_ae);
});
},reload:function(jq,id){
return jq.each(function(){
var _af=$(this).treegrid("options");
var _b0={};
if(typeof id=="object"){
_b0=id;
}else{
_b0=$.extend({},_af.queryParams);
_b0.id=id;
}
if(_b0.id){
var _b1=$(this).treegrid("find",_b0.id);
if(_b1.children){
_b1.children.splice(0,_b1.children.length);
}
_af.queryParams=_b0;
var tr=_af.finder.getTr(this,_b0.id);
tr.next("tr.treegrid-tr-tree").remove();
tr.find("span.tree-hit").removeClass("tree-expanded tree-expanded-hover").addClass("tree-collapsed");
_68(this,_b0.id);
}else{
_15(this,null,_b0);
}
});
},reloadFooter:function(jq,_b2){
return jq.each(function(){
var _b3=$.data(this,"treegrid").options;
var dc=$.data(this,"datagrid").dc;
if(_b2){
$.data(this,"treegrid").footer=_b2;
}
if(_b3.showFooter){
_b3.view.renderFooter.call(_b3.view,this,dc.footer1,true);
_b3.view.renderFooter.call(_b3.view,this,dc.footer2,false);
if(_b3.view.onAfterRender){
_b3.view.onAfterRender.call(_b3.view,this);
}
$(this).treegrid("fixRowHeight");
}
});
},getData:function(jq){
return $.data(jq[0],"treegrid").data;
},getFooterRows:function(jq){
return $.data(jq[0],"treegrid").footer;
},getRoot:function(jq){
return _47(jq[0]);
},getRoots:function(jq){
return _4a(jq[0]);
},getParent:function(jq,id){
return _4c(jq[0],id);
},getChildren:function(jq,id){
return _1b(jq[0],id);
},getLevel:function(jq,id){
return _59(jq[0],id);
},find:function(jq,id){
return _37(jq[0],id);
},isLeaf:function(jq,id){
var _b4=$.data(jq[0],"treegrid").options;
var tr=_b4.finder.getTr(jq[0],id);
var hit=tr.find("span.tree-hit");
return hit.length==0;
},select:function(jq,id){
return jq.each(function(){
$(this).datagrid("selectRow",id);
});
},unselect:function(jq,id){
return jq.each(function(){
$(this).datagrid("unselectRow",id);
});
},collapse:function(jq,id){
return jq.each(function(){
_64(this,id);
});
},expand:function(jq,id){
return jq.each(function(){
_68(this,id);
});
},toggle:function(jq,id){
return jq.each(function(){
_26(this,id);
});
},collapseAll:function(jq,id){
return jq.each(function(){
_72(this,id);
});
},expandAll:function(jq,id){
return jq.each(function(){
_77(this,id);
});
},expandTo:function(jq,id){
return jq.each(function(){
_7c(this,id);
});
},append:function(jq,_b5){
return jq.each(function(){
_80(this,_b5);
});
},insert:function(jq,_b6){
return jq.each(function(){
_86(this,_b6);
});
},remove:function(jq,id){
return jq.each(function(){
_92(this,id);
});
},pop:function(jq,id){
var row=jq.treegrid("find",id);
jq.treegrid("remove",id);
return row;
},refresh:function(jq,id){
return jq.each(function(){
var _b7=$.data(this,"treegrid").options;
_b7.view.refreshRow.call(_b7.view,this,id);
});
},update:function(jq,_b8){
return jq.each(function(){
var _b9=$.data(this,"treegrid").options;
_b9.view.updateRow.call(_b9.view,this,_b8.id,_b8.row);
});
},beginEdit:function(jq,id){
return jq.each(function(){
$(this).datagrid("beginEdit",id);
$(this).treegrid("fixRowHeight",id);
});
},endEdit:function(jq,id){
return jq.each(function(){
$(this).datagrid("endEdit",id);
});
},cancelEdit:function(jq,id){
return jq.each(function(){
$(this).datagrid("cancelEdit",id);
});
},showLines:function(jq){
return jq.each(function(){
_96(this);
});
}};
$.fn.treegrid.parseOptions=function(_ba){
return $.extend({},$.fn.datagrid.parseOptions(_ba),$.parser.parseOptions(_ba,["treeField",{animate:"boolean"}]));
};
var _bb=$.extend({},$.fn.datagrid.defaults.view,{render:function(_bc,_bd,_be){
var _bf=$.data(_bc,"treegrid").options;
var _c0=$(_bc).datagrid("getColumnFields",_be);
var _c1=$.data(_bc,"datagrid").rowIdPrefix;
if(_be){
if(!(_bf.rownumbers||(_bf.frozenColumns&&_bf.frozenColumns.length))){
return;
}
}
var _c2=this;
if(this.treeNodes&&this.treeNodes.length){
var _c3=_c4(_be,this.treeLevel,this.treeNodes);
$(_bd).append(_c3.join(""));
}
function _c4(_c5,_c6,_c7){
var _c8=$(_bc).treegrid("getParent",_c7[0][_bf.idField]);
var _c9=(_c8?_c8.children.length:$(_bc).treegrid("getRoots").length)-_c7.length;
var _ca=["<table class=\"datagrid-btable\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody>"];
for(var i=0;i<_c7.length;i++){
var row=_c7[i];
if(row.state!="open"&&row.state!="closed"){
row.state="open";
}
var css=_bf.rowStyler?_bf.rowStyler.call(_bc,row):"";
var _cb="";
var _cc="";
if(typeof css=="string"){
_cc=css;
}else{
if(css){
_cb=css["class"]||"";
_cc=css["style"]||"";
}
}
var cls="class=\"datagrid-row "+(_c9++%2&&_bf.striped?"datagrid-row-alt ":" ")+_cb+"\"";
var _cd=_cc?"style=\""+_cc+"\"":"";
var _ce=_c1+"-"+(_c5?1:2)+"-"+row[_bf.idField];
_ca.push("<tr id=\""+_ce+"\" node-id=\""+row[_bf.idField]+"\" "+cls+" "+_cd+">");
_ca=_ca.concat(_c2.renderRow.call(_c2,_bc,_c0,_c5,_c6,row));
_ca.push("</tr>");
if(row.children&&row.children.length){
var tt=_c4(_c5,_c6+1,row.children);
var v=row.state=="closed"?"none":"block";
_ca.push("<tr class=\"treegrid-tr-tree\"><td style=\"border:0px\" colspan="+(_c0.length+(_bf.rownumbers?1:0))+"><div style=\"display:"+v+"\">");
_ca=_ca.concat(tt);
_ca.push("</div></td></tr>");
}
}
_ca.push("</tbody></table>");
return _ca;
};
},renderFooter:function(_cf,_d0,_d1){
var _d2=$.data(_cf,"treegrid").options;
var _d3=$.data(_cf,"treegrid").footer||[];
var _d4=$(_cf).datagrid("getColumnFields",_d1);
var _d5=["<table class=\"datagrid-ftable\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody>"];
for(var i=0;i<_d3.length;i++){
var row=_d3[i];
row[_d2.idField]=row[_d2.idField]||("foot-row-id"+i);
_d5.push("<tr class=\"datagrid-row\" node-id=\""+row[_d2.idField]+"\">");
_d5.push(this.renderRow.call(this,_cf,_d4,_d1,0,row));
_d5.push("</tr>");
}
_d5.push("</tbody></table>");
$(_d0).html(_d5.join(""));
},renderRow:function(_d6,_d7,_d8,_d9,row){
var _da=$.data(_d6,"treegrid").options;
var cc=[];
if(_d8&&_da.rownumbers){
cc.push("<td class=\"datagrid-td-rownumber\"><div class=\"datagrid-cell-rownumber\">0</div></td>");
}
for(var i=0;i<_d7.length;i++){
var _db=_d7[i];
var col=$(_d6).datagrid("getColumnOption",_db);
if(col){
var css=col.styler?(col.styler(row[_db],row)||""):"";
var _dc="";
var _dd="";
if(typeof css=="string"){
_dd=css;
}else{
if(cc){
_dc=css["class"]||"";
_dd=css["style"]||"";
}
}
var cls=_dc?"class=\""+_dc+"\"":"";
var _de=col.hidden?"style=\"display:none;"+_dd+"\"":(_dd?"style=\""+_dd+"\"":"");
cc.push("<td field=\""+_db+"\" "+cls+" "+_de+">");
var _de="";
if(!col.checkbox){
if(col.align){
_de+="text-align:"+col.align+";";
}
if(!_da.nowrap){
_de+="white-space:normal;height:auto;";
}else{
if(_da.autoRowHeight){
_de+="height:auto;";
}
}
}
cc.push("<div style=\""+_de+"\" ");
if(col.checkbox){
cc.push("class=\"datagrid-cell-check ");
}else{
cc.push("class=\"datagrid-cell "+col.cellClass);
}
cc.push("\">");
if(col.checkbox){
if(row.checked){
cc.push("<input type=\"checkbox\" checked=\"checked\"");
}else{
cc.push("<input type=\"checkbox\"");
}
cc.push(" name=\""+_db+"\" value=\""+(row[_db]!=undefined?row[_db]:"")+"\">");
}else{
var val=null;
if(col.formatter){
val=col.formatter(row[_db],row);
}else{
val=row[_db];
}
if(_db==_da.treeField){
for(var j=0;j<_d9;j++){
cc.push("<span class=\"tree-indent\"></span>");
}
if(row.state=="closed"){
cc.push("<span class=\"tree-hit tree-collapsed\"></span>");
cc.push("<span class=\"tree-icon tree-folder "+(row.iconCls?row.iconCls:"")+"\"></span>");
}else{
if(row.children&&row.children.length){
cc.push("<span class=\"tree-hit tree-expanded\"></span>");
cc.push("<span class=\"tree-icon tree-folder tree-folder-open "+(row.iconCls?row.iconCls:"")+"\"></span>");
}else{
cc.push("<span class=\"tree-indent\"></span>");
cc.push("<span class=\"tree-icon tree-file "+(row.iconCls?row.iconCls:"")+"\"></span>");
}
}
cc.push("<span class=\"tree-title\">"+val+"</span>");
}else{
cc.push(val);
}
}
cc.push("</div>");
cc.push("</td>");
}
}
return cc.join("");
},refreshRow:function(_df,id){
this.updateRow.call(this,_df,id,{});
},updateRow:function(_e0,id,row){
var _e1=$.data(_e0,"treegrid").options;
var _e2=$(_e0).treegrid("find",id);
$.extend(_e2,row);
var _e3=$(_e0).treegrid("getLevel",id)-1;
var _e4=_e1.rowStyler?_e1.rowStyler.call(_e0,_e2):"";
var _e5=$.data(_e0,"datagrid").rowIdPrefix;
var _e6=_e2[_e1.idField];
function _e7(_e8){
var _e9=$(_e0).treegrid("getColumnFields",_e8);
var tr=_e1.finder.getTr(_e0,id,"body",(_e8?1:2));
var _ea=tr.find("div.datagrid-cell-rownumber").html();
var _eb=tr.find("div.datagrid-cell-check input[type=checkbox]").is(":checked");
tr.html(this.renderRow(_e0,_e9,_e8,_e3,_e2));
tr.attr("style",_e4||"");
tr.find("div.datagrid-cell-rownumber").html(_ea);
if(_eb){
tr.find("div.datagrid-cell-check input[type=checkbox]")._propAttr("checked",true);
}
if(_e6!=id){
tr.attr("id",_e5+"-"+(_e8?1:2)+"-"+_e6);
tr.attr("node-id",_e6);
}
};
_e7.call(this,true);
_e7.call(this,false);
$(_e0).treegrid("fixRowHeight",id);
},deleteRow:function(_ec,id){
var _ed=$.data(_ec,"treegrid").options;
var tr=_ed.finder.getTr(_ec,id);
tr.next("tr.treegrid-tr-tree").remove();
tr.remove();
var _ee=del(id);
if(_ee){
if(_ee.children.length==0){
tr=_ed.finder.getTr(_ec,_ee[_ed.idField]);
tr.next("tr.treegrid-tr-tree").remove();
var _ef=tr.children("td[field=\""+_ed.treeField+"\"]").children("div.datagrid-cell");
_ef.find(".tree-icon").removeClass("tree-folder").addClass("tree-file");
_ef.find(".tree-hit").remove();
$("<span class=\"tree-indent\"></span>").prependTo(_ef);
}
}
function del(id){
var cc;
var _f0=$(_ec).treegrid("getParent",id);
if(_f0){
cc=_f0.children;
}else{
cc=$(_ec).treegrid("getData");
}
for(var i=0;i<cc.length;i++){
if(cc[i][_ed.idField]==id){
cc.splice(i,1);
break;
}
}
return _f0;
};
},onBeforeRender:function(_f1,_f2,_f3){
if($.isArray(_f2)){
_f3={total:_f2.length,rows:_f2};
_f2=null;
}
if(!_f3){
return false;
}
var _f4=$.data(_f1,"treegrid");
var _f5=_f4.options;
if(_f3.length==undefined){
if(_f3.footer){
_f4.footer=_f3.footer;
}
if(_f3.total){
_f4.total=_f3.total;
}
_f3=this.transfer(_f1,_f2,_f3.rows);
}else{
function _f6(_f7,_f8){
for(var i=0;i<_f7.length;i++){
var row=_f7[i];
row._parentId=_f8;
if(row.children&&row.children.length){
_f6(row.children,row[_f5.idField]);
}
}
};
_f6(_f3,_f2);
}
var _f9=_37(_f1,_f2);
if(_f9){
if(_f9.children){
_f9.children=_f9.children.concat(_f3);
}else{
_f9.children=_f3;
}
}else{
_f4.data=_f4.data.concat(_f3);
}
this.sort(_f1,_f3);
this.treeNodes=_f3;
this.treeLevel=$(_f1).treegrid("getLevel",_f2);
},sort:function(_fa,_fb){
var _fc=$.data(_fa,"treegrid").options;
if(!_fc.remoteSort&&_fc.sortName){
var _fd=_fc.sortName.split(",");
var _fe=_fc.sortOrder.split(",");
_ff(_fb);
}
function _ff(rows){
rows.sort(function(r1,r2){
var r=0;
for(var i=0;i<_fd.length;i++){
var sn=_fd[i];
var so=_fe[i];
var col=$(_fa).treegrid("getColumnOption",sn);
var _100=col.sorter||function(a,b){
return a==b?0:(a>b?1:-1);
};
r=_100(r1[sn],r2[sn])*(so=="asc"?1:-1);
if(r!=0){
return r;
}
}
return r;
});
for(var i=0;i<rows.length;i++){
var _101=rows[i].children;
if(_101&&_101.length){
_ff(_101);
}
}
};
},transfer:function(_102,_103,data){
var opts=$.data(_102,"treegrid").options;
var rows=[];
for(var i=0;i<data.length;i++){
rows.push(data[i]);
}
var _104=[];
for(var i=0;i<rows.length;i++){
var row=rows[i];
if(!_103){
if(!row._parentId){
_104.push(row);
rows.splice(i,1);
i--;
}
}else{
if(row._parentId==_103){
_104.push(row);
rows.splice(i,1);
i--;
}
}
}
var toDo=[];
for(var i=0;i<_104.length;i++){
toDo.push(_104[i]);
}
while(toDo.length){
var node=toDo.shift();
for(var i=0;i<rows.length;i++){
var row=rows[i];
if(row._parentId==node[opts.idField]){
if(node.children){
node.children.push(row);
}else{
node.children=[row];
}
toDo.push(row);
rows.splice(i,1);
i--;
}
}
}
return _104;
}});
$.fn.treegrid.defaults=$.extend({},$.fn.datagrid.defaults,{treeField:null,lines:false,animate:false,singleSelect:true,view:_bb,rowEvents:$.extend({},$.fn.datagrid.defaults.rowEvents,{mouseover:_22(true),mouseout:_22(false),click:_24}),loader:function(_105,_106,_107){
var opts=$(this).treegrid("options");
if(!opts.url){
return false;
}
$.ajax({type:opts.method,url:opts.url,data:_105,dataType:"json",success:function(data){
_106(data);
},error:function(){
_107.apply(this,arguments);
}});
},loadFilter:function(data,_108){
return data;
},finder:{getTr:function(_109,id,type,_10a){
type=type||"body";
_10a=_10a||0;
var dc=$.data(_109,"datagrid").dc;
if(_10a==0){
var opts=$.data(_109,"treegrid").options;
var tr1=opts.finder.getTr(_109,id,type,1);
var tr2=opts.finder.getTr(_109,id,type,2);
return tr1.add(tr2);
}else{
if(type=="body"){
var tr=$("#"+$.data(_109,"datagrid").rowIdPrefix+"-"+_10a+"-"+id);
if(!tr.length){
tr=(_10a==1?dc.body1:dc.body2).find("tr[node-id=\""+id+"\"]");
}
return tr;
}else{
if(type=="footer"){
return (_10a==1?dc.footer1:dc.footer2).find("tr[node-id=\""+id+"\"]");
}else{
if(type=="selected"){
return (_10a==1?dc.body1:dc.body2).find("tr.datagrid-row-selected");
}else{
if(type=="highlight"){
return (_10a==1?dc.body1:dc.body2).find("tr.datagrid-row-over");
}else{
if(type=="checked"){
return (_10a==1?dc.body1:dc.body2).find("tr.datagrid-row-checked");
}else{
if(type=="last"){
return (_10a==1?dc.body1:dc.body2).find("tr:last[node-id]");
}else{
if(type=="allbody"){
return (_10a==1?dc.body1:dc.body2).find("tr[node-id]");
}else{
if(type=="allfooter"){
return (_10a==1?dc.footer1:dc.footer2).find("tr[node-id]");
}
}
}
}
}
}
}
}
}
},getRow:function(_10b,p){
var id=(typeof p=="object")?p.attr("node-id"):p;
return $(_10b).treegrid("find",id);
},getRows:function(_10c){
return $(_10c).treegrid("getChildren");
}},onBeforeLoad:function(row,_10d){
},onLoadSuccess:function(row,data){
},onLoadError:function(){
},onBeforeCollapse:function(row){
},onCollapse:function(row){
},onBeforeExpand:function(row){
},onExpand:function(row){
},onClickRow:function(row){
},onDblClickRow:function(row){
},onClickCell:function(_10e,row){
},onDblClickCell:function(_10f,row){
},onContextMenu:function(e,row){
},onBeforeEdit:function(row){
},onAfterEdit:function(row,_110){
},onCancelEdit:function(row){
}});
})(jQuery);

