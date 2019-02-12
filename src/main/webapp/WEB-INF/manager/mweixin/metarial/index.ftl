<!--图文素材页-->
<link rel="stylesheet" href="../../../static/mweixin/css/material-list.css">
<div id="material-list-vue" v-if="menuVue.menuActive == '图文'" class="ms-weixin-content">
	<el-container>
		<!--右侧头部-->
		<el-header class="ms-header" height="50px">
			<el-row>
				<el-button type="primary" size="small" icon="el-icon-plus" onclick="articleVue.open()">添加</el-button>
				<el-button class="ms-fr" size="small" icon="el-icon-refresh">刷新</el-button>
				<el-button class="ms-fr" size="small" @click='sync'>同步微信素材</el-button>
			</el-row>
		</el-header>
		<el-container>
			<!--内容头部-->
			<el-header class="ms-tr ms-header ms-header-select">
				<el-select v-model="value1" placeholder="请选择" size="small">
					<el-option v-for="item in options1" :key="item.value" :label="item.label" :value="item.value">
					</el-option>
				</el-select>
				<el-select v-model="value2" placeholder="请选择" size="small">
					<el-option v-for="item in options2" :key="item.value" :label="item.label" :value="item.value">
					</el-option>
				</el-select>
				<el-button type="primary" icon="el-icon-search" size="small" @click='search'>查询</el-button>
			</el-header>
			<!--素材列表-->
			<el-main class="ms-admin-material-list">
				<div class="ms-admin-material-item" v-for="(material,index) in materialList" :key='index'>
					<div class="head">
						<span v-text="'更新于'+formmateTime(material.newsDateTime)"></span>
						<i class="iconfont icon-weixin" v-if='material.newsIsSyn'></i>
					</div>
					<div class="body">
						<span v-text="material.newsArticle.basicTitle"></span>
						<img :src="material.newsArticle.basicThumbnails || ms.base+'/WEB-INF/manager/images/data/ms-bg_1.jpg'" />
						<p v-text="material.newsArticle.basicDescription"></p>
					</div>
					<div class="footer">
						<i class="el-icon-edit" @click="articleVue.open(material)"></i>
						<em></em>
						<i class="el-icon-delete" @click='del(material,index)'></i>
					</div>
				</div>
			</el-main>
		</el-container>
	</el-container>
</div>

<script>
	var materialListVue = new Vue({
		el: "#material-list-vue",
		data: {
			options1: [{
				value: '全部图片',
				label: '全部图片'
			}],
			options2: [{
				value: '全部图片',
				label: '全部图片'
			}],
			value1: '全部图片',
			value2: '',
			materialList: [],
		},
		methods: {
			// 获取微信素材
			newsList: function () {
				var that = this;
				ms.http.get(ms.manager + "/weixin/news/list.do")
					.then(function (res) {
						that.materialList = res.rows
						console.log('微信', res);
					}, function (err) {
						that.$message.error(err)
					})
			},
			// 删除
			del: function (material,index) {
				var that = this;
				ms.http.post(ms.manager + "/weixin/news/"+material.newsId+"/delete.do")
					.then(function (res) {
						if(res.result){
							that.$message.success('素材删除成功');
							that.materialList.splice(index,1);
						}
					}, function (err) {
						that.$message.error(err);
					})
			},
			// 同步微信素材
			sync: function () {

			},
			// 刷新图文素材
			refresh: function () {

			},
			// 查询
			search: function () {

			},
			// 格式化时间
			formmateTime: function (time) {
				var updateTime = /^[0-9]{4}-[0-9]{2}-[0-9]{2}/.exec(time)
				if (updateTime != null) {
					return updateTime[0]
				}
			}
		},
		mounted: function () {
			var that = this;
			// 微信图文素材
			that.newsList();
		}
	})
</script>