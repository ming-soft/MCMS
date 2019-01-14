<#-- 树形控件,以input下拉框的形式显示(官网:http://www.ztree.me/v3/main.php#_zTreeInfo) -->
<#-- treeId(必须):树形加载和控制区域的ID,一张页面同时加载多个树形时必须用该值进行区分 -->
<#-- json(必须):需要加载成树形的数据,数据结构为:[{categoryId:1,categoryCategoryId:0,categoryTitle:""},{categoryId:2,categoryCategoryId:1,categoryTitle:""}] -->
<#-- jsonId(必须):json数据中ID名称,如:categoryId -->
<#-- jsonPid(必须):json数据中关联的父ID,如:categoryCategoryId -->
<#-- jsonName(必须):json数据中需要显示的数据名称,如:categoryTitle -->
<#-- jsonUrl:如过json数据中存在跳转地址则直接将字段名称填入点击树形时可自动跳转 -->
<#-- addNodesName:增加顶级根节点,直接传入根节点名称即可。如:顶级分类 -->
<#-- buttonText:选择框加载的默认提示信息 -->
<#-- inputName(必须):隐藏input框的name值,用于保存选中数据的ID -->
<#-- inputValue:隐藏input框的val默认值,适用用于加载初始化数据 -->
<#-- inputId:隐藏input框的id值,用于保存选中数据的ID -->
<#-- selectParent:用户选择父节点时的提示信息，当该值存在时，用户不能选择存在子节点的父节点，并提示传入的值，当该值不存在时用户可以选择任意 -->
<#-- clickZtreeId: 选择节点后触发的事件-->
<#-- expandAll:控制节点数据显示的时候是全部展开还是全部折叠(true[默认]:全部展开,false:全部折叠)。 -->
<#-- showIcon:是否显示文件夹图标,true:显示;false(默认)：不显示 -->
<#-- 内置函数调用方法说明：
				调用对象的函数名:	zTreeObj${treeId}(treeId为自定义的ID名称);
					/**
					 * 根据节点数据的属性搜索，获取条件完全匹配的单一节点数据 JSON 对象
					 * 如有重复则返回最近的一条。
					 * @param key:需要精确匹配的属性名称
					 * @param value:需要精确匹配的属性值，可以是任何类型，只要保证与 key 指定的属性值保持一致即可
					 * @param parentNodeJSON:搜索范围，指定在某个父节点下的子节点中进行搜索忽略此参数，为null时表示在全部节点中搜索
					 * @return JSON
					 */
					zTreeObj${treeId}.getNodeByParam(key,value,parentNode);
					
					/**
					 * 获取根节点数据,既获取PID=0的数据集合
					 * @return ArrayList(json)
					 */
					 zTreeObj${treeId}.getNodes();
					 
					 /**
					  * 根据节点数据的属性搜索，获取条件完全匹配的节点数据 JSON 对象集合
					  * @param key:需要精确匹配的属性名称
					  * @param value:需要精确匹配的属性值，可以是任何类型，只要保证与 key 指定的属性值保持一致即可
					  * @param parentNode:可以指定在某个父节点下的子节点中搜索，为null时表示在全部节点中搜索
					  * @return ArrayList(json)
					  */
					  zTreeObj${treeId}.getNodesByParam(key,value,parentNode);
-->		 
<#--废弃，推荐使用inputTree 参考input_tree.ftl--> 
<#macro treeInput treeId=""  json="" jsonId="" jsonPid="" jsonName="" jsonUrl="" addNodesName="" buttonText="" inputName="" inputValue="" inputId="" selectParent="" clickZtreeId="" expandAll="true" showIcon="false" >
	<!-- css样式开始 -->
	<style type="text/css">
		.ztree${treeId}{width:100%;max-height: 240px;overflow:auto;}
		.ztree${treeId} li a{padding:0}
	</style>	
	<!-- css样式结束 -->


	<!-- 初始化样式开始 -->
	<div class="dropdown" id="${treeId}">
		<button type="text" id="treeLabel${treeId}" class="form-control dropdown-toggle" data-toggle="dropdown" aria-expanded="true" style="text-align:left">
			${buttonText?default('请选择')}
		</button>
		<input type="hidden" <#if inputName?has_content>name="${inputName}"</#if> <#if inputId?has_content>id="${inputId}"</#if> value="${inputValue?default(0)}">
		<ul class="ztree ztree${treeId} dropdown-menu" role="menu" id="treeDome${treeId}" aria-labelledby="treeLabel${treeId}">
		</ul>
	</div>
	<!-- 初始化样式结束 -->
	
	<!-- js操作方法开始 input -->	
	<script>
		//初始化树形数据
		var zNodes${treeId} = <#if json?has_content>${json}<#else>[]</#if>;
		
		//初始化树形结构
		var setting${treeId} = {
			view:{//控制视图
				fontCss:{"white-space":"normal","display":"initial","word-break":"break-all"},
				showIcon:${showIcon},//是否显示节点文件夹图标
				showLine:true,//是否显示借点连接线
				expandSpeed:"",//折叠时的动画速度,参考jquery中动画效果的speed参数,三种预定速度之一的字符串("slow", "normal", or "fast")
			},
			data: {//控制显示数据
				simpleData: {
					enable: true,//是否采用简单数据模式 (Array)
					idKey:"${jsonId}",//节点ID名称
					pIdKey:"${jsonPid}",//父节点ID名称
				},
				key:{
					name:"${jsonName}",//节点数据保存节点名称的属性名称。
					url:"${jsonUrl}",//节点跳转地址属性
				}
			},
			callback: {//控制获取选择的节点数据
				beforeClick:<#if selectParent?has_content>beforeClick${treeId}<#else>null</#if>,//用于捕获单击节点之前的事件回调函数，并且根据返回值确定是否允许单击操作
				onClick:getZtreeId${treeId},//用于捕获节点被点击的事件回调函数
			},
			check:{//控制节点的选中方式(暂时未启用,根据后期需求再做调整)
				autoCheckTrigger:true,//是否触发自动勾选
				enable:false,//节点上是否显示选择框,false:不显示,true:显示。
				chkStyle:"checkbox",//勾选框类型(checkbox[默认值] 或 radio)
				chkboxType:{"Y":"ps","N":"ps"},//设置勾选关联关系
			},
		};	
		
		var zTreeObj${treeId}="";
		$(function(){
			//自定义顶级栏目
			<#if addNodesName?has_content>
				zNodes${treeId}[zNodes${treeId}.length] = {${jsonName}:"${addNodesName}",${jsonId}:0,${jsonPid}:0};
			</#if>
			
			//加载树形
			$.fn.zTree.init($("#treeDome${treeId}"),setting${treeId},zNodes${treeId});	
			
			//zTree内部函数对象,主要用户调用zTree内部方法
			zTreeObj${treeId} = $.fn.zTree.getZTreeObj("treeDome${treeId}");
			
			//展开(true)/折叠(false)全部节点(zTree内部方法)
			zTreeObj${treeId}.expandAll(${expandAll});

			//加载默认节点
			<#if inputValue?has_content>
				zTreeObj${treeId}.selectNode(zTreeObj${treeId}.getNodeByParam("${jsonId}",${inputValue},null));
			</#if>
			
			//当属性为折叠时，控制下拉菜单的开启和关闭
			<#if expandAll = "false">
				$("body").on("click",function(e) {
			        e = window.event || e; // 兼容IE7
			        
			        //获取当前点击事件对象
			        var objZtree = $(e.srcElement||e.target);
			        
			        //获取当前点击事件ID,并对点击的子节点ID进行切割获取自定义ID
			        var objZtreeId = objZtree.attr("id");
			        
			        //当用户点击选择框时还原下拉框属性
			        if(objZtreeId != undefined && objZtreeId.split("_")[0] == "treeLabel${treeId}"){
			        	$("#treeDome${treeId}").attr("style","");
			        	return ;
			        }
			        
			        //切割获取到的ID判断点击事件是否产生在下拉框
			        if(objZtreeId != undefined && objZtreeId.split("_")[0] == "treeDome${treeId}"){
			        	$("#treeDome${treeId}").attr("style","display:block");
			        }else{
			        	$("#treeDome${treeId}").attr("style","display:none");
			        }
				});
			</#if>
			
		});
		
		<#if selectParent?has_content>
			//对节点选择进行限制，用户只能选择子节点
			function beforeClick${treeId}(treeId,treeNode) {
				var check = (treeNode && !treeNode.isParent);
				if (!check){
					$("#treeLabel${treeId}").text("${selectParent}");
				};
				return check;
			}		
		</#if>
		
		//获取树形中选中的值,将选择值加载到隐藏框中
		function getZtreeId${treeId}(event,treeId,treeNode){
			var booleanClick = true;
			//用于捕获节点被点击的事件回调函数
			<#if clickZtreeId?has_content>
				booleanClick=${clickZtreeId};
			</#if>
			if(booleanClick==false){
				return;
			}
			//将用户选择数据ID加载到隐藏框
			$("#${treeId} input[name='${inputName}']").val(treeNode.${jsonId});
			//将用户选择数据的名称加载到输入框
			$("#treeLabel${treeId}").text(treeNode.${jsonName});
			
		}
	</script>
	<!-- js操作方法结束 -->
</#macro>

<#------------------------------------------------------------------------------------------------------------------------------------------------------------------>

<#-- 
	getZtreeId:外部重写JS方法：
		/**
		 * 外部点击树形节点时触发的事件，(传入参数必须与下述参数名保持一致)
		 * event:获取到的触发事件
		 * treeId:载体ID,这里为:treeDome${treeId}
		 * treeNode:内置函数对象，这里可直接调用内置函数方法
		 *				treeNode.${jsonId}:获取点击的树形节点的ID
		 *				treeNode.${jsonName}:获取点击树形节点的名称
		 *				.....
		 */
		getZtreeId${treeId}(event,treeId,treeNode);
-->
<#-- 树形控件,以input下拉框的形式显示(官网:http://www.ztree.me/v3/main.php#_zTreeInfo) -->
<#-- treeId(必须):树形加载和控制区域的ID,一张页面同时加载多个树形时必须用该值进行区分 -->
<#-- json(必须):需要加载成树形的数据,数据结构为:[{categoryId:1,categoryCategoryId:0,categoryTitle:""},{categoryId:2,categoryCategoryId:1,categoryTitle:""}] -->
<#-- jsonId(必须):json数据中ID名称,如:categoryId -->
<#-- jsonPid(必须):json数据中关联的父ID,如:categoryCategoryId -->
<#-- jsonName(必须):json数据中需要显示的数据名称,如:categoryTitle -->
<#-- jsonUrl:如过json数据中存在跳转地址则直接将字段名称填入点击树形时可自动跳转 -->
<#-- addNodesName:增加顶级根节点,直接传入根节点名称即可。如:顶级分类 -->
<#-- expandAll:控制节点数据显示的时候是全部展开还是全部折叠(true[默认]:全部展开,false:全部折叠)。 -->
<#-- showIcon:是否显示文件夹图标,true:显示;false(默认)：不显示 -->
<#-- 内置函数调用方法说明：
				调用对象的函数名:	zTreeObj${treeId}(treeId为自定义的ID名称);
					/**
					 * 根据节点数据的属性搜索，获取条件完全匹配的单一节点数据 JSON 对象
					 * 如有重复则返回最近的一条。
					 * @param key:需要精确匹配的属性名称
					 * @param value:需要精确匹配的属性值，可以是任何类型，只要保证与 key 指定的属性值保持一致即可
					 * @param parentNodeJSON:搜索范围，指定在某个父节点下的子节点中进行搜索忽略此参数，为null时表示在全部节点中搜索
					 * @return JSON
					 */
					zTreeObj${treeId}.getNodeByParam(key,value,parentNode);
					
					/**
					 * 获取根节点数据,既获取PID=0的数据集合
					 * @return ArrayList(json)
					 */
					 zTreeObj${treeId}.getNodes();
					 
					 /**
					  * 根据节点数据的属性搜索，获取条件完全匹配的节点数据 JSON 对象集合
					  * @param key:需要精确匹配的属性名称
					  * @param value:需要精确匹配的属性值，可以是任何类型，只要保证与 key 指定的属性值保持一致即可
					  * @param parentNode:可以指定在某个父节点下的子节点中搜索，为null时表示在全部节点中搜索
					  * @return ArrayList(json)
					  */
					  zTreeObj${treeId}.getNodesByParam(key,value,parentNode);
-->	
<#macro tree id="ztree${.now?string('yyyyMMddhhmmss')}" type="default" data=[] url="" idKey="" pIdKey="" text=""  label="" treeId="" json="" jsonId="" jsonPid="" jsonName="" jsonUrl="" validation="" addNodesName="" expandAll="true" showIcon="false" getZtreeId="" ischeck="false" help="">
<#if type="checkbox">
	<ul id="${id}" class="ztree"></ul>
	<SCRIPT type="text/javascript">
		<!--
		var ${id};
		ms.post("${url}",null,function(json){
			var setting = {
				check: {
					enable: true,
					chkboxType: { "Y" : "ps", "N" : "ps" }
				},		
				data: {
					simpleData: {
						enable: true,//是否采用简单数据模式 (Array)
						idKey:"${idKey}",//节点ID名称
						pIdKey:"${pIdKey}",//父节点ID名称
					},
					key:{
						name:"${text}"//节点数据保存节点名称的属性名称。
					}
				}
			};
			
			$(document).ready(function(){
				$.fn.zTree.init($("#${id}"), setting, json);
				${id} = $.fn.zTree.getZTreeObj("${id}");
				${id}.expandAll(true);
			});
			
		});
		//-->
	</SCRIPT>

<#elseif type=="default"> <#--默认调用方式在4.5.5将废弃-->
<!-- 初始化样式开始 -->
	<div class="form-group ms-form-group ">	
		<#include "control.ftl"/><#rt/>
		<div  class="ms-form-control <#if label!="">col-sm-9</#if>">	
			<ul class="ztree" id="treeDome${treeId}">
			</ul>
		</div>
	</div>
<!-- 初始化样式结束 -->
	
<!-- js操作方法开始 tree-->	
	<script>
		//初始化树形数据
		var zNodes${treeId} = ${json?default('[]')};
		var zTreeObj${treeId};
		//初始化树形结构
		var setting${treeId} = {
			view:{//控制视图
				fontCss:{"white-space":"normal","display":"initial","word-break":"break-all"},
				showIcon:${showIcon},//是否显示节点文件夹图标
				showLine:true,//是否显示借点连接线
				expandSpeed:"fast",//折叠时的动画速度,参考jquery中动画效果的speed参数,三种预定速度之一的字符串("slow", "normal", or "fast")
			},
			data: {//控制显示数据
				simpleData: {
					enable: true,//是否采用简单数据模式 (Array)
					idKey:"${jsonId}",//节点ID名称
					pIdKey:"${jsonPid}",//父节点ID名称
				},
				key:{
					name:"${jsonName}",//节点数据保存节点名称的属性名称。
					url:"${jsonUrl}",//节点跳转地址属性
				}
			},
			callback: {//控制获取选择的节点数据
				onClick:<#if getZtreeId?has_content>getZtreeId${treeId}<#else>null</#if>,//用于捕获节点被点击的事件回调函数
			},
			check:{//控制节点的选中方式(暂时未启用,根据后期需求再做调整)
				autoCheckTrigger:true,//是否触发自动勾选
				enable:${ischeck},//节点上是否显示选择框,false:不显示,true:显示。
				chkStyle:"checkbox",//勾选框类型(checkbox[默认值] 或 radio)
				chkboxType:{"Y":"ps","N":"ps"},//设置勾选关联关系
			},
		};	
		
		
		$(function(){
			//自定义顶级栏目
			<#if addNodesName?has_content>
				zNodes${treeId}[zNodes${treeId}.length] = {${jsonName}:"${addNodesName}",${jsonId}:0,${jsonPid}:0};
			</#if>
			
			//加载树形
			$.fn.zTree.init($("#treeDome${treeId}"),setting${treeId},zNodes${treeId});	
			
			//zTree内部函数对象,主要用户调用zTree内部方法
			zTreeObj${treeId} = $.fn.zTree.getZTreeObj("treeDome${treeId}");
			
			//展开(true)/折叠(false)全部节点(zTree内部方法)
			zTreeObj${treeId}.expandAll(${expandAll});
		});
		
		<#if getZtreeId?has_content>
			function getZtreeId${treeId}(event,treeId,treeNode){
				${getZtreeId};
			}
		</#if>
	</script>
<!-- js操作方法结束 -->

</#if>
</#macro>


<#-------------------------------------------------------------------------- -->
<#-- 树形控件,树形结构table 格式-->
<#-- tbodyId(必须) 需要进行委派的容器Id, 如要委派到tbody的id值-->
<#-- treeId(必须):树形加载和控制区域的ID,一张页面同时加载多个树形时必须用该值进行区分 -->
<#-- json(必须):需要加载成树形的数据,数据结构为:[{categoryId:1,categoryCategoryId:0,categoryTitle:""},{categoryId:2,categoryCategoryId:1,categoryTitle:""}] -->
<#-- jsonId(必须):json数据中ID名称,如:categoryId -->
<#-- jsonPid(必须):json数据中关联的父ID,如:categoryCategoryId -->
<#-- jsonName(必须):json数据中需要显示的数据名称,如:categoryTitle -->
<#-- tmplBefored是否插入节点图标之前 false不插入， true插入-->
<#-- #befored${treeId} 在节点图标之前需要插入列表属性，如果要使用必须tmplBefored="true"-->
<#-- #after${treeId}(必须) 在节点图标之后需要插入列表属性-->

<#-- 该结构中调用方法简略说明，如果需要其他更改，请添加方法：
	clickDome${treeId}，展开节点|关闭节点
	getChilds${treeId}，获取当前点击的子节点
	removeChilds${treeId}，/移除点击节点的所有子节点
-->

<#macro treeTable tbodyId="" treeId="" json="" jsonId="" jsonPid="" jsonName="" style="" tmplBefored="false">
	<ul class="ztreeTable" id="treeDome${treeId}" style="display:none">
	</ul>
	<!-- 列表HTML模版开始 -->
	<script id="treeTableTmpl${treeId}" type="text/x-jquery-tmpl">
		<tr data-id="{{= ${jsonId}}}"   id="columnTitle{{= ${jsonId}}}" >
			<td>{{= ${jsonId}}}</td>
			<#if tmplBefored== "true" >
				{{tmpl($data) '#befored${treeId}'}}
			</#if>
			<td>
				<a class="btn btn-xs red tooltips switch-list columnTitle" data-id="{{= ${jsonId}}}" onclick="clickDome${treeId}(this)" data-parentId="{{= ${jsonPid}}}" data-toggle="tooltip" data-original-title="查看子节点">
				 	<i class="glyphicon glyphicon-folder-close"></i>
				</a>
				{{= ${jsonName}}}
			</td>
			{{tmpl($data) '#after${treeId}'}}
		</tr> 
	</script>  
<!-- 列表HTML模版结束 -->
<!-- js操作方法开始 -->	
	<script>
		
		var zTreeObj${treeId};	//zTree内部函数对象变量,主要用户调用zTree内部方法
		
		//初始化树形结构
		var setting${treeId} = {
			data: {//控制显示数据
				simpleData: {
					enable: true,//是否采用简单数据模式 (Array)
					idKey:"${jsonId}",//节点ID名称
					pIdKey:"${jsonPid}",//父节点ID名称
				},
				key:{
					name:"${jsonName}",//节点数据保存节点名称的属性名称。
				}
			},
		};
		$(function(){
			//初始化树形数据
			var zNodes${treeId} = ${json?default('[]')};
			//加载树形
			$.fn.zTree.init($("#treeDome${treeId}"),setting${treeId},zNodes${treeId});	
			
			//zTree内部函数对象,主要用户调用zTree内部方法
			zTreeObj${treeId} = $.fn.zTree.getZTreeObj("treeDome${treeId}");
			
			//获取zTree中的数据对象
			var zTreeList = zTreeObj${treeId}.getNodes();
			
			//将内容委派到其中
			$("#treeTableTmpl${treeId}").tmpl(zTreeList).appendTo("#${tbodyId}");
			
			
		});
		
		//展开节点|关闭节点
		function clickDome${treeId}(obj){
			var columnId = $(obj).attr("data-id");//当前点击的节点
			var booleanBeging= true;	//用来处理是否展开/关闭节点
			$(".columnTitle").each(function(){	//判断是否存在子节点
				if($(this).attr("data-parentId")==columnId){
					booleanBeging=false;
					return false;
				}
			});
			//判断节点文件夹关闭图标是否存在，存在则显示打开的文件夹图标
			if($(obj).find(".glyphicon").hasClass("glyphicon-folder-close")){
				$(obj).find(".glyphicon").removeClass("glyphicon-folder-close");
				$(obj).find(".glyphicon").addClass("glyphicon-folder-open");
			}else if($(obj).find(".glyphicon").hasClass("glyphicon-folder-open")){//判断节点文件夹打开图标是否存在，存在则显示关闭的文件夹图标
				$(obj).find(".glyphicon").removeClass("glyphicon-folder-open")
				$(obj).find(".glyphicon").addClass("glyphicon-folder-close");
			}
			
			if(booleanBeging==true){
				getChilds${treeId}(columnId);//获取当前点击的子节点
			}else{
				removeChilds${treeId}(columnId);//移除点击节点的子节点
			}
		}
					
		//获取当前点击的子节点
		function getChilds${treeId}(jsonId){
			//拿到所有节点，比对该节点内是否存在父节点id跟当前点击节点id一致，累加到数组内容，循环完毕后委派到html内
			var rootNodes=zTreeObj${treeId}.getNodes();	//获取根节点
			var allNodes=zTreeObj${treeId}.transformToArray(rootNodes); //很据跟节点获取所有节点
			var selectNodes;	//选中的节点
			var arrayNodes = new Array();	//需要委派的节点
			for(var i=0;i<allNodes.length;i++){//将所有节点选中
				zTreeObj${treeId}.selectNode(allNodes[i],true);
			}
			selectNodes=zTreeObj${treeId}.getSelectedNodes();
			for(var j=0;j<selectNodes.length;j++){	//判断是否是当前点击的节点的子节点
				if(selectNodes[j].${jsonPid}== jsonId ){
					arrayNodes.push(selectNodes[j]);
				}
			}
			$("#treeTableTmpl${treeId}").tmpl(arrayNodes).insertAfter("#columnTitle"+jsonId);
			//文字首行缩进
			$(".columnTitle").each(function(){
				var id = $(this).attr("data-id");
				var curChilds = zTreeObj${treeId}.getNodesByParam("${jsonId}",id,null);
				var indent = curChilds[0].level;
				$(this).parents("td").css("text-indent",(indent*5)+"px");
			});
			
		}

		//移除点击节点的子节点
		function removeChilds${treeId}(jsonId){
			$(".columnTitle").each(function(){
				if($(this).attr("data-parentId")==jsonId){
					removeChilds${treeId}($(this).attr("data-id"));
					$("#columnTitle"+$(this).attr("data-id")).detach();
				}
			});
		}
	</script>
<!-- js操作方法结束 -->
</#macro>
