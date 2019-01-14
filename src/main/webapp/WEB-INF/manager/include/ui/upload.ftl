<#--上传控件-->



<#--上传控件-->
<#--path:上传路径，文件夹是在ms属性配置文件里面配置，会自动增加当前appId-->
<#--uploadFloderPath:如果path路径无法满足可以使用这个参数重新定义上传路径-->
<#--inputName:name值-->
<#--filetype:上传规则-->
<#--size:上传数量-->
<#--msg:提示信息-->
<#--imgs:默认显示的图片-->
<#--maxSize:默认文件大小 单位m-->
<#--如果是反复显示图片需要调用showImgs(imgs地址可以包含"|"符合,input的名称)-->
<#macro uploadImg path  inputName size="1" uploadFloderPath="" filetype="*.jpg;*.png;*.gif;*.bmp;*.jpeg" msg="" imgs="" maxSize="1">
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
		            upload_url: "${basePath}/file/upload.do",
		            post_params:{"uploadPath":"${path}","uploadFloderPath":"${uploadFloderPath}","isRename":"true","maxSize":"${maxSize}","allowedFile":"${filetype}","allowedFile":""},
		            file_size_limit: ${maxSize?default("1")}*1024,
		            file_types: "${filetype?default("*.jpg;*.png;*.gif;*.bmp;*.jpeg")}",
		            file_types_description: "Image files",
		            file_upload_limit: ${size?default("5")},
		            flash_url: "${basePath}/static/plugins/jquery.swfupload/1.0.0/swfupload.swf",
		            button_image_url: static+"/plugins/jquery.swfupload/1.0.0/button.png", 
		         	button_width: 92,
					button_height: 34,
		            button_placeholder: $('#up_file_${inputName}')[0],
		            debug: false
		        })
				.bind('fileQueued', function (event, file) {	
				   if ($("#ms__uploadPic_${inputName} .msUploadImgs").children().length>=${size?default("5")}) {
						  $(this).swfupload('cancelUpload');
						  <@ms.notify msg= "最多上传${size}个文件!" type= "warning" />
					} else {
					    var listitem = '<li id="' + file.id + '"><div class="displayimg"><img src="'+static+'/plugins/jquery.swfupload/1.0.0/load.gif" /></div><span class="front-cover">0%</span></li>';
			            $('#ms__uploadPic_${inputName} ul').append(listitem);
					    $(this).swfupload('startUpload');
				    }
				    
				})
				.bind('fileQueueError', function (event, file, errorCode, message) {
				    if (errorCode==-130) {
				    	<@ms.notify msg= "文件类型错误!" type= "warning" />
				    } else if (errorCode==-100) {
				    	<@ms.notify msg= "最多上传${size}个文件!" type= "warning" />
				    } else {
				    	<@ms.notify msg= "上传图片过多或上传图片过大!" type= "warning" />
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
				      
				        $('#ms__uploadPic_${inputName} ul li#' + file.id).remove();
				        
				        setInputValue${inputName}();
				    });
				})
				.bind('uploadComplete', function (event, file) {
				    $(this).swfupload('startUpload');
				})
		    });
		    
		    // 设置文本框的值 用于提交数据
		    function setInputValue${inputName}(){
		    	var value = "";
		        // 设置文本的值
		        $("#ms__uploadPic_${inputName}").find("ul li .displayimg img").each(function(){
		      		var src = $(this).attr('src').replace('${basePath}/', '');
		        	value += src + '|';
		        });
		        // 删除最后一个"|"
		        if (value){
		        	value = value.slice(0, -1);
		        }
		        
		      	$('#${inputName}').val(value);
		    }
		     
		    function removePreview${inputName}(uid,imgPath) {
		        var swfu = $.swfupload.getInstance('#ms__uploadPic_${inputName}');
		        var stats = swfu.getStats();
		        stats.successful_uploads--;
		        swfu.setStats(stats);
		        //imgPath=imgPath.replace("|","")
		        
				//判断保存图片的输入框中是否存在"|"如果存在则表示图片至少要两张
				//if ($('#${inputName}').val().indexOf("|")<0) {
				     //$('#${inputName}').val($('#${inputName}').val().replace(imgPath, ""));
				// }else{
				     //$('#${inputName}').val($('#${inputName}').val().replace(imgPath+"|", ""));
				// }
				
				//var obj=$("#ms__uploadPic_${inputName}").find("ul li:last");
				//var imgSrcPath = obj.find(".displayimg img").attr("src").replace("${basePath}/","");
				//判断是否删除的是最后一张,如果是则删除时不含"|"
				//if(imgSrcPath==imgPath.replace("|","")){
				    //$('#${inputName}').val($('#${inputName}').val().replace("|"+imgPath.replace("|",""), ""));
				//}
				
		        $('#ms__uploadPic_${inputName} ul li#' + uid.parentNode.id).slideUp('fast',function() {
		        	$(this).remove();
		        	setInputValue${inputName}();
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
<#--path:上传路径，文件夹是在ms属性配置文件里面配置，会自动增加当前appId-->
<#--uploadFloderPath:如果path路径无法满足可以使用这个参数重新定义上传路径-->
<#--inputName:name值-->
<#--filetype:上传规则-->
<#--size:上传数量-->
<#--msg:提示信息-->
<#--callBack:回调提示信息-->
<#--isRename:是否重命名true:将使用时间命名，否则使用上传是文件名，可能会出现同名称覆盖的问题,中文也会存在问题-->
<#--maxSize:默认文件大小 单位m-->
<#macro uploadFile path inputName uploadFloderPath="" size=1 filetype="*.zip,*.rar,*.doc,*.xls,*.doc,*.txt,*.pdf" msg=""  maxSize="10" callBack="" isRename=false>
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
		            upload_url: "${basePath}/file/upload.do",
		            post_params:{"uploadPath":"/${path}","uploadFloderPath":"${uploadFloderPath}","isRename":"${isRename?default("true")}","maxSize":"${maxSize}","allowedFile":"${filetype}","allowedFile":""},
		            file_size_limit: ${maxSize?default("1")}*1024,
		            file_types: "${filetype?default("*.jpg;*.png;*.gif;*.bmp;*.jpeg;*.zip;*.rar")}",
		            file_upload_limit: ${size?default("5")},
		            flash_url: "${basePath}/static/plugins/jquery.swfupload/1.0.0/swfupload.swf",
		            button_image_url: static+"/plugins/jquery.swfupload/1.0.0/button_file.png",
		         	button_width: 92,
					button_height: 34,
		            button_placeholder: $('#up_file_${inputName}')[0],
		            debug: false
		        })
				.bind('fileQueued', function (event, file) {	
				   if ($("#ms__uploadPic_${inputName} .msUploadImgs").children().length>=${size?default("5")}) {
						  $(this).swfupload('cancelUpload');
						  <@ms.notify msg= "上传图片过多或上传图片过大!" type= "warning" />
					} else {
					    $(this).swfupload('startUpload');
				    }
				    
				})
				.bind('fileQueueError', function (event, file, errorCode, message) {
				    if (errorCode==-130) {
				    	<@ms.notify msg= "文件类型错误!" type= "warning" />
				    } else if (errorCode==-100) {
				    	<@ms.notify msg= "最多上传${size}个文件!" type= "warning" />
				    } else {
				    	//alert(errorCode+'上传图片过多或上传图片过大!');
				    	<@ms.notify msg= "上传文件过大!" type= "warning" />
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
							<@ms.notify msg= "上传成功" type= "success" />
						</#if>
				})
				.bind('uploadComplete', function (event, file) {
				    $(this).swfupload('startUpload');
				})
		    });
			</script>
</#macro>

<#-- plupload 图片上传组件 -->
<#-- path 图片上传地址-->
<#-- triggerBtnId 触发上传对话框的dom元素id-->
<#-- imgId 放置图片的的标签id 为空的话不显示 -->
<#-- container 用来指定Plupload所创建的html结构的父容器，默认为前面指定的browse_button的父元素。该参数的值可以是一个元素的id,也可以是DOM元素本身。-->
<#-- filetype 图片文件类型用 , 隔开-->
<#-- maxSize 文件最大值 单位 M-->
<#macro pluploadImg path triggerBtnId imgId="" filetype="*.jpg;*.png;*.gif;*.bmp;*.jpeg" maxSize="1" callback="" isRename=true>

<#assign onlyId = triggerBtnId />
	<script type="text/javascript">
	var ms__uploader_${onlyId} = new plupload.Uploader({
		runtimes: 'html5',
		browse_button: '${triggerBtnId}',
		url: "${basePath}/upload",			// 接收上传请求的servlet地址
		multi_selection: false,				// 只能选择1个文件
		filters : {
	        max_file_size : '${maxSize}mb',
	        mime_types: [{title:"ImageFiles", extensions:"jpg,gif,png,bmp,jpeg"}]
	    },
	    // 上传服务器数据 post
	    multipart_params: {
	    	"uploadPath": "/${path}", 
	    	"isRename": "${isRename?default("true")}",
	    	"maxSize": ${maxSize},
	    	"allowedFile": "${filetype?default('*.jpg;*.png;*.gif;*.bmp;*.jpeg')}"
	    }
	});
	
	//在实例对象上调用init()方法进行初始化
	ms__uploader_${onlyId}.init();
	
	// 初始化方法
	ms__uploader_${onlyId}.bind('Init', function(loader){
	
	});
	
	// 用户添加文件, 开始的时候立即添加
	ms__uploader_${onlyId}.bind('FilesAdded', function(up, files){
		uploader.start();
	});
	
	// 队列中所有文件被上传完
	ms__uploader_${onlyId}.bind('UploadComplete', function(up, file){
		
	});
	
	// 当一个文件开始上传的时候触发
	ms__uploader_${onlyId}.bind('UploadFile', function(up, file){
		
	});
	
	// 文件上传成功的时候触发
	ms__uploader_${onlyId}.bind('FileUploaded', function(uploader, file, result){
	
		if (result.status == 200){
			// 图片的服务器路径
			var imgUrl = result.response;
			$('#${imgId}').attr('src', '${basePath}/' + imgUrl);
		}
		else{
			$('.ms-notifications').offset({top:43}).notify({
				type:'success',
				message: { text:'上传失败，请求返回码:' + result.status }
			}).show();
		}
		
		<#if callback != "" > 
			eval("${callBack}(result)");
		</#if>
	});

</script>
</#macro>
