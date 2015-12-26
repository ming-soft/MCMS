<#--自定义内容模型字段-->
<#--field:字段实体-->
<script type="text/javascript" src="${base}/jquery/moment.js"></script>
<script type="text/javascript" src="${base}/jquery/daterangepicker.js"></script>

<#include "/manager/include/macro.ftl"/>
<#macro field type name filedName value defaultValue isnull>
		
	   
		
</#macro>
<ul class="ztreeTable" id="treeDome" style="display:none"></ul>
	<!-- js操作方法开始 -->	
	<script>
		var zTreeObj;	//zTree内部函数对象变量,主要用户调用zTree内部方法
		
		//初始化树形结构
		var setting = {
			data: {//控制显示数据
				simpleData: {
					enable: true,//是否采用简单数据模式 (Array)
					idKey:"categoryId",//节点ID名称
					pIdKey:"categoryCategoryId",//父节点ID名称
				},
				key:{
					name:"categoryTitle",//节点数据保存节点名称的属性名称。
				}
			},
		};
		
		$(function(){
			////初始化树形数据
			var zNodes = ${categoryList?default('')};
			$.fn.zTree.init($("#treeDome"),setting,zNodes);	
			//zTree内部函数对象,主要用户调用zTree内部方法
			zTreeObj = $.fn.zTree.getZTreeObj("treeDome");
			//获取zTree中的数据对象
			var zTreeList = zTreeObj.getNodes();
			$("#selectTmpl").tmpl(zTreeList).appendTo("#type");
			$("#type").find("select").each(function(){
				getChilds($(this).attr("data-id"));
			});
		});
		
		//获取当前点击的子节点
		function getChilds(jsonId){
			//拿到所有节点，比对该节点内是否存在父节点id跟当前点击节点id一致，累加到数组内容，循环完毕后委派到html内
			var rootNodes=zTreeObj.getNodes();	//获取根节点
			var allNodes=zTreeObj.transformToArray(rootNodes); //很据跟节点获取所有节点
			var selectNodes;	//选中的节点
			var arrayNodes = new Array();	//需要委派的节点
			for(var i=0;i<allNodes.length;i++){//将所有节点选中
				zTreeObj.selectNode(allNodes[i],true);
			}
			
			selectNodes=zTreeObj.getSelectedNodes();
			for(var j=0;j<selectNodes.length;j++){	//判断是否是当前点击的节点的子节点
				if(selectNodes[j].categoryCategoryId== jsonId ){
					arrayNodes.push(selectNodes[j]);
				}
			}
			$("#optionTmpl").tmpl(arrayNodes).appendTo($("#type").find("select[data-id="+jsonId+"]"));
			<#if basicCategoryList?has_content>
				var selectedValue=${basicCategoryList?default('')};
				<#else>
				var selectedValue="";
			</#if>
			
			for(var j=0;j<selectedValue.length;j++){
				$("select[name=bcCategoryId]").find("option[value="+selectedValue[j].bcCategoryId+"]").attr("selected",true)
			}
			
		}
	</script>	
<div id="type" style="overflow:hidden;">
	
</div>
<!-- 列表HTML模版开始 -->
<script id="selectTmpl" type="text/x-jquery-tmpl">
	<div class="form-group " style="width:48%;margin-bottom:10px">
		<label  class="control-label">{{= categoryTitle}}</label>
		<select name="bcCategoryId" style="width:60%;" data-id="{{= categoryId}}"></select>
	</div>
</script>

<script id="optionTmpl" type="text/x-jquery-tmpl">
	<option value="{{= categoryId}}">{{= categoryTitle}}</option>
</script>
