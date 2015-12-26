<#include "ui/index.ftl"/>

<#--权限控制-->
<#--link:必须 type:add/del/edit/query class:样式 id,value:显示文字-->
<#macro auth link type="" value="" class="" id="">
	<@shiro.hasPermission name="${link}">
		<#if type=="add">
			<@ms.panelNavBtnAdd id="${id}" value="${value}" class="${class}"/>
		<#elseif type=="del">
			<@ms.panelNavBtnDel id="${id}" value="${value}" class="${class}"/>
		<!--
		<#elseif type=="edit">
			<@ms.panelNavBtnDel id="${id}" value="${value}" class="${class}"/>
			-->
		<#else>
			<a href="${link}" class="${class}">${value}</a>
		</#if>
	</@shiro.hasPermission>
</#macro>

<#--分页-->
<#macro showPage page>
<#if page?exists && page.pageCount gt 1>
	<nav class="pageNav">
	<ul class="pagination pull-right">
		<#--格式 <（上一页） 1 2 3 4 >(下一页) -->
		<li class="prev <#if (page.pageNo+1)==1> disabled" ><a<#else> "><a href="${page.previousUrl}" </#if> target="_self"><i class="fa fa-angle-left">上一页</i></a></li>
			<#list 1..page.pageCount as i>
				<li <#if page.pageNo+1==i>class="active" ><a<#else> ><a href='${page.linkUrl}pageNo=${i}'</#if>  target="_self">${i}</a></li>
			</#list>
		<li class="next <#if page.pageNo+1 == page.pageCount>disabled" ><a<#else> "><a href="${page.nextUrl}"</#if>  target="_self"><i class="fa fa-angle-right">下一页</i></a></li>
	</ul>
	</nav>
</#if>
</#macro>



<#--简易编辑器-->
<#--inputName:输入框名称-->
<#--width\height:编辑器的宽度高度-->
<#--content:初始化内容-->
<#macro smallUedit inputName width height content>

	    <script type="text/plain" id="editor_${inputName}" name="${inputName}">${content?default('')}</script>
	    
		  <div class="editor-bottom-bar">
		    当前已输入
		    <span class="char_count">
		      0
		    </span>
		    个字符, 您还可以输入
		    <span class="char_remain">
		      80000
		    </span>
		    个字符。
		  </div>    
	    <style>
		.editor-bottom-bar {
			white-space: nowrap;
			border: 1px solid #ccc;
			line-height: 20px;
			font-size: 12px;
			text-align: right;
			margin-right: 5px;
			color: #aaa;
			border-top: 0;
			width:  ${width}px;
		}
		</style>
	
		<script type="text/javascript">
				var charLimit = 80000;
		    	window.editor_${inputName} = new UE.ui.Editor({
					initialFrameWidth : ${width},
					initialFrameHeight : ${height}
				});
				window.editor_${inputName}.render("editor_${inputName}");
		    	function computeChar() {
		    	
					var len = editor_${inputName}.getContent().length;
					if (len > charLimit) {
						$(".editor-bottom-bar").html("<span style='color:red;'>你输入的字符个数（"
								+ len + "）已经超出最大允许值！</span>")
					} else {
						$(".editor-bottom-bar").html("当前已输入<span class='char_count'>" + len
								+ "</span>个字符, 您还可以输入<span class='char_remain'>"
								+ (charLimit - len) + "</span>个字符。")
					}
				}
				
				window.editor_${inputName}.addListener("keyup", function(type, evt) {
					computeChar()
				})
				
				
		</script>
</#macro>


<#--通用弹窗-->
<#--modalName:弹出窗的名称-->
<#--调用方法open弹出窗口名称，例如:窗口名称 abc ，调用openabc('展示内容','标题')-->
<#--注意使用的时候，message的内容只能是id或字符串对象-->
<#macro modalDialog modalName>
	<div class="modal fade" id="${modalName}Dialog" style="overflow-y: hidden;">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="${modalName}Title">
	        </h4>
	      </div>
	      <!--startprint-->
	      <div class="modal-body" id="${modalName}Body">
	      </div>
	      <!--添加其他信息-
	      <div class="modal-footer" id="${modalName}Footer">
	      </div>
	      -->
	      <!--endprint-->
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<script>
		function open${modalName}(message,title) {
		    if (title) {
				$("#${modalName}Title").html(title);
			}
			try {
				if (message) {
					message.show();
				}
			} catch(e){
				alert("文本");
			}	
			$("#${modalName}Body ").html(message);
			$('#${modalName}Dialog').modal();
		}
		 function close${modalName}() {
				$('#warn${modalName}Dialog').modal('hide');
			}
	</script>	
</#macro>



<#--通用警告弹窗-->
<#--warnModal:弹出窗的名称-->
<#--调用方法open弹出窗口名称，例如:窗口名称 abc ，调用openabc('展示内容','标题','点击确定按钮之后回调方法，如果没有则不会显示确认按钮')-->
<#macro warnModal  modalName>
	<div id="warn${modalName}Dialog" class="modal fade" tabindex="-1" data-focus-on="input:first">
	 <div class="modal-dialog">
	    <div class="modal-content">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title"  id="warn${modalName}Title">警告！</h4>
		</div>
		<div class="modal-body"  id="warn${modalName}Body">
			
		</div>
		<div class="modal-footer">
			<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
			<button type="button"  id="warn${modalName}Ok" class="btn btn-primary right" style="display:none">确定</button>
		</div>
		</div>
	 </div>
	</div>	
	<script>
		function warn${modalName}(message,title,func) {
		    if (title) {
				$("#warn${modalName}Title").html(title);
			}
			if(func) {
				$("#warn${modalName}Ok ").show();
				$("#warn${modalName}Ok ").one("click",function(){
					eval(func);
				});
			}
			$("#warn${modalName}Body ").html(message);
			$('#warn${modalName}Dialog').modal();
		}
		
		 function closewarn${modalName}() {
				$('#warn${modalName}Dialog').modal('hide');
			}
	</script>
</#macro>





<#--上传控件-->
<#--path:上传路径-->
<#--inputName:name值-->
<#--filetype:上传规则-->
<#--size:上传数量-->
<#--msg:提示信息-->
<#--imgs:默认显示的图片-->
<#--maxSize:默认文件大小 单位m-->
<#--如果是反复显示图片需要调用showImgs(imgs地址可以包含"|"符合,input的名称)-->
<#macro uploadImg path inputName size filetype msg imgs maxSize>
	<div id="ms__uploadPic_${inputName}">
		<style>
			.msUploadImgs{margin: 0;padding: 0;list-style: none;}
			.msUploadImgs li {list-style:none;float: left;text-align: center;border: 1px solid #F3F3F3;margin: 8px; width:100px;}
			.msUploadImgs img {width:100%; height:100px;}
			.msUploadImgs li span {cursor: pointer;}
			.divUploader{clear:both}
		</style>
		<ul class="msUploadImgs">
			<#if imgs!="">
				<#list imgs?split("|") as img>
					<#if img!="">
						<li id="SWFUpload_9_${img_index}">
							<div class="displayimg">
								<img src="${basePath}/${img}">
							</div>
							<span class="front-cover" onclick="removePreview${inputName}(this,'${img}'+'|')"><a class="btn btn-xs red tooltips " data-original-title="点击删除图片"><i class="glyphicon glyphicon-trash"></i></a>
							</span>
						</li>
					</#if>			
				</#list>	
			</#if>
		</ul>
		<div class="divUploader"><input type="button" id="up_file_${inputName}" />
		<#if msg!="">
		<div class="alert alert-warning alert-dismissable">${msg}</div>
		</#if>
		</div>
		<input type="hidden" size="100" name="${inputName}" id="${inputName}" value="${imgs?default('')}" />
	</div>
	<script type="text/javascript">
		    $(function ()  {
		        $('#ms__uploadPic_${inputName}').swfupload({
		            upload_url: "${basePath}/upload",
		            post_params:{"uploadPath":"/${path}","maxSize":"${maxSize}","allowedFile":"${filetype}","allowedFile":""},
		            file_size_limit: ${maxSize?default("1")}*1024,
		            file_types: "${filetype?default("*.jpg;*.png;*.gif;*.bmp;*.jpeg")}",
		            file_types_description: "Image files",
		            file_upload_limit: ${size?default("5")},
		            flash_url: "${basePath}/jquery/swfupload/swfupload.swf",
		            button_image_url: "${basePath}/jquery/swfupload/button.png",
		         	button_width: 92,
					button_height: 34,
		            button_placeholder: $('#up_file_${inputName}')[0],
		            debug: false
		        })
				.bind('fileQueued', function (event, file) {	
				   if ($("#ms__uploadPic_${inputName} .msUploadImgs").children().length>=${size?default("5")}) {
						  $(this).swfupload('cancelUpload');
						  alert("最多上传${size}个文件!");
					} else {
					    var listitem = '<li id="' + file.id + '"><div class="displayimg"><img src="${basePath}/jquery/swfupload/load.gif" /></div><span class="front-cover">0%</span></li>';
			            $('#ms__uploadPic_${inputName} ul').append(listitem);
					    $(this).swfupload('startUpload');
				    }
				    
				})
				.bind('fileQueueError', function (event, file, errorCode, message) {
				    if (errorCode==-130) {
				    	alert('文件类型错误!');
				    } else if (errorCode==-100) {
				    	alert("最多上传${size}个文件!");
				    } else {
				    	alert('上传图片过多或上传图片过大!');
				    }
				})
				.bind('uploadStart', function (event, file) {
						$('#ms__uploadPic_${inputName} ul li#' + file.id).find('span.front-cover').text('0%');
				})
				.bind('uploadProgress', function (event, file, bytesLoaded) {
					   var percentage = Math.round((bytesLoaded / file.size) * 100);
				       $('#ms__uploadPic_${inputName} ul li#' + file.id).find('span.front-cover').text(percentage + '%');
				})
				.bind('uploadSuccess', function (event, file, serverData) {
				    var item = $('#ms__uploadPic_${inputName} ul li#' + file.id);
				    item.find('div.displayimg').html('<img src="${basePath}/' + serverData + '" />');
				    item.find('span.front-cover').html('<a class="btn btn-xs red tooltips " data-original-title="点击删除图片"><i class="glyphicon glyphicon-trash"></i></a>');
				    if($('#${inputName}').val()!=""){
				    	 $('#${inputName}').val($('#${inputName}').val() + "|"+ serverData )
				    }else{
				    	 $('#${inputName}').val(serverData )
				    }
				    
				    
				    
				    $('#ms__uploadPic_${inputName} ul li#' + file.id + ' span.front-cover').bind('click', function () {
				        $('#ms__uploadPic_${inputName} ul li#' + file.id + '').slideUp('fast');
				        var swfu = $.swfupload.getInstance('#ms__uploadPic_${inputName}');
				        var stats = swfu.getStats();
				        stats.successful_uploads--;
				        swfu.setStats(stats);
				        
				        //判断保存图片的输入框中是否存在"|"如果存在则表示图片至少要两张
				        if ($('#${inputName}').val().indexOf("|")<0) {
				        	$('#${inputName}').val($('#${inputName}').val().replace(serverData, ""));
				        }else{
				        	 $('#${inputName}').val($('#${inputName}').val().replace(serverData+"|", ""));
				        }
				        //获取最后一张图片的路径
				        var obj=$("#ms__uploadPic_${inputName}").find("ul li:last");
				        var imgSrcPath = obj.find(".displayimg img").attr("src").replace("${basePath}/","");;
				        //判断是否删除的是最后一张,如果是则删除时不含"|"
				        if(imgSrcPath==serverData.replace("|","")){
				        	$('#${inputName}').val($('#${inputName}').val().replace("|"+serverData.replace("|",""), ""));
				        }
				       
				        $('#ms__uploadPic_${inputName} ul li#' + file.id).remove();
				    });
				})
				.bind('uploadComplete', function (event, file) {
				    $(this).swfupload('startUpload');
				})
		    });
		    function removePreview${inputName}(uid,imgPath) {
		        var swfu = $.swfupload.getInstance('#ms__uploadPic_${inputName}');
		        var stats = swfu.getStats();
		        stats.successful_uploads--;
		        swfu.setStats(stats);
		        imgPath=imgPath.replace("|","")
				//判断保存图片的输入框中是否存在"|"如果存在则表示图片至少要两张
				if ($('#${inputName}').val().indexOf("|")<0) {
				     $('#${inputName}').val($('#${inputName}').val().replace(imgPath, ""));
				 }else{
				     $('#${inputName}').val($('#${inputName}').val().replace(imgPath+"|", ""));
				 }
				 var obj=$("#ms__uploadPic_${inputName}").find("ul li:last");
				var imgSrcPath = obj.find(".displayimg img").attr("src").replace("${basePath}/","");
				//判断是否删除的是最后一张,如果是则删除时不含"|"
				if(imgSrcPath==imgPath.replace("|","")){
				    $('#${inputName}').val($('#${inputName}').val().replace("|"+imgPath.replace("|",""), ""));
				}
		        $('#ms__uploadPic_${inputName} ul li#' + uid.parentNode.id).slideUp('fast',function() {
		        	$(this).remove();
		        });
		    }
		    
		    /**
		    *提供给弹窗显示图片使用
		    */
		    function showImgs${inputName}(imgs,inputName) {
		    	//var swfu = $.swfupload.getInstance('#ms__uploadPic_'+inputName);
		        //var stats = swfu.getStats();
		    	$(".msUploadImgs").children().remove();
		    	  if (imgs) {
		    	  	 var _imgs = imgs.split("\|");
		    	    for (i=0;i<_imgs.length;i++) {
		    	    	  if (_imgs[i]!="") {
								var imgLi = '<li id="SWFUpload_9_'+i+'">';
									imgLi+='<div class="displayimg">';
													imgLi+='<img src="${basePath}/'+_imgs[i]+'">';
									imgLi+='</div>';
									imgLi+='<span class="front-cover" onclick="removePreview${inputName}(this,\''+_imgs[i]+'\'+'|')"><a class="btn btn-xs red tooltips " data-original-title="点击删除图片"><i class="glyphicon glyphicon-trash"></i></a>';
									imgLi+='</span>';
								imgLi+='</li>';
								$(".msUploadImgs").append(imgLi);;
								//stats.successful_uploads++;
								//swfu.setStats(stats);
							}
						}
				    }
		    }			
			</script>
</#macro>

<#--上传控件-->
<#--path:上传路径-->
<#--inputName:name值-->
<#--filetype:上传规则-->
<#--size:上传数量-->
<#--msg:提示信息-->
<#--callBack:回调提示信息-->
<#--isRename:是否重命名true:将使用时间命名，否则使用上传是文件名，可能会出现同名称覆盖的问题,中文也会存在问题-->
<#--maxSize:默认文件大小 单位m-->
<#macro uploadFile path inputName size filetype msg  maxSize callBack isRename>
	<div id="ms__uploadPic_${inputName}">
		<div class="divUploader"><input type="button" id="up_file_${inputName}" />
		<#if msg!="">
		<div class="alert alert-warning alert-dismissable">${msg}</div>
		</#if>
		</div>
		<input type="hidden" size="100" name="${inputName}" id="${inputName}" value="${imgs?default('')}" />
	</div>
	<script type="text/javascript">
		    $(function ()  {
		        $('#ms__uploadPic_${inputName}').swfupload({
		            upload_url: "${basePath}/upload",
		            post_params:{"uploadPath":"/${path}","isRename":"${isRename?default("true")}","maxSize":"${maxSize}","allowedFile":"${filetype}","allowedFile":""},
		            file_size_limit: ${maxSize?default("1")}*1024,
		            file_types: "${filetype?default("*.jpg;*.png;*.gif;*.bmp;*.jpeg")}",
		            file_types_description: "Image files",
		            file_upload_limit: ${size?default("5")},
		            flash_url: "${basePath}/jquery/swfupload/swfupload.swf",
		            button_image_url: "${basePath}/jquery/swfupload/button_file.png",
		         	button_width: 92,
					button_height: 34,
		            button_placeholder: $('#up_file_${inputName}')[0],
		            debug: false
		        })
				.bind('fileQueued', function (event, file) {	
				   if ($("#ms__uploadPic_${inputName} .msUploadImgs").children().length>=${size?default("5")}) {
						  $(this).swfupload('cancelUpload');
						  alert("最多上传${size}个文件!");
					} else {
					    $(this).swfupload('startUpload');
				    }
				    
				})
				.bind('fileQueueError', function (event, file, errorCode, message) {
				    if (errorCode==-130) {
				    	alert('文件类型错误!');
				    } else if (errorCode==-100) {
				    	alert("最多上传${size}个文件!");
				    } else {
				    	//alert(errorCode+'上传图片过多或上传图片过大!');
				    	alert('上传文件过大!');
				    }
				    <#if callBack!=""> 
				    	eval("${callBack}(errorCode)");
				    </#if>
				})
				.bind('uploadStart', function (event, file) {
						$('#ms__uploadPic_${inputName} ul li#' + file.id).find('span.front-cover').text('0%');
				})
				.bind('uploadProgress', function (event, file, bytesLoaded) {
					   var percentage = Math.round((bytesLoaded / file.size) * 100);
				})
				.bind('uploadSuccess', function (event, file, serverData) {
						$('#${inputName}').val(serverData);
						<#if callBack!=""> 
							eval("${callBack}(serverData)");
						<#else>
							alert("上传成功");
						</#if>
				})
				.bind('uploadComplete', function (event, file) {
				    $(this).swfupload('startUpload');
				})
		    });
			</script>
</#macro>



