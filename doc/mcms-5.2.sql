/*
 Navicat MySQL Data Transfer

 Source Server         : 192.168.0.8
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : 192.168.0.8:3316
 Source Schema         : mcms-dev-5.2-1

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 03/11/2020 18:06:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '站点id',
  `app_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '站点名称',
  `app_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '站点域名，多个回车换行显示',
  `app_logo` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网站logo',
  `app_keyword` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点关键字',
  `app_copyright` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点版权信息',
  `app_style` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点风格',
  `app_description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `app_datetime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `app_mobile_style` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '移动端风格',
  `app_pay_date` datetime(0) NULL DEFAULT NULL COMMENT '应用续费时间',
  `app_pay` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '费用清单',
  `app_state` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0运行中 1已停止  ',
  `app_mobile_state` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0启用 1停用',
  `app_login_page` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del` int(1) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES (1, 'MCMS-OPEN', 'http://localhost:5107\r\n', '[{\"path\":\"/upload/1/appLogo/1578375538540.jpg\",\"url\":\"/upload/1/appLogo/1578375538540.jpg\",\"uid\":1603951176409,\"status\":\"success\"}]', '铭飞MCMS', '版权所有 ©铭飞科技有限公司2012-2019 保留一切权利。', '江西省人民政府-web', '铭飞MCMS', NULL, '', '2019-11-16 00:00:00', '', 0, 1, '', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for cms_category
-- ----------------------------
DROP TABLE IF EXISTS `cms_category`;
CREATE TABLE `cms_category`  (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目管理名称',
  `category_img` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `category_flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目属性',
  `category_descrip` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目管理描述',
  `category_keyword` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目管理关键字',
  `category_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目路径',
  `category_parent_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父类型编号',
  `dict_id` int(11) NULL DEFAULT NULL COMMENT '字典对应编号',
  `app_id` int(11) NULL DEFAULT NULL COMMENT '应用编号',
  `category_manager_id` int(11) NULL DEFAULT NULL COMMENT '发布用户id',
  `category_datetime` datetime(0) NULL DEFAULT NULL COMMENT '类别发布时间',
  `mdiy_model_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目管理的内容模型id',
  `category_diy_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义链接',
  `category_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容模板',
  `category_list_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列表模板',
  `category_sort` int(11) NULL DEFAULT NULL COMMENT '自定义顺序',
  `category_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目管理属性',
  `category_id` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属栏目',
  `del` int(1) NULL DEFAULT 0 COMMENT '删除标记',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `category_pinyin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `leaf` bigint(1) NULL DEFAULT NULL COMMENT '是否是叶子节点',
  `top_id` bigint(20) NULL DEFAULT NULL COMMENT '顶级id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_category
-- ----------------------------
INSERT INTO `cms_category` VALUES (150, '省政府', '[]', 'n', '', '', '/shengzhengfu', NULL, NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 2, '1', NULL, 0, '2020-10-26 10:26:28', 57, '2020-10-26 08:58:15', 57, 'shengzhengfu', 1, 0);
INSERT INTO `cms_category` VALUES (151, '要闻动态', '[]', 'n', '', '', '/yaowendongtai', NULL, NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', NULL, 0, '2020-10-26 10:26:23', 57, '2020-10-26 08:58:50', 57, 'yaowendongtai', 0, 0);
INSERT INTO `cms_category` VALUES (152, '政务公开', '[]', 'n', '', '', '/zhengwugongkai', NULL, NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', NULL, 0, '2020-10-26 10:26:42', 57, '2020-10-26 08:58:15', 57, 'zhengwugongkai', 0, 0);
INSERT INTO `cms_category` VALUES (153, '政务服务', '[]', 'n', '', '', '/zhengwufuwu', NULL, NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', NULL, 0, '2020-10-26 10:26:48', 57, '2020-10-26 08:58:50', 57, 'zhengwufuwu', 1, 0);
INSERT INTO `cms_category` VALUES (154, '互动交流', '[]', '', '', '', '/shengzhengfu', NULL, NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', '', 0, NULL, NULL, '2020-10-26 08:58:15', 57, 'shengzhengfu', 0, 0);
INSERT INTO `cms_category` VALUES (155, '数据开放', '[]', 'n', '', '', '/shujukaifang', NULL, NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', NULL, 0, '2020-10-26 10:26:57', 57, '2020-10-26 08:58:50', 57, 'shujukaifang', 1, 0);
INSERT INTO `cms_category` VALUES (156, '美丽江西', '[]', 'n', '', '', '/meilijiangxi', NULL, NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', NULL, 0, '2020-10-26 10:27:19', 57, '2020-10-26 08:58:15', 57, 'meilijiangxi', 1, 0);
INSERT INTO `cms_category` VALUES (158, '江西要闻', '[]', 'n', '', '', '/yaowendongtai/jiangxiyaowen', '151', NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', '151', 0, '2020-10-26 10:27:38', 57, '2020-10-26 09:15:07', 57, 'jiangxiyaowen', 1, 151);
INSERT INTO `cms_category` VALUES (159, '国务院信息', '[]', '', '', '', '/yaowendongtai/guowuyuanxinxi', '151', NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', '151', 0, '2020-10-26 09:16:07', 57, '2020-10-26 09:15:43', 57, 'guowuyuanxinxi', 1, 151);
INSERT INTO `cms_category` VALUES (160, '常见问题', '[]', '', '', '', '/shengzhengfu/changjianwenti', '154', NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', '154', 0, NULL, NULL, '2020-10-26 09:16:59', 57, 'changjianwenti', 1, 154);
INSERT INTO `cms_category` VALUES (161, '政策文件', '[]', '', '', '', '/zhengwugongkai/zhengcewenjian', '152', NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', '152', 0, NULL, NULL, '2020-10-26 09:26:04', 57, 'zhengcewenjian', 1, 152);
INSERT INTO `cms_category` VALUES (162, '政策解读', '[]', '', '', '', '/zhengwugongkai/zhengcejiedu', '152', NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', '152', 0, NULL, NULL, '2020-10-26 09:26:24', 57, 'zhengcejiedu', 1, 152);
INSERT INTO `cms_category` VALUES (163, '网站导航', '[]', '', '', '', '/wangzhandaohang', NULL, NULL, 1, NULL, NULL, NULL, '', NULL, NULL, 0, '3', '', 0, NULL, NULL, '2020-10-26 09:27:43', 57, 'wangzhandaohang', 1, 0);
INSERT INTO `cms_category` VALUES (164, '关于我们', '[]', '', '', '', '/guanyuwomen', NULL, NULL, 1, NULL, NULL, NULL, '', 'about.htm', NULL, 3, '2', '', 0, '2020-10-26 09:50:52', 57, '2020-10-26 09:29:40', 57, 'guanyuwomen', 1, 0);
INSERT INTO `cms_category` VALUES (165, '在线交谈', '[]', '', '', '', '/shengzhengfu/zaixianjiaotan', '154', NULL, 1, NULL, NULL, NULL, '', 'detail.htm', 'list.htm', 0, '1', '154', 0, NULL, NULL, '2020-10-28 16:07:00', 57, 'zaixianjiaotan', 1, 154);
INSERT INTO `cms_category` VALUES (1323080642752925697, '测试栏目', '[]', '', '', '', '/ceshilanmu', NULL, NULL, NULL, NULL, NULL, '', '', 'detail.htm', 'list.htm', 0, '1', '', 0, NULL, 0, '2020-11-02 09:53:01', 57, 'ceshilanmu', 0, 0);

-- ----------------------------
-- Table structure for cms_content
-- ----------------------------
DROP TABLE IF EXISTS `cms_content`;
CREATE TABLE `cms_content`  (
  `id` bigint(20) UNSIGNED NOT NULL,
  `app_id` int(11) NULL DEFAULT NULL COMMENT '文章管理的应用id',
  `content_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章标题',
  `content_category_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属栏目',
  `content_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章跳转链接地址',
  `content_details` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文章内容',
  `content_keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `content_description` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `content_img` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章缩略图',
  `content_sort` int(11) NULL DEFAULT NULL COMMENT '自定义顺序',
  `content_datetime` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `content_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章来源',
  `content_author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章作者',
  `content_display` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否显示',
  `content_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章类型',
  `content_hit` bigint(22) NULL DEFAULT NULL COMMENT '点击次数',
  `del` int(1) NULL DEFAULT 0 COMMENT '删除标记',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_content
-- ----------------------------
INSERT INTO `cms_content` VALUES (223, 1, '刘奇主持召开省委常委会会议 传达学习贯彻第三次中央新疆工作座谈会精神1', '159', NULL, '<p style=\"margin-top: 25px; margin-bottom: 25px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 32.4px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(34, 34, 34); white-space: normal;\">9月27日，江西省委常委会召开会议，传达学习第三次中央新疆工作座谈会精神特别是习近平总书记重要讲话精神，研究我省贯彻落实意见。省委书记刘奇主持会议。</p><p style=\"margin-top: 25px; margin-bottom: 25px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 32.4px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(34, 34, 34); white-space: normal;\">　　会议指出，习近平总书记在第三次中央新疆工作座谈会上的重要讲话，全面总结了第二次中央新疆工作座谈会以来新疆工作取得的重大成效，深入分析了当前新疆工作面临的形势，阐释了新时代党的治疆方略，明确了当前和今后一个时期新疆工作的指导思想、目标任务、方针政策、战略举措，全面部署了推动新疆社会稳定和长治久安的重点工作，具有很强的政治性、思想性、理论性，是指导新时代新疆工作的纲领性文献。我们要深入学习贯彻习近平总书记重要讲话精神，按照第三次中央新疆工作座谈会的部署要求，完整准确贯彻新时代党的治疆方略，牢牢扭住新疆工作总目标，加强同新疆协调配合，不断提升对口援疆综合效益，为建设团结和谐、繁荣富裕、文明进步、安居乐业、生态良好的新时代中国特色社会主义新疆贡献江西力量。</p><p style=\"margin-top: 25px; margin-bottom: 25px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 32.4px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(34, 34, 34); white-space: normal;\">　　会议强调，要站在维护祖国统一、民族团结、国家安全的战略高度，充分认识新疆工作的重要性、长期性和艰巨性，切实增强“四个意识”、坚定“四个自信”、做到“两个维护”，以强烈的责任感使命感，不折不扣落实好、完成好对口援疆任务，推动中央关于新疆工作的各项决策部署落到实处，全力助推新疆社会稳定和长治久安。要坚决维护新疆持续稳定长期稳定，坚定不移抓基层强基础，增强基层组织的凝聚力战斗力，深入开展文化润疆工程，提高公共文化服务水平，广泛开展“民族团结一家亲”活动，推动各族干部群众广泛交往、全面交流、深度交融，铸牢中华民族共同体意识，为促进新疆长治久安奠定民族团结的坚实基础。要坚持以人民为中心助推新疆高质量发展，统筹推进疫情防控和经济社会发展，扎实做好“六稳”工作、全面落实“六保”任务，培育壮大特色优势产业，千方百计促进群众就业创业，形成以产业促就业、促民生、促团结的良好局面。要加大力度保障和改善民生，坚决打赢脱贫攻坚战，大力推进教育援疆，提高传染病防治和医疗卫生水平，不断增强受援地人民群众获得感幸福感安全感。要全面加强在赣新疆籍人员的服务管理，严格落实在赣新疆籍人员综合服务管理制度机制，坚持服务上用心用情、管理上依法依规、教育上入脑入心，让他们在江西“进得来、留得住、过得好”，切实感受到社会主义大家庭的温暖。</p><p style=\"margin-top: 25px; margin-bottom: 25px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 18px; line-height: 32.4px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(34, 34, 34); white-space: normal;\">　　会议强调，要始终心系“国之大者”，提高政治站位，坚决对标新时代党的治疆方略，强化党的领导，强化资金保障，强化队伍建设，强化担当实干，扎实做好对口援疆各项工作，以实实在在的业绩向各族干部群众交出满意答卷。要满腔热情关心关爱援疆干部人才，让他们全身心投入对口援疆事业。要高质量推进江西省“十四五”对口援疆工作规划编制，为受援地经济社会发展提供强有力支撑。 (记者刘勇)</p><p><br/></p>', '', '9月27日，江西省委常委会召开会议，传达学习第三次中央新疆工作座谈会精神特别是习近平总书记重要讲话精神，研究我省贯彻落实意见。省委书记刘奇主持会议。', '[]', 0, '2020-10-26 09:20:36', '', '', '0', 'h', 31, 0, '2020-10-28 16:40:47', 57, '2020-10-26 09:21:08', 57);
INSERT INTO `cms_content` VALUES (224, 1, '省十三届人大常委会第二十三次会议举行', '158', NULL, '<p><span style=\"color: rgb(51, 51, 51); font-family: arial; text-align: justify; background-color: rgb(255, 255, 255);\">9月24日上午，省十三届人大常委会第二十三次会议在济南举行第二次全体会议。省人大常委会党组书记、副主任于晓明，副主任王随莲、齐涛、王云鹏、王华，秘书长孙建功出席；副主任王良主持。</span></p>', '', '', '[{\"url\":\"/upload/1/cms/content/1603868874881.jpg\",\"name\":\"619001f2022b1e3a232ed0d8da58b8a7.jpg\",\"path\":\"/upload/1/cms/content/1603868874881.jpg\",\"uid\":1603868874828,\"status\":\"success\"}]', 0, '2020-10-26 09:21:44', '', '', '0', 'f', 4, 0, '2020-10-28 15:09:05', 57, '2020-10-26 09:22:38', 57);
INSERT INTO `cms_content` VALUES (225, 1, '省十三届人大常委会第二十二次会议举行刘奇主持', '158', NULL, '<p style=\"margin-top: 0px; margin-bottom: 18px; padding: 0px; color: rgb(77, 79, 83); font-family: &quot;Hiragino Sans GB&quot;, &quot;Microsoft Yahei&quot;, &quot;\\\\5FAE软雅黑&quot;, SimSun, &quot;\\\\5B8B体&quot;, Arial; font-size: 18px; letter-spacing: 1px; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;原标题：省十三届人大常委会第二十二次会议举行刘奇主持</p><p><span style=\"color: rgb(77, 79, 83); font-family: &quot;Hiragino Sans GB&quot;, &quot;Microsoft Yahei&quot;, &quot;\\\\5FAE软雅黑&quot;, SimSun, &quot;\\\\5B8B体&quot;, Arial; font-size: 18px; letter-spacing: 1px; background-color: rgb(255, 255, 255);\">来源：江西日报</span><br style=\"color: rgb(77, 79, 83); font-family: &quot;Hiragino Sans GB&quot;, &quot;Microsoft Yahei&quot;, &quot;\\\\5FAE软雅黑&quot;, SimSun, &quot;\\\\5B8B体&quot;, Arial; font-size: 18px; letter-spacing: 1px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(77, 79, 83); font-family: &quot;Hiragino Sans GB&quot;, &quot;Microsoft Yahei&quot;, &quot;\\\\5FAE软雅黑&quot;, SimSun, &quot;\\\\5B8B体&quot;, Arial; font-size: 18px; letter-spacing: 1px; white-space: normal; background-color: rgb(255, 255, 255);\"/></p><p cms-style=\"font-L\" style=\"margin-top: 0px; margin-bottom: 18px; padding: 0px; font-size: 18px; color: rgb(77, 79, 83); font-family: &quot;Hiragino Sans GB&quot;, &quot;Microsoft Yahei&quot;, &quot;\\\\5FAE软雅黑&quot;, SimSun, &quot;\\\\5B8B体&quot;, Arial; letter-spacing: 1px; white-space: normal; background-color: rgb(255, 255, 255);\">　　8月31日，省十三届人大常委会第二十二次会议在南昌举行。省委书记、省人大常委会主任刘奇主持全体会议。省人大常委会党组书记、副主任周萌，副主任朱虹、马志武、龚建华、冯桃莲、胡世忠，秘书长韩军和委员共54人出席会议。</p><p cms-style=\"font-L\" style=\"margin-top: 0px; margin-bottom: 18px; padding: 0px; font-size: 18px; color: rgb(77, 79, 83); font-family: &quot;Hiragino Sans GB&quot;, &quot;Microsoft Yahei&quot;, &quot;\\\\5FAE软雅黑&quot;, SimSun, &quot;\\\\5B8B体&quot;, Arial; letter-spacing: 1px; white-space: normal; background-color: rgb(255, 255, 255);\">　　会议听取了省委常委、省委组织部部长刘强作的关于人事事项的说明，省人民政府副省长拟任人选罗小云到会与省人大常委会组成人员见面，并作任前发言。</p><p cms-style=\"font-L\" style=\"margin-top: 0px; margin-bottom: 18px; padding: 0px; font-size: 18px; color: rgb(77, 79, 83); font-family: &quot;Hiragino Sans GB&quot;, &quot;Microsoft Yahei&quot;, &quot;\\\\5FAE软雅黑&quot;, SimSun, &quot;\\\\5B8B体&quot;, Arial; letter-spacing: 1px; white-space: normal; background-color: rgb(255, 255, 255);\">　　会议审议并表决，决定任命罗小云为江西省人民政府副省长。按照《江西省实施宪法宣誓制度办法》，罗小云进行了宪法宣誓。</p><p cms-style=\"font-L\" style=\"margin-top: 0px; margin-bottom: 18px; padding: 0px; font-size: 18px; color: rgb(77, 79, 83); font-family: &quot;Hiragino Sans GB&quot;, &quot;Microsoft Yahei&quot;, &quot;\\\\5FAE软雅黑&quot;, SimSun, &quot;\\\\5B8B体&quot;, Arial; letter-spacing: 1px; white-space: normal; background-color: rgb(255, 255, 255);\">　　省监察委员会代理主任马森述，省人民政府副省长秦义，省高级人民法院院长葛晓燕、省人民检察院检察长田云鹏，省人大常委会副秘书长，省人大专门委员会成员，省人大常委会工作部门负责同志列席了会议。</p><p><br/></p>', '', '', '[{\"url\":\"/upload/1/cms/content/1603868885841.png\",\"name\":\"731ea58ddf610955400bd9e67edf0e73.png\",\"path\":\"/upload/1/cms/content/1603868885841.png\",\"uid\":1603868885742,\"status\":\"success\"}]', 0, '2020-10-26 09:22:48', '', '', '0', 'f', 2, 0, '2020-10-28 15:09:09', 57, '2020-10-26 09:23:45', 57);
INSERT INTO `cms_content` VALUES (226, 1, '江西省十三届人大常委会第二十一次会议举行', '158', NULL, '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">中国江西网/江西头条客户端讯 记者<span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">王琴红</span>、实习生<span class=\"bjh-strong\" style=\"font-size: 18px; font-weight: 700;\">蔡紫欣</span>报道：7月22日，江西省十三届人大常委会第二十一次会议第一次全体会议在南昌举行。会议听取了关于《江西省企业工会工作条例(草案)》修改情况的汇报，关于《江西省标准化条例(修订草案)》修改情况的汇报，关于《江西省中小企业促进条例(修订草案)》的说明和关于该修订草案的审查报告，关于《江西省实施&lt;中华人民共和国野生动物保护法&gt;办法修正案(草案)》的说明和关于该修正案草案的审查报告，关于《九江市文明行为促进条例》等5件地方性法规审查意见的报告，关于《江西省人民代表大会常务委员会关于南昌市新建区、红谷滩区人民代表大会代表名额和红谷滩区人民代表大会常务委员会组成人员名额的决定(草案)》的说明和代表资格的审查报告。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\">会议现场</p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">会议还提请审议人事任免议案。</span></p><p style=\"margin-top: 22px; margin-bottom: 0px; padding: 0px; line-height: 24px; color: rgb(51, 51, 51); text-align: justify; font-family: arial; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"bjh-p\">根据安排，江西省十三届人大常委会第二十一次会议将于24日闭会。23日、24日，分别召开第二次、第三次全体会议。</span></p><p><br/></p>', '', '', '[{\"url\":\"/upload/1/cms/content/1603868894525.jpg\",\"name\":\"ff8e20b94a1e459e89fa095324095793.jpg\",\"path\":\"/upload/1/cms/content/1603868894525.jpg\",\"uid\":1603868894510,\"status\":\"success\"}]', 0, '2020-10-26 09:24:05', '', '', '0', 'f', NULL, 0, '2020-10-28 15:09:14', 57, '2020-10-26 09:24:33', 57);
INSERT INTO `cms_content` VALUES (227, 1, '开学了，校园疫情防控怎么做？', '160', NULL, '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学校一直是新冠肺炎疫情防控的重点场所，为科学指导高等学校、中小学校和托幼机构做好秋冬季新冠肺炎疫情防控工作，有序推进复学复课，国家卫生健康委在线访谈栏目特别邀请了中国疾控中心环境所沈瑾副研究员、北京市疾控中心学校卫生所郭欣主任医师、中国疾控中心学校卫生中心、北京大学儿童青少年卫生研究所马军教授回答网友关心的问题。</p>', NULL, NULL, '[]', 0, '2020-10-26 09:30:14', NULL, NULL, '0', '', NULL, 0, NULL, NULL, '2020-10-26 09:30:35', 57);
INSERT INTO `cms_content` VALUES (228, 1, '中国人民银行有关部门负责人就部分金融机构侵害消费者金融信息安全权案件相关情况答记者问 ', '160', NULL, '<p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\"><strong>一、介绍一下此次部分金融机构侵害消费者金融信息安全权的案件情况？</strong></p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">人民银行一直高度重视消费者金融信息保护工作，坚持对侵害消费者金融信息安全行为“零容忍”，对侵犯金融消费者合法权益的违法违规行为坚决依法严厉打击。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">前期，部分媒体报道了个别金融机构员工涉嫌泄露消费者金融信息。人民银行依据属地原则调查立案，发现涉案金融机构存在侵害消费者金融信息安全权的行为，依法依规对涉案金融机构严肃查处。人民银行在依法作出行政处罚的同时，责令涉案金融机构以此为戒，全面排查消费者金融信息保护安全隐患，及时进行整改。一是在制度建设层面，明确要求其进一步健全完善消费者金融信息收集、保存、使用、对外提供等环节的内控制度，采取有效措施将各项制度落到实处。二是在系统建设方面，金融机构要持续改进完善业务系统和反洗钱系统，建立用户异常行为监测模型，定期监测并堵塞系统存在的技术漏洞等安全隐患；完善系统功能模块，确保系统生成日志能及时、准确、全面地记录信息数据的查询和下载操作。特别是要畅通系统使用人员的意见反馈渠道，避免业务、技术“两层皮”的现象。三是在人员管理方面，要不断强化相关措施。对接触消费者金融信息的岗位人员合理设置权限，并采取内部审批等有效措施进行权限控制，全面开展员工业务培训和警示教育工作，有效避免泄露消费者金融信息行为的再次发生。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">截至目前，各涉案机构均已进行整改和问责，进一步健全消费者金融信息保护内部控制机制，完善信息安全技术防范措施，强化从业人员消费者金融信息安全意识。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\"><strong>二、金融机构在消费者金融信息安全管理上应承担哪些主体责任？</strong></p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">总体上看，近年来金融机构消费者金融信息保护工作取得了许多成效。但从这次事件看，暴露出部分金融机构金融消费权益保护意识不足，消费者金融信息保护工作机制落实不到位，内部控制仍需持续强化，技术安全防范能力有待进一步提升等问题。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">保障消费者金融信息安全是金融机构的法定职责，金融机构要切实履行主体责任。一要强化全流程管控，将法律法规和监管要求逐项分解落实到业务运行的各个环节，细化到业务岗位职责中。二要加强员工教育，强化对中高级管理人员和基层业务人员的消费者金融信息安全教育，培养消费者金融信息安全红线“不能碰、不想碰”的底线思维。三要规范员工行为，合理设置分级授权，完善授权审批流程，避免消费者金融信息使用环节“一手清”。四要加强技防手段，及早发现风险隐患。五要平衡发展与安全的关系，不能以牺牲消费者金融信息安全为代价换取业务发展。六要发挥投诉预警纠偏作用，主动查找漏洞或薄弱环节，及时研究问题，填补管理漏洞，消除风险隐患。七要强化责任追究，对有关责任人员要予以严肃处理，强化震慑。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\"><strong>三、人民银行在消费者金融信息保护方面开展了哪些主要工作？</strong></p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">近年来，人民银行积极推动消费者金融信息保护制度建设，出台消费者金融信息保护规范性文件，要求金融机构严格防控金融消费者信息泄露风险，保障金融消费者信息安全。为进一步加强消费者金融信息保护力度，提升消费者金融信息保护法律法规层级，《个人金融信息（数据）保护试行办法》《中国人民银行金融消费者权益保护实施办法》已列入人民银行规章制定工作计划，其中《中国人民银行金融消费者权益保护实施办法》已于9月18日发布，自11月1日起施行，该实施办法在延续原有的金融信息保护专章的基础上，以实现保护金融消费者信息安全权为目的，从信息收集、披露和告知、使用、管理、存储和保密等方面进行了优化。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">人民银行坚持对侵害消费者金融信息安全行为“零容忍”，对侵犯金融消费者合法权益的违法违规行为坚决依法严厉打击。自2013年以来每年均开展以消费者金融信息保护为主要内容的监督检查工作，严肃查处相关机构在消费者金融信息保护方面的违法违规行为。此外，还不断提高非现场监管水平，通过金融消费权益保护评估等方式，对金融机构进行持续、动态监测。对金融机构超范围收集、非法存储、超范围使用或者泄露消费者金融信息等违反消费者金融信息保护规定的行为依法进行严肃查处，强化对信息违法违规行为的震慑力。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">在普及金融知识和消费者教育方面，人民银行开展了内容丰富、形式多样的活动，提升金融消费者对个人金融信息的自我保护和防范诈骗等风险意识。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\"><strong>四、金融机构在反洗钱信息保密方面应承担哪些法律义务？人民银行在这方面开展了哪些主要工作？</strong></p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">《反洗钱法》第五条明确规定对依法履行反洗钱职责或者义务获得的客户身份资料和交易信息，应当予以保密；非依法律规定，不得向任何单位和个人提供。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">目前金融机构反洗钱信息保密方面的要求主要包括：金融机构及其工作人员对依法履行反洗钱义务获得的客户身份资料和交易信息应当予以保密，非依法律规定，不得向任何单位和个人提供；金融机构及其工作人员应当对依法履行大额交易和可疑交易报告义务获得的客户身份资料和交易信息，对依法监测、分析、报告可疑交易的有关情况予以保密，不得违反规定向任何单位和个人提供；金融机构应采取必要管理措施和技术措施，防止客户身份资料和交易记录的缺失、损毁，防止泄露客户身份信息和交易信息；金融机构应当对本机构的监测标准及监测措施严格保密，建立相应制度或要求规范监测标准的知悉和使用范围；金融机构不得向客户或其他与反洗钱工作无关的第三方泄露客户风险等级信息。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">人民银行不断加强反洗钱信息保密制度执行情况的监督管理，始终保持对反洗钱信息泄露的执法警惕，将金融机构履行反洗钱信息保密义务作为风险评估、分类评级、执法检查、行政处罚、监管走访等日常监督管理的重要内容，持续加大对金融机构履行反洗钱信息保密义务的监管力度，不断压实金融机构反洗钱信息保密的主体责任。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">在反洗钱信息保密宣传培训方面，人民银行持续拓宽宣传思路，创新宣传形式，全面提高全社会的反洗钱保密意识；督促金融机构有效开展反洗钱信息保密教育培训，强化典型案例警示教育，切实提升金融从业人员反洗钱信息保密意识。</p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\"><strong>五、金融消费者应该如何保护自己的消费者金融信息安全？</strong></p><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; list-style: none; color: rgb(51, 51, 51); font-family: 宋体; font-size: 12pt; white-space: normal; background-color: rgb(255, 255, 255); text-indent: 2em;\">消费者金融信息，一般包括个人身份信息、财产信息、账户信息、信用信息、金融交易信息及其他反映特定个人某些情况的信息。这些重要信息一旦泄露，可能导致金融消费者自身以及家人、亲友的精神、名誉、财产遭受损害。金融消费者保护自己的消费者金融信息安全，重点要把握好以下几个方面：一是要保管好身份证件、银行卡、银行（支付）账户等，不要转借他人使用；二是切勿向他人透露个人金融信息、财产状况等基本信息，不要随意在各类线上线下渠道留下个人金融信息；三是尽量亲自办理金融业务，切勿委托不熟悉的人或中介代办，谨防个人金融信息被盗；四是提供个人身份证件复印件办理各类业务时，要在复印件上注明使用用途；五是不要随意丢弃刷卡签购单、取款凭条、信用卡对账单等，及时销毁作废的金融业务单据；六是不要轻易点击来历不明的手机短信、邮件和不明链接，不要随意扫描来历不明的二维码，谨慎使用公共WIFI、免密WIFI；七是发现个人金融信息泄露风险，要及时联系公安等部门维权。</p><p><br/></p>', NULL, NULL, '[]', 0, '2020-10-26 09:31:15', NULL, NULL, '0', '', NULL, 0, NULL, NULL, '2020-10-26 09:31:51', 57);
INSERT INTO `cms_content` VALUES (229, 1, '电梯安全宣传周', '165', NULL, '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; border: medium none; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 2em; white-space: normal; background-color: rgb(255, 255, 255);\">各位网友：</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; border: medium none; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 2em; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp; &nbsp; &nbsp; 近年来，我省电梯数量快速增长，目前全省总数已达16.5万台，成为广大群众重要的交通工具。同时，广大群众和社会各界对安全乘用电梯、规范管理电梯也日益关注。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; border: medium none; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 2em; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp; &nbsp; &nbsp; 为方便社会公众更好地了解我省电梯安全状况和监管工作情况，9月30日下午15：00至16：00，江西省人民政府网将邀请省市场监管局章志键二级巡视员以及有关同志与各位网友交流互动。</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; border: medium none; padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑; line-height: 2em; white-space: normal; background-color: rgb(255, 255, 255);\">&nbsp; &nbsp; &nbsp; 欢迎广大网友登录www.jiangxi.gov.cn“在线访谈”栏目踊跃提问，积极参与在线交流，也可以通过本页的留言窗口提前向我们提出相关问题。</p><p><br/></p>', '', '江西省人民政府', '[{\"url\":\"blob:http://wujj.store.new.mingsoft.net:5107/70d71786-d53f-4b7d-b991-a25470632acf\",\"name\":\"1602065099002.jpg\",\"path\":\"/upload/1/cms/content/1603873778103.jpg\",\"uid\":1603873778080,\"status\":\"success\"}]', 0, '2020-09-30 16:07:10', '江西省人民政府网', '', '0', '', NULL, 0, '2020-10-28 16:29:40', 57, '2020-10-28 16:13:34', 57);
INSERT INTO `cms_content` VALUES (1322362185324281858, 1, '1', '1322103018739027970', NULL, '', '', '', '[]', 0, '2020-10-31 10:18:04', '', '', '0', '', NULL, 1, NULL, 0, '2020-10-31 10:18:08', 57);
INSERT INTO `cms_content` VALUES (1323080539543687169, NULL, '测试文章', '158', NULL, '', '', '', '[]', 0, '2020-11-02 09:52:14', '', '', '0', '', NULL, 0, NULL, 0, '2020-11-02 09:52:37', 57);

-- ----------------------------
-- Table structure for cms_history_log
-- ----------------------------
DROP TABLE IF EXISTS `cms_history_log`;
CREATE TABLE `cms_history_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `hl_is_mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为移动端',
  `hl_people_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `hl_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览ip',
  `content_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章编号',
  `del` int(1) NULL DEFAULT 0 COMMENT '删除标记',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章浏览记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_history_log
-- ----------------------------
INSERT INTO `cms_history_log` VALUES (1, '0', NULL, '127.0.0.2', '7', 0, NULL, NULL, NULL, NULL);
INSERT INTO `cms_history_log` VALUES (2, '0', NULL, '127.0.0.2', '2', 0, NULL, NULL, NULL, NULL);
INSERT INTO `cms_history_log` VALUES (3, '0', NULL, '127.0.0.1', '2', 0, NULL, NULL, NULL, NULL);
INSERT INTO `cms_history_log` VALUES (4, '0', NULL, '127.0.0.1', '8', 0, NULL, NULL, NULL, NULL);
INSERT INTO `cms_history_log` VALUES (5, '0', NULL, '127.0.0.1', '7', 0, NULL, NULL, NULL, NULL);
INSERT INTO `cms_history_log` VALUES (6, '0', NULL, '127.0.0.1', '224', 0, NULL, NULL, '2020-10-29 14:12:10', NULL);

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件编号',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '文件分类编号',
  `app_id` int(11) NULL DEFAULT NULL COMMENT 'APP编号',
  `file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件链接',
  `file_size` int(11) NULL DEFAULT NULL COMMENT '文件大小',
  `file_json` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件详情Json数据',
  `file_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型：图片、音频、视频等',
  `is_child` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子业务',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` int(11) NULL DEFAULT NULL COMMENT '更新者',
  `create_by` int(11) NULL DEFAULT NULL COMMENT '创建者',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `del` int(1) NULL DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基础文件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `manager_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '管理员id(主键)',
  `manager_name` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员用户名',
  `manager_nickname` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员昵称',
  `manager_password` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员密码',
  `manager_roleid` int(11) NULL DEFAULT NULL COMMENT '角色编号',
  `manager_peopleid` bigint(22) NULL DEFAULT 0 COMMENT '用户编号即商家编号',
  `manager_time` datetime(0) NULL DEFAULT NULL COMMENT '管理员创建时间',
  `manager_system_skin_id` int(11) NULL DEFAULT 0 COMMENT '管理员主界面样式',
  `manager_admin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `create_by` int(11) NULL DEFAULT NULL,
  `del` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`manager_id`) USING BTREE,
  INDEX `fk_manager_role_1`(`manager_roleid`) USING BTREE,
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`manager_roleid`) REFERENCES `role` (`role_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (57, 'msopen', 'msopen', '9d8622060de5f24937b60585c3f4d66b', 48, 0, NULL, 0, 'super', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `manager` VALUES (58, 'asdad', 'msopenadad', 'f9354b3c82482150956b904f71296b8c', 48, 0, '2020-10-28 17:46:26', 0, NULL, '2020-10-28 17:46:26', NULL, 0, 57, 0);
INSERT INTO `manager` VALUES (59, 'dddd', 'msopen', '9d8622060de5f24937b60585c3f4d66b', 48, 0, '2020-10-29 08:34:14', 0, NULL, '2020-10-29 08:34:14', NULL, 0, 57, 0);
INSERT INTO `manager` VALUES (60, 'adasd', 'msopend', '9d8622060de5f24937b60585c3f4d66b', 48, 0, '2020-10-29 08:36:16', 0, NULL, '2020-10-29 08:36:16', NULL, 0, 57, 0);

-- ----------------------------
-- Table structure for mdiy_dict
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_dict`;
CREATE TABLE `mdiy_dict`  (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `app_id` int(11) NULL DEFAULT NULL COMMENT '应用编号',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '类型',
  `dict_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  `is_child` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '扩展业务标记',
  `dict_enable` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '1' COMMENT '启用状态',
  `dict_sort` int(10) NOT NULL DEFAULT 0 COMMENT '排序（升序）',
  `dict_parent_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '父级编号',
  `dict_remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注信息',
  `create_by` int(64) NULL DEFAULT 0 COMMENT '创建者',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` int(64) NULL DEFAULT 0 COMMENT '更新者',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del` int(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`dict_id`) USING BTREE,
  INDEX `fk_mdiy_dict`(`app_id`) USING BTREE,
  INDEX `dict_value`(`dict_value`) USING BTREE,
  INDEX `dict_label`(`dict_label`) USING BTREE,
  CONSTRAINT `mdiy_dict_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 644 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_dict
-- ----------------------------
INSERT INTO `mdiy_dict` VALUES (1, 1, 'f', '幻灯', '文章属性', NULL, NULL, '1', 3, '0', NULL, 0, NULL, 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (2, 1, 'p', '图片', '文章属性', NULL, NULL, '1', 1, '0', NULL, 0, NULL, 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (3, 1, 'c', '推荐', '文章属性', NULL, NULL, '1', 4, '0', NULL, 0, NULL, 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (4, 1, 'h', '头条', '文章属性', NULL, NULL, '1', 2, '0', NULL, 0, NULL, 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (621, 1, 'zdymx_wz', '文章', '自定义模型', NULL, '0', '1', 0, NULL, NULL, 0, NULL, 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (638, 1, '3', '逻辑表', '标签类型', NULL, '0', '1', 0, NULL, NULL, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (639, 1, '0', '单条记录标签', '标签类型', NULL, '0', '1', 0, NULL, NULL, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (640, 1, '1', '多记录标签', '标签类型', NULL, '0', '1', 0, NULL, NULL, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (641, 1, '2', '功能标签', '标签类型', NULL, '0', '1', 0, NULL, NULL, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (642, 1, 'cms', '文章', '自定义页面类型', NULL, NULL, '1', 0, '0', NULL, 0, '2019-12-28 14:32:46', 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (643, 1, 't', '推荐', '栏目属性', NULL, NULL, '1', 0, '0', NULL, 0, '2020-01-09 10:38:26', 0, NULL, 0);

-- ----------------------------
-- Table structure for mdiy_form
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_form`;
CREATE TABLE `mdiy_form`  (
  `form_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `form_tips_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自定义表单提示文字',
  `form_table_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自定义表单表名',
  `form_app_id` int(11) NOT NULL COMMENT '自定义表单关联的应用编号',
  `create_by` int(11) NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`form_id`) USING BTREE,
  INDEX `fk_mdiy_form`(`form_app_id`) USING BTREE,
  CONSTRAINT `mdiy_form_ibfk_1` FOREIGN KEY (`form_app_id`) REFERENCES `app` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义表单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mdiy_model
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_model`;
CREATE TABLE `mdiy_model`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `model_json` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'json',
  `app_id` int(11) NULL DEFAULT NULL COMMENT '应用编号',
  `model_table_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模型表名',
  `model_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `model_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模型类型',
  `del` int(1) NULL DEFAULT NULL COMMENT '删除标记',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `model_field` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `model_custom_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义模型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_model
-- ----------------------------
INSERT INTO `mdiy_model` VALUES (41, '{\"html\":\"<template id=\\\"custom-model\\\">\\r\\n    <el-form ref=\\\"form\\\" :model=\\\"form\\\" :rules=\\\"rules\\\" label-width=\\\"120px\\\" label-position=\\\"right\\\" size=\\\"small\\\">\\r\\n            <el-form-item  label=\\\"姓名\\\" prop=\\\"name\\\"\\r\\n>\\r\\n                <el-input v-model=\\\"form.name\\\"\\r\\n                          :disabled=\\\"false\\\"\\r\\n                          :style=\\\"{width:  \'100%\'}\\\"\\r\\n                          :clearable=\\\"true\\\"\\r\\n                          placeholder=\\\"请输入姓名\\\">\\r\\n                </el-input>\\r\\n            </el-form-item>\\r\\n            <el-form-item  label=\\\"手机\\\" prop=\\\"phone\\\"\\r\\n>\\r\\n                <el-input v-model=\\\"form.phone\\\"\\r\\n                          :disabled=\\\"false\\\"\\r\\n                          :style=\\\"{width:  \'100%\'}\\\"\\r\\n                          :clearable=\\\"true\\\"\\r\\n                          placeholder=\\\"请输入手机\\\">\\r\\n                </el-input>\\r\\n            </el-form-item>\\r\\n            <el-form-item  label=\\\"留言\\\" prop=\\\"words\\\"\\r\\n>\\r\\n                <el-input\\r\\n                        type=\\\"textarea\\\" :rows=\\\"5\\\"\\r\\n                        :disabled=\\\"false\\\"\\r\\n\\r\\n                        v-model=\\\"form.words\\\"\\r\\n                        :style=\\\"{width: \'100%\'}\\\"\\r\\n                        placeholder=\\\"请输入留言\\\">\\r\\n                </el-input>\\r\\n            </el-form-item>\\r\\n    </el-form>\\r\\n</template>\\r\\n\",\"script\":\"       var custom_model = Vue.component(\\\"custom-model\\\",{\\r\\n            el: \'#custom-model\',\\r\\n            data() {\\r\\n                return {\\r\\n                    modelId:0,\\r\\n                    //表单数据\\r\\n                    form: {\\r\\n                        linkId:0,\\r\\n                    // 姓名\\r\\n                    name:\'\',\\r\\n                    // 手机\\r\\n                    phone:\'\',\\r\\n                    // 留言\\r\\n                    words:\'\',\\r\\n                    },\\r\\n                    rules:{\\r\\n                    },\\r\\n\\r\\n                }\\r\\n            },\\r\\n            watch:{\\r\\n            },\\r\\n            computed:{\\r\\n            },\\r\\n            methods: {\\r\\n                validate(){\\r\\n                    var b = false\\r\\n                    this.$refs.form.validate((valid) => {\\r\\n                        b = valid;\\r\\n                    });\\r\\n                    return b;\\r\\n                },\\r\\n                save() {\\r\\n                    var that = this;\\r\\n                    var success = false;\\r\\n                    var url = ms.manager + \\\"/mdiy/model/data/save.do\\\"\\r\\n                    if (that.form.id > 0) {\\r\\n                    url = ms.manager + \\\"/mdiy/model/data/update.do\\\";\\r\\n                    }\\r\\n                    this.$refs.form.validate((valid) => {\\r\\n                        if (valid) {\\r\\n                            var data = JSON.parse(JSON.stringify(that.form));\\r\\n                            data.modelId = that.modelId;\\r\\n                            ms.http.post(url, data).then(function (res) {\\r\\n                                if (res.data.id > 0) {\\r\\n                                    success = true;\\r\\n                                }\\r\\n                            });\\r\\n                        } else {\\r\\n                            return false;\\r\\n                        }\\r\\n                    })\\r\\n                    return success;\\r\\n                },\\r\\n                //获取当前意见反馈\\r\\n                get(id) {\\r\\n                    var that = this;\\r\\n                    ms.http.get(ms.manager + \\\"/mdiy/model/data.do\\\", {modelId:this.modelId,linkId:id}).then(function (res) {\\r\\n                            if(res.result&&res.data){\\r\\n                            that.form = res.data;\\r\\n                        }\\r\\n                    }).catch(function (err) {\\r\\n                        console.log(err);\\r\\n                    });\\r\\n                },\\r\\n            },\\r\\n            created() {\\r\\n                this.get(this.form.linkId);\\r\\n            }\\r\\n        });\\r\\n\\r\\n\"}', 1, 'mdiy_post_feedback', '意见反馈', NULL, 0, NULL, 0, NULL, 0, '[\r\n{\r\n            \"model\":\"name\",\r\n            \"key\":\"name\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"姓名\",\r\n            \"type\":\"input\"\r\n            }\r\n            ,{\r\n            \"model\":\"phone\",\r\n            \"key\":\"phone\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"手机\",\r\n            \"type\":\"input\"\r\n            }\r\n            ,{\r\n            \"model\":\"words\",\r\n            \"key\":\"words\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"留言\",\r\n            \"type\":\"textarea\"\r\n            }\r\n]', 'post');

-- ----------------------------
-- Table structure for mdiy_page
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_page`;
CREATE TABLE `mdiy_page`  (
  `page_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `app_id` int(11) NOT NULL COMMENT '应用id',
  `page_model_id` int(11) NULL DEFAULT NULL COMMENT '模块id',
  `page_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义页面绑定模板的路径',
  `page_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义页面标题',
  `page_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典分类字段',
  `page_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义页面访问路径',
  `create_date` datetime(0) NULL DEFAULT NULL,
  `create_by` int(11) NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  `del` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`page_id`) USING BTREE,
  INDEX `index_page_key`(`page_key`) USING BTREE,
  INDEX `index_page_app_id`(`app_id`) USING BTREE,
  INDEX `index_page_model_id`(`page_model_id`) USING BTREE,
  CONSTRAINT `mdiy_page_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义页面表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mdiy_page
-- ----------------------------
INSERT INTO `mdiy_page` VALUES (1, 1, 0, 'people/register.htm', '注册', 'cms', 'register', NULL, NULL, NULL, '2020-01-09 19:56:45', 0);
INSERT INTO `mdiy_page` VALUES (2, 1, 0, 'people/login.htm', '登入', 'cms', 'login', NULL, NULL, NULL, '2020-01-09 19:56:40', 0);
INSERT INTO `mdiy_page` VALUES (3, 1, 0, 'people/center.htm', '个人中心', 'cms', 'people/center', NULL, NULL, NULL, '2020-01-09 19:56:29', 0);
INSERT INTO `mdiy_page` VALUES (4, 1, 0, 'people/passworld-change.htm', '修改密码', 'cms', 'people/password-change', NULL, NULL, NULL, '2020-01-09 14:46:52', 0);

-- ----------------------------
-- Table structure for mdiy_post_feedback
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_post_feedback`;
CREATE TABLE `mdiy_post_feedback`  (
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `words` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言',
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '意见反馈' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mdiy_tag
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_tag`;
CREATE TABLE `mdiy_tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名称',
  `tag_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签类型',
  `tag_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_tag
-- ----------------------------
INSERT INTO `mdiy_tag` VALUES (3, 'arclist', 'page', '文章列表');
INSERT INTO `mdiy_tag` VALUES (4, 'channel', 'list', '通用栏目');
INSERT INTO `mdiy_tag` VALUES (5, 'global', 'single', '全局');
INSERT INTO `mdiy_tag` VALUES (7, 'field', 'single', '文章内容');
INSERT INTO `mdiy_tag` VALUES (8, 'pre', 'single', '文章上一篇');
INSERT INTO `mdiy_tag` VALUES (9, 'page', 'single', '通用分页');
INSERT INTO `mdiy_tag` VALUES (10, 'next', 'single', '文章下一篇');

-- ----------------------------
-- Table structure for mdiy_tag_sql
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_tag_sql`;
CREATE TABLE `mdiy_tag_sql`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL COMMENT '自定义标签编号',
  `tag_sql` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '自定义sql支持ftl写法',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序升序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_mdiy_tag_id`(`tag_id`) USING BTREE,
  CONSTRAINT `mdiy_tag_sql_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `mdiy_tag` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签对应多个sql语句' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mdiy_tag_sql
-- ----------------------------
INSERT INTO `mdiy_tag_sql` VALUES (5, 3, '<#assign _typeid=\'\'/>\r\n<#assign _size=\'20\'/>\r\n<#if column?? && column.id?? && column.id?number gt 0>\r\n  <#assign  _typeid=\'${column.id}\'>\r\n</#if>\r\n<#if typeid??>\r\n  <#assign  _typeid=\'${typeid}\'>\r\n</#if>\r\n<#if size??>\r\n  <#assign  _size=\'${size}\'>\r\n</#if>\r\n<#if orderby?? >\r\n      <#if orderby==\'date\'> \r\n	   <#assign  _orderby=\'content_datetime\'>\r\n      <#elseif orderby==\'updatedate\'>\r\n <#assign  _orderby=\'content_updatetime\'>\r\n      <#elseif orderby==\'hit\'> \r\n	  <#assign  _orderby=\'content_hit\'>\r\n      <#elseif orderby==\'sort\'>\r\n	   <#assign  _orderby=\'content_sort\'>\r\n      <#else><#assign  _orderby=\'cms_content.id\'></#if>\r\n   <#else>\r\n   <#assign  _orderby=\'cms_content.id\'>\r\n  </#if>\r\nSELECT\r\n  cms_content.id AS id,\r\n  content_title AS title,\r\n  content_title AS fulltitle,\r\n  content_author AS author,\r\n  content_source AS source,\r\n  content_details AS content,\r\n  category.category_title AS typename,\r\n  category.id AS typeid,\r\n  category.category_img AS typelitpic,\r\n  <#--列表页动态链接-->\r\n  <#if isDo?? && isDo>\r\n  CONCAT(\'/${modelName}/list.do?typeid=\', category.category_id) as typelink,\r\n  <#else>\r\n  (SELECT \'index.html\') AS typelink,\r\n  </#if>\r\n  content_img AS litpic,\r\n  <#--内容页动态链接-->\r\n  <#if isDo?? && isDo>\r\n   CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\r\n  <#else>\r\n\r\n  CONCAT(category.category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\r\n  </#if>\r\n  content_datetime AS \"date\",<#if tableName??>${tableName}.*,</#if>\r\n  content_description AS descrip,\r\n  content_hit AS hit,\r\n  content_type AS flag,\r\n  category_title AS typetitle,\r\n  cms_content.content_keyword AS keyword \r\nFROM\r\n  cms_content\r\n  LEFT JOIN cms_category as category ON content_category_id = category.id\r\n  <#--判断是否有自定义模型表-->\r\n  <#if tableName??>LEFT JOIN ${tableName} ON ${tableName}.link_id=cms_content.id </#if>\r\nWHERE  \r\n  content_display=0 \r\n	and cms_content.del=0 \r\n  <#--根据站点编号查询-->\r\n  <#if appId?? >\r\n    and cms_content.app_id=${appId}\r\n	and cms_content.id>0\r\n  </#if>\r\n  <#--判断是否有搜索分类集合-->\r\n  <#if search??>\r\n		<#if search.categoryIds??>and FIND_IN_SET(category.id,\'${search.categoryIds}\')</#if>\r\n			<#--标题-->\r\n			<#if search.content_title??> and content_title like CONCAT(\'%\',\'${search.content_title}\',\'%\')</#if>\r\n			<#--作者-->\r\n			<#if search.content_author??> and content_author like CONCAT(\'%\',\'${search.content_author}\',\'%\')</#if>\r\n			<#--来源-->\r\n			<#if search.content_source??> and content_source like CONCAT(\'%\',\'${search.content_source}\',\'%\')</#if>\r\n			<#--属性-->\r\n			<#if search.content_type??> and  (\r\n			<#list search.content_type?split(\',\') as item>\r\n			<#if item?index gt 0> or</#if>\r\n			FIND_IN_SET(\'${item}\',cms_content.content_type)\r\n			</#list>)</#if>\r\n			<#--描述-->\r\n			<#if search.content_description??> and content_description like CONCAT(\'%\',\'${search.content_description}\',\'%\')</#if>\r\n			<#--关键字-->\r\n			<#if search.content_keyword??> and content_keyword like CONCAT(\'%\',\'${search.content_keyword}\',\'%\')</#if>\r\n			<#--内容-->\r\n			<#if search.content_details??> and content_details like CONCAT(\'%\',\'${search.content_details}\',\'%\')</#if>\r\n			\r\n<#--自定义顺序-->\r\n			<#if search.content_sort??> and content_sort=${search.content_sort}</#if>		\r\n<#--时间范围-->\r\n			<#if search.content_datetime_start??&&search.content_datetime_end??> and content_datetime between \'${search.content_datetime_start}\' and \'${search.content_datetime_end}\'</#if>\r\n  <#else><#--查询栏目-->\r\n    <#if _typeid?has_content> and (content_category_id=${_typeid} or content_category_id in \r\n  (select id FROM cms_category where cms_category.del=0 and FIND_IN_SET(${_typeid},CATEGORY_PARENT_ID))) </#if>\r\n </#if>\r\n  <#--标题-->\r\n  <#if content_title??> and content_title like CONCAT(\'%\',\'${content_title}\',\'%\')</#if>\r\n  <#--作者-->\r\n  <#if content_author??> and content_author like CONCAT(\'%\',\'${content_author}\',\'%\')</#if>\r\n  <#--来源-->\r\n  <#if content_source??> and content_source like CONCAT(\'%\',\'${content_source}\',\'%\')</#if>\r\n  <#--属性-->\r\n  <#if content_type??> and content_type like CONCAT(\'%\',\'${content_type}\',\'%\')</#if>\r\n  <#--描述-->\r\n  <#if content_description??> and content_description like CONCAT(\'%\',\'${content_description}\',\'%\')</#if>\r\n  <#--关键字-->\r\n  <#if content_keyword??> and content_keyword like CONCAT(\'%\',\'${content_keyword}\',\'%\')</#if>\r\n  <#--内容-->\r\n  <#if content_details??> and content_details like CONCAT(\'%\',\'${content_details}\',\'%\')</#if>\r\n  <#--自定义顺序-->\r\n  <#if content_sort??> and content_sort=${content_sort}</#if>\r\n  <#--自定义模型-->\r\n  <#if diyModel??> \r\n    <#list diyModel as dm>\r\n      and ${tableName}.${dm.key} like CONCAT(\'%\',\'${dm.value}\',\'%\') \r\n    </#list>\r\n  </#if>\r\n  <#--文章属性-->\r\n  <#if flag?? >\r\n			and(\r\n			<#list flag?split(\',\') as item>\r\n			<#if item?index gt 0> or</#if>\r\n			FIND_IN_SET(\'${item}\',cms_content.content_type)\r\n			</#list>)\r\n  </#if>\r\n  <#if noflag??>\r\n			and(\r\n			<#list noflag?split(\',\') as item>\r\n			<#if item?index gt 0> and</#if>\r\n			FIND_IN_SET(\'${item}\',cms_content.content_type)=0\r\n			</#list> or cms_content.content_type is null)\r\n  </#if>\r\n  <#--字段排序-->\r\n  <#if orderby?? >\r\n    ORDER BY \r\n      <#if orderby==\'date\'> content_datetime\r\n      <#elseif orderby==\'updatedate\'> content_updatetime\r\n      <#elseif orderby==\'hit\'> content_hit\r\n      <#elseif orderby==\'sort\'> content_sort\r\n      <#else>cms_content.id</#if>\r\n <#else>\r\n    ORDER BY   cms_content.id\r\n  </#if>\r\n  <#if order?? >\r\n      <#if order==\'desc\'> desc</#if>\r\n      <#if order==\'asc\'> asc</#if>\r\n  </#if>\r\n   LIMIT \r\n    <#--判断是否分页-->\r\n  <#if ispaging?? && (pageTag.pageNo)??>${((pageTag.pageNo-1)*_size?eval)?c},${_size?default(20)}\r\n  <#else>${_size?default(20)}</#if>', 1);
INSERT INTO `mdiy_tag_sql` VALUES (6, 4, '<#assign _typeid=\'0\'/>\r\n<#if column?? && column.id?? && column.id?number gt 0>\r\n	<#assign  _typeid=\'${column.id}\'>\r\n	<#assign  selfid=\'${column.id}\'>\r\n</#if>\r\n<#if typeid??>\r\n	<#assign  _typeid=\'${typeid}\'>\r\n</#if>\r\nselect \r\n	id,\r\n	id as typeid,\r\n	category_title as typetitle,\r\n	<#--返回父id集合-->\r\n	category_parent_id as pids,\r\n	<#--动态链接-->\r\n	<#if isDo?? && isDo>\r\n	CONCAT(\'/${modelName}/list.do?typeid=\', id) as typelink,\r\n	<#else>\r\n		<#--栏目类型为链接-->\r\n		CONCAT(category_path,\'/index.html\') as typelink,\r\n	</#if>\r\n	category_keyword as typekeyword,\r\n	category_diy_url as typeurl,\r\n	category_flag as flag,\r\n category_parent_id as parentid,\r\ncategory_descrip as typedescrip,\r\n	category_img as typelitpic ,\r\n(select count(*) from cms_category c where c.category_id=id and c.del=0) as childsize\r\n	from cms_category  \r\n	where \r\n	cms_category.del=0 \r\n	<#--根据站点编号查询-->\r\n	<#if appId?? >\r\n		and cms_category.app_id=${appId}\r\n	</#if>\r\n	<#--栏目属性-->\r\n	  <#if flag?? >\r\n   and\r\n	(		<#list flag?split(\',\') as item>\r\n			<#if item?index gt 0> or</#if>\r\n			FIND_IN_SET(\'${item}\',category_flag)\r\n			</#list>)\r\n  </#if>\r\n	<#if noflag?? >\r\n      and\r\n			(\r\n			<#list noflag?split(\',\') as item>\r\n			<#if item?index gt 0> and</#if>\r\n			FIND_IN_SET(\'${item}\',category_flag)=0\r\n			</#list> or category_flag is null)\r\n	</#if>\r\n	<#--type默认son-->\r\n<#if !type??||!type?has_content>\r\n<#assign type=\'son\'/>\r\n</#if>\r\n<#if type?has_content>\r\n	<#--顶级栏目（单个）-->\r\n	<#if type==\'top\'>\r\n	<#if _typeid != \'0\'>\r\n		and (id = top_id or top_id = 0)\r\n		</#if>\r\n	<#elseif type==\'nav\'>\r\n		and(category_id=0 or category_id is null)\r\n	<#--同级栏目（多个）-->\r\n	<#elseif type==\'level\'>\r\n		and\r\n		<#if _typeid?has_content>\r\n		 category_id=(select category_id from cms_category where id=${_typeid})\r\n		<#else>\r\n		 1=1\r\n		</#if>\r\n  	<#--当前栏目（单个）-->\r\n	<#elseif type==\'self\'>\r\n		 and \r\n		 <#if _typeid?has_content>\r\n		  id=${_typeid}\r\n		 <#else>\r\n		 1=1\r\n		 </#if>\r\n	<#--当前栏目的所属栏目（多个）-->\r\n	<#elseif type==\'path\'>\r\n			and \r\n		 <#if _typeid?has_content>\r\n		   id in (<#if column?? && column.categoryParentId??>${column.categoryParentId},</#if>${_typeid})\r\n		 <#else>\r\n		  1=1\r\n		 </#if>\r\n	<#--子栏目（多个）-->\r\n	<#elseif type==\'son\'>\r\n			and \r\n		 <#if _typeid?has_content>\r\n		  category_id=${_typeid}\r\n		 <#else>\r\n		  1=1\r\n		 </#if>\r\n		 <#--上一级栏目没有则取当前栏目（单个）-->\r\n	<#elseif type==\'parent\'>\r\n			and \r\n		 <#if _typeid?has_content>\r\n		   <#if column?? && column.categoryId??>\r\n				id=${column.categoryId}\r\n			 <#else>\r\n			  id=${_typeid}\r\n			 </#if>\r\n		 <#else>\r\n		  1=1\r\n	</#if>\r\n	</#if>\r\n<#else> <#--默认顶级栏目-->\r\n	 and\r\n	<#if _typeid?has_content>\r\n	 id=${_typeid}\r\n	<#else>\r\n	 (category_id=0 or category_id is null)\r\n	</#if>\r\n</#if>\r\n<#--字段排序-->\r\n  <#if orderby?? >\r\n    ORDER BY \r\n      <#if orderby==\'date\'> category_datetime\r\n      <#elseif orderby==\'sort\'> category_sort\r\n      <#else>cms_content.id</#if>\r\n\r\n  </#if>\r\n  <#if order?? >\r\n      <#if order==\'desc\'> desc</#if>\r\n      <#if order==\'asc\'> asc</#if>\r\n  </#if>', 1);
INSERT INTO `mdiy_tag_sql` VALUES (7, 5, 'select \r\nAPP_NAME as name,\r\napp_logo as logo ,\r\napp_keyword as keyword,\r\napp_description as descrip,\r\napp_copyright as copyright,\r\n<#--动态解析 -->\r\n<#if isDo?? && isDo>\r\nCONCAT(\'${url}\',\'/${html}/\',id) as url,\r\n\'${url}\' as host,\r\n<#--使用地址栏的域名 -->\r\n<#elseif url??>\r\nCONCAT(\'${url}\',\'/${html}/\',id,\'/<#if m??>${m}</#if>\') as url,\r\n\'${url}\' as host,\r\n<#else>\r\nCONCAT(REPLACE(REPLACE(TRIM(substring_index(app_url,\'\\n\',1)), CHAR(10),\'\'), CHAR(13),\'\'),\'/html/\',id,\'/<#if m??>${m}</#if>\') as url,\r\nREPLACE(REPLACE(TRIM(substring_index(app_url,\'\\n\',1)), CHAR(10),\'\'), CHAR(13),\'\') as host,\r\n</#if>\r\nCONCAT(\'templets/\',id,\'/\',<#if m??>CONCAT(app_style,\'/${m}\')<#else>app_style</#if>) as \"style\" <#-- 判断是否为手机端 -->\r\nfrom app where id = ${appId} limit 1', 1);
INSERT INTO `mdiy_tag_sql` VALUES (8, 7, 'SELECT \r\ncms_content.id as id,\r\nleft(content_title,${titlelen?default(40)}) as title,\r\ncontent_title as fulltitle,\r\ncontent_author as author, \r\ncontent_source as source, \r\ncontent_details as content,\r\ncategory_title as typetitle,\r\ncms_category.id as typeid,\r\n cms_category.category_img AS typelitpic,\r\n<#--动态链接-->\r\n<#if isDo?? && isDo>\r\nCONCAT(\'/${modelName}/list.do?typeid=\', cms_category.id) as typelink,\r\n<#else>\r\n(SELECT \'index.html\') as typelink,\r\n</#if>\r\ncms_content.content_img AS litpic,\r\n<#--内容页动态链接-->\r\n<#if isDo?? && isDo>\r\nCONCAT(\'/mcms/view.do?id=\', cms_content.id) as \"link\",\r\n<#else>\r\ncontent_url AS \"link\",\r\n</#if>\r\ncontent_datetime as \"date\",\r\ncontent_description as descrip,\r\nCONCAT(\'<script type=\"text/javascript\" src=\"${url}/cms/content/\',cms_content.id,\'/hit.do\"></script>\') as hit,\r\ncontent_type as flag,\r\ncategory_title as typetitle,\r\n<#if tableName??>${tableName}.*,</#if>\r\ncontent_keyword as keyword\r\nFROM cms_content\r\nLEFT JOIN cms_category  ON \r\n<#--如果是栏目列表页没有文章id所以只取栏目id-->\r\n<#if column??&&column.id??&&!id??> \r\n cms_category.id=${column.id}\r\n<#else>\r\ncms_category.id = content_category_id\r\n</#if>\r\n<#--判断是否有自定义模型表-->\r\n<#if tableName??>left join ${tableName} on ${tableName}.link_id=cms_content.id</#if>\r\nWHERE \r\n cms_content.del=0\r\n<#if id??> and cms_content.id=${id}</#if>', 1);
INSERT INTO `mdiy_tag_sql` VALUES (9, 8, '<#assign select=\"(SELECT \'\')\"/>\r\n<#if orderby?? >\r\n      <#if orderby==\"date\"> \r\n	   <#assign  _orderby=\"content_datetime\">\r\n      <#elseif orderby==\"updatedate\">\r\n <#assign  _orderby=\"content_updatetime\">\r\n      <#elseif orderby==\"hit\"> \r\n	  <#assign  _orderby=\"content_hit\">\r\n      <#elseif orderby==\"sort\">\r\n	   <#assign  _orderby=\"content_sort\">\r\n      <#else><#assign  _orderby=\"cms_content.id\"></#if>\r\n   <#else>\r\n   <#assign  _orderby=\"cms_content.id\">\r\n  </#if>\r\n<#if pageTag.preId??>\r\nSELECT \r\ncms_content.id as id,\r\nleft(content_title,${titlelen?default(40)}) as title,\r\ncontent_title as fulltitle,\r\ncontent_author as author, \r\ncontent_source as source, \r\ncontent_details as content,\r\ncategory.category_title as typename,\r\ncategory.category_id as typeid,\r\n(SELECT \'index.html\') as typelink,\r\ncontent_img as litpic,\r\n<#--内容页动态链接-->\r\n  <#if isDo?? && isDo>\r\n   CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\r\n  <#else>\r\n  CONCAT(category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\r\n  </#if>\r\ncontent_datetime as \"date\",\r\ncontent_description as descrip,\r\ncontent_hit as hit,\r\ncontent_type as flag,\r\ncontent_keyword as keyword \r\nFROM cms_content \r\nLEFT JOIN cms_category as category ON content_category_id=category.id \r\nWHERE cms_content.id=${pageTag.preId}\r\n<#else>\r\nSELECT \r\n${select} as id,\r\n${select} as title,\r\n${select} as fulltitle,\r\n${select} as author, \r\n${select} as source, \r\n${select} as content,\r\n${select} as typename,\r\n${select} as typeid,\r\n${select} as typelink,\r\n${select} as litpic,\r\n${select} as \"link\",\r\n${select} as \"date\",\r\n${select} as descrip,\r\n${select} as hit,\r\n${select} as flag,\r\n${select} as keyword FROM cms_content\r\n</#if>', NULL);
INSERT INTO `mdiy_tag_sql` VALUES (10, 9, '  select\r\n	<#if !(pageTag.indexUrl??)>\r\n	<#--判断是否有栏目对象，用于搜索不传栏目-->\r\n	<#if column??>\r\n		<#assign path=column.categoryPath/>\r\n	<#else>\r\n		<#assign path=\"\"/>\r\n	</#if>\r\n  <#--总记录数、总页数-->\r\n	(SELECT ${pageTag.total}) as \"total\",\r\n	<#--记录总数-->\r\n	(SELECT ${pageTag.size}) as \"rcount\",\r\n	<#--当前页码-->\r\n	(SELECT ${pageTag.pageNo}) as \"cur\",\r\n	<#--首页-->\r\n  CONCAT(\'${path}\', \'/index.html\') as \"index\",\r\n	<#--上一页-->\r\n	<#if (pageTag.pageNo?eval-1) gt 1>\r\n	CONCAT(\'${path}\',\'/list-${pageTag.pageNo?eval-1}.html\') as \"pre\",\r\n	<#else>\r\n	CONCAT(\'${path}\',\'/index.html\') as \"pre\",\r\n	</#if>\r\n	<#--下一页-->\r\n	<#if pageTag.total==1>\r\n		CONCAT(\'${path}\', \'/index.html\') as \"next\",\r\n		CONCAT(\'${path}\', \'/index.html\') as \"last\"\r\n	<#else>\r\n		<#if pageTag.pageNo?eval gte pageTag.total>\r\n		CONCAT(\'${path}\',\'/list-${pageTag.total}.html\') as \"next\",\r\n		<#else>\r\n		CONCAT(\'${path}\',\'/list-${pageTag.pageNo?eval+1}.html\') as \"next\",\r\n		</#if>\r\n		<#--最后一页-->\r\n		CONCAT(\'${path}\',\'/list-${pageTag.total}.html\') as \"last\"\r\n		</#if>\r\n<#else><#--判断是否是搜索页面-->\r\n \'${pageTag.indexUrl}\' as \"index\",\'${pageTag.lastUrl}\' as \"last\",\'${pageTag.preUrl}\' as \"pre\",\'${pageTag.nextUrl}\' as \"next\",\'${pageTag.total}\' as \"total\",\'${pageTag.size}\' as \"rcount\",\'${pageTag.pageNo}\' as \"cur\"\r\n</#if>', NULL);
INSERT INTO `mdiy_tag_sql` VALUES (11, 10, '<#assign select=\"(SELECT \'\')\"/>\r\n<#if orderby?? >\r\n      <#if orderby==\"date\"> \r\n	   <#assign  _orderby=\"content_datetime\">\r\n      <#elseif orderby==\"updatedate\">\r\n <#assign  _orderby=\"content_updatetime\">\r\n      <#elseif orderby==\"hit\"> \r\n	  <#assign  _orderby=\"content_hit\">\r\n      <#elseif orderby==\"sort\">\r\n	   <#assign  _orderby=\"content_sort\">\r\n      <#else><#assign  _orderby=\"cms_content.id\"></#if>\r\n   <#else>\r\n   <#assign  _orderby=\"cms_content.id\">\r\n  </#if>\r\n<#if pageTag.nextId??>\r\nSELECT \r\ncms_content.id as id,\r\nleft(content_title,${titlelen?default(40)}) as title,\r\ncontent_title as fulltitle,\r\ncontent_author as author, \r\ncontent_source as source, \r\ncontent_details as content,\r\ncategory.category_title as typename,\r\ncategory.category_id as typeid,\r\n(SELECT \'index.html\') as typelink,\r\ncontent_img as litpic,\r\n<#--内容页动态链接-->\r\n  <#if isDo?? && isDo>\r\n   CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\r\n  <#else>\r\n  CONCAT(category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\r\n  </#if>\r\ncontent_datetime as \"date\",\r\ncontent_description as descrip,\r\ncontent_hit as hit,\r\ncontent_type as flag,\r\ncontent_keyword as keyword \r\nFROM cms_content \r\nLEFT JOIN cms_category as category ON content_category_id=category.id \r\nWHERE cms_content.id=${pageTag.nextId}\r\n<#else>\r\nSELECT \r\n${select} as id,\r\n${select} as title,\r\n${select} as fulltitle,\r\n${select} as author, \r\n${select} as source, \r\n${select} as content,\r\n${select} as typename,\r\n${select} as typeid,\r\n${select} as typelink,\r\n${select} as litpic,\r\n${select} as \"link\",\r\n${select} as \"date\",\r\n${select} as descrip,\r\n${select} as hit,\r\n${select} as flag,\r\n${select} as keyword FROM cms_content\r\n</#if>', NULL);

-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS `model`;
CREATE TABLE `model`  (
  `model_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模块自增长id',
  `model_title` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块标题',
  `model_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块编码',
  `model_modelid` int(22) NULL DEFAULT NULL COMMENT '模块的父模块id',
  `model_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块连接地址',
  `model_datetime` datetime(0) NULL DEFAULT NULL,
  `model_icon` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块图标',
  `model_modelmanagerid` int(11) NULL DEFAULT NULL COMMENT '模块关联的关联员id',
  `model_sort` int(11) NULL DEFAULT NULL COMMENT '模块的排序',
  `model_ismenu` int(1) NULL DEFAULT 0 COMMENT '模块是否是菜单',
  `model_parent_ids` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级编号集合，从小到大排序',
  `IS_CHILD` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  PRIMARY KEY (`model_id`) USING BTREE,
  UNIQUE INDEX `sys_c009201`(`model_id`) USING BTREE,
  INDEX `model_modelid`(`model_modelid`) USING BTREE,
  INDEX `model_code`(`model_code`) USING BTREE,
  CONSTRAINT `model_ibfk_1` FOREIGN KEY (`model_modelid`) REFERENCES `model` (`model_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 858 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model
-- ----------------------------
INSERT INTO `model` VALUES (23, '权限管理', '01000000', NULL, '', '2014-09-08 08:12:22', 'icon-quanxianguanli', 0, 5, 1, NULL, NULL);
INSERT INTO `model` VALUES (84, '系统设置', '12000000', NULL, '', '2014-12-18 18:30:24', 'icon-xitongguanli', 0, 3, 1, NULL, NULL);
INSERT INTO `model` VALUES (86, '应用设置', '12010000', 84, 'app/-1/edit.do', '2014-12-18 18:31:59', '', 0, 0, 1, '84', NULL);
INSERT INTO `model` VALUES (87, '模版管理', '12020000', 84, 'template/index.do', '2014-12-18 18:32:50', '', 0, 0, 1, '84', NULL);
INSERT INTO `model` VALUES (182, '修改', '12010004', 86, 'app:update', '2017-09-04 14:14:42', '', 0, 0, 0, '84,86', NULL);
INSERT INTO `model` VALUES (183, '菜单管理', '01030000', 23, 'model/index.do', '2017-09-04 11:09:26', '', 0, 0, 1, '23', NULL);
INSERT INTO `model` VALUES (184, '查看', '01030001', 183, 'model:view', '2017-09-04 11:10:43', '', 0, 0, 0, '23,183', NULL);
INSERT INTO `model` VALUES (201, '新增', '01030002', 183, 'model:save', '2019-12-27 10:26:29', NULL, 0, 0, 0, '23,183', NULL);
INSERT INTO `model` VALUES (202, '修改', '01030004', 183, 'model:update', '2019-12-27 10:26:33', NULL, 0, 0, 0, '23,183', NULL);
INSERT INTO `model` VALUES (204, '上传', '12020002', 87, 'template:upload', '2019-12-27 10:26:37', '', 0, 0, 0, '84,87', NULL);
INSERT INTO `model` VALUES (217, '会员中心', '07000000', NULL, '', '2018-10-28 19:30:44', 'icon-huiyuanzhongxin', 0, 0, 1, NULL, NULL);
INSERT INTO `model` VALUES (218, '用户管理', '07020100', 217, 'people/peopleUser/index.do', '2018-10-28 19:30:44', NULL, 0, 0, 1, '217', NULL);
INSERT INTO `model` VALUES (219, '修改', '07020104', 218, 'people:user:update', '2018-10-28 19:30:44', '', 0, 0, 0, '217,218', NULL);
INSERT INTO `model` VALUES (220, '删除', '07020103', 218, 'people:user:del', '2018-10-28 19:30:44', '', 0, 0, 0, '217,218', NULL);
INSERT INTO `model` VALUES (221, '新增', '07020102', 218, 'people:user:save', '2018-10-28 19:30:44', '', 0, 0, 0, '217,218', NULL);
INSERT INTO `model` VALUES (222, '查看', '07020101', 218, 'people:view', '2018-10-28 19:30:45', NULL, 0, 0, 0, '217,218', NULL);
INSERT INTO `model` VALUES (264, '自定义管理', '20000000', NULL, '', '2018-09-06 09:38:51', 'icon-zidingyiguanli', 0, 0, 1, '264', NULL);
INSERT INTO `model` VALUES (265, '自定义页面', '20010000', 264, 'mdiy/page/index.do', '2018-09-06 09:38:51', NULL, 0, 0, 1, '264', NULL);
INSERT INTO `model` VALUES (266, '修改', '20010004', 269, 'mdiy:form:update', '2018-09-06 09:38:51', NULL, 0, 0, 0, '264,269', NULL);
INSERT INTO `model` VALUES (267, '新增', '20010002', 269, 'mdiy:form:save', '2018-09-06 09:38:51', NULL, 0, 0, 0, '264,269', NULL);
INSERT INTO `model` VALUES (268, '查看', '20010001', 269, 'mdiy:form:view', '2018-09-06 09:38:51', NULL, 0, 0, 0, '264,269', NULL);
INSERT INTO `model` VALUES (269, '自定义表单', '20020000', 264, 'mdiy/post/index.do', '2018-09-06 09:38:51', NULL, 0, 0, 1, '264', NULL);
INSERT INTO `model` VALUES (280, '自定义字典', '20050000', 264, 'mdiy/dict/index.do', '2018-09-06 09:38:53', NULL, 0, 0, 1, '264', NULL);
INSERT INTO `model` VALUES (281, '删除', '20050003', 280, 'mdiy:dict:del', '2018-09-06 09:38:53', NULL, 0, 0, 0, '264,280', NULL);
INSERT INTO `model` VALUES (282, '修改', '20050004', 280, 'mdiy:dict:update', '2018-09-06 09:38:53', NULL, 0, 0, 0, '264,280', NULL);
INSERT INTO `model` VALUES (283, '新增', '20050002', 280, 'mdiy:dict:save', '2018-09-06 09:38:53', NULL, 0, 0, 0, '264,280', NULL);
INSERT INTO `model` VALUES (284, '查看', '20050001', 280, 'mdiy:dict:view', '2018-09-06 09:38:53', NULL, 0, 0, 0, '264,280', NULL);
INSERT INTO `model` VALUES (299, '新增', '299', 265, 'mdiy:page:save', '2019-05-27 16:04:32', '', 0, 0, 0, '264,265', NULL);
INSERT INTO `model` VALUES (300, '修改', '300', 265, 'mdiy:page:update', '2019-05-27 16:05:11', '', 0, 0, 0, '264,265', NULL);
INSERT INTO `model` VALUES (301, '删除', '301', 265, 'mdiy:page:del', '2019-05-27 16:42:10', '', 0, 0, 0, '264,265', NULL);
INSERT INTO `model` VALUES (406, '角色管理', '406', 23, 'basic/role/index.do', '2019-08-02 17:18:47', '', 0, 0, 1, '23', NULL);
INSERT INTO `model` VALUES (407, '新增', '407', 406, 'role:save', '2019-08-02 17:19:10', '', 0, 0, 0, '23,406', NULL);
INSERT INTO `model` VALUES (408, '修改', '408', 406, 'role:update', '2019-08-02 17:19:34', '', 0, 0, 0, '23,406', NULL);
INSERT INTO `model` VALUES (409, '删除', '409', 406, 'role:del', '2019-08-02 17:19:59', '', 0, 0, 0, '23,406', NULL);
INSERT INTO `model` VALUES (411, '管理员管理', '411', 23, 'basic/manager/index.do', '2019-08-03 10:54:38', '', 0, 0, 1, '23', NULL);
INSERT INTO `model` VALUES (412, '查看', '412', 411, 'manager:view', '2019-08-03 10:56:13', '', 0, 0, 0, '23,411', NULL);
INSERT INTO `model` VALUES (538, '自定义模型', '15730944491834300', 264, 'mdiy/model/index.do', '2019-11-07 10:36:46', '', 0, 0, 1, '264,264', NULL);
INSERT INTO `model` VALUES (540, '删除', '15730944491833822', 538, 'mdiy:model:del', '2019-11-07 10:36:47', NULL, 0, 0, 0, '264,538', NULL);
INSERT INTO `model` VALUES (542, '查看', '15730944491832459', 538, 'mdiy:model:view', '2019-11-07 10:36:47', NULL, 0, 0, 0, '264,538', NULL);
INSERT INTO `model` VALUES (553, '导入', 'importJson', 538, 'mdiy:model:importJson', '2019-11-07 13:46:53', '', 0, 0, 0, '264,538', NULL);
INSERT INTO `model` VALUES (554, '删除', 'mdiy:form:del', 269, 'mdiy:form:del', '2019-11-07 15:14:40', '', 0, 0, 0, '264,269', NULL);
INSERT INTO `model` VALUES (661, '审核', '543434354', 218, 'people:user:check', '2019-11-16 15:38:17', '', 0, 0, 0, '217,218', NULL);
INSERT INTO `model` VALUES (663, '删除', '15737980803547570', 411, 'manager:del', '2019-11-18 14:19:35', '', 0, 0, 0, '23,411', NULL);
INSERT INTO `model` VALUES (664, '更新', '15737980853527702', 411, 'manager:update', '2019-11-18 14:21:08', '', 0, 0, 0, '23,411', NULL);
INSERT INTO `model` VALUES (665, '新增', '15735981803267702', 411, 'manager:save', '2019-11-18 14:21:42', '', 0, 0, 0, '23,411', NULL);
INSERT INTO `model` VALUES (668, '删除', '668', 183, 'model:del', '2019-11-18 14:35:49', '', 0, 0, 0, '23,183', NULL);
INSERT INTO `model` VALUES (672, '删除', '5434345', 87, 'template:del', '2019-11-18 15:05:09', '', 0, 0, 0, '84,87', NULL);
INSERT INTO `model` VALUES (673, '更新', '452435345', 87, 'template:update', '2019-11-18 15:05:35', '', 0, 0, 0, '84,87', NULL);
INSERT INTO `model` VALUES (685, '系统日志', '65123656532', 84, 'basic/systemLog/index.do', '2019-11-21 17:13:50', '', 0, 0, 1, '84', NULL);
INSERT INTO `model` VALUES (686, '查看', '351463145634', 685, 'basic:systemlog:view', '2019-11-21 17:14:24', '', 0, 0, 0, '84,685', NULL);
INSERT INTO `model` VALUES (706, '内容管理', '02000000', NULL, '', '2019-11-22 16:14:59', 'icon-neirongguanli', 0, 5, 1, NULL, NULL);
INSERT INTO `model` VALUES (707, '文章管理', '02980000', 706, 'cms/content/index.do', '2019-11-22 16:16:25', '', 0, 3, 1, '706', NULL);
INSERT INTO `model` VALUES (708, '栏目管理', '02990000', 706, 'cms/category/index.do', '2019-11-22 16:16:50', '', 0, 2, 1, '706', NULL);
INSERT INTO `model` VALUES (709, '静态化', '02020000', 706, 'cms/generate/index.do', '2019-11-22 16:17:15', '', 0, 1, 1, '706', NULL);
INSERT INTO `model` VALUES (710, '生成文章', '02020004', 709, 'cms:generate:article', '2019-11-22 16:17:39', '', 0, 0, 0, '706,709', NULL);
INSERT INTO `model` VALUES (711, '生成栏目', '02020003', 709, 'cms:generate:column', '2019-11-22 16:18:05', '', 0, 0, 0, '706,709', NULL);
INSERT INTO `model` VALUES (713, '查看', '02020001', 709, 'cms:generate:view', '2019-11-22 16:18:48', '', 0, 0, 0, '706,709', NULL);
INSERT INTO `model` VALUES (714, '生成主页', '56454656', 709, 'cms:generate:index', '2019-11-22 16:20:10', '', 0, 0, 0, '706,709', NULL);
INSERT INTO `model` VALUES (715, '新增', '02990004', 708, 'cms:category:save', '2019-11-22 16:20:42', '', 0, 0, 0, '706,708', NULL);
INSERT INTO `model` VALUES (716, '修改', '02990003', 708, 'cms:category:update', '2019-11-22 16:21:36', '', 0, 0, 0, '706,708', NULL);
INSERT INTO `model` VALUES (717, '查看', '02990001', 708, 'cms:category:view', '2019-11-22 16:22:05', '', 0, 0, 0, '706,708', NULL);
INSERT INTO `model` VALUES (718, '新增', '02980002', 707, 'cms:content:save', '2019-11-22 16:22:35', '', 0, 0, 0, '706,707', NULL);
INSERT INTO `model` VALUES (719, '修改', '02980004', 707, 'cms:content:update', '2019-11-22 16:22:57', '', 0, 0, 0, '706,707', NULL);
INSERT INTO `model` VALUES (720, '查看', '02980001', 707, 'cms:content:view', '2019-11-22 16:23:15', '', 0, 0, 0, '706,707', NULL);
INSERT INTO `model` VALUES (721, '删除', '721', 707, 'cms:content:del', '2019-11-22 17:02:28', '', 0, 0, 0, '706,707', NULL);
INSERT INTO `model` VALUES (722, '导入', '722', 269, 'mdiy:form:importJson', '2019-12-27 12:07:24', '', 0, 0, 0, '264,269', NULL);
INSERT INTO `model` VALUES (857, '删除', '857', 708, 'cms:category:del', '2019-12-27 17:33:06', '', 0, 0, 1, '706,708', NULL);

-- ----------------------------
-- Table structure for people
-- ----------------------------
DROP TABLE IF EXISTS `people`;
CREATE TABLE `people`  (
  `people_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '增长自id',
  `people_phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `people_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `people_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `people_datetime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  `app_id` int(11) NOT NULL COMMENT '应用编号',
  `people_mail` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `people_state` int(2) NULL DEFAULT 0 COMMENT '用户状态',
  `people_code` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '随机验证码',
  `people_codesenddate` datetime(0) NULL DEFAULT NULL COMMENT '发送验证码时间',
  `people_phonecheck` int(1) NULL DEFAULT 0 COMMENT '1手机验证通过',
  `people_maillcheck` int(1) NULL DEFAULT 0 COMMENT '1邮箱验证通过',
  `people_ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户登录ip',
  PRIMARY KEY (`people_id`) USING BTREE,
  INDEX `fk_people`(`app_id`) USING BTREE,
  CONSTRAINT `people_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '户用基础表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of people
-- ----------------------------
INSERT INTO `people` VALUES (1, '18179860960', 'msopen', '9d8622060de5f24937b60585c3f4d66b', '2019-12-30 18:28:28', 1, '1027418825@qq.com', 0, NULL, NULL, 0, 0, '127.0.0.1');

-- ----------------------------
-- Table structure for people_address
-- ----------------------------
DROP TABLE IF EXISTS `people_address`;
CREATE TABLE `people_address`  (
  `PA_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户收货地址自增长Id',
  `PA_PEOPLE_ID` int(11) NOT NULL COMMENT '对应用户基础信息拓展表的id',
  `PA_CONSIGNEE_NAME` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户收货人姓名',
  `PA_PROVINCE` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人所在的省',
  `PA_PROVINCE_ID` bigint(11) NULL DEFAULT 0 COMMENT '省份编号',
  `PA_CITY` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人所在的市',
  `PA_CITY_ID` bigint(11) NULL DEFAULT 0 COMMENT '城市编号',
  `PA_DISTRICT` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人所在区(县)',
  `PA_DISTRICT_ID` bigint(11) NULL DEFAULT 0 COMMENT '区编号',
  `PA_STREET` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PA_STREET_ID` bigint(11) NULL DEFAULT 0 COMMENT '街道编号',
  `PA_ADDRESS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人的详细收货地址',
  `PA_MAIL` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人邮箱',
  `PA_PHONE` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人手机',
  `PA_DEFAULT` int(1) NULL DEFAULT 0 COMMENT '是否是收货人最终收货地址。1代表是，0代表不是，默认为0',
  `APP_ID` int(11) NOT NULL COMMENT '对应的站点id',
  PRIMARY KEY (`PA_ID`) USING BTREE,
  INDEX `PA_APP_ID`(`APP_ID`) USING BTREE,
  INDEX `PA_PEOPLE_ID`(`PA_PEOPLE_ID`) USING BTREE,
  CONSTRAINT `people_address_ibfk_1` FOREIGN KEY (`PA_PEOPLE_ID`) REFERENCES `people` (`people_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户地址' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for people_user
-- ----------------------------
DROP TABLE IF EXISTS `people_user`;
CREATE TABLE `people_user`  (
  `pu_people_id` int(11) NOT NULL COMMENT '用户id关联people表的（people_id）',
  `pu_real_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户真实名称',
  `pu_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户地址',
  `pu_level` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户等级',
  `pu_level_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户等级名称',
  `pu_icon` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像图标地址',
  `pu_nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `pu_sex` int(2) NULL DEFAULT NULL COMMENT '用户性别(0.未知、1.男、2.女)',
  `pu_birthday` date NULL DEFAULT NULL COMMENT '用户出生年月日',
  `pu_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `province_id` bigint(20) NULL DEFAULT NULL,
  `province_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city_id` bigint(20) NULL DEFAULT NULL,
  `city_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `county_id` bigint(20) NULL DEFAULT NULL,
  `county_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pu_people_id`) USING BTREE,
  INDEX `pu_people_id`(`pu_people_id`) USING BTREE,
  CONSTRAINT `people_user_ibfk_1` FOREIGN KEY (`pu_people_id`) REFERENCES `people` (`people_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户基础信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of people_user
-- ----------------------------
INSERT INTO `people_user` VALUES (1, NULL, NULL, NULL, NULL, '/upload/1577701863298.jpg', '111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id，自增长',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `role_managerid` int(11) NULL DEFAULT 0 COMMENT '角色管理员编号',
  `app_id` int(11) NULL DEFAULT NULL COMMENT '应用编号',
  PRIMARY KEY (`role_id`) USING BTREE,
  INDEX `role_managerid`(`role_managerid`) USING BTREE,
  INDEX `fk_role_app_id`(`app_id`) USING BTREE,
  CONSTRAINT `role_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (48, 'msopen', 57, 1);

-- ----------------------------
-- Table structure for role_model
-- ----------------------------
DROP TABLE IF EXISTS `role_model`;
CREATE TABLE `role_model`  (
  `rm_modelid` int(22) NULL DEFAULT NULL COMMENT '模块编号',
  `rm_roleid` int(22) NULL DEFAULT NULL COMMENT '角色编号',
  UNIQUE INDEX `index`(`rm_modelid`, `rm_roleid`) USING BTREE,
  INDEX `rm_modelid`(`rm_modelid`) USING BTREE,
  INDEX `fk_role_model_role_1`(`rm_roleid`) USING BTREE,
  CONSTRAINT `role_model_ibfk_1` FOREIGN KEY (`rm_roleid`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `role_model_ibfk_2` FOREIGN KEY (`rm_modelid`) REFERENCES `model` (`model_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色模块关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_model
-- ----------------------------
INSERT INTO `role_model` VALUES (23, 48);
INSERT INTO `role_model` VALUES (84, 48);
INSERT INTO `role_model` VALUES (86, 48);
INSERT INTO `role_model` VALUES (87, 48);
INSERT INTO `role_model` VALUES (182, 48);
INSERT INTO `role_model` VALUES (183, 48);
INSERT INTO `role_model` VALUES (184, 48);
INSERT INTO `role_model` VALUES (201, 48);
INSERT INTO `role_model` VALUES (202, 48);
INSERT INTO `role_model` VALUES (204, 48);
INSERT INTO `role_model` VALUES (217, 48);
INSERT INTO `role_model` VALUES (218, 48);
INSERT INTO `role_model` VALUES (219, 48);
INSERT INTO `role_model` VALUES (220, 48);
INSERT INTO `role_model` VALUES (221, 48);
INSERT INTO `role_model` VALUES (222, 48);
INSERT INTO `role_model` VALUES (264, 48);
INSERT INTO `role_model` VALUES (265, 48);
INSERT INTO `role_model` VALUES (266, 48);
INSERT INTO `role_model` VALUES (267, 48);
INSERT INTO `role_model` VALUES (268, 48);
INSERT INTO `role_model` VALUES (269, 48);
INSERT INTO `role_model` VALUES (280, 48);
INSERT INTO `role_model` VALUES (281, 48);
INSERT INTO `role_model` VALUES (282, 48);
INSERT INTO `role_model` VALUES (283, 48);
INSERT INTO `role_model` VALUES (284, 48);
INSERT INTO `role_model` VALUES (299, 48);
INSERT INTO `role_model` VALUES (300, 48);
INSERT INTO `role_model` VALUES (301, 48);
INSERT INTO `role_model` VALUES (406, 48);
INSERT INTO `role_model` VALUES (407, 48);
INSERT INTO `role_model` VALUES (408, 48);
INSERT INTO `role_model` VALUES (409, 48);
INSERT INTO `role_model` VALUES (411, 48);
INSERT INTO `role_model` VALUES (412, 48);
INSERT INTO `role_model` VALUES (538, 48);
INSERT INTO `role_model` VALUES (540, 48);
INSERT INTO `role_model` VALUES (542, 48);
INSERT INTO `role_model` VALUES (553, 48);
INSERT INTO `role_model` VALUES (554, 48);
INSERT INTO `role_model` VALUES (661, 48);
INSERT INTO `role_model` VALUES (663, 48);
INSERT INTO `role_model` VALUES (664, 48);
INSERT INTO `role_model` VALUES (665, 48);
INSERT INTO `role_model` VALUES (668, 48);
INSERT INTO `role_model` VALUES (672, 48);
INSERT INTO `role_model` VALUES (673, 48);
INSERT INTO `role_model` VALUES (685, 48);
INSERT INTO `role_model` VALUES (686, 48);
INSERT INTO `role_model` VALUES (706, 48);
INSERT INTO `role_model` VALUES (707, 48);
INSERT INTO `role_model` VALUES (708, 48);
INSERT INTO `role_model` VALUES (709, 48);
INSERT INTO `role_model` VALUES (710, 48);
INSERT INTO `role_model` VALUES (711, 48);
INSERT INTO `role_model` VALUES (713, 48);
INSERT INTO `role_model` VALUES (714, 48);
INSERT INTO `role_model` VALUES (715, 48);
INSERT INTO `role_model` VALUES (716, 48);
INSERT INTO `role_model` VALUES (717, 48);
INSERT INTO `role_model` VALUES (718, 48);
INSERT INTO `role_model` VALUES (719, 48);
INSERT INTO `role_model` VALUES (720, 48);
INSERT INTO `role_model` VALUES (721, 48);
INSERT INTO `role_model` VALUES (722, 48);
INSERT INTO `role_model` VALUES (857, 48);

-- ----------------------------
-- Table structure for system_log
-- ----------------------------
DROP TABLE IF EXISTS `system_log`;
CREATE TABLE `system_log`  (
  `id` bigint(20) UNSIGNED NOT NULL,
  `error_msg` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '错误消息',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求状态',
  `result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '返回参数',
  `param` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  `user_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户类型',
  `request_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方式',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `business_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务类型',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `del` int(1) NULL DEFAULT 0 COMMENT '删除标记',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `app_id` int(11) NULL DEFAULT NULL COMMENT '站点id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_log
-- ----------------------------
INSERT INTO `system_log` VALUES (8, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-28 10:33:14', 0, 1);
INSERT INTO `system_log` VALUES (9, NULL, 'error', 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-28 10:34:22', 0, 1);
INSERT INTO `system_log` VALUES (10, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-28 10:35:15', 0, 1);
INSERT INTO `system_log` VALUES (11, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-28 13:41:24', 0, 1);
INSERT INTO `system_log` VALUES (12, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-10-28\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-10-28 13:41:31', 0, 1);
INSERT INTO `system_log` VALUES (13, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', '/ms/cms/generate/0/genernateColumn.do', 'msopen', 'manage', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', 'update', '127.0.0.1', '生成栏目', 0, NULL, 0, '2020-10-28 13:41:34', 0, 1);
INSERT INTO `system_log` VALUES (14, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"createBy\":57,\n		\"createDate\":\"2020-10-28 17:46:26\",\n		\"del\":0,\n		\"managerId\":58,\n		\"managerName\":\"asdad\",\n		\"managerNickName\":\"msopenadad\",\n		\"managerPassword\":\"f9354b3c82482150956b904f71296b8c\",\n		\"managerPeopleID\":0,\n		\"managerRoleID\":48,\n		\"managerSystemSkinId\":0,\n		\"managerTime\":\"2020-10-28 17:46:26\",\n		\"sqlWhereList\":[],\n		\"updateBy\":0\n	}\n}', '{\n	\"managerName\":[\"asdad\"],\n	\"managerNickName\":[\"msopenadad\"],\n	\"managerPassword\":[\"msopenasd\"],\n	\"managerRoleID\":[\"48\"]\n}', '内网IP', '/ms/basic/manager/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.basic.action.ManagerAction.save()', 'insert', '127.0.0.1', '保存管理员实体', 0, NULL, NULL, '2020-10-28 17:46:26', NULL, 1);
INSERT INTO `system_log` VALUES (15, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-10-28 17:50:09', NULL, 1);
INSERT INTO `system_log` VALUES (16, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-10-28 17:50:31', NULL, 1);
INSERT INTO `system_log` VALUES (17, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '192.168.56.1', '生成主页', 0, NULL, NULL, '2020-10-28 17:51:17', NULL, 1);
INSERT INTO `system_log` VALUES (1321393292652441601, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-28 18:08:06', 0, 1);
INSERT INTO `system_log` VALUES (1321610782758268930, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-29 08:32:20', 0, 1);
INSERT INTO `system_log` VALUES (1321611197759381505, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-29 08:33:59', 0, 1);
INSERT INTO `system_log` VALUES (1321611262200668161, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"createBy\":57,\n		\"createDate\":\"2020-10-29 08:34:13\",\n		\"del\":0,\n		\"managerId\":0,\n		\"managerName\":\"dddd\",\n		\"managerNickName\":\"msopen\",\n		\"managerPassword\":\"9d8622060de5f24937b60585c3f4d66b\",\n		\"managerPeopleID\":0,\n		\"managerRoleID\":48,\n		\"managerSystemSkinId\":0,\n		\"managerTime\":\"2020-10-29 08:34:13\",\n		\"sqlWhereList\":[],\n		\"updateBy\":0\n	}\n}', '{\n	\"managerName\":[\"dddd\"],\n	\"managerNickName\":[\"msopen\"],\n	\"managerPassword\":[\"msopen\"],\n	\"managerRoleID\":[\"48\"]\n}', '内网IP', '/ms/basic/manager/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.basic.action.ManagerAction.save()', 'insert', '127.0.0.1', '保存管理员实体', 0, NULL, 0, '2020-10-29 08:34:14', 0, 1);
INSERT INTO `system_log` VALUES (1321611726573019138, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-29 08:36:05', 0, 1);
INSERT INTO `system_log` VALUES (1321611773977042945, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"createBy\":57,\n		\"createDate\":\"2020-10-29 08:36:15\",\n		\"del\":0,\n		\"managerId\":0,\n		\"managerName\":\"adasd\",\n		\"managerNickName\":\"msopend\",\n		\"managerPassword\":\"9d8622060de5f24937b60585c3f4d66b\",\n		\"managerPeopleID\":0,\n		\"managerRoleID\":48,\n		\"managerSystemSkinId\":0,\n		\"managerTime\":\"2020-10-29 08:36:15\",\n		\"sqlWhereList\":[],\n		\"updateBy\":0\n	}\n}', '{\n	\"managerName\":[\"adasd\"],\n	\"managerNickName\":[\"msopend\"],\n	\"managerPassword\":[\"msopen\"],\n	\"managerRoleID\":[\"48\"]\n}', '内网IP', '/ms/basic/manager/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.basic.action.ManagerAction.save()', 'insert', '127.0.0.1', '保存管理员实体', 0, NULL, 0, '2020-10-29 08:36:16', 0, 1);
INSERT INTO `system_log` VALUES (1321629423243362305, 'Invalid bound statement (not found): com.baomidou.mybatisplus.core.mapper.BaseMapper.insert', 'error', 'null', '{\n	\"contentTitle\":[\"sadadasd\"],\n	\"contentCategoryId\":[\"149\"],\n	\"contentType\":[\"\"],\n	\"contentDisplay\":[\"0\"],\n	\"contentAuthor\":[\"\"],\n	\"contentSource\":[\"asdad\"],\n	\"contentSort\":[\"0\"],\n	\"contentImg\":[\"[]\"],\n	\"contentDescription\":[\"sad\"],\n	\"contentKeyword\":[\"sad\"],\n	\"contentDetails\":[\"<p>dasd</p>\"],\n	\"id\":[\"\"],\n	\"contentDatetime\":[\"2020-10-29 09:46:12\"]\n}', '内网IP', '/ms/cms/content/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.ContentAction.save()', 'insert', '127.0.0.1', '保存文章', 0, NULL, 0, '2020-10-29 09:46:24', 0, 1);
INSERT INTO `system_log` VALUES (1321630281477677057, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'id\' at row 1\r\n### The error may exist in net/mingsoft/cms/dao/IContentDao.java (best guess)\r\n### The error may involve net.mingsoft.cms.dao.IContentDao.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO cms_content  ( id, `content_title`, `content_category_id`, `content_type`, `content_display`, `content_author`, `content_source`, `content_datetime`, `content_sort`, `content_img`, `content_description`, `content_keyword`, `content_details`,  `app_id`,  `create_by`, `create_date`, `del`, `update_by` )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?,  ?, ?, ?, ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'id\' at row 1\n; Data truncation: Out of range value for column \'id\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'id\' at row 1', 'error', 'null', '{\n	\"contentTitle\":[\"sadadasd\"],\n	\"contentCategoryId\":[\"149\"],\n	\"contentType\":[\"\"],\n	\"contentDisplay\":[\"0\"],\n	\"contentAuthor\":[\"\"],\n	\"contentSource\":[\"asdad\"],\n	\"contentSort\":[\"0\"],\n	\"contentImg\":[\"[]\"],\n	\"contentDescription\":[\"sad\"],\n	\"contentKeyword\":[\"sad\"],\n	\"contentDetails\":[\"<p>dasd</p>\"],\n	\"id\":[\"\"],\n	\"contentDatetime\":[\"2020-10-29 09:46:12\"]\n}', '内网IP', '/ms/cms/content/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.ContentAction.save()', 'insert', '127.0.0.1', '保存文章', 0, NULL, 0, '2020-10-29 09:49:48', 0, 1);
INSERT INTO `system_log` VALUES (1321630390198231041, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"appId\":1,\n		\"contentAuthor\":\"\",\n		\"contentCategoryId\":\"149\",\n		\"contentDatetime\":\"2020-10-29 09:46:12\",\n		\"contentDescription\":\"sad\",\n		\"contentDetails\":\"<p>dasd</p>\",\n		\"contentDisplay\":\"0\",\n		\"contentImg\":\"[]\",\n		\"contentKeyword\":\"sad\",\n		\"contentSort\":0,\n		\"contentSource\":\"asdad\",\n		\"contentTitle\":\"sadadasd\",\n		\"contentType\":\"\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-29 09:50:14\",\n		\"del\":0,\n		\"id\":\"1321630390097567745\",\n		\"sqlWhereList\":[],\n		\"updateBy\":0\n	}\n}', '{\n	\"contentTitle\":[\"sadadasd\"],\n	\"contentCategoryId\":[\"149\"],\n	\"contentType\":[\"\"],\n	\"contentDisplay\":[\"0\"],\n	\"contentAuthor\":[\"\"],\n	\"contentSource\":[\"asdad\"],\n	\"contentSort\":[\"0\"],\n	\"contentImg\":[\"[]\"],\n	\"contentDescription\":[\"sad\"],\n	\"contentKeyword\":[\"sad\"],\n	\"contentDetails\":[\"<p>dasd</p>\"],\n	\"id\":[\"\"],\n	\"contentDatetime\":[\"2020-10-29 09:46:12\"]\n}', '内网IP', '/ms/cms/content/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.ContentAction.save()', 'insert', '127.0.0.1', '保存文章', 0, NULL, 0, '2020-10-29 09:50:14', 0, 1);
INSERT INTO `system_log` VALUES (1321642210178916354, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"appId\":1,\n		\"categoryDatetime\":\"2018-07-09 11:07:41\",\n		\"categoryDescrip\":\"\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"\",\n		\"categoryListUrl\":\"case-list.htm\",\n		\"categoryManagerId\":50,\n		\"categoryPath\":\"/wangzhananli\",\n		\"categoryPinyin\":\"wangzhananli\",\n		\"categorySort\":1,\n		\"categoryTitle\":\"网站案例\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"case-list.htm\",\n		\"createBy\":0,\n		\"del\":0,\n		\"dictId\":0,\n		\"flag\":\"\",\n		\"id\":\"149\",\n		\"leaf\":false,\n		\"mdiyModelId\":\"\",\n		\"order\":\"\",\n		\"remarks\":\"\",\n		\"sqlWhereList\":[],\n		\"topId\":\"0\",\n		\"typedescrip\":\"\",\n		\"typeid\":\"149\",\n		\"typekeyword\":\"\",\n		\"typelink\":\"/wangzhananli/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"网站案例\",\n		\"typeurl\":\"\",\n		\"updateBy\":57,\n		\"updateDate\":\"2020-10-29 10:37:12\"\n	}\n}', '{\n	\"createBy\":[\"0\"],\n	\"createDate\":[\"\"],\n	\"del\":[\"0\"],\n	\"id\":[\"149\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"2019-12-28 17:49:38\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"网站案例\"],\n	\"categoryPinyin\":[\"wangzhananli\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"1\"],\n	\"categoryListUrl\":[\"case-list.htm\"],\n	\"categoryUrl\":[\"case-list.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"2018-07-09 11:07:41\"],\n	\"categoryManagerId\":[\"50\"],\n	\"appId\":[\"1\"],\n	\"dictId\":[\"0\"],\n	\"categoryFlag\":[\"\"],\n	\"categoryPath\":[\"/wangzhananli\"],\n	\"categoryParentId\":[\"\"],\n	\"leaf\":[\"false\"],\n	\"topId\":[\"0\"],\n	\"flag\":[\"\"],\n	\"typetitle\":[\"网站案例\"],\n	\"typelink\":[\"/wangzhananli/index.html\"],\n	\"typekeyword\":[\"\"],\n	\"typeurl\":[\"\"],\n	\"parentid\":[\"\"],\n	\"typedescrip\":[\"\"],\n	\"typeid\":[\"149\"],\n	\"typelitpic\":[\"\"]\n}', '内网IP', '/ms/cms/category/update.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', 'update', '127.0.0.1', '更新分类', 0, NULL, 0, '2020-10-29 10:37:12', 0, 1);
INSERT INTO `system_log` VALUES (1321642680070987777, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'id\' at row 1\r\n### The error may exist in net/mingsoft/cms/dao/ICategoryDao.java (best guess)\r\n### The error may involve net.mingsoft.cms.dao.ICategoryDao.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO cms_category  ( id, `category_title`, `category_pinyin`, `category_id`, `category_type`, `category_sort`, `category_list_url`, `category_url`, `category_keyword`, `category_descrip`, `category_img`, `category_diy_url`, `mdiy_model_id`,   `app_id`,  `category_flag`,     `create_by`, `create_date`, `del`, `update_by` )  VALUES  ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,   ?,  ?,     ?, ?, ?, ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'id\' at row 1\n; Data truncation: Out of range value for column \'id\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Out of range value for column \'id\' at row 1', 'error', 'null', '{\n	\"categoryTitle\":[\"dsadasd\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasd\"],\n	\"categoryDescrip\":[\"asdad\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:39:05', 0, 1);
INSERT INTO `system_log` VALUES (1321642836942151682, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"appId\":1,\n		\"categoryDescrip\":\"asdad\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"dasd\",\n		\"categoryListUrl\":\"about.htm\",\n		\"categoryPath\":\"/dsadasd\",\n		\"categoryPinyin\":\"dsadasd\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"dsadasd\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-29 10:39:41\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1321642836409475073\",\n		\"mdiyModelId\":\"\",\n		\"sqlWhereList\":[],\n		\"typedescrip\":\"asdad\",\n		\"typeid\":\"1321642836409475073\",\n		\"typekeyword\":\"dasd\",\n		\"typelink\":\"/dsadasd/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"dsadasd\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n}', '{\n	\"categoryTitle\":[\"dsadasd\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasd\"],\n	\"categoryDescrip\":[\"asdad\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:39:42', 0, 1);
INSERT INTO `system_log` VALUES (1321643278585585666, '\r\n### Error updating database.  Cause: java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1\r\n### The error may exist in net/mingsoft/cms/dao/ICategoryDao.java (best guess)\r\n### The error may involve net.mingsoft.cms.dao.ICategoryDao.updateById-Inline\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE cms_category  SET `category_title`=?, `category_pinyin`=?, `category_id`=?, `category_type`=?, `category_sort`=?, `category_list_url`=?, `category_url`=?, `category_keyword`=?, `category_descrip`=?, `category_img`=?, `category_diy_url`=?, `mdiy_model_id`=?,   `app_id`=?,  `category_flag`=?, `category_path`=?,   `top_id`=?, `create_by`=?, `create_date`=?, `del`=?, `update_by`=?, `update_date`=?  WHERE id=?\r\n### Cause: java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1\n; uncategorized SQLException; SQL state [HY000]; error code [1366]; Incorrect integer value: \'\' for column \'top_id\' at row 1; nested exception is java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1', 'error', 'null', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-10-29 10:39:42\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1321642836409475073\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"dsadasd\"],\n	\"categoryPinyin\":[\"dsadasd\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasd\"],\n	\"categoryDescrip\":[\"asdad\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"categoryManagerId\":[\"\"],\n	\"appId\":[\"1\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"categoryPath\":[\"/dsadasd\"],\n	\"categoryParentId\":[\"\"],\n	\"leaf\":[\"\"],\n	\"topId\":[\"\"],\n	\"flag\":[\"\"],\n	\"typetitle\":[\"dsadasd\"],\n	\"typelink\":[\"/dsadasd/index.html\"],\n	\"typekeyword\":[\"dasd\"],\n	\"typeurl\":[\"\"],\n	\"parentid\":[\"\"],\n	\"typedescrip\":[\"asdad\"],\n	\"typeid\":[\"1321642836409475073\"],\n	\"typelitpic\":[\"\"]\n}', '内网IP', '/ms/cms/category/update.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', 'update', '127.0.0.1', '更新分类', 0, NULL, 0, '2020-10-29 10:41:27', 0, 1);
INSERT INTO `system_log` VALUES (1321643481963192321, '\r\n### Error updating database.  Cause: java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1\r\n### The error may exist in net/mingsoft/cms/dao/ICategoryDao.java (best guess)\r\n### The error may involve net.mingsoft.cms.dao.ICategoryDao.updateById-Inline\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE cms_category  SET `category_title`=?, `category_pinyin`=?, `category_id`=?, `category_type`=?, `category_sort`=?, `category_list_url`=?, `category_url`=?, `category_keyword`=?, `category_descrip`=?, `category_img`=?, `category_diy_url`=?, `mdiy_model_id`=?,   `app_id`=?,  `category_flag`=?, `category_path`=?,   `top_id`=?, `create_by`=?, `create_date`=?, `del`=?, `update_by`=?, `update_date`=?  WHERE id=?\r\n### Cause: java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1\n; uncategorized SQLException; SQL state [HY000]; error code [1366]; Incorrect integer value: \'\' for column \'top_id\' at row 1; nested exception is java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1', 'error', 'null', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-10-29 10:39:42\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1321642836409475073\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"dsadasd\"],\n	\"categoryPinyin\":[\"dsadasd\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasd\"],\n	\"categoryDescrip\":[\"asdad\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"categoryManagerId\":[\"\"],\n	\"appId\":[\"1\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"categoryPath\":[\"/dsadasd\"],\n	\"categoryParentId\":[\"\"],\n	\"leaf\":[\"\"],\n	\"topId\":[\"\"],\n	\"flag\":[\"\"],\n	\"typetitle\":[\"dsadasd\"],\n	\"typelink\":[\"/dsadasd/index.html\"],\n	\"typekeyword\":[\"dasd\"],\n	\"typeurl\":[\"\"],\n	\"parentid\":[\"\"],\n	\"typedescrip\":[\"asdad\"],\n	\"typeid\":[\"1321642836409475073\"],\n	\"typelitpic\":[\"\"]\n}', '内网IP', '/ms/cms/category/update.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', 'update', '127.0.0.1', '更新分类', 0, NULL, 0, '2020-10-29 10:42:16', 0, 1);
INSERT INTO `system_log` VALUES (1321643685856698370, '\r\n### Error updating database.  Cause: java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1\r\n### The error may exist in net/mingsoft/cms/dao/ICategoryDao.java (best guess)\r\n### The error may involve net.mingsoft.cms.dao.ICategoryDao.updateById-Inline\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE cms_category  SET `category_title`=?, `category_pinyin`=?, `category_id`=?, `category_type`=?, `category_sort`=?, `category_list_url`=?, `category_url`=?, `category_keyword`=?, `category_descrip`=?, `category_img`=?, `category_diy_url`=?, `mdiy_model_id`=?,   `app_id`=?,  `category_flag`=?, `category_path`=?,   `top_id`=?, `create_by`=?, `create_date`=?, `del`=?, `update_by`=?, `update_date`=?  WHERE id=?\r\n### Cause: java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1\n; uncategorized SQLException; SQL state [HY000]; error code [1366]; Incorrect integer value: \'\' for column \'top_id\' at row 1; nested exception is java.sql.SQLException: Incorrect integer value: \'\' for column \'top_id\' at row 1', 'error', 'null', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-10-29 10:39:42\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1321642836409475073\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"dsadasd\"],\n	\"categoryPinyin\":[\"dsadasd\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasd\"],\n	\"categoryDescrip\":[\"asdad\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"categoryManagerId\":[\"\"],\n	\"appId\":[\"1\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"categoryPath\":[\"/dsadasd\"],\n	\"categoryParentId\":[\"\"],\n	\"leaf\":[\"\"],\n	\"topId\":[\"\"],\n	\"flag\":[\"\"],\n	\"typetitle\":[\"dsadasd\"],\n	\"typelink\":[\"/dsadasd/index.html\"],\n	\"typekeyword\":[\"dasd\"],\n	\"typeurl\":[\"\"],\n	\"parentid\":[\"\"],\n	\"typedescrip\":[\"asdad\"],\n	\"typeid\":[\"1321642836409475073\"],\n	\"typelitpic\":[\"\"]\n}', '内网IP', '/ms/cms/category/update.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', 'update', '127.0.0.1', '更新分类', 0, NULL, 0, '2020-10-29 10:43:04', 0, 1);
INSERT INTO `system_log` VALUES (1321643881357402114, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"appId\":1,\n		\"categoryDescrip\":\"asdad\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"dasd\",\n		\"categoryListUrl\":\"about.htm\",\n		\"categoryPath\":\"/dsadasd\",\n		\"categoryPinyin\":\"dsadasd\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"dsadasd\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-29 10:39:42\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1321642836409475073\",\n		\"mdiyModelId\":\"\",\n		\"order\":\"\",\n		\"remarks\":\"\",\n		\"sqlWhereList\":[],\n		\"topId\":\"0\",\n		\"typedescrip\":\"asdad\",\n		\"typeid\":\"1321642836409475073\",\n		\"typekeyword\":\"dasd\",\n		\"typelink\":\"/dsadasd/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"dsadasd\",\n		\"typeurl\":\"\",\n		\"updateBy\":57,\n		\"updateDate\":\"2020-10-29 10:43:48\"\n	}\n}', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-10-29 10:39:42\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1321642836409475073\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"dsadasd\"],\n	\"categoryPinyin\":[\"dsadasd\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasd\"],\n	\"categoryDescrip\":[\"asdad\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"categoryManagerId\":[\"\"],\n	\"appId\":[\"1\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"categoryPath\":[\"/dsadasd\"],\n	\"categoryParentId\":[\"\"],\n	\"leaf\":[\"\"],\n	\"topId\":[\"\"],\n	\"flag\":[\"\"],\n	\"typetitle\":[\"dsadasd\"],\n	\"typelink\":[\"/dsadasd/index.html\"],\n	\"typekeyword\":[\"dasd\"],\n	\"typeurl\":[\"\"],\n	\"parentid\":[\"\"],\n	\"typedescrip\":[\"asdad\"],\n	\"typeid\":[\"1321642836409475073\"],\n	\"typelitpic\":[\"\"]\n}', '内网IP', '/ms/cms/category/update.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', 'update', '127.0.0.1', '更新分类', 0, NULL, 0, '2020-10-29 10:43:51', 0, 1);
INSERT INTO `system_log` VALUES (1321643974345121794, 'For input string: \"1321642836409475073\"', 'error', 'null', '{\n	\"categoryTitle\":[\"sadasd\"],\n	\"categoryId\":[\"1321642836409475073\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasda\"],\n	\"categoryDescrip\":[\"dasd\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:44:13', 0, 1);
INSERT INTO `system_log` VALUES (1321644560570408961, NULL, 'error', 'null', '{\n	\"categoryTitle\":[\"sadasd\"],\n	\"categoryId\":[\"1321642836409475073\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasda\"],\n	\"categoryDescrip\":[\"dasd\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:46:33', 0, 1);
INSERT INTO `system_log` VALUES (1321645459955015681, NULL, 'error', 'null', '{\n	\"categoryTitle\":[\"sadasd\"],\n	\"categoryId\":[\"1321642836409475073\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasda\"],\n	\"categoryDescrip\":[\"dasd\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:50:07', 0, 1);
INSERT INTO `system_log` VALUES (1321645596550914049, NULL, 'error', 'null', '{\n	\"categoryTitle\":[\"sadasd\"],\n	\"categoryId\":[\"1321642836409475073\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasda\"],\n	\"categoryDescrip\":[\"dasd\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:50:40', 0, 1);
INSERT INTO `system_log` VALUES (1321645956300562433, NULL, 'error', 'null', '{\n	\"categoryTitle\":[\"sadasd\"],\n	\"categoryId\":[\"1321642836409475073\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasda\"],\n	\"categoryDescrip\":[\"dasd\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:52:06', 0, 1);
INSERT INTO `system_log` VALUES (1321646021064810498, NULL, 'error', 'null', '{\n	\"categoryTitle\":[\"sadasd\"],\n	\"categoryId\":[\"1321642836409475073\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasda\"],\n	\"categoryDescrip\":[\"dasd\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:52:21', 0, 1);
INSERT INTO `system_log` VALUES (1321646252254846977, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"appId\":1,\n		\"categoryDescrip\":\"dasd\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"1321642836409475073\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"dasda\",\n		\"categoryListUrl\":\"about.htm\",\n		\"categoryParentId\":\"1321642836409475073\",\n		\"categoryPath\":\"/dsadasd/sadasd\",\n		\"categoryPinyin\":\"sadasd\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"sadasd\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-29 10:53:13\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1321646240779231234\",\n		\"mdiyModelId\":\"\",\n		\"parentid\":\"1321642836409475073\",\n		\"sqlWhereList\":[],\n		\"topId\":\"1321642836409475073\",\n		\"typedescrip\":\"dasd\",\n		\"typeid\":\"1321646240779231234\",\n		\"typekeyword\":\"dasda\",\n		\"typelink\":\"/dsadasd/sadasd/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"sadasd\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n}', '{\n	\"categoryTitle\":[\"sadasd\"],\n	\"categoryId\":[\"1321642836409475073\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"dasda\"],\n	\"categoryDescrip\":[\"dasd\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-29 10:53:16', 0, 1);
INSERT INTO `system_log` VALUES (1321651454349434882, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-29 11:13:56', 0, 1);
INSERT INTO `system_log` VALUES (1321651461253259265, 'Error attempting to get column \'article_Id\' from result set.  Cause: java.sql.SQLDataException: Value \'1321630390097567745\' is outside of valid range for type java.lang.Integer\n; Value \'1321630390097567745\' is outside of valid range for type java.lang.Integer; nested exception is java.sql.SQLDataException: Value \'1321630390097567745\' is outside of valid range for type java.lang.Integer', 'error', 'null', '{\n	\"dateTime\":[\"2020-10-29\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-10-29 11:13:58', 0, 1);
INSERT INTO `system_log` VALUES (1321651472984727554, 'Error attempting to get column \'article_Id\' from result set.  Cause: java.sql.SQLDataException: Value \'1321630390097567745\' is outside of valid range for type java.lang.Integer\n; Value \'1321630390097567745\' is outside of valid range for type java.lang.Integer; nested exception is java.sql.SQLDataException: Value \'1321630390097567745\' is outside of valid range for type java.lang.Integer', 'error', 'null', '{}', '内网IP', '/ms/cms/generate/0/genernateColumn.do', 'msopen', 'manage', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', 'update', '127.0.0.1', '生成栏目', 0, NULL, 0, '2020-10-29 11:14:01', 0, 1);
INSERT INTO `system_log` VALUES (1321652324373925890, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', '/ms/cms/generate/0/genernateColumn.do', 'msopen', 'manage', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', 'update', '127.0.0.1', '生成栏目', 0, NULL, 0, '2020-10-29 11:17:24', 0, 1);
INSERT INTO `system_log` VALUES (1321652810850275329, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', '/ms/cms/generate/0/genernateColumn.do', 'msopen', 'manage', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', 'update', '127.0.0.1', '生成栏目', 0, NULL, 0, '2020-10-29 11:19:20', 0, 1);
INSERT INTO `system_log` VALUES (1321653007965851650, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', '/ms/cms/generate/0/genernateColumn.do', 'msopen', 'manage', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', 'update', '127.0.0.1', '生成栏目', 0, NULL, 0, '2020-10-29 11:20:07', 0, 1);
INSERT INTO `system_log` VALUES (1321653027532279809, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-10-29\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-10-29 11:20:12', 0, 1);
INSERT INTO `system_log` VALUES (1321693157194211329, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"createBy\":[\"0\"],\n	\"createDate\":[\"\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"\"],\n	\"order\":[\"\"],\n	\"appName\":[\"MCMS-OPEN\"],\n	\"appDescription\":[\"铭飞MCMS\"],\n	\"appLogo\":[\"[{\\\"path\\\":\\\"/upload/1/appLogo/1578375538540.jpg\\\",\\\"url\\\":\\\"/upload/1/appLogo/1578375538540.jpg\\\",\\\"uid\\\":1603951176409,\\\"status\\\":\\\"success\\\"}]\"],\n	\"appStyle\":[\"江西省人民政府-web\"],\n	\"appMobileStyle\":[\"\"],\n	\"appKeyword\":[\"铭飞MCMS\"],\n	\"appCopyright\":[\"版权所有 ©铭飞科技有限公司2012-2019 保留一切权利。\"],\n	\"appUrl\":[\"http://localhost:5107\"],\n	\"appDatetime\":[\"\"],\n	\"appPayDate\":[\"2019-11-16 00:00:00\"],\n	\"appPay\":[\"\"],\n	\"appLoginPage\":[\"\"],\n	\"appId\":[\"1\"],\n	\"appHostUrl\":[\"http://localhost:5107\"]\n}', '内网IP', '/ms/app/update.do', 'msopen', 'manage', 'POST', 'net.mingsoft.basic.action.AppAction.update()', 'update', '127.0.0.1', '更新站点信息', 0, NULL, 0, '2020-10-29 13:59:39', 0, 1);
INSERT INTO `system_log` VALUES (1321693210931634177, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-29 13:59:52', 0, 1);
INSERT INTO `system_log` VALUES (1321695272788566018, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-10-29 14:08:04', 0, 1);
INSERT INTO `system_log` VALUES (1321695385653092354, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-10-29\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-10-29 14:08:31', 0, 1);
INSERT INTO `system_log` VALUES (1321695399230054401, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', '/ms/cms/generate/0/genernateColumn.do', 'msopen', 'manage', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', 'update', '127.0.0.1', '生成栏目', 0, NULL, 0, '2020-10-29 14:08:34', 0, 1);
INSERT INTO `system_log` VALUES (1321696276359684097, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-10-06\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-10-29 14:12:03', 0, 1);
INSERT INTO `system_log` VALUES (1322103019309453314, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"categoryDescrip\":\"\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"\",\n		\"categoryListUrl\":\"about.htm\",\n		\"categoryPath\":\"/yijilanmu\",\n		\"categoryPinyin\":\"yijilanmu\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"一级栏目\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-30 17:08:17\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1322103018739027970\",\n		\"leaf\":false,\n		\"mdiyModelId\":\"\",\n		\"sqlWhereList\":[],\n		\"topId\":\"0\",\n		\"typedescrip\":\"\",\n		\"typeid\":\"1322103018739027970\",\n		\"typekeyword\":\"\",\n		\"typelink\":\"/yijilanmu/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"一级栏目\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n}', '{\n	\"categoryTitle\":[\"一级栏目\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"],\n	\"childId\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-30 17:08:18', 0, NULL);
INSERT INTO `system_log` VALUES (1322103456901189634, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"categoryDescrip\":\"\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"1322103018739027970\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"\",\n		\"categoryListUrl\":\"about.htm\",\n		\"categoryParentId\":\"1322103018739027970\",\n		\"categoryPath\":\"/yijilanmu/erjilanmu\",\n		\"categoryPinyin\":\"erjilanmu\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"二级栏目\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-30 17:10:02\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1322103456653725697\",\n		\"leaf\":false,\n		\"mdiyModelId\":\"\",\n		\"parentid\":\"1322103018739027970\",\n		\"sqlWhereList\":[],\n		\"topId\":\"1322103018739027970\",\n		\"typedescrip\":\"\",\n		\"typeid\":\"1322103456653725697\",\n		\"typekeyword\":\"\",\n		\"typelink\":\"/yijilanmu/erjilanmu/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"二级栏目\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n}', '{\n	\"categoryTitle\":[\"二级栏目\"],\n	\"categoryId\":[\"1322103018739027970\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"],\n	\"childId\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-30 17:10:02', 0, NULL);
INSERT INTO `system_log` VALUES (1322103634915840001, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"categoryDescrip\":\"\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"1322103456653725697\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"\",\n		\"categoryListUrl\":\"\",\n		\"categoryParentId\":\"1322103018739027970,1322103456653725697\",\n		\"categoryPath\":\"/yijilanmu/erjilanmu/sanjifengmian\",\n		\"categoryPinyin\":\"sanjifengmian\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"三级封面\",\n		\"categoryType\":\"2\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-30 17:10:44\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1322103634412523522\",\n		\"leaf\":false,\n		\"mdiyModelId\":\"\",\n		\"parentid\":\"1322103018739027970,1322103456653725697\",\n		\"sqlWhereList\":[],\n		\"topId\":\"1322103018739027970\",\n		\"typedescrip\":\"\",\n		\"typeid\":\"1322103634412523522\",\n		\"typekeyword\":\"\",\n		\"typelink\":\"/yijilanmu/erjilanmu/sanjifengmian/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"三级封面\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n}', '{\n	\"categoryTitle\":[\"三级封面\"],\n	\"categoryId\":[\"1322103456653725697\"],\n	\"categoryType\":[\"2\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"],\n	\"childId\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-30 17:10:45', 0, NULL);
INSERT INTO `system_log` VALUES (1322105806650867714, NULL, 'error', 'null', '{\n	\"categoryTitle\":[\"三级栏目\"],\n	\"categoryId\":[\"158\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"],\n	\"childId\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-30 17:19:22', 0, NULL);
INSERT INTO `system_log` VALUES (1322106070078324738, NULL, 'error', 'null', '{\n	\"categoryTitle\":[\"三级栏目\"],\n	\"categoryId\":[\"158\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"],\n	\"childId\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-30 17:20:25', 0, NULL);
INSERT INTO `system_log` VALUES (1322106305009680386, NULL, 'error', 'null', '{\n	\"categoryTitle\":[\"三级栏目\"],\n	\"categoryId\":[\"158\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"about.htm\"],\n	\"categoryUrl\":[\"about.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"],\n	\"childId\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-10-30 17:21:21', 0, NULL);
INSERT INTO `system_log` VALUES (1322357196233203714, 'For input string: \"1322103634412523522\"', 'error', 'null', '[\n	{\n		\"appId\":1,\n		\"categoryDescrip\":\"\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"1322103456653725697\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"\",\n		\"categoryListUrl\":\"\",\n		\"categoryParentId\":\"1322103018739027970,1322103456653725697\",\n		\"categoryPath\":\"/yijilanmu/erjilanmu/sanjifengmian\",\n		\"categoryPinyin\":\"sanjifengmian\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"三级封面\",\n		\"categoryType\":\"2\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-30 17:10:45\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1322103634412523522\",\n		\"leaf\":true,\n		\"mdiyModelId\":\"\",\n		\"parentid\":\"1322103018739027970,1322103456653725697\",\n		\"sqlWhereList\":[],\n		\"topId\":\"1322103018739027970\",\n		\"typedescrip\":\"\",\n		\"typeid\":\"1322103634412523522\",\n		\"typekeyword\":\"\",\n		\"typelink\":\"/yijilanmu/erjilanmu/sanjifengmian/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"三级封面\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n]', '内网IP', '/ms/cms/category/delete.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.delete()', 'delete', '127.0.0.1', '删除分类', 0, NULL, 0, '2020-10-31 09:58:18', 0, NULL);
INSERT INTO `system_log` VALUES (1322362116382507009, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '[\n	{\n		\"appId\":1,\n		\"categoryDescrip\":\"\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"1322103018739027970\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"\",\n		\"categoryListUrl\":\"about.htm\",\n		\"categoryParentId\":\"1322103018739027970\",\n		\"categoryPath\":\"/yijilanmu/erjilanmu\",\n		\"categoryPinyin\":\"erjilanmu\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"二级栏目\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-30 17:10:02\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1322103456653725697\",\n		\"leaf\":false,\n		\"mdiyModelId\":\"\",\n		\"parentid\":\"1322103018739027970\",\n		\"sqlWhereList\":[],\n		\"topId\":\"1322103018739027970\",\n		\"typedescrip\":\"\",\n		\"typeid\":\"1322103456653725697\",\n		\"typekeyword\":\"\",\n		\"typelink\":\"/yijilanmu/erjilanmu/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"二级栏目\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n]', '内网IP', '/ms/cms/category/delete.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.delete()', 'delete', '127.0.0.1', '删除分类', 0, NULL, 0, '2020-10-31 10:17:51', 0, NULL);
INSERT INTO `system_log` VALUES (1322362185760489474, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"contentAuthor\":\"\",\n		\"contentCategoryId\":\"1322103018739027970\",\n		\"contentDatetime\":\"2020-10-31 10:18:04\",\n		\"contentDescription\":\"\",\n		\"contentDetails\":\"\",\n		\"contentDisplay\":\"0\",\n		\"contentImg\":\"[]\",\n		\"contentKeyword\":\"\",\n		\"contentSort\":0,\n		\"contentSource\":\"\",\n		\"contentTitle\":\"1\",\n		\"contentType\":\"\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-31 10:18:07\",\n		\"del\":0,\n		\"id\":\"1322362185324281858\",\n		\"sqlWhereList\":[],\n		\"updateBy\":0\n	}\n}', '{\n	\"contentTitle\":[\"1\"],\n	\"contentCategoryId\":[\"1322103018739027970\"],\n	\"contentType\":[\"\"],\n	\"contentDisplay\":[\"0\"],\n	\"contentAuthor\":[\"\"],\n	\"contentSource\":[\"\"],\n	\"contentSort\":[\"0\"],\n	\"contentImg\":[\"[]\"],\n	\"contentDescription\":[\"\"],\n	\"contentKeyword\":[\"\"],\n	\"contentDetails\":[\"\"],\n	\"id\":[\"\"],\n	\"contentDatetime\":[\"2020-10-31 10:18:04\"]\n}', '内网IP', '/ms/cms/content/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.ContentAction.save()', 'insert', '127.0.0.1', '保存文章', 0, NULL, 0, '2020-10-31 10:18:08', 0, NULL);
INSERT INTO `system_log` VALUES (1322362214059458562, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '[\n	{\n		\"appId\":1,\n		\"categoryDescrip\":\"\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"\",\n		\"categoryListUrl\":\"about.htm\",\n		\"categoryPath\":\"/yijilanmu\",\n		\"categoryPinyin\":\"yijilanmu\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"一级栏目\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"about.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-10-30 17:08:18\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1322103018739027970\",\n		\"leaf\":false,\n		\"mdiyModelId\":\"\",\n		\"sqlWhereList\":[],\n		\"topId\":\"0\",\n		\"typedescrip\":\"\",\n		\"typeid\":\"1322103018739027970\",\n		\"typekeyword\":\"\",\n		\"typelink\":\"/yijilanmu/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"一级栏目\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n]', '内网IP', '/ms/cms/category/delete.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.delete()', 'delete', '127.0.0.1', '删除分类', 0, NULL, 0, '2020-10-31 10:18:15', 0, NULL);
INSERT INTO `system_log` VALUES (1322384869358723073, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-10-31\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-10-31 11:48:16', 0, NULL);
INSERT INTO `system_log` VALUES (1322384994579668993, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-10-31\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-10-31 11:48:46', 0, NULL);
INSERT INTO `system_log` VALUES (1323080347708805121, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-11-02 09:51:51', 0, NULL);
INSERT INTO `system_log` VALUES (1323080362883796994, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-11-02\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-11-02 09:51:55', 0, NULL);
INSERT INTO `system_log` VALUES (1323080539833094145, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"contentAuthor\":\"\",\n		\"contentCategoryId\":\"158\",\n		\"contentDatetime\":\"2020-11-02 09:52:14\",\n		\"contentDescription\":\"\",\n		\"contentDetails\":\"\",\n		\"contentDisplay\":\"0\",\n		\"contentImg\":\"[]\",\n		\"contentKeyword\":\"\",\n		\"contentSort\":0,\n		\"contentSource\":\"\",\n		\"contentTitle\":\"测试文章\",\n		\"contentType\":\"\",\n		\"createBy\":57,\n		\"createDate\":\"2020-11-02 09:52:36\",\n		\"del\":0,\n		\"id\":\"1323080539543687169\",\n		\"sqlWhereList\":[],\n		\"updateBy\":0\n	}\n}', '{\n	\"contentTitle\":[\"测试文章\"],\n	\"contentCategoryId\":[\"158\"],\n	\"contentType\":[\"\"],\n	\"contentDisplay\":[\"0\"],\n	\"contentAuthor\":[\"\"],\n	\"contentSource\":[\"\"],\n	\"contentSort\":[\"0\"],\n	\"contentImg\":[\"[]\"],\n	\"contentDescription\":[\"\"],\n	\"contentKeyword\":[\"\"],\n	\"contentDetails\":[\"\"],\n	\"id\":[\"\"],\n	\"contentDatetime\":[\"2020-11-02 09:52:14\"]\n}', '内网IP', '/ms/cms/content/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.ContentAction.save()', 'insert', '127.0.0.1', '保存文章', 0, NULL, 0, '2020-11-02 09:52:37', 0, NULL);
INSERT INTO `system_log` VALUES (1323080643084275713, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"categoryDescrip\":\"\",\n		\"categoryDiyUrl\":\"\",\n		\"categoryFlag\":\"\",\n		\"categoryId\":\"\",\n		\"categoryImg\":\"[]\",\n		\"categoryKeyword\":\"\",\n		\"categoryListUrl\":\"list.htm\",\n		\"categoryPath\":\"/ceshilanmu\",\n		\"categoryPinyin\":\"ceshilanmu\",\n		\"categorySort\":0,\n		\"categoryTitle\":\"测试栏目\",\n		\"categoryType\":\"1\",\n		\"categoryUrl\":\"detail.htm\",\n		\"createBy\":57,\n		\"createDate\":\"2020-11-02 09:53:01\",\n		\"del\":0,\n		\"flag\":\"\",\n		\"id\":\"1323080642752925697\",\n		\"leaf\":false,\n		\"mdiyModelId\":\"\",\n		\"sqlWhereList\":[],\n		\"topId\":\"0\",\n		\"typedescrip\":\"\",\n		\"typeid\":\"1323080642752925697\",\n		\"typekeyword\":\"\",\n		\"typelink\":\"/ceshilanmu/index.html\",\n		\"typelitpic\":\"\",\n		\"typetitle\":\"测试栏目\",\n		\"typeurl\":\"\",\n		\"updateBy\":0\n	}\n}', '{\n	\"categoryTitle\":[\"测试栏目\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"list.htm\"],\n	\"categoryUrl\":[\"detail.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"id\":[\"\"],\n	\"childId\":[\"\"]\n}', '内网IP', '/ms/cms/category/save.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.CategoryAction.save()', 'insert', '127.0.0.1', '保存分类', 0, NULL, 0, '2020-11-02 09:53:02', 0, NULL);
INSERT INTO `system_log` VALUES (1323080675531411458, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', '/ms/cms/generate//generateIndex.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', 'update', '127.0.0.1', '生成主页', 0, NULL, 0, '2020-11-02 09:53:09', 0, NULL);
INSERT INTO `system_log` VALUES (1323080705617154049, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', '/ms/cms/generate/0/genernateColumn.do', 'msopen', 'manage', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', 'update', '127.0.0.1', '生成栏目', 0, NULL, 0, '2020-11-02 09:53:17', 0, NULL);
INSERT INTO `system_log` VALUES (1323080721614229505, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-11-02\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-11-02 09:53:20', 0, NULL);
INSERT INTO `system_log` VALUES (1323080744804536322, NULL, 'success', '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2019-11-12\"]\n}', '内网IP', '/ms/cms/generate/0/generateArticle.do', 'msopen', 'manage', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', 'update', '127.0.0.1', '生成文章', 0, NULL, 0, '2020-11-02 09:53:26', 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
