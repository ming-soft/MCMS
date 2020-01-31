<!DOCTYPE html>
<html>
<head>
	<title>分类</title>
		<#include "../../include/head-file.ftl">
	    <script src="${base}/static/plugins/clipboard/clipboard.js"></script>
</head>
<body>
	<div id="index" class="ms-index" v-cloak>
			<el-header class="ms-header" height="50px">
			<el-col :span="12">
				<@shiro.hasPermission name="cms:category:save">
				<el-button type="primary" icon="el-icon-plus" size="mini" @click="save()">新增</el-button>
				</@shiro.hasPermission>
				<@shiro.hasPermission name="cms:category:del">
				<el-button type="danger" icon="el-icon-delete" size="mini" @click="del(selectionList)"  :disabled="!selectionList.length">删除</el-button>
				</@shiro.hasPermission>
			</el-col>
			</el-header>
		<el-main class="ms-container">
			<el-table ref="multipleTable" :indent="6"
					  height="calc(100vh - 20px)"
					  border :data="dataList"
					  row-key="id"
					  v-loading="loading"
					  default-expand-all='true'
					  :tree-props="{children: 'children'}"
					  tooltip-effect="dark"
					  @selection-change="handleSelectionChange">
				<template slot="empty">
					{{emptyText}}
				</template>
				<el-table-column type="selection" width="40"></el-table-column>
				<el-table-column label="编号" width="120" prop="id">
					<template slot='header'>编号
						<el-popover placement="top-start" title="提示" trigger="hover" >
							<a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/nei-rong-biao-qian-ms-field.html" target="_blank">{ms:field.typeid/}</a>
							<a href="http://doc.ms.mingsoft.net/plugs-cms/biao-qian/lan-mu-lie-biao-ms-channel.html" target="_blank">[field.typeid/]</a>
							<i class="el-icon-question" slot="reference"></i>
						</el-popover>
					</template>
				</el-table-column>
                 <el-table-column label="标题" align="left" prop="categoryTitle">
                 </el-table-column>
            <el-table-column label="属性" align="center" prop="categoryType" :formatter="categoryTypeFormat" width="70">
            </el-table-column>
                <el-table-column label="链接地址" align="left" prop="categoryPath" show-overflow-tooltip>
					<template slot-scope="scope">
						<span style="cursor: pointer" class="copyBtn" :data-clipboard-text="'{ms:global.url/}'+scope.row.categoryPath+'/index.html'" @click="copyUrl">{{"{ms:global.url/}"+scope.row.categoryPath+"/index.html"}}</span>
					</template>
				</el-table-column>
            <el-table-column label="列表地址" align="left" prop="categoryListUrl" show-overflow-tooltip>
            </el-table-column>
            <el-table-column label="内容地址" align="left" prop="categoryUrl" show-overflow-tooltip>
				<template slot-scope="scope">
					{{scope.row.categoryType == '1'?scope.row.categoryUrl:''}}
				</template>
            </el-table-column>
            <el-table-column label="封面地址" align="left" prop="categoryUrl" show-overflow-tooltip>
				<template slot-scope="scope">
					{{scope.row.categoryType == '2'?scope.row.categoryUrl:''}}
				</template>
            </el-table-column>
					<el-table-column label="操作" width="120" align="center">
					<template slot-scope="scope">
						<@shiro.hasPermission name="cms:category:update">
						<el-link type="primary" :underline="false" @click="save(scope.row.id)">编辑</el-link>
						</@shiro.hasPermission>
						<@shiro.hasPermission name="cms:category:del">
						<el-link type="primary" :underline="false" @click="del([scope.row])">删除</el-link>
						</@shiro.hasPermission>
					</template>
					</el-table-column>
			</el-table>
         </el-main>
	</div>
</body>

</html>
<script>
	"use strict";

	var indexVue = new Vue({
		el: '#index',
		data: {
			dataList: [],
			//分类列表
			selectionList: [],
			//分类列表选中
			loading: true,
			//加载状态
			emptyText: '',
			//提示文字
			manager: ms.manager,
			loadState: false,
			categoryTypeOptions: [{
				"value": "1",
				"label": "列表"
			}, {
				"value": "2",
				"label": "封面"
			}],
			//搜索表单
			form: {
				// 栏目管理名称
				categoryTitle: '',
				// 所属栏目
				categoryId: '',
				// 栏目管理属性
				categoryType: '2',
				// 自定义顺序
				categorySort: 0,
				// 列表模板
				categoryListUrl: '',
				// 内容模板
				categoryUrl: '',
				// 栏目管理关键字
				categoryKeyword: '',
				// 栏目管理描述
				categoryDescrip: '',
				// 缩略图
				categoryImg: [],
				// 自定义链接
				categoryDiyUrl: '',
				// 栏目管理的内容模型id
				mdiyModelId: ''
			}
		},
		methods: {
			//查询列表
			list: function () {
				var that = this;
				this.loadState = false;
				this.loading = true;
				ms.http.get(ms.manager + "/cms/category/list.do", {
					pageSize: 999
				}).then(function (res) {
					if (that.loadState) {
						that.loading = false;
					} else {
						that.loadState = true;
					}

					if (!res.result || res.data.total <= 0) {
						that.emptyText = '暂无数据';
						that.dataList = [];
					} else {
						that.emptyText = '';
						that.dataList = ms.util.treeData(res.data.rows, 'id', 'categoryId', 'children');
					}
				}).catch(function (err) {
					console.log(err);
				});
				setTimeout(function () {
					if (that.loadState) {
						that.loading = false;
					} else {
						that.loadState = true;
					}
				}, 500);
			},
			copyUrl: function () {
				var clipboard = new ClipboardJS('.copyBtn');
				var self = this;
				clipboard.on('success', function (e) {
					self.$notify({
						title: '提示',
						message: "链接地址已保存到剪切板",
						type: 'success'
					});
					clipboard.destroy();
				});
			},
			//分类列表选中
			handleSelectionChange: function (val) {
				this.selectionList = val;
			},
			//删除
			del: function (row) {
				var that = this;
				that.$confirm('此操作将永久删除所选内容, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(function () {
					ms.http.post(ms.manager + "/cms/category/delete.do", row.length ? row : [row], {
						headers: {
							'Content-Type': 'application/json'
						}
					}).then(function (res) {
						if (res.result) {
							that.$notify({
								type: 'success',
								message: '删除成功!'
							}); //删除成功，刷新列表

							that.list();
						} else {
							that.$notify({
								title: '失败',
								message: res.msg,
								type: 'warning'
							});
						}
					});
				}).catch(function () {
					that.$notify({
						type: 'info',
						message: '已取消删除'
					});
				});
			},
			//表格数据转换
			categoryTypeFormat: function (row, column, cellValue, index) {
				var value = "";

				if (cellValue) {
					var data = this.categoryTypeOptions.find(function (value) {
						return value.value == cellValue;
					});

					if (data && data.label) {
						value = data.label;
					}
				}

				return value;
			},
			//新增
			save: function (id) {
				if (id) {
					location.href = this.manager + "/cms/category/form.do?id=" + id;
				} else {
					location.href = this.manager + "/cms/category/form.do";
				}
			},
			//重置表单
			rest: function () {
				this.$refs.searchForm.resetFields();
			}
		},
		created: function () {
			/* this.categoryListUrlOptionsGet();
             this.categoryUrlOptionsGet();*/
			this.list();
		}
	});
</script>
