<!-- 消息回复 && 关注回复 -->
<link rel="stylesheet" href="../../../../static/mweixin/css/message-reply.css">
<div id="message-reply" class="ms-message-reply ms-weixin-content" v-if="menuVue.menuActive == '消息回复'||menuVue.menuActive == '关注时回复'">
	<el-container class="ms-admin-message-reply">
		<el-header class="ms-header" height="50px">
			<el-row>
				<el-button class="ms-fr" size="small" icon="el-icon-refresh">重置</el-button>
				<el-button type="success" class="ms-fr" size="small" icon="el-icon-tickets">保存</el-button>
			</el-row>
		</el-header>
		<el-container>
			<el-header class="ms-tr ms-header">
				<el-input size="medium" placeholder="请输入内容" suffix-icon="el-icon-search">
				</el-input>
			</el-header>
			<em-main class="ms-container">
				<div>回复内容</div>
				<el-tabs v-model="activeName" @tab-click="" class="message-reply-tabs">
					<el-tab-pane label="文字" name="text">
						<el-form ref="messageReplyForm" :rules='messageReplyFormRules' :model="messageReplyForm">
							<el-form-item class="ms-message-reply-content">
								<el-input type="textarea" v-model="messageReplyForm.reply" :autosize="{ minRows: 4, maxRows: 4}" resize='none'>
								</el-input>
								<i class="el-icon-delete" @click="messageReplyForm.reply = ''"></i>
								<div class="footer">
									<i class="el-icon-star-off"></i>
									<!-- 插入超链接 -->
									<el-popover placement="top-start" width="350" trigger="click" v-model='popoverShow'>
										<el-form label-width="81px" :model="hyperlinkForm" ref="hyperlinkForm" :rules='hyperlinkRule'>
											<el-form-item label="文本内容" prop='text'>
												<el-input v-model="hyperlinkForm.text" size='mini'></el-input>
											</el-form-item>
											<el-form-item label="链接地址" prop='link'>
												<el-input v-model="hyperlinkForm.link" size='mini'></el-input>
											</el-form-item>
											<el-form-item style="margin:0">
												<el-row type='flex' justify='end'>
													<el-col span='6'>
														<el-button type="primary" @click="saveLink" size='mini'>保存</el-button>
													</el-col>
													<el-col span='6'>
															<el-button @click="cancelLink" size='mini'>取消</el-button>
													</el-col>
												</el-row>
											</el-form-item>
										</el-form>
										<a slot="reference">插入超链接</a>
									</el-popover>
								</div>
							</el-form-item>
						</el-form>
						</el-form>
					</el-tab-pane>
					<el-tab-pane label="图片" name="picture" class="message-reply-picture">
						<div onclick="materialBankFormVue.open()">
							<i class="el-icon-picture-outline"></i>
							<span>从素材库选择</span>
						</div>
						<div onclick="newPicFormVue.open()">
							<i class="el-icon-plus"></i>
							<span>新建图片</span>
						</div>
					</el-tab-pane>
					<el-tab-pane label="图文" name="article" class="message-reply-article">
						<div onclick="materialBankFormVue.open()">
							<i class="el-icon-picture-outline"></i>
							<span>从素材库选择</span>
						</div>
						<div onclick="newPicFormVue.open()">
							<i class="el-icon-plus"></i>
							<span>新建图文</span>
						</div>
					</el-tab-pane>
				</el-tabs>
			</em-main>
		</el-container>
	</el-container>
</div>
<script>
	var messageReplyVue = new Vue({
		el: "#message-reply",
		data: {
			messageReplyForm: {
				reply: '',
			},
			messageReplyFormRules: {
				name: [{
						required: true,
						message: '请输入菜单名称',
						trigger: ['blur', 'change']
					},
					{
						min: 1,
						max: 5,
						message: '长度在 1 到 5 个字符',
						trigger: ['blur', 'change']
					}
				],
			},
			activeName: 'text',
			// 超链接
			hyperlinkForm: {
				text: "",
				link: "",
			},
			hyperlinkRule: {
				text: [{
						required: true,
						message: '请输入超链接显示的文本内容',
						trigger: 'blur'
					},
					{
						min: 1,
						max: 50,
						message: '长度在 1 到 50 个字符',
						trigger: 'blur'
					}
				],
				link: [{
					required: true,
					message: '请输入超链接地址',
					trigger: 'change'
				}, {
					validator: function (rule, value, callback) {
						/^(http|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?$/.test(value) ?
							callback() : callback('链接不合法')
					}
				}],
			},
			popoverShow:false,//弹出层显示与否的状态值
		},
		methods: {
			// 保存超链接
			saveLink: function () {
				var that = this;
				that.$refs.hyperlinkForm.validate(function (boolean,object) {
					if(boolean){
						// 校验成功
						that.messageReplyForm.reply = that.messageReplyForm.reply + `<a href=${that.hyperlinkForm.link}>${that.hyperlinkForm.text}</a>`
						that.cancelLink()
					}
				})
			},
			// 取消超链接
			cancelLink: function () {
				this.$refs.hyperlinkForm.resetFields();
				this.popoverShow = false
			},
		}

	})
</script>