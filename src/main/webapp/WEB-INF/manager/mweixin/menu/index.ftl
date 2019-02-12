<!-- 自定义菜单 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/custom-menu.css" />
<div id="custom-menu" class="ms-custom-menu ms-weixin-content" v-if="menuVue.menuActive == '自定义菜单'">
	<el-container class="ms-custom-container">
		<el-header class="ms-header" height="50px">
			<el-row>
				<el-button type="danger" size="small" icon="el-icon-delet" @click='menuDel'>删除</el-button>
				<el-button size="small" @click="menuSort">菜单排序</el-button>
				<el-button class="ms-fr" size="small" icon="el-icon-refresh" @click='resetForm'>重置</el-button>
				<el-button type="success" class="ms-fr" size="small" icon="el-icon-tickets" @click='menuSave'>保存</el-button>
				<el-button type="success" class="ms-fr" size="small" icon="el-icon-tickets" @click='menuCreate'>发布菜单</el-button>
			</el-row>
		</el-header>
		<el-container class="ms-container">
			<el-aside>
				<el-container>
					<el-header>公众号</el-header>
					<el-main></el-main>
					<el-footer>
						<el-button icon="el-icon-date"></el-button>
						<div class="ms-create-menu">
							<div class="ms-create-sub-menu" v-for="(menu,index) of mainMenuList" :key="index">
								<!-- 父菜单 -->
								<el-button type="primary" @click="openSubMenu(index,menu);menu.addSubMenuShow = !menu.addSubMenuShow;$forceUpdate()">{{
									menu.menuTitle }}</el-button>
								<div class="sub-menu-list" v-show="menu.addSubMenuShow">
									<!-- 子菜单 -->
									<el-button v-for="(sub,index) of currentSubMenuList" :key="index" v-text="sub.menuTitle" class="sub-menu-item"
									 @click='customMenuForm = sub;$forceUpdate();'></el-button>
									<!-- 添加子菜单的加号按钮 -->
									<el-button icon="el-icon-plus" class="ms-create-btn" @click="addSubMenu"></el-button>
								</div>
							</div>
							<!-- 添加父菜单的加号按钮 -->
							<el-button icon="el-icon-plus" @click="addMenu" v-show="addMenuBtn && mainMenuList.length<3" class="add-menu"></el-button>
						</div>
					</el-footer>
				</el-container>
			</el-aside>
			<el-main>
				<el-card class="custom-menu-card" shadow="never">
					<div slot="header" class="clearfix">
						<span v-text="customMenuForm.menuId ? '修改菜单' : '新建菜单'"></span>
					</div>
					<el-form ref="customMenuForm" :rules="customMenuFormRules" :model="customMenuForm" label-width="81px">
						<el-form-item label="菜单名称" prop="menuTitle" class="ms-custom-menu-name">
							<el-input v-model="customMenuForm.menuTitle" size="medium"></el-input>
							<span>菜单名称字数不多于5个汉字或10个字母</span>
						</el-form-item>
						<el-form-item label="菜单内容" class="ms-custom-menu-content" prop='menuUrl'>
							<el-input v-model="customMenuForm.menuUrl" size="medium"></el-input>
							<span>请输入菜单地址</span>
							<!-- <el-tabs v-model="activeName" @tab-click="">
								<el-tab-pane label="图片" name="picture">
									<span slot="label">
										<i class="el-icon-picture"></i>图片</span>
									<div onclick="materialBankFormVue.open()">
										<i class="el-icon-picture-outline"></i>
										<span>从素材库选择</span>
									</div>
									<div onclick="newPicFormVue.open()">
										<i class="el-icon-plus"></i>
										<span>新建图片</span>
									</div>
								</el-tab-pane>
								<el-tab-pane label="图文管理" name="article">
									<span slot="label">
										<i class="el-icon-picture"></i>图文管理</span>
									<div onclick="materialBankFormVue.open()">
										<i class="el-icon-picture-outline"></i>
										<span>从素材库选择</span>
									</div>
									<div onclick="newPicFormVue.open()">
										<i class="el-icon-plus"></i>
										<span>新建图文</span>
									</div>
								</el-tab-pane>
							</el-tabs> -->
						</el-form-item>
					</el-form>
				</el-card>
			</el-main>
		</el-container>
	</el-container>
</div>
<script>
	var customMenuVue = new Vue({
		el: "#custom-menu",
		data: {
			customMenuForm: {
				menuTitle: "",
				menuUrl: "",
				menuId: "",
				menuMenuId: "", //父菜单编号
				menuStatus: "", //菜单状态 0：不启用 1：启用
				menuStyle: "", //类型：1文本 2图文 4外链接
				menuType: "", //菜单属性 0:链接 1:回复
			},
			customMenuFormRules: {
				menuTitle: [{
						required: true,
						message: "请输入菜单名称",
						trigger: ["blur", "change"]
					},
					{
						min: 1,
						max: 5,
						message: "长度在 1 到 5 个字符",
						trigger: ["blur", "change"]
					}
				],
				menuUrl: [{
					required: true,
					message: '请输入菜单地址',
					trigger: 'change'
				}, {
					validator: function (rule, value, callback) {
						/^(http|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?$/.test(value) ?
							callback() : callback('链接不合法')
					}
				}]
			},
			addMenuBtn: true, //添加菜单按钮
			activeName: "picture", //导航切换  当前激活面板
			mainMenuList: [],
			subMenuList: [], //所有的子菜单
			currentSubMenuList: [], //打开当前父菜单的子菜单列表
			currentMenuMenuId: '', //打开当前父菜单的菜单ID
		},
		methods: {
			menuList: function () {
				var that = this;
				ms.http.get(ms.manager + "/mweixin/menu/list.do")
					.then((res) => {
						console.log('res菜单', res);
						that.mainMenuList = []
						that.subMenuList = []
						res.rows && res.rows.forEach(function (item, index) {
							item.menuMenuId == null && that.mainMenuList.push(item)
							item.menuMenuId != null && that.subMenuList.push(item)
						})
						// 初始化显示第一个菜单
						if(that.mainMenuList.length){
							that.customMenuForm = that.mainMenuList[0]
						}else{
							that.mainMenuList.push(that.customMenuForm)
							// 没有一个菜单的时候
							that.mainMenuList[0].menuTitle = '新建菜单'
						}
					}, (err) => {
						console.log(err)
					})
			},
			// 菜单排序
			menuSort: function () {
				event.target.innerText = "完成";
			},
			// 添加菜单
			addMenu: function () {
				this.mainMenuList.push({
					menuTitle: "新建菜单"
				});
				this.$nextTick(function () {
					var that = this;
					Array.prototype.forEach.call(
						document.querySelectorAll(".ms-create-sub-menu"),
						function (item, index) {
							item.style.width = '80px';
						}
					);
					document.querySelector(".add-menu").style.width = '80px';
				});
				if (this.mainMenuList.length == 3) {
					return (this.addMenuBtn = false);
				}
			},
			// 添加子菜单
			addSubMenu: function () {
				if(!this.currentMenuMenuId){
					return this.$message.error("创建子菜单前，必须先创建父菜单");
				}
				if (this.currentSubMenuList.length > 4) {
					return this.$message.error("子菜单最多5项");
				}
				var that = this;
				console.log('that.currentMenuMenuId', that.currentMenuMenuId);
				this.currentSubMenuList.push({
					menuTitle: "新建子菜单",
					menuMenuId: that.currentMenuMenuId,
				});
				console.log('currentSubMenuList', this.currentSubMenuList);
			},
			openSubMenu(index, menu) {
				console.log('menu', menu);
				var that = this;
				that.customMenuForm = menu
				that.closeAllSubMenu(index);
				that.currentSubMenuList = [];
				that.currentMenuMenuId = menu.menuId;
				console.log('that.subMenuList', that.subMenuList);
				that.subMenuList.forEach(function (item, index) {
					item.menuMenuId == menu.menuId && that.currentSubMenuList.push(item)
				})
			},
			// 关闭所有的子菜单弹出层
			closeAllSubMenu: function (num) {
				// 确保当前的菜单不被重置成false
				this.mainMenuList.forEach(function (item, index) {
					num != index && (item.addSubMenuShow = false)
				})
			},
			// 保存菜单
			menuSave: function () {
				// 表单校验
				var that = this;
				this.$refs.customMenuForm.validate(function (ispass, object) {
					if (ispass) {
						// 判断保存的菜单类型，这里先简单处理，写死
						that.customMenuForm.menuStatus = 1
						that.customMenuForm.menuStyle = 4 //类型：1文本 2图文 4外链接
						that.customMenuForm.menuType = 0 //菜单属性 0:链接 1:回复
						ms.http.post(ms.manager + "/mweixin/menu/save.do", that.customMenuForm)
							.then(function (res) {
								that.customMenuForm.menuStatus = that.customMenuForm.menuStyle = that.customMenuForm.menuType = ''
								if(res.menuId){
									that.$message.success('菜单保存成功')
									that.menuList();
								}else{
									that.$message.error(res.resultMsg)
								}
							}, function (err) {
								console.log(err)
							})
					}
				})
			},
			// 删除菜单
			menuDel: function () {
				var that = this;
				// 当存在子菜单的时候，不得删除菜单
				if(that.customMenuForm.menuMenuId == null && that.currentSubMenuList.length){
					return that.$message.error('当前菜单存在子菜单，不得删除')
				}
				if(!that.customMenuForm.menuId){
					return that.$message.error('请新建菜单之后，再进行删除')
				}
				this.$confirm('此操作将永久删除该菜单, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					ms.http.post(ms.manager + "/mweixin/menu/delete.do", {
							ids: that.customMenuForm.menuId
						})
						.then(function (res) {
							that.$message({
								type: 'success',
								message: '删除成功!'
							});
							// 清空表单值
							that.resetForm();
							// 刷新菜单列表
							that.menuList();
						}, function (err) {
							console.log(err)
						})
				}).catch(() => {
					this.$message({
						type: 'info',
						message: '已取消删除'
					});
				})
			},
			// 发布菜单
			menuCreate: function () {
				var that = this;
				this.$confirm('此操作将发布公众号菜单, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					ms.http.get(ms.manager + "/mweixin/menu/create.do")
						.then(function (res) {
							if(res.result){
								that.$message({
									type: 'success',
									message: '发布成功!，菜单将于2小时后生效'
								});
							}else{
								that.$message({
									type: 'error',
									message: '发布失败！'
								});
							}
						}, function (err) {
							console.log(err)
						})
				}).catch(() => {
					this.$message({
						type: 'info',
						message: '已取消删除'
					});
				})
			},
			// 重置
			resetForm:function(){
				// this.$refs.customMenuForm.resetFields();未在表单中，清空不了
				this.customMenuForm.menuStatus = 
				this.customMenuForm.menuStyle = 
				this.customMenuForm.menuType = 
				this.customMenuForm.menuTitle = 
				this.customMenuForm.menuUrl = 
				''
			}
		},
		mounted: function () {
			this.menuList();
		},
	});
</script>