<#--简易编辑器-->
<#--name:输入框名称-->
<#--width\height:编辑器的宽度高度-->
<#--content:初始化内容-->
<#macro editor name label=""  content="" validation="" width="100%" height="200" labelStyle=""> 
<div class="form-group ms-form-group">	
	<#include "control.ftl"/><#rt/>		
	<div style="float:left;">
	    <script type="text/plain" id="editor_${name}" name="${name}" style="width:${width};heigth:${height}">${content?default('')}</script>
	    
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
			color: #aaa;
			border-top: 0;
			width:  ${width};
		}
		</style>
	
		<script type="text/javascript">
				var charLimit = 80000;
		    	window.editor_${name} = new UE.ui.Editor({
					initialFrameHeight : ${height}
				});
				window.editor_${name}.render("editor_${name}");
		    	function computeChar() {
					var len = editor_${name}.getContent().length;
					if (len > charLimit) {
						$(".editor-bottom-bar").html("<span style='color:red;'>你输入的字符个数（"
								+ len + "）已经超出最大允许值！</span>")
					} else {
						$(".editor-bottom-bar").html("当前已输入<span class='char_count'>" + len
								+ "</span>个字符, 您还可以输入<span class='char_remain'>"
								+ (charLimit - len) + "</span>个字符。")
					}
				}
				
				window.editor_${name}.addListener("keyup", function(type, evt) {
					computeChar()
				})
				
				
		</script>
	</div>
</div>	
</#macro>