<#--简易编辑器-->
<#--name:输入框名称-->
<#--width\height:编辑器的宽度高度-->
<#--content:初始化内容-->
<#macro editor name label=""  content="" validation="" width="100%" height="480" labelStyle="" appId="" help="" helpDirection=""> 
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>	
	<div class="ms-form-control ms-from-group-input col-sm-9 has-feedback">
	<script type="text/plain" id="editor_${name}" name="${name}" style="width:${width}px;height:${height}px">${content?default('')}</script>
	<script type="text/javascript">
	
		//实例化编辑器
		//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
		//  var ue = UE.getEditor('editor_${name}');
       var URL = window.UEDITOR_HOME_URL || "${basePath}/ueditor_1_4_3_1/";
	   var ue = UE.getEditor('editor_${name}', {
       		imageScaleEnabled :true,
       		// 服务器统一请求接口路径
       		serverUrl: URL + "jsp/msController.jsp?jsonConfig={imageUrlPrefix:'${base}',imagePathFormat:'/upload/editor/${appId?default(0)}/{time}',filePathFormat:'/upload/editor/${appId}/{time}',videoPathFormat:'/upload/editor/${appId}/{time}'}", 
	   		toolbars: [
				['bold', 'fontsize', 'blockquote', 'removeformat','forecolor', 'emotion', 'justifyleft', 'justifycenter', 'justifyright', 'link', 'unlink', 'simpleupload', 'insertimage', 'insertvideo', 'inserttable', 'deletetable', 'attachment', 'insertcode', 'source','fullscreen']
			],
			autoHeightEnabled: true,
			autoFloatEnabled: true,
			scaleEnabled: true,
        	compressSide:0,
        	maxImageSideLength:2000,
			maximumWords: 80000,
		});
                                                                
	</script>
	</div>
</div>
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
