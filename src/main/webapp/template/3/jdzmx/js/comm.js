






//***********************************设为首页，收藏开始*********************************************
function AddToFavorite()  
{  
    if (document.all){  
       window.external.addFavorite(document.URL,document.title);  
    }else if (window.sidebar){  
       window.sidebar.addPanel(document.title, document.URL, "");  
    }  
}  
  
//设为首页  
function setHomepage(){  
    if (document.all){  
    document.body.style.behavior='url(#default#homepage)';  
    document.body.setHomePage(document.URL);  
  }else if (window.sidebar){  
        if(window.netscape){  
       try{   
          netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");   
       }catch (e){   
                    alert( "该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 about:config,然后将项 signed.applets.codebase_principal_support 值该为true" );   
       }  
        }   
    var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components. interfaces.nsIPrefBranch);  
    prefs.setCharPref('browser.startup.homepage',document.URL);  
    }  
} 
//***********************************设为首页，收藏结束*********************************************


<!-- Beginning of JavaScript Code -------------------

nereidFadeObjects = new Object();
nereidFadeTimers = new Object();
function nereidFade(object, destOp, rate, delta){
if (!document.all)
return
    if (object != "[object]"){ setTimeout("nereidFade("+object+","+destOp+","+rate+","+delta+")",0);
        return;
    }
    clearTimeout(nereidFadeTimers[object.sourceIndex]);
    diff = destOp-object.filters.alpha.opacity;
    direction = 1;
    if (object.filters.alpha.opacity > destOp){
        direction = -1;
    }
    delta=Math.min(direction*diff,delta);
    object.filters.alpha.opacity+=direction*delta;
    if (object.filters.alpha.opacity != destOp){
        nereidFadeObjects[object.sourceIndex]=object;
        nereidFadeTimers[object.sourceIndex]=setTimeout("nereidFade(nereidFadeObjects["+object.sourceIndex+"],"+destOp+","+rate+","+delta+")",rate);
    }
}
// -- End of JavaScript Code -->

<!--
//图片按比例缩放
var flag=false;
function DrawImage(ImgD){
var image=new Image();
var iwidth = 180; //定义允许图片宽度
var iheight = 160; //定义允许图片高度
image.src=ImgD.src;
if(image.width>0 && image.height>0){
flag=true;
if(image.width/image.height>= iwidth/iheight){
if(image.width>iwidth){ 
ImgD.width=iwidth;
ImgD.height=(image.height*iwidth)/image.width;
}else{
ImgD.width=image.width; 
ImgD.height=image.height;
}

ImgD.alt=image.width+"×"+image.height;
}
else{
if(image.height>iheight){ 
ImgD.height=iheight;
ImgD.width=(image.width*iheight)/image.height; 
}else{
ImgD.width=image.width; 
ImgD.height=image.height;
}
ImgD.alt=image.width+"×"+image.height;
}
}
} 
//调用：<img src="图片" onload="javascript:DrawImage(this)">
//-->

<!--ff支持outerHTML-->
 if(typeof(HTMLElement)!="undefined" && !window.opera)
 {
  HTMLElement.prototype.__defineGetter__("outerHTML",function()
  {
   var a=this.attributes, str="<"+this.tagName, i=0;for(;i<a.length;i++)
   if(a[i].specified)
    str+=" "+a[i].name+'="'+a[i].value+'"';
   if(!this.canHaveChildren)
    return str+" />";
   return str+">"+this.innerHTML+"</"+this.tagName+">";
  });
  HTMLElement.prototype.__defineSetter__("outerHTML",function(s)
  {
   var r = this.ownerDocument.createRange();
   r.setStartBefore(this);
   var df = r.createContextualFragment(s);
   this.parentNode.replaceChild(df, this);
   return s;
  });
  HTMLElement.prototype.__defineGetter__("canHaveChildren",function()
  {
   return !/^(area|base|basefont|col|frame|hr|img|br|input|isindex|link|meta|param)$/.test(this.tagName.toLowerCase());
  });
 }
 <!--ff支持outerHTML-->

  // 图片大小控制
function ReImgSize(){
	var obj =document.getElementById("content").getElementsByTagName("img");
	if(!obj) obj = document.images;
	for (i=0; i<obj.length; i++){
		if (obj){
			if (obj[i].width>450){
				obj[i].width = 450;
				obj[i].style.width = 450;
				obj[i].title = "在新窗口打开图片!";
				obj[i].style.cursor = "pointer";
				obj[i].border = 0;
				obj[i].outerHTML='<a href="'+obj[i].src+'" rel="lightbox[loval]"  target="_blank" title="[pic:title]">'+obj[i].outerHTML+'</a>'
			}
		}
	}
}
