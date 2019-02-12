<!-- 自定义菜单 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/custom-menu.css" />
<div id="custom-menu" class="ms-custom-menu ms-weixin-content" v-if="menuVue.menuActive == '自定义菜单'">
	<el-container class="ms-custom-container">
		<el-header class="ms-header" height="50px">
			<el-row>
				<el-button type="danger" size="small" icon="el-icon-delet">删除</el-button>
				<el-button size="small" @click="menuSort">菜单排序</el-button>
				<el-button class="ms-fr" size="small" icon="el-icon-refresh">重置</el-button>
				<el-button type="success" class="ms-fr" size="small" icon="el-icon-tickets">保存</el-button>
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
								<el-button type="primary" @click="openSubMenu(index,menu);menu.addSubMenuShow = !menu.addSubMenuShow;$forceUpdate()">{{
									menu.menuTitle }}</el-button>
								<div class="sub-menu-list" v-show="menu.addSubMenuShow">
									<!-- 子菜单 -->
									<el-button v-for="(sub,index) of currentSubMenuList" :key="index" v-text="sub.menuTitle" class="sub-menu-item"></el-button>
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
						<span>新建菜单</span>
					</div>
					<el-form ref="customMenuForm" :rule="customMenuFormRules" :model="customMenuForm" label-width="80px">
						<el-form-item label="菜单名称" prop="name" class="ms-custom-menu-name">
							<el-input v-model="customMenuForm.name" size="medium"></el-input>
							<span>菜单名称字数不多于5个汉字或10个字母</span>
						</el-form-item>
						<el-form-item label="菜单内容" class="ms-custom-menu-content">
							<el-input v-model="customMenuForm.link" size="medium"></el-input>
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
				name: "",
				link: ""
			},
			customMenuFormRules: {
				name: [{
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
				]
			},
			addMenuBtn: true, //添加菜单按钮
			activeName: "picture", //导航切换  当前激活面板
			mainMenuList: [],
			subMenuList: [],//所有的子菜单
			currentSubMenuList:[],//打开当前父菜单的子菜单列表
		},
		methods: {
			menuList: function () {
				var that = this;
				ms.http.get(ms.manager + "/mweixin/menu/list.do")
					.then((res) => {
						console.log('res菜单', res);
						res.rows && res.rows.forEach(function(item,index){
							item.menuMenuId == null && that.mainMenuList.push(item)
							item.menuMenuId != null && that.subMenuList.push(item)
						})
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
				if (this.subMenuList.length > 4) {
					return this.$message.error("子菜单最多5项");
				}
				this.subMenuList.push({
					menuTitle: "新建子菜单"
				});
			},
			openSubMenu(index,menu){
				this.closeAllSubMenu(index);
				this.$set(menu,'subMenuList',[])
				console.log('menu',menu);
				var that = this;
				that.currentSubMenuList = [];
				console.log('that.subMenuList',that.subMenuList);
				that.subMenuList.forEach(function(item,index){
					item.menuMenuId == menu.menuId && that.currentSubMenuList.push(item)
				})
			},
			// 关闭所有的子菜单弹出层
			closeAllSubMenu: function (num) {
				// 确保当前的菜单不被重置成false
				this.mainMenuList.forEach(function (item, index) {
					num != index && (item.addSubMenuShow = false)
				})
			}
		},
		mounted:function() {
			this.menuList();
		},
	});
</script>