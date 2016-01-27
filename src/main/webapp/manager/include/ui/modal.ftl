
<#--模态框按钮区域 废弃-->
<#macro modalButtonarea>
	<div class="modal-footer">
			<#nested/>
	</div>
</#macro>

<#--警告的模态框-->
<#macro warn  modalName>
	<div id="warn${modalName}Dialog" class="modal fade  ${modalName}" tabindex="-1" data-focus-on="input:first">
	 <div class="modal-dialog">
	    <div class="modal-content">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title"  id="warn${modalName}Title">警告！</h4>
		</div>
		<div class="modal-body"  id="warn${modalName}Body">
			<#nested/>
		</div>
		<div class="modal-footer">
			<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
			<button type="button"  id="warn${modalName}Ok" class="btn btn-primary right" >确定</button>
		</div>
		</div>
	 </div>
	</div>	
</#macro>

<#--模块框 modalName废弃属性-->
<#macro modal id="" title="标题" style="" height="300" resetFrom=true modalName="" size="S">
	<#if style!="">
		<#assign _style="${style}">
	<#elseif size=="S">
		<#assign _style="width:450px;height:150px;">
	<#elseif size=="M">
		<#assign _style="width:600px;height:500px;">
	<#elseif size=="L">
		<#assign _style="width:900px;height:650px;">
	</#if>
	<div class="modal fade ${modalName}${id}" id="${modalName}${id}" >
	  <div class="modal-dialog"  style="${_style};">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="${modalName}${id}Title">
	       	${title}
	        </h4>
	      </div>
		  <#nested/>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<script>
		
	<#if resetFrom>
		$(function(){
			$('#${modalName}${id}').on('hide.bs.modal', function (event) {
			  if ($("#${modalName}${id} form").length>0) {
			  	$("#${modalName}${id} form").data('bootstrapValidator').resetForm(true);
			  	$("#${modalName}${id} form")[0].reset();
			  }
			})	
		});
	</#if>
		
	</script>
</#macro>

<#--模态框内容-->
<#macro modalBody height="150">
	      <div class="modal-body" style="height:${height}px;min-height:50px;overflow-y: auto;">
	      	<#nested/>
	      </div>
</#macro>

<#--模态框按钮区域-->
<#macro modalButton>
	       <div class="modal-footer">
	      	<#nested/>
	      </div>
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


