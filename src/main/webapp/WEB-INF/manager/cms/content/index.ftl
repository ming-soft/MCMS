<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>文章</title>
	<#include "../../include/head-file.ftl">
	<#include "../../include/increase-search.ftl">
</head>
<body style="overflow: hidden">
<div id="index"  v-cloak>
	<!--左侧-->
	<el-container class="index-menu">
		<div class="left-tree"></div>
		<iframe :src="action" class="ms-iframe-style">
		</iframe>
	</el-container>
</div>
</body>
</html>
<script>
	var indexVue = new Vue({
		el: "#index",
		data: {
			action:"", //跳转页面
		},
		methods:{
		},
		mounted(){
			this.action = ms.manager +"/cms/content/main.do";
		}
	})
</script>
<style>
	#index .index-menu {
		min-height: 100vh;
		min-width: 140px;
	}
	#index .ms-iframe-style {
		width: 100%;
		border: 0;
	}

	#index .index-menu .el-main {
		padding: 0;
	}
	#index .left-tree{
		min-height: 100vh;
		background: #fff;
		width: 180px;
		border-right: solid 1px #e6e6e6;
	}

	#index .index-menu .el-main .index-menu-menu .el-menu-item {
		min-width: 140px;
		width: 100%;
	}
	#index .index-menu .el-main .index-material-item {
		min-width: 100% !important
	}
	#index .index-menu-menu-item , .el-submenu__title {
		height: 40px !important;
		line-height: 46px !important;
	}
</style>
