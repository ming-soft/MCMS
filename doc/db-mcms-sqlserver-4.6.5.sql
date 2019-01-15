

-- ----------------------------
-- Table structure for app
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[app]') AND type IN ('U'))
	DROP TABLE [app]
GO

CREATE TABLE [app] (
  [app_id] int IDENTITY(1,1) NOT NULL,
  [app_name] nvarchar(60) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [app_url] nvarchar(200) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [app_logo] nvarchar(120) COLLATE Chinese_PRC_CI_AS NULL,
  [app_keyword] nvarchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [app_copyright] nvarchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [app_style] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [app_managerid] int NULL,
  [app_description] nvarchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [app_datetime] datetime2(7) NULL,
  [app_mobile_style] nvarchar(11) COLLATE Chinese_PRC_CI_AS NULL,
  [app_pay_date] datetime2(7) NULL,
  [app_pay] nvarchar(300) COLLATE Chinese_PRC_CI_AS NULL,
  [app_state] int DEFAULT ((0)) NOT NULL,
  [app_mobile_state] int DEFAULT ((0)) NOT NULL,
  [app_login_page] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [app] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'站点id',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'站点名称',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'站点域名，多个回车换行显示',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'网站logo',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_logo'
GO

EXEC sp_addextendedproperty
'MS_Description', N'站点关键字',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_keyword'
GO

EXEC sp_addextendedproperty
'MS_Description', N'站点版权信息',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_copyright'
GO

EXEC sp_addextendedproperty
'MS_Description', N'站点风格',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_style'
GO

EXEC sp_addextendedproperty
'MS_Description', N'站点对于管理员编号',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_managerid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'描述',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_datetime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'移动端风格',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_mobile_style'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用续费时间',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_pay_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'费用清单',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_pay'
GO

EXEC sp_addextendedproperty
'MS_Description', N'0运行中 1已停止  ',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_state'
GO

EXEC sp_addextendedproperty
'MS_Description', N'0启用 1停用',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_mobile_state'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义登录界面',
'SCHEMA', N'dbo',
'TABLE', N'app',
'COLUMN', N'app_login_page'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用表',
'SCHEMA', N'dbo',
'TABLE', N'app'
GO


-- ----------------------------
-- Records of [app]
-- ----------------------------
SET IDENTITY_INSERT [app] ON
GO

INSERT INTO [app] ([app_id], [app_name], [app_url], [app_logo], [app_keyword], [app_copyright], [app_style], [app_managerid], [app_description], [app_datetime], [app_mobile_style], [app_pay_date], [app_pay], [app_state], [app_mobile_state],[app_login_page]) VALUES (N'1', N'MCMS-OPEN', N'http://localhost:8080/ms-mcms
', N'', N'', N'', N'mooc', N'50', N'', NULL, N'm', NULL, N'', N'0', N'0',null)
GO

SET IDENTITY_INSERT [app] OFF
GO


-- ----------------------------
-- Table structure for basic
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[basic]') AND type IN ('U'))
	DROP TABLE [basic]
GO

CREATE TABLE [basic] (
  [basic_id] int IDENTITY(1,1) NOT NULL,
  [basic_title] nvarchar(300) COLLATE Chinese_PRC_CI_AS NULL,
  [basic_description] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [basic_thumbnails] nvarchar(1000) COLLATE Chinese_PRC_CI_AS NULL,
  [basic_hit] bigint NULL,
  [basic_sort] int NULL,
  [basic_datetime] datetime2(7) NULL,
  [basic_updatetime] datetime2(7) NULL,
  [basic_peopleid] int NULL,
  [basic_categoryid] int NULL,
  [basic_appid] int NOT NULL,
  [basic_modelid] int NULL,
  [basic_comment] int NULL,
  [basic_collect] int NULL,
  [basic_share] int NULL,
  [basic_type] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [basic_display] int DEFAULT ((0)) NOT NULL
)
GO

ALTER TABLE [basic] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增长id',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标题',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'描述',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'缩略图',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_thumbnails'
GO

EXEC sp_addextendedproperty
'MS_Description', N'点击次数',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_hit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N' 发布时间',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_datetime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_updatetime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户编号',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_peopleid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属分类编号',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_categoryid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用编号',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_appid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块编号',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_modelid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'评论次数',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_comment'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收藏次数',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_collect'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分享次数',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_share'
GO

EXEC sp_addextendedproperty
'MS_Description', N'属性',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'显示属性 0显示1不显示',
'SCHEMA', N'dbo',
'TABLE', N'basic',
'COLUMN', N'basic_display'
GO

EXEC sp_addextendedproperty
'MS_Description', N'基础表',
'SCHEMA', N'dbo',
'TABLE', N'basic'
GO


-- ----------------------------
-- Records of [basic]
-- ----------------------------
SET IDENTITY_INSERT [basic] ON
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'24', N'关于我们', N'  公司于2012年3月8日，已正式向《景德镇市工商行政管理局》领取营业   执照。\r\n  公司名称：景德镇铭飞科技有限公司\r\n  经营范围：计算机系统服务及技术开发、咨询服务', N'', N'0', N'0', N'2015-09-18 16:31:18.0000000', N'2016-06-02 11:07:36.0000000', N'0', N'19', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'32', N'为远行的人', N'', N'', N'0', N'0', N'2016-03-16 17:26:37.0000000', N'2016-05-19 17:50:56.0000000', N'0', N'146', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'33', N'一生学做人', N'', N'', N'0', N'0', N'2016-03-16 17:27:31.0000000', N'2016-06-02 11:35:20.0000000', N'0', N'146', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'34', N'何处惹尘埃', N'', N'', N'0', N'0', N'2016-03-16 17:29:06.0000000', N'2016-05-19 17:50:31.0000000', N'0', N'146', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'35', N'雨夜，晚归人', N'', N'', N'0', N'0', N'2016-03-16 17:31:11.0000000', N'2016-05-19 17:50:10.0000000', N'0', N'146', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'36', N'网站建设', N'网站设计 网站制作 网站维护 网站改版', N'/upload/article/1638/1464868285592.png', N'0', N'0', N'2016-03-16 17:41:27.0000000', N'2016-06-02 19:51:27.0000000', N'0', N'53', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'37', N'人才招聘', N'企业内部的竞聘、晋升机制，为员工提供了公平竞争的机会。通过挖掘企业内部的人才，调动内部人员的潜力和积极性，促进了优秀人才脱颖而出，实现人力资源的合理配置，把\"合适的人放在合适的地方\"。', N'', N'0', N'0', N'2016-03-16 17:48:38.0000000', N'2016-06-04 11:08:08.0000000', N'0', N'146', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'52', N'响应式Web设计的9项基本原则', N'响应式web设计对于解决多类型屏幕问题来说是个', N'/upload/article/1/1458980355125.png', N'0', N'0', N'2016-03-26 14:43:40.0000000', N'2016-06-02 15:00:26.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'53', N'导航设计模式的重要意义', N'Gmai 就 是单页应用的一个很好的例子，其将多项', N'/upload/article/1/1458981328236.jpeg', N'0', N'0', N'2016-03-26 14:49:14.0000000', N'2016-06-02 15:00:32.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'54', N'如何进行可用性启发式评估', N'用 户体验只有在渗透入从创意到开发测试等产品', N'/upload/article/1/1458981122379.png', N'0', N'0', N'2016-03-26 15:47:29.0000000', N'2016-06-02 15:00:59.0000000', N'0', N'67', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'55', N'响应式Web设计的9项基本原则', N'想象一下走进一个狭小拥挤，遍地垃圾的商店。店', N'/upload/article/1/1458981072779.jpg', N'0', N'0', N'2016-03-26 15:50:20.0000000', N'2016-06-02 15:00:54.0000000', N'0', N'67', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'56', N'原生App切图的那些事儿', N'最小的分辨率是320x480，我们把这个尺寸定为基', N'/upload/article/1/1458981027610.png', N'1', N'0', N'2016-03-26 15:51:39.0000000', N'2016-06-02 15:00:48.0000000', N'0', N'66', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'57', N'11个小妙招激发你的灵感', N'感到自己深陷千篇一律的设计泥潭无法自拔？ Sty', N'/upload/article/1/1458980990018.jpeg', N'1', N'0', N'2016-03-26 15:52:27.0000000', N'2016-06-02 15:00:37.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'58', N'5项提高产品设计的交互模式', N'在这个简短的移动端设计模式系列文章的前几篇中', N'/upload/article/1/1458980956132.jpeg', N'1', N'0', N'2016-03-26 15:53:20.0000000', N'2016-06-02 15:00:43.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'59', N'在网页设计中运用柔和色调', N'网页中的柔和色调的使用，不止是近来的趋势，这', N'/upload/article/1/1458980935362.jpg', N'1', N'0', N'2016-03-26 15:54:17.0000000', N'2016-06-02 15:00:19.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'60', N'细数那些精彩纷呈的引导页', N'随着苹果ios8的发布，可以看到App store货架上', N'/upload/article/1/1458980789639.png', N'0', N'0', N'2016-03-26 16:07:08.0000000', N'2016-06-02 15:00:09.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'61', N'从摄影的角度看设计', N'一幅好照片要把观众的注意力吸引到趣味中心mdas', N'/upload/article/1/1458980625909.jpg', N'1', N'0', N'2016-03-26 16:07:55.0000000', N'2016-06-02 14:59:55.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'62', N'国内java开源商城系统', N'MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。', N'/upload/article/1/1458980449738.jpeg', N'1', N'0', N'2016-03-26 16:08:53.0000000', N'2016-06-02 14:59:46.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'63', N'国内java开源 cms系统', N'MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。', N'/upload/article/1/1458980395756.jpg', N'1', N'0', N'2016-03-26 16:09:27.0000000', N'2016-06-02 14:59:39.0000000', N'0', N'65', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'70', N'2015年 铭飞MCms获得最热门开源项目第40位', N'自 Git@OSC 上线以来受到广大开源作者的喜爱。值此新年之际，开源中国整理出 Git@OSC 最热门开源项目 Top50，对 Git@OSC 的发展至今所取得的成绩进行总结。此榜单主要通过开源项目的 Watch、Star、Fork 数量来评定', N'/upload/article/1/1461384072200.jpeg', N'1', N'0', N'2016-03-27 09:34:58.0000000', N'2016-06-02 19:38:12.0000000', N'0', N'69', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'71', N'国内java开源 cms系统', N'MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。', N'/upload/article/1638/1464847653084.jpeg', N'0', N'0', N'2016-03-27 09:36:45.0000000', N'2016-06-03 19:48:52.0000000', N'0', N'68', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'72', N'2016年CMS开源系统排行榜', N'CMS（Content Management System),中文叫作整站系统、文章系统。\r\n大概2004以前，如果想进行网站内容管理,基本上都是靠手工维护,但千变万化的信息流，但没有好的程序支持，还继续靠手工完成是不可能的事。', N'/upload/article/1/1461384142045.png', N'0', N'0', N'2016-03-27 09:37:07.0000000', N'2016-06-03 19:49:00.0000000', N'0', N'68', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'73', N'国内java开源商城系统', N'MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。', N'/upload/article/1/1461384035654.png', N'2', N'0', N'2016-03-27 09:37:46.0000000', N'2016-06-03 19:49:09.0000000', N'0', N'68', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'74', N'国内java开源bbs系统', N'当前版本:5.4.2 铭飞MS官网:http://ms.mingsoft.net官网同时提供一键运行版本下载，请步移官网....', N'/upload/article/1/1461383961935.png', N'1', N'0', N'2016-03-27 09:38:15.0000000', N'2016-06-02 19:24:56.0000000', N'0', N'68', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'92', N'建站资源共享学习平台', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。我们致力于打造一个优秀的建站资源共享学习平台！从零开始系统全面的教你如何建立一个属于自己的网站。能够自己搭建一个网站，并通过优化推广实现盈利。0基础由浅入深的带您走进的世界。掌握程序的操作和使用，能独立开发模板并能运用进行仿站。专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', N'', N'0', N'0', N'2016-03-28 16:39:44.0000000', N'2016-06-02 10:07:19.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'93', N'从零开始系统全面的教你如何建立一个属于自己的网站', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。我们致力于打造一个优秀的建站资源共享学习平台！从零开始系统全面的教你如何建立一个属于自己的网站。能够自己搭建一个网站，并通过优化推广实现盈利。0基础由浅入深的带您走进的世界。掌握程序的操作和使用，能独立开发模板并能运用进行仿站。专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', N'', N'0', N'0', N'2016-03-28 16:40:18.0000000', N'2016-06-02 10:06:14.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'94', N'0基础由浅入深的带您走进的世界', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。我们致力于打造一个优秀的建站资源共享学习平台！从零开始系统全面的教你如何建立一个属于自己的网站。能够自己搭建一个网站，并通过优化推广实现盈利。0基础由浅入深的带您走进的世界。掌握程序的操作和使用，能独立开发模板并能运用进行仿站。专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', N'', N'0', N'0', N'2016-03-28 16:41:12.0000000', N'2016-06-02 10:06:32.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'95', N'网站模板', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', N'', N'0', N'0', N'2016-03-28 16:54:59.0000000', N'2016-06-02 10:07:56.0000000', N'0', N'84', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'96', N'建站培训', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', N'', N'0', N'0', N'2016-03-28 16:55:22.0000000', N'2016-06-02 10:07:51.0000000', N'0', N'84', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'97', N'模板', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', N'', N'0', N'0', N'2016-03-28 16:55:43.0000000', N'2016-06-02 10:07:46.0000000', N'0', N'84', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'98', N'视频课程', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', N'', N'0', N'0', N'2016-03-28 16:56:27.0000000', N'2016-06-02 10:07:40.0000000', N'0', N'84', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'112', N'新科科技', N'在网上寻觅了很久很久。终于找到了这里。晃眼一看，好多漂亮的模板。下载了几个都很好用。希望越做越好，多提供些精品资源！找了好久啊，一直想有一个这样的网站，找来找去，老感觉么有合适的。偶然间来到这儿，爽。找到啦！对于网站建设新手来说，是一个最好的平台，你可以随心找到你最喜欢的网站模板，做出你喜欢的网站。\r\n专业提供网站模板，网页模板，模板教程，网页制作，程序插件，网站素材等建站资源，我们致为于打造优秀的建站资源共享平台！ ', N'/upload/article/1/1459305011132.png', N'0', N'0', N'2016-03-30 10:28:39.0000000', N'2016-06-02 15:19:51.0000000', N'0', N'87', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'113', N'联娱公司', N'找模板找了很久了，于是找到了，觉的这里的模板很不错，下载了两套试试，果然可以用。于是充值了，希望站长以后多多指点啊！站长很友好，为我们这些新手站长提供这么多的模版。大家一起交流，才能成长得更快吧！感谢，感谢网友，你们辛苦了！对于网站建设新手来说，是一个最好的平台，你可以随心找到你最喜欢的网站模板，做出你喜欢的网站。专业提供网站模板，网页模板，模板教程，网页制作，程序插件，网站素材等建站资源，我们致为于打造优秀的建站资源共享平台！ ', N'/upload/article/1/1459305021450.png', N'0', N'0', N'2016-03-30 10:29:13.0000000', N'2016-06-02 15:19:14.0000000', N'0', N'87', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'130', N'关于我们', N'广州城市规划设计有限公司是中欧国际旅游规划设计研究院（Sino-Europe Academy of Tourism Planning and Design）旗下之专业机构，公司专注于城市规...', N'/upload/article/1/1460376794567.jpg', N'0', N'0', N'2016-04-11 20:02:32.0000000', N'2016-06-02 11:27:17.0000000', N'0', N'93', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'131', N'主营业务', N'互联网时代正在颠覆旅游业传统的商业模式。CEDAR积极应对这种变革，依托中欧国际旅游规划设计研究院（SEATPD）的资源优势，推动文化、地产与旅游业的横向联合发展，以此延伸到移动互联、绿色农业、金融资本、现代物流业等产业领域。', N'/upload/article/1638/1464838231122.jpg', N'0', N'5', N'2016-04-11 20:20:42.0000000', N'2016-06-03 14:29:55.0000000', N'0', N'94', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'132', N'合作伙伴', N'让设计充满新奇和创造力，同时也饱含着和谐、力量与深意。\r\n\"适度\" 是一种幸福的生活态度。\r\n设计哲学 \"合适的设计\"，设计中最难的环节往往并非创新，而是在精确适配下的创造。\r\n打造令人灵感迸发及纵情享受的情绪空间。\r\n', N'/upload/article/1638/1464838215050.jpg', N'0', N'0', N'2016-04-11 20:21:45.0000000', N'2016-06-02 17:38:19.0000000', N'0', N'95', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'133', N'合作伙伴', N'某某，中国知名室内设计师，2005年于北京创立筑邦臣设计公司，他擅长用东方哲学思考解决问题，关注各类空间形态对人的影响，同时注重设计的商业化表现。张海涛说：“希望在设计中融入丰富的文化表达，以打造可以令人思考的空间意境。”他一直坚信，中国拥有丰富的文化底蕴，在未来“中国设计”将充满无限可能！', N'/upload/article/1569/1461506188829.jpg', N'0', N'0', N'2016-04-11 20:23:48.0000000', N'2016-06-02 17:59:19.0000000', N'0', N'97', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'134', N'亚太旅游规划设计十大影响力品牌', N'2009年12月13日由中国民族建筑研究会与中国 房地产 及住宅研究会共同主办，2009第六届中国人居典范建筑规划设计方案竞赛颁奖大会在北京京都信苑饭店隆重召开。经过九个多月来的精...', N'/upload/article/1/1460377619458.jpg', N'0', N'0', N'2016-04-11 20:27:43.0000000', N'2016-04-12 19:56:40.0000000', N'0', N'96', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'135', N'2009中国人居典范●最佳设计方案', N'2009年12月13日由中国民族建筑研究会与中国 房地产 及住宅研究会共同主办，2009第六届中国人居典范建筑规划...', N'/upload/article/1/1460377712056.png', N'0', N'0', N'2016-04-11 20:28:48.0000000', N'2016-06-02 14:16:45.0000000', N'0', N'96', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'136', N'定制化项目金融孵化模式', N'广州规划设计以金融资本为支撑，以规划设计为撬动点，协助旅游业开发高潜力项目，推动项目融资..', N'/upload/article/1585/1462265098563.jpg', N'0', N'0', N'2016-04-11 20:30:32.0000000', N'2016-05-03 16:45:00.0000000', N'0', N'98', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'137', N'幻灯一', N'', N'/upload/article/1638/1465808003859.jpg', N'0', N'0', N'2016-04-11 20:59:07.0000000', N'2016-06-13 16:53:24.0000000', N'0', N'147', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'138', N'幻灯二', N'', N'/upload/article/1638/1465808020382.jpg', N'0', N'0', N'2016-04-11 20:59:25.0000000', N'2016-06-13 16:53:40.0000000', N'0', N'147', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'139', N'幻灯三', N'', N'/upload/article/1638/1465808030831.jpg', N'0', N'0', N'2016-04-11 21:00:16.0000000', N'2016-06-13 16:53:51.0000000', N'0', N'147', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'140', N'幻灯四', N'', N'/upload/article/1638/1464858626484.jpg', N'0', N'0', N'2016-04-11 21:00:35.0000000', N'2016-06-02 17:25:01.0000000', N'0', N'147', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'141', N'城市规划', N'城市商业综合体规划 -新城（新区）规划 -温城市更新与旧城改造 -小城镇建设规划 -历史文化名城/镇保护研究与规划 -产业园区规划...', N'/upload/article/1/1460380106006.jpg', N'0', N'0', N'2016-04-11 21:09:07.0000000', N'2016-06-03 15:32:34.0000000', N'0', N'101', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'142', N'环境艺术设计', N'CEDAR以美学与生态的双重视野开展环境艺术的探索与实践，营造健康、高雅、舒适、美观的现代生态环境，以此提升城市及旅游景区的软环境。...', N'/upload/article/1/1460380199624.jpg', N'0', N'0', N'2016-04-11 21:10:38.0000000', N'2016-06-02 17:57:25.0000000', N'0', N'102', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'143', N'旅游形象策划', N'在把握好旅游地的地脉（地理根据）、文脉（文化根据）和商脉（市场根据）的基础上，为旅游地做好旅游形象定位，并开展理念基础（MI）、行为准则（BI）、视觉形象（VI）的系统策...', N'/upload/article/1/1460380287863.jpg', N'0', N'0', N'2016-04-11 21:11:33.0000000', N'2016-06-02 17:57:30.0000000', N'0', N'103', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'144', N'旅游企业管理', N'目的地与景区管理： -发展战略规划 -营销管理体系咨询 -品牌管理体系咨询 -组织架构与流程再造 -投资运营与管理 -资源与环境保护 酒店管理： -酒店运营管理 -酒店物业管理 -酒店产品...', N'/upload/article/1/1460380343199.jpg', N'0', N'0', N'2016-04-11 21:12:42.0000000', N'2016-06-02 17:57:33.0000000', N'0', N'104', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'146', N'广东梅州市雁洋旅游服务区域城市规划', N'项目地址：广东梅州市雁洋镇\r\n规划面积：1，281，863平方米\r\n项目委托：广东梅州市人民政府', N'/upload/article/1/1460380700438.png', N'0', N'0', N'2016-04-11 21:18:54.0000000', N'2016-06-02 15:06:21.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'147', N'海口湾酒店公寓第二期建筑设计', N'项目地址：海南省海口市北部海口湾西部滨海地区\r\n总用地面积：47957.1平方米\r\n总建筑面积：116154.65平方米\r\n总地上建筑面积：94523.55平方米', N'/upload/article/1/1460380774867.png', N'0', N'0', N'2016-04-11 21:20:05.0000000', N'2016-06-02 15:15:07.0000000', N'0', N'108', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'148', N'昆山水月周庄旅游地产概念营销策划', N'周庄拥有丰富的自然资源、人文资源及极具优势的地理位置，区域发展潜力巨大，古镇旅游品牌价值大，区域发展热点已经形成，旅游经济的发展为房地产市场提供了巨大的想象空间。', N'/upload/article/1/1460380829450.jpg', N'0', N'0', N'2016-04-11 21:21:01.0000000', N'2016-06-02 15:06:16.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'149', N'京杭大运河旅游形象研究与策划', N'项目地址：浙江杭州、苏州\r\n项目委托：杭州市旅游局、苏州市旅游局\r\n \r\n运河文化，吴地风情', N'/upload/article/1/1460380900751.png', N'0', N'0', N'2016-04-11 21:22:08.0000000', N'2016-06-02 15:14:43.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'150', N'佛山某师军史馆设计', N'', N'/upload/article/1/1460380995728.jpg', N'0', N'0', N'2016-04-11 21:23:19.0000000', N'2016-06-02 15:14:45.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'157', N'旅游规划', N'- 区域旅游发展规划\r\n- 历史文化区旅游开发规划\r\n- 风景名胜区旅游开发规划', N'/upload/article/1/1460384875034.jpg', N'0', N'0', N'2016-04-11 22:28:02.0000000', N'2016-06-02 15:06:02.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'158', N'旅游规划', N'区域旅游发展规划 -历史文化区旅游开发规划 -风景名胜区旅游开发规划 -生态旅游区开发规划 -温泉滨海度假区旅游开发规划 -旅游地产开发规划 -乡村旅游开发', N'/upload/article/1/1460385002423.jpg', N'0', N'0', N'2016-04-11 22:30:21.0000000', N'2016-06-02 17:58:24.0000000', N'0', N'101', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'163', N'得品牌者得市场', N'精益求精的网页制作人员、严谨的应用程序开发人员、尽善尽美的售后服务人员。这一切，是我们为您提供专业网站建设服务，也是让你在同行业中傲视群 雄', N'/upload/article/1638/1464746921150.jpg', N'0', N'0', N'2016-04-15 15:29:42.0000000', N'2016-06-03 20:16:45.0000000', N'0', N'99', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'164', N'海派卓越规划设计智业团队', N'广州规划设计麾下聚集了众多从美国旧金山艺术大学、奥本大学、香港理工大学毕业的海派旅游规', N'/upload/article/1585/1462265091247.jpg', N'0', N'0', N'2016-04-15 15:39:48.0000000', N'2016-05-03 16:44:52.0000000', N'0', N'98', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'165', N'高质量行业交互平台', N'广州规划设计创新构建协同式、交互式、大数据及系统式行业服务平台。。。', N'/upload/article/1585/1462265083093.jpg', N'0', N'0', N'2016-04-15 15:40:42.0000000', N'2016-06-02 17:59:22.0000000', N'0', N'98', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'166', N'01品牌创建', N'品牌命名/品牌文化/品牌识别设计\r\n最初的品牌播种，决定了品牌是要长成野草还是参天大树。所谓三岁看大，品牌风格确立也要从萌芽开始，让品牌自始至终保持活力与竞争力，健康茁长的成长。\r\n服务项目：\r\n品牌文化理念挖掘 / 挖掘一种品牌文化，并力求这种文化与更多目标消费群相关品牌命名 /\r\n创造符合品牌精神的独特名称 / 品牌视觉识别（VIS）设计 /\r\n基于市场与设计角度创造严谨而实用的形象设计 /', N'/upload/article/1/1460771365547.jpg', N'0', N'0', N'2016-04-16 09:49:44.0000000', N'2016-04-29 17:23:22.0000000', N'0', N'62', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'167', N'品牌改造设计', N'品牌形象的改造与提升设计\r\n品牌发展到一定的阶段，因为企业发展模式及战略目标发生改变，其原有的形象已经不能承载企业未来发展的战略需求时，则需要创造更具生长气质的视觉形象，为未来打算，为未来改变！品牌改造设计正好填补着类客户的发展需求。\r\n服务项目：\r\n品牌形象改造设计 / 令形象更适合品牌定位，提升 / 完善品牌形象\r\n完善并继承优秀基因,为企业注入新鲜的视觉活力\r\n与客户品牌发展模式及战略目标相匹配', N'/upload/article/1/1460771447978.jpg', N'0', N'0', N'2016-04-16 09:51:22.0000000', N'2016-06-02 19:12:58.0000000', N'0', N'138', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'168', N'品牌推广设计', N'形象画册 / 产品样本 / 招商手册 / 企业年报\r\n印刷品是企业最常用最有效的推广方式，也是挖掘潜在客户的钥匙。好的设计能循序渐进的引导读者，让读者更清楚的了解产品，从而择需购买。一本设计粗糙的画册，不等被翻开便会被丢弃。\r\n服务项目：\r\n印刷品设计 / 具有企业特色的形象画册设计、产品目录及年报设计.\r\n企业内刊策划设计 / 为大型企业策划设计品牌内部刊物', N'/upload/article/1/1460771488365.jpg', N'0', N'0', N'2016-04-16 09:52:35.0000000', N'2016-06-02 15:18:14.0000000', N'0', N'138', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'172', N'网络优化', N'企业网站建设目的何在？如何充分挖掘互联网络的资源和优势，如何合理地组织网站内容与功能从而达到客户的需求？\r\n我们将根据市场分析、客户产品及服务的优势、竞争对手分析等等，有效的确立网站定位。根据相关需求分析获得相应网站运营策略，在网站建立之初我们就网站VI形象、网站营销手段、运营模式、网站发展前景等等进行定位。', N'/upload/article/1/1460889312736.jpg', N'0', N'0', N'2016-04-17 18:37:32.0000000', N'2016-06-04 09:16:24.0000000', N'0', N'133', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'173', N'网络营销', N'互联网品牌推广有个新鲜名词叫数字营销，数字营销是新发展起来的一种营销模式，是利用互联网特性和技术，更加有效、高性价比地完成整合营销计划，达到传统 的IMC不能达到的高效客户关系管理等，从而精准地实施营销策略，实现企业营销的高效率、低成本、大影响。可以按两种意思来理解：网络整合营销是利用网络 技术和网络特性最大化、最快速、最有效、最精准的进行整合营销；网络整合营销是以为客户提供有价值的信息为基础，由客户创造、传播为主导的整合营销理念进 行的网络营销。', N'/upload/article/1/1460889475526.jpg', N'0', N'0', N'2016-04-17 18:38:12.0000000', N'2016-06-02 17:15:23.0000000', N'0', N'134', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'174', N'域名注册', N'上网\"已成为不少人的口头禅。但是，要想在网上建立服务器发布信息，则必须首先注册自己的域名，只有有了自己的域名才能让别人访问到自己。所以，域名注册是在互联网上建立任何服务的基础。同时，由于域名的唯一性，尽早注册又是十分必要的。', N'/upload/article/1638/1464868329275.png', N'0', N'0', N'2016-04-17 18:39:43.0000000', N'2016-06-04 09:16:08.0000000', N'0', N'135', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'177', N'国内开源 java cms，铭飞MCms', N'MCMS是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。\r\n\r\nMS平台开发团队承诺MCMS内容管理系统永久完整开源免费(这真是极', N'/upload/article/1/1461384090357.jpeg', N'1', N'0', N'2016-04-23 11:51:21.0000000', N'2016-06-02 19:39:13.0000000', N'0', N'70', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'178', N'价值源自分享', N'MStore（铭飞商城）是铭飞（MS）平台为开发者提供模版与插件作品分享平台,为企业提供优质产品和服务我们致力于打造一个优秀的Java资源共享学习平台。', N'/upload/article/1/1461383921888.jpeg', N'1', N'0', N'2016-04-23 11:52:35.0000000', N'2016-06-02 19:22:20.0000000', N'0', N'68', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'179', N'铭飞商城MStore——价值源自分享', N'MStore（铭飞商城）是铭飞（MS）平台为开发者提供模版与插件作品分享平台,为企业提供优质产品和服务我们致力于打造一个优秀的Java资源共享学习平台。\r\n', N'/upload/article/1/1461383937683.jpeg', N'1', N'0', N'2016-04-23 11:58:24.0000000', N'2016-06-02 19:20:23.0000000', N'0', N'68', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'182', N'人才理念', N'网络营销是以互联网络为基础，通过数字化的信息和网络媒体的交互性来辅助营销目标实现的一种新型的市场营销方式。', N'/upload/article/1584/1462521245856.jpg', N'0', N'0', N'2016-04-29 14:49:03.0000000', N'2016-06-02 11:17:43.0000000', N'0', N'52', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'183', N'联系我们', N'这里是一个充满活力和梦想的企业，我们不反对个性，我们不安于现状，我们亲手创造价值，我们永远在进步……如果你也是名有梦想勇于尝试的人，那就赶快加入我们吧！\r\n\r\n我们面向全国招募有志之士，欢迎自荐或向周围的好友推荐。', N'', N'0', N'0', N'2016-04-29 14:49:25.0000000', N'2016-06-02 11:17:55.0000000', N'0', N'136', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'185', N'联系我们', N'这里是一个充满活力和梦想的企业，我们不反对个性，我们不安于现状，我们亲手创造价值，我们永远在进步……如果你也是名有梦想勇于尝试的人，那就赶快加入我们吧！\r\n\r\n我们面向全国招募有志之士，欢迎自荐或向周围的好友推荐。', N'/upload/article/1638/1465720290023.jpg', N'0', N'4', N'2016-05-04 14:49:32.0000000', N'2016-06-12 16:31:31.0000000', N'0', N'141', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'190', N'在线留言', N'', N'', N'0', N'0', N'2016-06-02 11:17:01.0000000', N'2016-06-02 11:17:01.0000000', N'0', N'142', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'191', N'“绿色装饰”融入杭州市民中心装饰工程', N'此外项目部还非常注重采取新工艺、新方法，不仅提高了工程的整体美观性和实用性，而且加快了施工进度，提升了工作效率。由于本工程是圆型结构的楼层施 工，特别是石材在圆弧和圆柱造型上用量大，大大增加了工程的施工难度。', N'/upload/article/1638/1464861354733.jpg', N'0', N'0', N'2016-06-02 14:52:40.0000000', N'2016-06-02 17:55:55.0000000', N'0', N'84', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'192', N'纽约时髦客手中那些让人尖叫的包', N'对于时尚达人而言，包袋与衣服的混搭也是一种必杀技。休闲手提包可以搭配不同的造型，而搭配运动裤就是更加直接地表现出时尚休闲风的最佳配搭方案。', N'/upload/article/1638/1464861380560.png', N'0', N'0', N'2016-06-02 14:53:33.0000000', N'2016-06-04 09:55:27.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'193', N'宋朝华率队赴贵州招商洽谈推进重大项目', N'市委副书记、市长宋朝华率队前往贵州省贵阳市，实地考察由中铁贵旅公司投资开发建设的中铁国际生态城项目，并与公司高层进行了深入友好座谈，洽谈推进重大项目落户我市仁寿县相关事宜。\r\n ', N'/upload/article/1638/1464861385314.jpg', N'0', N'0', N'2016-06-02 14:53:59.0000000', N'2016-06-02 17:56:25.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'194', N'红木市场是否低迷 消费者仍在', N'内庭中央还展示着一辆豪华轿车，而周边则摆满红木家具，完全没有红木家具应该有的意境。更令人瞠目结舌的是，里面人流熙熙攘攘', N'/upload/article/1638/1464861401214.jpg', N'0', N'0', N'2016-06-02 14:54:54.0000000', N'2016-06-02 17:56:42.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'195', N'众多国宝级古典家具悉数亮相', N'海南黄花梨圆包脚罗汉床、小叶紫檀云龙纹镶理石圆桌、富贵满堂多宝阁……昨日（12月13日）上午，第三届中国（江门）传统家具精品鉴赏会暨2014中国（江门）红木家具....', N'/upload/article/1638/1464861408016.jpg', N'0', N'0', N'2016-06-02 14:55:33.0000000', N'2016-06-04 09:55:30.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'196', N'戴为红木燃情成都，开启幸福之门', N'近期，出于对中国传统文化的热爱，以及对红木艺术的执着、深情和追求，戴为红木携带“幸福之家”主题活动礼遇成都，使其鸿儒红木家居艺术馆隆重开业，为已进入寒冬的成都燃起了一把火，掀起了中式红木家具热潮！', N'/upload/article/1638/1464861413861.jpg', N'0', N'0', N'2016-06-02 14:56:00.0000000', N'2016-06-02 17:56:54.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'197', N'质检整治电商售假 红木家具市场良莠不齐', N'质检总局执法督查司按照网上发现、源头追溯、落地查处的要求，组织开展电子商务产品专项执法打假活动，积极构建适应电子商务执法打假的全国执法协查工作机制...', N'/upload/article/1638/1464861373394.png', N'0', N'0', N'2016-06-02 14:56:35.0000000', N'2016-06-02 17:56:16.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'198', N'东西方两大甜妞聚首巴黎时装周头排', N'巴黎时装周许晴倾力助阵，当天许晴身着黑色拼接装头排看秀，大秀美腿，加上干净利落的妆容，整体造型简洁率性，绿色的刺绣手包更添俏皮..', N'/upload/article/1638/1464861364631.jpg', N'0', N'0', N'2016-06-02 14:57:07.0000000', N'2016-06-02 17:56:05.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'199', N'宋朝华率队赴贵州招商洽谈推进重大项目', N'市委副书记、市长宋朝华率队前往贵州省贵阳市，实地考察由中铁贵旅公司投资开发建设的中铁国际生态城项目，并与公司高层进行了深入友好座谈，洽谈推进重大项目落户我市仁寿县相关事宜。', N'/upload/article/1638/1464861360036.png', N'0', N'0', N'2016-06-02 14:57:40.0000000', N'2016-06-02 17:56:01.0000000', N'0', N'83', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'200', N'奔驰斯宾特A3 豪华版', N'斯宾特系列(Sprinter)系列技术领先，动力强劲。座位数从10座到20座均可选择，跟据配置不同,价格也从95.8万178万可以选择。为您带来不同的商务体验。下面为.', N'/upload/article/1638/1464851333470.jpg', N'0', N'0', N'2016-06-02 15:09:12.0000000', N'2016-06-02 15:14:48.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'201', N'福特E350 游艇版', N'其实商务车在人们眼里就是普通的客车，没有人会花时间去研究它，欣赏它。商务车给人的印象，就是整体的一箱车，发动机不是在驾驶与副驾驶的座椅下...', N'/upload/article/1638/1464851477741.jpg', N'0', N'0', N'2016-06-02 15:09:42.0000000', N'2016-06-02 15:11:18.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'202', N'GMC3500 平顶舒适版', N'对于这样一款外观霸气，承载性高的原装进口商务车和它实在的销售价格，都让这款车的性价比大大提升了不少。对于市场上一些追求个性的客户群来讲，...', N'/upload/article/1638/1464851473102.jpg', N'0', N'0', N'2016-06-02 15:10:17.0000000', N'2016-06-02 15:11:14.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'203', N'宾特奔驰斯A系列', N'奔驰斯宾特系列礼宾车在豪华商务车系中，一向是高端、舒适的代名词。在秉承了奔驰的贵族气质的同时，其全新定制的奢华内饰让人感觉犹如进入了高档..', N'/upload/article/1638/1465808166467.png', N'0', N'0', N'2016-06-02 15:11:08.0000000', N'2016-06-13 16:56:07.0000000', N'0', N'107', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'204', N'1', N'', N'/upload/article/1638/1464859580381.jpg', N'0', N'0', N'2016-06-02 17:26:21.0000000', N'2016-06-02 17:26:21.0000000', N'0', N'148', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'205', N'2', N'', N'/upload/article/1638/1464859585818.jpg', N'0', N'0', N'2016-06-02 17:26:26.0000000', N'2016-06-02 17:26:26.0000000', N'0', N'148', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'206', N'3', N'', N'/upload/article/1638/1464859590366.jpg', N'0', N'0', N'2016-06-02 17:26:31.0000000', N'2016-06-02 17:26:31.0000000', N'0', N'148', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'207', N'4', N'', N'/upload/article/1638/1464859595151.jpg', N'0', N'0', N'2016-06-02 17:26:36.0000000', N'2016-06-02 17:26:36.0000000', N'0', N'148', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'208', N'5', N'', N'/upload/article/1638/1464859599849.jpg', N'0', N'0', N'2016-06-02 17:26:40.0000000', N'2016-06-02 17:26:40.0000000', N'0', N'148', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'209', N'6', N'高品质景观缔造者\r\nHigh quality landscape architects.', N'/upload/article/1638/1464859604208.jpg', N'0', N'0', N'2016-06-02 17:26:45.0000000', N'2016-06-16 14:24:51.0000000', N'0', N'148', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'210', N'幻灯五', N'做精品设计、建优良工程、打造精品工程\r\nBoutique design, construction engineering, excellent build quality engineering.', N'/upload/article/1638/1464859633594.jpg', N'0', N'0', N'2016-06-02 17:26:55.0000000', N'2016-06-16 14:24:18.0000000', N'0', N'147', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'211', N'幻灯六', N'与您一起携手，共同谱写园林绿化事业的新篇章！\r\nWork with you to jointly write a new chapter landscaping business!', N'/upload/article/1638/1464859625584.jpg', N'0', N'0', N'2016-06-02 17:27:06.0000000', N'2016-06-16 14:23:03.0000000', N'0', N'147', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'212', N'愿景', N'我们拥有稳定的充满创作激情的设计团队，核心人员由公司创立至今伴随我们一个又一个客户的成长，保证了稳定的设计出品质量及熟知我们所合作过的每一个客户的设计需求，现在，团队不断壮大。', N'/upload/article/1638/1464940624025.png', N'0', N'0', N'2016-06-02 17:36:54.0000000', N'2016-06-03 20:52:58.0000000', N'0', N'95', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'213', N'价值观', N'我们已为数百家企业、政府和社会团体完成品牌的传播与设计，积累了大量丰富的经验，可为您提供大量同类企业和机构的案例进行比较参考。', N'/upload/article/1638/1464940619456.jpg', N'0', N'0', N'2016-06-02 17:37:08.0000000', N'2016-06-03 20:52:55.0000000', N'0', N'95', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'214', N'经营理念', N'可提供一站式全面服务：品牌的定位——企业文化梳理——企业/品牌形象设计——品牌传播——环境空间设计——宣传物品的落地', N'/upload/article/1638/1464940614692.jpg', N'0', N'0', N'2016-06-02 17:37:19.0000000', N'2016-06-03 20:52:46.0000000', N'0', N'95', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'215', N'管理理念', N'多年来，我们始终专注于品牌的设计与塑造，坚持站在市场的角度，为客户创作出准确的、极具商业价值的形象设计与品牌传播策略。', N'/upload/article/1638/1464940610305.jpg', N'0', N'0', N'2016-06-02 17:37:42.0000000', N'2016-06-12 17:54:59.0000000', N'0', N'95', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'216', N'李镇江', N'资深PPT设计师', N'/upload/article/1638/1464860436576.png', N'0', N'0', N'2016-06-02 17:40:31.0000000', N'2016-06-03 15:47:36.0000000', N'0', N'115', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'217', N'曹瑛', N'锐诚PPT特邀首席技术专家', N'/upload/article/1638/1464860564066.png', N'0', N'0', N'2016-06-02 17:41:15.0000000', N'2016-06-03 15:47:33.0000000', N'0', N'115', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'218', N'孙建东', N'锐诚PPT培训部总监', N'/upload/article/1638/1464860506257.png', N'0', N'0', N'2016-06-02 17:41:47.0000000', N'2016-06-03 15:47:30.0000000', N'0', N'115', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

INSERT INTO [basic] ([basic_id], [basic_title], [basic_description], [basic_thumbnails], [basic_hit], [basic_sort], [basic_datetime], [basic_updatetime], [basic_peopleid], [basic_categoryid], [basic_appid], [basic_modelid], [basic_comment], [basic_collect], [basic_share], [basic_type], [basic_display]) VALUES (N'219', N'梅幸', N'锐诚PPT金牌设计师1', N'/upload/article/1638/1464860570155.png', N'0', N'0', N'2016-06-02 17:42:00.0000000', N'2018-05-10 16:18:13.9670000', N'0', N'69', N'1', N'8', NULL, NULL, NULL, NULL, 0)
GO

SET IDENTITY_INSERT [basic] OFF
GO


-- ----------------------------
-- Table structure for basic_attention
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[basic_attention]') AND type IN ('U'))
	DROP TABLE [basic_attention]
GO

CREATE TABLE [basic_attention] (
  [ba_id] int IDENTITY(1,1) NOT NULL,
  [ba_people_id] int NULL,
  [ba_app_id] int NULL,
  [ba_basic_id] int NULL,
  [ba_type] int NULL,
  [ba_datetime] datetime2(7) NULL,
  [ba_url] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [basic_attention] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增长id',
'SCHEMA', N'dbo',
'TABLE', N'basic_attention',
'COLUMN', N'ba_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户id',
'SCHEMA', N'dbo',
'TABLE', N'basic_attention',
'COLUMN', N'ba_people_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户应用id',
'SCHEMA', N'dbo',
'TABLE', N'basic_attention',
'COLUMN', N'ba_app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户收藏关联的基础id',
'SCHEMA', N'dbo',
'TABLE', N'basic_attention',
'COLUMN', N'ba_basic_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收藏类型 1： 收藏  2：顶',
'SCHEMA', N'dbo',
'TABLE', N'basic_attention',
'COLUMN', N'ba_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户收藏文章，帖子或商品时的时间',
'SCHEMA', N'dbo',
'TABLE', N'basic_attention',
'COLUMN', N'ba_datetime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'收藏的文章,帖子，商品的链接地址',
'SCHEMA', N'dbo',
'TABLE', N'basic_attention',
'COLUMN', N'ba_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户收藏表',
'SCHEMA', N'dbo',
'TABLE', N'basic_attention'
GO


-- ----------------------------
-- Table structure for basic_column
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[basic_column]') AND type IN ('U'))
	DROP TABLE [basic_column]
GO

CREATE TABLE [basic_column] (
  [column_category_id] int NOT NULL,
  [column_keyword] nvarchar(300) COLLATE Chinese_PRC_CI_AS NULL,
  [column_descrip] nvarchar(500) COLLATE Chinese_PRC_CI_AS NULL,
  [column_type] int NULL,
  [column_url] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [column_listurl] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [column_path] nvarchar(150) COLLATE Chinese_PRC_CI_AS NULL,
  [column_cm_id] int NULL
)
GO

ALTER TABLE [basic_column] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'关联category表（类别表ID）',
'SCHEMA', N'dbo',
'TABLE', N'basic_column',
'COLUMN', N'column_category_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'栏目简介',
'SCHEMA', N'dbo',
'TABLE', N'basic_column',
'COLUMN', N'column_keyword'
GO

EXEC sp_addextendedproperty
'MS_Description', N'栏目关键字的扩展',
'SCHEMA', N'dbo',
'TABLE', N'basic_column',
'COLUMN', N'column_descrip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'1,代表最终列表栏目。2，代表频道封面。3，带表外部链接',
'SCHEMA', N'dbo',
'TABLE', N'basic_column',
'COLUMN', N'column_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'如果是外部链接，则保持外部链接地址。如果为最终列表栏目，就保存文章显示列表',
'SCHEMA', N'dbo',
'TABLE', N'basic_column',
'COLUMN', N'column_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'最终列表栏目的列表模板地址',
'SCHEMA', N'dbo',
'TABLE', N'basic_column',
'COLUMN', N'column_listurl'
GO

EXEC sp_addextendedproperty
'MS_Description', N'栏目路径',
'SCHEMA', N'dbo',
'TABLE', N'basic_column',
'COLUMN', N'column_path'
GO

EXEC sp_addextendedproperty
'MS_Description', N'栏目管理的内容模型id',
'SCHEMA', N'dbo',
'TABLE', N'basic_column',
'COLUMN', N'column_cm_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'栏目表',
'SCHEMA', N'dbo',
'TABLE', N'basic_column'
GO


-- ----------------------------
-- Records of [basic_column]
-- ----------------------------
INSERT INTO [basic_column]  VALUES (N'19', N'', N'', N'2', N'about.htm', NULL, N'/19', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'23', N'', N'', N'1', N'about.htm', N'liebiao.htm', N'/23', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'33', N'', N'', N'1', N'detail.htm', N'list.htm', N'/33', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'52', N'', N'', N'2', N'about.htm', N'about.htm', N'/52', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'53', N'', N'', N'2', N'about.htm', N'about.htm', N'/53', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'59', N'', N'您可以通过以下新闻与公司动态进一步了解我们。我们所签约的客户，无论他们的项目是大或者是小，我们都将提供100%的服务', N'1', N'news-show.htm', N'news-list.htm', N'/59', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'61', N'', N'新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', N'1', N'case-show.htm', N'case-list.htm', N'/61', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'62', N'', N'您可以通过以下新闻与公司动态进一步了解我们。我们所签约的客户，无论他们的项目是大或者是小，我们都将提供100%的服务', N'1', N'news-show.htm', N'news-list.htm', N'/62', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'63', N'建站资源共享学习平台!', N'我们为您提供网站策划、网页设计、程序开发、网站推广、域名注册、虚拟主机、企业邮箱等网站建设相关服务；为您提供iOS/Android/Windows Phone等移动平台的APP应用开发；为您提供办公系统、客户关系管理系统、电子政务系统等行业应用系统的开发；为您提供软件定制开发和系统集成服务。', N'2', N'service.htm', N'service.htm', N'/63', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'65', N'精选案例展示', N'新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', N'1', N'case-show.htm', N'case-list.htm', N'/61/65', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'66', N'精选案例展示', N'新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', N'1', N'case-show.htm', N'case-list.htm', N'/61/66', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'67', N'精选案例展示', N'新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', N'1', N'case-show.htm', N'case-list.htm', N'/61/67', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'68', N'', N'您可以通过以下新闻与公司动态进一步了解我们。我们所签约的客户，无论他们的项目是大或者是小，我们都将提供100%的服务', N'1', N'news-show.htm', N'news-list.htm', N'/59/68', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'69', N'', N'', N'1', N'news-show.htm', N'news-list.htm', N'/59/69', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'70', N'', N'新闻中心', N'1', N'news-show.htm', N'news-list.htm', N'/59/70', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'83', N'', N'您可以通过以下新闻与公司动态进一步了解我们。我们所签约的客户，无论他们的项目是大或者是小，我们都将提供100%的服务', N'1', N'news-show.htm', N'news-list.htm', N'/62/83', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'84', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。我们致力于打造一个优秀的建站资源共享学习平台！', N'专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。设计者：如果您是模板设计师，插件制作者。我们致力于打造一个优秀的建站资源共享学习平台！您可以在这里放心出售您的模板和插件，我们提供版权保护。购买者：购买本站资源，我们提供“三重保障”(担保交易+人工介入+售后服务)，保障购买者的合法权益。织梦猫已经上路，我们将为此不懈努', N'1', N'news-show.htm', N'news-list.htm', N'/62/84', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'87', N'', N'', N'2', N'solution.htm', N'about.htm', N'/87', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'93', N'关于我们', N'关于我们', N'2', N'about.htm', N'about.htm', N'/93', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'94', N'关于我们', N'关于我们', N'2', N'about.htm', N'about.htm', N'/93/94', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'95', N'关于我们', N'关于我们', N'2', N'about.htm', N'about-list.htm', N'/93/95', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'96', N'', N'', N'2', N'about.htm', N'news-list.htm', N'/93/96', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'97', N'', N'', N'2', N'about.htm', N'about.htm', N'/93/97', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'98', N'关于我们', N'生态农庄', N'2', N'about.htm', N'about.htm', N'/93/98', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'99', N'', N'', N'2', N'service.htm', N'product.htm', N'/99', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'100', N'', N'', N'1', N'about.htm', N'about.htm', N'/100', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'101', N'专业服务', N'品牌策划年度服务是岳派品牌机构的主要服务方式之一，以一年或更长时间作为服务周期，为企业进行有计划、有步骤的策划、设计、执行等，进行一体化品牌策划推广服务。', N'2', N'servise.htm', N'about-list.htm', N'/99/101', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'102', N'专业服务', N'LO 标志设计 VIS设计 宣传物料设计视觉是人们接受外部信息的最重要和最主要的通道。设计科学、实施有利的视觉识别，是传播企业经营理念、建立企业知名度、塑造企业形象的快速便捷之途', N'2', N'servise.htm', N'about-list.htm', N'/99/102', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'103', N'专业服务', N'竞争的优势不仅在于产品，也源于产品包装的设计，一个产品的包装直接影响顾客购买心理，产品的包装是最直接的广告 ,由表及里是自然界认识事物不变的定律。', N'2', N'servise.htm', N'news-list.htm', N'/99/103', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'104', N'专业服务', N'连锁店的CI和一般企业的作法有相当大的差异，最主要的因素就是与目标接触的场合不同。连锁店与消费者之间最常发生的接触就是在门店，创造视觉的个性化与标准化，来\r\n加深人们的印象', N'2', N'servise.htm', N'news-list.htm', N'/99/104', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'106', N'我们的作品', N'新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', N'1', N'product-show.htm', N'product-list.htm', N'/106', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'107', N'我们的作品', N'新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', N'1', N'product-show.htm', N'product-list.htm', N'/106/107', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'108', N'', N'', N'1', N'product-show.htm', N'product-list.htm', N'/106/108', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'115', N'', N'', N'1', N'show.htm', N'service.htm', N'/115', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'133', N'网站设计 网站制作 网站维护 网站改版', N'关于我们', N'2', N'about.htm', NULL, N'/53/133', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'134', N'网站整站优化 网页结构优化 网站关键词优化', N'', N'2', N'about.htm', NULL, N'/53/134', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'135', N'英文国际域名 英文国内域名 中文国际域名 中文国内域名', N'关于我们', N'2', N'about.htm', NULL, N'/53/135', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'136', N'', N'联系我们', N'2', N'about.htm', N'about.htm', N'/52/136', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'138', N'', N'我们为您提供网站策划、网页设计、程序开发、网站推广、域名注册、虚拟主机、企业邮箱等网站建设相关服务；为您提供iOS/Android/Windows Phone等移动平台的APP应用开发；为您提供办公系统、客户关系管理系统、电子政务系统等行业应用系统的开发；为您提供软件定制开发和系统集成服务。', N'2', N'service.htm', N'service.htm', N'/63/138', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'141', N'', N'', N'2', N'contact.htm', N'contact.htm', N'/19/141', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'142', N'', N'', N'2', N'advice.htm', NULL, N'/19/142', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'146', N'', N'', N'2', N'advertises.htm', N'about.htm', N'/146', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'147', N'', N'', N'1', N'index.html', N'index.html', N'/100/147', NULL)
GO

INSERT INTO [basic_column]  VALUES (N'148', N'', N'', N'1', N'index.html', N'index.html', N'/100/148', NULL)
GO


-- ----------------------------
-- Table structure for basic_log
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[basic_log]') AND type IN ('U'))
	DROP TABLE [basic_log]
GO

CREATE TABLE [basic_log] (
  [bl_id] int IDENTITY(1,1) NOT NULL,
  [bl_basic_id] int NOT NULL,
  [bl_ip] nvarchar(20) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [bl_datetime] datetime2(7) NOT NULL,
  [bl_is_mobile] int DEFAULT ((0)) NOT NULL
)
GO

ALTER TABLE [basic_log] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'编号',
'SCHEMA', N'dbo',
'TABLE', N'basic_log',
'COLUMN', N'bl_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'引用编号',
'SCHEMA', N'dbo',
'TABLE', N'basic_log',
'COLUMN', N'bl_basic_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'ip地址',
'SCHEMA', N'dbo',
'TABLE', N'basic_log',
'COLUMN', N'bl_ip'
GO

EXEC sp_addextendedproperty
'MS_Description', N'记录时间',
'SCHEMA', N'dbo',
'TABLE', N'basic_log',
'COLUMN', N'bl_datetime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'1移动端 0默认pc',
'SCHEMA', N'dbo',
'TABLE', N'basic_log',
'COLUMN', N'bl_is_mobile'
GO

EXEC sp_addextendedproperty
'MS_Description', N'信息访问日志',
'SCHEMA', N'dbo',
'TABLE', N'basic_log'
GO


-- ----------------------------
-- Records of [basic_log]
-- ----------------------------
SET IDENTITY_INSERT [basic_log] ON
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'1', N'178', N'192.168.1.165', N'2016-05-31 15:33:33.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'2', N'74', N'192.168.1.165', N'2016-05-31 15:33:36.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'3', N'179', N'192.168.1.165', N'2016-05-31 15:33:44.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'4', N'63', N'192.168.1.165', N'2016-05-31 17:49:01.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'5', N'70', N'192.168.1.165', N'2016-05-31 17:53:37.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'6', N'58', N'192.168.1.165', N'2016-05-31 17:54:59.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'7', N'59', N'192.168.1.165', N'2016-05-31 17:55:09.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'8', N'56', N'192.168.1.165', N'2016-05-31 17:55:13.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'9', N'62', N'192.168.1.165', N'2016-05-31 17:55:38.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'10', N'61', N'192.168.1.165', N'2016-05-31 17:55:40.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'11', N'57', N'192.168.1.165', N'2016-05-31 17:56:21.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'12', N'177', N'192.168.1.165', N'2016-06-03 17:41:32.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'13', N'73', N'192.168.1.165', N'2016-06-12 11:31:11.0000000', N'0')
GO

INSERT INTO [basic_log] ([bl_id], [bl_basic_id], [bl_ip], [bl_datetime], [bl_is_mobile]) VALUES (N'14', N'73', N'192.168.1.152', N'2016-06-13 19:53:50.0000000', N'0')
GO

SET IDENTITY_INSERT [basic_log] OFF
GO


-- ----------------------------
-- Table structure for category
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[category]') AND type IN ('U'))
	DROP TABLE [category]
GO

CREATE TABLE [category] (
  [category_id] int IDENTITY(1,1) NOT NULL,
  [category_title] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [category_sort] int NULL,
  [category_datetime] datetime2(7) NULL,
  [category_managerid] int NULL,
  [category_modelid] int NULL,
  [category_categoryid] int NULL,
  [category_smallimg] nvarchar(2000) COLLATE Chinese_PRC_CI_AS NULL,
  [category_appid] int NULL,
  [category_description] nvarchar(45) COLLATE Chinese_PRC_CI_AS NULL,
  [category_parent_id] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [category_dict_id] int DEFAULT ((0)) NULL,
  [create_by] int DEFAULT ((0)) NULL,
  [create_date] datetime2(7) NULL,
  [update_by] int DEFAULT ((0)) NULL,
  [update_date] datetime2(7) NULL,
  [del] int DEFAULT ((0)) NOT NULL
)
GO

ALTER TABLE [category] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'类别ID',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'类别标题',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'类别排序',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'类别发布时间',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_datetime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'发布用户id',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_managerid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'所属模块id',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_modelid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父类别编号',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_categoryid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'略缩图',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_smallimg'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用编号',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_appid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'栏目描述',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父类型编号',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_parent_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典对应编号',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'category_dict_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建人',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'create_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新人',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'update_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除状态',
'SCHEMA', N'dbo',
'TABLE', N'category',
'COLUMN', N'del'
GO

EXEC sp_addextendedproperty
'MS_Description', N'分类表',
'SCHEMA', N'dbo',
'TABLE', N'category'
GO


-- ----------------------------
-- Records of [category]
-- ----------------------------
SET IDENTITY_INSERT [category] ON
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'19', N'联系我们', N'0', N'2015-09-01 15:31:30.0000000', N'50', N'7', NULL, N'', N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'23', N'常见问题', N'0', N'2015-09-01 15:33:54.0000000', N'50', N'87', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'33', N'投资', N'0', N'2015-09-02 00:32:02.0000000', N'50', N'87', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'52', N'招商加盟', N'0', N'2016-03-15 17:35:38.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'53', N'关于我们', N'0', N'2016-03-16 17:16:11.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'59', N'新闻中心', N'0', N'2016-03-26 13:18:53.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'61', N'客户案例', N'0', N'2016-03-26 13:26:34.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'62', N'新闻', N'0', N'2016-03-26 13:27:39.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'63', N'服务', N'0', N'2016-03-26 13:29:07.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'65', N'网站设计', N'3', N'2016-03-26 14:34:49.0000000', N'50', N'7', N'61', NULL, N'1', NULL, N'61', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'66', N'手机应用', N'1', N'2016-03-26 14:35:49.0000000', N'50', N'7', N'61', NULL, N'1', NULL, N'61', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'67', N'平面设计', N'2', N'2016-03-26 14:36:15.0000000', N'50', N'7', N'61', NULL, N'1', NULL, N'61', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'68', N'公司新闻', N'3', N'2016-03-27 09:39:22.0000000', N'50', N'7', N'59', N'', N'1', NULL, N'59', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'69', N'行业新闻', N'2', N'2016-03-27 09:39:48.0000000', N'50', N'7', N'59', NULL, N'1', NULL, N'59', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'70', N'最新动态', N'1', N'2016-03-27 09:40:22.0000000', N'50', N'7', N'59', NULL, N'1', NULL, N'59', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'83', N'研发团队', N'2', N'2016-03-28 16:51:31.0000000', N'50', N'7', N'62', NULL, N'1', NULL, N'62', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'84', N'研发成果', N'1', N'2016-03-28 16:54:29.0000000', N'50', N'7', N'62', NULL, N'1', NULL, N'62', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'87', N'客户的声音', N'0', N'2016-03-30 10:27:42.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'93', N'关于我们', N'0', N'2016-04-11 19:52:30.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'94', N'主营业务', N'5', N'2016-04-11 19:54:05.0000000', N'50', N'7', N'93', NULL, N'1', NULL, N'93', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'95', N'企业文化', N'4', N'2016-04-11 19:54:43.0000000', N'50', N'7', N'93', NULL, N'1', NULL, N'93', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'96', N'资质荣誉', N'0', N'2016-04-11 19:55:18.0000000', N'50', N'7', N'93', NULL, N'1', NULL, N'93', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'97', N'合作伙伴', N'0', N'2016-04-11 19:55:41.0000000', N'50', N'7', N'93', NULL, N'1', NULL, N'93', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'98', N'企业优势', N'0', N'2016-04-11 19:56:04.0000000', N'50', N'7', N'93', NULL, N'1', NULL, N'93', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'99', N'服务项目', N'0', N'2016-04-11 20:32:40.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'100', N'首页幻灯', N'0', N'2016-04-11 20:56:40.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'101', N' 全案设计', N'3', N'2016-04-11 21:04:41.0000000', N'50', N'7', N'99', NULL, N'1', NULL, N'99', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'102', N'企业形象设计', N'4', N'2016-04-11 21:05:11.0000000', N'50', N'7', N'99', NULL, N'1', NULL, N'99', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'103', N'产品包装设计', N'2', N'2016-04-11 21:05:42.0000000', N'50', N'7', N'99', NULL, N'1', NULL, N'99', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'104', N'连锁店设计', N'0', N'2016-04-11 21:05:57.0000000', N'50', N'7', N'99', NULL, N'1', NULL, N'99', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'106', N'产品列表', N'0', N'2016-04-11 21:15:27.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'107', N'产品一类', N'2', N'2016-04-11 21:15:43.0000000', N'50', N'7', N'106', NULL, N'1', NULL, N'106', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'108', N'产品二类', N'1', N'2016-04-11 21:16:21.0000000', N'50', N'7', N'106', NULL, N'1', NULL, N'106', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'115', N'专家研究院', N'0', N'2016-04-11 21:29:24.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'133', N'网站优化', N'3', N'2016-04-17 18:32:05.0000000', N'50', N'7', N'53', NULL, N'1', NULL, N'53', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'134', N'网络营销', N'2', N'2016-04-17 18:33:01.0000000', N'50', N'7', N'53', NULL, N'1', NULL, N'53', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'135', N'域名注册', N'1', N'2016-04-17 18:33:47.0000000', N'50', N'7', N'53', NULL, N'1', NULL, N'53', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'136', N'优化报价', N'0', N'2016-04-17 21:13:17.0000000', N'50', N'7', N'52', NULL, N'1', NULL, N'52', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'138', N'服务中心', N'0', N'2016-04-29 17:15:49.0000000', N'50', N'7', N'63', NULL, N'1', NULL, N'63', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'141', N'联系我们', N'2', N'2016-05-04 14:42:07.0000000', N'50', N'7', N'19', NULL, N'1', NULL, N'19', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'142', N'在线留言', N'1', N'2016-05-04 14:42:31.0000000', N'50', N'7', N'19', NULL, N'1', NULL, N'19', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'146', N'人才招聘', N'0', N'2016-05-19 17:49:37.0000000', N'50', N'7', NULL, NULL, N'1', NULL, NULL, N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'147', N'长图', N'0', N'2016-06-02 17:23:49.0000000', N'50', N'7', N'100', NULL, N'1', NULL, N'100', N'0', N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [category] ([category_id], [category_title], [category_sort], [category_datetime], [category_managerid], [category_modelid], [category_categoryid], [category_smallimg], [category_appid], [category_description], [category_parent_id], [category_dict_id], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'148', N'短图', N'0', N'2016-06-02 17:24:21.0000000', N'50', N'7', N'100', NULL, N'1', NULL, N'100', N'0', N'0', NULL, N'0', NULL, N'0')
GO

SET IDENTITY_INSERT [category] OFF
GO


-- ----------------------------
-- Table structure for cms_article
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[cms_article]') AND type IN ('U'))
	DROP TABLE [cms_article]
GO

CREATE TABLE [cms_article] (
  [article_basicid] int DEFAULT ((0)) NOT NULL,
  [article_author] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [article_content] nvarchar(max) COLLATE Chinese_PRC_CI_AS NULL,
  [article_type] nvarchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [article_source] nvarchar(300) COLLATE Chinese_PRC_CI_AS NULL,
  [article_url] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [article_keyword] nvarchar(300) COLLATE Chinese_PRC_CI_AS NULL,
  [article_freeorder] int NULL,
  [article_webid] int NULL
)
GO

ALTER TABLE [cms_article] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章id',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_basicid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章作者',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_author'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章内容',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章类型',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章来源',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_source'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章跳转链接地址',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章关键字',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_keyword'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章自定义显示顺序',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_freeorder'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章管理的应用id',
'SCHEMA', N'dbo',
'TABLE', N'cms_article',
'COLUMN', N'article_webid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文章表',
'SCHEMA', N'dbo',
'TABLE', N'cms_article'
GO


-- ----------------------------
-- Records of [cms_article]
-- ----------------------------
INSERT INTO [cms_article]  VALUES (N'24', N'铭飞科技', N'<p>&nbsp; 公司于2012年3月8日，已正式向《景德镇市工商行政管理局》领取营业 &nbsp; 执照。</p><p>&nbsp; 公司名称：景德镇铭飞科技有限公司</p><p>&nbsp; 经营范围：计算机系统服务及技术开发、咨询服务</p><p><br/></p>', N'c,', N'铭飞科技', N'/19\\index.html', N'公司于2012年3月8日，已正式向《景德镇市工商行政管理局》领取营业   执照。\r\n  公司名称：景德镇铭飞科技有限公司\r\n  经营范围：计算机系统服务及技术开发、咨询服务', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'36', N'', N'<p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网站整体策划</span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">企业网站建设目的何在？如何充分挖掘互联网络的资源和优势，如何合理地组织网站内容与功能从而达到客户的需求？<br style=\"padding: 0px; margin: 0px;\"/>我们将根据市场分析、客户产品及服务的优势、竞争对手分析等等，有效的确立网站定位。根据相关需求分析获得相应网站运营策略，在网站建立之初我们就网站VI形象、网站营销手段、运营模式、网站发展前景等等进行定位。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网站设计&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">DESIGN</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">网络媒体不同于传统媒体，如果在网站设计的时候仅仅是将文字和图片做一个简单堆积和展示的话，这样的网站跟一片丢落在街头的破旧宣传资料没有任何区别。客户往往通过企业网站就留下了对企业的第一印象，这个第一印象是决定客户是否与你合作的重要因素。<br style=\"padding: 0px; margin: 0px;\"/>所以在浏览者的角度，我们分析企业特点和品牌内涵，完美的通过网站体现企业形象，并严格采用W3C国际标准进行网站设计，采用DIV+CSS构 架，不但使您的网站具备足够的扩展性，您网站的速度、兼容性、友好性也都会显著提高，更主要的是，代码和表现分离的方式让您的网站改版变得更容易，而针对 SEO搜索引擎优化的工作也变得更加的畅通。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网站建设售后服务&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">SALES</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">网站建设专家致力于为客户提供优质的产品及服务。为了多渠道的了解客户的需求，快速响应个性化需要，不断完善售后服务工作，我们客户服务管理部在此为您搭建了这个沟通的平台，我们希望通过网络加强与客户的交流。<br style=\"padding: 0px; margin: 0px;\"/>完善的售后服务是公司信誉的保障和服务趋于完善与成熟的象征，因此，我们在这一方面投入了较大的精力，确保每一位客户的利益得到充分的保障，从而提高企业信誉，发展长期友好的合作。<br style=\"padding: 0px; margin: 0px;\"/>对于享受我公司建站服务的客户，我们提供免费一年售后服务。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网站全程维护&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">MAINTAIN</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">网页制作好了以后并不是就没事了？其实日后的更新维护才是最重要的！如果参观网站的访问者每次看到的网站都是一样的，那么它们日后还会来吗？这时候，您的网页要由谁来维护呢？<br style=\"padding: 0px; margin: 0px;\"/>严格来说，每一个站点都应该由专业人员定期更新维护。互联网络的最大优势就是信息的实时性，只有快速的反映，准确的报道，才能吸引更多的浏览者。<br style=\"padding: 0px; margin: 0px;\"/>目前很多站点人气很旺，应该和定期更新分不开的。也有很多站点由于种种原因，数月才更新一次，这样就违背了网路最基本的商业目的。网站不是购买一件商品，随着时间的推移而贬值陈旧，只有不断的溶入企业发展动向，推陈出新，才会具有创造力，发挥网路商业潜能。<br style=\"padding: 0px; margin: 0px;\"/>更新维护不仅仅只局限于简单的更换文字稿，应该是将企业的商业动态和发展方向充分考虑进去， 再结合现有的网站规划结构，迅速作出相应的改进。企业的每一个新项目的推广和价格的浮动、内部结构调整， 不应该只是在报纸、电视等媒体做宣传而忽略网路这个最具有潜力的市场。 这也是我们一直强调的商业网站 CIS 策略。<br style=\"padding: 0px; margin: 0px;\"/>鉴于目前大多数网站不具有专业维护的技术力量，网站建设公司可为广大客户提供专业服务。每一个企业可根据自身的商业特征制定不同的维护方案，并保证在最短的时间内迅速完成。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网页改版&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">REVISED</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">企业上网已成趋势，企业网站犹如雨后春笋般地拔起，试问：<br style=\"padding: 0px; margin: 0px;\"/>您的企业通过互联网进行了巨额的投入，但网站到底给您带来了多大的效益？<br style=\"padding: 0px; margin: 0px;\"/>您的网站从建立到现在，更新过几次、改版过几次？<br style=\"padding: 0px; margin: 0px;\"/>功能不全、设计不美观、布局不合理、几乎从不更新的网站会给企形象带来多大的负面影响？<br style=\"padding: 0px; margin: 0px;\"/>选择网站建站专家，帮您重新审视和构架您的网站系统，我们提供八项全能服务，全面改善您的网站系统，专为您解决企业上网后顾之忧。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">培训解决方案&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">TRAIN</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">为了更好地做好企业外部门户网站的技术培训工作，将选派具有丰富技术培训和实施经验的技术人员组成培训小组，编写详尽实用的培训教材，并且制定切实有效的培训方案。技术培训的工作为应用软件系统管理和使用培训。<br style=\"padding: 0px; margin: 0px;\"/>在软件产品实践培训中，采用集中培训的方式，由的培训师针对本系统的技术特点，为企业技术人员提供全面培训，培训内容涵盖了本此系统建设过程中使用的主要技术理论和产品实践。<br style=\"padding: 0px; margin: 0px;\"/>在应用软件系统管理和使用培训中，我们会组织项目开发小组的主要人员针对管理和使用人员的不同需求，提供不同层次的培训课程。</p><p><br/></p>', N'', N'', N'/53\\index.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'37', N'火星猿', N'<p class=\"font_b font_14\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-weight: bold; font-size: 14px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">*&nbsp;&nbsp;以人为本，人尽其才&quot;的原则<br/>*&nbsp;&nbsp;德才兼备,德为先&nbsp;<br/>*&nbsp;&nbsp;内部提拔,给员工一个上升的空间<br/>*&nbsp;&nbsp;绩效考核制度,倡导&quot;能者上，庸者下&quot;的淘汰机制</p><p class=\"font_b font_14\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-weight: bold; font-size: 14px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">一个企业的竞争力归结到底是人才的竞争力。荣超物业本着&quot;以人为本，人尽其才&quot;的原则，为有志于物业管理行业发展的人才提供一个发展的舞台。在人才招聘中，结合每位应聘者的素质、品格、经验进行综合评价，遵循公平、平等、竞争、择优以及双向选择的原则。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">企业内部的竞聘、晋升机制，为员工提供了公平竞争的机会。通过挖掘企业内部的人才，调动内部人员的潜力和积极性，促进了优秀人才脱颖而出，实现人力资源的合理配置，把&quot;合适的人放在合适的地方&quot;。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">建立客观公正的考核制度，是人才使用的一个重要人力资源措施。考核突出对每位员工的工作绩效、工作态度和工作能力进行考评，以提高团队的整体绩效和提高企业的管理服务水平，并倡导&quot;能者上，庸者下&quot;的淘汰机制。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;\">企业致力于创造一个员工于企业共同发展的空间和平台，荣超物业期待您的加盟，企业的发展将为您的加入而更为精彩！</p><p><br/></p>', N'', N'MS', N'/54\\37.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'52', N'MS', N'<p>响应式web设计对于解决多类型屏幕问题来说是个不错方案，但从印刷的角度来看，其却存在着很多的困难。没有固定的页面尺寸、没有毫米或英寸，没有任何物 理限制，让人感到无从下手。随着建立网站可用的各种小工具越来越多，像素设计局限于桌面和移动端也已经成为历史。因此，现在就让我们来说明一下如何运用响 应式web设计的各项基本原则来实现，而不是抗拒流畅的网页体验。为了简单起见，我们将着重讲布局</p>', N'f,', N'来自火星的程序猿', N'/61/65\\52.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'53', N'MS', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\"><strong style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\">Gmai</strong>就 是单页应用的一个很好的例子，其将多项操作融入了一个单独的“页面”中。单页设计的趋势是这一UI模式中相对不太高端的一种实现方式，在这一设计模式下， 所有内容均可通过同一页面访问。这一模式可以让浏览变得更快、响应更迅速，从而让桌面与web应用之间的界限不再如此分明。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\">对于Spotify等web应用，考虑到用户有时会在背景播放音乐的同时浏览其他音乐，这时单页应用模式的重要性就愈发凸显，通过使用单页应用，用户就无需对页面进行重新加载，也不会造成音乐停止播放。</p><p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; background: rgb(255, 255, 255);\">在 使用单页应用时需要考虑的一个问题就是URL结构。由于内容使用JavaScript动态加载，URL会失去作用，如果设计不当，还会造成无法访问特定视 图。Gmail和Twitter等应用通过为每个视图生成专门的URL来克服这一问题，这一方法还能够解决浏览器后退按钮失效的问题。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\"><br/></p><p><br/></p>', N'c,', N'来自火星的程序猿', N'/61/65\\53.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'54', N'MS', N'<p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; color: rgb(51, 51, 51); background: transparent;\"><span style=\"font-family:Verdana, 宋体;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\">用 户体验只有在渗透入从创意到开发测试等产品开发的各个阶段时才能发挥最佳效果。当通常来说事情没这么简单，用户体验专家需要反复对已经完成的产品进行优化 才能使其达到我们口中所说的“用户友好”水平。但是，亡羊补牢，为时未晚。对现有网站进行用户体验优化也有自己的好处和缺点。好处是你可以获得更多真实用 户数据和统计信息方便进行用户调研，但另一方面，也会遇到很多变革的阻力，特别是在你要换掉用户“心爱的宝贝”的时候。</span></span></span></p><p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(127, 127, 127); background: rgb(255, 255, 255);\"><span style=\"font-family:微软雅黑,;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 16px; vertical-align: baseline; background: transparent;\">作为用户体验专家，你可以自由选择调研的方法，甚至可以使用超越传统工具的方法，但是今天，我想回归简单，谈一谈启发式评估方法。</span></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\"><br/></p><p><br/></p>', N'', N'来自火星的程序猿', N'/61/67\\54.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'55', N'MS', N'<p><span style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; background-color: rgb(255, 255, 255);\">想象一下走进一个狭小拥挤，遍地垃圾的商店。店员不停怂恿你买自己不想要的东西。在这种情况下，你肯定会马上转身离开去别家。如果有人给你压力，逼迫你在充满敌意的环境下快速做出抉择，你会自然而然的失去信任感。这一点也适用于网络。</span><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; background-color: rgb(255, 255, 255);\">网上充满着向你推销各种服务和产品的人。用户要先信任你，才能考虑从你那购买产品或服务。下面列出了10个比较流行的让用户相信、信任你登陆页面的方法。你可以借鉴或者干脆照搬这些方法为你的网上业务建立起值得信赖的网站。</span><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; white-space: normal; background: rgb(255, 255, 255);\">1.快速表现价值</strong><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; background-color: rgb(255, 255, 255);\">每个来到你登陆页面的用户都会问同一个问题：你能给我带来什么好处？你需要让他们立刻看到你所能提供的价值。使用显眼的标题说明你所能提供的内容，以及你 与竞争对手的不同之处在哪。但是不要太过于强调你自己和你的公司，否则可能会让用户反感而离开。应当着重强调你如何满足用户的需求。</span></p>', N'h,', N'来自火星的程序猿', N'/61/67\\55.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'56', N'MS', N'<p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; color: rgb(120, 120, 120); background: transparent;\"><span style=\"font-family:Tahoma, simsun;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;\">最小的分辨率是320x480，我们把这个尺寸定为基准界面尺寸（baseline），基准尺寸所用的图标定为1倍图（1x）。</span></span></span></p><p><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/></p><p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; color: rgb(120, 120, 120); background: transparent;\"><span style=\"font-family:Tahoma, simsun;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;\">在 实际设计过程中，为了降低设计成本，一般拿设备最高的分辨率作为设计稿的原始尺寸，拿iphone来说就是iphone5或5s的640x1136啦，当 然也可以用iphone4或4s的640x960，因为宽度都是640px，他们切图的标准是一样的。显然，以1倍图的基准尺寸（宽320px）为相对的 参考依据，宽640px的设计稿，以原始尺寸切出来的图标称为2倍图（2x）。</span></span></span></p><p>&nbsp;</p><p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; color: rgb(120, 120, 120); background: transparent;\"><span style=\"font-family:Tahoma, simsun;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;\">有人可能会问：为什么不拿320px作为设计稿的原始尺寸呢？因为1倍图放大成为2倍图远比2倍图缩小成1倍图来得模糊！</span></span></span></p><p>&nbsp;</p><p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; color: rgb(120, 120, 120); background: transparent;\"><span style=\"font-family:Tahoma, simsun;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;\">于是，在不考虑iphone6和iphone 6 plus的情况下，为了适配iphone，每个图标需要切两份。</span></span></span></p><p>&nbsp;</p><p><strong style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; white-space: normal; background: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\">Android - 更为繁多的界面尺寸</span></strong><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/></p><p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; color: rgb(120, 120, 120); background: transparent;\"><span style=\"font-family:Tahoma, simsun;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;\">Android开源自由的代价就是设备规范的不可控，市面上充斥着各种品牌的android手机，有着各种各样的尺寸和分辨率，为了适配各种不同分辨率的设备，同一个图标需要切成N份，每一份对应一个尺寸。</span></span></span></p><p>&nbsp;</p><p><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; color: rgb(120, 120, 120); background: transparent;\"><span style=\"font-family:Tahoma, simsun;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 12px; vertical-align: baseline; background: transparent;\">另外需要注意的是，Android里面开发用的尺寸单位是dp或sp（dp为元素表现尺寸，sp为字体尺寸）而不是iphone中的px。。。</span></span></span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\"><br/></p><p><br/></p>', N'', N'来自火星的程序猿', N'/61/66\\56.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'57', N'MS', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 24px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\">感到自己深陷千篇一律的设计泥潭无法自拔？</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 24px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\">Stylorouge的Rob O’Connor为你送上下面几条建议帮助你解放自己的想象力。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 26px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\">找不到设计灵感？项目在眼前却不知道如何着手或者找不到合适的入手角度？挣扎着想克服阻拦创意的屏障？</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 26px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\">别着急，哪怕是最优秀的设计师也会碰上这些问题。你只需要找到方法让大脑重回战斗状态，创意就会源源不断滚滚而来。下面，我们为你整理了一系列能帮助你有效进行头脑风暴的小建议，另外还有五个绝妙的应用协助你捋清头脑风暴的流程。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\"><br/></p><p><br/></p>', N'p,h,', N'来自火星的程序猿', N'/61/65\\57.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'58', N'MS', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\">在这个简短的移动端设计模式系列文章的前几篇中，我为大家介绍了几个能够解决开发期间所产生问题的常见设计模式，大家也学到了什么是设计模式，其基本组成 部分有什么，使用它们解决问题的最佳方法都有哪些，以及表单、图片集架构、搜索功能和交互建议等各种问题。另外，大家应该还了解了避免<br/>作为本系列的终篇，我将为大家概括性地介绍5种流行移动应用中常见的界面设计模式以供大家在自己的项目中参考。这些设计模式有助于大家提高设计的可用性，让界面变得更加直观。文章将侧重介绍能够帮助大家进行下列各方面设计的模式：<br/>· 社交分享<br/>· 通知<br/>· 弹窗<br/>· 内容更新<br/>· 用户互动（滑动、点击等）</p><p><br/></p>', N'', N'来自火星的程序猿', N'/61/65\\58.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'59', N'MS', N'<p>网页中的柔和色调的使用，不止是近来的趋势，这是一项设计师使用多年的技巧，用来创造有冲击力的视觉效果。</p><p><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/></p><p>当你听到“柔和”一词，想到的可能是淡粉色、淡蓝色、淡黄色，不过这种配色远不止这些颜色。柔和并不一定要感觉像新生儿一样。通过某些适当的方式，配合其他元素，这些色调也可以相当鲜明。</p><p><br style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);\"/></p><p>下面我们从优秀的案例网站出发，了解10种在网页设计中运用柔和色调的方法。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\"><br/></p><p><br/></p>', N'', N'来自火星的程序猿', N'/61/65\\59.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'60', N'MS', N'<p><span style=\"color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; background-color: rgb(255, 255, 255);\">随着苹果ios8的发布，可以看到App store货架上，众多主流App迫不及待地向人们展示产品视频预览，接下去会是被设计师、市场宣传相继关注的焦点，产品宣传的下一轮引爆点。作为能在 App store上先发触达地形成前期推广的视频预览，又会否影响到App安装完毕后的引导页呈现？我们不得而知。鉴于两者形式的展现，间隔于安装App前后， 多少会规避重复性。不管怎样，趁着手机App和扁平风热潮，一起来细数归纳下对手机引导页的所见所想。 早期我们会见到比较多成熟的PC软件或者网页产品的产品安装包或新特性指引页。近几年在移动端平台上兴起了各种门类，形式精彩纷呈的引导页。</span></p>', N'', N'来自火星的程序猿', N'/61/65\\60.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'61', N'MS', N'<p>一幅好照片要把观众的注意力吸引到趣味中心&amp;mdash;&amp;mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体，这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的。</p><p>&nbsp;</p><p>&nbsp; &nbsp;&nbsp;&nbsp;网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&amp;ldquo;G点&amp;rdquo;，有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。</p><p>&nbsp;</p><p>&nbsp; &nbsp;&nbsp;&nbsp;下面我将通过几种突出被摄重点的摄影方法来诠释设计与摄影的微妙关系。</p><p>&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);\"><br/></p><p><br/></p>', N'', N'来自火星的程序猿', N'/61/65\\61.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'62', N'MS', N'<p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台开发团队承诺MCMS内容管理系统永久完整开源免费(这真是极好的)！下面就简单的给大家介绍一下MS平台和MCMS为什么如此之快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台是铭飞团队经过三年的研发，最终以MCMS为基础，集商城、论坛、分期、会员、支付、积分、微信等系统于一体的插件式系统。并实现了淘宝、京东、苏宁、国美等第三方电商平台数据接口的统一。平台中的小插件如：邮件推送、短信接口、定时任务、促销活动、数据采集等非常丰富。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS的模版采用标签式开发，上手非常快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于技术小白来说不仅避开了学习复杂的高级开发语言,而且MStore有大量成熟的模版直接下载之后换换图片和内容就可以使用,要是需要调整只需要写简单的标签就可以。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于前端工程师来说只需要写好页面样式并在页面内容部分套上标签，就可以做出一套优美的动态网站。并且还可以实现留言板、用户登录等数据交互功能。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MStore主页：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; background-color: rgb(255, 255, 255);\"><a href=\"http://static.oschina.net/uploads/space/2015/1124/231902_VsUz_2501041.jpg\" target=\"_blank\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"></a></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于学习JAVA开发的工程师来说这无疑是最好的学习项目,并且最大的优势在于整个系统的结构非常清晰,使用的都是当下JAVA最常用最热门的技术,由于MCMS是全部开源并且作为MS的技术架构在使用这也就说明在学习MCMS的同时也学会了相应的框架使用方法。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS结构图解：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><br/></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS的群站解决方案和模块式的开发架构，让我们管理项目非常方便。不仅很好的解决了因为项目过多而导致的管理紊乱现象，而且还在一定程度上使服务器的资源得到最大化的利用，也避免同时维护多套系统的繁杂。由于是纯JAVA系统这里安全性完全可以放心。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">由于MS平台采用的是模块和插件式的开发,这又进一步从代码层面上提升了我们维护简便性和针对性，而不是像传统项目那样需要维护整套代码。比如：短信插件出问题了那么我们只需要单独的去维护端短信插件即可，其他插件模块不会因为短信插件在维护而受到影响。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台采用模块式开发，严格的说MCMS只是属于MS平台中的一个基础模块。这给定向业务和第三方平台的接入提供了很好的结构支持，从另一个角度来说MCMS严格的遵循了开闭原则，是支持无限拓展的。并且每一次拓展都不会伤害到原有的代码。不仅从结构上保障了系统的开发速度而且不会因为系统的升级或者是插件影响到系统的稳定性。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">同时MCMS将底层复杂的前端代码和第三方接口以及JDK中常用的方法做了很完善的二次封装，从代码角度来讲也大大的节省的开发时间。做到了真正的让代码飞起来！而且更为难得的是这些封装都具有极强规律性，和易用性这里简单的给大家举几个例子：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">封装的freemarker</span><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><br/></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">封装表单</span><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><br/></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">封装的上传图片插件</span><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><br/></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">封装的分页</span><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><br/></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台中有大量的插件和模版可以使用资源非常丰富，目前已经发布或者计划发布的官方模版有八套，开发者提交并且还在审核中的有162套，并且还在以每天10套左右的速度增加。目前已经发布或者准备发布的官方插件有：BBS(论坛)，商城，微信，分期，短信，淘宝，支付等由于数量众多这里就不一一列举。开发者提交的有短信模版插件、邮件模版插件、淘宝开放平台插件等其中大部分还在审核阶段。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台的资源之所以如此丰富插件和模块。一方面除了系统从结构上支持无缝对接之外，MS平台还拥有一大批优质的开发者。开发者在平台提交优质插件之后定价权在自己手中，这又从另外一个角度上大大刺激了海量优质插件的诞生。</span></p><p><br/></p>', N'', N'来自火星的程序猿', N'/61/65\\62.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'63', N'MS', N'<p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台开发团队承诺MCMS内容管理系统永久完整开源免费(这真是极好的)！下面就简单的给大家介绍一下MS平台和MCMS为什么如此之快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台是铭飞团队经过多年的研发，最终以MCMS为基础，集商城、论坛、分期、会员、支付、积分、微信等系统于一体的插件式系统。并实现了淘宝、京东、苏宁、国美等第三方电商平台数据接口的统一。平台中的小插件如：邮件推送、短信接口、定时任务、促销活动、数据采集等非常丰富。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS的模版采用标签式开发，上手非常快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于技术小白来说不仅避开了学习复杂的高级开发语言,而且MStore有大量成熟的模版直接下载之后换换图片和内容就可以使用,要是需要调整只需要写简单的标签就可以。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于前端工程师来说只需要写好页面样式并在页面内容部分套上标签，就可以做出一套优美的动态网站。并且还可以实现留言板、用户登录等数据交互功能。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; background-color: rgb(255, 255, 255);\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MStroe主页：</span></p><p><br/></p>', N'h,', N'来自火星的程序猿', N'/61/65\\63.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'70', N'MS', N'<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">自 Git@OSC 上线以来受到广大开源作者的喜爱。值此新年之际，开源中国整理出 Git@OSC 最热门开源项目 Top50，对 Git@OSC 的发展至今所取得的成绩进行总结。此榜单主要通过开源项目的 Watch、Star、Fork 数量来评定，项目类型不尽相同，难免有纰漏，如有遗漏或者不妥之处，希望大家批评指正。若您对 Git@OSC 未来的发展有何意见或者建议，也欢迎在评论区留言告诉我们。<br style=\"box-sizing: border-box; margin: 0px; padding: 0px;\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\"><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px;\">下面是项目列表：</strong></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">1、<a target=\"_blank\" href=\"http://git.oschina.net/jfinal/jfinal\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">JFinal</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">项 目简介：JFinal 是基于 Java 语言的极速 WEB + ORM 框架，其核心设计目标是开发迅速、代码量少、学习简单、功能强大、轻量级、易扩展、Restful。在拥有Java语言所有优势的同时再拥有ruby、 python、php等动态语言的开发效率！为您节约更多时间，去陪恋人、家人和朋友 :)</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">2、<a target=\"_blank\" href=\"http://git.oschina.net/jeecg/jeewx\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">jeewx</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：免费开源JAVA微信管家平台，实现了微信平台的基础功能，便于用户二次开发。JEEWX支持微信第三方平台全网发布、支持微信插件开发机制，可轻松集成微信H5插件。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">3、<a target=\"_blank\" href=\"http://git.oschina.net/tinyframework/tiny\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">tiny</a><br style=\"box-sizing: border-box; margin: 0px; padding: 0px;\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体\">项目简介：值得拥有的企业级j2ee应用开发框架套件，专业团队开发，完整的生态体系，活跃的社区氛围，无限的水平扩展能力，7*24不间断运维能力。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">4、<a target=\"_blank\" href=\"http://git.oschina.net/shishuo/CMS\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">CMS</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">一款使用Java语言开发的CMS，使用了Spring MVC,Spring,MyBatis等流行框架，提供首页大图管理、目录管理、文章管理和管理员管理等功能。是学习和二次开发的首选。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">5、<a target=\"_blank\" href=\"http://git.oschina.net/jeecg/jeecg\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">jeecg</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项 目推荐：JEECG是一款J2EE企业级快速智能开发平台，开源界“小普元”超越传统商业企业级开发平台。基于代码生成器，引领新的开发模式 (Online Coding模式(自定义表单)-&gt;代码生成器模式-&gt;手工MERGE智能开发)， 可以帮助解决Java项目60%的重复工作，让开发更多关注业务逻辑。既能快速提高开发效率，帮助公司节省人力成本，同时又不失灵活性。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">6、<a target=\"_blank\" href=\"http://git.oschina.net/free/Mybatis_PageHelper\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">Mybatis_PageHelper</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：Mybatis_PageHelper 是 Mybatis 分页插件，支持任何复杂的单表、多表分页。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">7、<a target=\"_blank\" href=\"http://git.oschina.net/thinkgem/jeesite\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">JeeSite</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：JeeSite 是一个企业信息化开发基础平台，Java EE（J2EE）快速开发框架，使用经典技术组合（Spring、Spring MVC、Apache Shiro、MyBatis、Bootstrap UI），包括核心模块如：组织机构、角色用户、权限授权、数据权限、内容管理、工作流等。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">8、<a target=\"_blank\" href=\"http://git.oschina.net/ligerui/LigerUI\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">LigerUI</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：基于jQuery的UI框架，包括表单、布局、表格等等常用UI控件，使用LigerUI可以快速轻松地创建风格统一的界面效果。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">9、<a target=\"_blank\" href=\"http://git.oschina.net/9miao/CrossApp\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">CrossApp</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：一款完全开源、免费、跨平台的移动应用开发引擎，开发者可以完全免费、毫无顾虑的使用CrossApp开发任何项目。本引擎基于C++语言编写，OpenGl ES2.0图形渲染。拥有丰富的UI控件、丰富的第三方库、集成各种系统接口。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">10、<a target=\"_blank\" href=\"http://git.oschina.net/liu21st/thinkphp\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">thinkphp</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：ThinkPHP 是一个免费开源的，快速、简单的面向对象的 轻量级PHP开发框架 ，创立于2006年初，遵循Apache2开源协议发布，是为了敏捷WEB应用开发和简化企业应用开发而诞生的。ThinkPHP从诞生以来一直秉承简洁 实用的设计原则，在保持出色的性能和至简的代码的同时，也注重易用性。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">11、<a target=\"_blank\" href=\"http://git.oschina.net/kymjs/KJFrameForAndroid\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">KJFrameForAndroid</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：KJFrameForAndroid的设计思想是通过封装Android原生SDK中复杂的复杂操作而达到简化Android应用级开发，最终实现快速而又安全高效的开发APP。我们的目标是用最少的代码，完成最多的操作，用最高的效率，完成最复杂的功能。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">12、<a target=\"_blank\" href=\"http://git.oschina.net/rushmore/zbus\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">zbus</a><br style=\"box-sizing: border-box; margin: 0px; padding: 0px;\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">项目简介：ZBUS=MQ+RPC+PROXY 服务总线 &nbsp;1)支持消息队列, 发布订阅, RPC, 代理（TCP/DMZ） &nbsp; 2)亿级消息堆积能力、支持HA高可用 &nbsp;3)无依赖单个Jar包 ~300K &nbsp; 4)丰富的API--JAVA/C/C++/C#/Python/Node.JS多语言接入，支持HTTP/Thrift等协议接入</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">13、<a target=\"_blank\" href=\"http://git.oschina.net/loyin/ECP\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">ECP</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">项目简介：ECP&nbsp; 是基于jfinal、avalon、bootstrap、jqGrid、snaker工作流开发的客户关系及进销存财务系统。支持多企业使用。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">14、<a target=\"_blank\" href=\"http://git.oschina.net/jfinal/jfinal-weixin\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">jfinal-weixin</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：JFinal Weixin 是基于 JFinal 的微信公众号极速开发 SDK，只需浏览 Demo 代码即可进行极速开发，自 JFinal Weixin 1.2 版本开始已添加对多公众号支持。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">15、<a target=\"_blank\" href=\"http://git.oschina.net/farsunset/cim\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">cim</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：基于apache&nbsp; mina 的 java即时通讯服务端。与android 客户端完美结合，同时支持其他语言(ios,c,ActionScript，.net等)客户端的即时通信。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">16、<a target=\"_blank\" href=\"http://git.oschina.net/flashsword20/webmagic\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">webmagic</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：webmagic的是一个无须配置、便于二次开发的爬虫框架，它提供简单灵活的API，只需少量代码即可实现一个爬虫。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">17、<a target=\"_blank\" href=\"http://git.oschina.net/free/Mapper\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">Mapper</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：极其方便的使用Mybatis单表的增删改查。通用Mapper都可以极大的方便开发人员。可以随意的按照自己的需要选择通用方法，还可以很方便的开发自己的通用方法。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">18、<a target=\"_blank\" href=\"http://git.oschina.net/huangyong/smart-framework\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">smart-framework</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">项目简介：轻量级 Java Web 开发框架，内置 IOC、AOP、ORM、DAO、MVC 等特性，基于 Servlet 3.0 规范，使用 Java 注解取代 XML 配置。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">19、<a target=\"_blank\" href=\"http://git.oschina.net/wzw/git-quick-start\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">git-quick-start</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：这是一个git的快速入门项目，使用一些gif图片来播放一些基础的git命令使用方法。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">20、<a target=\"_blank\" href=\"http://git.oschina.net/easypr/EasyPR\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">EasyPR</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：EasyPR是一个中文的开源车牌识别系统，其目标是成为一个简单、高效、准确的车牌识别引擎。 相比于其他的车牌识别系统，EasyPR有如下特点： * 它基于openCV这个开源库。这意味着你可以获取全部源代码，并且移植到java等平台。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">21、<a target=\"_blank\" href=\"http://git.oschina.net/dockerf/docker-training\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">docker-training</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：此次课程是：希云cSphere免费为国内docker爱好者进行docker培训。希云cSphere致力于为企业提供专业的docker管理平台，和paas平台！</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">22、<a target=\"_blank\" href=\"http://git.oschina.net/wenshao/fastjson\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">fastjson</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：fastjson 是一个性能很好的 Java 语言实现的 JSON 解析器和生成器，来自阿里巴巴的工程师开发。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">23、<a target=\"_blank\" href=\"http://git.oschina.net/chunanyong/springrain\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">springrain</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：springrain是spring的极简封装,spring一站式开发的范例。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">24、<a target=\"_blank\" href=\"http://git.oschina.net/jueyue/easypoi\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">easypoi</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：POI 工具类,Excel的快速导入导出,Excel模板导出,Word模板导出,可以仅仅5行代码就可以完成Excel的导入导出,修改导出格式简单粗暴,快速有效,easypoi值得你尝试。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">25、<a target=\"_blank\" href=\"http://git.oschina.net/xautlx/s2jh\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">s2jh</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：基于SSH的企业Web应用开发框架。集结最新主流时尚开源技术的面向企业级Web应用的基础开发框架，提供一个J2EE相关主流开源技术架构整合及一些企业应用基础通用功能和组件的设计实现的最佳实践和原型参考。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">26、<a target=\"_blank\" href=\"http://git.oschina.net/eova/eova\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">eova</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：J2EE快速开发平台，master 为最新代码，稳定版-&gt;请下载最新的Tag版本，Eova仅兼容webkit 内核浏览器，IE和火狐是不兼容的，推荐使用谷歌浏览器。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">27、<a target=\"_blank\" href=\"http://git.oschina.net/wwccss/zentaopms\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">zentaopms</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：禅道是第一款国产的开源项目管理软件。它集产品管理、项目管理、质量管理、文档管理、组织管理和事务管理于一体，是一款专业的研发项目管理软件，完整地覆 盖了项目管理的核心流程。注重实效，合软件架构合理，操作简洁高效，扩展灵活，多语言支持，多风格支持，搜索功能，统计功能——这一切，您通过禅道，都可 以拥有！</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">28、<a target=\"_blank\" href=\"http://git.oschina.net/kuiyu/dotnetcodes\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">DotNetCodes</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：一些常用的功能性代码,可以减少许多开发时间,而且类与类之间没有什么依赖,每个类都可以单独拿出来使用。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">29、<a target=\"_blank\" href=\"http://git.oschina.net/xknaan/B-JUI\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">B-JUI</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：B-JUI（Best jQuery UI） 前端框架，轻松开发，专注您的业务，从B-JUI开始。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">30、<a target=\"_blank\" href=\"http://git.oschina.net/duxcms/DuxCms-2.0\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">DuxCms 2.0</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：DUXCMS是一款针对于中小网站与二次开发平台的一款管理系统，基于canphp3框架，后台采用拼图UI，更加利于多平台使用于开发者快速开发。开发版基于正式版进行的部分优化于实验性功能，不建议作为正式建站使用。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">31、<a target=\"_blank\" href=\"http://git.oschina.net/cynthia/Cynthia\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">Cynthia</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">项目简介：Cynthia提供了一个基于Web的、开源的、跨平台的软件项目管理和问题管理的解决方案。通过极大的灵活度，实现了特殊性和普遍性的统一。 它提供了强大的自定义配置功能，用户能够根据自己的实际情况配置问题的流转和数据模板，它同时内置了强大的Cache模块提高数据的访问效率。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">32、<a target=\"_blank\" href=\"http://git.oschina.net/anycmd/anycmd\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">anycmd</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：一个完全开源的，完整支持rbac的，将会支持xacml、javascript的通用的权限框架、引擎、中间件、解决方案。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">33、<a target=\"_blank\" href=\"http://git.oschina.net/yhtt2020/OpenCenter\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">OpenCenter</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：基于Apache2.0 开源通用 用户及后台管理框架，提供了注册登录、头像裁剪、单点登录、权限管理、扩展资料管理、等级头衔、自定义积分管理、用户行为日志机制、模块装卸、插件机制，提供建议的安装程序。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">34、<a target=\"_blank\" href=\"http://git.oschina.net/dogstar/PhalApi\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">PhalApi</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">项目简介：PHP轻量级开源接口框架，专注于后台接口的快速开发。在移动互联网时代的这十年，希望此框架能对各接口开发有实际的帮助，欢迎使用！我们致力于将PhalApi维护成像恒星一样：不断更新，保持生气；为接口负责，为开源负责！</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">35、<a target=\"_blank\" href=\"http://git.oschina.net/zftlive/zftlive\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">zftlive</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">项目简介：这是一个集成目前Android主流优秀第三方组件、优秀好用的自定义控件、实用工具类封装、以及一些APP共通模块（比如：版本更新、意见反馈、引导界面等等）的开发包，帮助程序员快速开发自己的APP。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">36、<a target=\"_blank\" href=\"http://git.oschina.net/284520459/commonrpc\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">commonrpc</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项 目简介：还在羡慕BAT等公司的大流量的架构吗？让你的java系统引用解耦，互相独立,commonrpc 就可以办到。commonrpc 是一个以netty 传输协议框架为基础， 自定义 spring shcema标签的rpc框架,不侵入任何业务代码，插件模式，即插即用；一个高性能分布式rpc框架，支持tcp，http协议，扩展性强。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">37、<a target=\"_blank\" href=\"http://git.oschina.net/ITdos/Dos.ORM\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">Dos.ORM</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：Dos.ORM（原Hxj.Data）于2009年发布，并发布实体生成工具。在开发过程参考了多个ORM框架，特别是NBear，MySoft、EF、Dapper等。吸取了他们的一些精华，加入自己的新思想。该组件已在上百个成熟企业项目中应用。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">38、<a target=\"_blank\" href=\"http://git.oschina.net/crm8000/PSI\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">PSI</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：PSI是开源进销存系统。PSI是希腊字母Ψ的读音。产品寓意：PSI本身不完美，但追求的是不断改进的品质，距离终极产品就一步之遥(因为在希腊字母表中，Ψ之后是Ω，Ω有终极的意思)。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">39、<a target=\"_blank\" href=\"http://git.oschina.net/loyin/jecp\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">JECP</a><br style=\"box-sizing: border-box; margin: 0px; padding: 0px;\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">JECP 集合了easyui +jfinal +druid+freemarker，非常方便开发。目前只完成了系统管理模块，属于开发整合。具体功能本人时间不多，未能实现。工作流采用的是activiti，目前已在另外的项目中采用。等应用成熟后会后续添加到JECP中。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">40、<a target=\"_blank\" href=\"http://git.oschina.net/mingSoft/MCMS\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">MCMS</a><br style=\"box-sizing: border-box; margin: 0px; padding: 0px;\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：免费开源铭飞MCMS系统完整J2EE代码,提供商城、微信、论坛等更多丰富插件，每月28更新新版本。快的不像JAVA系统。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">41、<a target=\"_blank\" href=\"http://git.oschina.net/X5OK/WeX5\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">WeX5</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：WeX5是跨端移动快速开发框架；只需一次开发，即可发布、运行于各种前端平台上；支持iOS ipa、android apk、微信服务号/企业号应用、web app和其他轻应用的快速开发。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">42、<a target=\"_blank\" href=\"http://git.oschina.net/kyyblabla/QQLikeUI\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">QQLikeUI</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：Qt实现的高仿QQ6.x UI，登录窗体与主窗体已经部分实现，窗体目前还不能自由改变大小，但是可以随意拖动。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">43、<a target=\"_blank\" href=\"http://git.oschina.net/thinkcmf/ThinkCMFX\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">ThinkCMFX</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：ThinkCMF 是一款高速PHP内容管理框架，扩展性良好可高程度的提高开发者的开发效率，节省开发成本。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">44、<a target=\"_blank\" href=\"http://git.oschina.net/jeecg/jeewx-api\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">jeewx-api</a><br style=\"box-sizing: border-box; margin: 0px; padding: 0px;\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：现在微信越来越火，基于微信的公众号和服务号越来越丰富，虽然微信帮助文档已经提供了相关的接口，但是接口比较多，通过代码自己调用比较麻烦，所以为减轻开发者独自创造轮子，将微信API进行了统一封装！</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">45、<a target=\"_blank\" href=\"http://git.oschina.net/20110516/jfinalbbs\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">jfinalbbs</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：使用PHP开发的论坛遍地都是，但使用JAVA来开发社区基本上没有，朋也使用JFinal框架开发了一个属于JAVA语言的社区软件，在这开源供大家借鉴使用，大神勿喷。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">46、<a target=\"_blank\" href=\"http://git.oschina.net/osbzr/openerp-china\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">openerp-china</a><br style=\"box-sizing: border-box; margin: 0px; padding: 0px;\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：OpenERP中国版，降低OpenERP中国社区项目的参与门槛。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; \">47、<a target=\"_blank\" href=\"http://git.oschina.net/beyonehu/manual_dota\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">manual_dota</a><br style=\"box-sizing: border-box; margin: 0px; padding: 0px;\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">项目简介：《刀塔传奇》开源项目，服务器+客户端，蛮牛主办深圳玩贝科技组织。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体;\">48、<a target=\"_blank\" href=\"http://git.oschina.net/ocelot/examxx\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">examxx</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; background-color: rgb(255, 255, 255);\">项目简介：Exam++是国内首款基于JAVA与MYSQL开发的网络考试系统。它可以稳定、顺畅的运行在Windows与Linux平台上。您可以通过它快捷方便的创建试题和题库，发布试卷，组织考试，系统自动批改。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; background-color: rgb(255, 255, 255);\">49、<a target=\"_blank\" href=\"http://git.oschina.net/wangt/webbase\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">webbase</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; background-color: rgb(255, 255, 255);\">项目简介：务系统框架,包括员工管理,组织机构,请假出差申请,流程审批,信息汇总,excel导出等基础功能。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; background-color: rgb(255, 255, 255);\">50、<a target=\"_blank\" href=\"http://git.oschina.net/mkk/HeartBeat\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(62, 98, 166); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; margin: 0px; padding: 0px; outline: 0px; background-color: transparent;\">HeartBeat</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 15pt; font-size: 14px; color: rgb(102, 102, 102); line-height: 22.4px; white-space: normal; padding: 0px; font-family: Verdana, sans-serif, 宋体; background-color: rgb(255, 255, 255);\">项目简介：心跳检测各类应用服务器(如Tomcat,Jetty),WEB服务器(如 Apache,Nginx) 的JAVA WEB应用程序。</p><p><br/></p>', N'c,', N'来自火星的程序猿', N'/59\\70.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'71', N'MS', N'<p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台开发团队承诺MCMS内容管理系统永久完整开源免费(这真是极好的)！下面就简单的给大家介绍一下MS平台和MCMS为什么如此之快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台是铭飞团队经过多年的研发，最终以MCMS为基础，集商城、论坛、分期、会员、支付、积分、微信等系统于一体的插件式系统。并实现了淘宝、京东、苏宁、国美等第三方电商平台数据接口的统一。平台中的小插件如：邮件推送、短信接口、定时任务、促销活动、数据采集等非常丰富。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS的模版采用标签式开发，上手非常快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于技术小白来说不仅避开了学习复杂的高级开发语言,而且MStore有大量成熟的模版直接下载之后换换图片和内容就可以使用,要是需要调整只需要写简单的标签就可以。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于前端工程师来说只需要写好页面样式并在页面内容部分套上标签，就可以做出一套优美的动态网站。并且还可以实现留言板、用户登录等数据交互功能。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MStroe主页：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-align: center; \"><img src=\"/upload/editor/1569/1461658200683.jpg\" title=\"1461658200683.jpg\" alt=\"1461658200683.jpg\" width=\"700\" height=\"375\" style=\"width: 700px; height: 375px;\" border=\"0\" vspace=\"0\"/><img src=\"/upload/editor/1569/1461658233757.jpg\" title=\"1461658233757.jpg\" alt=\"1461658233757.jpg\" width=\"700\" height=\"375\" style=\"width: 700px; height: 375px;\" border=\"0\" vspace=\"0\"/><img src=\"/upload/editor/1569/1461658203315.png\" title=\"1461658203315.png\" alt=\"1461658203315.png\" width=\"700\" height=\"375\" style=\"width: 700px; height: 375px;\" border=\"0\" vspace=\"0\"/></p><p><br/></p>', N'', N'来自火星的程序猿', N'/59\\71.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'72', N'MS', N'<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal; \"><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">首先还是介绍一下什么是CMS。</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">CMS（Content Management System),中文叫作整站系统、文章系统。</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">大概2004以前，如果想进行网站内容管理,基本上都是靠手工维护,但千变万化的信息流，但没有好的程序支持，还继续靠手工完成是不可能的事。</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">如果有一个好的系统来支撑你的网站，那将节省大量的人力物力，开发者就可能给客户一个软件包，可以用它定期人工修改网站。</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">只要你配置安装好，你的编辑，在线记者，更新员只要定期更新数据，剩下的事就交给CMS去处理。</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/></p><h3 style=\"box-sizing: border-box; font-family: 微软雅黑; font-weight: 500; line-height: 28px; color: rgb(37, 37, 37); margin: 0px; font-size: 24px; white-space: normal; padding: 0px; \">铭飞CMS(MCMS)</h3><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal;\"><img src=\"/upload/editor/1569/1461658172067.jpg\" title=\"1461658172067.jpg\" alt=\"1461658172067.jpg\" width=\"700\" height=\"375\" style=\"width: 700px; height: 375px;\" border=\"0\" vspace=\"0\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal;\"><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">特点:</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">&nbsp;</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">Java领域唯一完全免费开源的系统，值得点个赞！在2015年开源中国排名第40位，铭飞cms系统也采用模块化开发，功能可扩展更方便。铭飞还提供了MStore资源平台，提供更多的模版与插件源码，这给整个系统来说增加了很多想象的空间。</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">免费完整开源：</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">基于MIT协议，源代码完全开源，无商业限制,MS开发团队承诺将MCMS内容系统永久完整开源；</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">标签化建站：</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">不需要专业的后台开发技能，只要使用系统提供的标签，就能轻松建设网站；</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">html静态化：</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">系统支持全站静态化；</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">跨终端：</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">站点同时支持PC与移动端访问，同时会自动根据访问的终端切换到对应的界面，数据由系统统一管理；</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">海量模版：</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">铭飞通过MStore（MS商城）分享更多免费、精美的企业网站模版，降低建站成本；</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">丰富插件：</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">为了让MCms适应更多的业务场景，在MStore用户可以下载对应的插件，如：站群插件、微信插件、商城插件等；</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">每月更新：</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">铭飞团队承诺每月28日为系统升级日，分享更多好用等模版与插件；</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">文档丰富：</strong><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">为了让用户更快速的使用MCms系统进行开发，铭飞团队持续更新开发相关文档，如标签文档、使用文档、视频教程等；</span><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><strong style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">评价:</strong><br style=\"box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\"/><span style=\"box-sizing: border-box; color: rgb(37, 37, 37); font-family: 微软雅黑; font-size: 14px; line-height: 28px;\">算是Java领域开源的新星吧，框架的选型都很用心。对一个java程序猿来说二次开发很轻松。小编感觉铭飞并不是一个简单cms系统，从铭飞官方提供的MStore来看，系统可以实现各种业务模块，例如商城、分期系统、淘宝API、微信API等都有提供，同时也关注官方的MS平台，相信这是Java领域的福音。</span></p><p><br/></p>', N'', N'来自火星的程序猿', N'/59\\72.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'73', N'MS', N'<p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; \"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台开发团队承诺MCMS内容管理系统永久完整开源免费(这真是极好的)！下面就简单的给大家介绍一下MS平台和MCMS为什么如此之快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台是铭飞团队经过三年的研发，最终以MCMS为基础，集商城、论坛、分期、会员、支付、积分、微信等系统于一体的插件式系统。并实现了淘宝、京东、苏宁、国美等第三方电商平台数据接口的统一。平台中的小插件如：邮件推送、短信接口、定时任务、促销活动、数据采集等非常丰富。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS的模版采用标签式开发，上手非常快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于技术小白来说不仅避开了学习复杂的高级开发语言,而且MStore有大量成熟的模版直接下载之后换换图片和内容就可以使用,要是需要调整只需要写简单的标签就可以。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; \"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于前端工程师来说只需要写好页面样式并在页面内容部分套上标签，就可以做出一套优美的动态网站。并且还可以实现留言板、用户登录等数据交互功能。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; \"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MStore主页：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体;\"><img src=\"/upload/editor/1569/1461658043545.jpg\" title=\"1461658043545.jpg\" alt=\"1461658043545.jpg\" width=\"700\" height=\"375\" style=\"width: 700px; height: 375px;\" border=\"0\" vspace=\"0\"/></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于学习JAVA开发的工程师来说这无疑是最好的学习项目,并且最大的优势在于整个系统的结构非常清晰,使用的都是当下JAVA最常用最热门的技术,由于MCMS是全部开源并且作为MS的技术架构在使用这也就说明在学习MCMS的同时也学会了相应的框架使用方法。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS结构图解：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\"><a href=\"http://static.oschina.net/uploads/space/2015/1124/231956_5q0R_2501041.png\" target=\"_blank\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"><img src=\"/upload/editor/1569/1461658055795.png\" title=\"1461658055795.png\" alt=\"1461115606898073191.png\"/></a></span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px; \"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS的群站解决方案和模块式的开发架构，让我们管理项目非常方便。不仅很好的解决了因为项目过多而导致的管理紊乱现象，而且还在一定程度上使服务器的资源得到最大化的利用，也避免同时维护多套系统的繁杂。由于是纯JAVA系统这里安全性完全可以放心。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">由于MS平台采用的是模块和插件式的开发,这又进一步从代码层面上提升了我们维护简便性和针对性，而不是像传统项目那样需要维护整套代码。比如：短信插件出问题了那么我们只需要单独的去维护端短信插件即可，其他插件模块不会因为短信插件在维护而受到影响。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台采用模块式开发，严格的说MCMS只是属于MS平台中的一个基础模块。这给定向业务和第三方平台的接入提供了很好的结构支持，从另一个角度来说MCMS严格的遵循了开闭原则，是支持无限拓展的。并且每一次拓展都不会伤害到原有的代码。不仅从结构上保障了系统的开发速度而且不会因为系统的升级或者是插件影响到系统的稳定性。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">同时MCMS将底层复杂的前端代码和第三方接口以及JDK中常用的方法做了很完善的二次封装，从代码角度来讲也大大的节省的开发时间。做到了真正的让代码飞起来！而且更为难得的是这些封装都具有极强规律性，和易用性这里简单的给大家举几个例子：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">封装的freemarker</span><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><a href=\"http://static.oschina.net/uploads/space/2015/1124/232023_95Ky_2501041.png\" target=\"_blank\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"><img src=\"/upload/editor/1569/1461658065646.png\" title=\"1461658065646.png\" alt=\"1461115607308036067.png\"/></a></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">封装表单</span><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">：</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><a href=\"http://static.oschina.net/uploads/space/2015/1124/232050_rWXe_2501041.png\" target=\"_blank\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"><img src=\"/upload/editor/1569/1461658076477.png\" title=\"1461658076477.png\" alt=\"1461115607472060206.png\"/></a></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台中有大量的插件和模版可以使用资源非常丰富，目前已经发布或者计划发布的官方模版有八套，开发者提交并且还在审核中的有162套，并且还在以每天10套左右的速度增加。目前已经发布或者准备发布的官方插件有：BBS(论坛)，商城，微信，分期，短信，淘宝，支付等由于数量众多这里就不一一列举。开发者提交的有短信模版插件、邮件模版插件、淘宝开放平台插件等其中大部分还在审核阶段。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台的资源之所以如此丰富插件和模块。一方面除了系统从结构上支持无缝对接之外，MS平台还拥有一大批优质的开发者。开发者在平台提交优质插件之后定价权在自己手中，这又从另外一个角度上大大刺激了海量优质插件的诞生。</span></p><p><br/></p>', N'h,', N'来自火星的程序猿', N'/59\\73.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'74', N'MS', N'<h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px; \">铭飞MCMS内容管理系统完整开源版J2EE代码</h1><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">当前版本:5.4.2 铭飞MS官网:http://ms.mingsoft.net官网同时提供一键运行版本下载，请步移官网....</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal;\"><span id=\"OSC_h1_2\" style=\"box-sizing: border-box; padding: 0px; margin: 0px; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span><span style=\"box-sizing: border-box; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span></p><h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px;\"><a href=\"http://git.oschina.net/mingSoft/MCMS#特点\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"></a>特点</h1><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">免费开源:纯Java开发，MS开发团队承诺将MCMS内容系统永久完整开源;</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">终端统一: 铭飞MCMS支持PC与MOBILE皮肤定制,同时使用MS团队移动JS插件,轻松实现手机多屏幕适配,想想看你发布的信息第一时间在PC上展示又能在手机上展示,这是件多么幸福的事情,数据统一、平台统一、终端统一是MS团队一直在努力的方向;</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">扩展性:以铭飞MCMS为核心,MS官网提供第三方插件安装,最新的插件用户可以通过更新功能获得,同时MS也鼓励并支持第三方开发人员发布优质的插件;</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">更新升级: 铭飞MCMS提供了行业内最完美的升级方案,从此升级无需手动下载复制粘贴,一切完全由MS升级插件无缝完成;</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">文档手册:铭飞不断向外部公布最新文档，如二次开发手册、标签使用手册,减轻用户学习成本;</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">站群：MCMS支持站群，只需在服务器上架设一套铭飞MCMS就可以创建多个个网站，并且网站之间的数据是独立存在，很大程度降低了维护成本，与服务器资源的开销；</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">其他：html静态生成、标签式建站</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">技术支持:提永久升级服务技术交流群,不定期会升级系统，开发可以关注后台的更新板块；</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal; \"><span id=\"OSC_h1_3\" style=\"box-sizing: border-box; padding: 0px; margin: 0px; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span><span style=\"box-sizing: border-box; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span></p><h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px;\"><a href=\"http://git.oschina.net/mingSoft/MCMS#面向对象\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"></a>面向对象</h1><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">铭飞MCMS是企业在创立初期很好的技术基础框架，加快公司项目开发进度，当然也可以对现有的系统进行升级；</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">个人开发者也可以使用MCMS承接外包项目；</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">初学JAVA的同学可以下载源代码来进行学习交流；</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal;\"><span id=\"OSC_h1_4\" style=\"box-sizing: border-box; padding: 0px; margin: 0px; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span><span style=\"box-sizing: border-box; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span></p><h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px;\"><a href=\"http://git.oschina.net/mingSoft/MCMS#开发框及语言\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"></a>开发框及语言</h1><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">铭飞MCMS(铭飞内容管理系统)是一款支持不同平台、不同终端并且支持多站点的内容管理系统，</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">· SpringMVC4+Spring4+MyBatis3+Freemarker技术架构</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">· 基于java技术开发，继承其强大、稳定、安全、高效、跨平台等多方面的优点；</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">· 标签化建站，只要你懂html就能建站；</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">· 完全生成全站静态页面；</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">· 可自定义路径结构，全面提高页面访问速度；</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">有人说铭飞MCMS是全国唯一完整开源的J2EE版本系统！团队希望看到更多的优秀好用的开源系统，我们一直会努力下去！</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal; \"><span id=\"OSC_h1_5\" style=\"box-sizing: border-box; padding: 0px; margin: 0px; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span><span style=\"box-sizing: border-box; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span></p><h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px; \"><a href=\"http://git.oschina.net/mingSoft/MCMS#运行环境\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"></a>运行环境</h1><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">原则上支持全系列JAVA运行环境；</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">WEB服务器：Weblogic、Tomcat、WebSphere、JBoss 等</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">数据库服务器：Mysql等</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">操作系统：Windows、Linux、Unix 等</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal;\"><span id=\"OSC_h1_6\" style=\"box-sizing: border-box; padding: 0px; margin: 0px; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span><span style=\"box-sizing: border-box; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span></p><h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px;\"><a href=\"http://git.oschina.net/mingSoft/MCMS#开发环境\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"></a>开发环境</h1><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">建议开发者使用一下环境，这样避免版本带来的冲突</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">IDE:eclipse、MyEclise</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">DB:Mysql5.5</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">JDK:JAVA 7、J2EE6</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal;\"><span id=\"OSC_h1_7\" style=\"box-sizing: border-box; padding: 0px; margin: 0px; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span><span style=\"box-sizing: border-box; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span></p><h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px;\"><a href=\"http://git.oschina.net/mingSoft/MCMS#重要文件说明\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"></a>重要文件说明</h1><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">数据库连接文件: config.properties</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">数据库文件：doc/db-mcms-open.sql</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">数据库编码：UTF-8</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">模板文件：templets/1549/mooc</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">后台访问路径：</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">http://+ip地址（或localhost）+tomcat端口+项目发布名/ms/login.do</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">如果出现无法访问的情况输入</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">http://+ip地址（或localhost）+tomcat端口+项目发布名/initApp进行初始化</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">账号:msopen</p><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">密码:msopen</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal; \"><span id=\"OSC_h1_8\" style=\"box-sizing: border-box; padding: 0px; margin: 0px; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span><span style=\"box-sizing: border-box; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span></p><h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px; \"><a href=\"http://git.oschina.net/mingSoft/MCMS#代码部署与常见问题\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\"></a>代码部署与常见问题</h1><p style=\"box-sizing: inherit; margin-top: 0px; margin-bottom: 15px; font-size: 15px; color: rgba(0, 0, 0, 0.8); line-height: 1.33; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Lato, &#39;Helvetica Neue&#39;, &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif; background-color: rgb(250, 250, 250);\">铭飞MS官方开发社区文档&nbsp;<a href=\"http://ms.mingsoft.net/mbbs/12998/detail.do\" target=\"_self\" rel=\"nofollow\" style=\"box-sizing: border-box; color: rgb(255, 131, 115); text-decoration: none; -webkit-transition: all 0.5s; transition: all 0.5s; padding: 0px; margin: 0px; outline: 0px; font-size: 12px; background-color: transparent;\">http://ms.mingsoft.net/mbbs/12998/detail.do</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; font-size: 0.95em; color: rgb(102, 102, 102); line-height: 1.8em; font-family: 微软雅黑, &#39;Open Sans&#39;, sans-serif; white-space: normal; \"><span id=\"OSC_h1_9\" style=\"box-sizing: border-box; padding: 0px; margin: 0px; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span><span style=\"box-sizing: border-box; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px; line-height: 22.5px;\"></span></p><h1 style=\"box-sizing: border-box; margin: 20px 0px 10px; font-size: 24px; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-weight: 500; line-height: 43.2px; color: rgb(51, 51, 51); white-space: normal; padding: 0px; \">系统美图</h1><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; \"><img src=\"/upload/editor/1569/1461657686925.jpg\" title=\"1461657686925.jpg\" alt=\"1461657686925.jpg\" width=\"700\" height=\"375\" style=\"width: 700px; height: 375px;\" border=\"0\" vspace=\"0\"/></p><p><br/></p>', N'', N'来自火星的程序猿', N'/59\\74.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'112', N'', N'<p><strong>主营品牌车型：</strong>奔驰、宝马、奥迪、路虎、保时捷、宾利、劳斯莱斯、北京现代、上海大众斯柯达、东风标致、东风悦达起亚、东风雪铁龙、东风本田雪弗兰、上海大众、进口大众、道奇、吉普、雷诺、别克、马自达、中华、福特、海南马自达等各种中高档进口和国产轿车。在汽车销售行业里有着较高的知名度和良好的信誉。</p><p>经营业务：除了销售各种品牌车外，还经营汽车保险、汽车装潢、汽车按揭、二手车评估、二手车收购、二手车置换，并免费为您提供上牌等一条龙服务。</p><p>&nbsp;</p><p><strong>郑重承诺：</strong>保证您从我公司购买的车是全市场上最低的价格，让您购的放心， 我公司所售车辆均为各品牌4S店的车，选车、交钱、提车、开发票、售后保养，一切的一切都在4S店办理，我们就相当于是4S店的跑量销售员（批发价）。 说白了，就是您在4S店买车我们帮您还价。 您在我公司定了车以后，我们会安排4S店的销售员和你联系。</p><p><strong>经营宗旨：</strong>减少成本和跑量给消费者带来最大的实惠！金杯银杯不如客户的口碑！只要您买过就会介绍朋友来买！</p><p>宝诚导购流程：我公司为了让大家更放心的购买汽车，现进行经营模式调整，较以前更加灵活、更加方便、更具备人性化。如果有客户觉得我们的价格比较实惠，但又担心车的来源，在这种情况下，我公司对有顾虑的客户，我们帮您排除这个疑虑。在我们公司签定车合同后，我们安排4S店销售员和您联系，办理所有相关手续。具体导购流程如下：</p><p><strong>第一步：</strong>您可以先到您所需品牌的任何一家4S店看车，选车，然后决定要什么车型。</p><p><strong>第二步：</strong>决定好所需车型，在某品牌4S店进行砍价，和销售员谈个最低价，但切忌不要交定金。</p><p><strong>第三步：</strong>拨打我们公司电话，告诉我们您需要的车型和颜色，以及哪家4S店。和我们谈好您觉得的满意的价格，我们觉得有钱可赚（少赚点没关系，不亏就行），意见达成一致。</p><p><strong>第四步：</strong>直接到我们公司签定车合同并交付定金。<br/><strong>第五步：</strong>我公司安排销售人员陪同客户去4S店提车并办理相关手续。</p><p><br/></p>', N'h,', N'公关前台', N'/61/87\\112.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'113', N'', N'<p><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">&nbsp;</span><strong style=\"font-size: 14px; white-space: normal; font-family: 宋体; line-height: 22px; padding: 0px; margin: 0px; background-color: rgb(255, 255, 255);\">1、特色服务</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\"></span></p><p>1.1 提供专业的危险品一条龙服务，从专业的危险品取样，代做报告（化工报告和商检报告危包证），及提供报关单证，报关，申报，交接危险品货物，至货物安全的到达目的港，全方位的D/D TO D/D 服务；</p><p>1.2 东航，国泰，阿联酋，汉莎4GV包装使用备案免检企业，可采用4GV作为货物外包装，免于检验；</p><p>1.3 能够协助客户用MSDS 来代替化工报告的业务。</p><p>&nbsp;</p><p><strong style=\"padding: 0px; margin: 0px;\">2、&nbsp;常规服务</strong></p><p>2.1 订舱：快捷、顺畅、全面快捷</p><p>便捷多样的订舱渠道（EK，MU，CX，LH，KL，AF，FM，CA等）顺畅：熟悉各航空公司危险品订舱要求及操作流程。全面：承接全球各航空公司航线化工品、危险品运输</p><p>2.2 仓库 运输</p><p>提供全方位专业的打托、包装、唛头、标签及更换外包装等服务；公司自备各类具有危险品资质的车辆，满足客户上门提货的需求。</p><p>2.3 报关、报检</p><p>代办空运危险品的报关报检,上海化工院鉴定，IMI鉴定证书，代做危包证等服务。</p><p>2.4 货物查询</p><p>E-SERVICE：自助式网上查询系统，方便客户跟踪、查询货物状态。</p><p>&nbsp;</p><p><strong style=\"padding: 0px; margin: 0px;\">3、 实力资质</strong></p><p>3.1 专业人员</p><p>资深的客户服务人员、订舱操作人员、危险品货物交接人员，拥有丰富的化工品、危险品专业知识和具有良好的沟通能力，熟悉各航空公司对危险品的操作流程。</p><p>3.2 完善系统</p><p>专业的流程化订舱体系ERP操作系统，从接单、订舱、货物包装商检、报关交接等一系列货物运输环节，R-Q HSE安全控制体系，监控并确保货物安全规范运输。</p><p>3.3 资质及设施</p><p>中国外经贸部批准的一级货运代理证书，中国航空运输协会批准颁发的一级货运代理证书，中国货代百强企业；</p><p>操作人员拥有中国航协ITAT 颁发的危险品操作人员证书和DGM 及浦东机场货栈颁发的危险品资质证书；</p><p>在机场内拥有6000平方米的普通仓库，4000 平方米的专业危险品仓库，齐备叉车，打包机等专业的仓储设备，120辆专用危险品运输车辆为客户提供专业、安全、便捷、快速的仓储及配送服务。</p><p><br/></p>', N'c,', N'总经理', N'/61/87\\113.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'130', N'', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">广州城市规划设计有限公司是中欧国际旅游规划设计研究院（Sino-Europe Academy of Tourism Planning and Design）旗下之专业机构，公司专注于城市规划、旅游规划设计与商业综合体设计，构建了从规划设计、品牌营销、资本运作到管理咨询等全产品链集成一体化服务，提供从总体策划、建筑景观设计、资源引进、战略实施、平台搭建到运营管理等全程、专业化解决方案。</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><br style=\"margin: 0px; padding: 0px; border: 0px;\"/>广州规划设计以“产业联动、搭建平台、金融孵化”为经营哲学，推动旅游业与民俗艺术、饮食、地产、绿色农业及金融业的融合发展，同时依托中欧国际旅游规划设计研究院的学术背景与国际资源，搭建行业交互平台，提供切合旅游企业需要的一揽子专业协同服务。<br style=\"margin: 0px; padding: 0px; border: 0px;\"/><br style=\"margin: 0px; padding: 0px; border: 0px;\"/>广州规划设计秉持“文化开发与生态保护相结合”的规划设计理念，切实将“因地制宜、以人为本、市场引导、经济可行、体验为怀、低碳环保”的精神贯穿于每一个项目之中，倡导空间与艺术相结合、经济与美学相融合、历史文明与现代时尚相调和，力求每个作品都能达到人文景观与大自然的和谐完美融合。<br style=\"margin: 0px; padding: 0px; border: 0px;\"/><br style=\"margin: 0px; padding: 0px; border: 0px;\"/>广州规划设计与国际行业组织、海内外同行及国内知名高等院校如香港大学、中山大学、同济大学、广东财经大学等建立和保持着密切的合作与互动关系，致力于整合行业高端智慧，引进行业优质资源，推动中国旅游业迈向更高的竞争层次。</p><p><br/></p>', N'h,', N'关于我们', N'/93\\130.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'131', N'', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">广州规划设计在为客户提供市场分析和战略规划服务的基础上，确保初步规划和概念逐渐成形最终落地运营的产品。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">广州</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">规划设计的业务范畴主要集中在旅游规划、城市规划、建筑设计与景观设计，构筑了策划、规划、设计、营销、资本引进与管理咨询等全程服务。同时，帮助客户了解市场行情、评估风险、厘清发展计划、商业战略和公共政策内在的不确定因素。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">广州</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">规划设计在打造景区特色、建立生态系统、营造文化环境等多领域都有着不可撼动的行业地位，规划业务服务集中在总体规划、城市规划、区域规划、旅游商业模式策划、生态环境规划、城市战略规划等。根据项目的不同尺度和背景，有选择地搭配合适的各项专业人才团队，为客户提供全面而合理的解决方案</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><br style=\"margin: 0px; padding: 0px; border: 0px;\"/>广州规划设计与国际行业组织、海内外同行及国内知名高等院校如香港大学、中山大学、同济大学、广东财经大学等建立和保持着密切的合作与互动关系，致力于整合行业高端智慧，引进行业优质资源，推动中国旅游业迈向更高的竞争层次。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><br/></p><h1 style=\"margin: 0px; padding: 0px; border: 0px; font-size: 12px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 25px; text-align: justify; white-space: normal;\">经营哲学：</h1><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><br/></p><p><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">用智慧与资本描摹设计蓝图</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">中国旅游业已经跨入互联网时代的大门中，互联网正在彻底颠覆传统咨询业的知识架构和业务模式，CEDAR站在互联网大潮的浪尖上，以高瞻的视角描摹着旅游行业的发展蓝图。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">&nbsp; &nbsp; &nbsp; ●&nbsp;产业联动</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">互联网时代正在颠覆旅游业传统的商业模式。CEDAR积极应对这种变革，依托中欧国际旅游规划设计研究院（SEATPD）的资源优势，推动文化、地产与旅游业的横向联合发展，以此延伸到移动互联、绿色农业、金融资本、现代物流业等产业领域。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">&nbsp; &nbsp; &nbsp; ●&nbsp;搭建平台</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">互联网时代的行业生态系统也在发生着改变。以往单一、专业式的服务模式不再为客户所青睐，CEDAR创新构建协同式、交互式、大数据、系统服务式的行业平台，整合行业各专业领域的优势资源，基于共同的平台进行专业协作，为旅游业提供一揽子系统化的解决方案。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">&nbsp; &nbsp; &nbsp; ●&nbsp;金融孵化</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">大平台的背后是高度的智慧与资源整合，更是金融资本的有效支撑。CEDAR协助旅游企业开发设计植入性产品，做好定制化产品的孵化，开展引资融资服务，帮助客户在产业版图拓展中淘金。同时，以规划设计为撬动点，通过小资本或技术入股，撬动大资本大产业。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/></p><h1 style=\"margin: 0px; padding: 0px; border: 0px; font-size: 12px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 25px; text-align: justify; white-space: normal;\">服务能力：</h1><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp; &nbsp; &nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp; &nbsp; &nbsp;</p><h1 style=\"margin: 0px; padding: 0px; border: 0px; font-size: 12px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 25px; text-align: justify; white-space: normal;\">产业咨询：</h1><p><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">CEDAR专家以宏观、战略、系统、科学、可操作性的视角，为客户提供产业整体发展咨询，服务涉及项目的前期市场研究、战略定位、产品开发、空间结构规划、区域规划、旅游品牌营销到景区的企业管理、企业文化、人力资源等全方位一揽子主导整合服务。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><strong style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">规划设计</strong><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">CEDAR规划设计包括旅游区及城市商业综合体的景观设计、建筑设计及环境文化设计。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">我们主张设计创新，试图对每一处场景赋予独一无二的精神，并合理地对景观建筑、规划资源进行配置与优化，加强景观、建筑与规划领域的互动，为客户提供从城市规划、建筑设计到景观设计的全程化、一体化、专业化解决方案。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><strong style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">品牌营销</strong><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">&nbsp;CEDAR依托团队丰富的品牌管理与营销策划能力，为旅游品牌提供从市场研究、品牌形象策划、整合营销传播、公共关系到节事会展营销等整合系统服务。</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><strong style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">资本运作</strong><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">CEDAR不仅推动规划设计的科学前瞻，更愿意借助中欧国际旅游规划设计研究院（SEATPD）的国际背景、宽厚人脉及资源整合力，打造旅游企业的金融孵化平台，通过“咨询管理+ 资本运作”的模式，为旅游业发展引进资本、人才、管理体系、商业模式、企业文化、市场营销等综合支撑。</span></p><p><br/></p>', N'f,', N'关于我们', N'/93/94\\131.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'132', N'CORPORATE PART', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">全心全力，美善相随，</span><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">这个世代不缺技艺超群之才，</span><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">却匮乏尽心尽力之士，</span><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">CEDAR信实守约</span></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">捧着一颗心来，不带半根草去，竭力置身于客户的立场换位思考，除去一切不利于客户利益的自我私欲</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">精诚坦荡，肝胆相照，将自己的专业本色全意展现，为客户创造超值的服务体验 &nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><br/></p><p><br/></p>', N'h,', N'CORPORATE CULTURE', N'/93/95\\132.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'133', N'张三', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px; font-size: 13px; line-height: 25px; text-align: justify; color: rgb(134, 134, 134); font-family: &#39;Microsoft YaHei&#39;;\">广州规划设计，立足于互联网思潮下商业模式创新的宏大视野，以科学的规划设计为基点，以战略执行、资源导入、品牌营销、管理咨询为后续深度服务，联袂海内外卓越专业机构，构筑行业智慧高地，并搭建行业性交互式平台，推动旅游业持续稳健地发展。&nbsp;</span><br style=\"margin: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; color: rgb(134, 134, 134);\"/><br style=\"margin: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; color: rgb(134, 134, 134);\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; color: rgb(134, 134, 134);\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\"><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(102, 102, 102); font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\">战略学术联盟：</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; color: rgb(134, 134, 134);\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; color: rgb(134, 134, 134);\"><br/>&nbsp;&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; color: rgb(134, 134, 134);\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\"><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(102, 102, 102); font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\">战略设计联盟：</span></strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; color: rgb(134, 134, 134);\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; color: rgb(134, 134, 134);\"><span style=\"margin: 0px; padding: 0px; border: 0px; line-height: 1.5;\"><span style=\"margin: 0px; padding: 0px; border: 0px; font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\">MORMANFOSTER</span><strong style=\"margin: 0px; padding: 0px; border: 0px;\"><span style=\"margin: 0px; padding: 0px; border: 0px; font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></strong></span><span style=\"margin: 0px; padding: 0px; border: 0px; line-height: 1.5;\"><span style=\"margin: 0px; padding: 0px; border: 0px; font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\">乐昂国际设计集团</span><span style=\"margin: 0px; padding: 0px; border: 0px; line-height: 1.5;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\"><span style=\"margin: 0px; padding: 0px; border: 0px; line-height: 1.5; font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></span></strong></span></span><span style=\"margin: 0px; padding: 0px; border: 0px; line-height: 1.5; font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\">香港郑中设计师事务所</span><strong style=\"margin: 0px; padding: 0px; border: 0px; line-height: 1.5;\"><span style=\"margin: 0px; padding: 0px; border: 0px; line-height: 1.5; font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></span></strong><span style=\"margin: 0px; padding: 0px; border: 0px; line-height: 1.5; font-size: 12px; font-family: &#39;Microsoft YaHei&#39;;\">中国建筑装饰集团</span></p><p>&nbsp;</p><p><br/></p>', N'p,', N'THE MEANING OF THE DESIGN IS TO SEEK HARMONY BETWEEN PEOPLEOTHER/, ARCHITECTUREOTHER/, NATURAL AND OF WISDOM', N'/93/97\\133.html', N'设计的意义在于寻求人、建筑、自然之间相融与相生的智慧', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'134', N'', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><span style=\"margin: 0px; padding: 0px; border: 0px; font-family: Arial, 宋体, SimSun, HELVETICA, &#39;Hiragino Sans GB&#39;; font-size: 14px; line-height: 26px; text-indent: 28px;\">2009年12月13日由中国民族建筑研究会与中国</span>房地产<span style=\"margin: 0px; padding: 0px; border: 0px; font-family: Arial, 宋体, SimSun, HELVETICA, &#39;Hiragino Sans GB&#39;; font-size: 14px; line-height: 26px; text-indent: 28px;\">及住宅研究会共同主办，“2009?第六届中国人居典范建筑规划设计方案竞赛”颁奖大会在北京?京都信苑饭店隆重召开。经过九个多月来的精心组织与评选，全国共有241个方案获奖。通过本届竞赛，在全国建设领域树立一批人居规划设计典范，对促进全国建筑规划设计和建设水平的提高起到示范推动作用。</span></p><p><br/></p>', N'', N'关于我们', N'/93/96\\134.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'135', N'', N'<p><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); text-align: justify; font-family: Arial, 宋体, SimSun, HELVETICA, &#39;Hiragino Sans GB&#39;; font-size: 14px; line-height: 26px; text-indent: 28px;\">2009年12月13日由中国民族建筑研究会与中国</span><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">房地产</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); text-align: justify; font-family: Arial, 宋体, SimSun, HELVETICA, &#39;Hiragino Sans GB&#39;; font-size: 14px; line-height: 26px; text-indent: 28px;\">及住宅研究会共同主办，“2009?第六届中国人居典范建筑规划设计方案竞赛”颁奖大会在北京?京都信苑饭店隆重召开。经过九个多月来的精心组织与评选，全国共有241个方案获奖。通过本届竞赛，在全国建设领域树立一批人居规划设计典范，对促进全国建筑规划设计和建设水平的提高起到示范推动作用。</span></p>', N'h,', N'关于我们', N'/93/96\\135.html', N'最佳设计方案', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'136', N'1', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">广州规划设计以金融资本为支撑，以规划设计为撬动点，协助旅游业开发高潜力项目，推动项目融资，帮助客户在产业版图拓展中淘金入市。</span></p>', N'', N'关于我们', N'/93/98\\136.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'137', N'', NULL, N'', N'', N'/100\\137.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'138', N'', NULL, N'', N'', N'/100\\138.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'139', N'', NULL, N'f,', N'', N'/100\\139.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'140', N'', NULL, N'', N'首页幻灯', N'/100\\140.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'141', N'', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: left; white-space: normal;\"><span style=\"margin: 0px; padding: 0px; border: 0px;\">-&nbsp;城市商业综合体规划&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px;\">-&nbsp;新城（新区）规划&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px;\">-&nbsp;温城市更新与旧城改造</span><br style=\"margin: 0px; padding: 0px; border: 0px;\"/><span style=\"margin: 0px; padding: 0px; border: 0px;\">-&nbsp;小城镇建设规划&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px;\">-&nbsp;历史文化名城/镇保护研究与规划&nbsp;</span><span style=\"margin: 0px; padding: 0px; border: 0px;\">-&nbsp;产业园区规划</span></p><p style=\"text-align: left;\"><span style=\"margin: 0px; padding: 0px; border: 0px;\"><br/></span></p><p style=\"text-align: center;\"><br/></p>', N'', N'专业服务', N'/99/101\\141.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'142', N'', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">CEDAR以美学与生态的双重视野开展环境艺术的探索与实践，营造健康、高雅、舒适、美观的现代生态环境，以此提升城市及旅游景区的软环境。</span></p>', N'c,', N'专业服务', N'/99/102\\142.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'143', N'', N'<p>在把握好旅游地的地脉（地理根据）、文脉（文化根据）和商脉（市场根据）的基础上，为旅游地做好旅游形象定位，并开展理念基础（MI）、行为准则（BI）、视觉形象（VI）的系统策...</p>', N'p,', N'专业服务', N'/99/103\\143.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'144', N'', N'<p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em\">目的地与景区管理：</p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em\"><span style=\"line-height: 27px; text-indent: 2em;\">-&nbsp;发展战略规划</span><span style=\"line-height: 27px; text-indent: 2em;\">-&nbsp;营销管理体系咨询</span><span style=\"line-height: 27px; text-indent: 2em;\">-&nbsp;品牌管理体系咨询</span></p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em\">-&nbsp;组织架构与流程再造<span style=\"text-indent: 2em;\">-&nbsp;投资运营与管理</span><span style=\"text-indent: 2em;\">-&nbsp;资源与环境保护</span></p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em\">&nbsp;</p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em\"><span style=\";padding: 0px;border: 0px;line-height: 25px;text-indent: 28px\">酒店管理：</span></p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em\">-&nbsp;酒店运营管理<span style=\"text-indent: 2em;\">-&nbsp;酒店物业管理</span><span style=\"text-indent: 2em;\">-&nbsp;酒店产品与服务管理</span></p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em\">-&nbsp;酒店人力资源管理<span style=\"text-indent: 2em;\">-&nbsp;酒店投资与财务管理</span><span style=\"text-indent: 2em;\">-&nbsp;酒店危机管理</span></p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em\">&nbsp;</p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em\">住宿业管理：&nbsp;&nbsp;</p><p style=\"margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em\">为酒楼、茶楼、旅馆、非星级宾馆等住宿接待业提供经营管理咨询服务。</p><p><br/></p>', N'h,', N'专业服务', N'/99/104\\144.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'146', N'MS', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">项目地址：广东梅州市雁洋镇 规划面积：1，281，863平方米 项目委托：广东梅州市人民政府</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">全世界客家人的首都，客家文化的遗产中心</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">雁洋的自然环境、人文历史以及作为世界自然度假胜地门户的地理位置，与梅州市的城市特色和资源形成互补，为当地居民及国内外游客提供一种轻松的绿色体验。我们试图通过推广建筑、农业、文化资源的保护，把现有的文化基础设施开发成为世界级别的旅游胜地。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/13015313Q-0.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/>&nbsp;<img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/1301531A9-1.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/>&nbsp;<img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/1301531L5-2.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/1301531937-3.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/></p><p><br/></p>', N'', N'来自火星的程序猿', N'/106/107\\146.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'147', N'MS', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">项目地址：海南省海口市北部海口湾西部滨海地区</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">总用地面积：47957.1平方米</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">总建筑面积：116154.65平方米</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">总地上建筑面积：94523.55平方米</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">总地下建筑面积：21631.1平方米</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">委托单位：某地产集团海南公司&nbsp;&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">海口湾时尚度假新平台</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">设计定位：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">功能定位-----&nbsp;提供度假体验的产权式酒店，并引入购物、娱乐、餐饮等多元复合功能；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">形象定位-----&nbsp;海口城市形象的名片，塑造融入城市环境的建筑形象，与滨海景观相协调。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">设计策略：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">区域融合与区域发展融为一体；功能复合，丰富海口湾岸线景观。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">建筑设计策略：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">商业集中布局；景观视线保障；建筑退台设计；绿色节能规划。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/152SJ546-0.png\" width=\"45%\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/>&nbsp;<img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/152SKH7-1.png\" width=\"45%\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/152SL340-2.png\" width=\"45%\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/>&nbsp;<img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/152SK302-3.png\" width=\"45%\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/></p><p><br/></p>', N'h,', N'来自火星的程序猿', N'/106/108\\147.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'148', N'MS', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">周庄拥有丰富的自然资源、人文资源及极具优势的地理位置，区域发展潜力巨大，古镇旅游品牌价值大，区域发展热点已经形成，旅游经济的发展为房地产市场提供了巨大的想象空间。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">我们的项目研判与理解：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">-&nbsp;天生丽质，但区域发展态势不明朗；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">-&nbsp;以前瞻性的眼光，组合运营多元化地产运营模式，与周边项目形成错位，整合旅游、休闲、度假、商务、商业与投资资源，方可突出重围。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">项目总体概念定位：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">液体周庄-------&nbsp;未来水乡</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">“未来水乡概念”·&nbsp;复合型旅游休闲港湾&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">功能定位：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">复合型旅游休闲港湾&nbsp;-------</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">集中于“休闲”功能，满足“在家度假”的生活梦想。以“液态生活”为主题，用原生态的景观，再现原汁原味的水乡生活。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">水乡生活体验基地&nbsp;---&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">其功能主要集中在“体验”上，营造休闲的氛围，形成与都市截然不同的氛围，创造一种江南文化的现代体验。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">商业空间规划：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">&nbsp;</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/152I12344-0.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/>&nbsp;<img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/152I16160-1.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"text-align:center;margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">由沿路商街和船概念水街构成&nbsp;</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">沿路商街的主题：渔人码头</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">- 主要经营特色餐饮、新派江南菜；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">- 手工艺品，生活气息浓郁为特色；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">- 江南古董店。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">船概念水街的主题：在水一坊</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">- 茶坊、咖啡店；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">- 鱼、蟹、虾等特色水产品；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">- 菱角等水产植物。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p><strong style=\"margin: 0px; padding: 0px; border: 0px;\">项目推广：</strong></p></li></ul><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">总体定位&nbsp;-------&nbsp;品质派旅游地产商</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">Slogan：江南液上海，休闲水乡情</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><br/></p><p><br/></p>', N'', N'来自火星的程序猿', N'/106/109\\148.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'149', N'MS', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">项目地址：浙江杭州、苏州</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">项目委托：杭州市旅游局、苏州市旅游局</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">运河文化，吴地风情</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">在现代旅游业的发展当中，旅游形象设计正在发挥着越来越重要的作用。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">旅游形象设计能使旅游地政府和公众对本地旅游的资源核心、产品定位和发展目标有更清楚地认识，使旅游地在众多的同类产品中以鲜明的姿态出现在旅游者面前。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">本次苏杭大运河旅游形象策划，我们是在大运河杭州、苏州段旅游市场和旅游资源分析的基础上，结合对规划区域地方性的研究和受众特征的调查分析，提出了明确的区域旅游形象的核心理念和外在界面。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">地方性研究：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">前期我们开展地方性研究、受众调查和分析、形象替代性分析等，同时，主要讨论和创建旅游形象的具体表达，如理念、传播口号、视觉符号等。对京杭段古运河旅游形象构成的背景要素、地方性特征要素、形象修正要素进行了详细的分析，并对游客认知特征进行了调查研究，为进一步旅游形象设计奠定了基础。后面主要根据前期研究成果，创建旅游形象的具体表达体系。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">策划思路：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">古运河旅游形象的设计采用“用形象口号作为形象定位的精辟表达”的方法。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">主要有两种设计思路：</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">第一，采取资源导向型旅游形象口号的设计模式，或者运用白描、比喻、夸张等表现手法自我阐释自己的资源优势，或者采用领先、比附、衬托等表现手法比较阐释自己的资源优势；</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">第二，采取游客导向型旅游形象口号的设计模式，或者运用感情、借势、公关、悬念等表现手段来刺激旅游需求，或者运用距离、时间、心理、承诺等表现手段来克服潜在旅游者的出游阻力&nbsp;。&nbsp;&nbsp;&nbsp;&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\"><strong style=\"margin: 0px; padding: 0px; border: 0px;\">整体形象定位：</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">“清名运河图，江南绝版地”&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">运河形象体系构建：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">1、品牌标识系统设计；&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">2、宣传口号提炼；&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">3、品牌音乐符号：&nbsp;&nbsp;以运河音为体，创作出适合各种乐器弹奏的曲目，并请知名词作家为之谱词。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal; text-indent: 2em;\">4、吴地运河宣传片、专题片、微电影整体策划拍摄制作。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><br/></p><p><br/></p>', N'h,', N'来自火星的程序猿', N'/106/110\\149.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'150', N'MS', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"><img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/1530011938-0.jpg\" width=\"45%\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/>&nbsp;<img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/15300121b-1.jpg\" width=\"45%\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top;\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\">&nbsp;</p><p><img alt=\"\" src=\"http://m286.dedemao.net/uploads/allimg/151112/15300154Q-2.jpg\" width=\"45%\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: top; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/></p><p><br/></p>', N'f,', N'来自火星的程序猿', N'/106/111\\150.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'157', N'MS', N'<p><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;区域旅游发展规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;历史文化区旅游开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;风景名胜区旅游开发规划</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;生态旅游区开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;温泉滨海度假区旅游开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;旅游地产开发规划</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;乡村旅游开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;主题公园开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;城市旅游开发规划</span></p>', N'', N'来自火星的程序猿', N'/106/107\\157.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'158', N'', N'<p><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;区域旅游发展规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;历史文化区旅游开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;风景名胜区旅游开发规划</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;生态旅游区开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;温泉滨海度假区旅游开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;旅游地产开发规划</span><br style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;\"/><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;乡村旅游开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;主题公园开发规划</span><span style=\"margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">-&nbsp;城市旅游开发规划</span></p>', N'f,', N'专业服务', N'/99/101\\158.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'163', N'', N'<p><span style=\"color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; line-height: 24px; background-color: rgb(255, 255, 255);\">凭借专业的网站策划队伍、专业的美工设计师、一流的程序开发人员，丰富的制作经验和高超的创意水平，根据您的企业的行业类型和产品特点度身定制品 牌网站。精益求精的网页制作人员、严谨的应用程序开发人员、尽善尽美的售后服务人员。这一切，是我们为您提供专业网站建设服务，也是让你在同行业中傲视群 雄</span></p>', N'f,', N'', N'/99\\index.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'164', N'2', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">广州规划设计麾下聚集了众多从美国旧金山艺术大学、奥本大学、香港理工大学毕业的海派旅游规划与建筑、景观设计高端人才，其国际化视野和开放创新的风格，将确保香柏领先的、卓越的规划设计水平和创造超出客户预期的服务效果。</span></p>', N'', N'', N'/93/98\\164.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'165', N'3', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;\">广州规划设计创新构建协同式、交互式、大数据及系统式行业服务平台，整合企业管理、金融、互联网、媒介各领域专业资源，为旅游行业提供一揽子系统化解决方</span></p>', N'c,', N'', N'/93/98\\165.html', N'高质量行业交互平台', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'166', N'', NULL, N'', N'65', N'/63\\166.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'167', N'', N'<p><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">公司为危化客户提供危化行业危化车辆销售、金融支持、服务、二维检测、罐体检测与清洗、紧急救援、从业人员培训、二手车置换、危化物流信息平台、事故车维修理赔等多功能于一体的服务中心，提供专业的产品与服务，保障危化车辆运输安全。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">全天候服务：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">本公司在周末、节假日均提供正常服务。在夜间，公司设有值班人员。客户遇险可及时打电话到公司，相关人员将在最短的时间内提供救援服务。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">送服务上门：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">客户无论是租车、修车、保养或其它相关问题，如客户不便来我公司办理，公司可派相关专业人员上门提供服务。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">替换车辆：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">客户所租车辆遇险或发生故障，在车辆修理期间，公司可提供临时替换车辆。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">定时保养：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">本公司按时给租赁车辆实施保养，以保障客户所租车辆处于正常运转状态。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">车辆保险：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">本公司为全部租赁车辆办理保险，并负责出险索赔。客户可以放心地驾驶所租车辆。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">自驾租赁：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">不论您是家庭出行、商务往来、公务出行、出外旅行还是短期替换车，我们都能向您提供符合您需求的租赁车辆。多样的车型、专业的服务、低廉的价格使您体验便捷舒适的汽车租赁服务。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">代驾租赁：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">本公司拥有一支经过严格训练，高素质、熟悉长春及周边地区道路情况的驾驶员队伍，随时可以根据您的需要提供代驾租赁服务。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">商旅服务：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">为客户提供机场单程、往返的接送服务，面向长期客户的定向购车租赁服务。</span><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><strong style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\">职业驾驶员的代驾服务：</strong><br style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; white-space: normal; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">汽车租赁商务车队拥有宝马、别克商务、奥迪、帕萨特、桑塔纳志俊等数十种品牌的商务车型，及一支文化素质高、配置合理并经过专业培训的司机队伍。商务车队秉承良好&quot;高效、快速、品质、服务于人&quot;的服务宗旨，以过硬的专业技术，快速的反应，高标准的服务,为客户提供全天候汽车代驾服务。</span></p>', N'h,', N'66', N'/63\\167.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'168', N'', N'<p><strong style=\"font-size: 14px; white-space: normal; font-family: 宋体; line-height: 22px; padding: 0px; margin: 0px; background-color: rgb(255, 255, 255);\">1、特色服务：</strong><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\"></span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">1.1&nbsp;</span>承接各类化学品、危险品的进出口的贸易代理业务</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">1.2&nbsp;</span>承接样品、修理物品、暂时进出口等特殊贸易方式的进出口代理业务</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">1.3&nbsp;</span>代办两用物项进出口许可证：包括电子钥匙的申领、进出口经营登记申请及进出口许可证的办理</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">1.4&nbsp;</span>承接黄磷、硝化棉的贸易采购业务</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">&nbsp;</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><strong style=\"padding: 0px; margin: 0px;\"><span style=\"padding: 0px; margin: 0px;\">2、</span>常规服务：</strong></span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">2.1&nbsp;</span>接单：专业的客服人员和完善的操作流程，提供贸易代理的咨询和操作服务</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">2.2&nbsp;</span>制单：全套进出口单证的制作</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">2.3&nbsp;</span>外汇结算：及时准确的安排收付外汇，保证外贸义务的及时履行</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">&nbsp;</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><strong style=\"padding: 0px; margin: 0px;\"><span style=\"padding: 0px; margin: 0px;\">3、</span>实力资质：</strong></span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">3.1&nbsp;</span>专业人员</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">资深客户服务及管理人员，拥有丰富的化工品、危险品专业知识和贸易操作经验，为客户提供化学品、危险品进出口贸易代理服务。</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">3.2&nbsp;</span>完善体系</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">1）&nbsp;专业的一体化<span style=\"padding: 0px; margin: 0px;\">ERP系统，从接单到代理合同、单证制作、交付货代、结算货款、出口退税，严格控制贸易代理的每一个环节。</span></span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">2）&nbsp;RQHSE安全控制体系，监控并确保货物安全规范的操作。</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">3.3<span style=\"padding: 0px; margin: 0px;\">&nbsp;</span></span>采购资源</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">与国内多家大型能源型企业为长期合作伙伴关系，可为境外的黄磷、硝化棉需求商稳定供货。</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\"><span style=\"padding: 0px; margin: 0px;\">3.4&nbsp;</span>相关资质</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">1）外经贸核准的进出口经营许可</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">2）海关核准的企业报关资质</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">3）商检局核准的出入境检验检疫报检资质</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">4）外汇管理局核准的企业进出口外汇经营资质</span></p><p><span style=\"line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; color: rgb(0, 0, 0);\">5）安监局审核的危险化学品经营许可<span style=\"padding: 0px; margin: 0px;\">&nbsp;&nbsp;</span></span></p><p><span style=\"font-size: 14px; line-height: 22px; font-family: 宋体; padding: 0px; margin: 0px; background-color: rgb(255, 255, 255);\">6）健全的服务网络：在国内主要港口如上海、天津、青岛等设有分支机构，国内代理网络齐全。</span></p><p><br/></p>', N'c,', N'67', N'/63\\168.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'172', N'', N'<p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网站整体策划</span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\">企业网站建设目的何在？如何充分挖掘互联网络的资源和优势，如何合理地组织网站内容与功能从而达到客户的需求？<br style=\"padding: 0px; margin: 0px;\"/>我们将根据市场分析、客户产品及服务的优势、竞争对手分析等等，有效的确立网站定位。根据相关需求分析获得相应网站运营策略，在网站建立之初我们就网站VI形象、网站营销手段、运营模式、网站发展前景等等进行定位。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">&nbsp;<span style=\"padding: 0px; margin: 0px; font-size: 14px;\"></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网站设计&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">DESIGN</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">网络媒体不同于传统媒体，如果在网站设计的时候仅仅是将文字和图片做一个简单堆积和展示的话，这样的网站跟一片丢落在街头的破旧宣传资料没有任何区别。客户往往通过企业网站就留下了对企业的第一印象，这个第一印象是决定客户是否与你合作的重要因素。<br style=\"padding: 0px; margin: 0px;\"/>所以站在浏览者的角度，我们分析企业特点和品牌内涵，完美的通过网站体现企业形象，并严格采用W3C国际标准进行网站设计，采用DIV+CSS构 架，不但使您的网站具备足够的扩展性，您网站的速度、兼容性、友好性也都会显著提高，更主要的是，代码和表现分离的方式让您的网站改版变得更容易，而针对 SEO搜索引擎优化的工作也变得更加的畅通。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网站建设售后服务&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">SALES</span></span></p><p>&lt;p style=&quot;padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; &gt;网站建设专家致力于为客户提供优质的产品及服务。为了多渠道的了解客户的需求，快速响应个性化需要，不断完善售后服务工作，我们客户服务管理部在此为您搭建了这个沟通的平台，我们希望通过网络加强与客户的交流。<br style=\"padding: 0px; margin: 0px;\"/>完善的售后服务是公司信誉的保障和服务趋于完善与成熟的象征，因此，我们在这一方面投入了较大的精力，确保每一位客户的利益得到充分的保障，从而提高企业信誉，发展长期友好的合作。<br style=\"padding: 0px; margin: 0px;\"/>对于享受我公司建站服务的客户，我们提供免费一年售后服务。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网站全程维护&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">MAINTAIN</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">网页制作好了以后并不是就没事了？其实日后的更新维护才是最重要的！如果参观网站的访问者每次看到的网站都是一样的，那么它们日后还会来吗？这时候，您的网页要由谁来维护呢？<br style=\"padding: 0px; margin: 0px;\"/>严格来说，每一个站点都应该由专业人员定期更新维护。互联网络的最大优势就是信息的实时性，只有快速的反映，准确的报道，才能吸引更多的浏览者。<br style=\"padding: 0px; margin: 0px;\"/>目前很多站点人气很旺，应该和定期更新分不开的。也有很多站点由于种种原因，数月才更新一次，这样就违背了网路最基本的商业目的。网站不是购买一件商品，随着时间的推移而贬值陈旧，只有不断的溶入企业发展动向，推陈出新，才会具有创造力，发挥网路商业潜能。<br style=\"padding: 0px; margin: 0px;\"/>更新维护不仅仅只局限于简单的更换文字稿，应该是将企业的商业动态和发展方向充分考虑进去， 再结合现有的网站规划结构，迅速作出相应的改进。企业的每一个新项目的推广和价格的浮动、内部结构调整， 不应该只是在报纸、电视等媒体做宣传而忽略网路这个最具有潜力的市场。 这也是我们一直强调的商业网站 CIS 策略。<br style=\"padding: 0px; margin: 0px;\"/>鉴于目前大多数网站不具有专业维护的技术力量，网站建设公司可为广大客户提供专业服务。每一个企业可根据自身的商业特征制定不同的维护方案，并保证在最短的时间内迅速完成。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网页改版&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">REVISED</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">企业上网已成趋势，企业网站犹如雨后春笋般地拔起，试问：<br style=\"padding: 0px; margin: 0px;\"/>您的企业通过互联网进行了巨额的投入，但网站到底给您带来了多大的效益？<br style=\"padding: 0px; margin: 0px;\"/>您的网站从建立到现在，更新过几次、改版过几次？<br style=\"padding: 0px; margin: 0px;\"/>功能不全、设计不美观、布局不合理、几乎从不更新的网站会给企形象带来多大的负面影响？<br style=\"padding: 0px; margin: 0px;\"/>选择网站建站专家，帮您重新审视和构架您的网站系统，我们提供八项全能服务，全面改善您的网站系统，专为您解决企业上网后顾之忧。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">培训解决方案&nbsp;<span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\">TRAIN</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">为了更好地做好企业外部门户网站的技术培训工作，将选派具有丰富技术培训和实施经验的技术人员组成培训小组，编写详尽实用的培训教材，并且制定切实有效的培训方案。技术培训的工作为应用软件系统管理和使用培训。<br style=\"padding: 0px; margin: 0px;\"/>在软件产品实践培训中，采用集中培训的方式，的培训师针对本系统的技术特点，为企业技术人员提供全面培训，培训内容涵盖了本此系统建设过程中使用的主要技术理论和产品实践。<br style=\"padding: 0px; margin: 0px;\"/>在应用软件系统管理和使用培训中，我们会组织项目开发小组的主要人员针对管理和使用人员的不同需求，提供不同层次的培训课程。</p><p><br/></p>', N'p,', N'', N'/53/133\\index.html', N'网络媒体不同于传统媒体，如果在网站设计的时候仅仅是将文字和图片做一个简单堆积和展示的话，这样的网站跟一片丢落在街头的破旧宣传资料没有任何区别。客户往往通过企业网站就留下了对企业的第一印象，这个第一印象是决定客户是否与你合作的重要因素。', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'173', N'', N'<p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">互联网品牌推广怎么做？</span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\">互联网品牌推广有个新鲜名词叫数字营销，数字营销是新发展起来的一种营销模式，是利用互联网特性和技术，更加有效、高性价比地完成整合营销计划，达到传统 的IMC不能达到的高效客户关系管理等，从而精准地实施营销策略，实现企业营销的高效率、低成本、大影响。可以按两种意思来理解：网络整合营销是利用网络 技术和网络特性最大化、最快速、最有效、最精准的进行整合营销；网络整合营销是以为客户提供有价值的信息为基础，由客户创造、传播为主导的整合营销理念进 行的网络营销。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">目前品牌在推广上遇到什么问题？</span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\">作为品牌主，你是否有这样的困惑？<br style=\"padding: 0px; margin: 0px;\"/>● 很早就有了互联网品牌网站，可是却不知如何利用，网络也没有给你创造任何经济效益！<br style=\"padding: 0px; margin: 0px;\"/>● 希望通过网络推广获得效益，但面对市场上纷繁复杂、层出不穷的网络推广概念和方式让人眼花缭乱，却无从下手！<br style=\"padding: 0px; margin: 0px;\"/>● 花了很多钱做网站推广，却没什么效果，也不知道问题出在哪里？<br style=\"padding: 0px; margin: 0px;\"/>● 看到竞争对手迅速壮大，却不知道他们究竟如何利用好网络营销的秘诀？</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">是怎么做的？</span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\">当我们的客户确定需要进行数字营销传播时，我们将提供以下服务：<br style=\"padding: 0px; margin: 0px;\"/>营销型网站建设，网络调研，搜索引擎营销(SEO和SEM)，软文营销(博客营销、论坛营销、SNS营销、新闻营销、许可邮件营销)，口碑互动营销(圈子 营销、社区营销、博客营销)，群营销(网络广告、论坛营销、SNS营销、IM和QQ群营销)。将以上传播进行有机的整合营销推广，制定传播营销方案。</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">一、提供推广资料和目标，提供报价。<br style=\"padding: 0px; margin: 0px;\"/>二、提供营销型网站方案。<br style=\"padding: 0px; margin: 0px;\"/>三、确定传播关键字。<br style=\"padding: 0px; margin: 0px;\"/>四、确定搜索引擎营销策略，进行关键词甩选。<br style=\"padding: 0px; margin: 0px;\"/>五、进行后台数据分析，确定网络广告文案。<br style=\"padding: 0px; margin: 0px;\"/>六、制定病毒式营销计划，确定博客营销、论坛营销、SNS营销载体。<br style=\"padding: 0px; margin: 0px;\"/>七、确定新闻营销、博客营销、论坛营销的整体方案。<br style=\"padding: 0px; margin: 0px;\"/>八、制定网络整合营销传播计划。<br style=\"padding: 0px; margin: 0px;\"/>九、效果评估。<br style=\"padding: 0px; margin: 0px;\"/>十、提供传播报告。</p><p><br/></p>', N'h,', N'', N'/53/134\\index.html', N'营销型网站建设', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'174', N'', N'<p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"><span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">域名?</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">Internet这个信息时代的宠儿，已经走出了襁褓，为越来越多的人所认识，电子商务、网上销售、网络广告已成为商界关注的热点。&quot;上网&quot;已成为不少人的口头禅。但是，要想在网上建立服务器发布信息，则必须首先注册自己的域名，只有有了自己的域名才能让别人访问到自己。所以，域名注册是在互联网上建立任何服务的基础。同时，由于域名的唯一性，尽早注册又是十分必要的。</span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\">&nbsp;</p><hr style=\"padding: 0px; margin: 0px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \"/><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;\"><span style=\"padding: 0px; margin: 0px; color: rgb(255, 0, 0);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">国际域名注册</span></span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; \">&nbsp;</p><table bgcolor=\"#cccccc\" cellpadding=\"0\" cellspacing=\"1\" class=\"yh_z\" width=\"100%\"><tbody style=\"padding: 0px; margin: 0px;\"><tr style=\"padding: 0px; margin: 0px;\" class=\"firstRow\"><th bgcolor=\"#f2f2f2\" height=\"25\" width=\"20%\" style=\"padding: 0px; margin: 0px;\"><strong style=\"padding: 0px; margin: 0px;\">域名价格</strong></th><th bgcolor=\"#f2f2f2\" width=\"20%\" style=\"padding: 0px; margin: 0px;\"><strong style=\"padding: 0px; margin: 0px;\">域名价格</strong></th><th bgcolor=\"#f2f2f2\" width=\"60%\" style=\"padding: 0px; margin: 0px;\"><strong style=\"padding: 0px; margin: 0px;\">域名说明</strong></th></tr><tr bgcolor=\"#ffffff\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">CN英文域名注册</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">80&nbsp;元/年</h5></td><td align=\"left\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名类型：.cn/ .com.cn/ .net.cn/ .org.cn等</td></tr><tr bgcolor=\"#f2f2f2\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">国际域名注册</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">80&nbsp;元/年<br style=\"padding: 0px; margin: 0px;\"/>(多年购买优惠)</h5></td><td align=\"left\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名类型：.com/ .net/ .org/ .biz</td></tr><tr bgcolor=\"#ffffff\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">英文.ASIA</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">159&nbsp;元/年</h5></td><td align=\"left\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：表示亚洲</td></tr><tr bgcolor=\"#f2f2f2\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">顶级域名.MOBI</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">168&nbsp;元/年<br style=\"padding: 0px; margin: 0px;\"/>(多年购买优惠)</h5></td><td align=\"left\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：手机域名，WAP网站首要之选</td></tr><tr bgcolor=\"#ffffff\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">新顶级域名TEL</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">158&nbsp;元/年</h5></td><td align=\"left\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：电话，网络名片</td></tr><tr bgcolor=\"#f2f2f2\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">英文.TRAVEL</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">1800&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：旅游域名，国际域名</td></tr><tr bgcolor=\"#fffde5\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">香港域名.HK</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">215&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名类型：.hk/ .com.hk</td></tr><tr bgcolor=\"#f2f2f2\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">新顶级域名.NAME</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">100&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：<strong style=\"padding: 0px; margin: 0px;\">国际顶级</strong>域名，<strong style=\"padding: 0px; margin: 0px;\">个人域名</strong>的标志</td></tr><tr bgcolor=\"#f2f2f2\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">新顶级域名.INFO</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">100&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：<strong style=\"padding: 0px; margin: 0px;\">国际域名</strong>，表示网络信息服务组织</td></tr><tr bgcolor=\"#f2f2f2\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">英文.CC</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">298&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：商业公司，中国公司</td></tr><tr bgcolor=\"#ffffff\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">英文.TV</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">330&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：表示电视,宽频时代的主流域名</td></tr><tr bgcolor=\"#ffffff\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">英文名.IN</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">580&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：India（印度）的国家域名</td></tr><tr bgcolor=\"#f2f2f2\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">英文.LA</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">880&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：表示洛杉矶</td></tr><tr bgcolor=\"#ffffff\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">英文 .JOBS</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">2800&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：国际顶级域名，主要面向招聘和求职市场</td></tr><tr bgcolor=\"#f2f2f2\" style=\"padding: 0px; margin: 0px;\"><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">英文 .ME</h5></td><td align=\"center\" style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\"><h5 style=\"padding: 0px; margin: 0px;\">315&nbsp;元/年</h5></td><td style=\"padding-right: 5px; padding-left: 5px; margin: 0px;\">域名意义：国际顶级域名，.Me代表“我”，属于你！</td></tr></tbody></table><p><br/></p>', N'c,', N'', N'/53/135\\index.html', N'Internet这个信息时代的宠儿', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'177', N'MS', N'<p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px; \"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台开发团队承诺MCMS内容管理系统永久完整开源免费(这真是极好的)！下面就简单的给大家介绍一下MS平台和MCMS为什么如此之快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MS平台是铭飞团队经过多年的研发，最终以MCMS为基础，集商城、论坛、分期、会员、支付、积分、微信等系统于一体的插件式系统。并实现了淘宝、京东、苏宁、国美等第三方电商平台数据接口的统一。平台中的小插件如：邮件推送、短信接口、定时任务、促销活动、数据采集等非常丰富。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">MCMS的模版采用标签式开发，上手非常快。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px;\"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于技术小白来说不仅避开了学习复杂的高级开发语言,而且MStore有大量成熟的模版直接下载之后换换图片和内容就可以使用,要是需要调整只需要写简单的标签就可以。</span></p><p style=\"box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px; \"><span style=\"box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;\">对于前端工程师来说只需要写好页面样式并在页面内容部分套上标签，就可以做出一套优美的动态网站。并且还可以实现留言板、用户登录等数据交互功能。</span></p><p><br/></p>', N'h,', N'来自火星的程序猿', N'/59/70\\177.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'178', N'MS', N'<p><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">MStore（铭飞商城）是铭飞（MS）平台为开发者提供模版与插件作品分享平台,为企业提供优质产品和服务我们致力于打造一个优秀的Java资源共享学习平台。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><strong style=\"box-sizing: border-box; white-space: normal; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">MStore离不开您的参与，<br style=\"box-sizing: border-box;\"/>如果您是开发者（前端&amp;后台）</strong><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">：</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">1.要分享自己的得意模板、插件、教程？欢迎您来这里，找到需要她、欣赏她的人。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">2.想找个网络模板收藏夹存放自己喜爱的模板？ 这里就是您的选择。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">3.想结交更多热爱模板、插件的朋友？那就快来展示您的作品，寻找志趣相投的朋友吧。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><strong style=\"box-sizing: border-box; white-space: normal; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">如果您是企业：</strong><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">1.这里有一群精力旺盛有着代码执着追求的开发者分享的模版与插件，相信他们肯定为您提供更好的服务。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">2.更多Java coder分享的更多插件，满足您各种项目需求，降低开发与维护成本。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">3.这里有专业设计人员提供的更多精美模版，帮您省去设计投入成本。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">4.同时也希望您为分享者点个赞。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><strong style=\"box-sizing: border-box; white-space: normal; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">铭飞已经上路，我们将为此不懈努力，期待得到您的支持！</strong></p>', N'', N'来自火星的程序猿', N'/59/68\\178.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'179', N'MS', N'<p><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">MStore（铭飞商城）是铭飞（MS）平台为开发者提供模版与插件作品分享平台,为企业提供优质产品和服务我们致力于打造一个优秀的Java资源共享学习平台。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><strong style=\"box-sizing: border-box; white-space: normal; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">MStore离不开您的参与，<br style=\"box-sizing: border-box;\"/>如果您是开发者（前端&amp;后台）</strong><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">：</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">1.要分享自己的得意模板、插件、教程？欢迎您来这里，找到需要她、欣赏她的人。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">2.想找个网络模板收藏夹存放自己喜爱的模板？ 这里就是您的选择。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">3.想结交更多热爱模板、插件的朋友？那就快来展示您的作品，寻找志趣相投的朋友吧。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><strong style=\"box-sizing: border-box; white-space: normal; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">如果您是企业：</strong><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">1.这里有一群精力旺盛有着代码执着追求的开发者分享的模版与插件，相信他们肯定为您提供更好的服务。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">2.更多Java coder分享的更多插件，满足您各种项目需求，降低开发与维护成本。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">3.这里有专业设计人员提供的更多精美模版，帮您省去设计投入成本。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px;\">4.同时也希望您为分享者点个赞。</span><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; \"/><br style=\"box-sizing: border-box; white-space: normal; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px;\"/><strong style=\"box-sizing: border-box; white-space: normal; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; \">铭飞已经上路，我们将为此不懈努力，期待得到您的支持！</strong></p>', N'h,', N'来自火星的程序猿', N'/59/68\\179.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'182', N'', N'<p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">网络营销是以互联网络为基础，通过数字化的信息和网络媒体的交互性来辅助营销目标实现的一种新型的市场营销方式。</span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 据统计，在国外，80%的个人和企业都选择网络媒介进行营销推广，并从中获得了极好的效果。而在中国，选择网络营销的企业和个人只有7-8%，不到国外的十分之一。</span></p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;</p><p style=\"padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"padding: 0px; margin: 0px; font-size: 14px;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 随着网络影响的进一步扩大，随着人们对于网络营销理解的进一步加深，以及越来越多出现的网络营销推广的成功案例，人们已经开始意识到网络营销的诸多优点，越来越多的企业和个人通过网络进行营销推广</span></p><p><br/></p>', N'', N'', N'/52\\index.html', N'网络营销是以互联网络为基础', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'183', N'', N'<p><img src=\"/upload/editor/1580/1461912560218.jpg\" title=\"1461912560218.jpg\" alt=\"1-1203302131502F.jpg\"/><img src=\"/upload/editor/1580/1461912562754.jpg\" title=\"1461912562754.jpg\" alt=\"1-120330213210F7.jpg\"/><img src=\"/upload/editor/1580/1461912555214.jpg\" title=\"1461912555214.jpg\" alt=\"1-12033021312C17.jpg\"/></p>', N'', N'', N'/52/136\\index.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'185', N'', N'<p>联系电话：888888<br/></p><p>QQ：1391265900</p><p>邮箱：1391265900@qq.com</p><p>地址：来自火星的程序猿</p><p><br/></p>', N'', N'', N'/19/141\\index.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'190', N'', NULL, N'', N'', N'/19/142\\index.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'191', N'铭飞', N'<p><span style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;\">日前，公司成功中标杭州市民中心G楼约18000多平方米四层公共区域装饰工程，这是继杭州钱江新城国际会议中心之后的又一城市标志性建筑工程。</span><br style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px; white-space: normal;\"/><span style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;\">在该项目施工过程中，公司始终将“绿色装饰”理念融入其中。“绿色装饰”是指在设计、装修选材、施工等整个过程都符合绿色环保的理念，把对环 境造成的危害降低到最小，让市民享受到真正的绿色生活。随着社会的不断发展，“绿色装饰”日趋成为广大建筑装饰企业努力的方向。</span><br style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px; white-space: normal;\"/><span style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;\">公司项目部在杭州市民中心G楼工程中，严格按照健康、环保、安全的施工标准，精心施工，力争达到“浙江省建筑安全文明标化工地”的要求。在原 材料的选用上精挑细选，大量运用了玻璃、大理石材等绿色环保和高品质的装饰材料，突显出了简约、明快、自然的设计风格，创造出宽阔、绿色、实用的公共空 间。</span><br style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px; white-space: normal;\"/><span style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;\">此外项目部还非常注重采取新工艺、新方法，不仅提高了工程的整体美观性和实用性，而且加快了施工进度，提升了工作效率。由于本工程是圆型结构的楼层施 工，特别是石材在圆弧和圆柱造型上用量大，大大增加了工程的施工难度。因此，项目部按工程施工位置的不同分别采用了石材干挂施工工艺和石材湿贴与灌浆施工 工艺。通过这两种施工工艺铺出来的石材平整、洁净、色泽一致，无裂痕和缺损，既美观又方便今后日常护理。</span><br style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px; white-space: normal;\"/><span style=\"color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;\">作为杭州市重点工程，杭州市民中心G楼公共区域装饰工程得到了公司领导的高度重视。总经理高利明亲自坐镇指挥，组建了一支强有力的项目领导管 理班子，采用矩阵式组织管理体系，即采取以项目经理为第一责任人，分解项目绿色施工指标，形成完善的绿色施工组织、责任体系，在保证质量、安全等基本要求 的前提下，通过科学管理和技术进步，最大限度地节约资源与减少对环境负面影响，实现四位一体的绿色环保施工，打造“绿色装饰”精品工程。</span></p>', N'h,', N'铭飞', N'/62/84\\191.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'192', N'铭飞', N'<p><span style=\"color: rgb(51, 51, 51); font-family: 微软雅黑, Arial; line-height: 34px; background-color: rgb(255, 255, 255);\">对于时尚达人而言，包袋与衣服的混搭也是一种必杀技。休闲手提包可以搭配不同的造型，而搭配运动裤就是更加直接地表现出时尚休闲风的最佳配搭方案。 宽松舒适的运动裤相信是不少男士最爱，但却很难搭出时尚感，更一不小心就给人过于随便的印象。而手提包在款式、颜色、材质及图案方面层出不穷，再搭配不同款式的运动裤，打造半运动化的时装搭配，让运动休闲和时尚文化完美结合，塑造出运动感的摩登简约风，让整体穿着随意且舒适。</span></p>', N'p,', N'铭飞', N'/62/84\\192.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'193', N'铭飞', N'<p>市委副书记、市长宋朝华率队前往贵州省贵阳市，实地考察由中铁贵旅公司投资开发建设的中铁国际生态城项目，并与公司高层进行了深入友好座谈，洽谈推进重大项目落户我市仁寿县相关事宜。</p><p>&nbsp;</p><p>中国中铁旗下子公司——中铁贵旅公司开发建设的中铁国际生态城项目位于贵阳市龙洞堡空港经济区，总投资500亿元，占地面积约20平方公里，打造集旅游、休闲、度假、运动、文化、养老、养生和居住等多种功能于一体的世界级旅游度假目的地，2011年被列为“贵州省十二五旅游发展规划十大旅游项目”之一，是贵州省的重点项目。在中铁贵旅公司董事长张敏的陪同下，宋朝华一行参观考察了中铁国际生态城展示中心、中铁国际生态旅游城市综合体项目、安纳塔拉度假酒店和巫山香杏小镇等旅游开发项目，认真听取了项目规划建设有关情况介绍，对中铁国际生态城项目规划理念新、设计水平高、推进速度快表示由衷赞赏，对中铁贵旅公司有意来我市仁寿县投资发展表示热烈欢迎。</p><p>&nbsp;</p><p>座谈会上，双方就推进项目落户事宜进行了深入友好会谈。宋朝华指出，中铁贵旅公司实力强、品牌响、理念新，对公司投资开发黑龙滩休闲旅游度假中心项目充满信心。通过深入考察和友好洽谈，双方就项目投资有关事宜达成了共识，并将于近期正式签署合作协议。张敏表示，天府眉山交通区位优越，旅游资源独特，发展潜力巨大，集团拟投资200亿元以上开发建设黑龙滩旅游项目。该项目将按照国际化水准，坚持以游为主、高举高打，紧紧围绕“吃、住、行、游、购、娱”六要素，走产业高端、高端产业的路线，全力打造5a级景区，为发展旅游产业和造福眉山人民作出央企应有的贡献。</p><p><br/></p>', N'', N'铭飞', N'/62/84\\193.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'194', N'铭飞', N'<p>森和汽车城，位于广州市天河北路，是一家高端品牌汽车的城市综合展厅，本来是全方位展示豪华新车的地方。上周，突然在门口拉上了横幅——东阳红木清货大甩卖。记者于日前一探，吓了一跳。门口的广场上停着几辆大货车，不断有红木家具被抬出来打包装车。走进去视觉更混乱，当庭摆着一套五件鹿角椅，旁边是满雕龙的金丝楠木顶箱柜，内庭中央还展示着一辆豪华轿车，而周边则摆满红木家具，完全没有红木家具应该有的意境。更令人瞠目结舌的是，里面人流熙熙攘攘，整个场景可以让你直接穿越到上世纪八十年代中期一个小县城的展销会。</p><p>&nbsp;</p><p>　　“销售情况非常可观，首日已经突破100万元销售，周末差不多也是这个数。”东阳红木销售负责人穆延东告诉记者，这次的清货周四开始，周日结束，下周同样如此，中间的时间会对产品进行调整，再销售一次就结束了。记者在店内粗略看了一下，产品以清式家具为主，材质则以金丝楠木、微凹黄檀、缅甸花梨、南美酸枝、东南亚酸枝为主，大红酸枝和明式风格的产品不多，就连在今年APEC上出现的大红酸枝交椅的完整复刻版，也随便被摆在了角落。从做工和风格以及雕刻工艺来看，这些货物并非出自一家工厂。“此次清货的红木家具，来自东阳红木家具六家工厂，这些货基本是这些厂家去年接的订单直接生产的，但今年有很多客户取消了订单，加上市场环境变化，代理商出货也很慢。工厂不像经销商，可以囤货，它必须保持周转，否则就得停工待产坐以待毙。所以几家厂子就联合起来，将厂里现有的产品变现，自谋生路。”穆延东告诉记者，他们在北京、上海也有此类清货会，销售情况都不错，相对而言，广州的销售情况不如北京、上海。“可能是产品材质的问题，微凹黄檀和缅甸花梨的产品比较畅销，但南美酸枝和东南亚酸枝的产品不太被认可。有很多消费者直接询问有没有大红酸枝的产品，也有很多消费者询问有没有明式风格的产品。”他透露，下周销售的产品将会进行调整，还是针对普通消费者，以老挝大红酸枝(交趾黄檀)、缅甸花梨的材质为主，增加明式风格家具的品类，但还是以清式风格为主。</p><p><br/></p>', N'', N'铭飞', N'/62/83\\194.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'195', N'铭飞', N'<p>海南黄花梨圆包脚罗汉床、小叶紫檀云龙纹镶理石圆桌、富贵满堂多宝阁……昨日（12月13日）上午，第三届中国（江门）传统家具精品鉴赏会暨2014中国（江门）红木家具经销大会在五邑华侨广场会展中心正式开幕，众多国宝级古典家具作品以及海南黄花梨等珍贵木材亮相。</p><p>&nbsp;</p><p>　　此次活动由江门市古典家具行业协会主办，江门市新会区古典家具行业协会、台山市大江古典家具商会共同协办，会期为12月13日至16日，有来自我市新会、台山的50家代表性企业参展，云集了20多个省市经销商、行业精英，这是我市古典家具行业促进交流合作，展示广作精品，推广“江门红木”的重要平台。</p><p>&nbsp;</p><p>　　出席展会开幕式的有关嘉宾有：中国家具协会副理事长、传统家具专业委员会主席团常设主席陈宝光，故宫博物院常务副院长、故宫博物院研究员王亚民，中国家具协会传统家具专业委员会主席、江门市古典家具行业协会会长伍炳亮，省家具协会会长王克，省工艺美术协会会长舒海波等。</p><p>&nbsp;</p><p>　　我市是红木广作工艺的发源地之一，也是全国红木家具重要的生产基地，拥有深厚的文化和精妙的技艺，人才云集。借助这次展会，伍炳亮认为，一方面，“将有利于增加广大爱好者对传统家具的了解，在提升自己的审美观和鉴赏力，领略艺术魅力的同时，享受艺术带来的美好生活”；另一方面，这将成为我市对外展示的窗口，“展示我市优秀传统家具作品和设计，引领当代仿古家具健康发展”。</p><p>&nbsp;</p><p>　　王亚民在致辞中说：“江门在传统家具制作方面有很长的历史，涌现出了一批家具行业的企业家，对传统家具的继承创新与发展都做出了自己的探索和非常令人鼓舞的成就，在全国形成影响。”</p><p>&nbsp;</p><p>　　陈宝光则希望：“江门红木家具企业能够借这次展会，进一步推动行业良性发展，为全国红木家具发展作出贡献。”</p><p><br/></p>', N'f,', N'铭飞', N'/62/83\\195.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'196', N'铭飞', N'<p>有人说，成都，是一个让人来了就不想离开的地方，是一座悠远的文化名城，它用睿智和远见，让每一个人共享一座城市的幸福，因此被评为“最具幸福感的城市”。</p><p>&nbsp;</p><p>那么，当中国国粹文化的传承者、追求幸福感的红木家具知名品牌——东莞市弘开实业有限公司（以下简称戴为红木）与成都邂逅，必能为广大成都市民增添更多新的幸福感。<br/><br/></p><p>近期，出于对中国传统文化的热爱，以及对红木艺术的执着、深情和追求，戴为红木携带“幸福之家”主题活动礼遇成都，使其鸿儒红木家居艺术馆隆重开业，为已进入寒冬的成都燃起了一把火，掀起了中式红木家具热潮！</p><p>&nbsp;</p><p>据了解，戴为红木成都鸿儒红木家居艺术馆在锦江区三色路，展馆面积达500多平方米。艺术馆整体宏伟大气，装修精致，馆内的精品极富特色设计，尤其是第四层展示了戴为红木的代表性设计风格，不仅拥有宁静致远的品茶茶室，静心悟道之香道品香室，古色古香的贵宾区，休闲娱乐之棋牌室等高端居室，而且居室采用了鸿儒家居VIP会员制度。这意味着，在这里，不仅可以享受国粹文化的熏陶，还能尊享贵宾待遇的幸福感。</p><p><br/></p>', N'h,', N'铭飞', N'/62/83\\196.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'197', N'铭飞', N'<p>今年以来，质检总局执法督查司按照网上发现、源头追溯、落地查处的要求，组织开展电子商务产品专项执法打假活动，积极构建适应电子商务执法打假的全国执法协查工作机制，推动属地查处工作的开展，全国共查处电商产品质量违法案件400余件。</p><p>2014年6月，江苏省淮安市质监局根据总局执法司统一部署，对江苏杰翔羽绒有限公司进行了执法检查。经查，该公司涉嫌生产并通过“天猫商城”和“京东商城”等电子商务平台销售以假充真蚕丝被。目前，江苏省淮安市淮安质监局已对该案立案查处。</p><p><br/></p>', N'', N'铭飞', N'/62/83\\197.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'198', N'铭飞', N'<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Arial; line-height: 34px; white-space: normal; background-color: rgb(255, 255, 255);\">巴黎时装周许晴倾力助阵，当天许晴身着黑色拼接装头排看秀，大秀美腿，加上干净利落的妆容，整体造型简洁率性，绿色的刺绣手包更添俏皮，银色的尖头高跟鞋成点睛之笔，许晴此次看秀的装扮可谓彰显了至纯至简主义。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Arial; line-height: 34px; white-space: normal; background-color: rgb(255, 255, 255);\">对于此次的装扮许晴表示：“这次的服装都是看似简单其实细节之处非常打动我，像这件是硬朗的皮质与柔软的丝绵材质的拼接，好比是一刚一柔，代表女子都有柔软和刚强的两面，刚柔并济。”许晴和MirandaKerr在头牌看秀时不时凑在一起交流，时而发出会心微笑时而一起鼓掌，成为现场最闪耀的亮点，很多时尚博主达人都纷纷夸赞二人拥有最甜美的笑脸。</p><p><br/></p>', N'', N'铭飞', N'/62/83\\198.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'199', N'铭飞', N'<p>市委副书记、市长宋朝华率队前往贵州省贵阳市，实地考察由中铁贵旅公司投资开发建设的中铁国际生态城项目，并与公司高层进行了深入友好座谈，洽谈推进重大项目落户我市仁寿县相关事宜。</p><p>&nbsp;</p><p>中国中铁旗下子公司——中铁贵旅公司开发建设的中铁国际生态城项目位于贵阳市龙洞堡空港经济区，总投资500亿元，占地面积约20平方公里，打造集旅游、休闲、度假、运动、文化、养老、养生和居住等多种功能于一体的世界级旅游度假目的地，2011年被列为“贵州省十二五旅游发展规划十大旅游项目”之一，是贵州省的重点项目。在中铁贵旅公司董事长张敏的陪同下，宋朝华一行参观考察了中铁国际生态城展示中心、中铁国际生态旅游城市综合体项目、安纳塔拉度假酒店和巫山香杏小镇等旅游开发项目，认真听取了项目规划建设有关情况介绍，对中铁国际生态城项目规划理念新、设计水平高、推进速度快表示由衷赞赏，对中铁贵旅公司有意来我市仁寿县投资发展表示热烈欢迎。</p><p>&nbsp;</p><p>座谈会上，双方就推进项目落户事宜进行了深入友好会谈。宋朝华指出，中铁贵旅公司实力强、品牌响、理念新，对公司投资开发黑龙滩休闲旅游度假中心项目充满信心。通过深入考察和友好洽谈，双方就项目投资有关事宜达成了共识，并将于近期正式签署合作协议。张敏表示，天府眉山交通区位优越，旅游资源独特，发展潜力巨大，集团拟投资200亿元以上开发建设黑龙滩旅游项目。该项目将按照国际化水准，坚持以游为主、高举高打，紧紧围绕“吃、住、行、游、购、娱”六要素，走产业高端、高端产业的路线，全力打造5a级景区，为发展旅游产业和造福眉山人民作出央企应有的贡献。</p><p><br/></p>', N'c,', N'铭飞', N'/62/83\\199.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'200', N'MS', N'<p>斯宾特系列(Sprinter)系列技术领先，动力强劲。座位数从10座到20座均可选择，跟据配置不同,价格也从95.8万——178万可以选择。为您带来不同的商务体验。下面为您带来的就是斯宾特A3-9座旗舰型，号称移动总裁办公室的豪华商务房车。</p><p>从看到斯宾特的第一眼，您就会喜欢上他，不仅仅因为他豪华大气的外观，更得益于梅赛德斯-奔驰精湛造车技艺的极致发挥和处处以人为本的至臻理念，时刻让您感受到其中极高的舒适和享受。车门电动滑动装置，配合智能化遥控车钥匙开启，您可以轻而易举的开合车门，体现无微不至的尊荣享受。尽显豪华大气本色！</p><p><br/>后轮双胎配置使车身的承载能力更加强大，更加稳定、安全。奔驰商务车秉承了梅赛德斯-奔驰品牌百年的造车传统，奔驰商务车中斯宾特以豪华大气的外观、卓尔不凡的品质、坚实可靠的性能，再一次演绎了梅赛德斯-奔驰对至善臻美的不懈追求。新一代梅赛德斯-奔驰商务车斯宾特技术更上一层楼，为高级商务车行业树立新标杆。外观造型气度恢弘、浑然天成；细节设计周密严谨、精益求精。梅赛德斯-奔驰造车专家独运匠心，精心打造，为客户带来具有更大空间、更强动力和更高安全保障的斯宾特。</p><p>&nbsp;</p><p>车内中控隔屏、BOSE顶级KTV系统及酒柜吧台。高大的车身设计带来无与伦比的车内空间，车内净高1.98米。这使您进出车仓无需弯腰低头，也喻示着此车的拥有者在生意场上的强势，无需向任何人低头。车内后仓配备阿尔卑斯小牛皮手工订制的豪华航空座椅，尽显商务头等仓本色，两个可以360度旋转的座椅和侧置沙发可以让车内座椅布局自由组合。带来超乎想像的谈判空间！</p><p><br/>隔屏上集成了一台来自三星的40英寸3D液晶电视，配合卫星电视接收器可以接收国内100多个电视频道，DVD庭影院系统也可以播放高清视频。让您在旅途中不再无聊。来自瑞士的水晶杯在酒柜的LED灯光照射下晶莹剔透，更显皇家风范。</p><p><br/></p>', N'p,', N'来自火星的程序猿', N'/106/107\\200.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'201', N'MS', N'<p><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">其实商务车在人们眼里就是普通的客车，没有人会花时间去研究它，欣赏它。商务车给人的印象，就是整体的一箱车，发动机不是在驾驶与副驾驶的座椅下边，就是在车子的后面。没有前发动机舱，很少有人会把普通的商务车与“霸气”这个词汇文明发言在一起。而作为一款纯正的“美国”商务车，GMC3500完全打破中国人传统意识里的对商务车的形象。&nbsp;</span></p>', N'', N'来自火星的程序猿', N'/106/107\\201.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'202', N'MS', N'<p><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">对于这样一款外观霸气，承载性高的原装进口商务车和它实在的销售价格，都让这款车的性价比大大提升了不少。对于市场上一些追求个性的客户群来讲，GMC3500恰恰就是一款能够让他们体现出个性化的座驾，留有足够改装想象和个性发展的空间，体验生活品味，从GMC开始。新款GMC Savana 3500 舒适版商务车是您一个很不错的选择。</span></p>', N'', N'来自火星的程序猿', N'/106/107\\202.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'203', N'MS', N'<p><span style=\"color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);\">奔驰斯宾特系列礼宾车在豪华商务车系中，一向是高端、舒适的代名词。在秉承了奔驰的贵族气质的同时，其全新定制的奢华内饰让人感觉犹如进入了高档的商务会所。定位为大型集团公司商务接待用车。其超高端的豪华配置能够很好的提升用车企业的自身品质，给来访者一种最高礼遇，是对商务洽谈活动的一种实质推动和提升。&nbsp;</span></p>', N'c,', N'来自火星的程序猿', N'/106/107\\203.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'204', N'', NULL, N'', N'', N'/100/148\\204.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'205', N'', NULL, N'', N'', N'/100/148\\205.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'206', N'', NULL, N'', N'', N'/100/148\\206.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'207', N'', NULL, N'', N'', N'/100/148\\207.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'208', N'', NULL, N'', N'', N'/100/148\\208.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'209', N'', NULL, N'', N'园林绿化二级资质企业', N'/100/148\\209.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'210', N'', NULL, N'', N'园林绿化二级资质企业', N'/100/147\\210.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'211', N'', NULL, N'', N'园林绿化二级资质企业', N'/100/147\\211.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'212', N'', N'<ol class=\"list-ol list-paddingleft-2\" style=\"list-style-type: square;\"><li><p>创造价值，提供优质的产品和服务，赢得用户的喜爱和尊敬。</p></li><li><p>利益均沾，让公司的每一成员都获得满意的回报。</p></li><li><p>合作共赢，与合作伙伴共同成长，赢得行业尊敬。</p></li><li><p>注重企业责任，关爱社会、回馈社会，赢得社会尊敬。</p></li></ol><p><br/></p>', N'h,', N'', N'/93/95\\212.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'213', N'', N'<ol class=\"list-ol list-paddingleft-2\" style=\"list-style-type: square;\"><li><p>创造价值：一切工作围绕为用户价值展开，不做任何对用户没有价值的面子工作。</p></li><li><p>积极主动：在做好本职工作的前提下，积极主动为公司解决问题，推动公司发展。</p></li><li><p>踏实奋进：不报幻想，实事求是，锐意进取。不把“运气”当作成事的前提，抱美好的梦想，作最坏的打算。</p></li><li><p>合作共赢：抱着共赢的心态，积极与企业内外合作，充分利用各方优势，创造价值。</p></li></ol><p><br/></p>', N'p,', N'', N'/93/95\\213.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'214', N'', N'<ol class=\"list-ol list-paddingleft-2\" style=\"list-style-type: square;\"><li><p>注重长远发展，不因商业利益伤害用户价值。</p></li><li><p>关注并深刻理解用户需求，不断以卓越的产品和服务满足用户需求。</p></li><li><p>重视与用户的情感沟通，尊重用户感受，与用户共成长。</p></li><li><p>合作共赢：抱着共赢的心态，积极与企业内外合作，充分利用各方优势，创造价值。</p></li></ol><p><br/></p>', N'f,', N'', N'/93/95\\214.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'215', N'', N'<ol class=\"list-ol list-paddingleft-2\" style=\"list-style-type: square;\"><li><p>努力为员工提供良好的工作环境和科学的激励机制。</p></li><li><p>努力让适合的人干适合的事，为员工提供丰富的培训和晋升机会，使员工和公司共同成长。</p></li><li><p>尊重和信任员工，鼓励员工充分发挥聪明才智，使其在自己的领域获得成功。</p></li></ol><p><br/></p>', N'c,', N'', N'/93/95\\215.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'216', N'', N'<p>锐诚PPT创始人，资深PPT设计师、培训师、品牌策划师，任全国知名地产公司高级策划师，大型教育集团品牌运营总监；创办锐诚PPT后，为中原演示设计领域带来全新标准，帮助数百家企业定制演示精品，让演示创造更多价值。精通各种高端PPT设计、 精通版式、配色、文字逻辑和动画，设计案例上百件。擅长在实战中为学员点拨，让学员快速提升美感，做出更漂亮的作品。</p><p><br/></p>', N'h,', N'', N'/115\\216.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'217', N'', N'<p>锐诚PPT特邀首席技术专家，连续五年荣获美国微软公司评出的全球最有价值专家奖（简称MVP），通过微软办公专家国际认证（简称MOS）。出版专业PPT书籍《PPT高效设计-5分钟完美打造PPT课件》，在历届网络PPT大赛中做评委。阿瑛老师从事PPT设及教学十余年，PPT公开课上千场，经验极其丰富，授课轻松风趣，让0基础的学员都可以快速提升技能，做出漂亮的PPT。</p>', N'p,', N'', N'/115\\217.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'218', N'', N'<p>锐诚PPT培训部总监，17年PPT研究积淀，5年网络教室的教学经验。2013年获得全国振兴杯多媒体制作员比赛第7名 。多次获得省市局级办公软件技术大赛奖，独撰《PPT高效设计—6招完美打造工作型PPT》全国发行。曾任中国石化干部管理学院担任“PPT高级制作技巧”课程授课讲师。幽默，轻松的授课方式，快乐中传授高效快捷的实用技术。</p><p><br/></p>', N'c,', N'', N'/115\\218.html', N'', N'0', N'1')
GO

INSERT INTO [cms_article]  VALUES (N'219', N'', N'<p>锐诚PPT金牌设计师，毕业于上海美术学院视觉传达专业，曾在国内某知名4A广告公司任职，五年动画和PPT设计经验，拥有丰富的高端定制设计经验，专注于企业展示/工作汇报/品牌宣讲/竞聘/路演等高端PPT设计，设计理念：创意是设计的灵魂！在动画、质感和版式的设计上力求完美。</p><p><br/></p>', N'f,', N'', N'/115\\219.html', N'111', N'0', N'1')
GO


-- ----------------------------
-- Table structure for cms_class_50
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[cms_class_50]') AND type IN ('U'))
	DROP TABLE [cms_class_50]
GO

CREATE TABLE [cms_class_50] (
  [basicid] int NOT NULL,
  [school] nvarchar(220) COLLATE Chinese_PRC_CI_AS NULL,
  [platform] nvarchar(220) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [cms_class_50] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Table structure for comment
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[comment]') AND type IN ('U'))
	DROP TABLE [comment]
GO

CREATE TABLE [comment] (
  [comment_id] int IDENTITY(1,1) NOT NULL,
  [comment_commentid] int NOT NULL,
  [comment_content] nvarchar(2000) COLLATE Chinese_PRC_CI_AS NULL,
  [comment_picture] nvarchar(300) COLLATE Chinese_PRC_CI_AS NULL,
  [comment_time] datetime2(7) NOT NULL,
  [comment_type] int NOT NULL,
  [comment_peopleid] int DEFAULT ((0)) NULL,
  [comment_points] int DEFAULT ((0)) NULL,
  [comment_basicid] int NOT NULL,
  [comment_appid] int NULL,
  [comment_file_name] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [comment_file_path] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [comment_is_anonymous] int DEFAULT ((0)) NULL,
  [comment_audit] int DEFAULT ((0)) NULL
)
GO

ALTER TABLE [comment] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'评论id（主键）',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父评论id',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_commentid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'评论的内容',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_content'
GO

EXEC sp_addextendedproperty
'MS_Description', N'评论时发布的图片，可上传多张图片',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_picture'
GO

EXEC sp_addextendedproperty
'MS_Description', N'评论时间',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_time'
GO

EXEC sp_addextendedproperty
'MS_Description', N'评论的类型：1 匿名，2 公开，默认为公开',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'评论者id，默认为非会员用户（即游客）',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_peopleid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'评价打分（-1至5分）',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_points'
GO

EXEC sp_addextendedproperty
'MS_Description', N'（文章、商品...）绑定basicid（外键）',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_basicid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'(文章、商品）绑定的应用编号',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_appid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'附件文件名称',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_file_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'附件文件路径',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_file_path'
GO

EXEC sp_addextendedproperty
'MS_Description', N'是否匿名',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_is_anonymous'
GO

EXEC sp_addextendedproperty
'MS_Description', N'0默认显示 1:审核不通过',
'SCHEMA', N'dbo',
'TABLE', N'comment',
'COLUMN', N'comment_audit'
GO

EXEC sp_addextendedproperty
'MS_Description', N'评论表',
'SCHEMA', N'dbo',
'TABLE', N'comment'
GO


-- ----------------------------
-- Table structure for manager
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[manager]') AND type IN ('U'))
	DROP TABLE [manager]
GO

CREATE TABLE [manager] (
  [manager_id] int IDENTITY(1,1) NOT NULL,
  [manager_name] nvarchar(15) COLLATE Chinese_PRC_CI_AS NULL,
  [manager_nickname] nvarchar(15) COLLATE Chinese_PRC_CI_AS NULL,
  [manager_password] nvarchar(45) COLLATE Chinese_PRC_CI_AS NULL,
  [manager_roleid] int NULL,
  [manager_peopleid] bigint DEFAULT ((0)) NULL,
  [manager_time] datetime2(7) NULL
)
GO

ALTER TABLE [manager] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员id(主键)',
'SCHEMA', N'dbo',
'TABLE', N'manager',
'COLUMN', N'manager_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员用户名',
'SCHEMA', N'dbo',
'TABLE', N'manager',
'COLUMN', N'manager_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员昵称',
'SCHEMA', N'dbo',
'TABLE', N'manager',
'COLUMN', N'manager_nickname'
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员密码',
'SCHEMA', N'dbo',
'TABLE', N'manager',
'COLUMN', N'manager_password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色编号',
'SCHEMA', N'dbo',
'TABLE', N'manager',
'COLUMN', N'manager_roleid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户编号即商家编号',
'SCHEMA', N'dbo',
'TABLE', N'manager',
'COLUMN', N'manager_peopleid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员创建时间',
'SCHEMA', N'dbo',
'TABLE', N'manager',
'COLUMN', N'manager_time'
GO


EXEC sp_addextendedproperty
'MS_Description', N'管理员表',
'SCHEMA', N'dbo',
'TABLE', N'manager'
GO


-- ----------------------------
-- Records of [manager]
-- ----------------------------
SET IDENTITY_INSERT [manager] ON
GO

INSERT INTO [manager] ([manager_id], [manager_name], [manager_nickname], [manager_password], [manager_roleid], [manager_peopleid], [manager_time]) VALUES (N'50', N'msopen', N'msopen', N'9d8622060de5f24937b60585c3f4d66b', N'48', N'0', N'2015-09-18 11:54:36.0000000')
GO

SET IDENTITY_INSERT [manager] OFF
GO


-- ----------------------------
-- Table structure for manager_model_page
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[manager_model_page]') AND type IN ('U'))
	DROP TABLE [manager_model_page]
GO

CREATE TABLE [manager_model_page] (
  [mmp_manager_id] int NOT NULL,
  [mmp_model_id] int NULL,
  [mmp_url] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [manager_model_page] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增长id',
'SCHEMA', N'dbo',
'TABLE', N'manager_model_page',
'COLUMN', N'mmp_manager_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块编号',
'SCHEMA', N'dbo',
'TABLE', N'manager_model_page',
'COLUMN', N'mmp_model_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'默认后台显示的主界面',
'SCHEMA', N'dbo',
'TABLE', N'manager_model_page',
'COLUMN', N'mmp_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'管理员对应的每个模块的主界面自定义',
'SCHEMA', N'dbo',
'TABLE', N'manager_model_page'
GO


-- ----------------------------
-- Table structure for mdiy_content_mode_field
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[mdiy_content_mode_field]') AND type IN ('U'))
	DROP TABLE [mdiy_content_mode_field]
GO

CREATE TABLE [mdiy_content_mode_field] (
  [field_id] int IDENTITY(1,1) NOT NULL,
  [field_tipsname] nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [field_fieldname] nvarchar(20) COLLATE Chinese_PRC_CI_AS NULL,
  [field_type] int NULL,
  [field_default] nvarchar(250) COLLATE Chinese_PRC_CI_AS NULL,
  [field_isnull] int NULL,
  [field_cmid] int NULL,
  [field_sort] int NULL,
  [field_issearch] int NULL,
  [field_length] int NULL,
  [create_by] int NULL,
  [create_date] datetime2(7) NULL,
  [update_by] int NULL,
  [update_date] datetime2(7) NULL,
  [del] int NULL
)
GO

ALTER TABLE [mdiy_content_mode_field] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段自增长id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段提示文字',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_tipsname'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段名称',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_fieldname'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段类型（如1.单行，2.多行，3.图片，等）',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段默认值',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_default'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段是否为空 0:必填 1:可选',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_isnull'
GO

EXEC sp_addextendedproperty
'MS_Description', N'关联内容模型表id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_cmid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段排序',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段是否支持后台搜索0：不支持，1：支持',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_issearch'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段长度',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field',
'COLUMN', N'field_length'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义内容模型关联字段表',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_mode_field'
GO


-- ----------------------------
-- Records of [mdiy_content_mode_field]
-- ----------------------------
SET IDENTITY_INSERT [mdiy_content_mode_field] ON
GO

INSERT INTO [mdiy_content_mode_field] ([field_id], [field_tipsname], [field_fieldname], [field_type], [field_default], [field_isnull], [field_cmid], [field_sort], [field_issearch], [field_length], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'5', N'产品参数', N'detail', N'2', NULL, N'1', N'1', NULL, N'0', N'1', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [mdiy_content_mode_field] ([field_id], [field_tipsname], [field_fieldname], [field_type], [field_default], [field_isnull], [field_cmid], [field_sort], [field_issearch], [field_length], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'6', N'商品栏目ID', N'BI', N'1', NULL, N'1', N'2', NULL, N'0', N'1', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [mdiy_content_mode_field] ([field_id], [field_tipsname], [field_fieldname], [field_type], [field_default], [field_isnull], [field_cmid], [field_sort], [field_issearch], [field_length], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'8', N'描述1', N'descripone', N'2', NULL, N'1', N'3', NULL, N'0', N'1', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [mdiy_content_mode_field] ([field_id], [field_tipsname], [field_fieldname], [field_type], [field_default], [field_isnull], [field_cmid], [field_sort], [field_issearch], [field_length], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'9', N'描述2', N'descriptwo', N'2', NULL, N'1', N'3', NULL, N'0', N'1', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [mdiy_content_mode_field] ([field_id], [field_tipsname], [field_fieldname], [field_type], [field_default], [field_isnull], [field_cmid], [field_sort], [field_issearch], [field_length], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'10', N'描述3', N'descripTh', N'2', NULL, N'1', N'3', NULL, N'0', N'1', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [mdiy_content_mode_field] ([field_id], [field_tipsname], [field_fieldname], [field_type], [field_default], [field_isnull], [field_cmid], [field_sort], [field_issearch], [field_length], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'11', N'描述4', N'descripFo', N'2', NULL, N'1', N'3', NULL, N'0', N'1', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [mdiy_content_mode_field] ([field_id], [field_tipsname], [field_fieldname], [field_type], [field_default], [field_isnull], [field_cmid], [field_sort], [field_issearch], [field_length], [create_by], [create_date], [update_by], [update_date], [del]) VALUES (N'12', N'描述5', N'descripFi', N'2', NULL, N'1', N'3', NULL, N'0', N'1', NULL, NULL, NULL, NULL, NULL)
GO

SET IDENTITY_INSERT [mdiy_content_mode_field] OFF
GO


-- ----------------------------
-- Table structure for mdiy_content_model
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[mdiy_content_model]') AND type IN ('U'))
	DROP TABLE [mdiy_content_model]
GO

CREATE TABLE [mdiy_content_model] (
  [cm_id] int IDENTITY(1,1) NOT NULL,
  [cm_tips_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [cm_table_name] nvarchar(20) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [cm_model_id] int NULL,
  [cm_app_id] int NULL,
  [create_by] int NULL,
  [creaet_date] datetime2(7) NULL,
  [update_by] int NULL,
  [update_date] datetime2(7) NULL
)
GO

ALTER TABLE [mdiy_content_model] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增长id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_model',
'COLUMN', N'cm_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单提示文字',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_model',
'COLUMN', N'cm_tips_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'表单名称',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_model',
'COLUMN', N'cm_table_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块编号',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_model',
'COLUMN', N'cm_model_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用编号',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_model',
'COLUMN', N'cm_app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义模型表',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_content_model'
GO


-- ----------------------------
-- Records of [mdiy_content_model]
-- ----------------------------
SET IDENTITY_INSERT [mdiy_content_model] ON
GO

INSERT INTO [mdiy_content_model] ([cm_id], [cm_tips_name], [cm_table_name], [cm_model_id], [cm_app_id], [create_by], [creaet_date], [update_by], [update_date]) VALUES (N'1', N'茶叶', N'mdiy_tea_2', N'0', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [mdiy_content_model] ([cm_id], [cm_tips_name], [cm_table_name], [cm_model_id], [cm_app_id], [create_by], [creaet_date], [update_by], [update_date]) VALUES (N'2', N'商品品牌', N'mdiy_brand_2', N'0', NULL, NULL, NULL, NULL, NULL)
GO

INSERT INTO [mdiy_content_model] ([cm_id], [cm_tips_name], [cm_table_name], [cm_model_id], [cm_app_id], [create_by], [creaet_date], [update_by], [update_date]) VALUES (N'3', N'自定义', N'mdiy_mooc_50', N'0', NULL, NULL, NULL, NULL, NULL)
GO

SET IDENTITY_INSERT [mdiy_content_model] OFF
GO


-- ----------------------------
-- Table structure for mdiy_dict
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[mdiy_dict]') AND type IN ('U'))
	DROP TABLE [mdiy_dict]
GO

CREATE TABLE [mdiy_dict] (
  [dict_id] int IDENTITY(1,1) NOT NULL,
  [app_id] int NULL,
  [dict_value] nvarchar(100) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [dict_label] nvarchar(100) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [dict_type] nvarchar(100) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [dict_description] nvarchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [dict_sort] int DEFAULT ((0)) NOT NULL,
  [dict_parent_id] nvarchar(64) COLLATE Chinese_PRC_CI_AS NULL,
  [dict_remarks] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [create_by] int DEFAULT ((0)) NULL,
  [create_date] datetime2(7) NULL,
  [update_by] int DEFAULT ((0)) NULL,
  [update_date] datetime2(7) NULL,
  [del] int DEFAULT ((0)) NOT NULL
)
GO

ALTER TABLE [mdiy_dict] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'编号',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'dict_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用编号',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'数据值',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'dict_value'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标签名',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'dict_label'
GO

EXEC sp_addextendedproperty
'MS_Description', N'类型',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'dict_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'描述',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'dict_description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序（升序）',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'dict_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父级编号',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'dict_parent_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'备注信息',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'dict_remarks'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'create_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'update_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标记',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'del'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字典表',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict'
GO

-- ----------------------------
-- Records of [mdiy_dict]
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mdiy_dict] ON
GO

INSERT INTO [dbo].[mdiy_dict] VALUES (N'2', N'1', N'c', N'推荐', N'文章属性', NULL, N'4', NULL, NULL, N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [dbo].[mdiy_dict] VALUES (N'3', N'1', N'p', N'图片', N'文章属性', NULL, N'4', NULL, NULL, N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [dbo].[mdiy_dict] VALUES (N'4', N'1', N'h', N'头条', N'文章属性', NULL, N'2', NULL, NULL, N'0', NULL, N'0', NULL, N'0')
GO

INSERT INTO [dbo].[mdiy_dict] VALUES (N'5', N'1', N'f', N'幻灯', N'文章属性', NULL, N'2', NULL, NULL, N'0', NULL, N'0', NULL, N'0')
GO

SET IDENTITY_INSERT [dbo].[mdiy_dict] OFF
GO

-- ----------------------------
-- Table structure for mdiy_form
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[mdiy_form]') AND type IN ('U'))
	DROP TABLE [mdiy_form]
GO

CREATE TABLE [mdiy_form] (
  [form_id] int IDENTITY(1,1) NOT NULL,
  [form_tips_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [form_table_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [form_app_id] int NOT NULL,
  [create_by] int NULL,
  [create_date] datetime2(7) NULL,
  [update_by] int NULL,
  [update_date] datetime2(7) NULL
)
GO

ALTER TABLE [mdiy_form] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增长id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form',
'COLUMN', N'form_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义表单提示文字',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form',
'COLUMN', N'form_tips_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义表单关联的应用编号',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form',
'COLUMN', N'form_app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义表单表',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form'
GO

-- ----------------------------
-- Records of [mdiy_form]
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mdiy_form] ON
GO

INSERT INTO [dbo].[mdiy_form] VALUES (N'1', N'留言', N'mdiy_message_50', N'1', N'0', NULL, NULL, NULL)
GO

SET IDENTITY_INSERT [dbo].[mdiy_form] OFF
GO

-- ----------------------------
-- Table structure for mdiy_form_field
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[mdiy_form_field]') AND type IN ('U'))
	DROP TABLE [mdiy_form_field]
GO

CREATE TABLE [mdiy_form_field] (
  [ff_id] int IDENTITY(1,1) NOT NULL,
  [ff_tipsname] nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [ff_fieldname] nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [ff_type] int NULL,
  [ff_default] nvarchar(250) COLLATE Chinese_PRC_CI_AS NULL,
  [ff_isnull] int NULL,
  [ff_sort] int NULL,
  [ff_formid] int NULL
)
GO

ALTER TABLE [mdiy_form_field] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段自增长id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form_field',
'COLUMN', N'ff_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段提示文字',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form_field',
'COLUMN', N'ff_tipsname'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段类型（如1.单行，2.多行，3.图片，等）',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form_field',
'COLUMN', N'ff_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段的默认值',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form_field',
'COLUMN', N'ff_default'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段是否为空',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form_field',
'COLUMN', N'ff_isnull'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义表单的排序',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form_field',
'COLUMN', N'ff_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'字段管理的表单id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form_field',
'COLUMN', N'ff_formid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义表单字段表',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_form_field'
GO

-- ----------------------------
-- Records of [mdiy_form_field]
-- ----------------------------
SET IDENTITY_INSERT [dbo].[mdiy_form_field] ON
GO

INSERT INTO [dbo].[mdiy_form_field] VALUES (N'1', N'姓名', N'NAME', N'1', N'', N'0', N'0', N'1')
GO

INSERT INTO [dbo].[mdiy_form_field] VALUES (N'2', N'手机', N'PHONE', N'1', N'', N'0', N'0', N'1')
GO

INSERT INTO [dbo].[mdiy_form_field] VALUES (N'3', N'留言内容', N'CONTENT', N'3', N'', N'1', N'0', N'1')
GO

SET IDENTITY_INSERT [dbo].[mdiy_form_field] OFF
GO

-- ----------------------------
-- Table structure for mdiy_mooc_50
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[mdiy_mooc_50]') AND type IN ('U'))
	DROP TABLE [mdiy_mooc_50]
GO

CREATE TABLE [mdiy_mooc_50] (
  [basicid] int NOT NULL,
  [images] nvarchar(225) COLLATE Chinese_PRC_CI_AS NULL,
  [descripone] nvarchar(225) COLLATE Chinese_PRC_CI_AS NULL,
  [descriptwo] nvarchar(225) COLLATE Chinese_PRC_CI_AS NULL,
  [descripth] nvarchar(225) COLLATE Chinese_PRC_CI_AS NULL,
  [descripfo] nvarchar(225) COLLATE Chinese_PRC_CI_AS NULL,
  [descripfi] nvarchar(225) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [mdiy_mooc_50] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of [mdiy_mooc_50]
-- ----------------------------
INSERT INTO [mdiy_mooc_50]  VALUES (N'52', N'/upload/article/1638/1464835901016.jpeg|/upload/article/1638/1464835901049.jpg|/upload/article/1638/1464835901116.jpg|/upload/article/1638/1464835901184.jpeg', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'53', N'/upload/article/1638/1464835910115.jpg|/upload/article/1638/1464835910168.jpg|/upload/article/1638/1464835910230.jpeg|/upload/article/1638/1464835910293.jpeg', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'54', N'/upload/article/1638/1464836001681.jpg|/upload/article/1638/1464836001737.jpg|/upload/article/1638/1464836001790.jpeg|/upload/article/1638/1464836001868.jpg', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'55', N'/upload/article/1638/1464835993804.jpg|/upload/article/1638/1464835993869.jpg|/upload/article/1638/1464835993934.jpeg|/upload/article/1638/1464835993997.jpeg', N'想象一下走进一个狭小拥挤，遍地垃圾的商店。店员不停怂恿你买自己不想要的东西。在这种情况下，你肯定会马上转身离开去别家。如果有人给你压力，逼迫你在充满敌意的环境下快速做出抉择，你会自然而然的失去信任感。这一点也适用于网络。', N'网上充满着向你推销各种服务和产品的人。用户要先信任你，才能考虑从你那购买产品或服务。下面列出了10个比较流行的让用户相信、信任你登陆页面的方法。你可以借鉴或者干脆照搬这些方法为你的网上业务建立起值得信赖的网站。', N'每个来到你登陆页面的用户都会问同一个问题：你能给我带来什么好处？你需要让他们立刻看到你所能提供的价值。使用显眼的标题说明你所能提供的内容，以及你 与竞争对手的不同之处在哪。但是不要太过于强调你自己和你的公司，否则可能会让用户反感而离开。应当着重强调你如何满足用户的需求。', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'56', N'/upload/article/1638/1464835975699.jpg|/upload/article/1638/1464835975757.jpg|/upload/article/1638/1464835975815.jpeg|/upload/article/1638/1464835975875.jpeg', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'57', N'/upload/article/1638/1464835969386.jpg|/upload/article/1638/1464835969452.jpeg|/upload/article/1638/1464835969492.jpg|/upload/article/1638/1464835969559.jpg', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'58', N'/upload/article/1638/1464835892002.jpg|/upload/article/1638/1464835892054.jpg|/upload/article/1638/1464835892116.jpeg|/upload/article/1638/1464835892179.jpg', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'59', N'/upload/article/1638/1464835874500.jpg|/upload/article/1638/1464835874565.jpg|/upload/article/1638/1464835874617.jpeg|/upload/article/1638/1464835874678.jpg', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'60', N'/upload/article/1638/1464835866478.jpg|/upload/article/1638/1464835866538.jpg|/upload/article/1638/1464835866582.jpeg|/upload/article/1638/1464835866640.jpeg', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'61', N'/upload/article/1638/1464835988106.jpg|/upload/article/1638/1464835988154.jpg|/upload/article/1638/1464835988216.jpeg|/upload/article/1638/1464835988284.jpg', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'62', N'/upload/article/1638/1464835856964.jpg|/upload/article/1638/1464835857006.jpg|/upload/article/1638/1464835857074.jpeg|/upload/article/1638/1464835857133.jpg', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体')
GO

INSERT INTO [mdiy_mooc_50]  VALUES (N'63', N'/upload/article/1638/1464835842429.jpg|/upload/article/1638/1464835842841.jpeg|/upload/article/1638/1464835842898.jpg|/upload/article/1638/1464835842964.jpeg', N'一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', N'这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', N'网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', N'有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', N'能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？')
GO


-- ----------------------------
-- Table structure for mdiy_page
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[mdiy_page]') AND type IN ('U'))
	DROP TABLE [mdiy_page]
GO

CREATE TABLE [mdiy_page] (
  [page_id] int IDENTITY(1,1) NOT NULL,
  [page_app_id] int NOT NULL,
  [page_model_id] int NULL,
  [page_path] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [page_title] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [page_key] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [create_date] datetime2(7) NULL
)
GO

ALTER TABLE [mdiy_page] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增长id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_page',
'COLUMN', N'page_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_page',
'COLUMN', N'page_app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_page',
'COLUMN', N'page_model_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义页面绑定模板的路径',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_page',
'COLUMN', N'page_path'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义页面标题',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_page',
'COLUMN', N'page_title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义页面访问路径',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_page',
'COLUMN', N'page_key'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义页面表',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_page'
GO


-- ----------------------------
-- Records of [mdiy_page]
-- ----------------------------
SET IDENTITY_INSERT [mdiy_page] ON
GO

INSERT INTO [mdiy_page] ([page_id], [page_app_id], [page_model_id], [page_path], [page_title], [page_key], [create_date]) VALUES (N'1', N'1', N'0', N'people/register.htm', N'注册', N'register', NULL)
GO

INSERT INTO [mdiy_page] ([page_id], [page_app_id], [page_model_id], [page_path], [page_title], [page_key], [create_date]) VALUES (N'2', N'1', N'0', N'people/login.htm', N'登录', N'login', NULL)
GO

INSERT INTO [mdiy_page] ([page_id], [page_app_id], [page_model_id], [page_path], [page_title], [page_key], [create_date]) VALUES (N'3', N'1', N'0', N'people/center.htm', N'个人中心', N'people/center', NULL)
GO

INSERT INTO [mdiy_page] ([page_id], [page_app_id], [page_model_id], [page_path], [page_title], [page_key], [create_date]) VALUES (N'4', N'1', N'0', N'people/change-passWord.htm', N'修改密码', N'people/changePassWord', NULL)
GO

SET IDENTITY_INSERT [mdiy_page] OFF
GO


-- ----------------------------
-- Table structure for mdiy_search
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[mdiy_search]') AND type IN ('U'))
	DROP TABLE [mdiy_search]
GO

CREATE TABLE [mdiy_search] (
  [search_id] int IDENTITY(1,1) NOT NULL,
  [search_name] nvarchar(20) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [search_templets] nvarchar(50) COLLATE Chinese_PRC_CI_AS NOT NULL,
  [search_app_id] int NOT NULL,
  [search_type] nvarchar(20) COLLATE Chinese_PRC_CI_AS NOT NULL
)
GO

ALTER TABLE [mdiy_search] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自增长id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_search',
'COLUMN', N'search_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'搜索名称',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_search',
'COLUMN', N'search_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'搜索结果模版',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_search',
'COLUMN', N'search_templets'
GO

EXEC sp_addextendedproperty
'MS_Description', N'搜索管理的应用id',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_search',
'COLUMN', N'search_app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'搜索类型',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_search',
'COLUMN', N'search_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义搜索表',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_search'
GO

-- ----------------------------
-- Table structure for mdiy_message_50
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mdiy_message_50]') AND type IN ('U'))
	DROP TABLE [dbo].[mdiy_message_50]
GO

CREATE TABLE [dbo].[mdiy_message_50] (
  [Id] int IDENTITY(5,1) NOT NULL,
  [date] datetime DEFAULT NULL NULL,
  [fromID] int DEFAULT NULL NULL,
  [NAME] varchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [PHONE] varchar(100) COLLATE Chinese_PRC_CI_AS NULL,
  [CONTENT] text COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [dbo].[mdiy_message_50] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_message_50
-- ----------------------------
ALTER TABLE [dbo].[mdiy_message_50] ADD CONSTRAINT [PK__mdiy_mes__3214EC07F6D81267] PRIMARY KEY CLUSTERED ([Id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Records of [mdiy_search]
-- ----------------------------
SET IDENTITY_INSERT [mdiy_search] ON
GO

INSERT INTO [mdiy_search] ([search_id], [search_name], [search_templets], [search_app_id], [search_type]) VALUES (N'1', N'头部', N'search.htm', N'1', N'cms')
GO

INSERT INTO [mdiy_search] ([search_id], [search_name], [search_templets], [search_app_id], [search_type]) VALUES (N'9', N'列表页面搜索', N'search-list.htm', N'1', N'cms')
GO

SET IDENTITY_INSERT [mdiy_search] OFF
GO


-- ----------------------------
-- Table structure for model
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[model]') AND type IN ('U'))
	DROP TABLE [model]
GO

CREATE TABLE [model] (
  [model_id] int IDENTITY(1,1) NOT NULL,
  [model_title] nvarchar(150) COLLATE Chinese_PRC_CI_AS NULL,
  [model_code] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [model_modelid] int NULL,
  [model_url] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [model_datetime] datetime2(7) NULL,
  [model_icon] nvarchar(120) COLLATE Chinese_PRC_CI_AS NULL,
  [model_modelmanagerid] int NULL,
  [model_sort] int NULL,
  [model_ismenu] int NULL,
  [model_parent_ids] nvarchar(300) COLLATE Chinese_PRC_CI_AS NULL
)
GO

ALTER TABLE [model] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块自增长id',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块标题',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_title'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块编码',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块的父模块id',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_modelid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块连接地址',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块图标',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_icon'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块关联的关联员id',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_modelmanagerid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块的排序',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块是否是菜单',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_ismenu'
GO

EXEC sp_addextendedproperty
'MS_Description', N'父级编号集合，从小到大排序',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'model_parent_ids'
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块表',
'SCHEMA', N'dbo',
'TABLE', N'model'
GO


-- ----------------------------
-- Records of [model]
-- ----------------------------
SET IDENTITY_INSERT [model] ON
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'1', N'内容管理', N'02000000', NULL, N'', N'2014-08-01 16:19:50.0000000', N'&#xe77a;', N'0', N'0', N'1', NULL)
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'4', N'管理员管理', N'01020000', N'23', N'basic/manager/index.do', N'2014-08-03 09:15:02.0000000', N'', N'0', N'0', N'1', N'23')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'5', N'角色管理', N'01010000', N'23', N'basic/role/index.do', N'2014-08-03 09:15:14.0000000', N'', N'0', N'0', N'1', N'23')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'7', N'栏目管理', N'02990000', N'1', N'column/index.do', N'2014-08-03 09:16:29.0000000', N'', N'0', N'0', N'1', N'1')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'8', N'文章管理', N'02980000', N'1', N'cms/article/index.do', N'2014-08-03 09:17:10.0000000', N'', N'0', N'0', N'1', N'1')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'22', N'会员中心', N'07000000', NULL, N'', N'2014-09-08 08:11:28.0000000', N'&#xe6b6;', N'0', N'0', N'1', NULL)
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'23', N'权限管理', N'01000000', NULL, N'', N'2014-09-08 08:12:22.0000000', N'&#xe950;', N'0', N'0', N'1', NULL)
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'80', N'静态化', N'02020000', N'1', N'cms/generate/index.do', N'2014-12-18 11:37:15.0000000', N'', N'0', N'0', N'1', N'1')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'84', N'系统管理', N'12000000', NULL, N'', N'2014-12-18 18:30:24.0000000', N'&#xe71f;', N'0', N'0', N'1', NULL)
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'86', N'应用设置', N'12010000', N'84', N'app/-1/edit.do', N'2014-12-18 18:31:59.0000000', N'', N'0', N'0', N'1', N'84')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'88', N'用户管理', N'07020100', N'22', N'people/peopleUser/index.do ', N'2015-09-18 11:44:54.0000000', N'', N'0', N'0', N'1', N'22')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'91', N'模板管理', N'12020000', N'84', N'template/queryTemplateSkin.do', NULL, N'', N'0', N'0', N'1', N'84')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'92', N'查看', N'02990001', N'7', N'cms:column:view', N'2017-09-04 11:05:24.0000000', N'', N'0', N'0', N'0', N'1,7')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'93', N'查看', N'02980001', N'8', N'article:view', N'2017-09-04 11:05:58.0000000', N'', N'0', N'0', N'0', N'1,8')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'94', N'查看', N'02020001', N'80', N'cms:generate:view', N'2017-09-04 11:07:50.0000000', N'', N'0', N'0', N'0', N'1,80')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'95', N'查看', N'07020101', N'88', N'people:view', N'2017-09-04 11:08:24.0000000', N'', N'0', N'0', N'0', N'22,88')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'96', N'菜单管理', N'01030000', N'23', N'model/index.do', N'2017-09-04 11:09:26.0000000', N'', N'0', N'0', N'1', N'23')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'97', N'查看', N'01020001', N'4', N'manager:view', N'2017-09-04 11:09:58.0000000', N'', N'0', N'0', N'0', N'23,4')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'98', N'查看', N'01010001', N'5', N'role:view', N'2017-09-04 11:10:20.0000000', N'', N'0', N'0', N'0', N'23,5')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'99', N'查看', N'01030001', N'96', N'model:view', N'2017-09-04 11:10:43.0000000', N'', N'0', N'0', N'0', N'23,96')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'100', N'查看', N'12020001', N'91', N'template:view', N'2017-09-04 11:12:02.0000000', N'', N'0', N'0', N'0', N'84,91')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'101', N'查看', N'12010001', N'86', N'app:view', N'2017-09-04 11:12:46.0000000', N'', N'0', N'0', N'0', N'84,86')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'104', N'自定义管理', N'20000000', NULL, N'', N'2017-09-04 11:17:41.0000000', N'&#xe6dd', N'0', N'0', N'1', NULL)
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'105', N'自定义页面', N'20010000', N'104', N'mdiy/page/index.do', N'2017-09-04 11:18:51.0000000', N'', N'0', N'0', N'1', N'104')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'106', N'自定义表单', N'20020000', N'104', N'mdiy/form/index.do', N'2017-09-04 11:19:15.0000000', N'', N'0', N'0', N'1', N'104')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'107', N'自定义模型', N'20030000', N'104', N'mdiy/contentModel/index.do', N'2017-09-04 11:20:15.0000000', N'', N'0', N'0', N'1', N'104')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'108', N'自定义搜索', N'20040000', N'104', N'mdiy/search/index.do', N'2017-09-04 11:20:31.0000000', N'', N'0', N'0', N'1', N'104')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'109', N'自定义字典', N'20050000', N'104', N'mdiy/dict/index.do', N'2017-09-04 11:21:09.0000000', N'', N'0', N'0', N'1', N'104')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'110', N'查看', N'20010001', N'105', N'mdiy:page:view', N'2017-09-04 11:21:47.0000000', NULL, N'0', N'0', N'0', N'104,105')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'111', N'查看', N'20020001', N'106', N'mdiy:form:view', N'2017-09-04 11:22:17.0000000', N'', N'0', N'0', N'0', N'104,106')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'112', N'查看', N'20030001', N'107', N'mdiy:content:view', N'2017-09-04 11:22:45.0000000', N'', N'0', N'0', N'0', N'104,107')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'113', N'查看', N'20040001', N'108', N'mdiy:search:view', N'2017-09-04 11:23:04.0000000', N'', N'0', N'0', N'0', N'104,108')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'114', N'查看', N'20050001', N'109', N'mdiy:dict:view', N'2017-09-04 11:23:23.0000000', N'', N'0', N'0', N'0', N'104,109')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'115', N'删除', N'02980003', N'8', N'article:del', N'2017-09-04 13:24:41.0000000', N'', N'0', N'0', N'0', N'1,8')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'116', N'修改', N'02980004', N'8', N'article:update', N'2017-09-04 13:24:58.0000000', N'', N'0', N'0', N'0', N'1,8')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'117', N'新增', N'02980002', N'8', N'article:save', N'2017-09-04 13:25:37.0000000', N'', N'0', N'0', N'0', N'1,8')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'118', N'生成主页', N'02020002', N'80', N'cms:generate:index', N'2017-09-04 13:31:16.0000000', N'', N'0', N'0', N'0', N'1,80')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'119', N'生成栏目', N'02020003', N'80', N'cms:generate:column', N'2017-09-04 13:31:47.0000000', N'', N'0', N'0', N'0', N'1,80')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'120', N'生成文章', N'02020004', N'80', N'cms:generate:article', N'2017-09-04 13:32:14.0000000', N'', N'0', N'0', N'0', N'1,80')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'121', N'删除', N'07020103', N'88', N'people:del', N'2017-09-04 14:06:19.0000000', N'', N'0', N'0', N'0', N'22,88')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'122', N'修改', N'07020104', N'88', N'people:update', N'2017-09-04 14:07:40.0000000', N'', N'0', N'0', N'0', N'22,88')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'123', N'新增', N'07020102', N'88', N'people:save', N'2017-09-04 14:08:07.0000000', N'', N'0', N'0', N'0', N'22,88')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'124', N'删除', N'01020003', N'4', N'manager:del', N'2017-09-04 14:08:52.0000000', N'', N'0', N'0', N'0', N'23,4')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'125', N'修改', N'01020004', N'4', N'manager:update', N'2017-09-04 14:09:24.0000000', N'', N'0', N'0', N'0', N'23,4')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'126', N'新增', N'01020002', N'4', N'manager:save', N'2017-09-04 14:09:45.0000000', N'', N'0', N'0', N'0', N'23,4')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'127', N'删除', N'01010003', N'5', N'role:del', N'2017-09-04 14:10:56.0000000', N'', N'0', N'0', N'0', N'23,5')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'128', N'修改', N'01010004', N'5', N'role:update', N'2017-09-04 14:11:36.0000000', N'', N'0', N'0', N'0', N'23,5')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'129', N'新增', N'01010002', N'5', N'role:save', N'2017-09-04 14:12:09.0000000', N'', N'0', N'0', N'0', N'23,5')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'130', N'删除', N'01030003', N'96', N'model:del', N'2017-09-04 14:13:05.0000000', N'', N'0', N'0', N'0', N'23,96')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'131', N'修改', N'01030004', N'96', N'model:update', N'2017-09-04 14:13:34.0000000', N'', N'0', N'0', N'0', N'23,96')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'132', N'新增', N'01030002', N'96', N'model:save', N'2017-09-04 14:14:03.0000000', N'', N'0', N'0', N'0', N'23,96')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'133', N'修改', N'12010004', N'86', N'app:update', N'2017-09-04 14:14:42.0000000', N'', N'0', N'0', N'0', N'84,86')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'134', N'删除', N'12020003', N'91', N'template:del', N'2017-09-04 14:16:25.0000000', N'', N'0', N'0', N'0', N'84,91')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'135', N'修改', N'12020004', N'91', N'template:update', N'2017-09-04 14:16:54.0000000', N'', N'0', N'0', N'0', N'84,91')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'136', N'上传', N'12020002', N'91', N'template:upload', N'2017-09-04 14:18:20.0000000', N'', N'0', N'0', N'0', N'84,91')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'137', N'删除', N'20010003', N'105', N'mdiy:page:del', N'2017-09-04 14:19:05.0000000', NULL, N'0', N'0', N'0', N'104,105')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'138', N'修改', N'20010004', N'105', N'mdiy:page:update', N'2017-09-04 14:19:44.0000000', NULL, N'0', N'0', N'0', N'104,105')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'139', N'新增', N'20010002', N'105', N'mdiy:page:save', N'2017-09-04 14:20:04.0000000', NULL, N'0', N'0', N'0', N'104,105')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'140', N'删除', N'20020003', N'106', N'mdiy:form:del', N'2017-09-04 14:23:53.0000000', N'', N'0', N'0', N'0', N'104,106')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'141', N'修改', N'20020004', N'106', N'mdiy:form:update', N'2017-09-04 14:24:20.0000000', N'', N'0', N'0', N'0', N'104,106')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'142', N'新增', N'20020002', N'106', N'mdiy:form:save', N'2017-09-04 14:24:39.0000000', N'', N'0', N'0', N'0', N'104,106')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'143', N'删除', N'20030003', N'107', N'mdiy:content:del', N'2017-09-04 14:25:21.0000000', N'', N'0', N'0', N'0', N'104,107')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'144', N'修改', N'20030004', N'107', N'mdiy:content:update', N'2017-09-04 14:25:48.0000000', N'', N'0', N'0', N'0', N'104,107')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'145', N'新增', N'20030002', N'107', N'mdiy:content:save', N'2017-09-04 14:26:12.0000000', N'', N'0', N'0', N'0', N'104,107')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'146', N'删除', N'20040003', N'108', N'mdiy:search:del', N'2017-09-04 14:26:55.0000000', N'', N'0', N'0', N'0', N'104,108')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'147', N'修改', N'20040004', N'108', N'mdiy:search:update', N'2017-09-04 14:27:13.0000000', N'', N'0', N'0', N'0', N'104,108')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'148', N'新增', N'20040002', N'108', N'mdiy:search:save', N'2017-09-04 14:27:33.0000000', N'', N'0', N'0', N'0', N'104,108')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'149', N'删除', N'20050003', N'109', N'mdiy:dict:del', N'2017-09-04 14:28:00.0000000', N'', N'0', N'0', N'0', N'104,109')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'150', N'修改', N'20050003', N'109', N'mdiy:dict:update', N'2017-09-04 14:28:17.0000000', N'', N'0', N'0', N'0', N'104,109')
GO

INSERT INTO [model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids]) VALUES (N'151', N'新增', N'20050002', N'109', N'mdiy:dict:save', N'2017-09-04 14:28:41.0000000', N'', N'0', N'0', N'0', N'104,109')
GO

SET IDENTITY_INSERT [model] OFF
GO


-- ----------------------------
-- Table structure for people
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[people]') AND type IN ('U'))
	DROP TABLE [people]
GO

CREATE TABLE [people] (
  [people_id] int IDENTITY(1,1) NOT NULL,
  [people_phone] nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [people_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [people_password] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [people_datetime] datetime2(7) NULL,
  [people_app_id] int NOT NULL,
  [people_mail] nvarchar(120) COLLATE Chinese_PRC_CI_AS NULL,
  [people_state] int DEFAULT ((0)) NULL,
  [people_code] nvarchar(15) COLLATE Chinese_PRC_CI_AS NULL,
  [people_codesenddate] datetime2(7) NULL,
  [people_phonecheck] int DEFAULT ((0)) NULL,
  [people_maillcheck] int DEFAULT ((0)) NULL
)
GO

ALTER TABLE [people] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'增长自id',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'手机号码',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_phone'
GO

EXEC sp_addextendedproperty
'MS_Description', N'账号',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'密码',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_password'
GO

EXEC sp_addextendedproperty
'MS_Description', N'注册时间',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_datetime'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用编号',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户邮箱',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_mail'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户状态',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_state'
GO

EXEC sp_addextendedproperty
'MS_Description', N'随机验证码',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_code'
GO

EXEC sp_addextendedproperty
'MS_Description', N'发送验证码时间',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_codesenddate'
GO

EXEC sp_addextendedproperty
'MS_Description', N'1手机验证通过',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_phonecheck'
GO

EXEC sp_addextendedproperty
'MS_Description', N'1邮箱验证通过',
'SCHEMA', N'dbo',
'TABLE', N'people',
'COLUMN', N'people_maillcheck'
GO

EXEC sp_addextendedproperty
'MS_Description', N'户用基础表',
'SCHEMA', N'dbo',
'TABLE', N'people'
GO


-- ----------------------------
-- Records of [people]
-- ----------------------------
SET IDENTITY_INSERT [people] ON
GO

INSERT INTO [people] ([people_id], [people_phone], [people_name], [people_password], [people_datetime], [people_app_id], [people_mail], [people_state], [people_code], [people_codesenddate], [people_phonecheck], [people_maillcheck]) VALUES (N'1', N'', N'msopen', N'9d8622060de5f24937b60585c3f4d66b', N'2018-05-10 11:18:36.0000000', N'1', N'', N'0', NULL, NULL, NULL, NULL)
GO

SET IDENTITY_INSERT [people] OFF
GO


-- ----------------------------
-- Table structure for people_user
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[people_user]') AND type IN ('U'))
	DROP TABLE [people_user]
GO

CREATE TABLE [people_user] (
  [pu_people_id] int NOT NULL,
  [pu_real_name] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [pu_address] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [pu_icon] nvarchar(200) COLLATE Chinese_PRC_CI_AS NULL,
  [pu_nickname] nvarchar(50) COLLATE Chinese_PRC_CI_AS NULL,
  [pu_sex] int NULL,
  [pu_birthday] date NULL,
  [pu_card] nvarchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [pu_province] int DEFAULT ((0)) NULL,
  [pu_city] int DEFAULT ((0)) NULL,
  [pu_district] int DEFAULT ((0)) NULL,
  [pu_street] int DEFAULT ((0)) NULL
)
GO

ALTER TABLE [people_user] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户id关联people表的（people_id）',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_people_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户真实名称',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_real_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户地址',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_address'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户头像图标地址',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_icon'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户昵称',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_nickname'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户性别(0.未知、1.男、2.女)',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_sex'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户出生年月日',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_birthday'
GO

EXEC sp_addextendedproperty
'MS_Description', N'身份证',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_card'
GO

EXEC sp_addextendedproperty
'MS_Description', N'省',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_province'
GO

EXEC sp_addextendedproperty
'MS_Description', N'城市',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_city'
GO

EXEC sp_addextendedproperty
'MS_Description', N'区',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_district'
GO

EXEC sp_addextendedproperty
'MS_Description', N'街道',
'SCHEMA', N'dbo',
'TABLE', N'people_user',
'COLUMN', N'pu_street'
GO

EXEC sp_addextendedproperty
'MS_Description', N'用户基础信息表',
'SCHEMA', N'dbo',
'TABLE', N'people_user'
GO


-- ----------------------------
-- Records of [people_user]
-- ----------------------------
INSERT INTO [people_user]  VALUES (N'1', NULL, NULL, N'', N'msopen', N'1', NULL, NULL, NULL, NULL, NULL, NULL)
GO


-- ----------------------------
-- Table structure for role
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[role]') AND type IN ('U'))
	DROP TABLE [role]
GO

CREATE TABLE [role] (
  [role_id] int IDENTITY(1,1) NOT NULL,
  [role_name] nvarchar(30) COLLATE Chinese_PRC_CI_AS NULL,
  [role_managerid] int DEFAULT ((0)) NULL,
  [app_id] int NOT NULL
)
GO

ALTER TABLE [role] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色id，自增长',
'SCHEMA', N'dbo',
'TABLE', N'role',
'COLUMN', N'role_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色名',
'SCHEMA', N'dbo',
'TABLE', N'role',
'COLUMN', N'role_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色管理员编号',
'SCHEMA', N'dbo',
'TABLE', N'role',
'COLUMN', N'role_managerid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'应用编号',
'SCHEMA', N'dbo',
'TABLE', N'role',
'COLUMN', N'app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色表',
'SCHEMA', N'dbo',
'TABLE', N'role'
GO


-- ----------------------------
-- Records of [role]
-- ----------------------------
SET IDENTITY_INSERT [role] ON
GO

INSERT INTO [role] ([role_id], [role_name], [role_managerid], [app_id]) VALUES (N'48', N'msopen', N'50', N'1')
GO

SET IDENTITY_INSERT [role] OFF
GO


-- ----------------------------
-- Table structure for role_model
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[role_model]') AND type IN ('U'))
	DROP TABLE [role_model]
GO

CREATE TABLE [role_model] (
  [rm_modelid] int NOT NULL,
  [rm_roleid] int NULL
)
GO

ALTER TABLE [role_model] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'模块编号',
'SCHEMA', N'dbo',
'TABLE', N'role_model',
'COLUMN', N'rm_modelid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色编号',
'SCHEMA', N'dbo',
'TABLE', N'role_model',
'COLUMN', N'rm_roleid'
GO

EXEC sp_addextendedproperty
'MS_Description', N'角色模块关联表',
'SCHEMA', N'dbo',
'TABLE', N'role_model'
GO


-- ----------------------------
-- Records of [role_model]
-- ----------------------------
INSERT INTO [role_model]  VALUES (N'1', N'48')
GO

INSERT INTO [role_model]  VALUES (N'1', N'48')
GO

INSERT INTO [role_model]  VALUES (N'4', N'48')
GO

INSERT INTO [role_model]  VALUES (N'5', N'48')
GO

INSERT INTO [role_model]  VALUES (N'7', N'48')
GO

INSERT INTO [role_model]  VALUES (N'8', N'48')
GO

INSERT INTO [role_model]  VALUES (N'22', N'48')
GO

INSERT INTO [role_model]  VALUES (N'23', N'48')
GO

INSERT INTO [role_model]  VALUES (N'80', N'48')
GO

INSERT INTO [role_model]  VALUES (N'84', N'48')
GO

INSERT INTO [role_model]  VALUES (N'86', N'48')
GO

INSERT INTO [role_model]  VALUES (N'88', N'48')
GO

INSERT INTO [role_model]  VALUES (N'91', N'48')
GO

INSERT INTO [role_model]  VALUES (N'92', N'48')
GO

INSERT INTO [role_model]  VALUES (N'93', N'48')
GO

INSERT INTO [role_model]  VALUES (N'94', N'48')
GO

INSERT INTO [role_model]  VALUES (N'95', N'48')
GO

INSERT INTO [role_model]  VALUES (N'96', N'48')
GO

INSERT INTO [role_model]  VALUES (N'97', N'48')
GO

INSERT INTO [role_model]  VALUES (N'98', N'48')
GO

INSERT INTO [role_model]  VALUES (N'99', N'48')
GO

INSERT INTO [role_model]  VALUES (N'100', N'48')
GO

INSERT INTO [role_model]  VALUES (N'101', N'48')
GO

INSERT INTO [role_model]  VALUES (N'104', N'48')
GO

INSERT INTO [role_model]  VALUES (N'105', N'48')
GO

INSERT INTO [role_model]  VALUES (N'106', N'48')
GO

INSERT INTO [role_model]  VALUES (N'107', N'48')
GO

INSERT INTO [role_model]  VALUES (N'108', N'48')
GO

INSERT INTO [role_model]  VALUES (N'109', N'48')
GO

INSERT INTO [role_model]  VALUES (N'110', N'48')
GO

INSERT INTO [role_model]  VALUES (N'111', N'48')
GO

INSERT INTO [role_model]  VALUES (N'112', N'48')
GO

INSERT INTO [role_model]  VALUES (N'113', N'48')
GO

INSERT INTO [role_model]  VALUES (N'114', N'48')
GO

INSERT INTO [role_model]  VALUES (N'115', N'48')
GO

INSERT INTO [role_model]  VALUES (N'116', N'48')
GO

INSERT INTO [role_model]  VALUES (N'117', N'48')
GO

INSERT INTO [role_model]  VALUES (N'118', N'48')
GO

INSERT INTO [role_model]  VALUES (N'119', N'48')
GO

INSERT INTO [role_model]  VALUES (N'120', N'48')
GO

INSERT INTO [role_model]  VALUES (N'121', N'48')
GO

INSERT INTO [role_model]  VALUES (N'122', N'48')
GO

INSERT INTO [role_model]  VALUES (N'123', N'48')
GO

INSERT INTO [role_model]  VALUES (N'124', N'48')
GO

INSERT INTO [role_model]  VALUES (N'125', N'48')
GO

INSERT INTO [role_model]  VALUES (N'126', N'48')
GO

INSERT INTO [role_model]  VALUES (N'127', N'48')
GO

INSERT INTO [role_model]  VALUES (N'128', N'48')
GO

INSERT INTO [role_model]  VALUES (N'129', N'48')
GO

INSERT INTO [role_model]  VALUES (N'130', N'48')
GO

INSERT INTO [role_model]  VALUES (N'131', N'48')
GO

INSERT INTO [role_model]  VALUES (N'132', N'48')
GO

INSERT INTO [role_model]  VALUES (N'133', N'48')
GO

INSERT INTO [role_model]  VALUES (N'134', N'48')
GO

INSERT INTO [role_model]  VALUES (N'135', N'48')
GO

INSERT INTO [role_model]  VALUES (N'136', N'48')
GO

INSERT INTO [role_model]  VALUES (N'137', N'48')
GO

INSERT INTO [role_model]  VALUES (N'138', N'48')
GO

INSERT INTO [role_model]  VALUES (N'139', N'48')
GO

INSERT INTO [role_model]  VALUES (N'140', N'48')
GO

INSERT INTO [role_model]  VALUES (N'141', N'48')
GO

INSERT INTO [role_model]  VALUES (N'142', N'48')
GO

INSERT INTO [role_model]  VALUES (N'143', N'48')
GO

INSERT INTO [role_model]  VALUES (N'144', N'48')
GO

INSERT INTO [role_model]  VALUES (N'145', N'48')
GO

INSERT INTO [role_model]  VALUES (N'146', N'48')
GO

INSERT INTO [role_model]  VALUES (N'147', N'48')
GO

INSERT INTO [role_model]  VALUES (N'148', N'48')
GO

INSERT INTO [role_model]  VALUES (N'149', N'48')
GO

INSERT INTO [role_model]  VALUES (N'150', N'48')
GO

INSERT INTO [role_model]  VALUES (N'151', N'48')
GO





-- ----------------------------
-- Indexes structure for table app
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_app_manager_1]
ON [app] (
  [app_managerid] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table app
-- ----------------------------
ALTER TABLE [app] ADD CONSTRAINT [PK__app__6F8A0A346FDCCBAA] PRIMARY KEY CLUSTERED ([app_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table basic
-- ----------------------------
CREATE NONCLUSTERED INDEX [basic_id]
ON [basic] (
  [basic_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [basic_title]
ON [basic] (
  [basic_title] ASC
)
GO

CREATE NONCLUSTERED INDEX [basic_appid]
ON [basic] (
  [basic_appid] ASC
)
GO

CREATE NONCLUSTERED INDEX [basic_modelid]
ON [basic] (
  [basic_modelid] ASC
)
GO

CREATE NONCLUSTERED INDEX [basic_categoryid]
ON [basic] (
  [basic_categoryid] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table basic
-- ----------------------------
ALTER TABLE [basic] ADD CONSTRAINT [PK__basic__4AA24BED86A2C5A0] PRIMARY KEY CLUSTERED ([basic_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table basic_attention
-- ----------------------------
CREATE NONCLUSTERED INDEX [ba_peopleid]
ON [basic_attention] (
  [ba_people_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [fk_basic_attention_basic_1]
ON [basic_attention] (
  [ba_basic_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table basic_attention
-- ----------------------------
ALTER TABLE [basic_attention] ADD CONSTRAINT [PK__basic_at__95A0A937FF65E753] PRIMARY KEY CLUSTERED ([ba_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table basic_column
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_basic_column_1]
ON [basic_column] (
  [column_cm_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table basic_column
-- ----------------------------
ALTER TABLE [basic_column] ADD CONSTRAINT [PK__basic_co__6254AE3D9EB3C2F3] PRIMARY KEY CLUSTERED ([column_category_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table basic_log
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_basic_log_basic_1]
ON [basic_log] (
  [bl_basic_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table basic_log
-- ----------------------------
ALTER TABLE [basic_log] ADD CONSTRAINT [PK__basic_lo__86FB260A0C060820] PRIMARY KEY CLUSTERED ([bl_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table category
-- ----------------------------
CREATE NONCLUSTERED INDEX [category_appid]
ON [category] (
  [category_appid] ASC
)
GO

CREATE NONCLUSTERED INDEX [category_managerid]
ON [category] (
  [category_managerid] ASC
)
GO

CREATE NONCLUSTERED INDEX [category_modelid]
ON [category] (
  [category_modelid] ASC
)
GO

CREATE NONCLUSTERED INDEX [category_categoryid]
ON [category] (
  [category_categoryid] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table category
-- ----------------------------
ALTER TABLE [category] ADD CONSTRAINT [PK__category__D54EE9B4CD6578B1] PRIMARY KEY CLUSTERED ([category_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table cms_article
-- ----------------------------
CREATE NONCLUSTERED INDEX [article_basicid]
ON [cms_article] (
  [article_basicid] ASC
)
GO

CREATE NONCLUSTERED INDEX [article_webid]
ON [cms_article] (
  [article_webid] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table cms_article
-- ----------------------------
ALTER TABLE [cms_article] ADD CONSTRAINT [PK__cms_arti__7D62D14BA00CC007] PRIMARY KEY CLUSTERED ([article_basicid])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table cms_class_50
-- ----------------------------
ALTER TABLE [cms_class_50] ADD CONSTRAINT [PK__cms_clas__CD1605CE9C8F2240] PRIMARY KEY CLUSTERED ([basicid])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table comment
-- ----------------------------
CREATE NONCLUSTERED INDEX [index2]
ON [comment] (
  [comment_basicid] ASC
)
GO

CREATE NONCLUSTERED INDEX [fk_comment_people_1]
ON [comment] (
  [comment_peopleid] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table comment
-- ----------------------------
ALTER TABLE [comment] ADD CONSTRAINT [PK__comment__E795768779F6FA12] PRIMARY KEY CLUSTERED ([comment_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table manager
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_manager_role_1]
ON [manager] (
  [manager_roleid] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table manager
-- ----------------------------
ALTER TABLE [manager] ADD CONSTRAINT [PK__manager__5A6073FC300C393B] PRIMARY KEY CLUSTERED ([manager_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table manager_model_page
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_manager_model_page_manager_1]
ON [manager_model_page] (
  [mmp_manager_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [fk_manager_model_page_model_1]
ON [manager_model_page] (
  [mmp_model_id] ASC
)
GO


-- ----------------------------
-- Indexes structure for table mdiy_content_mode_field
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_mdiy_content_mode_field_mdiy_content_model_1]
ON [mdiy_content_mode_field] (
  [field_cmid] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_content_mode_field
-- ----------------------------
ALTER TABLE [mdiy_content_mode_field] ADD CONSTRAINT [PK__mdiy_con__1BB6F43EADF54000] PRIMARY KEY CLUSTERED ([field_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mdiy_content_model
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_mdiy_content_model]
ON [mdiy_content_model] (
  [cm_app_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_content_model
-- ----------------------------
ALTER TABLE [mdiy_content_model] ADD CONSTRAINT [PK__mdiy_con__682312EC1B6B0608] PRIMARY KEY CLUSTERED ([cm_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mdiy_dict
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_mdiy_dict]
ON [mdiy_dict] (
  [app_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_dict
-- ----------------------------
ALTER TABLE [mdiy_dict] ADD CONSTRAINT [PK__mdiy_dic__3BD4186CFFA3416C] PRIMARY KEY CLUSTERED ([dict_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mdiy_form
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_mdiy_form]
ON [mdiy_form] (
  [form_app_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_form
-- ----------------------------
ALTER TABLE [mdiy_form] ADD CONSTRAINT [PK__mdiy_for__190E16C9BBD2C19D] PRIMARY KEY CLUSTERED ([form_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mdiy_form_field
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_mdiy_form_field]
ON [mdiy_form_field] (
  [ff_formid] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_form_field
-- ----------------------------
ALTER TABLE [mdiy_form_field] ADD CONSTRAINT [PK__mdiy_for__8F8A371D6D7D7AEB] PRIMARY KEY CLUSTERED ([ff_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table mdiy_mooc_50
-- ----------------------------
ALTER TABLE [mdiy_mooc_50] ADD CONSTRAINT [PK__mdiy_moo__CD1605CE04016701] PRIMARY KEY CLUSTERED ([basicid])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mdiy_page
-- ----------------------------
CREATE NONCLUSTERED INDEX [index_page_key]
ON [mdiy_page] (
  [page_key] ASC
)
GO

CREATE NONCLUSTERED INDEX [index_page_app_id]
ON [mdiy_page] (
  [page_app_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [index_page_model_id]
ON [mdiy_page] (
  [page_model_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_page
-- ----------------------------
ALTER TABLE [mdiy_page] ADD CONSTRAINT [PK__mdiy_pag__637F305A160CB88F] PRIMARY KEY CLUSTERED ([page_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table mdiy_search
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_mdiy_search]
ON [mdiy_search] (
  [search_app_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_search
-- ----------------------------
ALTER TABLE [mdiy_search] ADD CONSTRAINT [PK__mdiy_sea__B302268D8A9DE53B] PRIMARY KEY CLUSTERED ([search_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table model
-- ----------------------------
CREATE NONCLUSTERED INDEX [sys_c009201]
ON [model] (
  [model_id] ASC
)
GO

CREATE NONCLUSTERED INDEX [model_modelid]
ON [model] (
  [model_modelid] ASC
)
GO

CREATE NONCLUSTERED INDEX [model_code]
ON [model] (
  [model_code] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table model
-- ----------------------------
ALTER TABLE [model] ADD CONSTRAINT [PK__model__DC39CAF43F0EB127] PRIMARY KEY CLUSTERED ([model_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table people
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_people]
ON [people] (
  [people_app_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table people
-- ----------------------------
ALTER TABLE [people] ADD CONSTRAINT [PK__people__9241A81F8A6A76B7] PRIMARY KEY CLUSTERED ([people_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table people_user
-- ----------------------------
CREATE NONCLUSTERED INDEX [pu_people_id]
ON [people_user] (
  [pu_people_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table people_user
-- ----------------------------
ALTER TABLE [people_user] ADD CONSTRAINT [PK__people_u__4F37481E99F7AF4D] PRIMARY KEY CLUSTERED ([pu_people_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table role
-- ----------------------------
ALTER TABLE [role] ADD CONSTRAINT [PK__role__760965CC2650EDCD] PRIMARY KEY CLUSTERED ([role_id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Indexes structure for table role_model
-- ----------------------------
CREATE NONCLUSTERED INDEX [index]
ON [role_model] (
  [rm_modelid] ASC,
  [rm_roleid] ASC
)
GO

CREATE NONCLUSTERED INDEX [rm_modelid]
ON [role_model] (
  [rm_modelid] ASC
)
GO

CREATE NONCLUSTERED INDEX [fk_role_model_role_1]
ON [role_model] (
  [rm_roleid] ASC
)
GO


-- ----------------------------
-- Foreign Keys structure for table app
-- ----------------------------
ALTER TABLE [app] ADD CONSTRAINT [fk_app_manager_1] FOREIGN KEY ([app_managerid]) REFERENCES [manager] ([manager_id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table basic
-- ----------------------------
ALTER TABLE [basic] ADD CONSTRAINT [fk_basic_app_1] FOREIGN KEY ([basic_appid]) REFERENCES [app] ([app_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [basic] ADD CONSTRAINT [fk_basic_category_1] FOREIGN KEY ([basic_categoryid]) REFERENCES [category] ([category_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table basic_attention
-- ----------------------------
ALTER TABLE [basic_attention] ADD CONSTRAINT [fk_basic_attention_basic_1] FOREIGN KEY ([ba_basic_id]) REFERENCES [basic] ([basic_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table basic_column
-- ----------------------------
ALTER TABLE [basic_column] ADD CONSTRAINT [fk_basic_column] FOREIGN KEY ([column_category_id]) REFERENCES [category] ([category_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [basic_column] ADD CONSTRAINT [fk_basic_column_1] FOREIGN KEY ([column_cm_id]) REFERENCES [mdiy_content_model] ([cm_id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table basic_log
-- ----------------------------
ALTER TABLE [basic_log] ADD CONSTRAINT [fk_basic_log_basic_1] FOREIGN KEY ([bl_basic_id]) REFERENCES [basic] ([basic_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table category
-- ----------------------------
ALTER TABLE [category] ADD CONSTRAINT [fk_category] FOREIGN KEY ([category_categoryid]) REFERENCES [category] ([category_id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [category] ADD CONSTRAINT [fk_category_1] FOREIGN KEY ([category_appid]) REFERENCES [app] ([app_id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table cms_article
-- ----------------------------
ALTER TABLE [cms_article] ADD CONSTRAINT [fk_cms_article_basic_1] FOREIGN KEY ([article_basicid]) REFERENCES [basic] ([basic_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table comment
-- ----------------------------
ALTER TABLE [comment] ADD CONSTRAINT [fk_comment] FOREIGN KEY ([comment_basicid]) REFERENCES [basic] ([basic_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [comment] ADD CONSTRAINT [fk_comment_people_1] FOREIGN KEY ([comment_peopleid]) REFERENCES [people] ([people_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table manager
-- ----------------------------
ALTER TABLE [manager] ADD CONSTRAINT [fk_manager_role_1] FOREIGN KEY ([manager_roleid]) REFERENCES [role] ([role_id]) ON DELETE SET NULL ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table manager_model_page
-- ----------------------------
ALTER TABLE [manager_model_page] ADD CONSTRAINT [fk_manager_model_page_manager_1] FOREIGN KEY ([mmp_manager_id]) REFERENCES [manager] ([manager_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [manager_model_page] ADD CONSTRAINT [fk_manager_model_page_model_1] FOREIGN KEY ([mmp_model_id]) REFERENCES [model] ([model_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_content_mode_field
-- ----------------------------
ALTER TABLE [mdiy_content_mode_field] ADD CONSTRAINT [fk_mdiy_content_mode_field_mdiy_content_model_1] FOREIGN KEY ([field_cmid]) REFERENCES [mdiy_content_model] ([cm_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_content_model
-- ----------------------------
ALTER TABLE [mdiy_content_model] ADD CONSTRAINT [fk_mdiy_content_model] FOREIGN KEY ([cm_app_id]) REFERENCES [app] ([app_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_dict
-- ----------------------------
ALTER TABLE [mdiy_dict] ADD CONSTRAINT [fk_mdiy_dict] FOREIGN KEY ([app_id]) REFERENCES [app] ([app_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_form
-- ----------------------------
ALTER TABLE [mdiy_form] ADD CONSTRAINT [fk_mdiy_form] FOREIGN KEY ([form_app_id]) REFERENCES [app] ([app_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_form_field
-- ----------------------------
ALTER TABLE [mdiy_form_field] ADD CONSTRAINT [fk_mdiy_form_field] FOREIGN KEY ([ff_formid]) REFERENCES [mdiy_form] ([form_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_mooc_50
-- ----------------------------
ALTER TABLE [mdiy_mooc_50] ADD CONSTRAINT [fk_mdiy_mooc_50_basicid] FOREIGN KEY ([basicid]) REFERENCES [basic] ([basic_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_page
-- ----------------------------
ALTER TABLE [mdiy_page] ADD CONSTRAINT [fk_model_template_app_1] FOREIGN KEY ([page_app_id]) REFERENCES [app] ([app_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_search
-- ----------------------------
ALTER TABLE [mdiy_search] ADD CONSTRAINT [fk_mdiy_search] FOREIGN KEY ([search_app_id]) REFERENCES [app] ([app_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table model
-- ----------------------------
ALTER TABLE [model] ADD CONSTRAINT [model_ibfk_1] FOREIGN KEY ([model_modelid]) REFERENCES [model] ([model_id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table people
-- ----------------------------
ALTER TABLE [people] ADD CONSTRAINT [fk_people] FOREIGN KEY ([people_app_id]) REFERENCES [app] ([app_id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table people_user
-- ----------------------------
ALTER TABLE [people_user] ADD CONSTRAINT [fk_people_user_people_1] FOREIGN KEY ([pu_people_id]) REFERENCES [people] ([people_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table role_model
-- ----------------------------
ALTER TABLE [role_model] ADD CONSTRAINT [fk_role_model_role_1] FOREIGN KEY ([rm_roleid]) REFERENCES [role] ([role_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO

ALTER TABLE [role_model] ADD CONSTRAINT [role_model_ibfk_1] FOREIGN KEY ([rm_modelid]) REFERENCES [model] ([model_id]) ON DELETE CASCADE ON UPDATE NO ACTION
GO




