<#-- 树形控件,以input下拉框的形式显示(官网:http://www.ztree.me/v3/main.php#_zTreeInfo) -->
<#-- treeId(必须):树形加载和控制区域的ID,一张页面同时加载多个树形时必须用该值进行区分 -->
<#-- json(必须):需要加载成树形的数据,数据结构为:[{categoryId:1,categoryCategoryId:0,categoryTitle:""},{categoryId:2,categoryCategoryId:1,categoryTitle:""}] -->
<#-- jsonId(必须):json数据中ID名称,如:categoryId -->
<#-- jsonPid(必须):json数据中关联的父ID,如:categoryCategoryId -->
<#-- jsonName(必须):json数据中需要显示的数据名称,如:categoryTitle -->
<#-- rootName:顶级根节点,直接传入根节点名称即可。如:顶级分类 -->
<#-- name(必须):隐藏input框的name与id值,用于保存选中数据的ID -->
<#-- value:隐藏input框的val默认值,适用用于加载初始化数据 -->
<#-- text:选择框加载的默认提示信息 -->
<#-- parent:是否可以选择父节点,false默认不允许，true允许 --> 
<#-- expandAll:控制节点数据显示的时候是全部展开还是全部折叠(true[默认]:全部展开,false:全部折叠)。 -->
<#-- showIcon:是否显示文件夹图标,true(默认):显示;false：不显示 -->
<#-- required:是否是必选项，true(默认)必选 false -->
<#-- onclick: 选择节点后触发的事件,会注入event,treeId,treeNode三个参数，参考ztree官方文档-->

<#macro inputTree treeId  json jsonId jsonPid jsonName name text
		rootName="" value=""  parent=false onclick="" expandAll="true" showIcon="true" 
		required=true >
	<!-- css样式开始 -->
	<style type="text/css">
		.ztree${treeId}{width:100%;max-height: 240px;overflow:auto;}
		.ztree${treeId} li a{padding:0}
		#${treeId} i{right:0}
	</style>	
	<!-- css样式结束 -->

	<!-- 初始化样式开始 -->
	<div class="dropdown" id="${treeId}">
		<button id="treeLabel${treeId}" class="form-control dropdown-toggle" data-toggle="dropdown" aria-expanded="true" style="text-align:left">
			${text?default('请选择')}
		</button>
		<input type="text" style="position: absolute;height:0;border: none;" <#if name?has_content>name="${name}" id="${name}"</#if> value="${value?default(0)}"
		<#if  required && validation?? && validation?has_content><#--验证框架，需要bootstrapValidator框架-->
			<#list validation?keys as key>
			${key}="${validation[key]}"<#rt/>
			</#list>
		<#elseif required>
			data-bv-between="true" data-bv-between-message="请选择！" data-bv-between-min="1" data-bv-between-max="99998" required  data-bv-notempty-message="请选择分类"
		</#if>
		/>
		<ul class="ztree ztree${treeId} dropdown-menu" role="menu" id="tree${treeId}" aria-labelledby="treeLabel${treeId}">
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
				}
			},
			callback: {//控制获取选择的节点数据
				beforeClick:<#if !parent>beforeClick${treeId}<#else>null</#if>,//用于捕获单击节点之前的事件回调函数，并且根据返回值确定是否允许单击操作
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
			<#if rootName?has_content>
				zNodes${treeId}[zNodes${treeId}.length] = {${jsonName}:"${rootName}",${jsonId}:0,${jsonPid}:0};
			</#if>
			
			//加载树形
			$.fn.zTree.init($("#tree${treeId}"),setting${treeId},zNodes${treeId});	
			
			//zTree内部函数对象,主要用户调用zTree内部方法
			zTreeObj${treeId} = $.fn.zTree.getZTreeObj("tree${treeId}");
			
			//展开(true)/折叠(false)全部节点(zTree内部方法)
			zTreeObj${treeId}.expandAll(${expandAll});

			//加载默认节点
			<#if value?has_content>
				var nodes = zTreeObj${treeId}.getNodeByParam("${jsonId}",${value},null)
				if (nodes!=null) {
					zTreeObj${treeId}.selectNode(nodes);
					$("#treeLabel${treeId}").text(nodes.${jsonName});
				}
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
			        	$("#tree${treeId}").attr("style","");
			        	return ;
			        }
			        
			        //切割获取到的ID判断点击事件是否产生在下拉框
			        if(objZtreeId != undefined && objZtreeId.split("_")[0] == "tree${treeId}"){
			        	$("#tree${treeId}").attr("style","display:block");
			        }else{
			        	$("#tree${treeId}").attr("style","display:none");
			        }
				});
			</#if>
			
		});
		
		<#if !parent>
			//对节点选择进行限制，用户只能选择子节点
			function beforeClick${treeId}(treeId,treeNode) {
				var check = (treeNode && !treeNode.isParent);
				if (!check){
					<@ms.notify msg="请选择该分类的子分类！" />
				};
				return check;
			}		
		</#if>
		
		//获取树形中选中的值,将选择值加载到隐藏框中
		function getZtreeId${treeId}(event,treeId,treeNode){
			var booleanClick = true;
			//用于捕获节点被点击的事件回调函数
			<#if onclick?has_content>
				booleanClick=${onclick}(event,treeId,treeNode);
			</#if>
			if(booleanClick==false){
				return;
			}
			//将用户选择数据ID加载到隐藏框
			$("#${treeId} input[name='${name}']").val(treeNode.${jsonId});
			<#if required>
			$("form:first").bootstrapValidator('revalidateField', '${name}');
			</#if>
			//将用户选择数据的名称加载到输入框
			$("#treeLabel${treeId}").text(treeNode.${jsonName});
			
		}
	</script>
	<!-- js操作方法结束 -->
</#macro>