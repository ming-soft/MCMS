
-- ----------------------------
-- Table structure for APP
-- ----------------------------
DROP TABLE "APP";
CREATE TABLE "APP" (
  "APP_ID" NUMBER(11) NOT NULL ,
  "APP_NAME" NVARCHAR2(60) NOT NULL ,
  "APP_URL" NVARCHAR2(200) NOT NULL ,
  "APP_LOGO" NVARCHAR2(120) ,
  "APP_KEYWORD" NVARCHAR2(500) ,
  "APP_COPYRIGHT" NVARCHAR2(500) ,
  "APP_STYLE" NVARCHAR2(50) ,
  "APP_MANAGERID" NUMBER(11) ,
  "APP_DESCRIPTION" NVARCHAR2(500) ,
  "APP_DATETIME" DATE ,
  "APP_MOBILE_STYLE" NVARCHAR2(11) ,
  "APP_PAY_DATE" DATE ,
  "APP_PAY" NVARCHAR2(300) ,
  "APP_STATE" NUMBER(1) DEFAULT 0  NOT NULL ,
  "APP_MOBILE_STATE" NUMBER(1) DEFAULT 0  NOT NULL ,
  "APP_LOGIN_PAGE" NVARCHAR2(255)  
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "APP"."APP_ID" IS '站点id';
COMMENT ON COLUMN "APP"."APP_NAME" IS '站点名称';
COMMENT ON COLUMN "APP"."APP_URL" IS '站点域名，多个回车换行显示';
COMMENT ON COLUMN "APP"."APP_LOGO" IS '网站logo';
COMMENT ON COLUMN "APP"."APP_KEYWORD" IS '站点关键字';
COMMENT ON COLUMN "APP"."APP_COPYRIGHT" IS '站点版权信息';
COMMENT ON COLUMN "APP"."APP_STYLE" IS '站点风格';
COMMENT ON COLUMN "APP"."APP_MANAGERID" IS '站点对于管理员编号';
COMMENT ON COLUMN "APP"."APP_DESCRIPTION" IS '描述';
COMMENT ON COLUMN "APP"."APP_DATETIME" IS '创建时间';
COMMENT ON COLUMN "APP"."APP_MOBILE_STYLE" IS '移动端风格';
COMMENT ON COLUMN "APP"."APP_PAY_DATE" IS '应用续费时间';
COMMENT ON COLUMN "APP"."APP_PAY" IS '费用清单';
COMMENT ON COLUMN "APP"."APP_STATE" IS '0运行中 1已停止  ';
COMMENT ON COLUMN "APP"."APP_MOBILE_STATE" IS '0启用 1停用';
COMMENT ON COLUMN "APP"."APP_LOGIN_PAGE" IS '自定义登录界面';
COMMENT ON TABLE "APP" IS '应用表';

-- ----------------------------
-- Records of "APP"
-- ----------------------------
INSERT INTO "APP" VALUES ('1', 'MCMS-OPEN', 'http://localhost:8080/ms-mcms
', NULL, NULL, NULL, 'mooc', '50', NULL, NULL, 'm', NULL, NULL, '0', '0', NULL);

-- ----------------------------
-- Table structure for BASIC
-- ----------------------------
DROP TABLE "BASIC";
CREATE TABLE "BASIC" (
  "BASIC_ID" NUMBER(11) NOT NULL ,
  "BASIC_TITLE" NVARCHAR2(300) ,
  "BASIC_DESCRIPTION" NCLOB ,
  "BASIC_THUMBNAILS" NVARCHAR2(1000) ,
  "BASIC_HIT" NUMBER(20) ,
  "BASIC_SORT" NUMBER(11) ,
  "BASIC_DATETIME" DATE ,
  "BASIC_UPDATETIME" DATE ,
  "BASIC_PEOPLEID" NUMBER(11) ,
  "BASIC_CATEGORYID" NUMBER(11) ,
  "BASIC_APPID" NUMBER(11) NOT NULL ,
  "BASIC_MODELID" NUMBER(11) ,
  "BASIC_COMMENT" NUMBER(11) ,
  "BASIC_COLLECT" NUMBER(11) ,
  "BASIC_SHARE" NUMBER(11) ,
  "BASIC_TYPE" NVARCHAR2(255),
  "BASIC_DISPLAY" NUMBER(1) DEFAULT 0  NOT NULL  
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BASIC"."BASIC_ID" IS '自增长id';
COMMENT ON COLUMN "BASIC"."BASIC_TITLE" IS '标题';
COMMENT ON COLUMN "BASIC"."BASIC_DESCRIPTION" IS '描述';
COMMENT ON COLUMN "BASIC"."BASIC_THUMBNAILS" IS '缩略图';
COMMENT ON COLUMN "BASIC"."BASIC_HIT" IS '点击次数';
COMMENT ON COLUMN "BASIC"."BASIC_SORT" IS '排序';
COMMENT ON COLUMN "BASIC"."BASIC_DATETIME" IS ' 发布时间';
COMMENT ON COLUMN "BASIC"."BASIC_UPDATETIME" IS '更新时间';
COMMENT ON COLUMN "BASIC"."BASIC_PEOPLEID" IS '用户编号';
COMMENT ON COLUMN "BASIC"."BASIC_CATEGORYID" IS '所属分类编号';
COMMENT ON COLUMN "BASIC"."BASIC_APPID" IS '应用编号';
COMMENT ON COLUMN "BASIC"."BASIC_MODELID" IS '模块编号';
COMMENT ON COLUMN "BASIC"."BASIC_COMMENT" IS '评论次数';
COMMENT ON COLUMN "BASIC"."BASIC_COLLECT" IS '收藏次数';
COMMENT ON COLUMN "BASIC"."BASIC_SHARE" IS '分享次数';
COMMENT ON COLUMN "BASIC"."BASIC_TYPE" IS '属性';
COMMENT ON COLUMN "BASIC"."BASIC_DISPLAY" IS '显示属性 0显示1不显示';
COMMENT ON TABLE "BASIC" IS '基础表';

-- ----------------------------
-- Records of "BASIC"
-- ----------------------------
INSERT INTO "BASIC" VALUES ('218', '孙建东', '锐诚PPT培训部总监', '/upload/article/1638/1464860506257.png', '0', '0', TO_DATE('2016-06-02 17:41:47', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 15:47:30', 'SYYYY-MM-DD HH24:MI:SS'), '0', '115', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('219', '梅幸', '锐诚PPT金牌设计师', '/upload/article/1638/1464860570155.png', '0', '0', TO_DATE('2016-06-02 17:42:27', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 15:47:27', 'SYYYY-MM-DD HH24:MI:SS'), '0', '115', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('24', '关于我们', '  公司于2012年3月8日，已正式向《景德镇市工商行政管理局》领取营业   执照。
  公司名称：景德镇铭飞科技有限公司
  经营范围：计算机系统服务及技术开发、咨询服务', NULL, '0', '0', TO_DATE('2015-09-18 16:31:18', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 11:07:36', 'SYYYY-MM-DD HH24:MI:SS'), '0', '19', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('32', '为远行的人', NULL, NULL, '0', '0', TO_DATE('2016-03-16 17:26:37', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-05-19 17:50:56', 'SYYYY-MM-DD HH24:MI:SS'), '0', '146', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('33', '一生学做人', NULL, NULL, '0', '0', TO_DATE('2016-03-16 17:27:31', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 11:35:20', 'SYYYY-MM-DD HH24:MI:SS'), '0', '146', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('34', '何处惹尘埃', NULL, NULL, '0', '0', TO_DATE('2016-03-16 17:29:06', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-05-19 17:50:31', 'SYYYY-MM-DD HH24:MI:SS'), '0', '146', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('35', '雨夜，晚归人', NULL, NULL, '0', '0', TO_DATE('2016-03-16 17:31:11', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-05-19 17:50:10', 'SYYYY-MM-DD HH24:MI:SS'), '0', '146', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('36', '网站建设', '网站设计 网站制作 网站维护 网站改版', '/upload/article/1638/1464868285592.png', '0', '0', TO_DATE('2016-03-16 17:41:27', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 19:51:27', 'SYYYY-MM-DD HH24:MI:SS'), '0', '53', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('37', '人才招聘', '企业内部的竞聘、晋升机制，为员工提供了公平竞争的机会。通过挖掘企业内部的人才，调动内部人员的潜力和积极性，促进了优秀人才脱颖而出，实现人力资源的合理配置，把"合适的人放在合适的地方"。', NULL, '0', '0', TO_DATE('2016-03-16 17:48:38', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-04 11:08:08', 'SYYYY-MM-DD HH24:MI:SS'), '0', '146', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('52', '响应式Web设计的9项基本原则', '响应式web设计对于解决多类型屏幕问题来说是个', '/upload/article/1/1458980355125.png', '0', '0', TO_DATE('2016-03-26 14:43:40', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:26', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('53', '导航设计模式的重要意义', 'Gmai 就 是单页应用的一个很好的例子，其将多项', '/upload/article/1/1458981328236.jpeg', '0', '0', TO_DATE('2016-03-26 14:49:14', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:32', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('54', '如何进行可用性启发式评估', '用 户体验只有在渗透入从创意到开发测试等产品', '/upload/article/1/1458981122379.png', '0', '0', TO_DATE('2016-03-26 15:47:29', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:59', 'SYYYY-MM-DD HH24:MI:SS'), '0', '67', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('55', '响应式Web设计的9项基本原则', '想象一下走进一个狭小拥挤，遍地垃圾的商店。店', '/upload/article/1/1458981072779.jpg', '0', '0', TO_DATE('2016-03-26 15:50:20', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:54', 'SYYYY-MM-DD HH24:MI:SS'), '0', '67', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('56', '原生App切图的那些事儿', '最小的分辨率是320x480，我们把这个尺寸定为基', '/upload/article/1/1458981027610.png', '1', '0', TO_DATE('2016-03-26 15:51:39', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:48', 'SYYYY-MM-DD HH24:MI:SS'), '0', '66', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('57', '11个小妙招激发你的灵感', '感到自己深陷千篇一律的设计泥潭无法自拔？ Sty', '/upload/article/1/1458980990018.jpeg', '1', '0', TO_DATE('2016-03-26 15:52:27', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:37', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('58', '5项提高产品设计的交互模式', '在这个简短的移动端设计模式系列文章的前几篇中', '/upload/article/1/1458980956132.jpeg', '1', '0', TO_DATE('2016-03-26 15:53:20', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:43', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('59', '在网页设计中运用柔和色调', '网页中的柔和色调的使用，不止是近来的趋势，这', '/upload/article/1/1458980935362.jpg', '1', '0', TO_DATE('2016-03-26 15:54:17', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:19', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('60', '细数那些精彩纷呈的引导页', '随着苹果ios8的发布，可以看到App store货架上', '/upload/article/1/1458980789639.png', '0', '0', TO_DATE('2016-03-26 16:07:08', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:00:09', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('61', '从摄影的角度看设计', '一幅好照片要把观众的注意力吸引到趣味中心mdas', '/upload/article/1/1458980625909.jpg', '1', '0', TO_DATE('2016-03-26 16:07:55', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 14:59:55', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('62', '国内java开源商城系统', 'MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。', '/upload/article/1/1458980449738.jpeg', '1', '0', TO_DATE('2016-03-26 16:08:53', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 14:59:46', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('63', '国内java开源 cms系统', 'MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。', '/upload/article/1/1458980395756.jpg', '1', '0', TO_DATE('2016-03-26 16:09:27', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 14:59:39', 'SYYYY-MM-DD HH24:MI:SS'), '0', '65', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('70', '2015年 铭飞MCms获得最热门开源项目第40位', '自 Git@OSC 上线以来受到广大开源作者的喜爱。值此新年之际，开源中国整理出 Git@OSC 最热门开源项目 Top50，对 Git@OSC 的发展至今所取得的成绩进行总结。此榜单主要通过开源项目的 Watch、Star、Fork 数量来评定', '/upload/article/1/1461384072200.jpeg', '1', '0', TO_DATE('2016-03-27 09:34:58', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 19:38:12', 'SYYYY-MM-DD HH24:MI:SS'), '0', '69', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('71', '国内java开源 cms系统', 'MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。', '/upload/article/1638/1464847653084.jpeg', '0', '0', TO_DATE('2016-03-27 09:36:45', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 19:48:52', 'SYYYY-MM-DD HH24:MI:SS'), '0', '68', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('72', '2016年CMS开源系统排行榜', 'CMS（Content Management System),中文叫作整站系统、文章系统。
大概2004以前，如果想进行网站内容管理,基本上都是靠手工维护,但千变万化的信息流，但没有好的程序支持，还继续靠手工完成是不可能的事。', '/upload/article/1/1461384142045.png', '0', '0', TO_DATE('2016-03-27 09:37:07', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 19:49:00', 'SYYYY-MM-DD HH24:MI:SS'), '0', '68', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('73', '国内java开源商城系统', 'MCMS(http://ms.mingsoft.net)是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。', '/upload/article/1/1461384035654.png', '2', '0', TO_DATE('2016-03-27 09:37:46', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 19:49:09', 'SYYYY-MM-DD HH24:MI:SS'), '0', '68', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('74', '国内java开源bbs系统', '当前版本:5.4.2 铭飞MS官网:http://ms.mingsoft.net官网同时提供一键运行版本下载，请步移官网....', '/upload/article/1/1461383961935.png', '1', '0', TO_DATE('2016-03-27 09:38:15', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 19:24:56', 'SYYYY-MM-DD HH24:MI:SS'), '0', '68', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('92', '建站资源共享学习平台', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。我们致力于打造一个优秀的建站资源共享学习平台！从零开始系统全面的教你如何建立一个属于自己的网站。能够自己搭建一个网站，并通过优化推广实现盈利。0基础由浅入深的带您走进的世界。掌握程序的操作和使用，能独立开发模板并能运用进行仿站。专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', NULL, '0', '0', TO_DATE('2016-03-28 16:39:44', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 10:07:19', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('93', '从零开始系统全面的教你如何建立一个属于自己的网站', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。我们致力于打造一个优秀的建站资源共享学习平台！从零开始系统全面的教你如何建立一个属于自己的网站。能够自己搭建一个网站，并通过优化推广实现盈利。0基础由浅入深的带您走进的世界。掌握程序的操作和使用，能独立开发模板并能运用进行仿站。专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', NULL, '0', '0', TO_DATE('2016-03-28 16:40:18', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 10:06:14', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('94', '0基础由浅入深的带您走进的世界', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。我们致力于打造一个优秀的建站资源共享学习平台！从零开始系统全面的教你如何建立一个属于自己的网站。能够自己搭建一个网站，并通过优化推广实现盈利。0基础由浅入深的带您走进的世界。掌握程序的操作和使用，能独立开发模板并能运用进行仿站。专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', NULL, '0', '0', TO_DATE('2016-03-28 16:41:12', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 10:06:32', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('95', '网站模板', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', NULL, '0', '0', TO_DATE('2016-03-28 16:54:59', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 10:07:56', 'SYYYY-MM-DD HH24:MI:SS'), '0', '84', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('96', '建站培训', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', NULL, '0', '0', TO_DATE('2016-03-28 16:55:22', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 10:07:51', 'SYYYY-MM-DD HH24:MI:SS'), '0', '84', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('97', '模板', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', NULL, '0', '0', TO_DATE('2016-03-28 16:55:43', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 10:07:46', 'SYYYY-MM-DD HH24:MI:SS'), '0', '84', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('98', '视频课程', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。', NULL, '0', '0', TO_DATE('2016-03-28 16:56:27', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 10:07:40', 'SYYYY-MM-DD HH24:MI:SS'), '0', '84', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('112', '新科科技', '在网上寻觅了很久很久。终于找到了这里。晃眼一看，好多漂亮的模板。下载了几个都很好用。希望越做越好，多提供些精品资源！找了好久啊，一直想有一个这样的网站，找来找去，老感觉么有合适的。偶然间来到这儿，爽。找到啦！对于网站建设新手来说，是一个最好的平台，你可以随心找到你最喜欢的网站模板，做出你喜欢的网站。
专业提供网站模板，网页模板，模板教程，网页制作，程序插件，网站素材等建站资源，我们致为于打造优秀的建站资源共享平台！ ', '/upload/article/1/1459305011132.png', '0', '0', TO_DATE('2016-03-30 10:28:39', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:19:51', 'SYYYY-MM-DD HH24:MI:SS'), '0', '87', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('113', '联娱公司', '找模板找了很久了，于是找到了，觉的这里的模板很不错，下载了两套试试，果然可以用。于是充值了，希望站长以后多多指点啊！站长很友好，为我们这些新手站长提供这么多的模版。大家一起交流，才能成长得更快吧！感谢，感谢网友，你们辛苦了！对于网站建设新手来说，是一个最好的平台，你可以随心找到你最喜欢的网站模板，做出你喜欢的网站。专业提供网站模板，网页模板，模板教程，网页制作，程序插件，网站素材等建站资源，我们致为于打造优秀的建站资源共享平台！ ', '/upload/article/1/1459305021450.png', '0', '0', TO_DATE('2016-03-30 10:29:13', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:19:14', 'SYYYY-MM-DD HH24:MI:SS'), '0', '87', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('130', '关于我们', '广州城市规划设计有限公司是中欧国际旅游规划设计研究院（Sino-Europe Academy of Tourism Planning and Design）旗下之专业机构，公司专注于城市规...', '/upload/article/1/1460376794567.jpg', '0', '0', TO_DATE('2016-04-11 20:02:32', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 11:27:17', 'SYYYY-MM-DD HH24:MI:SS'), '0', '93', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('131', '主营业务', '互联网时代正在颠覆旅游业传统的商业模式。CEDAR积极应对这种变革，依托中欧国际旅游规划设计研究院（SEATPD）的资源优势，推动文化、地产与旅游业的横向联合发展，以此延伸到移动互联、绿色农业、金融资本、现代物流业等产业领域。', '/upload/article/1638/1464838231122.jpg', '0', '5', TO_DATE('2016-04-11 20:20:42', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 14:29:55', 'SYYYY-MM-DD HH24:MI:SS'), '0', '94', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('132', '合作伙伴', '让设计充满新奇和创造力，同时也饱含着和谐、力量与深意。
"适度" 是一种幸福的生活态度。
设计哲学 "合适的设计"，设计中最难的环节往往并非创新，而是在精确适配下的创造。
打造令人灵感迸发及纵情享受的情绪空间。
', '/upload/article/1638/1464838215050.jpg', '0', '0', TO_DATE('2016-04-11 20:21:45', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:38:19', 'SYYYY-MM-DD HH24:MI:SS'), '0', '95', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('133', '合作伙伴', '某某，中国知名室内设计师，2005年于北京创立筑邦臣设计公司，他擅长用东方哲学思考解决问题，关注各类空间形态对人的影响，同时注重设计的商业化表现。张海涛说：“希望在设计中融入丰富的文化表达，以打造可以令人思考的空间意境。”他一直坚信，中国拥有丰富的文化底蕴，在未来“中国设计”将充满无限可能！', '/upload/article/1569/1461506188829.jpg', '0', '0', TO_DATE('2016-04-11 20:23:48', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:59:19', 'SYYYY-MM-DD HH24:MI:SS'), '0', '97', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('134', '亚太旅游规划设计十大影响力品牌', '2009年12月13日由中国民族建筑研究会与中国 房地产 及住宅研究会共同主办，2009第六届中国人居典范建筑规划设计方案竞赛颁奖大会在北京京都信苑饭店隆重召开。经过九个多月来的精...', '/upload/article/1/1460377619458.jpg', '0', '0', TO_DATE('2016-04-11 20:27:43', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-04-12 19:56:40', 'SYYYY-MM-DD HH24:MI:SS'), '0', '96', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('135', '2009中国人居典范●最佳设计方案', '2009年12月13日由中国民族建筑研究会与中国 房地产 及住宅研究会共同主办，2009第六届中国人居典范建筑规划...', '/upload/article/1/1460377712056.png', '0', '0', TO_DATE('2016-04-11 20:28:48', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 14:16:45', 'SYYYY-MM-DD HH24:MI:SS'), '0', '96', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('136', '定制化项目金融孵化模式', '广州规划设计以金融资本为支撑，以规划设计为撬动点，协助旅游业开发高潜力项目，推动项目融资..', '/upload/article/1585/1462265098563.jpg', '0', '0', TO_DATE('2016-04-11 20:30:32', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-05-03 16:45:00', 'SYYYY-MM-DD HH24:MI:SS'), '0', '98', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('137', '幻灯一', NULL, '/upload/article/1638/1465808003859.jpg', '0', '0', TO_DATE('2016-04-11 20:59:07', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-13 16:53:24', 'SYYYY-MM-DD HH24:MI:SS'), '0', '147', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('138', '幻灯二', NULL, '/upload/article/1638/1465808020382.jpg', '0', '0', TO_DATE('2016-04-11 20:59:25', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-13 16:53:40', 'SYYYY-MM-DD HH24:MI:SS'), '0', '147', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('139', '幻灯三', NULL, '/upload/article/1638/1465808030831.jpg', '0', '0', TO_DATE('2016-04-11 21:00:16', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-13 16:53:51', 'SYYYY-MM-DD HH24:MI:SS'), '0', '147', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('140', '幻灯四', NULL, '/upload/article/1638/1464858626484.jpg', '0', '0', TO_DATE('2016-04-11 21:00:35', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:25:01', 'SYYYY-MM-DD HH24:MI:SS'), '0', '147', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('141', '城市规划', '城市商业综合体规划 -新城（新区）规划 -温城市更新与旧城改造 -小城镇建设规划 -历史文化名城/镇保护研究与规划 -产业园区规划...', '/upload/article/1/1460380106006.jpg', '0', '0', TO_DATE('2016-04-11 21:09:07', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 15:32:34', 'SYYYY-MM-DD HH24:MI:SS'), '0', '101', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('142', '环境艺术设计', 'CEDAR以美学与生态的双重视野开展环境艺术的探索与实践，营造健康、高雅、舒适、美观的现代生态环境，以此提升城市及旅游景区的软环境。...', '/upload/article/1/1460380199624.jpg', '0', '0', TO_DATE('2016-04-11 21:10:38', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:57:25', 'SYYYY-MM-DD HH24:MI:SS'), '0', '102', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('143', '旅游形象策划', '在把握好旅游地的地脉（地理根据）、文脉（文化根据）和商脉（市场根据）的基础上，为旅游地做好旅游形象定位，并开展理念基础（MI）、行为准则（BI）、视觉形象（VI）的系统策...', '/upload/article/1/1460380287863.jpg', '0', '0', TO_DATE('2016-04-11 21:11:33', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:57:30', 'SYYYY-MM-DD HH24:MI:SS'), '0', '103', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('144', '旅游企业管理', '目的地与景区管理： -发展战略规划 -营销管理体系咨询 -品牌管理体系咨询 -组织架构与流程再造 -投资运营与管理 -资源与环境保护 酒店管理： -酒店运营管理 -酒店物业管理 -酒店产品...', '/upload/article/1/1460380343199.jpg', '0', '0', TO_DATE('2016-04-11 21:12:42', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:57:33', 'SYYYY-MM-DD HH24:MI:SS'), '0', '104', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('146', '广东梅州市雁洋旅游服务区域城市规划', '项目地址：广东梅州市雁洋镇
规划面积：1，281，863平方米
项目委托：广东梅州市人民政府', '/upload/article/1/1460380700438.png', '0', '0', TO_DATE('2016-04-11 21:18:54', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:06:21', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('147', '海口湾酒店公寓第二期建筑设计', '项目地址：海南省海口市北部海口湾西部滨海地区
总用地面积：47957.1平方米
总建筑面积：116154.65平方米
总地上建筑面积：94523.55平方米', '/upload/article/1/1460380774867.png', '0', '0', TO_DATE('2016-04-11 21:20:05', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:15:07', 'SYYYY-MM-DD HH24:MI:SS'), '0', '108', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('148', '昆山水月周庄旅游地产概念营销策划', '周庄拥有丰富的自然资源、人文资源及极具优势的地理位置，区域发展潜力巨大，古镇旅游品牌价值大，区域发展热点已经形成，旅游经济的发展为房地产市场提供了巨大的想象空间。', '/upload/article/1/1460380829450.jpg', '0', '0', TO_DATE('2016-04-11 21:21:01', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:06:16', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('149', '京杭大运河旅游形象研究与策划', '项目地址：浙江杭州、苏州
项目委托：杭州市旅游局、苏州市旅游局
 
运河文化，吴地风情', '/upload/article/1/1460380900751.png', '0', '0', TO_DATE('2016-04-11 21:22:08', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:14:43', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('150', '佛山某师军史馆设计', NULL, '/upload/article/1/1460380995728.jpg', '0', '0', TO_DATE('2016-04-11 21:23:19', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:14:45', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('157', '旅游规划', '- 区域旅游发展规划
- 历史文化区旅游开发规划
- 风景名胜区旅游开发规划', '/upload/article/1/1460384875034.jpg', '0', '0', TO_DATE('2016-04-11 22:28:02', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:06:02', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('158', '旅游规划', '区域旅游发展规划 -历史文化区旅游开发规划 -风景名胜区旅游开发规划 -生态旅游区开发规划 -温泉滨海度假区旅游开发规划 -旅游地产开发规划 -乡村旅游开发', '/upload/article/1/1460385002423.jpg', '0', '0', TO_DATE('2016-04-11 22:30:21', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:58:24', 'SYYYY-MM-DD HH24:MI:SS'), '0', '101', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('163', '得品牌者得市场', '精益求精的网页制作人员、严谨的应用程序开发人员、尽善尽美的售后服务人员。这一切，是我们为您提供专业网站建设服务，也是让你在同行业中傲视群 雄', '/upload/article/1638/1464746921150.jpg', '0', '0', TO_DATE('2016-04-15 15:29:42', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 20:16:45', 'SYYYY-MM-DD HH24:MI:SS'), '0', '99', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('164', '海派卓越规划设计智业团队', '广州规划设计麾下聚集了众多从美国旧金山艺术大学、奥本大学、香港理工大学毕业的海派旅游规', '/upload/article/1585/1462265091247.jpg', '0', '0', TO_DATE('2016-04-15 15:39:48', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-05-03 16:44:52', 'SYYYY-MM-DD HH24:MI:SS'), '0', '98', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('165', '高质量行业交互平台', '广州规划设计创新构建协同式、交互式、大数据及系统式行业服务平台。。。', '/upload/article/1585/1462265083093.jpg', '0', '0', TO_DATE('2016-04-15 15:40:42', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:59:22', 'SYYYY-MM-DD HH24:MI:SS'), '0', '98', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('166', '01品牌创建', '品牌命名/品牌文化/品牌识别设计
最初的品牌播种，决定了品牌是要长成野草还是参天大树。所谓三岁看大，品牌风格确立也要从萌芽开始，让品牌自始至终保持活力与竞争力，健康茁长的成长。
服务项目：
品牌文化理念挖掘 / 挖掘一种品牌文化，并力求这种文化与更多目标消费群相关品牌命名 /
创造符合品牌精神的独特名称 / 品牌视觉识别（VIS）设计 /
基于市场与设计角度创造严谨而实用的形象设计 /', '/upload/article/1/1460771365547.jpg', '0', '0', TO_DATE('2016-04-16 09:49:44', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-04-29 17:23:22', 'SYYYY-MM-DD HH24:MI:SS'), '0', '62', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('167', '品牌改造设计', '品牌形象的改造与提升设计
品牌发展到一定的阶段，因为企业发展模式及战略目标发生改变，其原有的形象已经不能承载企业未来发展的战略需求时，则需要创造更具生长气质的视觉形象，为未来打算，为未来改变！品牌改造设计正好填补着类客户的发展需求。
服务项目：
品牌形象改造设计 / 令形象更适合品牌定位，提升 / 完善品牌形象
完善并继承优秀基因,为企业注入新鲜的视觉活力
与客户品牌发展模式及战略目标相匹配', '/upload/article/1/1460771447978.jpg', '0', '0', TO_DATE('2016-04-16 09:51:22', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 19:12:58', 'SYYYY-MM-DD HH24:MI:SS'), '0', '138', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('168', '品牌推广设计', '形象画册 / 产品样本 / 招商手册 / 企业年报
印刷品是企业最常用最有效的推广方式，也是挖掘潜在客户的钥匙。好的设计能循序渐进的引导读者，让读者更清楚的了解产品，从而择需购买。一本设计粗糙的画册，不等被翻开便会被丢弃。
服务项目：
印刷品设计 / 具有企业特色的形象画册设计、产品目录及年报设计.
企业内刊策划设计 / 为大型企业策划设计品牌内部刊物', '/upload/article/1/1460771488365.jpg', '0', '0', TO_DATE('2016-04-16 09:52:35', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:18:14', 'SYYYY-MM-DD HH24:MI:SS'), '0', '138', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('172', '网络优化', '企业网站建设目的何在？如何充分挖掘互联网络的资源和优势，如何合理地组织网站内容与功能从而达到客户的需求？
我们将根据市场分析、客户产品及服务的优势、竞争对手分析等等，有效的确立网站定位。根据相关需求分析获得相应网站运营策略，在网站建立之初我们就网站VI形象、网站营销手段、运营模式、网站发展前景等等进行定位。', '/upload/article/1/1460889312736.jpg', '0', '0', TO_DATE('2016-04-17 18:37:32', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-04 09:16:24', 'SYYYY-MM-DD HH24:MI:SS'), '0', '133', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('173', '网络营销', '互联网品牌推广有个新鲜名词叫数字营销，数字营销是新发展起来的一种营销模式，是利用互联网特性和技术，更加有效、高性价比地完成整合营销计划，达到传统 的IMC不能达到的高效客户关系管理等，从而精准地实施营销策略，实现企业营销的高效率、低成本、大影响。可以按两种意思来理解：网络整合营销是利用网络 技术和网络特性最大化、最快速、最有效、最精准的进行整合营销；网络整合营销是以为客户提供有价值的信息为基础，由客户创造、传播为主导的整合营销理念进 行的网络营销。', '/upload/article/1/1460889475526.jpg', '0', '0', TO_DATE('2016-04-17 18:38:12', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:15:23', 'SYYYY-MM-DD HH24:MI:SS'), '0', '134', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('174', '域名注册', '上网"已成为不少人的口头禅。但是，要想在网上建立服务器发布信息，则必须首先注册自己的域名，只有有了自己的域名才能让别人访问到自己。所以，域名注册是在互联网上建立任何服务的基础。同时，由于域名的唯一性，尽早注册又是十分必要的。', '/upload/article/1638/1464868329275.png', '0', '0', TO_DATE('2016-04-17 18:39:43', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-04 09:16:08', 'SYYYY-MM-DD HH24:MI:SS'), '0', '135', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('177', '国内开源 java cms，铭飞MCms', 'MCMS是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。

MS平台开发团队承诺MCMS内容管理系统永久完整开源免费(这真是极', '/upload/article/1/1461384090357.jpeg', '1', '0', TO_DATE('2016-04-23 11:51:21', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 19:39:13', 'SYYYY-MM-DD HH24:MI:SS'), '0', '70', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('178', '价值源自分享', 'MStore（铭飞商城）是铭飞（MS）平台为开发者提供模版与插件作品分享平台,为企业提供优质产品和服务我们致力于打造一个优秀的Java资源共享学习平台。', '/upload/article/1/1461383921888.jpeg', '1', '0', TO_DATE('2016-04-23 11:52:35', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 19:22:20', 'SYYYY-MM-DD HH24:MI:SS'), '0', '68', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('179', '铭飞商城MStore——价值源自分享', 'MStore（铭飞商城）是铭飞（MS）平台为开发者提供模版与插件作品分享平台,为企业提供优质产品和服务我们致力于打造一个优秀的Java资源共享学习平台。
', '/upload/article/1/1461383937683.jpeg', '1', '0', TO_DATE('2016-04-23 11:58:24', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 19:20:23', 'SYYYY-MM-DD HH24:MI:SS'), '0', '68', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('182', '人才理念', '网络营销是以互联网络为基础，通过数字化的信息和网络媒体的交互性来辅助营销目标实现的一种新型的市场营销方式。', '/upload/article/1584/1462521245856.jpg', '0', '0', TO_DATE('2016-04-29 14:49:03', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 11:17:43', 'SYYYY-MM-DD HH24:MI:SS'), '0', '52', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('183', '联系我们', '这里是一个充满活力和梦想的企业，我们不反对个性，我们不安于现状，我们亲手创造价值，我们永远在进步……如果你也是名有梦想勇于尝试的人，那就赶快加入我们吧！

我们面向全国招募有志之士，欢迎自荐或向周围的好友推荐。', NULL, '0', '0', TO_DATE('2016-04-29 14:49:25', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 11:17:55', 'SYYYY-MM-DD HH24:MI:SS'), '0', '136', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('185', '联系我们', '这里是一个充满活力和梦想的企业，我们不反对个性，我们不安于现状，我们亲手创造价值，我们永远在进步……如果你也是名有梦想勇于尝试的人，那就赶快加入我们吧！

我们面向全国招募有志之士，欢迎自荐或向周围的好友推荐。', '/upload/article/1638/1465720290023.jpg', '0', '4', TO_DATE('2016-05-04 14:49:32', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-12 16:31:31', 'SYYYY-MM-DD HH24:MI:SS'), '0', '141', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('190', '在线留言', NULL, NULL, '0', '0', TO_DATE('2016-06-02 11:17:01', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 11:17:01', 'SYYYY-MM-DD HH24:MI:SS'), '0', '142', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('191', '“绿色装饰”融入杭州市民中心装饰工程', '此外项目部还非常注重采取新工艺、新方法，不仅提高了工程的整体美观性和实用性，而且加快了施工进度，提升了工作效率。由于本工程是圆型结构的楼层施 工，特别是石材在圆弧和圆柱造型上用量大，大大增加了工程的施工难度。', '/upload/article/1638/1464861354733.jpg', '0', '0', TO_DATE('2016-06-02 14:52:40', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:55:55', 'SYYYY-MM-DD HH24:MI:SS'), '0', '84', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('192', '纽约时髦客手中那些让人尖叫的包', '对于时尚达人而言，包袋与衣服的混搭也是一种必杀技。休闲手提包可以搭配不同的造型，而搭配运动裤就是更加直接地表现出时尚休闲风的最佳配搭方案。', '/upload/article/1638/1464861380560.png', '0', '0', TO_DATE('2016-06-02 14:53:33', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-04 09:55:27', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('193', '宋朝华率队赴贵州招商洽谈推进重大项目', '市委副书记、市长宋朝华率队前往贵州省贵阳市，实地考察由中铁贵旅公司投资开发建设的中铁国际生态城项目，并与公司高层进行了深入友好座谈，洽谈推进重大项目落户我市仁寿县相关事宜。
 ', '/upload/article/1638/1464861385314.jpg', '0', '0', TO_DATE('2016-06-02 14:53:59', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:56:25', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('194', '红木市场是否低迷 消费者仍在', '内庭中央还展示着一辆豪华轿车，而周边则摆满红木家具，完全没有红木家具应该有的意境。更令人瞠目结舌的是，里面人流熙熙攘攘', '/upload/article/1638/1464861401214.jpg', '0', '0', TO_DATE('2016-06-02 14:54:54', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:56:42', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('195', '众多国宝级古典家具悉数亮相', '海南黄花梨圆包脚罗汉床、小叶紫檀云龙纹镶理石圆桌、富贵满堂多宝阁……昨日（12月13日）上午，第三届中国（江门）传统家具精品鉴赏会暨2014中国（江门）红木家具....', '/upload/article/1638/1464861408016.jpg', '0', '0', TO_DATE('2016-06-02 14:55:33', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-04 09:55:30', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('196', '戴为红木燃情成都，开启幸福之门', '近期，出于对中国传统文化的热爱，以及对红木艺术的执着、深情和追求，戴为红木携带“幸福之家”主题活动礼遇成都，使其鸿儒红木家居艺术馆隆重开业，为已进入寒冬的成都燃起了一把火，掀起了中式红木家具热潮！', '/upload/article/1638/1464861413861.jpg', '0', '0', TO_DATE('2016-06-02 14:56:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:56:54', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('197', '质检整治电商售假 红木家具市场良莠不齐', '质检总局执法督查司按照网上发现、源头追溯、落地查处的要求，组织开展电子商务产品专项执法打假活动，积极构建适应电子商务执法打假的全国执法协查工作机制...', '/upload/article/1638/1464861373394.png', '0', '0', TO_DATE('2016-06-02 14:56:35', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:56:16', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('198', '东西方两大甜妞聚首巴黎时装周头排', '巴黎时装周许晴倾力助阵，当天许晴身着黑色拼接装头排看秀，大秀美腿，加上干净利落的妆容，整体造型简洁率性，绿色的刺绣手包更添俏皮..', '/upload/article/1638/1464861364631.jpg', '0', '0', TO_DATE('2016-06-02 14:57:07', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:56:05', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('199', '宋朝华率队赴贵州招商洽谈推进重大项目', '市委副书记、市长宋朝华率队前往贵州省贵阳市，实地考察由中铁贵旅公司投资开发建设的中铁国际生态城项目，并与公司高层进行了深入友好座谈，洽谈推进重大项目落户我市仁寿县相关事宜。', '/upload/article/1638/1464861360036.png', '0', '0', TO_DATE('2016-06-02 14:57:40', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:56:01', 'SYYYY-MM-DD HH24:MI:SS'), '0', '83', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('200', '奔驰斯宾特A3 豪华版', '斯宾特系列(Sprinter)系列技术领先，动力强劲。座位数从10座到20座均可选择，跟据配置不同,价格也从95.8万178万可以选择。为您带来不同的商务体验。下面为.', '/upload/article/1638/1464851333470.jpg', '0', '0', TO_DATE('2016-06-02 15:09:12', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:14:48', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('201', '福特E350 游艇版', '其实商务车在人们眼里就是普通的客车，没有人会花时间去研究它，欣赏它。商务车给人的印象，就是整体的一箱车，发动机不是在驾驶与副驾驶的座椅下...', '/upload/article/1638/1464851477741.jpg', '0', '0', TO_DATE('2016-06-02 15:09:42', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:11:18', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('202', 'GMC3500 平顶舒适版', '对于这样一款外观霸气，承载性高的原装进口商务车和它实在的销售价格，都让这款车的性价比大大提升了不少。对于市场上一些追求个性的客户群来讲，...', '/upload/article/1638/1464851473102.jpg', '0', '0', TO_DATE('2016-06-02 15:10:17', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 15:11:14', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('203', '宾特奔驰斯A系列', '奔驰斯宾特系列礼宾车在豪华商务车系中，一向是高端、舒适的代名词。在秉承了奔驰的贵族气质的同时，其全新定制的奢华内饰让人感觉犹如进入了高档..', '/upload/article/1638/1465808166467.png', '0', '0', TO_DATE('2016-06-02 15:11:08', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-13 16:56:07', 'SYYYY-MM-DD HH24:MI:SS'), '0', '107', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('204', '1', NULL, '/upload/article/1638/1464859580381.jpg', '0', '0', TO_DATE('2016-06-02 17:26:21', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:26:21', 'SYYYY-MM-DD HH24:MI:SS'), '0', '148', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('205', '2', NULL, '/upload/article/1638/1464859585818.jpg', '0', '0', TO_DATE('2016-06-02 17:26:26', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:26:26', 'SYYYY-MM-DD HH24:MI:SS'), '0', '148', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('206', '3', NULL, '/upload/article/1638/1464859590366.jpg', '0', '0', TO_DATE('2016-06-02 17:26:31', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:26:31', 'SYYYY-MM-DD HH24:MI:SS'), '0', '148', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('207', '4', NULL, '/upload/article/1638/1464859595151.jpg', '0', '0', TO_DATE('2016-06-02 17:26:36', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:26:36', 'SYYYY-MM-DD HH24:MI:SS'), '0', '148', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('208', '5', NULL, '/upload/article/1638/1464859599849.jpg', '0', '0', TO_DATE('2016-06-02 17:26:40', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-02 17:26:40', 'SYYYY-MM-DD HH24:MI:SS'), '0', '148', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('209', '6', '高品质景观缔造者
High quality landscape architects.', '/upload/article/1638/1464859604208.jpg', '0', '0', TO_DATE('2016-06-02 17:26:45', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-16 14:24:51', 'SYYYY-MM-DD HH24:MI:SS'), '0', '148', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('210', '幻灯五', '做精品设计、建优良工程、打造精品工程
Boutique design, construction engineering, excellent build quality engineering.', '/upload/article/1638/1464859633594.jpg', '0', '0', TO_DATE('2016-06-02 17:26:55', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-16 14:24:18', 'SYYYY-MM-DD HH24:MI:SS'), '0', '147', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('211', '幻灯六', '与您一起携手，共同谱写园林绿化事业的新篇章！
Work with you to jointly write a new chapter landscaping business!', '/upload/article/1638/1464859625584.jpg', '0', '0', TO_DATE('2016-06-02 17:27:06', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-16 14:23:03', 'SYYYY-MM-DD HH24:MI:SS'), '0', '147', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('212', '愿景', '我们拥有稳定的充满创作激情的设计团队，核心人员由公司创立至今伴随我们一个又一个客户的成长，保证了稳定的设计出品质量及熟知我们所合作过的每一个客户的设计需求，现在，团队不断壮大。', '/upload/article/1638/1464940624025.png', '0', '0', TO_DATE('2016-06-02 17:36:54', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 20:52:58', 'SYYYY-MM-DD HH24:MI:SS'), '0', '95', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('213', '价值观', '我们已为数百家企业、政府和社会团体完成品牌的传播与设计，积累了大量丰富的经验，可为您提供大量同类企业和机构的案例进行比较参考。', '/upload/article/1638/1464940619456.jpg', '0', '0', TO_DATE('2016-06-02 17:37:08', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 20:52:55', 'SYYYY-MM-DD HH24:MI:SS'), '0', '95', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('214', '经营理念', '可提供一站式全面服务：品牌的定位——企业文化梳理——企业/品牌形象设计——品牌传播——环境空间设计——宣传物品的落地', '/upload/article/1638/1464940614692.jpg', '0', '0', TO_DATE('2016-06-02 17:37:19', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 20:52:46', 'SYYYY-MM-DD HH24:MI:SS'), '0', '95', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('215', '管理理念', '多年来，我们始终专注于品牌的设计与塑造，坚持站在市场的角度，为客户创作出准确的、极具商业价值的形象设计与品牌传播策略。', '/upload/article/1638/1464940610305.jpg', '0', '0', TO_DATE('2016-06-02 17:37:42', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-12 17:54:59', 'SYYYY-MM-DD HH24:MI:SS'), '0', '95', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('216', '李镇江', '资深PPT设计师', '/upload/article/1638/1464860436576.png', '0', '0', TO_DATE('2016-06-02 17:40:31', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 15:47:36', 'SYYYY-MM-DD HH24:MI:SS'), '0', '115', '1', N'8', NULL, NULL, NULL, NULL, 0);
INSERT INTO "BASIC" VALUES ('217', '曹瑛', '锐诚PPT特邀首席技术专家', '/upload/article/1638/1464860564066.png', '0', '0', TO_DATE('2016-06-02 17:41:15', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-03 15:47:33', 'SYYYY-MM-DD HH24:MI:SS'), '0', '115', '1', N'8', NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for BASIC_ATTENTION
-- ----------------------------
DROP TABLE "BASIC_ATTENTION";
CREATE TABLE "BASIC_ATTENTION" (
  "BA_ID" NUMBER(11) NOT NULL ,
  "BA_PEOPLE_ID" NUMBER(11) ,
  "BA_APP_ID" NUMBER(11) ,
  "BA_BASIC_ID" NUMBER(11) ,
  "BA_TYPE" NUMBER(11) ,
  "BA_DATETIME" DATE ,
  "BA_URL" NVARCHAR2(200) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BASIC_ATTENTION"."BA_ID" IS '自增长id';
COMMENT ON COLUMN "BASIC_ATTENTION"."BA_PEOPLE_ID" IS '用户id';
COMMENT ON COLUMN "BASIC_ATTENTION"."BA_APP_ID" IS '用户应用id';
COMMENT ON COLUMN "BASIC_ATTENTION"."BA_BASIC_ID" IS '用户收藏关联的基础id';
COMMENT ON COLUMN "BASIC_ATTENTION"."BA_TYPE" IS '收藏类型 1： 收藏  2：顶';
COMMENT ON COLUMN "BASIC_ATTENTION"."BA_DATETIME" IS '用户收藏文章，帖子或商品时的时间';
COMMENT ON COLUMN "BASIC_ATTENTION"."BA_URL" IS '收藏的文章,帖子，商品的链接地址';
COMMENT ON TABLE "BASIC_ATTENTION" IS '用户收藏表';

-- ----------------------------
-- Table structure for BASIC_COLUMN
-- ----------------------------
DROP TABLE "BASIC_COLUMN";
CREATE TABLE "BASIC_COLUMN" (
  "COLUMN_CATEGORY_ID" NUMBER(11) NOT NULL ,
  "COLUMN_KEYWORD" NVARCHAR2(300) ,
  "COLUMN_DESCRIP" NVARCHAR2(500) ,
  "COLUMN_TYPE" NUMBER(11) ,
  "COLUMN_URL" NVARCHAR2(50) ,
  "COLUMN_LISTURL" NVARCHAR2(50) ,
  "COLUMN_PATH" NVARCHAR2(150) ,
  "COLUMN_CM_ID" NUMBER(11) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BASIC_COLUMN"."COLUMN_CATEGORY_ID" IS '关联category表（类别表ID）';
COMMENT ON COLUMN "BASIC_COLUMN"."COLUMN_KEYWORD" IS '栏目简介';
COMMENT ON COLUMN "BASIC_COLUMN"."COLUMN_DESCRIP" IS '栏目关键字的扩展';
COMMENT ON COLUMN "BASIC_COLUMN"."COLUMN_TYPE" IS '1,代表最终列表栏目。2，代表频道封面。3，带表外部链接';
COMMENT ON COLUMN "BASIC_COLUMN"."COLUMN_URL" IS '如果是外部链接，则保持外部链接地址。如果为最终列表栏目，就保存文章显示列表';
COMMENT ON COLUMN "BASIC_COLUMN"."COLUMN_LISTURL" IS '最终列表栏目的列表模板地址';
COMMENT ON COLUMN "BASIC_COLUMN"."COLUMN_PATH" IS '栏目路径';
COMMENT ON COLUMN "BASIC_COLUMN"."COLUMN_CM_ID" IS '栏目管理的内容模型id';
COMMENT ON TABLE "BASIC_COLUMN" IS '栏目表';

-- ----------------------------
-- Records of "BASIC_COLUMN"
-- ----------------------------
INSERT INTO "BASIC_COLUMN" VALUES ('19', NULL, NULL, '2', 'contact.htm', 'contact.htm', '/19', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('23', NULL, NULL, '1', 'about.htm', 'liebiao.htm', '/23', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('33', NULL, NULL, '1', 'detail.htm', 'list.htm', '/33', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('52', NULL, NULL, '2', 'about.htm', 'about.htm', '/52', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('53', NULL, NULL, '2', 'about.htm', 'about.htm', '/53', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('59', NULL, '您可以通过以下新闻与公司动态进一步了解我们。我们所签约的客户，无论他们的项目是大或者是小，我们都将提供100%的服务', '1', 'news-show.htm', 'news-list.htm', '/59', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('61', NULL, '新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', '1', 'case-show.htm', 'case-list.htm', '/61', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('62', NULL, '您可以通过以下新闻与公司动态进一步了解我们。我们所签约的客户，无论他们的项目是大或者是小，我们都将提供100%的服务', '1', 'news-show.htm', 'news-list.htm', '/62', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('63', '建站资源共享学习平台!', '我们为您提供网站策划、网页设计、程序开发、网站推广、域名注册、虚拟主机、企业邮箱等网站建设相关服务；为您提供iOS/Android/Windows Phone等移动平台的APP应用开发；为您提供办公系统、客户关系管理系统、电子政务系统等行业应用系统的开发；为您提供软件定制开发和系统集成服务。', '2', 'service.htm', 'service.htm', '/63', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('65', '精选案例展示', '新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', '1', 'case-show.htm', 'case-list.htm', '/61/65', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('66', '精选案例展示', '新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', '1', 'case-show.htm', 'case-list.htm', '/61/66', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('67', '精选案例展示', '新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', '1', 'case-show.htm', 'case-list.htm', '/61/67', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('68', NULL, '您可以通过以下新闻与公司动态进一步了解我们。我们所签约的客户，无论他们的项目是大或者是小，我们都将提供100%的服务', '1', 'news-show.htm', 'news-list.htm', '/59/68', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('69', NULL, NULL, '1', 'news-show.htm', 'news-list.htm', '/59/69', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('70', NULL, '新闻中心', '1', 'news-list.htm', 'news-show.htm', '/59/70', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('83', NULL, '您可以通过以下新闻与公司动态进一步了解我们。我们所签约的客户，无论他们的项目是大或者是小，我们都将提供100%的服务', '1', 'news-show.htm', 'news-list.htm', '/62/83', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('84', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。我们致力于打造一个优秀的建站资源共享学习平台！', '专业提供网站模板，网页模板，教程培训，程序插件，网站素材等建站资源。设计者：如果您是模板设计师，插件制作者。我们致力于打造一个优秀的建站资源共享学习平台！您可以在这里放心出售您的模板和插件，我们提供版权保护。购买者：购买本站资源，我们提供“三重保障”(担保交易+人工介入+售后服务)，保障购买者的合法权益。织梦猫已经上路，我们将为此不懈努', '1', 'news-show.htm', 'news-list.htm', '/62/84', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('87', NULL, NULL, '2', 'solution.htm', 'about.htm', '/87', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('93', '关于我们', '关于我们', '2', 'about.htm', 'about.htm', '/93', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('94', '关于我们', '关于我们', '2', 'about.htm', 'about.htm', '/93/94', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('95', '关于我们', '关于我们', '2', 'about.htm', 'about-list.htm', '/93/95', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('96', NULL, NULL, '2', 'about.htm', 'news-list.htm', '/93/96', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('97', NULL, NULL, '2', 'about.htm', 'about.htm', '/93/97', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('98', '关于我们', '生态农庄', '2', 'about.htm', 'about.htm', '/93/98', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('99', NULL, NULL, '2', 'service.htm', 'product.htm', '/99', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('100', NULL, NULL, '1', 'about.htm', 'about.htm', '/100', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('101', '专业服务', '品牌策划年度服务是岳派品牌机构的主要服务方式之一，以一年或更长时间作为服务周期，为企业进行有计划、有步骤的策划、设计、执行等，进行一体化品牌策划推广服务。', '2', 'servise.htm', 'about-list.htm', '/99/101', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('102', '专业服务', 'LOGO 标志设计 VIS设计 宣传物料设计视觉是人们接受外部信息的最重要和最主要的通道。设计科学、实施有利的视觉识别，是传播企业经营理念、建立企业知名度、塑造企业形象的快速便捷之途', '2', 'servise.htm', 'about-list.htm', '/99/102', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('103', '专业服务', '竞争的优势不仅在于产品，也源于产品包装的设计，一个产品的包装直接影响顾客购买心理，产品的包装是最直接的广告 ,由表及里是自然界认识事物不变的定律。', '2', 'servise.htm', 'news-list.htm', '/99/103', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('104', '专业服务', '连锁店的CI和一般企业的作法有相当大的差异，最主要的因素就是与目标接触的场合不同。连锁店与消费者之间最常发生的接触就是在门店，创造视觉的个性化与标准化，来
加深人们的印象', '2', 'servise.htm', 'news-list.htm', '/99/104', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('106', '我们的作品', '新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', '1', 'product-show.htm', 'product-list.htm', '/106', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('107', '我们的作品', '新颖的设计方案，大胆的革新思想，灵活的运用最新技术，是品网视觉的特点，我们只做有灵魂的设计', '1', 'product-show.htm', 'product-list.htm', '/106/107', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('108', NULL, NULL, '1', 'product-show.htm', 'product-list.htm', '/106/108', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('115', NULL, NULL, '1', 'show.htm', 'service.htm', '/115', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('133', '网站设计 网站制作 网站维护 网站改版', '关于我们', '2', 'about.htm', NULL, '/53/133', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('134', '网站整站优化 网页结构优化 网站关键词优化', NULL, '2', 'about.htm', NULL, '/53/134', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('135', '英文国际域名 英文国内域名 中文国际域名 中文国内域名', '关于我们', '2', 'about.htm', NULL, '/53/135', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('136', NULL, '联系我们', '2', 'about.htm', 'about.htm', '/52/136', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('138', NULL, '我们为您提供网站策划、网页设计、程序开发、网站推广、域名注册、虚拟主机、企业邮箱等网站建设相关服务；为您提供iOS/Android/Windows Phone等移动平台的APP应用开发；为您提供办公系统、客户关系管理系统、电子政务系统等行业应用系统的开发；为您提供软件定制开发和系统集成服务。', '2', 'service.htm', 'service.htm', '/63/138', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('141', NULL, NULL, '2', 'contact.htm', 'contact.htm', '/19/141', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('142', NULL, NULL, '2', 'advice.htm', NULL, '/19/142', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('146', NULL, NULL, '2', 'advertises.htm', 'about.htm', '/146', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('147', NULL, NULL, '1', 'index.html', 'index.html', '/100/147', NULL);
INSERT INTO "BASIC_COLUMN" VALUES ('148', NULL, NULL, '1', 'index.html', 'index.html', '/100/148', NULL);

-- ----------------------------
-- Table structure for BASIC_LOG
-- ----------------------------
DROP TABLE "BASIC_LOG";
CREATE TABLE "BASIC_LOG" (
  "BL_ID" NUMBER(11) NOT NULL ,
  "BL_BASIC_ID" NUMBER(11) NOT NULL ,
  "BL_IP" NVARCHAR2(20) NOT NULL ,
  "BL_DATETIME" DATE NOT NULL ,
  "BL_IS_MOBILE" NUMBER(11) DEFAULT 0  NOT NULL 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BASIC_LOG"."BL_ID" IS '编号';
COMMENT ON COLUMN "BASIC_LOG"."BL_BASIC_ID" IS '引用编号';
COMMENT ON COLUMN "BASIC_LOG"."BL_IP" IS 'ip地址';
COMMENT ON COLUMN "BASIC_LOG"."BL_DATETIME" IS '记录时间';
COMMENT ON COLUMN "BASIC_LOG"."BL_IS_MOBILE" IS '1移动端 0默认pc';
COMMENT ON TABLE "BASIC_LOG" IS '信息访问日志';

-- ----------------------------
-- Records of "BASIC_LOG"
-- ----------------------------
INSERT INTO "BASIC_LOG" VALUES ('1', '178', '192.168.1.165', TO_DATE('2016-05-31 15:33:33', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('2', '74', '192.168.1.165', TO_DATE('2016-05-31 15:33:36', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('3', '179', '192.168.1.165', TO_DATE('2016-05-31 15:33:44', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('4', '63', '192.168.1.165', TO_DATE('2016-05-31 17:49:01', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('5', '70', '192.168.1.165', TO_DATE('2016-05-31 17:53:37', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('6', '58', '192.168.1.165', TO_DATE('2016-05-31 17:54:59', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('7', '59', '192.168.1.165', TO_DATE('2016-05-31 17:55:09', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('8', '56', '192.168.1.165', TO_DATE('2016-05-31 17:55:13', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('9', '62', '192.168.1.165', TO_DATE('2016-05-31 17:55:38', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('10', '61', '192.168.1.165', TO_DATE('2016-05-31 17:55:40', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('11', '57', '192.168.1.165', TO_DATE('2016-05-31 17:56:21', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('12', '177', '192.168.1.165', TO_DATE('2016-06-03 17:41:32', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('13', '73', '192.168.1.165', TO_DATE('2016-06-12 11:31:11', 'SYYYY-MM-DD HH24:MI:SS'), '0');
INSERT INTO "BASIC_LOG" VALUES ('14', '73', '192.168.1.152', TO_DATE('2016-06-13 19:53:50', 'SYYYY-MM-DD HH24:MI:SS'), '0');

-- ----------------------------
-- Table structure for CATEGORY
-- ----------------------------
DROP TABLE "CATEGORY";
CREATE TABLE "CATEGORY" (
  "CATEGORY_ID" NUMBER(11) NOT NULL ,
  "CATEGORY_TITLE" NVARCHAR2(50) ,
  "CATEGORY_SORT" NUMBER(11) ,
  "CATEGORY_DATETIME" DATE ,
  "CATEGORY_MANAGERID" NUMBER(11) ,
  "CATEGORY_MODELID" NUMBER(11) ,
  "CATEGORY_CATEGORYID" NUMBER(11) ,
  "CATEGORY_SMALLIMG" NCLOB ,
  "CATEGORY_APPID" NUMBER(11) ,
  "CATEGORY_DESCRIPTION" NVARCHAR2(45) ,
  "CATEGORY_PARENT_ID" NVARCHAR2(255) ,
  "CATEGORY_DICT_ID" NUMBER(11) DEFAULT 0  ,
  "CREATE_BY" NUMBER(11) DEFAULT 0  ,
  "CREATE_DATE" DATE ,
  "UPDATE_BY" NUMBER(11) DEFAULT 0  ,
  "UPDATE_DATE" DATE ,
  "DEL" NUMBER(11) DEFAULT 0  NOT NULL 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "CATEGORY"."CATEGORY_ID" IS '类别ID';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_TITLE" IS '类别标题';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_SORT" IS '类别排序';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_DATETIME" IS '类别发布时间';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_MANAGERID" IS '发布用户id';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_MODELID" IS '所属模块id';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_CATEGORYID" IS '父类别编号';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_SMALLIMG" IS '略缩图';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_APPID" IS '应用编号';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_DESCRIPTION" IS '栏目描述';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_PARENT_ID" IS '父类型编号';
COMMENT ON COLUMN "CATEGORY"."CATEGORY_DICT_ID" IS '字典对应编号';
COMMENT ON COLUMN "CATEGORY"."CREATE_BY" IS '创建人';
COMMENT ON COLUMN "CATEGORY"."CREATE_DATE" IS '创建时间';
COMMENT ON COLUMN "CATEGORY"."UPDATE_BY" IS '更新人';
COMMENT ON COLUMN "CATEGORY"."UPDATE_DATE" IS '更新时间';
COMMENT ON COLUMN "CATEGORY"."DEL" IS '删除状态';
COMMENT ON TABLE "CATEGORY" IS '分类表';

-- ----------------------------
-- Records of "CATEGORY"
-- ----------------------------
INSERT INTO "CATEGORY" VALUES ('19', '联系我们', '0', TO_DATE('2015-09-01 15:31:30', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('23', '常见问题', '0', TO_DATE('2015-09-01 15:33:54', 'SYYYY-MM-DD HH24:MI:SS'), '50', '87', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('33', '投资', '0', TO_DATE('2015-09-02 00:32:02', 'SYYYY-MM-DD HH24:MI:SS'), '50', '87', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('52', '招商加盟', '0', TO_DATE('2016-03-15 17:35:38', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('53', '关于我们', '0', TO_DATE('2016-03-16 17:16:11', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('59', '新闻中心', '0', TO_DATE('2016-03-26 13:18:53', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('61', '客户案例', '0', TO_DATE('2016-03-26 13:26:34', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('62', '新闻', '0', TO_DATE('2016-03-26 13:27:39', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('63', '服务', '0', TO_DATE('2016-03-26 13:29:07', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('65', '网站设计', '3', TO_DATE('2016-03-26 14:34:49', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '61', NULL, '1', NULL, '61', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('66', '手机应用', '1', TO_DATE('2016-03-26 14:35:49', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '61', NULL, '1', NULL, '61', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('67', '平面设计', '2', TO_DATE('2016-03-26 14:36:15', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '61', NULL, '1', NULL, '61', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('68', '公司新闻', '3', TO_DATE('2016-03-27 09:39:22', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '59', NULL, '1', NULL, '59', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('69', '行业新闻', '2', TO_DATE('2016-03-27 09:39:48', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '59', NULL, '1', NULL, '59', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('70', '最新动态', '1', TO_DATE('2016-03-27 09:40:22', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '59', NULL, '1', NULL, '59', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('83', '研发团队', '2', TO_DATE('2016-03-28 16:51:31', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '62', NULL, '1', NULL, '62', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('84', '研发成果', '1', TO_DATE('2016-03-28 16:54:29', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '62', NULL, '1', NULL, '62', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('87', '客户的声音', '0', TO_DATE('2016-03-30 10:27:42', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('93', '关于我们', '0', TO_DATE('2016-04-11 19:52:30', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('94', '主营业务', '5', TO_DATE('2016-04-11 19:54:05', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '93', NULL, '1', NULL, '93', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('95', '企业文化', '4', TO_DATE('2016-04-11 19:54:43', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '93', NULL, '1', NULL, '93', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('96', '资质荣誉', '0', TO_DATE('2016-04-11 19:55:18', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '93', NULL, '1', NULL, '93', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('97', '合作伙伴', '0', TO_DATE('2016-04-11 19:55:41', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '93', NULL, '1', NULL, '93', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('98', '企业优势', '0', TO_DATE('2016-04-11 19:56:04', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '93', NULL, '1', NULL, '93', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('99', '服务项目', '0', TO_DATE('2016-04-11 20:32:40', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('100', '首页幻灯', '0', TO_DATE('2016-04-11 20:56:40', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('101', ' 全案设计', '3', TO_DATE('2016-04-11 21:04:41', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '99', NULL, '1', NULL, '99', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('102', '企业形象设计', '4', TO_DATE('2016-04-11 21:05:11', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '99', NULL, '1', NULL, '99', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('103', '产品包装设计', '2', TO_DATE('2016-04-11 21:05:42', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '99', NULL, '1', NULL, '99', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('104', '连锁店设计', '0', TO_DATE('2016-04-11 21:05:57', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '99', NULL, '1', NULL, '99', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('106', '产品列表', '0', TO_DATE('2016-04-11 21:15:27', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('107', '产品一类', '2', TO_DATE('2016-04-11 21:15:43', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '106', NULL, '1', NULL, '106', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('108', '产品二类', '1', TO_DATE('2016-04-11 21:16:21', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '106', NULL, '1', NULL, '106', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('115', '专家研究院', '0', TO_DATE('2016-04-11 21:29:24', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('133', '网站优化', '3', TO_DATE('2016-04-17 18:32:05', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '53', NULL, '1', NULL, '53', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('134', '网络营销', '2', TO_DATE('2016-04-17 18:33:01', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '53', NULL, '1', NULL, '53', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('135', '域名注册', '1', TO_DATE('2016-04-17 18:33:47', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '53', NULL, '1', NULL, '53', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('136', '优化报价', '0', TO_DATE('2016-04-17 21:13:17', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '52', NULL, '1', NULL, '52', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('138', '服务中心', '0', TO_DATE('2016-04-29 17:15:49', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '63', NULL, '1', NULL, '63', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('141', '联系我们', '2', TO_DATE('2016-05-04 14:42:07', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '19', NULL, '1', NULL, '19', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('142', '在线留言', '1', TO_DATE('2016-05-04 14:42:31', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '19', NULL, '1', NULL, '19', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('146', '人才招聘', '0', TO_DATE('2016-05-19 17:49:37', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', NULL, NULL, '1', NULL, NULL, '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('147', '长图', '0', TO_DATE('2016-06-02 17:23:49', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '100', NULL, '1', NULL, '100', '0', '0', NULL, '0', NULL, '0');
INSERT INTO "CATEGORY" VALUES ('148', '短图', '0', TO_DATE('2016-06-02 17:24:21', 'SYYYY-MM-DD HH24:MI:SS'), '50', '7', '100', NULL, '1', NULL, '100', '0', '0', NULL, '0', NULL, '0');

-- ----------------------------
-- Table structure for CMS_ARTICLE
-- ----------------------------
DROP TABLE "CMS_ARTICLE";
CREATE TABLE "CMS_ARTICLE" (
  "ARTICLE_BASICID" NUMBER(11) DEFAULT 0  NOT NULL ,
  "ARTICLE_AUTHOR" NVARCHAR2(20) ,
  "ARTICLE_CONTENT" NCLOB ,
  "ARTICLE_TYPE" NVARCHAR2(100) ,
  "ARTICLE_SOURCE" NVARCHAR2(300) ,
  "ARTICLE_URL" NVARCHAR2(200) ,
  "ARTICLE_KEYWORD" NVARCHAR2(300) ,
  "ARTICLE_FREEORDER" NUMBER(11) ,
  "ARTICLE_WEBID" NUMBER(11) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_BASICID" IS '文章id';
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_AUTHOR" IS '文章作者';
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_CONTENT" IS '文章内容';
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_TYPE" IS '文章类型';
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_SOURCE" IS '文章来源';
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_URL" IS '文章跳转链接地址';
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_KEYWORD" IS '文章关键字';
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_FREEORDER" IS '文章自定义显示顺序';
COMMENT ON COLUMN "CMS_ARTICLE"."ARTICLE_WEBID" IS '文章管理的应用id';
COMMENT ON TABLE "CMS_ARTICLE" IS '文章表';

-- ----------------------------
-- Records of "CMS_ARTICLE"
-- ----------------------------
INSERT INTO "CMS_ARTICLE" VALUES ('132', 'CORPORATE PART', '<p><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">全心全力，美善相随，</span><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">这个世代不缺技艺超群之才，</span><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">却匮乏尽心尽力之士，</span><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">CEDAR信实守约</span></p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">捧着一颗心来，不带半根草去，竭力置身于客户的立场换位思考，除去一切不利于客户利益的自我私欲</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">精诚坦荡，肝胆相照，将自己的专业本色全意展现，为客户创造超值的服务体验 &nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"><br/></p><p><br/></p>', 'h,', 'CORPORATE CULTURE', '/93/95\132.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('134', NULL, '<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"><span style="margin: 0px; padding: 0px; border: 0px; font-family: Arial, 宋体, SimSun, HELVETICA, &#39;Hiragino Sans GB&#39;; font-size: 14px; line-height: 26px; text-indent: 28px;">2009年12月13日由中国民族建筑研究会与中国</span>房地产<span style="margin: 0px; padding: 0px; border: 0px; font-family: Arial, 宋体, SimSun, HELVETICA, &#39;Hiragino Sans GB&#39;; font-size: 14px; line-height: 26px; text-indent: 28px;">及住宅研究会共同主办，“2009？第六届中国人居典范建筑规划设计方案竞赛”颁奖大会在北京？京都信苑饭店隆重召开。经过九个多月来的精心组织与评选，全国共有241个方案获奖。通过本届竞赛，在全国建设领域树立一批人居规划设计典范，对促进全国建筑规划设计和建设水平的提高起到示范推动作用。</span></p><p><br/></p>', NULL, '关于我们', '/93/96\134.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('135', NULL, '<p><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); text-align: justify; font-family: Arial, 宋体, SimSun, HELVETICA, &#39;Hiragino Sans GB&#39;; font-size: 14px; line-height: 26px; text-indent: 28px;">2009年12月13日由中国民族建筑研究会与中国</span><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">房地产</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); text-align: justify; font-family: Arial, 宋体, SimSun, HELVETICA, &#39;Hiragino Sans GB&#39;; font-size: 14px; line-height: 26px; text-indent: 28px;">及住宅研究会共同主办，“2009？第六届中国人居典范建筑规划设计方案竞赛”颁奖大会在北京？京都信苑饭店隆重召开。经过九个多月来的精心组织与评选，全国共有241个方案获奖。通过本届竞赛，在全国建设领域树立一批人居规划设计典范，对促进全国建筑规划设计和建设水平的提高起到示范推动作用。</span></p>', 'h,', '关于我们', '/93/96\135.html', '最佳设计方案', '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('136', '1', '<p><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">广州规划设计以金融资本为支撑，以规划设计为撬动点，协助旅游业开发高潜力项目，推动项目融资，帮助客户在产业版图拓展中淘金入市。</span></p>', NULL, '关于我们', '/93/98\136.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('137', NULL, NULL, NULL, NULL, '/100\137.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('138', NULL, NULL, NULL, NULL, '/100\138.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('139', NULL, NULL, 'f,', NULL, '/100\139.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('140', NULL, NULL, NULL, '首页幻灯', '/100\140.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('24', '铭飞科技', '<p>&nbsp; 公司于2012年3月8日，已正式向《景德镇市工商行政管理局》领取营业 &nbsp; 执照。</p><p>&nbsp; 公司名称：景德镇铭飞科技有限公司</p><p>&nbsp; 经营范围：计算机系统服务及技术开发、咨询服务</p><p><br/></p>', 'c,', '铭飞科技', '/19\index.html', '公司于2012年3月8日，已正式向《景德镇市工商行政管理局》领取营业   执照。
  公司名称：景德镇铭飞科技有限公司
  经营范围：计算机系统服务及技术开发、咨询服务', '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('37', '火星猿', '<p class="font_b font_14" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-weight: bold; font-size: 14px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 21px; white-space: normal; background-repeat: no-repeat;">*&nbsp;&nbsp;以人为本，人尽其才&quot;的原则<br/>*&nbsp;&nbsp;德才兼备,德为先&nbsp;<br/>*&nbsp;&nbsp;内部提拔,给员工一个上升的空间<br/>*&nbsp;&nbsp;绩效考核制度,倡导&quot;能者上，庸者下&quot;的淘汰机制</p><p class="font_b font_14" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-weight: bold; font-size: 14px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 21px; white-space: normal; background-repeat: no-repeat;">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;">一个企业的竞争力归结到底是人才的竞争力。荣超物业本着&quot;以人为本，人尽其才&quot;的原则，为有志于物业管理行业发展的人才提供一个发展的舞台。在人才招聘中，结合每位应聘者的素质、品格、经验进行综合评价，遵循公平、平等、竞争、择优以及双向选择的原则。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;">企业内部的竞聘、晋升机制，为员工提供了公平竞争的机会。通过挖掘企业内部的人才，调动内部人员的潜力和积极性，促进了优秀人才脱颖而出，实现人力资源的合理配置，把&quot;合适的人放在合适的地方&quot;。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;">建立客观公正的考核制度，是人才使用的一个重要人力资源措施。考核突出对每位员工的工作绩效、工作态度和工作能力进行考评，以提高团队的整体绩效和提高企业的管理服务水平，并倡导&quot;能者上，庸者下&quot;的淘汰机制。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 12px; line-height: 21px; white-space: normal; background-repeat: no-repeat;">企业致力于创造一个员工于企业共同发展的空间和平台，荣超物业期待您的加盟，企业的发展将为您的加入而更为精彩！</p><p><br/></p>', NULL, 'MS', '/54\37.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('52', 'MS', '<p>响应式web设计对于解决多类型屏幕问题来说是个不错方案，但从印刷的角度来看，其却存在着很多的困难。没有固定的页面尺寸、没有毫米或英寸，没有任何物 理限制，让人感到无从下手。随着建立网站可用的各种小工具越来越多，像素设计局限于桌面和移动端也已经成为历史。因此，现在就让我们来说明一下如何运用响 应式web设计的各项基本原则来实现，而不是抗拒流畅的网页体验。为了简单起见，我们将着重讲布局</p>', 'f,', '来自火星的程序猿', '/61/65\52.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('53', 'MS', '<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);"><strong style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;">Gmai</strong>就 是单页应用的一个很好的例子，其将多项操作融入了一个单独的“页面”中。单页设计的趋势是这一UI模式中相对不太高端的一种实现方式，在这一设计模式下， 所有内容均可通过同一页面访问。这一模式可以让浏览变得更快、响应更迅速，从而让桌面与web应用之间的界限不再如此分明。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);">对于Spotify等web应用，考虑到用户有时会在背景播放音乐的同时浏览其他音乐，这时单页应用模式的重要性就愈发凸显，通过使用单页应用，用户就无需对页面进行重新加载，也不会造成音乐停止播放。</p><p><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; background: rgb(255, 255, 255);">在 使用单页应用时需要考虑的一个问题就是URL结构。由于内容使用JavaScript动态加载，URL会失去作用，如果设计不当，还会造成无法访问特定视 图。Gmail和Twitter等应用通过为每个视图生成专门的URL来克服这一问题，这一方法还能够解决浏览器后退按钮失效的问题。</span></p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);"><br/></p><p><br/></p>', 'c,', '来自火星的程序猿', '/61/65\53.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('54', 'MS', '<p><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; color: rgb(51, 51, 51); background: transparent;"><span style="font-family:Verdana, 宋体;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;"><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;">用 户体验只有在渗透入从创意到开发测试等产品开发的各个阶段时才能发挥最佳效果。当通常来说事情没这么简单，用户体验专家需要反复对已经完成的产品进行优化 才能使其达到我们口中所说的“用户友好”水平。但是，亡羊补牢，为时未晚。对现有网站进行用户体验优化也有自己的好处和缺点。好处是你可以获得更多真实用 户数据和统计信息方便进行用户调研，但另一方面，也会遇到很多变革的阻力，特别是在你要换掉用户“心爱的宝贝”的时候。</span></span></span></p><p><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(127, 127, 127); background: rgb(255, 255, 255);"><span style="font-family:微软雅黑,;margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;"><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 16px; vertical-align: baseline; background: transparent;">作为用户体验专家，你可以自由选择调研的方法，甚至可以使用超越传统工具的方法，但是今天，我想回归简单，谈一谈启发式评估方法。</span></span></span></p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);"><br/></p><p><br/></p>', NULL, '来自火星的程序猿', '/61/67\54.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('55', 'MS', '<p><span style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; background-color: rgb(255, 255, 255);">想象一下走进一个狭小拥挤，遍地垃圾的商店。店员不停怂恿你买自己不想要的东西。在这种情况下，你肯定会马上转身离开去别家。如果有人给你压力，逼迫你在充满敌意的环境下快速做出抉择，你会自然而然的失去信任感。这一点也适用于网络。</span><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/><span style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; background-color: rgb(255, 255, 255);">网上充满着向你推销各种服务和产品的人。用户要先信任你，才能考虑从你那购买产品或服务。下面列出了10个比较流行的让用户相信、信任你登陆页面的方法。你可以借鉴或者干脆照搬这些方法为你的网上业务建立起值得信赖的网站。</span><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/><strong style="margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; white-space: normal; background: rgb(255, 255, 255);">1.快速表现价值</strong><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/><span style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; background-color: rgb(255, 255, 255);">每个来到你登陆页面的用户都会问同一个问题：你能给我带来什么好处？你需要让他们立刻看到你所能提供的价值。使用显眼的标题说明你所能提供的内容，以及你 与竞争对手的不同之处在哪。但是不要太过于强调你自己和你的公司，否则可能会让用户反感而离开。应当着重强调你如何满足用户的需求。</span></p>', 'h,', '来自火星的程序猿', '/61/67\55.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('57', 'MS', '<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 24px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);">感到自己深陷千篇一律的设计泥潭无法自拔？</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 24px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);">Stylorouge的Rob O’Connor为你送上下面几条建议帮助你解放自己的想象力。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 26px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);">找不到设计灵感？项目在眼前却不知道如何着手或者找不到合适的入手角度？挣扎着想克服阻拦创意的屏障？</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 26px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);">别着急，哪怕是最优秀的设计师也会碰上这些问题。你只需要找到方法让大脑重回战斗状态，创意就会源源不断滚滚而来。下面，我们为你整理了一系列能帮助你有效进行头脑风暴的小建议，另外还有五个绝妙的应用协助你捋清头脑风暴的流程。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);"><br/></p><p><br/></p>', 'p,h,', '来自火星的程序猿', '/61/65\57.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('58', 'MS', '<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);">在这个简短的移动端设计模式系列文章的前几篇中，我为大家介绍了几个能够解决开发期间所产生问题的常见设计模式，大家也学到了什么是设计模式，其基本组成 部分有什么，使用它们解决问题的最佳方法都有哪些，以及表单、图片集架构、搜索功能和交互建议等各种问题。另外，大家应该还了解了避免<br/>作为本系列的终篇，我将为大家概括性地介绍5种流行移动应用中常见的界面设计模式以供大家在自己的项目中参考。这些设计模式有助于大家提高设计的可用性，让界面变得更加直观。文章将侧重介绍能够帮助大家进行下列各方面设计的模式：<br/>· 社交分享<br/>· 通知<br/>· 弹窗<br/>· 内容更新<br/>· 用户互动（滑动、点击等）</p><p><br/></p>', NULL, '来自火星的程序猿', '/61/65\58.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('59', 'MS', '<p>网页中的柔和色调的使用，不止是近来的趋势，这是一项设计师使用多年的技巧，用来创造有冲击力的视觉效果。</p><p><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/></p><p>当你听到“柔和”一词，想到的可能是淡粉色、淡蓝色、淡黄色，不过这种配色远不止这些颜色。柔和并不一定要感觉像新生儿一样。通过某些适当的方式，配合其他元素，这些色调也可以相当鲜明。</p><p><br style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; white-space: normal; background-color: rgb(255, 255, 255);"/></p><p>下面我们从优秀的案例网站出发，了解10种在网页设计中运用柔和色调的方法。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);"><br/></p><p><br/></p>', NULL, '来自火星的程序猿', '/61/65\59.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('60', 'MS', '<p><span style="color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, sans-serif; font-size: 14px; line-height: 23px; background-color: rgb(255, 255, 255);">随着苹果ios8的发布，可以看到App store货架上，众多主流App迫不及待地向人们展示产品视频预览，接下去会是被设计师、市场宣传相继关注的焦点，产品宣传的下一轮引爆点。作为能在 App store上先发触达地形成前期推广的视频预览，又会否影响到App安装完毕后的引导页呈现？我们不得而知。鉴于两者形式的展现，间隔于安装App前后， 多少会规避重复性。不管怎样，趁着手机App和扁平风热潮，一起来细数归纳下对手机引导页的所见所想。 早期我们会见到比较多成熟的PC软件或者网页产品的产品安装包或新特性指引页。近几年在移动端平台上兴起了各种门类，形式精彩纷呈的引导页。</span></p>', NULL, '来自火星的程序猿', '/61/65\60.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('61', 'MS', '<p>一幅好照片要把观众的注意力吸引到趣味中心&amp;mdash;&amp;mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体，这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的。</p><p>&nbsp;</p><p>&nbsp; &nbsp;&nbsp;&nbsp;网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&amp;ldquo;G点&amp;rdquo;，有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。</p><p>&nbsp;</p><p>&nbsp; &nbsp;&nbsp;&nbsp;下面我将通过几种突出被摄重点的摄影方法来诠释设计与摄影的微妙关系。</p><p>&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; font-stretch: normal; font-family: &#39;Open Sans&#39;, sans-serif; line-height: 23px; color: rgb(114, 114, 114); white-space: normal; background: rgb(255, 255, 255);"><br/></p><p><br/></p>', NULL, '来自火星的程序猿', '/61/65\61.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('112', NULL, '<p><strong>主营品牌车型：</strong>奔驰、宝马、奥迪、路虎、保时捷、宾利、劳斯莱斯、北京现代、上海大众斯柯达、东风标致、东风悦达起亚、东风雪铁龙、东风本田雪弗兰、上海大众、进口大众、道奇、吉普、雷诺、别克、马自达、中华、福特、海南马自达等各种中高档进口和国产轿车。在汽车销售行业里有着较高的知名度和良好的信誉。</p><p>经营业务：除了销售各种品牌车外，还经营汽车保险、汽车装潢、汽车按揭、二手车评估、二手车收购、二手车置换，并免费为您提供上牌等一条龙服务。</p><p>&nbsp;</p><p><strong>郑重承诺：</strong>保证您从我公司购买的车是全市场上最低的价格，让您购的放心， 我公司所售车辆均为各品牌4S店的车，选车、交钱、提车、开发票、售后保养，一切的一切都在4S店办理，我们就相当于是4S店的跑量销售员（批发价）。 说白了，就是您在4S店买车我们帮您还价。 您在我公司定了车以后，我们会安排4S店的销售员和你联系。</p><p><strong>经营宗旨：</strong>减少成本和跑量给消费者带来最大的实惠！金杯银杯不如客户的口碑！只要您买过就会介绍朋友来买！</p><p>宝诚导购流程：我公司为了让大家更放心的购买汽车，现进行经营模式调整，较以前更加灵活、更加方便、更具备人性化。如果有客户觉得我们的价格比较实惠，但又担心车的来源，在这种情况下，我公司对有顾虑的客户，我们帮您排除这个疑虑。在我们公司签定车合同后，我们安排4S店销售员和您联系，办理所有相关手续。具体导购流程如下：</p><p><strong>第一步：</strong>您可以先到您所需品牌的任何一家4S店看车，选车，然后决定要什么车型。</p><p><strong>第二步：</strong>决定好所需车型，在某品牌4S店进行砍价，和销售员谈个最低价，但切忌不要交定金。</p><p><strong>第三步：</strong>拨打我们公司电话，告诉我们您需要的车型和颜色，以及哪家4S店。和我们谈好您觉得的满意的价格，我们觉得有钱可赚（少赚点没关系，不亏就行），意见达成一致。</p><p><strong>第四步：</strong>直接到我们公司签定车合同并交付定金。<br/><strong>第五步：</strong>我公司安排销售人员陪同客户去4S店提车并办理相关手续。</p><p><br/></p>', 'h,', '公关前台', '/61/87\112.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('113', NULL, '<p><span style="color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);">&nbsp;</span><strong style="font-size: 14px; white-space: normal; font-family: 宋体; line-height: 22px; padding: 0px; margin: 0px; background-color: rgb(255, 255, 255);">1、特色服务</strong><span style="color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);"></span></p><p>1.1 提供专业的危险品一条龙服务，从专业的危险品取样，代做报告（化工报告和商检报告危包证），及提供报关单证，报关，申报，交接危险品货物，至货物安全的到达目的港，全方位的D/D TO D/D 服务；</p><p>1.2 东航，国泰，阿联酋，汉莎4GV包装使用备案免检企业，可采用4GV作为货物外包装，免于检验；</p><p>1.3 能够协助客户用MSDS 来代替化工报告的业务。</p><p>&nbsp;</p><p><strong style="padding: 0px; margin: 0px;">2、&nbsp;常规服务</strong></p><p>2.1 订舱：快捷、顺畅、全面快捷</p><p>便捷多样的订舱渠道（EK，MU，CX，LH，KL，AF，FM，CA等）顺畅：熟悉各航空公司危险品订舱要求及操作流程。全面：承接全球各航空公司航线化工品、危险品运输</p><p>2.2 仓库 运输</p><p>提供全方位专业的打托、包装、唛头、标签及更换外包装等服务；公司自备各类具有危险品资质的车辆，满足客户上门提货的需求。</p><p>2.3 报关、报检</p><p>代办空运危险品的报关报检,上海化工院鉴定，IMI鉴定证书，代做危包证等服务。</p><p>2.4 货物查询</p><p>E-SERVICE：自助式网上查询系统，方便客户跟踪、查询货物状态。</p><p>&nbsp;</p><p><strong style="padding: 0px; margin: 0px;">3、 实力资质</strong></p><p>3.1 专业人员</p><p>资深的客户服务人员、订舱操作人员、危险品货物交接人员，拥有丰富的化工品、危险品专业知识和具有良好的沟通能力，熟悉各航空公司对危险品的操作流程。</p><p>3.2 完善系统</p><p>专业的流程化订舱体系ERP操作系统，从接单、订舱、货物包装商检、报关交接等一系列货物运输环节，R-Q HSE安全控制体系，监控并确保货物安全规范运输。</p><p>3.3 资质及设施</p><p>中国外经贸部批准的一级货运代理证书，中国航空运输协会批准颁发的一级货运代理证书，中国货代百强企业；</p><p>操作人员拥有中国航协ITAT 颁发的危险品操作人员证书和DGM 及浦东机场货栈颁发的危险品资质证书；</p><p>在机场内拥有6000平方米的普通仓库，4000 平方米的专业危险品仓库，齐备叉车，打包机等专业的仓储设备，120辆专用危险品运输车辆为客户提供专业、安全、便捷、快速的仓储及配送服务。</p><p><br/></p>', 'c,', '总经理', '/61/87\113.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('130', NULL, '<p><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">广州城市规划设计有限公司是中欧国际旅游规划设计研究院（Sino-Europe Academy of Tourism Planning and Design）旗下之专业机构，公司专注于城市规划、旅游规划设计与商业综合体设计，构建了从规划设计、品牌营销、资本运作到管理咨询等全产品链集成一体化服务，提供从总体策划、建筑景观设计、资源引进、战略实施、平台搭建到运营管理等全程、专业化解决方案。</span></p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"><br style="margin: 0px; padding: 0px; border: 0px;"/>广州规划设计以“产业联动、搭建平台、金融孵化”为经营哲学，推动旅游业与民俗艺术、饮食、地产、绿色农业及金融业的融合发展，同时依托中欧国际旅游规划设计研究院的学术背景与国际资源，搭建行业交互平台，提供切合旅游企业需要的一揽子专业协同服务。<br style="margin: 0px; padding: 0px; border: 0px;"/><br style="margin: 0px; padding: 0px; border: 0px;"/>广州规划设计秉持“文化开发与生态保护相结合”的规划设计理念，切实将“因地制宜、以人为本、市场引导、经济可行、体验为怀、低碳环保”的精神贯穿于每一个项目之中，倡导空间与艺术相结合、经济与美学相融合、历史文明与现代时尚相调和，力求每个作品都能达到人文景观与大自然的和谐完美融合。<br style="margin: 0px; padding: 0px; border: 0px;"/><br style="margin: 0px; padding: 0px; border: 0px;"/>广州规划设计与国际行业组织、海内外同行及国内知名高等院校如香港大学、中山大学、同济大学、广东财经大学等建立和保持着密切的合作与互动关系，致力于整合行业高端智慧，引进行业优质资源，推动中国旅游业迈向更高的竞争层次。</p><p><br/></p>', 'h,', '关于我们', '/93\130.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('203', 'MS', '<p><span style="color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);">奔驰斯宾特系列礼宾车在豪华商务车系中，一向是高端、舒适的代名词。在秉承了奔驰的贵族气质的同时，其全新定制的奢华内饰让人感觉犹如进入了高档的商务会所。定位为大型集团公司商务接待用车。其超高端的豪华配置能够很好的提升用车企业的自身品质，给来访者一种最高礼遇，是对商务洽谈活动的一种实质推动和提升。&nbsp;</span></p>', 'c,', '来自火星的程序猿', '/106/107\203.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('204', NULL, NULL, NULL, NULL, '/100/148\204.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('205', NULL, NULL, NULL, NULL, '/100/148\205.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('206', NULL, NULL, NULL, NULL, '/100/148\206.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('207', NULL, NULL, NULL, NULL, '/100/148\207.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('208', NULL, NULL, NULL, NULL, '/100/148\208.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('209', NULL, NULL, NULL, '园林绿化二级资质企业', '/100/148\209.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('210', NULL, NULL, NULL, '园林绿化二级资质企业', '/100/147\210.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('211', NULL, NULL, NULL, '园林绿化二级资质企业', '/100/147\211.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('212', NULL, '<ol class="list-ol list-paddingleft-2" style="list-style-type: square;"><li><p>创造价值，提供优质的产品和服务，赢得用户的喜爱和尊敬。</p></li><li><p>利益均沾，让公司的每一成员都获得满意的回报。</p></li><li><p>合作共赢，与合作伙伴共同成长，赢得行业尊敬。</p></li><li><p>注重企业责任，关爱社会、回馈社会，赢得社会尊敬。</p></li></ol><p><br/></p>', 'h,', NULL, '/93/95\212.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('213', NULL, '<ol class="list-ol list-paddingleft-2" style="list-style-type: square;"><li><p>创造价值：一切工作围绕为用户价值展开，不做任何对用户没有价值的面子工作。</p></li><li><p>积极主动：在做好本职工作的前提下，积极主动为公司解决问题，推动公司发展。</p></li><li><p>踏实奋进：不报幻想，实事求是，锐意进取。不把“运气”当作成事的前提，抱美好的梦想，作最坏的打算。</p></li><li><p>合作共赢：抱着共赢的心态，积极与企业内外合作，充分利用各方优势，创造价值。</p></li></ol><p><br/></p>', 'p,', NULL, '/93/95\213.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('214', NULL, '<ol class="list-ol list-paddingleft-2" style="list-style-type: square;"><li><p>注重长远发展，不因商业利益伤害用户价值。</p></li><li><p>关注并深刻理解用户需求，不断以卓越的产品和服务满足用户需求。</p></li><li><p>重视与用户的情感沟通，尊重用户感受，与用户共成长。</p></li><li><p>合作共赢：抱着共赢的心态，积极与企业内外合作，充分利用各方优势，创造价值。</p></li></ol><p><br/></p>', 'f,', NULL, '/93/95\214.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('215', NULL, '<ol class="list-ol list-paddingleft-2" style="list-style-type: square;"><li><p>努力为员工提供良好的工作环境和科学的激励机制。</p></li><li><p>努力让适合的人干适合的事，为员工提供丰富的培训和晋升机会，使员工和公司共同成长。</p></li><li><p>尊重和信任员工，鼓励员工充分发挥聪明才智，使其在自己的领域获得成功。</p></li></ol><p><br/></p>', 'c,', NULL, '/93/95\215.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('216', NULL, '<p>锐诚PPT创始人，资深PPT设计师、培训师、品牌策划师，任全国知名地产公司高级策划师，大型教育集团品牌运营总监；创办锐诚PPT后，为中原演示设计领域带来全新标准，帮助数百家企业定制演示精品，让演示创造更多价值。精通各种高端PPT设计、 精通版式、配色、文字逻辑和动画，设计案例上百件。擅长在实战中为学员点拨，让学员快速提升美感，做出更漂亮的作品。</p><p><br/></p>', 'h,', NULL, '/115\216.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('217', NULL, '<p>锐诚PPT特邀首席技术专家，连续五年荣获美国微软公司评出的全球最有价值专家奖（简称MVP），通过微软办公专家国际认证（简称MOS）。出版专业PPT书籍《PPT高效设计-5分钟完美打造PPT课件》，在历届网络PPT大赛中做评委。阿瑛老师从事PPT设及教学十余年，PPT公开课上千场，经验极其丰富，授课轻松风趣，让0基础的学员都可以快速提升技能，做出漂亮的PPT。</p>', 'p,', NULL, '/115\217.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('218', NULL, '<p>锐诚PPT培训部总监，17年PPT研究积淀，5年网络教室的教学经验。2013年获得全国振兴杯多媒体制作员比赛第7名 。多次获得省市局级办公软件技术大赛奖，独撰《PPT高效设计—6招完美打造工作型PPT》全国发行。曾任中国石化干部管理学院担任“PPT高级制作技巧”课程授课讲师。幽默，轻松的授课方式，快乐中传授高效快捷的实用技术。</p><p><br/></p>', 'c,', NULL, '/115\218.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('219', NULL, '<p>锐诚PPT金牌设计师，毕业于上海美术学院视觉传达专业，曾在国内某知名4A广告公司任职，五年动画和PPT设计经验，拥有丰富的高端定制设计经验，专注于企业展示/工作汇报/品牌宣讲/竞聘/路演等高端PPT设计，设计理念：创意是设计的灵魂！在动画、质感和版式的设计上力求完美。</p><p><br/></p>', 'f,', NULL, '/115\219.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('141', NULL, '<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: left; white-space: normal;"><span style="margin: 0px; padding: 0px; border: 0px;">-&nbsp;城市商业综合体规划&nbsp;</span><span style="margin: 0px; padding: 0px; border: 0px;">-&nbsp;新城（新区）规划&nbsp;</span><span style="margin: 0px; padding: 0px; border: 0px;">-&nbsp;温城市更新与旧城改造</span><br style="margin: 0px; padding: 0px; border: 0px;"/><span style="margin: 0px; padding: 0px; border: 0px;">-&nbsp;小城镇建设规划&nbsp;</span><span style="margin: 0px; padding: 0px; border: 0px;">-&nbsp;历史文化名城/镇保护研究与规划&nbsp;</span><span style="margin: 0px; padding: 0px; border: 0px;">-&nbsp;产业园区规划</span></p><p style="text-align: left;"><span style="margin: 0px; padding: 0px; border: 0px;"><br/></span></p><p style="text-align: center;"><br/></p>', NULL, '专业服务', '/99/101\141.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('142', NULL, '<p><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">CEDAR以美学与生态的双重视野开展环境艺术的探索与实践，营造健康、高雅、舒适、美观的现代生态环境，以此提升城市及旅游景区的软环境。</span></p>', 'c,', '专业服务', '/99/102\142.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('143', NULL, '<p>在把握好旅游地的地脉（地理根据）、文脉（文化根据）和商脉（市场根据）的基础上，为旅游地做好旅游形象定位，并开展理念基础（MI）、行为准则（BI）、视觉形象（VI）的系统策...</p>', 'p,', '专业服务', '/99/103\143.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('144', NULL, '<p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em">目的地与景区管理：</p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em"><span style="line-height: 27px; text-indent: 2em;">-&nbsp;发展战略规划</span><span style="line-height: 27px; text-indent: 2em;">-&nbsp;营销管理体系咨询</span><span style="line-height: 27px; text-indent: 2em;">-&nbsp;品牌管理体系咨询</span></p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em">-&nbsp;组织架构与流程再造<span style="text-indent: 2em;">-&nbsp;投资运营与管理</span><span style="text-indent: 2em;">-&nbsp;资源与环境保护</span></p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em">&nbsp;</p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em"><span style=";padding: 0px;border: 0px;line-height: 25px;text-indent: 28px">酒店管理：</span></p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em">-&nbsp;酒店运营管理<span style="text-indent: 2em;">-&nbsp;酒店物业管理</span><span style="text-indent: 2em;">-&nbsp;酒店产品与服务管理</span></p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em">-&nbsp;酒店人力资源管理<span style="text-indent: 2em;">-&nbsp;酒店投资与财务管理</span><span style="text-indent: 2em;">-&nbsp;酒店危机管理</span></p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em">&nbsp;</p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 24px;text-indent: 2em">住宿业管理：&nbsp;&nbsp;</p><p style="margin-top: 0;margin-bottom: 0;padding: 0px;border: 0px;font-family: 微软雅黑;text-align: justify;white-space: normal;color: rgb(178, 178, 178);font-size: 14px;line-height: 27px;text-indent: 2em">为酒楼、茶楼、旅馆、非星级宾馆等住宿接待业提供经营管理咨询服务。</p><p><br/></p>', 'h,', '专业服务', '/99/104\144.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('146', 'MS', '<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">项目地址：广东梅州市雁洋镇 规划面积：1，281，863平方米 项目委托：广东梅州市人民政府</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">全世界客家人的首都，客家文化的遗产中心</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">雁洋的自然环境、人文历史以及作为世界自然度假胜地门户的地理位置，与梅州市的城市特色和资源形成互补，为当地居民及国内外游客提供一种轻松的绿色体验。我们试图通过推广建筑、农业、文化资源的保护，把现有的文化基础设施开发成为世界级别的旅游胜地。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"><img alt="" src="http://m286.dedemao.net/uploads/allimg/151112/13015313Q-0.jpg" style="margin: 0px; padding: 0px; border: 0px; vertical-align: top;"/>&nbsp;<img alt="" src="http://m286.dedemao.net/uploads/allimg/151112/1301531A9-1.jpg" style="margin: 0px; padding: 0px; border: 0px; vertical-align: top;"/>&nbsp;<img alt="" src="http://m286.dedemao.net/uploads/allimg/151112/1301531L5-2.jpg" style="margin: 0px; padding: 0px; border: 0px; vertical-align: top;"/></p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">&nbsp;</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"><img alt="" src="http://m286.dedemao.net/uploads/allimg/151112/1301531937-3.jpg" style="margin: 0px; padding: 0px; border: 0px; vertical-align: top;"/></p><p><br/></p>', NULL, '来自火星的程序猿', '/106/107\146.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('150', 'MS', '<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"><img alt="" src="http://m286.dedemao.net/uploads/allimg/151112/1530011938-0.jpg" width="45%" style="margin: 0px; padding: 0px; border: 0px; vertical-align: top;"/>&nbsp;<img alt="" src="http://m286.dedemao.net/uploads/allimg/151112/15300121b-1.jpg" width="45%" style="margin: 0px; padding: 0px; border: 0px; vertical-align: top;"/></p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; border: 0px; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;">&nbsp;</p><p><img alt="" src="http://m286.dedemao.net/uploads/allimg/151112/15300154Q-2.jpg" width="45%" style="margin: 0px; padding: 0px; border: 0px; vertical-align: top; font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"/></p><p><br/></p>', 'f,', '来自火星的程序猿', '/106/111\150.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('157', 'MS', '<p><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;区域旅游发展规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;历史文化区旅游开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;风景名胜区旅游开发规划</span><br style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"/><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;生态旅游区开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;温泉滨海度假区旅游开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;旅游地产开发规划</span><br style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"/><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;乡村旅游开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;主题公园开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;城市旅游开发规划</span></p>', NULL, '来自火星的程序猿', '/106/107\157.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('158', NULL, '<p><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;区域旅游发展规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;历史文化区旅游开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;风景名胜区旅游开发规划</span><br style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"/><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;生态旅游区开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;温泉滨海度假区旅游开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;旅游地产开发规划</span><br style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify; white-space: normal;"/><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;乡村旅游开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;主题公园开发规划</span><span style="margin: 0px; padding: 0px; border: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">-&nbsp;城市旅游开发规划</span></p>', 'f,', '专业服务', '/99/101\158.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('163', NULL, '<p><span style="color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; line-height: 24px; background-color: rgb(255, 255, 255);">凭借专业的网站策划队伍、专业的美工设计师、一流的程序开发人员，丰富的制作经验和高超的创意水平，根据您的企业的行业类型和产品特点度身定制品 牌网站。精益求精的网页制作人员、严谨的应用程序开发人员、尽善尽美的售后服务人员。这一切，是我们为您提供专业网站建设服务，也是让你在同行业中傲视群 雄</span></p>', 'f,', NULL, '/99\index.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('164', '2', '<p><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">广州规划设计麾下聚集了众多从美国旧金山艺术大学、奥本大学、香港理工大学毕业的海派旅游规划与建筑、景观设计高端人才，其国际化视野和开放创新的风格，将确保香柏领先的、卓越的规划设计水平和创造超出客户预期的服务效果。</span></p>', NULL, NULL, '/93/98\164.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('165', '3', '<p><span style="color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 13px; line-height: 25px; text-align: justify;">广州规划设计创新构建协同式、交互式、大数据及系统式行业服务平台，整合企业管理、金融、互联网、媒介各领域专业资源，为旅游行业提供一揽子系统化解决方</span></p>', 'c,', NULL, '/93/98\165.html', '高质量行业交互平台', '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('166', NULL, NULL, NULL, '65', '/63\166.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('173', NULL, '<p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;"><span style="padding: 0px; margin: 0px; font-size: 14px;">互联网品牌推广怎么做？</span></p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;">互联网品牌推广有个新鲜名词叫数字营销，数字营销是新发展起来的一种营销模式，是利用互联网特性和技术，更加有效、高性价比地完成整合营销计划，达到传统 的IMC不能达到的高效客户关系管理等，从而精准地实施营销策略，实现企业营销的高效率、低成本、大影响。可以按两种意思来理解：网络整合营销是利用网络 技术和网络特性最大化、最快速、最有效、最精准的进行整合营销；网络整合营销是以为客户提供有价值的信息为基础，由客户创造、传播为主导的整合营销理念进 行的网络营销。</p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;">&nbsp;</p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;"><span style="padding: 0px; margin: 0px; font-size: 14px;">目前品牌在推广上遇到什么问题？</span></p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;">作为品牌主，你是否有这样的困惑？<br style="padding: 0px; margin: 0px;"/>● 很早就有了互联网品牌网站，可是却不知如何利用，网络也没有给你创造任何经济效益！<br style="padding: 0px; margin: 0px;"/>● 希望通过网络推广获得效益，但面对市场上纷繁复杂、层出不穷的网络推广概念和方式让人眼花缭乱，却无从下手！<br style="padding: 0px; margin: 0px;"/>● 花了很多钱做网站推广，却没什么效果，也不知道问题出在哪里？<br style="padding: 0px; margin: 0px;"/>● 看到竞争对手迅速壮大，却不知道他们究竟如何利用好网络营销的秘诀？</p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; ">&nbsp;</p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; "><span style="padding: 0px; margin: 0px; font-size: 14px;">是怎么做的？</span></p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal;">当我们的客户确定需要进行数字营销传播时，我们将提供以下服务：<br style="padding: 0px; margin: 0px;"/>营销型网站建设，网络调研，搜索引擎营销(SEO和SEM)，软文营销(博客营销、论坛营销、SNS营销、新闻营销、许可邮件营销)，口碑互动营销(圈子 营销、社区营销、博客营销)，群营销(网络广告、论坛营销、SNS营销、IM和QQ群营销)。将以上传播进行有机的整合营销推广，制定传播营销方案。</p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; ">一、提供推广资料和目标，提供报价。<br style="padding: 0px; margin: 0px;"/>二、提供营销型网站方案。<br style="padding: 0px; margin: 0px;"/>三、确定传播关键字。<br style="padding: 0px; margin: 0px;"/>四、确定搜索引擎营销策略，进行关键词甩选。<br style="padding: 0px; margin: 0px;"/>五、进行后台数据分析，确定网络广告文案。<br style="padding: 0px; margin: 0px;"/>六、制定病毒式营销计划，确定博客营销、论坛营销、SNS营销载体。<br style="padding: 0px; margin: 0px;"/>七、确定新闻营销、博客营销、论坛营销的整体方案。<br style="padding: 0px; margin: 0px;"/>八、制定网络整合营销传播计划。<br style="padding: 0px; margin: 0px;"/>九、效果评估。<br style="padding: 0px; margin: 0px;"/>十、提供传播报告。</p><p><br/></p>', 'h,', NULL, '/53/134\index.html', '营销型网站建设', '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('177', 'MS', '<p style="box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px; "><span style="box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;">MCMS是企业创立初期很好的基础框架，不仅可以实现和现有系统的对接而且有大量的插件模版可以使用。</span></p><p style="box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px;"><span style="box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;">MS平台开发团队承诺MCMS内容管理系统永久完整开源免费(这真是极好的)！下面就简单的给大家介绍一下MS平台和MCMS为什么如此之快。</span></p><p style="box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px;"><span style="box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;">MS平台是铭飞团队经过多年的研发，最终以MCMS为基础，集商城、论坛、分期、会员、支付、积分、微信等系统于一体的插件式系统。并实现了淘宝、京东、苏宁、国美等第三方电商平台数据接口的统一。平台中的小插件如：邮件推送、短信接口、定时任务、促销活动、数据采集等非常丰富。</span></p><p style="box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px;"><span style="box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;">MCMS的模版采用标签式开发，上手非常快。</span></p><p style="box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px;"><span style="box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;">对于技术小白来说不仅避开了学习复杂的高级开发语言,而且MStore有大量成熟的模版直接下载之后换换图片和内容就可以使用,要是需要调整只需要写简单的标签就可以。</span></p><p style="box-sizing: border-box; margin-top: 8px; margin-bottom: 8px; font-size: 12.5px; color: rgb(51, 51, 51); line-height: 22.5px; white-space: normal; padding: 0px; letter-spacing: 0.5px; word-wrap: break-word; word-break: break-all; font-family: Verdana, sans-serif, 宋体; text-indent: 28px; "><span style="box-sizing: border-box; padding: 0px; margin: 0px; font-family: 微软雅黑; font-size: 14px;">对于前端工程师来说只需要写好页面样式并在页面内容部分套上标签，就可以做出一套优美的动态网站。并且还可以实现留言板、用户登录等数据交互功能。</span></p><p><br/></p>', 'h,', '来自火星的程序猿', '/59/70\177.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('183', NULL, '<p><img src="/upload/editor/1580/1461912560218.jpg" title="1461912560218.jpg" alt="1-1203302131502F.jpg"/><img src="/upload/editor/1580/1461912562754.jpg" title="1461912562754.jpg" alt="1-120330213210F7.jpg"/><img src="/upload/editor/1580/1461912555214.jpg" title="1461912555214.jpg" alt="1-12033021312C17.jpg"/></p>', NULL, NULL, '/52/136\index.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('185', NULL, '<p>联系电话：888888<br/></p><p>QQ：1391265900</p><p>邮箱：1391265900@qq.com</p><p>地址：来自火星的程序猿</p><p><br/></p>', NULL, NULL, '/19/141\index.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('190', NULL, NULL, NULL, NULL, '/19/142\index.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('182', NULL, '<p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);"><span style="padding: 0px; margin: 0px; font-size: 14px;">网络营销是以互联网络为基础，通过数字化的信息和网络媒体的交互性来辅助营销目标实现的一种新型的市场营销方式。</span></p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);">&nbsp;</p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);"><span style="padding: 0px; margin: 0px; font-size: 14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 据统计，在国外，80%的个人和企业都选择网络媒介进行营销推广，并从中获得了极好的效果。而在中国，选择网络营销的企业和个人只有7-8%，不到国外的十分之一。</span></p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);">&nbsp;</p><p style="padding: 0px; margin-top: 0px; margin-bottom: 0px; line-height: 24px; color: rgb(68, 68, 68); font-family: Verdana, Arial, Tahoma; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);"><span style="padding: 0px; margin: 0px; font-size: 14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 随着网络影响的进一步扩大，随着人们对于网络营销理解的进一步加深，以及越来越多出现的网络营销推广的成功案例，人们已经开始意识到网络营销的诸多优点，越来越多的企业和个人通过网络进行营销推广</span></p><p><br/></p>', NULL, NULL, '/52\index.html', '网络营销是以互联网络为基础', '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('191', '铭飞', '<p><span style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;">日前，公司成功中标杭州市民中心G楼约18000多平方米四层公共区域装饰工程，这是继杭州钱江新城国际会议中心之后的又一城市标志性建筑工程。</span><br style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px; white-space: normal;"/><span style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;">在该项目施工过程中，公司始终将“绿色装饰”理念融入其中。“绿色装饰”是指在设计、装修选材、施工等整个过程都符合绿色环保的理念，把对环 境造成的危害降低到最小，让市民享受到真正的绿色生活。随着社会的不断发展，“绿色装饰”日趋成为广大建筑装饰企业努力的方向。</span><br style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px; white-space: normal;"/><span style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;">公司项目部在杭州市民中心G楼工程中，严格按照健康、环保、安全的施工标准，精心施工，力争达到“浙江省建筑安全文明标化工地”的要求。在原 材料的选用上精挑细选，大量运用了玻璃、大理石材等绿色环保和高品质的装饰材料，突显出了简约、明快、自然的设计风格，创造出宽阔、绿色、实用的公共空 间。</span><br style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px; white-space: normal;"/><span style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;">此外项目部还非常注重采取新工艺、新方法，不仅提高了工程的整体美观性和实用性，而且加快了施工进度，提升了工作效率。由于本工程是圆型结构的楼层施 工，特别是石材在圆弧和圆柱造型上用量大，大大增加了工程的施工难度。因此，项目部按工程施工位置的不同分别采用了石材干挂施工工艺和石材湿贴与灌浆施工 工艺。通过这两种施工工艺铺出来的石材平整、洁净、色泽一致，无裂痕和缺损，既美观又方便今后日常护理。</span><br style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px; white-space: normal;"/><span style="color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; line-height: 24px;">作为杭州市重点工程，杭州市民中心G楼公共区域装饰工程得到了公司领导的高度重视。总经理高利明亲自坐镇指挥，组建了一支强有力的项目领导管 理班子，采用矩阵式组织管理体系，即采取以项目经理为第一责任人，分解项目绿色施工指标，形成完善的绿色施工组织、责任体系，在保证质量、安全等基本要求 的前提下，通过科学管理和技术进步，最大限度地节约资源与减少对环境负面影响，实现四位一体的绿色环保施工，打造“绿色装饰”精品工程。</span></p>', 'h,', '铭飞', '/62/84\191.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('192', '铭飞', '<p><span style="color: rgb(51, 51, 51); font-family: 微软雅黑, Arial; line-height: 34px; background-color: rgb(255, 255, 255);">对于时尚达人而言，包袋与衣服的混搭也是一种必杀技。休闲手提包可以搭配不同的造型，而搭配运动裤就是更加直接地表现出时尚休闲风的最佳配搭方案。 宽松舒适的运动裤相信是不少男士最爱，但却很难搭出时尚感，更一不小心就给人过于随便的印象。而手提包在款式、颜色、材质及图案方面层出不穷，再搭配不同款式的运动裤，打造半运动化的时装搭配，让运动休闲和时尚文化完美结合，塑造出运动感的摩登简约风，让整体穿着随意且舒适。</span></p>', 'p,', '铭飞', '/62/84\192.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('193', '铭飞', '<p>市委副书记、市长宋朝华率队前往贵州省贵阳市，实地考察由中铁贵旅公司投资开发建设的中铁国际生态城项目，并与公司高层进行了深入友好座谈，洽谈推进重大项目落户我市仁寿县相关事宜。</p><p>&nbsp;</p><p>中国中铁旗下子公司——中铁贵旅公司开发建设的中铁国际生态城项目位于贵阳市龙洞堡空港经济区，总投资500亿元，占地面积约20平方公里，打造集旅游、休闲、度假、运动、文化、养老、养生和居住等多种功能于一体的世界级旅游度假目的地，2011年被列为“贵州省十二五旅游发展规划十大旅游项目”之一，是贵州省的重点项目。在中铁贵旅公司董事长张敏的陪同下，宋朝华一行参观考察了中铁国际生态城展示中心、中铁国际生态旅游城市综合体项目、安纳塔拉度假酒店和巫山香杏小镇等旅游开发项目，认真听取了项目规划建设有关情况介绍，对中铁国际生态城项目规划理念新、设计水平高、推进速度快表示由衷赞赏，对中铁贵旅公司有意来我市仁寿县投资发展表示热烈欢迎。</p><p>&nbsp;</p><p>座谈会上，双方就推进项目落户事宜进行了深入友好会谈。宋朝华指出，中铁贵旅公司实力强、品牌响、理念新，对公司投资开发黑龙滩休闲旅游度假中心项目充满信心。通过深入考察和友好洽谈，双方就项目投资有关事宜达成了共识，并将于近期正式签署合作协议。张敏表示，天府眉山交通区位优越，旅游资源独特，发展潜力巨大，集团拟投资200亿元以上开发建设黑龙滩旅游项目。该项目将按照国际化水准，坚持以游为主、高举高打，紧紧围绕“吃、住、行、游、购、娱”六要素，走产业高端、高端产业的路线，全力打造5a级景区，为发展旅游产业和造福眉山人民作出央企应有的贡献。</p><p><br/></p>', NULL, '铭飞', '/62/84\193.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('194', '铭飞', '<p>森和汽车城，位于广州市天河北路，是一家高端品牌汽车的城市综合展厅，本来是全方位展示豪华新车的地方。上周，突然在门口拉上了横幅——东阳红木清货大甩卖。记者于日前一探，吓了一跳。门口的广场上停着几辆大货车，不断有红木家具被抬出来打包装车。走进去视觉更混乱，当庭摆着一套五件鹿角椅，旁边是满雕龙的金丝楠木顶箱柜，内庭中央还展示着一辆豪华轿车，而周边则摆满红木家具，完全没有红木家具应该有的意境。更令人瞠目结舌的是，里面人流熙熙攘攘，整个场景可以让你直接穿越到上世纪八十年代中期一个小县城的展销会。</p><p>&nbsp;</p><p>　　“销售情况非常可观，首日已经突破100万元销售，周末差不多也是这个数。”东阳红木销售负责人穆延东告诉记者，这次的清货周四开始，周日结束，下周同样如此，中间的时间会对产品进行调整，再销售一次就结束了。记者在店内粗略看了一下，产品以清式家具为主，材质则以金丝楠木、微凹黄檀、缅甸花梨、南美酸枝、东南亚酸枝为主，大红酸枝和明式风格的产品不多，就连在今年APEC上出现的大红酸枝交椅的完整复刻版，也随便被摆在了角落。从做工和风格以及雕刻工艺来看，这些货物并非出自一家工厂。“此次清货的红木家具，来自东阳红木家具六家工厂，这些货基本是这些厂家去年接的订单直接生产的，但今年有很多客户取消了订单，加上市场环境变化，代理商出货也很慢。工厂不像经销商，可以囤货，它必须保持周转，否则就得停工待产坐以待毙。所以几家厂子就联合起来，将厂里现有的产品变现，自谋生路。”穆延东告诉记者，他们在北京、上海也有此类清货会，销售情况都不错，相对而言，广州的销售情况不如北京、上海。“可能是产品材质的问题，微凹黄檀和缅甸花梨的产品比较畅销，但南美酸枝和东南亚酸枝的产品不太被认可。有很多消费者直接询问有没有大红酸枝的产品，也有很多消费者询问有没有明式风格的产品。”他透露，下周销售的产品将会进行调整，还是针对普通消费者，以老挝大红酸枝(交趾黄檀)、缅甸花梨的材质为主，增加明式风格家具的品类，但还是以清式风格为主。</p><p><br/></p>', NULL, '铭飞', '/62/83\194.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('195', '铭飞', '<p>海南黄花梨圆包脚罗汉床、小叶紫檀云龙纹镶理石圆桌、富贵满堂多宝阁……昨日（12月13日）上午，第三届中国（江门）传统家具精品鉴赏会暨2014中国（江门）红木家具经销大会在五邑华侨广场会展中心正式开幕，众多国宝级古典家具作品以及海南黄花梨等珍贵木材亮相。</p><p>&nbsp;</p><p>　　此次活动由江门市古典家具行业协会主办，江门市新会区古典家具行业协会、台山市大江古典家具商会共同协办，会期为12月13日至16日，有来自我市新会、台山的50家代表性企业参展，云集了20多个省市经销商、行业精英，这是我市古典家具行业促进交流合作，展示广作精品，推广“江门红木”的重要平台。</p><p>&nbsp;</p><p>　　出席展会开幕式的有关嘉宾有：中国家具协会副理事长、传统家具专业委员会主席团常设主席陈宝光，故宫博物院常务副院长、故宫博物院研究员王亚民，中国家具协会传统家具专业委员会主席、江门市古典家具行业协会会长伍炳亮，省家具协会会长王克，省工艺美术协会会长舒海波等。</p><p>&nbsp;</p><p>　　我市是红木广作工艺的发源地之一，也是全国红木家具重要的生产基地，拥有深厚的文化和精妙的技艺，人才云集。借助这次展会，伍炳亮认为，一方面，“将有利于增加广大爱好者对传统家具的了解，在提升自己的审美观和鉴赏力，领略艺术魅力的同时，享受艺术带来的美好生活”；另一方面，这将成为我市对外展示的窗口，“展示我市优秀传统家具作品和设计，引领当代仿古家具健康发展”。</p><p>&nbsp;</p><p>　　王亚民在致辞中说：“江门在传统家具制作方面有很长的历史，涌现出了一批家具行业的企业家，对传统家具的继承创新与发展都做出了自己的探索和非常令人鼓舞的成就，在全国形成影响。”</p><p>&nbsp;</p><p>　　陈宝光则希望：“江门红木家具企业能够借这次展会，进一步推动行业良性发展，为全国红木家具发展作出贡献。”</p><p><br/></p>', 'f,', '铭飞', '/62/83\195.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('196', '铭飞', '<p>有人说，成都，是一个让人来了就不想离开的地方，是一座悠远的文化名城，它用睿智和远见，让每一个人共享一座城市的幸福，因此被评为“最具幸福感的城市”。</p><p>&nbsp;</p><p>那么，当中国国粹文化的传承者、追求幸福感的红木家具知名品牌——东莞市弘开实业有限公司（以下简称戴为红木）与成都邂逅，必能为广大成都市民增添更多新的幸福感。<br/><br/></p><p>近期，出于对中国传统文化的热爱，以及对红木艺术的执着、深情和追求，戴为红木携带“幸福之家”主题活动礼遇成都，使其鸿儒红木家居艺术馆隆重开业，为已进入寒冬的成都燃起了一把火，掀起了中式红木家具热潮！</p><p>&nbsp;</p><p>据了解，戴为红木成都鸿儒红木家居艺术馆在锦江区三色路，展馆面积达500多平方米。艺术馆整体宏伟大气，装修精致，馆内的精品极富特色设计，尤其是第四层展示了戴为红木的代表性设计风格，不仅拥有宁静致远的品茶茶室，静心悟道之香道品香室，古色古香的贵宾区，休闲娱乐之棋牌室等高端居室，而且居室采用了鸿儒家居VIP会员制度。这意味着，在这里，不仅可以享受国粹文化的熏陶，还能尊享贵宾待遇的幸福感。</p><p><br/></p>', 'h,', '铭飞', '/62/83\196.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('197', '铭飞', '<p>今年以来，质检总局执法督查司按照网上发现、源头追溯、落地查处的要求，组织开展电子商务产品专项执法打假活动，积极构建适应电子商务执法打假的全国执法协查工作机制，推动属地查处工作的开展，全国共查处电商产品质量违法案件400余件。</p><p>2014年6月，江苏省淮安市质监局根据总局执法司统一部署，对江苏杰翔羽绒有限公司进行了执法检查。经查，该公司涉嫌生产并通过“天猫商城”和“京东商城”等电子商务平台销售以假充真蚕丝被。目前，江苏省淮安市淮安质监局已对该案立案查处。</p><p><br/></p>', NULL, '铭飞', '/62/83\197.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('198', '铭飞', '<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Arial; line-height: 34px; white-space: normal; background-color: rgb(255, 255, 255);">巴黎时装周许晴倾力助阵，当天许晴身着黑色拼接装头排看秀，大秀美腿，加上干净利落的妆容，整体造型简洁率性，绿色的刺绣手包更添俏皮，银色的尖头高跟鞋成点睛之笔，许晴此次看秀的装扮可谓彰显了至纯至简主义。</p><p style="margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, Arial; line-height: 34px; white-space: normal; background-color: rgb(255, 255, 255);">对于此次的装扮许晴表示：“这次的服装都是看似简单其实细节之处非常打动我，像这件是硬朗的皮质与柔软的丝绵材质的拼接，好比是一刚一柔，代表女子都有柔软和刚强的两面，刚柔并济。”许晴和MirandaKerr在头牌看秀时不时凑在一起交流，时而发出会心微笑时而一起鼓掌，成为现场最闪耀的亮点，很多时尚博主达人都纷纷夸赞二人拥有最甜美的笑脸。</p><p><br/></p>', NULL, '铭飞', '/62/83\198.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('199', '铭飞', '<p>市委副书记、市长宋朝华率队前往贵州省贵阳市，实地考察由中铁贵旅公司投资开发建设的中铁国际生态城项目，并与公司高层进行了深入友好座谈，洽谈推进重大项目落户我市仁寿县相关事宜。</p><p>&nbsp;</p><p>中国中铁旗下子公司——中铁贵旅公司开发建设的中铁国际生态城项目位于贵阳市龙洞堡空港经济区，总投资500亿元，占地面积约20平方公里，打造集旅游、休闲、度假、运动、文化、养老、养生和居住等多种功能于一体的世界级旅游度假目的地，2011年被列为“贵州省十二五旅游发展规划十大旅游项目”之一，是贵州省的重点项目。在中铁贵旅公司董事长张敏的陪同下，宋朝华一行参观考察了中铁国际生态城展示中心、中铁国际生态旅游城市综合体项目、安纳塔拉度假酒店和巫山香杏小镇等旅游开发项目，认真听取了项目规划建设有关情况介绍，对中铁国际生态城项目规划理念新、设计水平高、推进速度快表示由衷赞赏，对中铁贵旅公司有意来我市仁寿县投资发展表示热烈欢迎。</p><p>&nbsp;</p><p>座谈会上，双方就推进项目落户事宜进行了深入友好会谈。宋朝华指出，中铁贵旅公司实力强、品牌响、理念新，对公司投资开发黑龙滩休闲旅游度假中心项目充满信心。通过深入考察和友好洽谈，双方就项目投资有关事宜达成了共识，并将于近期正式签署合作协议。张敏表示，天府眉山交通区位优越，旅游资源独特，发展潜力巨大，集团拟投资200亿元以上开发建设黑龙滩旅游项目。该项目将按照国际化水准，坚持以游为主、高举高打，紧紧围绕“吃、住、行、游、购、娱”六要素，走产业高端、高端产业的路线，全力打造5a级景区，为发展旅游产业和造福眉山人民作出央企应有的贡献。</p><p><br/></p>', 'c,', '铭飞', '/62/83\199.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('200', 'MS', '<p>斯宾特系列(Sprinter)系列技术领先，动力强劲。座位数从10座到20座均可选择，跟据配置不同,价格也从95.8万——178万可以选择。为您带来不同的商务体验。下面为您带来的就是斯宾特A3-9座旗舰型，号称移动总裁办公室的豪华商务房车。</p><p>从看到斯宾特的第一眼，您就会喜欢上他，不仅仅因为他豪华大气的外观，更得益于梅赛德斯-奔驰精湛造车技艺的极致发挥和处处以人为本的至臻理念，时刻让您感受到其中极高的舒适和享受。车门电动滑动装置，配合智能化遥控车钥匙开启，您可以轻而易举的开合车门，体现无微不至的尊荣享受。尽显豪华大气本色！</p><p><br/>后轮双胎配置使车身的承载能力更加强大，更加稳定、安全。奔驰商务车秉承了梅赛德斯-奔驰品牌百年的造车传统，奔驰商务车中斯宾特以豪华大气的外观、卓尔不凡的品质、坚实可靠的性能，再一次演绎了梅赛德斯-奔驰对至善臻美的不懈追求。新一代梅赛德斯-奔驰商务车斯宾特技术更上一层楼，为高级商务车行业树立新标杆。外观造型气度恢弘、浑然天成；细节设计周密严谨、精益求精。梅赛德斯-奔驰造车专家独运匠心，精心打造，为客户带来具有更大空间、更强动力和更高安全保障的斯宾特。</p><p>&nbsp;</p><p>车内中控隔屏、BOSE顶级KTV系统及酒柜吧台。高大的车身设计带来无与伦比的车内空间，车内净高1.98米。这使您进出车仓无需弯腰低头，也喻示着此车的拥有者在生意场上的强势，无需向任何人低头。车内后仓配备阿尔卑斯小牛皮手工订制的豪华航空座椅，尽显商务头等仓本色，两个可以360度旋转的座椅和侧置沙发可以让车内座椅布局自由组合。带来超乎想像的谈判空间！</p><p><br/>隔屏上集成了一台来自三星的40英寸3D液晶电视，配合卫星电视接收器可以接收国内100多个电视频道，DVD庭影院系统也可以播放高清视频。让您在旅途中不再无聊。来自瑞士的水晶杯在酒柜的LED灯光照射下晶莹剔透，更显皇家风范。</p><p><br/></p>', 'p,', '来自火星的程序猿', '/106/107\200.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('201', 'MS', '<p><span style="color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);">其实商务车在人们眼里就是普通的客车，没有人会花时间去研究它，欣赏它。商务车给人的印象，就是整体的一箱车，发动机不是在驾驶与副驾驶的座椅下边，就是在车子的后面。没有前发动机舱，很少有人会把普通的商务车与“霸气”这个词汇文明发言在一起。而作为一款纯正的“美国”商务车，GMC3500完全打破中国人传统意识里的对商务车的形象。&nbsp;</span></p>', NULL, '来自火星的程序猿', '/106/107\201.html', NULL, '0', '1');
INSERT INTO "CMS_ARTICLE" VALUES ('202', 'MS', '<p><span style="color: rgb(102, 102, 102); font-family: &#39;Microsoft Yahei&#39;, Verdana, Geneva, sans-serif; font-size: 14px; line-height: 25px; background-color: rgb(255, 255, 255);">对于这样一款外观霸气，承载性高的原装进口商务车和它实在的销售价格，都让这款车的性价比大大提升了不少。对于市场上一些追求个性的客户群来讲，GMC3500恰恰就是一款能够让他们体现出个性化的座驾，留有足够改装想象和个性发展的空间，体验生活品味，从GMC开始。新款GMC Savana 3500 舒适版商务车是您一个很不错的选择。</span></p>', NULL, '来自火星的程序猿', '/106/107\202.html', NULL, '0', '1');

-- ----------------------------
-- Table structure for CMS_CLASS_50
-- ----------------------------
DROP TABLE "CMS_CLASS_50";
CREATE TABLE "CMS_CLASS_50" (
  "BASICID" NUMBER(11) NOT NULL ,
  "SCHOOL" NVARCHAR2(220) ,
  "PLATFORM" NVARCHAR2(220) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of "CMS_CLASS_50"
-- ----------------------------
INSERT INTO "CMS_CLASS_50" VALUES ('2', '1', '2');
INSERT INTO "CMS_CLASS_50" VALUES ('3', '3', '2');
INSERT INTO "CMS_CLASS_50" VALUES ('4', '1', '4');
INSERT INTO "CMS_CLASS_50" VALUES ('5', '2', '1');
INSERT INTO "CMS_CLASS_50" VALUES ('6', '2', '1');
INSERT INTO "CMS_CLASS_50" VALUES ('7', '1', '1');

-- ----------------------------
-- Table structure for COMMENT
-- ----------------------------
DROP TABLE "COMMENT";
CREATE TABLE "COMMENT" (
  "COMMENT_ID" NUMBER(11) NOT NULL ,
  "COMMENT_COMMENTID" NUMBER(11) NOT NULL ,
  "COMMENT_CONTENT" NCLOB ,
  "COMMENT_PICTURE" NVARCHAR2(300) ,
  "COMMENT_TIME" DATE NOT NULL ,
  "COMMENT_TYPE" NUMBER(11) DEFAULT 2  NOT NULL ,
  "COMMENT_PEOPLEID" NUMBER(11) DEFAULT 0  ,
  "COMMENT_POINTS" NUMBER(11) DEFAULT 0  ,
  "COMMENT_BASICID" NUMBER(11) NOT NULL ,
  "COMMENT_APPID" NUMBER(11) ,
  "COMMENT_FILE_NAME" NVARCHAR2(255) ,
  "COMMENT_FILE_PATH" NVARCHAR2(255) ,
  "COMMENT_IS_ANONYMOUS" NUMBER(11) DEFAULT 0  ,
  "COMMENT_AUDIT" NUMBER(11) DEFAULT 0  
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "COMMENT"."COMMENT_ID" IS '评论id（主键）';
COMMENT ON COLUMN "COMMENT"."COMMENT_COMMENTID" IS '父评论id';
COMMENT ON COLUMN "COMMENT"."COMMENT_CONTENT" IS '评论的内容';
COMMENT ON COLUMN "COMMENT"."COMMENT_PICTURE" IS '评论时发布的图片，可上传多张图片';
COMMENT ON COLUMN "COMMENT"."COMMENT_TIME" IS '评论时间';
COMMENT ON COLUMN "COMMENT"."COMMENT_TYPE" IS '评论的类型：1 匿名，2 公开，默认为公开';
COMMENT ON COLUMN "COMMENT"."COMMENT_PEOPLEID" IS '评论者id，默认为非会员用户（即游客）';
COMMENT ON COLUMN "COMMENT"."COMMENT_POINTS" IS '评价打分（-1至5分）';
COMMENT ON COLUMN "COMMENT"."COMMENT_BASICID" IS '（文章、商品...）绑定basicid（外键）';
COMMENT ON COLUMN "COMMENT"."COMMENT_APPID" IS '(文章、商品）绑定的应用编号';
COMMENT ON COLUMN "COMMENT"."COMMENT_FILE_NAME" IS '附件文件名称';
COMMENT ON COLUMN "COMMENT"."COMMENT_FILE_PATH" IS '附件文件路径';
COMMENT ON COLUMN "COMMENT"."COMMENT_IS_ANONYMOUS" IS '是否匿名';
COMMENT ON COLUMN "COMMENT"."COMMENT_AUDIT" IS '0默认显示 1:审核不通过';
COMMENT ON TABLE "COMMENT" IS '评论表';

-- ----------------------------
-- Table structure for MANAGER
-- ----------------------------
DROP TABLE "MANAGER";
CREATE TABLE "MANAGER" (
  "MANAGER_ID" NUMBER(11) NOT NULL ,
  "MANAGER_NAME" NVARCHAR2(15) ,
  "MANAGER_NICKNAME" NVARCHAR2(15) ,
  "MANAGER_PASSWORD" NVARCHAR2(45) ,
  "MANAGER_ROLEID" NUMBER(11) ,
  "MANAGER_PEOPLEID" NUMBER(20) DEFAULT 0  ,
  "MANAGER_TIME" DATE 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MANAGER"."MANAGER_ID" IS '管理员id(主键)';
COMMENT ON COLUMN "MANAGER"."MANAGER_NAME" IS '管理员用户名';
COMMENT ON COLUMN "MANAGER"."MANAGER_NICKNAME" IS '管理员昵称';
COMMENT ON COLUMN "MANAGER"."MANAGER_PASSWORD" IS '管理员密码';
COMMENT ON COLUMN "MANAGER"."MANAGER_ROLEID" IS '角色编号';
COMMENT ON COLUMN "MANAGER"."MANAGER_PEOPLEID" IS '用户编号即商家编号';
COMMENT ON COLUMN "MANAGER"."MANAGER_TIME" IS '管理员创建时间';
COMMENT ON TABLE "MANAGER" IS '管理员表';

-- ----------------------------
-- Records of "MANAGER"
-- ----------------------------
INSERT INTO "MANAGER" VALUES ('50', 'msopen', 'msopen', '9d8622060de5f24937b60585c3f4d66b', '48', '0', TO_DATE('2015-09-18 11:54:36', 'SYYYY-MM-DD HH24:MI:SS'));

-- ----------------------------
-- Table structure for MANAGER_MODEL_PAGE
-- ----------------------------
DROP TABLE "MANAGER_MODEL_PAGE";
CREATE TABLE "MANAGER_MODEL_PAGE" (
  "MMP_MANAGER_ID" NUMBER(11) ,
  "MMP_MODEL_ID" NUMBER(11) ,
  "MMP_URL" NVARCHAR2(255) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MANAGER_MODEL_PAGE"."MMP_MANAGER_ID" IS '自增长id';
COMMENT ON COLUMN "MANAGER_MODEL_PAGE"."MMP_MODEL_ID" IS '模块编号';
COMMENT ON COLUMN "MANAGER_MODEL_PAGE"."MMP_URL" IS '默认后台显示的主界面';
COMMENT ON TABLE "MANAGER_MODEL_PAGE" IS '管理员对应的每个模块的主界面自定义';

-- ----------------------------
-- Table structure for MDIY_CONTENT_MODEL
-- ----------------------------
DROP TABLE "MDIY_CONTENT_MODEL";
CREATE TABLE "MDIY_CONTENT_MODEL" (
  "CM_ID" NUMBER(11) NOT NULL ,
  "CM_TIPS_NAME" NVARCHAR2(30) NOT NULL ,
  "CM_TABLE_NAME" NVARCHAR2(20) NOT NULL ,
  "CM_MODEL_ID" NUMBER(11) ,
  "CM_APP_ID" NUMBER(11) ,
  "CREATE_BY" NUMBER(11) ,
  "CREAET_DATE" DATE ,
  "UPDATE_BY" NUMBER(11) ,
  "UPDATE_DATE" DATE 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MDIY_CONTENT_MODEL"."CM_ID" IS '自增长id';
COMMENT ON COLUMN "MDIY_CONTENT_MODEL"."CM_TIPS_NAME" IS '表单提示文字';
COMMENT ON COLUMN "MDIY_CONTENT_MODEL"."CM_TABLE_NAME" IS '表单名称';
COMMENT ON COLUMN "MDIY_CONTENT_MODEL"."CM_MODEL_ID" IS '模块编号';
COMMENT ON COLUMN "MDIY_CONTENT_MODEL"."CM_APP_ID" IS '应用编号';
COMMENT ON TABLE "MDIY_CONTENT_MODEL" IS '自定义模型表';

-- ----------------------------
-- Records of "MDIY_CONTENT_MODEL"
-- ----------------------------
INSERT INTO "MDIY_CONTENT_MODEL" VALUES ('1', '茶叶', 'mdiy_tea_2', '0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "MDIY_CONTENT_MODEL" VALUES ('2', '商品品牌', 'mdiy_brand_2', '0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "MDIY_CONTENT_MODEL" VALUES ('3', '自定义', 'mdiy_mooc_50', '0', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MDIY_CONTENT_MODE_FIELD
-- ----------------------------
DROP TABLE "MDIY_CONTENT_MODE_FIELD";
CREATE TABLE "MDIY_CONTENT_MODE_FIELD" (
  "FIELD_ID" NUMBER(11) NOT NULL ,
  "FIELD_TIPSNAME" NVARCHAR2(30) ,
  "FIELD_FIELDNAME" NVARCHAR2(20) ,
  "FIELD_TYPE" NUMBER(11) ,
  "FIELD_DEFAULT" NVARCHAR2(250) ,
  "FIELD_ISNULL" NUMBER(11) ,
  "FIELD_CMID" NUMBER(11) ,
  "FIELD_SORT" NUMBER(11) ,
  "FIELD_ISSEARCH" NUMBER(11) ,
  "FIELD_LENGTH" NUMBER(11) ,
  "CREATE_BY" NUMBER(11) ,
  "CREATE_DATE" DATE ,
  "UPDATE_BY" NUMBER(11) ,
  "UPDATE_DATE" DATE ,
  "DEL" NUMBER(11) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_ID" IS '字段自增长id';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_TIPSNAME" IS '字段提示文字';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_FIELDNAME" IS '字段名称';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_TYPE" IS '字段类型（如1.单行，2.多行，3.图片，等）';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_DEFAULT" IS '字段默认值';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_ISNULL" IS '字段是否为空 0:必填 1:可选';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_CMID" IS '关联内容模型表id';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_SORT" IS '字段排序';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_ISSEARCH" IS '字段是否支持后台搜索0：不支持，1：支持';
COMMENT ON COLUMN "MDIY_CONTENT_MODE_FIELD"."FIELD_LENGTH" IS '字段长度';
COMMENT ON TABLE "MDIY_CONTENT_MODE_FIELD" IS '自定义内容模型关联字段表';

-- ----------------------------
-- Records of "MDIY_CONTENT_MODE_FIELD"
-- ----------------------------
INSERT INTO "MDIY_CONTENT_MODE_FIELD" VALUES ('5', '产品参数', 'detail', '2', NULL, '1', '1', NULL, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "MDIY_CONTENT_MODE_FIELD" VALUES ('6', '商品栏目ID', 'BI', '1', NULL, '1', '2', NULL, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "MDIY_CONTENT_MODE_FIELD" VALUES ('8', '描述1', 'descripone', '2', NULL, '1', '3', NULL, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "MDIY_CONTENT_MODE_FIELD" VALUES ('9', '描述2', 'descriptwo', '2', NULL, '1', '3', NULL, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "MDIY_CONTENT_MODE_FIELD" VALUES ('10', '描述3', 'descripTh', '2', NULL, '1', '3', NULL, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "MDIY_CONTENT_MODE_FIELD" VALUES ('11', '描述4', 'descripFo', '2', NULL, '1', '3', NULL, '0', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "MDIY_CONTENT_MODE_FIELD" VALUES ('12', '描述5', 'descripFi', '2', NULL, '1', '3', NULL, '0', '1', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for MDIY_DICT
-- ----------------------------
DROP TABLE "MDIY_DICT"; 
CREATE TABLE "MDIY_DICT" (
  "DICT_ID" NUMBER(11) NOT NULL ,
  "APP_ID" NUMBER(11) ,
  "DICT_VALUE" NVARCHAR2(100) NOT NULL ,
  "DICT_LABEL" NVARCHAR2(100) NOT NULL ,
  "DICT_TYPE" NVARCHAR2(100) NOT NULL ,
  "DICT_DESCRIPTION" NVARCHAR2(100) ,
  "DICT_SORT" NUMBER(11) DEFAULT 0  NOT NULL ,
  "DICT_PARENT_ID" NVARCHAR2(64) ,
  "DICT_REMARKS" NVARCHAR2(255) ,
  "CREATE_BY" NUMBER(11) DEFAULT 0  ,
  "CREATE_DATE" DATE ,
  "UPDATE_BY" NUMBER(11) DEFAULT 0  ,
  "UPDATE_DATE" DATE ,
  "DEL" NUMBER(11) DEFAULT 0  NOT NULL 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MDIY_DICT"."DICT_ID" IS '编号';
COMMENT ON COLUMN "MDIY_DICT"."APP_ID" IS '应用编号';
COMMENT ON COLUMN "MDIY_DICT"."DICT_VALUE" IS '数据值';
COMMENT ON COLUMN "MDIY_DICT"."DICT_LABEL" IS '标签名';
COMMENT ON COLUMN "MDIY_DICT"."DICT_TYPE" IS '类型';
COMMENT ON COLUMN "MDIY_DICT"."DICT_DESCRIPTION" IS '描述';
COMMENT ON COLUMN "MDIY_DICT"."DICT_SORT" IS '排序（升序）';
COMMENT ON COLUMN "MDIY_DICT"."DICT_PARENT_ID" IS '父级编号';
COMMENT ON COLUMN "MDIY_DICT"."DICT_REMARKS" IS '备注信息';
COMMENT ON COLUMN "MDIY_DICT"."CREATE_BY" IS '创建者';
COMMENT ON COLUMN "MDIY_DICT"."CREATE_DATE" IS '创建时间';
COMMENT ON COLUMN "MDIY_DICT"."UPDATE_BY" IS '更新者';
COMMENT ON COLUMN "MDIY_DICT"."UPDATE_DATE" IS '更新时间';
COMMENT ON COLUMN "MDIY_DICT"."DEL" IS '删除标记';
COMMENT ON TABLE "MDIY_DICT" IS '字典表';

INSERT INTO "MDIY_DICT" VALUES ('1', '1', 'p', '图片', '文章属性', '图片', '1', NULL, NULL, '0', NULL, '0', NULL, '0');
INSERT INTO "MDIY_DICT" VALUES ('2', '1', 'h', '头条', '文章属性', '头条', '2', NULL, NULL, '0', NULL, '0', NULL, '0');
INSERT INTO "MDIY_DICT" VALUES ('3', '1', 'f', '幻灯', '文章属性', '幻灯', '3', NULL, NULL, '0', NULL, '0', NULL, '0');
INSERT INTO "MDIY_DICT" VALUES ('4', '1', 'c', '推荐', '文章属性', '推荐', '4', NULL, NULL, '0', NULL, '0', NULL, '0');


-- ----------------------------
-- Table structure for MDIY_FORM
-- ----------------------------
DROP TABLE "MDIY_FORM";
CREATE TABLE "MDIY_FORM" (
  "FORM_ID" NUMBER(11) NOT NULL ,
  "FORM_TIPS_NAME" NVARCHAR2(30) NOT NULL ,
  "FORM_TABLE_NAME" NVARCHAR2(30) ,
  "FORM_APP_ID" NUMBER(11) NOT NULL ,
  "CREATE_BY" NUMBER(11) ,
  "CREATE_DATE" DATE ,
  "UPDATE_BY" NUMBER(11) ,
  "UPDATE_DATE" DATE 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MDIY_FORM"."FORM_ID" IS '自增长id';
COMMENT ON COLUMN "MDIY_FORM"."FORM_TIPS_NAME" IS '自定义表单提示文字';
COMMENT ON COLUMN "MDIY_FORM"."FORM_APP_ID" IS '自定义表单关联的应用编号';
COMMENT ON TABLE "MDIY_FORM" IS '自定义表单表';

INSERT INTO MDIY_FORM VALUES ( '1', '留言', 'mdiy_message_50', '1', '0', TO_DATE('2018-06-29 17:37:13', 'SYYYY-MM-DD HH24:MI:SS'), '0', TO_DATE('2018-06-29 17:37:13', 'SYYYY-MM-DD HH24:MI:SS'));

-- ----------------------------
-- Table structure for MDIY_FORM_FIELD
-- ----------------------------
DROP TABLE "MDIY_FORM_FIELD";
CREATE TABLE "MDIY_FORM_FIELD" (
  "FF_ID" NUMBER(11) NOT NULL ,
  "FF_TIPSNAME" NVARCHAR2(30) ,
  "FF_FIELDNAME" NVARCHAR2(30) ,
  "FF_TYPE" NUMBER(11) ,
  "FF_DEFAULT" NVARCHAR2(250) ,
  "FF_ISNULL" NUMBER(11) ,
  "FF_SORT" NUMBER(11) ,
  "FF_FORMID" NUMBER(11) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MDIY_FORM_FIELD"."FF_ID" IS '字段自增长id';
COMMENT ON COLUMN "MDIY_FORM_FIELD"."FF_TIPSNAME" IS '字段提示文字';
COMMENT ON COLUMN "MDIY_FORM_FIELD"."FF_TYPE" IS '字段类型（如1.单行，2.多行，3.图片，等）';
COMMENT ON COLUMN "MDIY_FORM_FIELD"."FF_DEFAULT" IS '字段的默认值';
COMMENT ON COLUMN "MDIY_FORM_FIELD"."FF_ISNULL" IS '字段是否为空';
COMMENT ON COLUMN "MDIY_FORM_FIELD"."FF_SORT" IS '自定义表单的排序';
COMMENT ON COLUMN "MDIY_FORM_FIELD"."FF_FORMID" IS '字段管理的表单id';
COMMENT ON TABLE "MDIY_FORM_FIELD" IS '自定义表单字段表';

INSERT INTO MDIY_FORM_FIELD VALUES ('1', '姓名', 'NAME', '1', '', '1', '0', '1');
INSERT INTO MDIY_FORM_FIELD VALUES ('2', '手机号', 'PHONE', '1', '', '1', '0', '1');
INSERT INTO MDIY_FORM_FIELD VALUES ('3', '留言内容', 'CONTENT', '1', '', '1', '0', '1');

-- ----------------------------
-- Table structure for MDIY_MOOC_50
-- ----------------------------
DROP TABLE "MDIY_MOOC_50";
CREATE TABLE "MDIY_MOOC_50" (
  "BASICID" NUMBER(11) NOT NULL ,
  "IMAGES" NVARCHAR2(225) ,
  "DESCRIPONE" NVARCHAR2(225) ,
  "DESCRIPTWO" NVARCHAR2(225) ,
  "DESCRIPTH" NVARCHAR2(225) ,
  "DESCRIPFO" NVARCHAR2(225) ,
  "DESCRIPFI" NVARCHAR2(225) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of "MDIY_MOOC_50"
-- ----------------------------
INSERT INTO "MDIY_MOOC_50" VALUES ('52', '/upload/article/1638/1464835901016.jpeg|/upload/article/1638/1464835901049.jpg|/upload/article/1638/1464835901116.jpg|/upload/article/1638/1464835901184.jpeg', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？');
INSERT INTO "MDIY_MOOC_50" VALUES ('53', '/upload/article/1638/1464835910115.jpg|/upload/article/1638/1464835910168.jpg|/upload/article/1638/1464835910230.jpeg|/upload/article/1638/1464835910293.jpeg', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体');
INSERT INTO "MDIY_MOOC_50" VALUES ('54', '/upload/article/1638/1464836001681.jpg|/upload/article/1638/1464836001737.jpg|/upload/article/1638/1464836001790.jpeg|/upload/article/1638/1464836001868.jpg', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？');
INSERT INTO "MDIY_MOOC_50" VALUES ('55', '/upload/article/1638/1464835993804.jpg|/upload/article/1638/1464835993869.jpg|/upload/article/1638/1464835993934.jpeg|/upload/article/1638/1464835993997.jpeg', '想象一下走进一个狭小拥挤，遍地垃圾的商店。店员不停怂恿你买自己不想要的东西。在这种情况下，你肯定会马上转身离开去别家。如果有人给你压力，逼迫你在充满敌意的环境下快速做出抉择，你会自然而然的失去信任感。这一点也适用于网络。', '网上充满着向你推销各种服务和产品的人。用户要先信任你，才能考虑从你那购买产品或服务。下面列出了10个比较流行的让用户相信、信任你登陆页面的方法。你可以借鉴或者干脆照搬这些方法为你的网上业务建立起值得信赖的网站。', '每个来到你登陆页面的用户都会问同一个问题：你能给我带来什么好处？你需要让他们立刻看到你所能提供的价值。使用显眼的标题说明你所能提供的内容，以及你 与竞争对手的不同之处在哪。但是不要太过于强调你自己和你的公司，否则可能会让用户反感而离开。应当着重强调你如何满足用户的需求。', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体');
INSERT INTO "MDIY_MOOC_50" VALUES ('56', '/upload/article/1638/1464835975699.jpg|/upload/article/1638/1464835975757.jpg|/upload/article/1638/1464835975815.jpeg|/upload/article/1638/1464835975875.jpeg', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体');
INSERT INTO "MDIY_MOOC_50" VALUES ('57', '/upload/article/1638/1464835969386.jpg|/upload/article/1638/1464835969452.jpeg|/upload/article/1638/1464835969492.jpg|/upload/article/1638/1464835969559.jpg', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体');
INSERT INTO "MDIY_MOOC_50" VALUES ('58', '/upload/article/1638/1464835892002.jpg|/upload/article/1638/1464835892054.jpg|/upload/article/1638/1464835892116.jpeg|/upload/article/1638/1464835892179.jpg', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？');
INSERT INTO "MDIY_MOOC_50" VALUES ('59', '/upload/article/1638/1464835874500.jpg|/upload/article/1638/1464835874565.jpg|/upload/article/1638/1464835874617.jpeg|/upload/article/1638/1464835874678.jpg', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体');
INSERT INTO "MDIY_MOOC_50" VALUES ('60', '/upload/article/1638/1464835866478.jpg|/upload/article/1638/1464835866538.jpg|/upload/article/1638/1464835866582.jpeg|/upload/article/1638/1464835866640.jpeg', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？');
INSERT INTO "MDIY_MOOC_50" VALUES ('61', '/upload/article/1638/1464835988106.jpg|/upload/article/1638/1464835988154.jpg|/upload/article/1638/1464835988216.jpeg|/upload/article/1638/1464835988284.jpg', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？');
INSERT INTO "MDIY_MOOC_50" VALUES ('62', '/upload/article/1638/1464835856964.jpg|/upload/article/1638/1464835857006.jpg|/upload/article/1638/1464835857074.jpeg|/upload/article/1638/1464835857133.jpg', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体');
INSERT INTO "MDIY_MOOC_50" VALUES ('63', '/upload/article/1638/1464835842429.jpg|/upload/article/1638/1464835842841.jpeg|/upload/article/1638/1464835842898.jpg|/upload/article/1638/1464835842964.jpeg', '一幅好照片要把观众的注意力吸引到趣味中心&mdash;&mdash;被摄主体上。无论是拍什么 类型的照片，都会有一个主体你喜欢拍人物，拍生态，这些都不是问题，但是一旦主体被模糊，欣赏照片时就会忽略照片的主体', '这样的照片是不失败不完美的，因 为真正想让观众看的东西并没有一眼看到。例如婚纱照，主体肯定是人物新娘和新郎。如果目光都被新娘后面的景色吸引，而不是新娘，这肯定不会是我们想照的', '网页设计师的重要任务不是根据内容做出网页，而是根据用户需求设计出让用户喜欢并积极使用的网页，能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo', '有让用户点击或者传播的欲望？突出设计 的重点就如同突出摄影的被摄主体一样，把控视觉的重点，你的设计一定会非常精彩。', '能够让用户知道并去使用网站的新产品or关键点 or有价值的信息，那么如何突出这些点？如何让用户看到网页的&ldquo;G点&rdquo;，有让用户点击或者传播的欲望？');

-- ----------------------------
-- Table structure for MDIY_PAGE
-- ----------------------------
DROP TABLE "MDIY_PAGE";
CREATE TABLE "MDIY_PAGE" (
  "PAGE_ID" NUMBER(11) NOT NULL ,
  "PAGE_APP_ID" NUMBER(11) NOT NULL ,
  "PAGE_MODEL_ID" NUMBER(11) ,
  "PAGE_PATH" NVARCHAR2(255) ,
  "PAGE_TITLE" NVARCHAR2(255) ,
  "PAGE_KEY" NVARCHAR2(255) ,
  "CREATE_DATE" DATE 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MDIY_PAGE"."PAGE_ID" IS '自增长id';
COMMENT ON COLUMN "MDIY_PAGE"."PAGE_APP_ID" IS '应用id';
COMMENT ON COLUMN "MDIY_PAGE"."PAGE_MODEL_ID" IS '模块id';
COMMENT ON COLUMN "MDIY_PAGE"."PAGE_PATH" IS '自定义页面绑定模板的路径';
COMMENT ON COLUMN "MDIY_PAGE"."PAGE_TITLE" IS '自定义页面标题';
COMMENT ON COLUMN "MDIY_PAGE"."PAGE_KEY" IS '自定义页面访问路径';
COMMENT ON TABLE "MDIY_PAGE" IS '自定义页面表';

-- ----------------------------
-- Records of "MDIY_PAGE"
-- ----------------------------
INSERT INTO "MDIY_PAGE" VALUES ('1', '1', '0', 'people/register.htm', '注册', 'register', NULL);
INSERT INTO "MDIY_PAGE" VALUES ('2', '1', '0', 'people/login.htm', '登录', 'login', NULL);
INSERT INTO "MDIY_PAGE" VALUES ('3', '1', '0', 'people/center.htm', '个人中心', 'people/center', NULL);
INSERT INTO "MDIY_PAGE" VALUES ('4', '1', '0', 'people/change-passWord.htm', '修改密码', 'people/changePassWord', NULL);

-- ----------------------------
-- Table structure for MDIY_SEARCH
-- ----------------------------
DROP TABLE "MDIY_SEARCH";
CREATE TABLE "MDIY_SEARCH" (
  "SEARCH_ID" NUMBER(11) NOT NULL ,
  "SEARCH_NAME" NVARCHAR2(20) NOT NULL ,
  "SEARCH_TEMPLETS" NVARCHAR2(50) NOT NULL ,
  "SEARCH_APP_ID" NUMBER(11) NOT NULL ,
  "SEARCH_TYPE" NVARCHAR2(20) NOT NULL 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MDIY_SEARCH"."SEARCH_ID" IS '自增长id';
COMMENT ON COLUMN "MDIY_SEARCH"."SEARCH_NAME" IS '搜索名称';
COMMENT ON COLUMN "MDIY_SEARCH"."SEARCH_TEMPLETS" IS '搜索结果模版';
COMMENT ON COLUMN "MDIY_SEARCH"."SEARCH_APP_ID" IS '搜索管理的应用id';
COMMENT ON COLUMN "MDIY_SEARCH"."SEARCH_TYPE" IS '搜索类型';
COMMENT ON TABLE "MDIY_SEARCH" IS '自定义搜索表';

-- ----------------------------
-- Records of "MDIY_SEARCH"
-- ----------------------------
INSERT INTO "MDIY_SEARCH" VALUES ('1', '头部', 'search.htm', '1', 'cms');
INSERT INTO "MDIY_SEARCH" VALUES ('9', '列表页面搜索', 'search-list.htm', '1', 'cms');

-- ----------------------------
-- Table structure for MODEL
-- ----------------------------
DROP TABLE "MODEL";
CREATE TABLE "MODEL" (
  "MODEL_ID" NUMBER(11) NOT NULL ,
  "MODEL_TITLE" NVARCHAR2(150) ,
  "MODEL_CODE" NVARCHAR2(255) ,
  "MODEL_MODELID" NUMBER(11) ,
  "MODEL_URL" NVARCHAR2(255) ,
  "MODEL_DATETIME" DATE ,
  "MODEL_ICON" NVARCHAR2(120) ,
  "MODEL_MODELMANAGERID" NUMBER(11) ,
  "MODEL_SORT" NUMBER(11) ,
  "MODEL_ISMENU" NUMBER(11) ,
  "MODEL_PARENT_IDS" NVARCHAR2(300) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "MODEL"."MODEL_ID" IS '模块自增长id';
COMMENT ON COLUMN "MODEL"."MODEL_TITLE" IS '模块标题';
COMMENT ON COLUMN "MODEL"."MODEL_CODE" IS '模块编码';
COMMENT ON COLUMN "MODEL"."MODEL_MODELID" IS '模块的父模块id';
COMMENT ON COLUMN "MODEL"."MODEL_URL" IS '模块连接地址';
COMMENT ON COLUMN "MODEL"."MODEL_ICON" IS '模块图标';
COMMENT ON COLUMN "MODEL"."MODEL_MODELMANAGERID" IS '模块关联的关联员id';
COMMENT ON COLUMN "MODEL"."MODEL_SORT" IS '模块的排序';
COMMENT ON COLUMN "MODEL"."MODEL_ISMENU" IS '模块是否是菜单';
COMMENT ON COLUMN "MODEL"."MODEL_PARENT_IDS" IS '父级编号集合，从小到大排序';
COMMENT ON TABLE "MODEL" IS '模块表';

-- ----------------------------
-- Records of "MODEL"
-- ----------------------------
INSERT INTO "MODEL" VALUES ('1', '内容管理', '02000000', NULL, NULL, TO_DATE('2014-08-01 16:19:50', 'SYYYY-MM-DD HH24:MI:SS'), '&#xe77a;', '0', '0', '1', NULL);
INSERT INTO "MODEL" VALUES ('4', '管理员管理', '01020000', '23', 'basic/manager/index.do', TO_DATE('2014-08-03 09:15:02', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '23');
INSERT INTO "MODEL" VALUES ('5', '角色管理', '01010000', '23', 'basic/role/index.do', TO_DATE('2014-08-03 09:15:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '23');
INSERT INTO "MODEL" VALUES ('7', '栏目管理', '02990000', '1', 'column/index.do', TO_DATE('2014-08-03 09:16:29', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '1');
INSERT INTO "MODEL" VALUES ('8', '文章管理', '02980000', '1', 'cms/article/index.do', TO_DATE('2014-08-03 09:17:10', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '1');
INSERT INTO "MODEL" VALUES ('22', '会员中心', '07000000', NULL, NULL, TO_DATE('2014-09-08 08:11:28', 'SYYYY-MM-DD HH24:MI:SS'), '&#xe6b6;', '0', '0', '1', NULL);
INSERT INTO "MODEL" VALUES ('23', '权限管理', '01000000', NULL, NULL, TO_DATE('2014-09-08 08:12:22', 'SYYYY-MM-DD HH24:MI:SS'), '&#xe950;', '0', '0', '1', NULL);
INSERT INTO "MODEL" VALUES ('80', '静态化', '02020000', '1', 'cms/generate/index.do', TO_DATE('2014-12-18 11:37:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '1');
INSERT INTO "MODEL" VALUES ('84', '系统管理', '12000000', NULL, NULL, TO_DATE('2014-12-18 18:30:24', 'SYYYY-MM-DD HH24:MI:SS'), '&#xe71f;', '0', '0', '1', NULL);
INSERT INTO "MODEL" VALUES ('86', '应用设置', '12010000', '84', 'app/-1/edit.do', TO_DATE('2014-12-18 18:31:59', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '84');
INSERT INTO "MODEL" VALUES ('88', '用户管理', '07020100', '22', 'people/peopleUser/index.do ', TO_DATE('2015-09-18 11:44:54', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '22');
INSERT INTO "MODEL" VALUES ('91', '模板管理', '12020000', '84', 'template/queryTemplateSkin.do', NULL, NULL, '0', '0', '1', '84');
INSERT INTO "MODEL" VALUES ('92', '查看', '02990001', '7', 'cms:column:view', TO_DATE('2017-09-04 11:05:24', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,7');
INSERT INTO "MODEL" VALUES ('93', '查看', '02980001', '8', 'article:view', TO_DATE('2017-09-04 11:05:58', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,8');
INSERT INTO "MODEL" VALUES ('94', '查看', '02020001', '80', 'cms:generate:view', TO_DATE('2017-09-04 11:07:50', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,80');
INSERT INTO "MODEL" VALUES ('95', '查看', '07020101', '88', 'people:view', TO_DATE('2017-09-04 11:08:24', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '22,88');
INSERT INTO "MODEL" VALUES ('96', '菜单管理', '01030000', '23', 'model/index.do', TO_DATE('2017-09-04 11:09:26', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '23');
INSERT INTO "MODEL" VALUES ('97', '查看', '01020001', '4', 'manager:view', TO_DATE('2017-09-04 11:09:58', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,4');
INSERT INTO "MODEL" VALUES ('98', '查看', '01010001', '5', 'role:view', TO_DATE('2017-09-04 11:10:20', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,5');
INSERT INTO "MODEL" VALUES ('99', '查看', '01030001', '96', 'model:view', TO_DATE('2017-09-04 11:10:43', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,96');
INSERT INTO "MODEL" VALUES ('100', '查看', '12020001', '91', 'template:view', TO_DATE('2017-09-04 11:12:02', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '84,91');
INSERT INTO "MODEL" VALUES ('101', '查看', '12010001', '86', 'app:view', TO_DATE('2017-09-04 11:12:46', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '84,86');
INSERT INTO "MODEL" VALUES ('104', '自定义管理', '20000000', NULL, NULL, TO_DATE('2017-09-04 11:17:41', 'SYYYY-MM-DD HH24:MI:SS'), '&#xe6dd', '0', '0', '1', NULL);
INSERT INTO "MODEL" VALUES ('105', '自定义页面', '20010000', '104', 'mdiy/page/index.do', TO_DATE('2017-09-04 11:18:51', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '104');
INSERT INTO "MODEL" VALUES ('106', '自定义表单', '20020000', '104', 'mdiy/form/index.do', TO_DATE('2017-09-04 11:19:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '104');
INSERT INTO "MODEL" VALUES ('107', '自定义模型', '20030000', '104', 'mdiy/contentModel/index.do', TO_DATE('2017-09-04 11:20:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '104');
INSERT INTO "MODEL" VALUES ('108', '自定义搜索', '20040000', '104', 'mdiy/search/index.do', TO_DATE('2017-09-04 11:20:31', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '104');
INSERT INTO "MODEL" VALUES ('109', '自定义字典', '20050000', '104', 'mdiy/dict/index.do', TO_DATE('2017-09-04 11:21:09', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '1', '104');
INSERT INTO "MODEL" VALUES ('110', '查看', '20010001', '105', 'mdiy:page:view', TO_DATE('2017-09-04 11:21:47', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,105');
INSERT INTO "MODEL" VALUES ('111', '查看', '20020001', '106', 'mdiy:form:view', TO_DATE('2017-09-04 11:22:17', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,106');
INSERT INTO "MODEL" VALUES ('112', '查看', '20030001', '107', 'mdiy:content:view', TO_DATE('2017-09-04 11:22:45', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,107');
INSERT INTO "MODEL" VALUES ('113', '查看', '20040001', '108', 'mdiy:search:view', TO_DATE('2017-09-04 11:23:04', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,108');
INSERT INTO "MODEL" VALUES ('114', '查看', '20050001', '109', 'mdiy:dict:view', TO_DATE('2017-09-04 11:23:23', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,109');
INSERT INTO "MODEL" VALUES ('115', '删除', '02980003', '8', 'article:del', TO_DATE('2017-09-04 13:24:41', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,8');
INSERT INTO "MODEL" VALUES ('116', '修改', '02980004', '8', 'article:update', TO_DATE('2017-09-04 13:24:58', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,8');
INSERT INTO "MODEL" VALUES ('117', '新增', '02980002', '8', 'article:save', TO_DATE('2017-09-04 13:25:37', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,8');
INSERT INTO "MODEL" VALUES ('118', '生成主页', '02020002', '80', 'cms:generate:index', TO_DATE('2017-09-04 13:31:16', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,80');
INSERT INTO "MODEL" VALUES ('119', '生成栏目', '02020003', '80', 'cms:generate:column', TO_DATE('2017-09-04 13:31:47', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,80');
INSERT INTO "MODEL" VALUES ('120', '生成文章', '02020004', '80', 'cms:generate:article', TO_DATE('2017-09-04 13:32:14', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '1,80');
INSERT INTO "MODEL" VALUES ('121', '删除', '07020103', '88', 'people:del', TO_DATE('2017-09-04 14:06:19', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '22,88');
INSERT INTO "MODEL" VALUES ('122', '修改', '07020104', '88', 'people:update', TO_DATE('2017-09-04 14:07:40', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '22,88');
INSERT INTO "MODEL" VALUES ('123', '新增', '07020102', '88', 'people:save', TO_DATE('2017-09-04 14:08:07', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '22,88');
INSERT INTO "MODEL" VALUES ('124', '删除', '01020003', '4', 'manager:del', TO_DATE('2017-09-04 14:08:52', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,4');
INSERT INTO "MODEL" VALUES ('125', '修改', '01020004', '4', 'manager:update', TO_DATE('2017-09-04 14:09:24', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,4');
INSERT INTO "MODEL" VALUES ('126', '新增', '01020002', '4', 'manager:save', TO_DATE('2017-09-04 14:09:45', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,4');
INSERT INTO "MODEL" VALUES ('127', '删除', '01010003', '5', 'role:del', TO_DATE('2017-09-04 14:10:56', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,5');
INSERT INTO "MODEL" VALUES ('128', '修改', '01010004', '5', 'role:update', TO_DATE('2017-09-04 14:11:36', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,5');
INSERT INTO "MODEL" VALUES ('129', '新增', '01010002', '5', 'role:save', TO_DATE('2017-09-04 14:12:09', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,5');
INSERT INTO "MODEL" VALUES ('130', '删除', '01030003', '96', 'model:del', TO_DATE('2017-09-04 14:13:05', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,96');
INSERT INTO "MODEL" VALUES ('131', '修改', '01030004', '96', 'model:update', TO_DATE('2017-09-04 14:13:34', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,96');
INSERT INTO "MODEL" VALUES ('132', '新增', '01030002', '96', 'model:save', TO_DATE('2017-09-04 14:14:03', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '23,96');
INSERT INTO "MODEL" VALUES ('133', '修改', '12010004', '86', 'app:update', TO_DATE('2017-09-04 14:14:42', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '84,86');
INSERT INTO "MODEL" VALUES ('134', '删除', '12020003', '91', 'template:del', TO_DATE('2017-09-04 14:16:25', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '84,91');
INSERT INTO "MODEL" VALUES ('135', '修改', '12020004', '91', 'template:update', TO_DATE('2017-09-04 14:16:54', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '84,91');
INSERT INTO "MODEL" VALUES ('136', '上传', '12020002', '91', 'template:upload', TO_DATE('2017-09-04 14:18:20', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '84,91');
INSERT INTO "MODEL" VALUES ('137', '删除', '20010003', '105', 'mdiy:page:del', TO_DATE('2017-09-04 14:19:05', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,105');
INSERT INTO "MODEL" VALUES ('138', '修改', '20010004', '105', 'mdiy:page:update', TO_DATE('2017-09-04 14:19:44', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,105');
INSERT INTO "MODEL" VALUES ('139', '新增', '20010002', '105', 'mdiy:page:save', TO_DATE('2017-09-04 14:20:04', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,105');
INSERT INTO "MODEL" VALUES ('140', '删除', '20020003', '106', 'mdiy:form:del', TO_DATE('2017-09-04 14:23:53', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,106');
INSERT INTO "MODEL" VALUES ('141', '修改', '20020004', '106', 'mdiy:form:update', TO_DATE('2017-09-04 14:24:20', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,106');
INSERT INTO "MODEL" VALUES ('142', '新增', '20020002', '106', 'mdiy:form:save', TO_DATE('2017-09-04 14:24:39', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,106');
INSERT INTO "MODEL" VALUES ('143', '删除', '20030003', '107', 'mdiy:content:del', TO_DATE('2017-09-04 14:25:21', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,107');
INSERT INTO "MODEL" VALUES ('144', '修改', '20030004', '107', 'mdiy:content:update', TO_DATE('2017-09-04 14:25:48', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,107');
INSERT INTO "MODEL" VALUES ('145', '新增', '20030002', '107', 'mdiy:content:save', TO_DATE('2017-09-04 14:26:12', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,107');
INSERT INTO "MODEL" VALUES ('146', '删除', '20040003', '108', 'mdiy:search:del', TO_DATE('2017-09-04 14:26:55', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,108');
INSERT INTO "MODEL" VALUES ('147', '修改', '20040004', '108', 'mdiy:search:update', TO_DATE('2017-09-04 14:27:13', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,108');
INSERT INTO "MODEL" VALUES ('148', '新增', '20040002', '108', 'mdiy:search:save', TO_DATE('2017-09-04 14:27:33', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,108');
INSERT INTO "MODEL" VALUES ('149', '删除', '20050003', '109', 'mdiy:dict:del', TO_DATE('2017-09-04 14:28:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,109');
INSERT INTO "MODEL" VALUES ('150', '修改', '20050003', '109', 'mdiy:dict:update', TO_DATE('2017-09-04 14:28:17', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,109');
INSERT INTO "MODEL" VALUES ('151', '新增', '20050002', '109', 'mdiy:dict:save', TO_DATE('2017-09-04 14:28:41', 'SYYYY-MM-DD HH24:MI:SS'), NULL, '0', '0', '0', '104,109');

-- ----------------------------
-- Table structure for PEOPLE
-- ----------------------------
DROP TABLE "PEOPLE";
CREATE TABLE "PEOPLE" (
  "PEOPLE_ID" NUMBER(11) NOT NULL ,
  "PEOPLE_PHONE" NVARCHAR2(30) ,
  "PEOPLE_NAME" NVARCHAR2(30) ,
  "PEOPLE_PASSWORD" NVARCHAR2(50) ,
  "PEOPLE_DATETIME" DATE ,
  "PEOPLE_APP_ID" NUMBER(11) NOT NULL ,
  "PEOPLE_MAIL" NVARCHAR2(120) ,
  "PEOPLE_STATE" NUMBER(11) DEFAULT 0  ,
  "PEOPLE_CODE" NVARCHAR2(15) ,
  "PEOPLE_CODESENDDATE" DATE ,
  "PEOPLE_PHONECHECK" NUMBER(11) DEFAULT 0  ,
  "PEOPLE_MAILLCHECK" NUMBER(11) DEFAULT 0  
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "PEOPLE"."PEOPLE_ID" IS '增长自id';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_PHONE" IS '手机号码';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_NAME" IS '账号';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_PASSWORD" IS '密码';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_DATETIME" IS '注册时间';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_APP_ID" IS '应用编号';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_MAIL" IS '用户邮箱';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_STATE" IS '用户状态';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_CODE" IS '随机验证码';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_CODESENDDATE" IS '发送验证码时间';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_PHONECHECK" IS '1手机验证通过';
COMMENT ON COLUMN "PEOPLE"."PEOPLE_MAILLCHECK" IS '1邮箱验证通过';
COMMENT ON TABLE "PEOPLE" IS '户用基础表';

-- ----------------------------
-- Table structure for PEOPLE_USER
-- ----------------------------
DROP TABLE "PEOPLE_USER";
CREATE TABLE "PEOPLE_USER" (
  "PU_PEOPLE_ID" NUMBER(11) NOT NULL ,
  "PU_REAL_NAME" NVARCHAR2(50) ,
  "PU_ADDRESS" NVARCHAR2(200) ,
  "PU_ICON" NVARCHAR2(200) ,
  "PU_NICKNAME" NVARCHAR2(50) ,
  "PU_SEX" NUMBER(11) ,
  "PU_BIRTHDAY" DATE ,
  "PU_CARD" NVARCHAR2(255) ,
  "PU_PROVINCE" NUMBER(11) DEFAULT 0  ,
  "PU_CITY" NUMBER(11) DEFAULT 0  ,
  "PU_DISTRICT" NUMBER(11) DEFAULT 0  ,
  "PU_STREET" NUMBER(11) DEFAULT 0  
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "PEOPLE_USER"."PU_PEOPLE_ID" IS '用户id关联people表的（people_id）';
COMMENT ON COLUMN "PEOPLE_USER"."PU_REAL_NAME" IS '用户真实名称';
COMMENT ON COLUMN "PEOPLE_USER"."PU_ADDRESS" IS '用户地址';
COMMENT ON COLUMN "PEOPLE_USER"."PU_ICON" IS '用户头像图标地址';
COMMENT ON COLUMN "PEOPLE_USER"."PU_NICKNAME" IS '用户昵称';
COMMENT ON COLUMN "PEOPLE_USER"."PU_SEX" IS '用户性别(0.未知、1.男、2.女)';
COMMENT ON COLUMN "PEOPLE_USER"."PU_BIRTHDAY" IS '用户出生年月日';
COMMENT ON COLUMN "PEOPLE_USER"."PU_CARD" IS '身份证';
COMMENT ON COLUMN "PEOPLE_USER"."PU_PROVINCE" IS '省';
COMMENT ON COLUMN "PEOPLE_USER"."PU_CITY" IS '城市';
COMMENT ON COLUMN "PEOPLE_USER"."PU_DISTRICT" IS '区';
COMMENT ON COLUMN "PEOPLE_USER"."PU_STREET" IS '街道';
COMMENT ON TABLE "PEOPLE_USER" IS '用户基础信息表';

-- ----------------------------
-- Table structure for ROLE
-- ----------------------------
DROP TABLE "ROLE";
CREATE TABLE "ROLE" (
  "ROLE_ID" NUMBER(11) NOT NULL ,
  "ROLE_NAME" NVARCHAR2(30) ,
  "ROLE_MANAGERID" NUMBER(11) DEFAULT 0  ,
  "APP_ID" NUMBER(11) NOT NULL 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "ROLE"."ROLE_ID" IS '角色id，自增长';
COMMENT ON COLUMN "ROLE"."ROLE_NAME" IS '角色名';
COMMENT ON COLUMN "ROLE"."ROLE_MANAGERID" IS '角色管理员编号';
COMMENT ON COLUMN "ROLE"."APP_ID" IS '应用编号';
COMMENT ON TABLE "ROLE" IS '角色表';

-- ----------------------------
-- Records of "ROLE"
-- ----------------------------
INSERT INTO "ROLE" VALUES ('48', 'msopen', '50', '1');

-- ----------------------------
-- Table structure for ROLE_MODEL
-- ----------------------------
DROP TABLE "ROLE_MODEL";
CREATE TABLE "ROLE_MODEL" (
  "RM_MODELID" NUMBER(11) ,
  "RM_ROLEID" NUMBER(11) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "ROLE_MODEL"."RM_MODELID" IS '模块编号';
COMMENT ON COLUMN "ROLE_MODEL"."RM_ROLEID" IS '角色编号';
COMMENT ON TABLE "ROLE_MODEL" IS '角色模块关联表';

-- ----------------------------
-- Records of "ROLE_MODEL"
-- ----------------------------
INSERT INTO "ROLE_MODEL" VALUES ('1', '48');
INSERT INTO "ROLE_MODEL" VALUES ('4', '48');
INSERT INTO "ROLE_MODEL" VALUES ('5', '48');
INSERT INTO "ROLE_MODEL" VALUES ('7', '48');
INSERT INTO "ROLE_MODEL" VALUES ('8', '48');
INSERT INTO "ROLE_MODEL" VALUES ('22', '48');
INSERT INTO "ROLE_MODEL" VALUES ('23', '48');
INSERT INTO "ROLE_MODEL" VALUES ('80', '48');
INSERT INTO "ROLE_MODEL" VALUES ('84', '48');
INSERT INTO "ROLE_MODEL" VALUES ('86', '48');
INSERT INTO "ROLE_MODEL" VALUES ('88', '48');
INSERT INTO "ROLE_MODEL" VALUES ('91', '48');
INSERT INTO "ROLE_MODEL" VALUES ('92', '48');
INSERT INTO "ROLE_MODEL" VALUES ('93', '48');
INSERT INTO "ROLE_MODEL" VALUES ('94', '48');
INSERT INTO "ROLE_MODEL" VALUES ('95', '48');
INSERT INTO "ROLE_MODEL" VALUES ('96', '48');
INSERT INTO "ROLE_MODEL" VALUES ('97', '48');
INSERT INTO "ROLE_MODEL" VALUES ('98', '48');
INSERT INTO "ROLE_MODEL" VALUES ('99', '48');
INSERT INTO "ROLE_MODEL" VALUES ('100', '48');
INSERT INTO "ROLE_MODEL" VALUES ('101', '48');
INSERT INTO "ROLE_MODEL" VALUES ('104', '48');
INSERT INTO "ROLE_MODEL" VALUES ('105', '48');
INSERT INTO "ROLE_MODEL" VALUES ('106', '48');
INSERT INTO "ROLE_MODEL" VALUES ('107', '48');
INSERT INTO "ROLE_MODEL" VALUES ('108', '48');
INSERT INTO "ROLE_MODEL" VALUES ('109', '48');
INSERT INTO "ROLE_MODEL" VALUES ('110', '48');
INSERT INTO "ROLE_MODEL" VALUES ('111', '48');
INSERT INTO "ROLE_MODEL" VALUES ('112', '48');
INSERT INTO "ROLE_MODEL" VALUES ('113', '48');
INSERT INTO "ROLE_MODEL" VALUES ('114', '48');
INSERT INTO "ROLE_MODEL" VALUES ('115', '48');
INSERT INTO "ROLE_MODEL" VALUES ('116', '48');
INSERT INTO "ROLE_MODEL" VALUES ('117', '48');
INSERT INTO "ROLE_MODEL" VALUES ('118', '48');
INSERT INTO "ROLE_MODEL" VALUES ('119', '48');
INSERT INTO "ROLE_MODEL" VALUES ('120', '48');
INSERT INTO "ROLE_MODEL" VALUES ('121', '48');
INSERT INTO "ROLE_MODEL" VALUES ('122', '48');
INSERT INTO "ROLE_MODEL" VALUES ('123', '48');
INSERT INTO "ROLE_MODEL" VALUES ('124', '48');
INSERT INTO "ROLE_MODEL" VALUES ('125', '48');
INSERT INTO "ROLE_MODEL" VALUES ('126', '48');
INSERT INTO "ROLE_MODEL" VALUES ('127', '48');
INSERT INTO "ROLE_MODEL" VALUES ('128', '48');
INSERT INTO "ROLE_MODEL" VALUES ('129', '48');
INSERT INTO "ROLE_MODEL" VALUES ('130', '48');
INSERT INTO "ROLE_MODEL" VALUES ('131', '48');
INSERT INTO "ROLE_MODEL" VALUES ('132', '48');
INSERT INTO "ROLE_MODEL" VALUES ('133', '48');
INSERT INTO "ROLE_MODEL" VALUES ('134', '48');
INSERT INTO "ROLE_MODEL" VALUES ('135', '48');
INSERT INTO "ROLE_MODEL" VALUES ('136', '48');
INSERT INTO "ROLE_MODEL" VALUES ('137', '48');
INSERT INTO "ROLE_MODEL" VALUES ('138', '48');
INSERT INTO "ROLE_MODEL" VALUES ('139', '48');
INSERT INTO "ROLE_MODEL" VALUES ('140', '48');
INSERT INTO "ROLE_MODEL" VALUES ('141', '48');
INSERT INTO "ROLE_MODEL" VALUES ('142', '48');
INSERT INTO "ROLE_MODEL" VALUES ('143', '48');
INSERT INTO "ROLE_MODEL" VALUES ('144', '48');
INSERT INTO "ROLE_MODEL" VALUES ('145', '48');
INSERT INTO "ROLE_MODEL" VALUES ('146', '48');
INSERT INTO "ROLE_MODEL" VALUES ('147', '48');
INSERT INTO "ROLE_MODEL" VALUES ('148', '48');
INSERT INTO "ROLE_MODEL" VALUES ('149', '48');
INSERT INTO "ROLE_MODEL" VALUES ('150', '48');
INSERT INTO "ROLE_MODEL" VALUES ('151', '48');

-- ----------------------------
-- Table structure for MDIY_MESSAGE_50
-- ----------------------------
CREATE TABLE MDIY_MESSAGE_50 (
  "ID" NUMBER(11) NOT NULL,
  "DATE" DATE,
  "FROMID" NUMBER(11),
  "NAME" NVARCHAR2(100),
  "PHONE" NVARCHAR2(100),
  "CONTENT" NVARCHAR2(100)
) 
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;


-- ----------------------------
-- Sequence structure for SEQ_APP_ID
-- ----------------------------
DROP SEQUENCE "SEQ_APP_ID";
CREATE SEQUENCE "SEQ_APP_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_BASIC_ID
-- ----------------------------
DROP SEQUENCE "SEQ_BASIC_ID";
CREATE SEQUENCE "SEQ_BASIC_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_BA_ID
-- ----------------------------
DROP SEQUENCE "SEQ_BA_ID";
CREATE SEQUENCE "SEQ_BA_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_BL_ID
-- ----------------------------
DROP SEQUENCE "SEQ_BL_ID";
CREATE SEQUENCE "SEQ_BL_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_CATEGORY_ID
-- ----------------------------
DROP SEQUENCE "SEQ_CATEGORY_ID";
CREATE SEQUENCE "SEQ_CATEGORY_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_CM_ID
-- ----------------------------
DROP SEQUENCE "SEQ_CM_ID";
CREATE SEQUENCE "SEQ_CM_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_COMMENT_ID
-- ----------------------------
DROP SEQUENCE "SEQ_COMMENT_ID";
CREATE SEQUENCE "SEQ_COMMENT_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_DICT_ID
-- ----------------------------
DROP SEQUENCE "SEQ_DICT_ID";
CREATE SEQUENCE "SEQ_DICT_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_FF_ID
-- ----------------------------
DROP SEQUENCE "SEQ_FF_ID";
CREATE SEQUENCE "SEQ_FF_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_FIELD_ID
-- ----------------------------
DROP SEQUENCE "SEQ_FIELD_ID";
CREATE SEQUENCE "SEQ_FIELD_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_FORM_ID
-- ----------------------------
DROP SEQUENCE "SEQ_FORM_ID";
CREATE SEQUENCE "SEQ_FORM_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_MANAGER_ID
-- ----------------------------
DROP SEQUENCE "SEQ_MANAGER_ID";
CREATE SEQUENCE "SEQ_MANAGER_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_MODEL_ID
-- ----------------------------
DROP SEQUENCE "SEQ_MODEL_ID";
CREATE SEQUENCE "SEQ_MODEL_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_PAGE_ID
-- ----------------------------
DROP SEQUENCE "SEQ_PAGE_ID";
CREATE SEQUENCE "SEQ_PAGE_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_PEOPLE_ID
-- ----------------------------
DROP SEQUENCE "SEQ_PEOPLE_ID";
CREATE SEQUENCE "SEQ_PEOPLE_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_ROLE_ID
-- ----------------------------
DROP SEQUENCE "SEQ_ROLE_ID";
CREATE SEQUENCE "SEQ_ROLE_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_SEARCH_ID
-- ----------------------------
DROP SEQUENCE "SEQ_SEARCH_ID";
CREATE SEQUENCE "SEQ_SEARCH_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Sequence structure for SEQ_SS_ID
-- ----------------------------
DROP SEQUENCE "SEQ_SS_ID";
CREATE SEQUENCE "SEQ_SS_ID" MINVALUE 1 MAXVALUE 99999999 START WITH 300 INCREMENT BY 1   CACHE 20;

-- ----------------------------
-- Primary Key structure for table APP
-- ----------------------------
ALTER TABLE "APP" ADD CONSTRAINT "SYS_C0025484" PRIMARY KEY ("APP_ID");

-- ----------------------------
-- Checks structure for table APP
-- ----------------------------
ALTER TABLE "APP" ADD CONSTRAINT "SYS_C0025430" CHECK ("APP_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "APP" ADD CONSTRAINT "SYS_C0025431" CHECK ("APP_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "APP" ADD CONSTRAINT "SYS_C0025432" CHECK ("APP_URL" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "APP" ADD CONSTRAINT "SYS_C0025433" CHECK ("APP_STATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "APP" ADD CONSTRAINT "SYS_C0025434" CHECK ("APP_MOBILE_STATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table APP
-- ----------------------------
CREATE INDEX "IND_APP_MANAGER_1"
  ON "APP" ("APP_MANAGERID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table BASIC
-- ----------------------------
ALTER TABLE "BASIC" ADD CONSTRAINT "SYS_C0025485" PRIMARY KEY ("BASIC_ID");

-- ----------------------------
-- Checks structure for table BASIC
-- ----------------------------
ALTER TABLE "BASIC" ADD CONSTRAINT "SYS_C0025435" CHECK ("BASIC_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BASIC" ADD CONSTRAINT "SYS_C0025436" CHECK ("BASIC_APPID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table BASIC
-- ----------------------------
CREATE INDEX "IND_BASIC_APPID"
  ON "BASIC" ("BASIC_APPID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_BASIC_CATEGORYID"
  ON "BASIC" ("BASIC_CATEGORYID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_BASIC_MODELID"
  ON "BASIC" ("BASIC_MODELID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_BASIC_TITLE"
  ON "BASIC" ("BASIC_TITLE" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table BASIC_ATTENTION
-- ----------------------------
ALTER TABLE "BASIC_ATTENTION" ADD CONSTRAINT "SYS_C0025486" PRIMARY KEY ("BA_ID");

-- ----------------------------
-- Checks structure for table BASIC_ATTENTION
-- ----------------------------
ALTER TABLE "BASIC_ATTENTION" ADD CONSTRAINT "SYS_C0025437" CHECK ("BA_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table BASIC_ATTENTION
-- ----------------------------
CREATE INDEX "IND_BASIC_ATTENTION_BASIC_1"
  ON "BASIC_ATTENTION" ("BA_BASIC_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_BA_PEOPLEID"
  ON "BASIC_ATTENTION" ("BA_PEOPLE_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table BASIC_COLUMN
-- ----------------------------
ALTER TABLE "BASIC_COLUMN" ADD CONSTRAINT "SYS_C0025487" PRIMARY KEY ("COLUMN_CATEGORY_ID");

-- ----------------------------
-- Checks structure for table BASIC_COLUMN
-- ----------------------------
ALTER TABLE "BASIC_COLUMN" ADD CONSTRAINT "SYS_C0025438" CHECK ("COLUMN_CATEGORY_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table BASIC_COLUMN
-- ----------------------------
CREATE INDEX "IND_BASIC_COLUMN_1"
  ON "BASIC_COLUMN" ("COLUMN_CM_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table BASIC_LOG
-- ----------------------------
ALTER TABLE "BASIC_LOG" ADD CONSTRAINT "SYS_C0025488" PRIMARY KEY ("BL_ID");

-- ----------------------------
-- Checks structure for table BASIC_LOG
-- ----------------------------
ALTER TABLE "BASIC_LOG" ADD CONSTRAINT "SYS_C0025439" CHECK ("BL_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BASIC_LOG" ADD CONSTRAINT "SYS_C0025440" CHECK ("BL_BASIC_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BASIC_LOG" ADD CONSTRAINT "SYS_C0025441" CHECK ("BL_IP" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BASIC_LOG" ADD CONSTRAINT "SYS_C0025442" CHECK ("BL_DATETIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BASIC_LOG" ADD CONSTRAINT "SYS_C0025443" CHECK ("BL_IS_MOBILE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table BASIC_LOG
-- ----------------------------
CREATE INDEX "IND_BASIC_LOG_BASIC_1"
  ON "BASIC_LOG" ("BL_BASIC_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table CATEGORY
-- ----------------------------
ALTER TABLE "CATEGORY" ADD CONSTRAINT "SYS_C0025489" PRIMARY KEY ("CATEGORY_ID");

-- ----------------------------
-- Checks structure for table CATEGORY
-- ----------------------------
ALTER TABLE "CATEGORY" ADD CONSTRAINT "SYS_C0025444" CHECK ("CATEGORY_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CATEGORY" ADD CONSTRAINT "SYS_C0025445" CHECK ("DEL" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table CATEGORY
-- ----------------------------
CREATE INDEX "IND_CATEGORY_APPID"
  ON "CATEGORY" ("CATEGORY_APPID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_CATEGORY_CATEGORYID"
  ON "CATEGORY" ("CATEGORY_CATEGORYID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_CATEGORY_MANAGERID"
  ON "CATEGORY" ("CATEGORY_MANAGERID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_CATEGORY_MODELID"
  ON "CATEGORY" ("CATEGORY_MODELID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table CMS_ARTICLE
-- ----------------------------
ALTER TABLE "CMS_ARTICLE" ADD CONSTRAINT "SYS_C0025490" PRIMARY KEY ("ARTICLE_BASICID");

-- ----------------------------
-- Checks structure for table CMS_ARTICLE
-- ----------------------------
ALTER TABLE "CMS_ARTICLE" ADD CONSTRAINT "SYS_C0025446" CHECK ("ARTICLE_BASICID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table CMS_ARTICLE
-- ----------------------------
CREATE INDEX "IND_ARTICLE_WEBID"
  ON "CMS_ARTICLE" ("ARTICLE_WEBID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table CMS_CLASS_50
-- ----------------------------
ALTER TABLE "CMS_CLASS_50" ADD CONSTRAINT "SYS_C0025491" PRIMARY KEY ("BASICID");

-- ----------------------------
-- Checks structure for table CMS_CLASS_50
-- ----------------------------
ALTER TABLE "CMS_CLASS_50" ADD CONSTRAINT "SYS_C0025447" CHECK ("BASICID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table COMMENT
-- ----------------------------
ALTER TABLE "COMMENT" ADD CONSTRAINT "SYS_C0025492" PRIMARY KEY ("COMMENT_ID");

-- ----------------------------
-- Checks structure for table COMMENT
-- ----------------------------
ALTER TABLE "COMMENT" ADD CONSTRAINT "SYS_C0025448" CHECK ("COMMENT_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COMMENT" ADD CONSTRAINT "SYS_C0025449" CHECK ("COMMENT_COMMENTID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COMMENT" ADD CONSTRAINT "SYS_C0025450" CHECK ("COMMENT_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COMMENT" ADD CONSTRAINT "SYS_C0025451" CHECK ("COMMENT_TYPE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COMMENT" ADD CONSTRAINT "SYS_C0025452" CHECK ("COMMENT_BASICID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table COMMENT
-- ----------------------------
CREATE INDEX "IND_COMMENT_BASICID"
  ON "COMMENT" ("COMMENT_BASICID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);
CREATE INDEX "INd_COMMENT_PEOPLE_1"
  ON "COMMENT" ("COMMENT_PEOPLEID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MANAGER
-- ----------------------------
ALTER TABLE "MANAGER" ADD CONSTRAINT "SYS_C0025493" PRIMARY KEY ("MANAGER_ID");

-- ----------------------------
-- Checks structure for table MANAGER
-- ----------------------------
ALTER TABLE "MANAGER" ADD CONSTRAINT "SYS_C0025453" CHECK ("MANAGER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MANAGER
-- ----------------------------
CREATE INDEX "IND_MANAGER_ROLE_1"
  ON "MANAGER" ("MANAGER_ROLEID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Indexes structure for table MANAGER_MODEL_PAGE
-- ----------------------------
CREATE INDEX "IND_MANAGER_MODEL_PAGE_MANAGER"
  ON "MANAGER_MODEL_PAGE" ("MMP_MANAGER_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_MANAGER_MODEL_PAGE_MODEL_1"
  ON "MANAGER_MODEL_PAGE" ("MMP_MODEL_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MDIY_CONTENT_MODEL
-- ----------------------------
ALTER TABLE "MDIY_CONTENT_MODEL" ADD CONSTRAINT "SYS_C0025495" PRIMARY KEY ("CM_ID");

-- ----------------------------
-- Checks structure for table MDIY_CONTENT_MODEL
-- ----------------------------
ALTER TABLE "MDIY_CONTENT_MODEL" ADD CONSTRAINT "SYS_C0025455" CHECK ("CM_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_CONTENT_MODEL" ADD CONSTRAINT "SYS_C0025456" CHECK ("CM_TIPS_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_CONTENT_MODEL" ADD CONSTRAINT "SYS_C0025457" CHECK ("CM_TABLE_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MDIY_CONTENT_MODEL
-- ----------------------------
CREATE INDEX "IND_MDIY_CONTENT_MODEL"
  ON "MDIY_CONTENT_MODEL" ("CM_APP_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MDIY_CONTENT_MODE_FIELD
-- ----------------------------
ALTER TABLE "MDIY_CONTENT_MODE_FIELD" ADD CONSTRAINT "SYS_C0025494" PRIMARY KEY ("FIELD_ID");

-- ----------------------------
-- Checks structure for table MDIY_CONTENT_MODE_FIELD
-- ----------------------------
ALTER TABLE "MDIY_CONTENT_MODE_FIELD" ADD CONSTRAINT "SYS_C0025454" CHECK ("FIELD_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MDIY_CONTENT_MODE_FIELD
-- ----------------------------
CREATE INDEX "IND_M_C_MODE_FIELD_M_C_MODEL"
  ON "MDIY_CONTENT_MODE_FIELD" ("FIELD_CMID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MDIY_DICT
-- ----------------------------
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "SYS_C0025496" PRIMARY KEY ("DICT_ID");

-- ----------------------------
-- Checks structure for table MDIY_DICT
-- ----------------------------
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "SYS_C0025458" CHECK ("DICT_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "SYS_C0025459" CHECK ("DICT_VALUE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "SYS_C0025460" CHECK ("DICT_LABEL" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "SYS_C0025461" CHECK ("DICT_TYPE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "SYS_C0025462" CHECK ("DICT_DESCRIPTION" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "SYS_C0025463" CHECK ("DICT_SORT" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "SYS_C0025464" CHECK ("DEL" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MDIY_DICT
-- ----------------------------
CREATE INDEX "IND_MDIY_DICT"
  ON "MDIY_DICT" ("APP_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MDIY_FORM
-- ----------------------------
ALTER TABLE "MDIY_FORM" ADD CONSTRAINT "SYS_C0025497" PRIMARY KEY ("FORM_ID");

-- ----------------------------
-- Checks structure for table MDIY_FORM
-- ----------------------------
ALTER TABLE "MDIY_FORM" ADD CONSTRAINT "SYS_C0025465" CHECK ("FORM_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_FORM" ADD CONSTRAINT "SYS_C0025466" CHECK ("FORM_TIPS_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_FORM" ADD CONSTRAINT "SYS_C0025467" CHECK ("FORM_APP_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MDIY_FORM
-- ----------------------------
CREATE INDEX "IND_MDIY_FORM"
  ON "MDIY_FORM" ("FORM_APP_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MDIY_FORM_FIELD
-- ----------------------------
ALTER TABLE "MDIY_FORM_FIELD" ADD CONSTRAINT "SYS_C0025498" PRIMARY KEY ("FF_ID");

-- ----------------------------
-- Checks structure for table MDIY_FORM_FIELD
-- ----------------------------
ALTER TABLE "MDIY_FORM_FIELD" ADD CONSTRAINT "SYS_C0025468" CHECK ("FF_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MDIY_FORM_FIELD
-- ----------------------------
CREATE INDEX "IND_MDIY_FORM_FIELD"
  ON "MDIY_FORM_FIELD" ("FF_FORMID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MDIY_MOOC_50
-- ----------------------------
ALTER TABLE "MDIY_MOOC_50" ADD CONSTRAINT "SYS_C0025499" PRIMARY KEY ("BASICID");

-- ----------------------------
-- Checks structure for table MDIY_MOOC_50
-- ----------------------------
ALTER TABLE "MDIY_MOOC_50" ADD CONSTRAINT "SYS_C0025469" CHECK ("BASICID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table MDIY_PAGE
-- ----------------------------
ALTER TABLE "MDIY_PAGE" ADD CONSTRAINT "SYS_C0025500" PRIMARY KEY ("PAGE_ID");

-- ----------------------------
-- Checks structure for table MDIY_PAGE
-- ----------------------------
ALTER TABLE "MDIY_PAGE" ADD CONSTRAINT "SYS_C0025470" CHECK ("PAGE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_PAGE" ADD CONSTRAINT "SYS_C0025471" CHECK ("PAGE_APP_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MDIY_PAGE
-- ----------------------------
CREATE INDEX "INDEX_PAGE_APP_ID"
  ON "MDIY_PAGE" ("PAGE_APP_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "INDEX_PAGE_KEY"
  ON "MDIY_PAGE" ("PAGE_KEY" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "INDEX_PAGE_MODEL_ID"
  ON "MDIY_PAGE" ("PAGE_MODEL_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MDIY_SEARCH
-- ----------------------------
ALTER TABLE "MDIY_SEARCH" ADD CONSTRAINT "SYS_C0025501" PRIMARY KEY ("SEARCH_ID");

-- ----------------------------
-- Checks structure for table MDIY_SEARCH
-- ----------------------------
ALTER TABLE "MDIY_SEARCH" ADD CONSTRAINT "SYS_C0025472" CHECK ("SEARCH_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_SEARCH" ADD CONSTRAINT "SYS_C0025473" CHECK ("SEARCH_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_SEARCH" ADD CONSTRAINT "SYS_C0025474" CHECK ("SEARCH_TEMPLETS" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_SEARCH" ADD CONSTRAINT "SYS_C0025475" CHECK ("SEARCH_APP_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MDIY_SEARCH" ADD CONSTRAINT "SYS_C0025476" CHECK ("SEARCH_TYPE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MDIY_SEARCH
-- ----------------------------
CREATE INDEX "IND_MDIY_SEARCH"
  ON "MDIY_SEARCH" ("SEARCH_APP_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table MODEL
-- ----------------------------
ALTER TABLE "MODEL" ADD CONSTRAINT "SYS_C0025502" PRIMARY KEY ("MODEL_ID");

-- ----------------------------
-- Checks structure for table MODEL
-- ----------------------------
ALTER TABLE "MODEL" ADD CONSTRAINT "SYS_C0025477" CHECK ("MODEL_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table MODEL
-- ----------------------------
CREATE INDEX "IND_MODEL_CODE"
  ON "MODEL" ("MODEL_CODE" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_MODEL_MODELID"
  ON "MODEL" ("MODEL_MODELID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table PEOPLE
-- ----------------------------
ALTER TABLE "PEOPLE" ADD CONSTRAINT "SYS_C0025503" PRIMARY KEY ("PEOPLE_ID");

-- ----------------------------
-- Checks structure for table PEOPLE
-- ----------------------------
ALTER TABLE "PEOPLE" ADD CONSTRAINT "SYS_C0025478" CHECK ("PEOPLE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "PEOPLE" ADD CONSTRAINT "SYS_C0025479" CHECK ("PEOPLE_APP_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table PEOPLE
-- ----------------------------
CREATE INDEX "IND_PEOPLE"
  ON "PEOPLE" ("PEOPLE_APP_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table PEOPLE_USER
-- ----------------------------
ALTER TABLE "PEOPLE_USER" ADD CONSTRAINT "SYS_C0025504" PRIMARY KEY ("PU_PEOPLE_ID");

-- ----------------------------
-- Checks structure for table PEOPLE_USER
-- ----------------------------
ALTER TABLE "PEOPLE_USER" ADD CONSTRAINT "SYS_C0025480" CHECK ("PU_PEOPLE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table ROLE
-- ----------------------------
ALTER TABLE "ROLE" ADD CONSTRAINT "SYS_C0025505" PRIMARY KEY ("ROLE_ID");

-- ----------------------------
-- Checks structure for table ROLE
-- ----------------------------
ALTER TABLE "ROLE" ADD CONSTRAINT "SYS_C0025481" CHECK ("ROLE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "ROLE" ADD CONSTRAINT "SYS_C0025482" CHECK ("APP_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table ROLE_MODEL
-- ----------------------------
CREATE INDEX "IND_RM_MODELID"
  ON "ROLE_MODEL" ("RM_MODELID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "IND_ROLE_MODEL_ROLE_1"
  ON "ROLE_MODEL" ("RM_ROLEID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE UNIQUE INDEX "UNI_RM_RR"
  ON "ROLE_MODEL" ("RM_MODELID" ASC, "RM_ROLEID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);


-- ----------------------------
-- Foreign Keys structure for table APP
-- ----------------------------
ALTER TABLE "APP" ADD CONSTRAINT "FK_APP_MANAGER_1" FOREIGN KEY ("APP_MANAGERID") REFERENCES "MANAGER" ("MANAGER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BASIC
-- ----------------------------
ALTER TABLE "BASIC" ADD CONSTRAINT "FK_BASIC_APP_1" FOREIGN KEY ("BASIC_APPID") REFERENCES "APP" ("APP_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BASIC" ADD CONSTRAINT "FK_BASIC_CATEGORY_1" FOREIGN KEY ("BASIC_CATEGORYID") REFERENCES "CATEGORY" ("CATEGORY_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BASIC_ATTENTION
-- ----------------------------
ALTER TABLE "BASIC_ATTENTION" ADD CONSTRAINT "FK_BASIC_ATTENTION_BASIC_1" FOREIGN KEY ("BA_BASIC_ID") REFERENCES "BASIC" ("BASIC_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BASIC_COLUMN
-- ----------------------------
ALTER TABLE "BASIC_COLUMN" ADD CONSTRAINT "FK_BASIC_COLUMN" FOREIGN KEY ("COLUMN_CATEGORY_ID") REFERENCES "CATEGORY" ("CATEGORY_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BASIC_COLUMN" ADD CONSTRAINT "FK_BASIC_COLUMN_1" FOREIGN KEY ("COLUMN_CM_ID") REFERENCES "MDIY_CONTENT_MODEL" ("CM_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BASIC_LOG
-- ----------------------------
ALTER TABLE "BASIC_LOG" ADD CONSTRAINT "FK_BASIC_LOG_BASIC_1" FOREIGN KEY ("BL_BASIC_ID") REFERENCES "BASIC" ("BASIC_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table CATEGORY
-- ----------------------------
ALTER TABLE "CATEGORY" ADD CONSTRAINT "FK_CATEGORY" FOREIGN KEY ("CATEGORY_CATEGORYID") REFERENCES "CATEGORY" ("CATEGORY_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "CATEGORY" ADD CONSTRAINT "FK_CATEGORY_1" FOREIGN KEY ("CATEGORY_APPID") REFERENCES "APP" ("APP_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table CMS_ARTICLE
-- ----------------------------
ALTER TABLE "CMS_ARTICLE" ADD CONSTRAINT "FK_CMS_ARTICLE_BASIC_1" FOREIGN KEY ("ARTICLE_BASICID") REFERENCES "BASIC" ("BASIC_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table COMMENT
-- ----------------------------
ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_COMMENT" FOREIGN KEY ("COMMENT_BASICID") REFERENCES "BASIC" ("BASIC_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_COMMENT_PEOPLE_1" FOREIGN KEY ("COMMENT_PEOPLEID") REFERENCES "PEOPLE" ("PEOPLE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MANAGER
-- ----------------------------
ALTER TABLE "MANAGER" ADD CONSTRAINT "FK_MANAGER_ROLE_1" FOREIGN KEY ("MANAGER_ROLEID") REFERENCES "ROLE" ("ROLE_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MANAGER_MODEL_PAGE
-- ----------------------------
ALTER TABLE "MANAGER_MODEL_PAGE" ADD CONSTRAINT "FK_MANAGER_MODEL_PAGE_MANAGER" FOREIGN KEY ("MMP_MANAGER_ID") REFERENCES "MANAGER" ("MANAGER_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "MANAGER_MODEL_PAGE" ADD CONSTRAINT "FK_MANAGER_MODEL_PAGE_MODEL_1" FOREIGN KEY ("MMP_MODEL_ID") REFERENCES "MODEL" ("MODEL_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MDIY_CONTENT_MODEL
-- ----------------------------
ALTER TABLE "MDIY_CONTENT_MODEL" ADD CONSTRAINT "FK_MDIY_CONTENT_MODEL" FOREIGN KEY ("CM_APP_ID") REFERENCES "APP" ("APP_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MDIY_CONTENT_MODE_FIELD
-- ----------------------------
ALTER TABLE "MDIY_CONTENT_MODE_FIELD" ADD CONSTRAINT "FK_M_C_MODE_FIELD_M_C_MODEL" FOREIGN KEY ("FIELD_CMID") REFERENCES "MDIY_CONTENT_MODEL" ("CM_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MDIY_DICT
-- ----------------------------
ALTER TABLE "MDIY_DICT" ADD CONSTRAINT "FK_MDIY_DICT" FOREIGN KEY ("APP_ID") REFERENCES "APP" ("APP_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MDIY_FORM
-- ----------------------------
ALTER TABLE "MDIY_FORM" ADD CONSTRAINT "FK_MDIY_FORM" FOREIGN KEY ("FORM_APP_ID") REFERENCES "APP" ("APP_ID")ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MDIY_FORM_FIELD
-- ----------------------------
ALTER TABLE "MDIY_FORM_FIELD" ADD CONSTRAINT "FK_MDIY_FORM_FIELD" FOREIGN KEY ("FF_FORMID") REFERENCES "MDIY_FORM" ("FORM_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MDIY_MOOC_50
-- ----------------------------
ALTER TABLE "MDIY_MOOC_50" ADD CONSTRAINT "FK_MDIY_MOOC_50_BASICID" FOREIGN KEY ("BASICID") REFERENCES "BASIC" ("BASIC_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MDIY_PAGE
-- ----------------------------
ALTER TABLE "MDIY_PAGE" ADD CONSTRAINT "FK_MODEL_TEMPLATE_APP_1" FOREIGN KEY ("PAGE_APP_ID") REFERENCES "APP" ("APP_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MDIY_SEARCH
-- ----------------------------
ALTER TABLE "MDIY_SEARCH" ADD CONSTRAINT "FK_MDIY_SEARCH" FOREIGN KEY ("SEARCH_APP_ID") REFERENCES "APP" ("APP_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table MODEL
-- ----------------------------
ALTER TABLE "MODEL" ADD CONSTRAINT "MODEL_IBFK_1" FOREIGN KEY ("MODEL_MODELID") REFERENCES "MODEL" ("MODEL_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table PEOPLE
-- ----------------------------
ALTER TABLE "PEOPLE" ADD CONSTRAINT "FK_PEOPLE" FOREIGN KEY ("PEOPLE_APP_ID") REFERENCES "APP" ("APP_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table PEOPLE_USER
-- ----------------------------
ALTER TABLE "PEOPLE_USER" ADD CONSTRAINT "FK_PEOPLE_USER_PEOPLE_1" FOREIGN KEY ("PU_PEOPLE_ID") REFERENCES "PEOPLE" ("PEOPLE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table ROLE_MODEL
-- ----------------------------
ALTER TABLE "ROLE_MODEL" ADD CONSTRAINT "FK_ROLE_MODEL_ROLE_1" FOREIGN KEY ("RM_ROLEID") REFERENCES "ROLE" ("ROLE_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "ROLE_MODEL" ADD CONSTRAINT "ROLE_MODEL_IBFK_1" FOREIGN KEY ("RM_MODELID") REFERENCES "MODEL" ("MODEL_ID") ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

