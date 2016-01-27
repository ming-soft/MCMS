  <base target="mainFrame" />
  <#setting url_escaping_charset='utf-8'> 
  <#assign bootstrap="bootstrap-3.3.5-dist">
  <#assign static="http://static.ming-soft.net/">
  <#assign static_ver="4.5.6.min">
  <#assign ueditor_ver="ueditor_1_4_3_1"/>
  <meta content="IE=edge" http-equiv="X-UA-Compatible" /> 
  <meta name="viewport" content="width=device-width, initial-scale=1.0" /> 
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /> 
  <meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> 
  <link rel="stylesheet" type="text/css" href="${base}/css/animate.css" media="all" /> 
    
  <link rel="stylesheet" type="text/css" href="${base}/js/mobile/iconfont.css"/>
  <link rel="stylesheet" type="text/css" href="${base}/${bootstrap}/css/bootstrap.min.css" media="all" /> 
   <link rel="stylesheet" type="text/css" href="${base}/${bootstrap}/css/bootstrap-switch.css" media="all" /> 
  <link rel="stylesheet" type="text/css" href="${base}/${bootstrap}/css/bootstrapValidator.css" media="all" /> 
  <link rel="stylesheet" type="text/css" href="${base}/${bootstrap}/css/bootstrap-notify.css" media="all" />
  
  <!--time插件-->
    <link rel="stylesheet" type="text/css" href="${base}/css/bootstrap-datetimepicker.min.css" media="all" />
    
  <link rel="stylesheet" type="text/css" href="${static}/manager/ms.manager-${static_ver}.css?v=" media="all" />
  <link rel="stylesheet" type="text/css" href="${base}/jquery/zTree_v3/zTreeStyle.css" media="all" /> 
  <script type="text/javascript" src="${base}/jquery/jquery-1.10.2.min.js"></script> 
  <script type="text/javascript" src="${base}/jquery/zTree_v3/jquery.ztree.all-3.5.min.js"></script> 
  <script type="text/javascript" src="${base}/${bootstrap}/js/bootstrap.min.js"></script> 
  <script type="text/javascript" src="${base}/${bootstrap}/js/bootstrap-switch.min.js"></script>   
  <script type="text/javascript" src="${base}/${bootstrap}/js/bootstrapValidator.js"></script> 
  <script type="text/javascript" src="${base}/${bootstrap}/js/bootstrap-notify.js"></script>
  
  <script type="text/javascript" src="${base}/jquery/jquery.validate.min.js"></script>
 <script type="text/javascript" src="${base}/jquery/jquery.tmpl.min.js"></script>
 <!--时间插件-->
<link href="${base}/css/daterangepicker.css" rel="stylesheet">
<script type="text/javascript" src="${base}/jquery/moment.js"></script>
<script type="text/javascript" src="${base}/jquery/daterangepicker.js"></script>

<!--时间插件-->
<script type="text/javascript" src="${base}/jquery/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="${base}/jquery/bootstrap-datetimepicker/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>


  <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
  <!--[if lt IE 9]><script src="${base}/../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
  <script src="${base}/bootstrap3.0.3/ie-emulation-modes-warning.js"></script>
  <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
  <script src="${base}/bootstrap3.0.3/ie10-viewport-bug-workaround.js"></script>
   
   <!----上传图片--->
  	<script type="text/javascript" src="${basePath}/jquery/swfupload/swfupload.js"></script>
	<script type="text/javascript" src="${basePath}/jquery//swfupload/jquery.swfupload.js"></script>
 	 <script type="text/javascript" src="${basePath}/jquery//swfupload/fileprogress.js"></script>
    
     <script type="text/javascript" src="${basePath}/js/ms.web.js"></script>
    <script type="text/javascript" src="${basePath}/js/ms.validate.js"></script>
    <script type="text/javascript" src="${static}/manager/ms.manager.min.js?v=${static_ver}"></script>
    
       
<script type="text/javascript" src="${base}/jquery/bootstrap_select2/select2.min.js"></script> 
<link rel="stylesheet" href="${base}/jquery/bootstrap_select2/select2.css" type="text/css"> 
  <#include "/manager/include/macro.ftl"/>
  <script>
    var basePath = "${basePath}";
    var base = "${base}";
    $(function() {
    			//启用工具提示
		   	$("[data-toggle='tooltip']").tooltip();
		   	$("[data-toggle='popover']").popover({html:true});
    })
<#if manager_session?exists>
	var websiteId= "${manager_session.basicId?default('0')}" ;
</#if>
  </script>	
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	  <script src="${base}/https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	  <script src="${base}/https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
<style>

</style>
		<script type="text/javascript" charset="utf-8" src="${basePath}/${ueditor_ver}/ueditor.parse.js"></script>
		<script type="text/javascript" charset="utf-8" src="${basePath}/${ueditor_ver}/ueditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="${basePath}/${ueditor_ver}/ueditor.all.js"></script>
        <script type="text/javascript" charset="utf-8" src="${basePath}/${ueditor_ver}/lang/zh-cn/zh-cn.js"></script>
