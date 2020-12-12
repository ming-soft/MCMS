/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.0.8
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : 192.168.0.8:3316
 Source Schema         : mcms-5.2

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 05/12/2020 17:37:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '站点id',
  `app_name` varchar(60) NOT NULL COMMENT '站点名称',
  `app_url` varchar(200) NOT NULL COMMENT '站点域名，多个回车换行显示',
  `app_logo` varchar(4000) DEFAULT NULL COMMENT '网站logo',
  `app_keyword` varchar(500) DEFAULT NULL COMMENT '站点关键字',
  `app_copyright` varchar(500) DEFAULT NULL COMMENT '站点版权信息',
  `app_style` varchar(50) DEFAULT NULL COMMENT '站点风格',
  `app_description` varchar(500) DEFAULT NULL COMMENT '描述',
  `app_pay` varchar(300) DEFAULT NULL COMMENT '费用清单',
  `app_state` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '0运行中 1已停止  ',
  `app_datetime` datetime DEFAULT NULL COMMENT '创建时间',
  `app_pay_date` datetime DEFAULT NULL COMMENT '应用续费时间',
  `app_dir` varchar(10) DEFAULT NULL COMMENT '网站生成的目录',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) DEFAULT NULL COMMENT '修改人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) DEFAULT NULL,
  `del` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of app
-- ----------------------------
BEGIN;
INSERT INTO `app` VALUES (1, 'MCMS-OPEN', 'http://localhost:8080\r\n', '[{\"path\":\"/upload/1/appLogo/1578375538540.jpg\",\"url\":\"/upload/1/appLogo/1578375538540.jpg\",\"uid\":1604106086351,\"status\":\"success\"}]', '铭飞MCMS', '版权所有 ©铭飞科技有限公司2012-2019 保留一切权利。', 'default', '铭飞MCMS', '', 0, NULL, '2019-11-17 04:00:00', 'a', NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for cms_category
-- ----------------------------
DROP TABLE IF EXISTS `cms_category`;
CREATE TABLE `cms_category` (
  `id` bigint(20) unsigned NOT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL COMMENT '所属栏目',
  `leaf` int(1) DEFAULT NULL COMMENT '是否是叶子节点',
  `top_id` bigint(20) DEFAULT NULL COMMENT '顶级id',
  `dict_id` int(11) DEFAULT NULL COMMENT '字典对应编号',
  `mdiy_model_id` int(11) DEFAULT NULL COMMENT '栏目管理的内容模型id',
  `category_parent_ids` varchar(255) DEFAULT NULL COMMENT '父类型编号，多个id逗号',
  `category_title` varchar(255) DEFAULT NULL COMMENT '栏目管理名称',
  `category_img` varchar(2000) DEFAULT NULL COMMENT '缩略图',
  `category_flag` varchar(255) DEFAULT NULL COMMENT '栏目属性',
  `category_descrip` varchar(500) DEFAULT NULL COMMENT '栏目管理描述',
  `category_keyword` varchar(300) DEFAULT NULL COMMENT '栏目管理关键字',
  `category_path` varchar(255) DEFAULT NULL COMMENT '栏目路径',
  `category_diy_url` varchar(255) DEFAULT NULL COMMENT '自定义链接',
  `category_url` varchar(50) DEFAULT NULL COMMENT '内容模板',
  `category_list_url` varchar(50) DEFAULT NULL COMMENT '列表模板',
  `category_type` varchar(10) DEFAULT NULL COMMENT '栏目管理属性',
  `category_pinyin` varchar(255) DEFAULT NULL COMMENT '栏目拼音',
  `category_datetime` datetime DEFAULT NULL COMMENT '类别发布时间',
  `category_sort` int(11) DEFAULT NULL COMMENT '自定义顺序',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) DEFAULT NULL COMMENT '修改人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  `del` int(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类';

-- ----------------------------
-- Records of cms_category
-- ----------------------------
BEGIN;
INSERT INTO `cms_category` VALUES (1329256979346038786, NULL, 1, 0, NULL, NULL, NULL, '首页', '[]', 'n', '', '', '/shouye', '', '', '', '3', 'shouye', NULL, 0, '2020-12-04 19:36:55', 57, '2020-11-19 10:55:35', 57, 0);
INSERT INTO `cms_category` VALUES (1329257213283344385, NULL, 0, 0, NULL, NULL, NULL, '公司产品', '[]', 'n', '', '', '/product', '', 'product-detail.htm', 'product-list.htm', '1', 'product', NULL, 0, '2020-12-04 20:00:14', 57, '2020-11-19 10:56:31', 57, 0);
INSERT INTO `cms_category` VALUES (1329257282518720513, NULL, 0, 0, NULL, NULL, NULL, '新闻动态', '[]', 'n', '', '', '/news', '', 'news-detail.htm', 'news-list.htm', '1', 'news', NULL, 0, '2020-12-05 02:24:38', 57, '2020-11-19 10:56:47', 57, 0);
INSERT INTO `cms_category` VALUES (1329257498923835394, NULL, 0, 0, NULL, NULL, NULL, '关于我们', '[]', 'd', '', '', '/gywm', '', 'about.htm', '', '2', 'gywm', NULL, 0, '2020-11-19 18:32:52', 57, '2020-11-19 10:57:39', 57, 0);
INSERT INTO `cms_category` VALUES (1329257594591715329, 1329257498923835394, 1, 1329257498923835394, NULL, NULL, '1329257498923835394', '联系我们', '[]', 'd', '', '', '/gywm/lianxiwomen', '', 'about.htm', '', '2', 'lianxiwomen', NULL, 0, '2020-11-19 18:33:02', 57, '2020-11-19 10:58:02', 57, 0);
INSERT INTO `cms_category` VALUES (1329257757913718785, 1329257213283344385, 1, 1329257213283344385, NULL, NULL, '1329257213283344385', '开源产品', '[]', '', '', '', '/product/kycp', '', 'product-detail1.htm', 'product.htm', '1', 'kycp', NULL, 0, '2020-12-04 21:50:49', 57, '2020-11-19 10:58:41', 57, 0);
INSERT INTO `cms_category` VALUES (1329257820769558530, 1329257213283344385, 1, 1329257213283344385, NULL, NULL, '1329257213283344385', '行业产品', '[]', '', '', '', '/product/hycp', '', 'product-detail1.htm', 'product.htm', '1', 'hycp', NULL, 0, '2020-11-19 18:31:23', 57, '2020-11-19 10:58:56', 57, 0);
INSERT INTO `cms_category` VALUES (1329258628990967809, 1329257282518720513, 1, 1329257282518720513, NULL, NULL, '1329257282518720513', '公司动态', '[]', '', '', '', '/news/gsdt', '', 'news-detail.htm', 'news-list.htm', '1', 'gsdt', NULL, 0, '2020-11-19 18:32:23', 57, '2020-11-19 11:02:08', 57, 0);
INSERT INTO `cms_category` VALUES (1329258744783118337, 1329257282518720513, 1, 1329257282518720513, NULL, NULL, '1329257282518720513', '行业动态', '[]', '', '', '', '/news/xingyedongtai', '', 'news-detail.htm', 'news-list.htm', '1', 'xingyedongtai', NULL, 0, '2020-11-19 18:32:43', 57, '2020-11-19 11:02:36', 57, 0);
INSERT INTO `cms_category` VALUES (1329259260493766658, 1329257498923835394, 1, 1329257498923835394, NULL, NULL, '1329257498923835394', '公司介绍', '[]', '', '', '', '/gywm/gongsijieshao', '', 'about.htm', '', '2', 'gongsijieshao', NULL, 0, '2020-11-19 18:33:10', 57, '2020-11-19 11:04:39', 57, 0);
INSERT INTO `cms_category` VALUES (1329316146811314177, 1329257213283344385, 1, 1329257213283344385, NULL, NULL, '1329257213283344385', '平台产品', '[]', '', '', '', '/product/pingtaichanpin', '', 'product-detail1.htm', 'product.htm', '1', 'pingtaichanpin', NULL, 0, '2020-11-19 18:31:37', 57, '2020-11-19 14:50:42', 57, 0);
INSERT INTO `cms_category` VALUES (1329357285870346241, NULL, 1, 0, NULL, NULL, NULL, '幻灯', '[]', '', '', '', '/huandeng', '', 'news-detail.htm', 'news-list.htm', '1', 'huandeng', NULL, 0, '2020-11-19 18:33:47', 57, '2020-11-19 17:34:10', 57, 0);
COMMIT;

-- ----------------------------
-- Table structure for cms_content
-- ----------------------------
DROP TABLE IF EXISTS `cms_content`;
CREATE TABLE `cms_content` (
  `id` bigint(20) unsigned NOT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL COMMENT '所属栏目',
  `content_details` text COMMENT '文章内容',
  `content_title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `content_url` varchar(255) DEFAULT NULL COMMENT '文章跳转链接地址',
  `content_keyword` varchar(255) DEFAULT NULL COMMENT '关键字',
  `content_description` varchar(400) DEFAULT NULL COMMENT '描述',
  `content_img` varchar(1000) DEFAULT NULL COMMENT '文章缩略图',
  `content_source` varchar(255) DEFAULT NULL COMMENT '文章来源',
  `content_author` varchar(255) DEFAULT NULL COMMENT '文章作者',
  `content_display` varchar(10) DEFAULT NULL COMMENT '是否显示',
  `content_type` varchar(100) DEFAULT NULL COMMENT '文章类型',
  `content_datetime` datetime DEFAULT NULL COMMENT '发布时间',
  `content_sort` int(11) DEFAULT NULL COMMENT '自定义顺序',
  `content_hit` int(22) DEFAULT NULL COMMENT '点击次数',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) DEFAULT NULL COMMENT '修改人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  `del` int(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_category_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `cms_category` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章';

-- ----------------------------
-- Records of cms_content
-- ----------------------------
BEGIN;
INSERT INTO `cms_content` VALUES (1329315330427789313, 1329257757913718785, '', 'MCms内容插件', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:47:15', 0, NULL, NULL, 0, '2020-11-19 14:47:27', 57, 0);
INSERT INTO `cms_content` VALUES (1329315378351906818, 1329257757913718785, '', 'MPeople会员插件', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:47:29', 0, NULL, NULL, 0, '2020-11-19 14:47:38', 57, 0);
INSERT INTO `cms_content` VALUES (1329315424476667905, 1329257757913718785, '', 'MDiy自定义插件', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:47:40', 0, NULL, NULL, 0, '2020-11-19 14:47:49', 57, 0);
INSERT INTO `cms_content` VALUES (1329315860382294018, 1329257820769558530, '', 'MEC工程造价咨询管理软件', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:49:22', 0, NULL, NULL, 0, '2020-11-19 14:49:33', 57, 0);
INSERT INTO `cms_content` VALUES (1329315928002863105, 1329257820769558530, '', 'BIMCms施工管理软件', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:49:35', 0, NULL, NULL, 0, '2020-11-19 14:49:49', 57, 0);
INSERT INTO `cms_content` VALUES (1329316558960402434, 1329316146811314177, '', 'PM项目管理', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:52:08', 0, NULL, NULL, 0, '2020-11-19 14:52:20', 57, 0);
INSERT INTO `cms_content` VALUES (1329316838384934914, 1329316146811314177, '', 'Code代码生成器', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:53:19', 0, NULL, NULL, 0, '2020-11-19 14:53:26', 57, 0);
INSERT INTO `cms_content` VALUES (1329316887084998658, 1329316146811314177, '', 'Designer设计器', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:53:28', 0, NULL, NULL, 0, '2020-11-19 14:53:38', 57, 0);
INSERT INTO `cms_content` VALUES (1329316951228489729, 1329316146811314177, '<p>Store应用市场</p>', 'Store应用市场', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 14:53:39', 0, NULL, '2020-11-20 23:04:33', 57, '2020-11-19 14:53:53', 57, 0);
INSERT INTO `cms_content` VALUES (1329374638616158210, 1329258628990967809, '', '1', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 18:43:01', 0, 2, NULL, 0, '2020-11-19 18:43:07', 57, 0);
INSERT INTO `cms_content` VALUES (1329374684459900929, 1329258628990967809, '', '2', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 18:43:10', 0, NULL, NULL, 0, '2020-11-19 18:43:18', 57, 0);
INSERT INTO `cms_content` VALUES (1329374724146405378, 1329258744783118337, '', '3', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 18:43:23', 0, NULL, NULL, 0, '2020-11-19 18:43:27', 57, 0);
INSERT INTO `cms_content` VALUES (1329374855797219329, 1329259260493766658, '<p><span style=\"color: rgb(96, 98, 102); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px; text-align: right; background-color: rgb(255, 255, 255);\">关键字</span><span style=\"color: rgb(96, 98, 102); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px; text-align: right; background-color: rgb(255, 255, 255);\">关键字</span><span style=\"color: rgb(96, 98, 102); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px; text-align: right; background-color: rgb(255, 255, 255);\">关键字</span><span style=\"background-color: rgb(255, 255, 255); color: rgb(96, 98, 102); font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px; text-align: right;\">关键字</span></p>', '公司介绍', NULL, '关键字', '', '[]', '', '', '0', '', '2020-11-19 18:43:44', 0, NULL, '2020-11-19 19:01:03', 57, '2020-11-19 18:43:59', 57, 0);
INSERT INTO `cms_content` VALUES (1329374891826290690, 1329257594591715329, '', '联系我们', NULL, '', '', '[]', '', '', '0', '', '2020-11-19 18:44:00', 0, NULL, NULL, 0, '2020-11-19 18:44:07', 57, 0);
INSERT INTO `cms_content` VALUES (1329375005479346177, 1329357285870346241, '', '1', NULL, '', '', '[{\"url\":\"blob:http://192.168.0.7:5108/919ebda5-111d-4a87-81bf-78dd5f6fda9d\",\"name\":\"1476442997.jpg\",\"path\":\"/upload/1/cms/content/1605782672773.jpg\",\"uid\":1605782672436,\"status\":\"success\"}]', '', '', '0', '', '2020-11-19 18:44:22', 0, NULL, NULL, 0, '2020-11-19 18:44:35', 57, 0);
INSERT INTO `cms_content` VALUES (1329375064132493314, 1329357285870346241, '', '2', NULL, '', '', '[{\"url\":\"/upload/1/cms/content/1605782687216.jpg\",\"name\":\"488679304.jpg\",\"path\":\"/upload/1/cms/content/1605782687216.jpg\",\"uid\":1605782686920,\"status\":\"success\"}]', '', '', '0', '', '2020-11-19 18:44:37', 0, NULL, '2020-11-22 19:33:37', 57, '2020-11-19 18:44:49', 57, 0);
COMMIT;

-- ----------------------------
-- Table structure for cms_history_log
-- ----------------------------
DROP TABLE IF EXISTS `cms_history_log`;
CREATE TABLE `cms_history_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` bigint(20) unsigned NOT NULL COMMENT '文章编号',
  `people_id` int(20) DEFAULT NULL COMMENT '用户id',
  `hl_ip` varchar(255) DEFAULT NULL COMMENT '浏览ip',
  `hl_is_mobile` varchar(255) DEFAULT NULL COMMENT '是否为移动端',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) DEFAULT NULL COMMENT '修改人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  `del` int(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文章浏览记录';

-- ----------------------------
-- Records of cms_history_log
-- ----------------------------
BEGIN;
INSERT INTO `cms_history_log` VALUES (1, 1324670399994753026, NULL, '192.168.0.4', '0', NULL, NULL, '2020-11-18 10:58:02', NULL, 0);
INSERT INTO `cms_history_log` VALUES (2, 1329374638616158210, NULL, '127.0.0.1', '0', NULL, NULL, '2020-11-20 22:55:26', NULL, 0);
INSERT INTO `cms_history_log` VALUES (3, 1329374638616158210, NULL, '192.168.0.4', '0', NULL, NULL, '2020-11-21 13:23:18', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `log_error_msg` varchar(4000) DEFAULT NULL COMMENT '错误消息',
  `log_result` varchar(4000) DEFAULT NULL COMMENT '返回参数',
  `log_param` varchar(4000) DEFAULT NULL COMMENT '请求参数',
  `log_location` varchar(255) DEFAULT NULL COMMENT '所在地区',
  `log_user` varchar(255) DEFAULT NULL COMMENT '操作人员',
  `log_user_type` varchar(255) DEFAULT NULL COMMENT '用户类型',
  `log_business_type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `log_status` varchar(255) DEFAULT NULL COMMENT '请求状态',
  `log_url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `log_request_method` varchar(255) DEFAULT NULL COMMENT '请求方式',
  `log_method` varchar(255) DEFAULT NULL COMMENT '请求方法',
  `log_ip` varchar(255) DEFAULT NULL COMMENT 'IP',
  `log_title` varchar(255) DEFAULT NULL COMMENT '标题',
  `del` int(1) DEFAULT '0' COMMENT '删除标记',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) DEFAULT NULL COMMENT '修改人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统日志';

-- ----------------------------
-- Records of log
-- ----------------------------
BEGIN;
INSERT INTO `log` VALUES (1, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-11-20 22:55:00', NULL);
INSERT INTO `log` VALUES (2, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2019-10-22\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-11-20 22:55:02', NULL);
INSERT INTO `log` VALUES (3, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-11-20 22:55:03', NULL);
INSERT INTO `log` VALUES (4, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":\"685\"\n}', '{\n	\"createBy\":[\"0\"],\n	\"createDate\":[\"\"],\n	\"del\":[\"0\"],\n	\"id\":[\"685\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"\"],\n	\"order\":[\"\"],\n	\"modelTitle\":[\"系统日志\"],\n	\"modelId\":[\"84\"],\n	\"modelUrl\":[\"basic/log/index.do\"],\n	\"modelCode\":[\"65123656532\"],\n	\"isChild\":[\"\"],\n	\"modelIcon\":[\"\"],\n	\"managerId\":[\"0\"],\n	\"modelSort\":[\"0\"],\n	\"modelIsMenu\":[\"1\"],\n	\"chick\":[\"0\"],\n	\"childNum\":[\"0\"],\n	\"depth\":[\"1\"],\n	\"modelParentIds\":[\"84\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/model/update.do', 'POST', 'net.mingsoft.basic.action.ModelAction.update()', '127.0.0.1', '更新模块表信息模块表', 0, NULL, NULL, '2020-11-20 22:57:38', NULL);
INSERT INTO `log` VALUES (5, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":\"686\"\n}', '{\n	\"createBy\":[\"0\"],\n	\"createDate\":[\"\"],\n	\"del\":[\"0\"],\n	\"id\":[\"686\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"\"],\n	\"order\":[\"\"],\n	\"modelTitle\":[\"查看\"],\n	\"modelId\":[\"685\"],\n	\"modelUrl\":[\"basic:log:view\"],\n	\"modelCode\":[\"351463145634\"],\n	\"isChild\":[\"\"],\n	\"modelIcon\":[\"\"],\n	\"managerId\":[\"0\"],\n	\"modelSort\":[\"0\"],\n	\"modelIsMenu\":[\"0\"],\n	\"chick\":[\"0\"],\n	\"childNum\":[\"0\"],\n	\"depth\":[\"2\"],\n	\"modelParentIds\":[\"84,685\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/model/update.do', 'POST', 'net.mingsoft.basic.action.ModelAction.update()', '127.0.0.1', '更新模块表信息模块表', 0, NULL, NULL, '2020-11-20 22:57:54', NULL);
INSERT INTO `log` VALUES (6, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-11-20 22:58:21', NULL);
INSERT INTO `log` VALUES (7, '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 10\r\n### The error may exist in net/mingsoft/cms/dao/IContentDao.xml\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select    ct.id article_id,c.*    FROM cms_content ct    LEFT JOIN cms_category c ON ct.category_id = c.id    where ct.del=0               and (ct.category_id=? or ct.category_id in     (select id FROM cms_category where find_in_set(\'1329256979346038786\',CATEGORY_PARENT_ID))\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 10\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\' at line 10', 'null', '{}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-11-20 22:58:23', NULL);
INSERT INTO `log` VALUES (8, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-11-20 22:59:39', NULL);
INSERT INTO `log` VALUES (9, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-11-20 22:59:42', NULL);
INSERT INTO `log` VALUES (10, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2019-10-22\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-11-20 22:59:45', NULL);
INSERT INTO `log` VALUES (11, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-11-20 23:02:55', NULL);
INSERT INTO `log` VALUES (12, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-11-21\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-11-20 23:03:01', NULL);
INSERT INTO `log` VALUES (13, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-11-20 23:03:03', NULL);
INSERT INTO `log` VALUES (14, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"cityName\":\"\",\n		\"countyName\":\"\",\n		\"createBy\":0,\n		\"del\":0,\n		\"id\":\"1\",\n		\"intId\":1,\n		\"integerId\":1,\n		\"newUser\":true,\n		\"peopleAutoLogin\":0,\n		\"peopleId\":1,\n		\"peopleMail\":\"11111111111@qq.com\",\n		\"peopleMailCheck\":1,\n		\"peopleName\":\"zs\",\n		\"peoplePhone\":\"11111111111\",\n		\"peoplePhoneCheck\":1,\n		\"peopleState\":1,\n		\"provinceName\":\"\",\n		\"puAddress\":\"1\",\n		\"puBirthday\":\"2020-11-09\",\n		\"puCard\":\"1\",\n		\"puIcon\":\"/upload/1/people/user/1605935035645.jpg\",\n		\"puLevel\":\"\",\n		\"puLevelName\":\"\",\n		\"puNickname\":\"张三\",\n		\"puRealName\":\"1\",\n		\"puSex\":1,\n		\"sqlWhereList\":[],\n		\"updateBy\":57,\n		\"updateDate\":\"2020-11-21 13:03:57\"\n	}\n}', '{\n	\"peopleName\":[\"zs\"],\n	\"peoplePassword\":[\"\"],\n	\"puNickname\":[\"张三\"],\n	\"puSex\":[\"1\"],\n	\"puBirthday\":[\"2020-11-09\"],\n	\"puRealName\":[\"1\"],\n	\"puCard\":[\"1\"],\n	\"peoplePhone\":[\"11111111111\"],\n	\"peopleMail\":[\"11111111111@qq.com\"],\n	\"peoplePhoneCheck\":[\"1\"],\n	\"peopleMailCheck\":[\"1\"],\n	\"peopleState\":[\"1\"],\n	\"puIcon\":[\"/upload/1/people/user/1605935035645.jpg\"],\n	\"provinceId\":[\"\"],\n	\"provinceName\":[\"\"],\n	\"cityName\":[\"\"],\n	\"countyName\":[\"\"],\n	\"cityId\":[\"\"],\n	\"countyId\":[\"\"],\n	\"puAddress\":[\"1\"],\n	\"puLevel\":[\"\"],\n	\"puLevelName\":[\"\"],\n	\"peopleId\":[\"1\"],\n	\"peopleDateTime\":[\"\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/people/peopleUser/update.do', 'POST', 'net.mingsoft.people.action.PeopleUserAction.update()', '127.0.0.1', '修改用户基础信息接口', 0, NULL, NULL, '2020-11-20 23:03:57', NULL);
INSERT INTO `log` VALUES (15, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-11-20 23:08:54', NULL);
INSERT INTO `log` VALUES (16, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '192.168.0.4', '生成栏目', 0, NULL, NULL, '2020-11-21 13:23:06', NULL);
INSERT INTO `log` VALUES (17, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-11-21\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '192.168.0.4', '生成文章', 0, NULL, NULL, '2020-11-21 13:23:07', NULL);
INSERT INTO `log` VALUES (18, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '192.168.0.4', '生成主页', 0, NULL, NULL, '2020-11-21 13:23:08', NULL);
INSERT INTO `log` VALUES (19, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2019-10-15\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '192.168.0.4', '生成文章', 0, NULL, NULL, '2020-11-21 13:23:14', NULL);
INSERT INTO `log` VALUES (20, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '192.168.0.4', '生成主页', 0, NULL, NULL, '2020-11-21 13:23:15', NULL);
INSERT INTO `log` VALUES (21, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"cityName\":\"\",\n		\"countyName\":\"\",\n		\"createBy\":0,\n		\"del\":0,\n		\"id\":\"1\",\n		\"intId\":1,\n		\"integerId\":1,\n		\"newUser\":true,\n		\"peopleAutoLogin\":0,\n		\"peopleId\":1,\n		\"peopleMail\":\"11111111111@qq.com\",\n		\"peopleMailCheck\":1,\n		\"peopleName\":\"zs\",\n		\"peoplePhone\":\"11111111111\",\n		\"peoplePhoneCheck\":1,\n		\"peopleState\":1,\n		\"provinceName\":\"\",\n		\"puAddress\":\"1\",\n		\"puBirthday\":\"2020-11-08\",\n		\"puCard\":\"1\",\n		\"puIcon\":\"/upload/1/people/user/1605936220556.jpg\",\n		\"puLevel\":\"\",\n		\"puLevelName\":\"\",\n		\"puNickname\":\"张三\",\n		\"puRealName\":\"1\",\n		\"puSex\":1,\n		\"sqlWhereList\":[],\n		\"updateBy\":57,\n		\"updateDate\":\"2020-11-21 13:23:42\"\n	}\n}', '{\n	\"peopleName\":[\"zs\"],\n	\"peoplePassword\":[\"\"],\n	\"puNickname\":[\"张三\"],\n	\"puSex\":[\"1\"],\n	\"puBirthday\":[\"2020-11-08\"],\n	\"puRealName\":[\"1\"],\n	\"puCard\":[\"1\"],\n	\"peoplePhone\":[\"11111111111\"],\n	\"peopleMail\":[\"11111111111@qq.com\"],\n	\"peoplePhoneCheck\":[\"1\"],\n	\"peopleMailCheck\":[\"1\"],\n	\"peopleState\":[\"1\"],\n	\"puIcon\":[\"/upload/1/people/user/1605936220556.jpg\"],\n	\"provinceId\":[\"\"],\n	\"provinceName\":[\"\"],\n	\"cityName\":[\"\"],\n	\"countyName\":[\"\"],\n	\"cityId\":[\"\"],\n	\"countyId\":[\"\"],\n	\"puAddress\":[\"1\"],\n	\"puLevel\":[\"\"],\n	\"puLevelName\":[\"\"],\n	\"peopleId\":[\"1\"],\n	\"peopleDateTime\":[\"\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/people/peopleUser/update.do', 'POST', 'net.mingsoft.people.action.PeopleUserAction.update()', '192.168.0.4', '������������������������������', 0, NULL, NULL, '2020-11-21 13:23:43', NULL);
INSERT INTO `log` VALUES (22, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"cityName\":\"\",\n		\"countyName\":\"\",\n		\"createBy\":57,\n		\"createDate\":\"2020-11-21 13:24:00\",\n		\"del\":0,\n		\"id\":\"2\",\n		\"intId\":2,\n		\"integerId\":2,\n		\"newUser\":true,\n		\"peopleAutoLogin\":0,\n		\"peopleDateTime\":\"2020-11-21 13:24:00\",\n		\"peopleMail\":\"\",\n		\"peopleMailCheck\":0,\n		\"peopleName\":\"lisi\",\n		\"peoplePhone\":\"\",\n		\"peoplePhoneCheck\":0,\n		\"peopleState\":0,\n		\"provinceName\":\"\",\n		\"puAddress\":\"\",\n		\"puCard\":\"\",\n		\"puIcon\":\"/upload/1/people/user/1605936239726.jpg\",\n		\"puLevel\":\"\",\n		\"puLevelName\":\"\",\n		\"puNickname\":\"李四\",\n		\"puRealName\":\"\",\n		\"sqlWhereList\":[],\n		\"updateBy\":0\n	}\n}', '{\n	\"peopleName\":[\"lisi\"],\n	\"peoplePassword\":[\"lisi\"],\n	\"puNickname\":[\"李四\"],\n	\"puSex\":[\"\"],\n	\"puBirthday\":[\"\"],\n	\"puRealName\":[\"\"],\n	\"puCard\":[\"\"],\n	\"peoplePhone\":[\"\"],\n	\"peopleMail\":[\"\"],\n	\"peoplePhoneCheck\":[\"0\"],\n	\"peopleMailCheck\":[\"0\"],\n	\"peopleState\":[\"0\"],\n	\"puIcon\":[\"/upload/1/people/user/1605936239726.jpg\"],\n	\"provinceId\":[\"\"],\n	\"provinceName\":[\"\"],\n	\"cityName\":[\"\"],\n	\"countyName\":[\"\"],\n	\"cityId\":[\"\"],\n	\"countyId\":[\"\"],\n	\"puAddress\":[\"\"],\n	\"puLevel\":[\"\"],\n	\"puLevelName\":[\"\"],\n	\"peopleId\":[\"\"]\n}', '内网IP', 'msopen', 'manage', 'insert', 'success', '/ms/people/peopleUser/save.do', 'POST', 'net.mingsoft.people.action.PeopleUserAction.save()', '192.168.0.4', '������������������������������', 0, NULL, NULL, '2020-11-21 13:24:02', NULL);
INSERT INTO `log` VALUES (23, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '192.168.0.4', '生成栏目', 0, NULL, NULL, '2020-11-21 13:39:39', NULL);
INSERT INTO `log` VALUES (24, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-11-21\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '192.168.0.4', '生成文章', 0, NULL, NULL, '2020-11-21 13:39:40', NULL);
INSERT INTO `log` VALUES (25, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2019-11-13\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '192.168.0.4', '生成文章', 0, NULL, NULL, '2020-11-21 13:39:46', NULL);
INSERT INTO `log` VALUES (26, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '192.168.0.4', '生成主页', 0, NULL, NULL, '2020-11-21 13:39:48', NULL);
INSERT INTO `log` VALUES (27, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"fileName\":[\"template\\\\1/\\\\default\\\\detail.htm\"],\n	\"name\":[\"detail.htm\"],\n	\"fileNamePrefix\":[\"template\\\\1/\\\\default\\\\\"],\n	\"fileContent\":[\"\\n\\n    <!--网络请求框架-->\\n\\n\\n<html>\\n<head>\\n    <meta charset=\\\"utf-8\\\" />\\n    <title>{ms:global.name/}</title>\\n    <meta http-equiv=\\\"content-type\\\" content=\\\"text/html\\\" />\\n    <META HTTP-EQUIV=\\\"Pragma\\\" CONTENT=\\\"no-cache\\\" />\\n    <meta name=\\\"viewport\\\" content=\\\"initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,width=device-width\\\"/>\\n    <meta name=\\\"format-detection\\\" content=\\\"telephone=no\\\"/>\\n    <meta name=\\\"app-mobile-web-app-capable\\\" content=\\\"yes\\\"/>\\n    <meta name=\\\"app-mobile-web-app-status-bar-style\\\" content=\\\"black-translucent\\\"/>\\n    <meta name=\\\"keywords\\\" content=\\\"{ms:global.keyword/}\\\" />\\n    <meta name=\\\"description\\\" content=\\\"{ms:global.descrip/}\\\" />\\n    <script type=\\\"text/javascript\\\" src=\\\"{ms:global.host/}/static/plugins/vue/2.6.9/vue.min.js\\\"></script>\\n    <link rel=\\\"stylesheet\\\" href=\\\"{ms:global.host/}/static/plugins/minireset/0.0.2/minireset.min.css\\\" />\\n    <link rel=\\\"stylesheet\\\" href=\\\"https://cdn.mingsoft.net/iconfont/iconfont.css\\\" />\\n    <link rel=\\\"stylesheet\\\" href=\\\"{ms:global.host/}/static/plugins/animate/4.1.0/animate.min.css\\\">\\n    <script src=\\\"{ms:global.host/}/static/plugins/element-ui/2.12.0/index.js\\\"></script>\\n    <link rel=\\\"stylesheet\\\" href=\\\"{ms:global.host/}/static/plugins/element-ui/2.12.0/index.css\\\" />\\n\\n    <link rel=\\\"stylesheet\\\" href=\\\"{ms:global.host/}/{ms:global.style/}/css/app.css\\\" />\\n\\n    <!--网络请求框架-->\\n    <script src=\\\"{ms:global.host/}/static/plugins/axios/0.18.0/axios.min.js\\\"></script>\\n    <script src=\\\"{ms:global.host/}/static/plugins/qs/6.6.0/qs.min.js\\\"></script>\\n    <script src=\\\"{ms:global.host/}/static/plugins/ms/1.0.0/ms.js\\\"></script>\\n    <script src=\\\"{ms:global.host/}/static/plugins/ms/1.0.0/ms.http.js\\\"></script>\\n    <script src=\\\"{ms:global.host/}/static/plugins/ms/1.0.0/ms.util.js\\\"></script>\\n    <script>\\n        ms.base = \\\"\\\";\\n    </script>\\n    <style>\\n        [v-cloak]{\\n            display: none;\\n        }\\n    </style>\\n</head>\\n<body>\\n    <div id=\\\"app\\\" v-cloak>\\n\\n        <#include \\\"header.htm\\\"/>\\n\\n\\n<div class=\\\"content\\\">\\n<div class=\\\"ms-channel-path\\\">\\n<span class=\\\"ms-channel-path-label\\\">\\n当前位置：\\n</span>\\n<a href=\\\"/\\\" class=\\\"ms-channel-path-index\\\">\\n首页\\n</a>\\n{ms:channel type=\\\"path\\\"}\\n<i class=\\\"iconfont icon-youjiantou\\\"></i>\\n<a href=\\\"{ms:global.url/}${field.typelink}\\\" class=\\\"ms-channel-path-link\\\">\\n${field.typetitle}\\n</a>\\n{/ms:channel}\\n</div>\\n<div class=\\\"detail\\\">\\n<div class=\\\"top\\\">\\n<span class=\\\"title\\\" >\\n${field.title}\\n</span>\\n<div class=\\\"date\\\">\\n<span >\\n发布时间：\\n</span>\\n<span >\\n${field.date?string(\\\"yyyy-MM-dd\\\")}\\n</span>\\n<div style=\\\"flex-wrap:nowrap;flex-direction:row;display:flex;width:20px;box-sizing:border-box;margin-top:0px;height:100%;\\\">\\n</div>\\n<span >\\n浏览次数：\\n</span>\\n<span >\\n${field.hit}\\n</span>\\n</div> </div>\\n<div class=\\\"body\\\">\\n<span class=\\\"body-text\\\" >\\n${field.content}\\n</span>\\n</div> </div>\\n<div class=\\\"ms-next-pre\\\">\\n<div class=\\\"pre\\\">\\n<span >\\n上一篇：\\n</span>\\n<a href=\\\"${global.url}${pre.link}\\\"\\n>\\n${pre.title}\\n</a>\\n</div>\\n<div class=\\\"next\\\">\\n<span >\\n下一篇：\\n</span>\\n<a href=\\\"${global.url}${next.link}\\\"\\n>\\n${next.title}\\n</a>\\n</div> </div> </div>\\n        <#include \\\"footer.htm\\\"/>\\n    </div>\\n</body>\\n</html>\\n\\n<script>\\nvar app = new Vue({\\n    el: \'#app\',\\n    watch:{\\n    },\\n    data: {\\n    },\\n    methods: {\\n       switchShow:function(arr){\\n       var that = this\\n           arr.forEach(function(x){\\n              let e = that.$el.querySelector(\\\"#key_\\\"+x)\\n               if(e){\\n                   e.style.display=e.style.display==\'none\'?\'flex\':\'none\'\\n               }\\n           })\\n       },\\n    },\\n    created(){\\n    }\\n})\\n</script>\\n\\n<style>\\n    body {\\n        background-color:#f5f5f5;\\n        box-sizing:border-box;\\n        font-family:-appl', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/template/writeFileContent.do', 'POST', 'net.mingsoft.basic.action.TemplateAction.writeFileContent()', '127.0.0.1', '写入模版文件内容', 0, NULL, NULL, '2020-11-22 18:36:55', NULL);
INSERT INTO `log` VALUES (28, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"fileName\":[\"template\\\\1/\\\\default\\\\detail.htm\"],\n	\"name\":[\"detail.htm\"],\n	\"fileNamePrefix\":[\"template\\\\1/\\\\default\\\\\"],\n	\"fileContent\":[\"\\n\\n\\n<html>\\n<head>\\n    <meta charset=\\\"utf-8\\\" />\\n    <title>{ms:global.name/}</title>\\n    <meta http-equiv=\\\"content-type\\\" content=\\\"text/html\\\" />\\n    <META HTTP-EQUIV=\\\"Pragma\\\" CONTENT=\\\"no-cache\\\" />\\n    <meta name=\\\"viewport\\\" content=\\\"initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,width=device-width\\\"/>\\n    <meta name=\\\"format-detection\\\" content=\\\"telephone=no\\\"/>\\n    <meta name=\\\"app-mobile-web-app-capable\\\" content=\\\"yes\\\"/>\\n    <meta name=\\\"app-mobile-web-app-status-bar-style\\\" content=\\\"black-translucent\\\"/>\\n    <meta name=\\\"keywords\\\" content=\\\"{ms:global.keyword/}\\\" />\\n    <meta name=\\\"description\\\" content=\\\"{ms:global.descrip/}\\\" />\\n    <script type=\\\"text/javascript\\\" src=\\\"{ms:global.host/}/static/plugins/vue/2.6.9/vue.min.js\\\"></script>\\n    <link rel=\\\"stylesheet\\\" href=\\\"{ms:global.host/}/static/plugins/minireset/0.0.2/minireset.min.css\\\" />\\n    <link rel=\\\"stylesheet\\\" href=\\\"https://cdn.mingsoft.net/iconfont/iconfont.css\\\" />\\n    <link rel=\\\"stylesheet\\\" href=\\\"{ms:global.host/}/static/plugins/animate/4.1.0/animate.min.css\\\">\\n    <script src=\\\"{ms:global.host/}/static/plugins/element-ui/2.12.0/index.js\\\"></script>\\n    <link rel=\\\"stylesheet\\\" href=\\\"{ms:global.host/}/static/plugins/element-ui/2.12.0/index.css\\\" />\\n\\n    <link rel=\\\"stylesheet\\\" href=\\\"{ms:global.host/}/{ms:global.style/}/css/app.css\\\" />\\n\\n    <!--网络请求框架-->\\n    <script src=\\\"{ms:global.host/}/static/plugins/axios/0.18.0/axios.min.js\\\"></script>\\n    <script src=\\\"{ms:global.host/}/static/plugins/qs/6.6.0/qs.min.js\\\"></script>\\n    <script src=\\\"{ms:global.host/}/static/plugins/ms/1.0.0/ms.js\\\"></script>\\n    <script src=\\\"{ms:global.host/}/static/plugins/ms/1.0.0/ms.http.js\\\"></script>\\n    <script src=\\\"{ms:global.host/}/static/plugins/ms/1.0.0/ms.util.js\\\"></script>\\n    <script>\\n        ms.base = \\\"\\\";\\n    </script>\\n    <style>\\n        [v-cloak]{\\n            display: none;\\n        }\\n    </style>\\n</head>\\n<body>\\n    <div id=\\\"app\\\" v-cloak>\\n\\n        <#include \\\"header.htm\\\"/>\\n\\n\\n<div class=\\\"content\\\">\\n<div class=\\\"ms-channel-path\\\">\\n<span class=\\\"ms-channel-path-label\\\">\\n当前位置：\\n</span>\\n<a href=\\\"/\\\" class=\\\"ms-channel-path-index\\\">\\n首页\\n</a>\\n{ms:channel type=\\\"path\\\"}\\n<i class=\\\"iconfont icon-youjiantou\\\"></i>\\n<a href=\\\"{ms:global.url/}${field.typelink}\\\" class=\\\"ms-channel-path-link\\\">\\n${field.typetitle}\\n</a>\\n{/ms:channel}\\n</div>\\n<div class=\\\"detail\\\">\\n<div class=\\\"top\\\">\\n<span class=\\\"title\\\" >\\n${field.title}\\n</span>\\n<div class=\\\"date\\\">\\n<span >\\n发布时间：\\n</span>\\n<span >\\n${field.date?string(\\\"yyyy-MM-dd\\\")}\\n</span>\\n<div style=\\\"flex-wrap:nowrap;flex-direction:row;display:flex;width:20px;box-sizing:border-box;margin-top:0px;height:100%;\\\">\\n</div>\\n<span >\\n浏览次数：\\n</span>\\n<span >\\n${field.hit}\\n</span>\\n</div> </div>\\n<div class=\\\"body\\\">\\n<span class=\\\"body-text\\\" >\\n${field.content}\\n</span>\\n</div> </div>\\n<div class=\\\"ms-next-pre\\\">\\n<div class=\\\"pre\\\">\\n<span >\\n上一篇：\\n</span>\\n<a href=\\\"${global.url}${pre.link}\\\"\\n>\\n${pre.title}\\n</a>\\n</div>\\n<div class=\\\"next\\\">\\n<span >\\n下一篇：\\n</span>\\n<a href=\\\"${global.url}${next.link}\\\"\\n>\\n${next.title}\\n</a>\\n</div> </div> </div>\\n        <#include \\\"footer.htm\\\"/>\\n    </div>\\n</body>\\n</html>\\n\\n<script>\\nvar app = new Vue({\\n    el: \'#app\',\\n    watch:{\\n    },\\n    data: {\\n    },\\n    methods: {\\n       switchShow:function(arr){\\n       var that = this\\n           arr.forEach(function(x){\\n              let e = that.$el.querySelector(\\\"#key_\\\"+x)\\n               if(e){\\n                   e.style.display=e.style.display==\'none\'?\'flex\':\'none\'\\n               }\\n           })\\n       },\\n    },\\n    created(){\\n    }\\n})\\n</script>\\n\\n<style>\\n    body {\\n        background-color:#f5f5f5;\\n        box-sizing:border-box;\\n        font-family:-apple-system, BlinkMacSys', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/template/writeFileContent.do', 'POST', 'net.mingsoft.basic.action.TemplateAction.writeFileContent()', '127.0.0.1', '写入模版文件内容', 0, NULL, NULL, '2020-11-22 18:37:14', NULL);
INSERT INTO `log` VALUES (29, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:26:40', NULL);
INSERT INTO `log` VALUES (30, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:30:24', NULL);
INSERT INTO `log` VALUES (31, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:31:10', NULL);
INSERT INTO `log` VALUES (32, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:31:18', NULL);
INSERT INTO `log` VALUES (33, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:32:01', NULL);
INSERT INTO `log` VALUES (34, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:32:04', NULL);
INSERT INTO `log` VALUES (35, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:32:38', NULL);
INSERT INTO `log` VALUES (36, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:32:57', NULL);
INSERT INTO `log` VALUES (37, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-12-04\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-12-03 21:33:06', NULL);
INSERT INTO `log` VALUES (38, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:33:10', NULL);
INSERT INTO `log` VALUES (39, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:33:37', NULL);
INSERT INTO `log` VALUES (40, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:33:43', NULL);
INSERT INTO `log` VALUES (41, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:34:00', NULL);
INSERT INTO `log` VALUES (42, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:34:13', NULL);
INSERT INTO `log` VALUES (43, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:34:17', NULL);
INSERT INTO `log` VALUES (44, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:36:53', NULL);
INSERT INTO `log` VALUES (45, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:37:10', NULL);
INSERT INTO `log` VALUES (46, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:42:36', NULL);
INSERT INTO `log` VALUES (47, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:43:32', NULL);
INSERT INTO `log` VALUES (48, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:45:14', NULL);
INSERT INTO `log` VALUES (49, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:45:14', NULL);
INSERT INTO `log` VALUES (50, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:48:36', NULL);
INSERT INTO `log` VALUES (51, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:48:48', NULL);
INSERT INTO `log` VALUES (52, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:49:05', NULL);
INSERT INTO `log` VALUES (53, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:49:13', NULL);
INSERT INTO `log` VALUES (54, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:49:43', NULL);
INSERT INTO `log` VALUES (55, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 21:49:44', NULL);
INSERT INTO `log` VALUES (56, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 22:05:42', NULL);
INSERT INTO `log` VALUES (57, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 22:05:48', NULL);
INSERT INTO `log` VALUES (58, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-03 22:06:34', NULL);
INSERT INTO `log` VALUES (59, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 00:54:40', NULL);
INSERT INTO `log` VALUES (60, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 00:56:54', NULL);
INSERT INTO `log` VALUES (61, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:00:37', NULL);
INSERT INTO `log` VALUES (62, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:00:51', NULL);
INSERT INTO `log` VALUES (63, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:00:51', NULL);
INSERT INTO `log` VALUES (64, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:02:42', NULL);
INSERT INTO `log` VALUES (65, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:03:24', NULL);
INSERT INTO `log` VALUES (66, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:03:54', NULL);
INSERT INTO `log` VALUES (67, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:06:15', NULL);
INSERT INTO `log` VALUES (68, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:07:24', NULL);
INSERT INTO `log` VALUES (69, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:07:25', NULL);
INSERT INTO `log` VALUES (70, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:07:28', NULL);
INSERT INTO `log` VALUES (71, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:08:11', NULL);
INSERT INTO `log` VALUES (72, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:08:12', NULL);
INSERT INTO `log` VALUES (73, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:13:36', NULL);
INSERT INTO `log` VALUES (74, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 01:16:25', NULL);
INSERT INTO `log` VALUES (75, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:22:59', NULL);
INSERT INTO `log` VALUES (76, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:23:50', NULL);
INSERT INTO `log` VALUES (77, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:24:27', NULL);
INSERT INTO `log` VALUES (78, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:25:22', NULL);
INSERT INTO `log` VALUES (79, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:25:49', NULL);
INSERT INTO `log` VALUES (80, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:26:14', NULL);
INSERT INTO `log` VALUES (81, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:26:35', NULL);
INSERT INTO `log` VALUES (82, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:26:44', NULL);
INSERT INTO `log` VALUES (83, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:26:53', NULL);
INSERT INTO `log` VALUES (84, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:27:32', NULL);
INSERT INTO `log` VALUES (85, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:27:44', NULL);
INSERT INTO `log` VALUES (86, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:27:53', NULL);
INSERT INTO `log` VALUES (87, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:28:01', NULL);
INSERT INTO `log` VALUES (88, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:28:07', NULL);
INSERT INTO `log` VALUES (89, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:28:39', NULL);
INSERT INTO `log` VALUES (90, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:29:03', NULL);
INSERT INTO `log` VALUES (91, NULL, 'null', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'error', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:29:35', NULL);
INSERT INTO `log` VALUES (92, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:30:01', NULL);
INSERT INTO `log` VALUES (93, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"id\":\"1329256979346038786\"\n	}\n}', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-11-20 00:55:35\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1329256979346038786\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"57\"],\n	\"updateDate\":[\"2020-11-20 01:53:44\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"首页\"],\n	\"categoryPinyin\":[\"shouye\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"3\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"\"],\n	\"categoryUrl\":[\"\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"n\"],\n	\"categoryPath\":[\"/shouye\"],\n	\"categoryParentIds\":[\"\"],\n	\"leaf\":[\"true\"],\n	\"topId\":[\"0\"],\n	\"flag\":[\"d\"],\n	\"parentids\":[\"\"],\n	\"typetitle\":[\"首页\"],\n	\"typelink\":[\"\"],\n	\"typekeyword\":[\"\"],\n	\"typeurl\":[\"\"],\n	\"typedescrip\":[\"\"],\n	\"typeid\":[\"1329256979346038786\"],\n	\"typelitpic\":[\"[]\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/category/update.do', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', '127.0.0.1', '更新分类', 0, NULL, NULL, '2020-12-04 19:36:56', NULL);
INSERT INTO `log` VALUES (94, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:37:14', NULL);
INSERT INTO `log` VALUES (95, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-12-05\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-12-04 19:39:35', NULL);
INSERT INTO `log` VALUES (96, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-12-04 19:39:38', NULL);
INSERT INTO `log` VALUES (97, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:40:04', NULL);
INSERT INTO `log` VALUES (98, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-12-05\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-12-04 19:40:06', NULL);
INSERT INTO `log` VALUES (99, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:51:20', NULL);
INSERT INTO `log` VALUES (100, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:56:42', NULL);
INSERT INTO `log` VALUES (101, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"id\":\"1329257213283344385\"\n	}\n}', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-11-20 00:56:31\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1329257213283344385\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"57\"],\n	\"updateDate\":[\"2020-11-20 08:29:38\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"公司产品\"],\n	\"categoryPinyin\":[\"product\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"product.htm\"],\n	\"categoryUrl\":[\"product-detail1.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"n\"],\n	\"categoryPath\":[\"/product\"],\n	\"categoryParentIds\":[\"\"],\n	\"leaf\":[\"false\"],\n	\"topId\":[\"0\"],\n	\"flag\":[\"d\"],\n	\"parentids\":[\"\"],\n	\"typetitle\":[\"公司产品\"],\n	\"typelink\":[\"/product/index.html\"],\n	\"typekeyword\":[\"\"],\n	\"typeurl\":[\"\"],\n	\"typedescrip\":[\"\"],\n	\"typeid\":[\"1329257213283344385\"],\n	\"typelitpic\":[\"[]\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/category/update.do', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', '127.0.0.1', '更新分类', 0, NULL, NULL, '2020-12-04 19:58:02', NULL);
INSERT INTO `log` VALUES (102, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"id\":\"1329257757913718785\"\n	}\n}', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-11-20 00:58:41\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1329257757913718785\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"57\"],\n	\"updateDate\":[\"2020-11-20 08:31:08\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"开源产品\"],\n	\"categoryPinyin\":[\"kycp\"],\n	\"categoryId\":[\"1329257213283344385\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"product.htm\"],\n	\"categoryUrl\":[\"product-detail1.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"n\"],\n	\"categoryPath\":[\"/product/kycp\"],\n	\"categoryParentIds\":[\"1329257213283344385\"],\n	\"leaf\":[\"true\"],\n	\"topId\":[\"1329257213283344385\"],\n	\"flag\":[\"\"],\n	\"parentids\":[\"1329257213283344385\"],\n	\"typetitle\":[\"开源产品\"],\n	\"typelink\":[\"/product/kycp/index.html\"],\n	\"typekeyword\":[\"\"],\n	\"typeurl\":[\"\"],\n	\"typedescrip\":[\"\"],\n	\"typeid\":[\"1329257757913718785\"],\n	\"typelitpic\":[\"[]\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/category/update.do', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', '127.0.0.1', '更新分类', 0, NULL, NULL, '2020-12-04 19:58:11', NULL);
INSERT INTO `log` VALUES (103, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:58:42', NULL);
INSERT INTO `log` VALUES (104, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-12-04 19:59:01', NULL);
INSERT INTO `log` VALUES (105, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"createBy\":[\"0\"],\n	\"createDate\":[\"\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"0\"],\n	\"updateDate\":[\"\"],\n	\"order\":[\"\"],\n	\"appName\":[\"MCMS-OPEN\"],\n	\"appDescription\":[\"铭飞MCMS\"],\n	\"appLogo\":[\"[{\\\"path\\\":\\\"/upload/1/appLogo/1578375538540.jpg\\\",\\\"url\\\":\\\"/upload/1/appLogo/1578375538540.jpg\\\",\\\"uid\\\":1604106086351,\\\"status\\\":\\\"success\\\"}]\"],\n	\"appStyle\":[\"default\"],\n	\"appKeyword\":[\"铭飞MCMS\"],\n	\"appCopyright\":[\"版权所有 ©铭飞科技有限公司2012-2019 保留一切权利。\"],\n	\"appDir\":[\"a\"],\n	\"appUrl\":[\"http://localhost:8080\"],\n	\"appDatetime\":[\"\"],\n	\"appPayDate\":[\"2019-11-17 18:00:00\"],\n	\"appPay\":[\"\"],\n	\"appId\":[\"1\"],\n	\"appHostUrl\":[\"http://localhost:8080\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/app/update.do', 'POST', 'net.mingsoft.basic.action.AppAction.update()', '127.0.0.1', '更新站点信息', 0, NULL, NULL, '2020-12-04 19:59:25', NULL);
INSERT INTO `log` VALUES (106, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 19:59:31', NULL);
INSERT INTO `log` VALUES (107, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-12-04 19:59:33', NULL);
INSERT INTO `log` VALUES (108, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-12-01\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-12-04 19:59:33', NULL);
INSERT INTO `log` VALUES (109, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"id\":\"1329257213283344385\"\n	}\n}', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-11-20 00:56:31\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1329257213283344385\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"57\"],\n	\"updateDate\":[\"2020-12-05 09:58:01\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"公司产品\"],\n	\"categoryPinyin\":[\"product\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"product-list.htm\"],\n	\"categoryUrl\":[\"product-detail.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"n\"],\n	\"categoryPath\":[\"/product\"],\n	\"categoryParentIds\":[\"\"],\n	\"leaf\":[\"false\"],\n	\"topId\":[\"0\"],\n	\"flag\":[\"n\"],\n	\"parentids\":[\"\"],\n	\"typetitle\":[\"公司产品\"],\n	\"typelink\":[\"/product/index.html\"],\n	\"typekeyword\":[\"\"],\n	\"typeurl\":[\"\"],\n	\"typedescrip\":[\"\"],\n	\"typeid\":[\"1329257213283344385\"],\n	\"typelitpic\":[\"[]\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/category/update.do', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', '127.0.0.1', '更新分类', 0, NULL, NULL, '2020-12-04 20:00:15', NULL);
INSERT INTO `log` VALUES (110, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-12-01\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-12-04 20:00:18', NULL);
INSERT INTO `log` VALUES (111, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-12-04 20:00:19', NULL);
INSERT INTO `log` VALUES (112, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 20:28:29', NULL);
INSERT INTO `log` VALUES (113, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-11-02\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-12-04 20:28:40', NULL);
INSERT INTO `log` VALUES (114, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-12-04 20:28:45', NULL);
INSERT INTO `log` VALUES (115, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"url\":[\"index.htm\"],\n	\"position\":[\"index\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate//generateIndex.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateIndex()', '127.0.0.1', '生成主页', 0, NULL, NULL, '2020-12-04 21:50:27', NULL);
INSERT INTO `log` VALUES (116, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{\n	\"dateTime\":[\"2020-12-05\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/generateArticle.do', 'POST', 'net.mingsoft.cms.action.GeneraterAction.generateArticle()', '127.0.0.1', '生成文章', 0, NULL, NULL, '2020-12-04 21:50:31', NULL);
INSERT INTO `log` VALUES (117, NULL, '{\n	\"result\":true,\n	\"code\":200\n}', '{}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/generate/0/genernateColumn.do', 'GET', 'net.mingsoft.cms.action.GeneraterAction.genernateColumn()', '127.0.0.1', '生成栏目', 0, NULL, NULL, '2020-12-04 21:50:35', NULL);
INSERT INTO `log` VALUES (118, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"id\":\"1329257757913718785\"\n	}\n}', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-11-20 00:58:41\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1329257757913718785\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"57\"],\n	\"updateDate\":[\"2020-12-05 09:58:11\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"开源产品\"],\n	\"categoryPinyin\":[\"kycp\"],\n	\"categoryId\":[\"1329257213283344385\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"product.htm\"],\n	\"categoryUrl\":[\"product-detail1.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"\"],\n	\"categoryPath\":[\"/product/kycp\"],\n	\"categoryParentIds\":[\"1329257213283344385\"],\n	\"leaf\":[\"true\"],\n	\"topId\":[\"1329257213283344385\"],\n	\"flag\":[\"n\"],\n	\"parentids\":[\"1329257213283344385\"],\n	\"typetitle\":[\"开源产品\"],\n	\"typelink\":[\"/product/kycp/index.html\"],\n	\"typekeyword\":[\"\"],\n	\"typeurl\":[\"\"],\n	\"typedescrip\":[\"\"],\n	\"typeid\":[\"1329257757913718785\"],\n	\"typelitpic\":[\"[]\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/category/update.do', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', '127.0.0.1', '更新分类', 0, NULL, NULL, '2020-12-04 21:50:49', NULL);
INSERT INTO `log` VALUES (119, NULL, '{\n	\"result\":true,\n	\"code\":200,\n	\"data\":{\n		\"id\":\"1329257282518720513\"\n	}\n}', '{\n	\"createBy\":[\"57\"],\n	\"createDate\":[\"2020-11-20 00:56:47\"],\n	\"del\":[\"0\"],\n	\"id\":[\"1329257282518720513\"],\n	\"remarks\":[\"\"],\n	\"updateBy\":[\"57\"],\n	\"updateDate\":[\"2020-11-20 08:31:51\"],\n	\"order\":[\"\"],\n	\"categoryTitle\":[\"新闻动态\"],\n	\"categoryPinyin\":[\"news\"],\n	\"categoryId\":[\"\"],\n	\"categoryType\":[\"1\"],\n	\"categorySort\":[\"0\"],\n	\"categoryListUrl\":[\"news-list.htm\"],\n	\"categoryUrl\":[\"news-detail.htm\"],\n	\"categoryKeyword\":[\"\"],\n	\"categoryDescrip\":[\"\"],\n	\"categoryImg\":[\"[]\"],\n	\"categoryDiyUrl\":[\"\"],\n	\"mdiyModelId\":[\"\"],\n	\"categoryDatetime\":[\"\"],\n	\"dictId\":[\"\"],\n	\"categoryFlag\":[\"n\"],\n	\"categoryPath\":[\"/news\"],\n	\"categoryParentIds\":[\"\"],\n	\"leaf\":[\"false\"],\n	\"topId\":[\"0\"],\n	\"flag\":[\"d\"],\n	\"parentids\":[\"\"],\n	\"typetitle\":[\"新闻动态\"],\n	\"typelink\":[\"/news/index.html\"],\n	\"typekeyword\":[\"\"],\n	\"typeurl\":[\"\"],\n	\"typedescrip\":[\"\"],\n	\"typeid\":[\"1329257282518720513\"],\n	\"typelitpic\":[\"[]\"]\n}', '内网IP', 'msopen', 'manage', 'update', 'success', '/ms/cms/category/update.do', 'POST', 'net.mingsoft.cms.action.CategoryAction.update()', '127.0.0.1', '更新分类', 0, NULL, NULL, '2020-12-05 02:24:39', NULL);
COMMIT;

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `role_id` int(11) DEFAULT NULL COMMENT '角色编号',
  `people_id` int(11) DEFAULT '0' COMMENT '用户编号即商家编号',
  `manager_admin` varchar(255) DEFAULT NULL COMMENT '管理员标识，超级管理员：super，子管理员：open',
  `manager_name` varchar(15) DEFAULT NULL COMMENT '管理员用户名',
  `manager_nickname` varchar(15) DEFAULT NULL COMMENT '管理员昵称',
  `manager_password` varchar(45) DEFAULT NULL COMMENT '管理员密码',
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `create_by` int(11) DEFAULT NULL,
  `del` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_manager_role_id` (`role_id`) USING BTREE,
  CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of manager
-- ----------------------------
BEGIN;
INSERT INTO `manager` VALUES (57, 48, 0, 'super', 'msopen', 'msopen', '9d8622060de5f24937b60585c3f4d66b', NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for mdiy_dict
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_dict`;
CREATE TABLE `mdiy_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `dict_value` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `dict_label` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `dict_type` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '类型',
  `dict_description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `is_child` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '扩展业务标记',
  `dict_enable` varchar(11) COLLATE utf8_bin DEFAULT '1' COMMENT '启用状态',
  `dict_remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `dict_sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序（升序）',
  `create_by` int(64) DEFAULT '0' COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` int(64) DEFAULT '0' COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `del` int(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `inx_dict_value` (`dict_value`) USING BTREE,
  KEY `inx_dict_label` (`dict_label`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=645 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='字典表';

-- ----------------------------
-- Records of mdiy_dict
-- ----------------------------
BEGIN;
INSERT INTO `mdiy_dict` VALUES (1, 'f', '幻灯', '文章属性', NULL, NULL, '1', NULL, 3, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (2, 'p', '图片', '文章属性', NULL, NULL, '1', NULL, 1, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (3, 'c', '推荐', '文章属性', NULL, NULL, '1', NULL, 4, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (4, 'h', '头条', '文章属性', NULL, NULL, '1', NULL, 2, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (621, 'cms', '文章', '自定义模型类型', NULL, '0', '1', NULL, 0, 0, NULL, 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (642, 'cms', '文章', '自定义页面类型', NULL, NULL, '1', NULL, 0, 0, '2019-12-29 18:32:46', 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (643, 'c', '推荐', '栏目属性', NULL, NULL, '1', NULL, 0, 0, '2020-01-10 14:38:26', 0, NULL, 3);
INSERT INTO `mdiy_dict` VALUES (644, 'n', '导航', '栏目属性', NULL, NULL, '1', NULL, 0, 0, '2020-01-10 14:38:26', 0, NULL, 3);
COMMIT;

-- ----------------------------
-- Table structure for mdiy_model
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_model`;
CREATE TABLE `mdiy_model` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `model_json` text COMMENT 'json',
  `model_table_name` varchar(255) DEFAULT NULL COMMENT '模型表名',
  `model_name` varchar(30) DEFAULT NULL COMMENT '模型名称',
  `model_type` varchar(255) DEFAULT NULL COMMENT '自定义模型类型，自定义表单不用该字段',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` int(11) DEFAULT NULL COMMENT '修改人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  `model_field` text COMMENT '模型字段',
  `model_custom_type` varchar(255) DEFAULT NULL COMMENT '类型，自定义表单：post，自定义模型：model',
  `del` int(1) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='自定义模型';

-- ----------------------------
-- Records of mdiy_model
-- ----------------------------
BEGIN;
INSERT INTO `mdiy_model` VALUES (41, '{\"html\":\"<template id=\\\"custom-model\\\">\\r\\n    <el-form ref=\\\"form\\\" :model=\\\"form\\\" :rules=\\\"rules\\\" label-width=\\\"120px\\\" label-position=\\\"right\\\" size=\\\"small\\\">\\r\\n            <el-form-item  label=\\\"姓名\\\" prop=\\\"name\\\"\\r\\n>\\r\\n                <el-input v-model=\\\"form.name\\\"\\r\\n                          :disabled=\\\"false\\\"\\r\\n                          :style=\\\"{width:  \'100%\'}\\\"\\r\\n                          :clearable=\\\"true\\\"\\r\\n                          placeholder=\\\"请输入姓名\\\">\\r\\n                </el-input>\\r\\n            </el-form-item>\\r\\n            <el-form-item  label=\\\"手机\\\" prop=\\\"phone\\\"\\r\\n>\\r\\n                <el-input v-model=\\\"form.phone\\\"\\r\\n                          :disabled=\\\"false\\\"\\r\\n                          :style=\\\"{width:  \'100%\'}\\\"\\r\\n                          :clearable=\\\"true\\\"\\r\\n                          placeholder=\\\"请输入手机\\\">\\r\\n                </el-input>\\r\\n            </el-form-item>\\r\\n            <el-form-item  label=\\\"留言\\\" prop=\\\"words\\\"\\r\\n>\\r\\n                <el-input\\r\\n                        type=\\\"textarea\\\" :rows=\\\"5\\\"\\r\\n                        :disabled=\\\"false\\\"\\r\\n\\r\\n                        v-model=\\\"form.words\\\"\\r\\n                        :style=\\\"{width: \'100%\'}\\\"\\r\\n                        placeholder=\\\"请输入留言\\\">\\r\\n                </el-input>\\r\\n            </el-form-item>\\r\\n    </el-form>\\r\\n</template>\\r\\n\",\"script\":\"       var custom_model = Vue.component(\\\"custom-model\\\",{\\r\\n            el: \'#custom-model\',\\r\\n            data() {\\r\\n                return {\\r\\n                    modelId:0,\\r\\n                    //表单数据\\r\\n                    form: {\\r\\n                        linkId:0,\\r\\n                    // 姓名\\r\\n                    name:\'\',\\r\\n                    // 手机\\r\\n                    phone:\'\',\\r\\n                    // 留言\\r\\n                    words:\'\',\\r\\n                    },\\r\\n                    rules:{\\r\\n                    },\\r\\n\\r\\n                }\\r\\n            },\\r\\n            watch:{\\r\\n            },\\r\\n            computed:{\\r\\n            },\\r\\n            methods: {\\r\\n                validate(){\\r\\n                    var b = false\\r\\n                    this.$refs.form.validate((valid) => {\\r\\n                        b = valid;\\r\\n                    });\\r\\n                    return b;\\r\\n                },\\r\\n                save() {\\r\\n                    var that = this;\\r\\n                    var success = false;\\r\\n                    var url = ms.manager + \\\"/mdiy/model/data/save.do\\\"\\r\\n                    if (that.form.id > 0) {\\r\\n                    url = ms.manager + \\\"/mdiy/model/data/update.do\\\";\\r\\n                    }\\r\\n                    this.$refs.form.validate((valid) => {\\r\\n                        if (valid) {\\r\\n                            var data = JSON.parse(JSON.stringify(that.form));\\r\\n                            data.modelId = that.modelId;\\r\\n                            ms.http.post(url, data).then(function (res) {\\r\\n                                if (res.data.id > 0) {\\r\\n                                    success = true;\\r\\n                                }\\r\\n                            });\\r\\n                        } else {\\r\\n                            return false;\\r\\n                        }\\r\\n                    })\\r\\n                    return success;\\r\\n                },\\r\\n                //获取当前意见反馈\\r\\n                get(id) {\\r\\n                    var that = this;\\r\\n                    ms.http.get(ms.manager + \\\"/mdiy/model/data.do\\\", {modelId:this.modelId,linkId:id}).then(function (res) {\\r\\n                            if(res.result&&res.data){\\r\\n                            that.form = res.data;\\r\\n                        }\\r\\n                    }).catch(function (err) {\\r\\n                        console.log(err);\\r\\n                    });\\r\\n                },\\r\\n            },\\r\\n            created() {\\r\\n                this.get(this.form.linkId);\\r\\n            }\\r\\n        });\\r\\n\\r\\n\"}', 'mdiy_post_feedback', '意见反馈', NULL, NULL, 0, NULL, 0, '[\r\n{\r\n            \"model\":\"name\",\r\n            \"key\":\"name\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"姓名\",\r\n            \"type\":\"input\"\r\n            }\r\n            ,{\r\n            \"model\":\"phone\",\r\n            \"key\":\"phone\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"手机\",\r\n            \"type\":\"input\"\r\n            }\r\n            ,{\r\n            \"model\":\"words\",\r\n            \"key\":\"words\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"留言\",\r\n            \"type\":\"textarea\"\r\n            }\r\n]', 'post', 0);
INSERT INTO `mdiy_model` VALUES (45, '{\"html\":\"<template id=\\\"custom-model\\\">\\r\\n    <el-form ref=\\\"form\\\" :model=\\\"form\\\" :rules=\\\"rules\\\" label-width=\\\"120px\\\" label-position=\\\"right\\\" size=\\\"small\\\">\\r\\n\\r\\n        <el-form-item  label=\\\"评分\\\" prop=\\\"rate\\\">\\r\\n            <el-rate  v-model=\\\"form.rate\\\" :max=\\\"5\\\"  :disabled=\\\"false\\\"\\r\\n                     :allow-half=\\\"false\\\"></el-rate>\\r\\n        </el-form-item>\\r\\n\\r\\n        <el-form-item  label=\\\"内容\\\" prop=\\\"textarea\\\">\\r\\n                <el-input\\r\\n                        type=\\\"textarea\\\" :rows=\\\"5\\\"\\r\\n                        :disabled=\\\"false\\\"\\r\\n                        :readonly=\\\"false\\\"\\r\\n                        v-model=\\\"form.textarea\\\"\\r\\n                        :style=\\\"{width: \'100%\'}\\\"\\r\\n                        placeholder=\\\"请输入内容\\\">\\r\\n                </el-input>\\r\\n        </el-form-item>\\r\\n\\r\\n        <el-form-item  label=\\\"联系方式\\\" prop=\\\"contactInformation\\\">\\r\\n                <el-input\\r\\n                        v-model=\\\"form.contactInformation\\\"\\r\\n                        :disabled=\\\"false\\\"\\r\\n                          :readonly=\\\"false\\\"\\r\\n                          :style=\\\"{width:  \'100%\'}\\\"\\r\\n                          :clearable=\\\"true\\\"\\r\\n                        placeholder=\\\"请输入联系方式\\\">\\r\\n                </el-input>\\r\\n        </el-form-item>\\r\\n\\r\\n\\r\\n\\r\\n\\r\\n\\r\\n\\r\\n    </el-form>\\r\\n</template>\\r\\n\",\"script\":\"       var custom_model = Vue.component(\\\"custom-model\\\",{\\r\\n            el: \'#custom-model\',\\r\\n            data:function() {\\r\\n                return {\\r\\n                    modelId:0,\\r\\n                    //表单数据\\r\\n                    form: {\\r\\n                        linkId:0,\\r\\n                    // 评分\\r\\n                    rate:0,\\r\\n                    // 内容\\r\\n                    textarea:\'\',\\r\\n                    // 联系方式\\r\\n                    contactInformation:\'\',\\r\\n                    },\\r\\n                    rules:{\\r\\n                // 联系方式\\r\\n                contactInformation: [{\\\"pattern\\\":/^([0-9]{3,4}-)?[0-9]{7,8}$|^\\\\d{3,4}-\\\\d{3,4}-\\\\d{3,4}$|^1[0-9]{10}$/,\\\"message\\\":\\\"联系方式格式不匹配\\\"},{\\\"min\\\":0,\\\"max\\\":100,\\\"message\\\":\\\"联系方式长度必须为0-100\\\"}],\\r\\n                    },\\r\\n\\r\\n                }\\r\\n            },\\r\\n            watch:{\\r\\n            },\\r\\n            computed:{\\r\\n            },\\r\\n            methods: {\\r\\n                validate:function(){\\r\\n                    var b = false\\r\\n                    this.$refs.form.validate((valid) => {\\r\\n                        b = valid;\\r\\n                    });\\r\\n                    return b;\\r\\n                },\\r\\n                save:function() {\\r\\n                    var that = this;\\r\\n                    var success = false;\\r\\n                    var url = ms.manager + \\\"/mdiy/model/data/save.do\\\"\\r\\n                    if (that.form.id > 0) {\\r\\n                    url = ms.manager + \\\"/mdiy/model/data/update.do\\\";\\r\\n                    }\\r\\n                    this.$refs.form.validate(function(valid) {\\r\\n                        if (valid) {\\r\\n                            var data = JSON.parse(JSON.stringify(that.form));\\r\\n                            data.modelId = that.modelId;\\r\\n                            ms.http.post(url, data).then(function (res) {\\r\\n                                if (res.data.id > 0) {\\r\\n                                    success = true;\\r\\n                                }\\r\\n                            });\\r\\n                        } else {\\r\\n                            return false;\\r\\n                        }\\r\\n                    })\\r\\n                    return success;\\r\\n                },\\r\\n                //获取当前调查反馈\\r\\n                get:function(id) {\\r\\n                    var that = this;\\r\\n                    ms.http.get(ms.manager + \\\"/mdiy/model/data.do\\\", {modelId:this.modelId,linkId:id}).then(function (res) {\\r\\n                            if(res.result&&res.data){\\r\\n                            that.form = res.data;\\r\\n                        }\\r\\n                    }).catch(function (err) {\\r\\n                        console.log(err);\\r\\n                    });\\r\\n                },\\r\\n            },\\r\\n            created:function() {\\r\\n                this.get(this.form.linkId);\\r\\n            }\\r\\n        });\\r\\n\\r\\n\"}', 'mdiy_model_xietestcomment', '评论模型', 'cms', NULL, 0, NULL, 0, '[\r\n{\r\n            \"model\":\"rate\",\r\n            \"key\":\"rate\",\r\n            \"javaType\":\"Integer\",\r\n            \"jdbcType\":\"INT\",\r\n            \"name\":\"评分\",\r\n            \"type\":\"rate\"\r\n            }\r\n            ,{\r\n            \"model\":\"textarea\",\r\n            \"key\":\"textarea\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"内容\",\r\n            \"type\":\"textarea\"\r\n            }\r\n            ,{\r\n            \"model\":\"contactInformation\",\r\n            \"key\":\"contact_information\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"联系方式\",\r\n            \"type\":\"input\"\r\n            }\r\n]', 'model', 0);
INSERT INTO `mdiy_model` VALUES (47, '{\"html\":\"<template id=\\\"custom-model\\\">\\r\\n    <el-form ref=\\\"form\\\" :model=\\\"form\\\" :rules=\\\"rules\\\" label-width=\\\"120px\\\" label-position=\\\"right\\\" size=\\\"small\\\">\\r\\n\\r\\n        <el-form-item  label=\\\"单行文本\\\" prop=\\\"input160574680900056697\\\">\\r\\n                <el-input\\r\\n                        v-model=\\\"form.input160574680900056697\\\"\\r\\n                        :disabled=\\\"false\\\"\\r\\n                          :readonly=\\\"false\\\"\\r\\n                          :style=\\\"{width:  \'100%\'}\\\"\\r\\n                          :clearable=\\\"true\\\"\\r\\n                        placeholder=\\\"请输入内容\\\">\\r\\n                </el-input>\\r\\n        </el-form-item>\\r\\n\\r\\n        <el-form-item  label=\\\"多行文本\\\" prop=\\\"textarea160574681000051652\\\">\\r\\n                <el-input\\r\\n                        type=\\\"textarea\\\" :rows=\\\"5\\\"\\r\\n                        :disabled=\\\"false\\\"\\r\\n                        :readonly=\\\"false\\\"\\r\\n                        v-model=\\\"form.textarea160574681000051652\\\"\\r\\n                        :style=\\\"{width: \'100%\'}\\\"\\r\\n                        placeholder=\\\"请输入内容\\\">\\r\\n                </el-input>\\r\\n        </el-form-item>\\r\\n                <el-row\\r\\n                        gutter=\\\"0\\\"\\r\\n                        justify=\\\"start\\\" align=\\\"top\\\">\\r\\n                        <el-col span=\\\"12\\\">\\r\\n\\r\\n        <el-form-item  label=\\\"下拉选择框\\\" prop=\\\"select160574681900069237\\\">\\r\\n                    <el-select  v-model=\\\"form.select160574681900069237\\\"\\r\\n                               :style=\\\"{width: \'100%\'}\\\"\\r\\n                               :filterable=\\\"false\\\"\\r\\n                               :disabled=\\\"false\\\"\\r\\n                               :multiple=\\\"false\\\" :clearable=\\\"true\\\"\\r\\n                            placeholder=\\\"请输入内容\\\">\\r\\n                        <el-option v-for=\'item in select160574681900069237Options\' :key=\\\"item.value\\\" :value=\\\"item.value\\\"\\r\\n                                   :label=\\\"item.label\\\"></el-option>\\r\\n                    </el-select>\\r\\n        </el-form-item>\\r\\n                        </el-col>\\r\\n                        <el-col span=\\\"12\\\">\\r\\n\\r\\n        <el-form-item  label=\\\"密码框\\\" prop=\\\"password160574681200012096\\\">\\r\\n                <el-input type=\\\"password\\\"\\r\\n                          :show-password=\\\"true\\\"\\r\\n                          :clearable=\\\"true\\\" autocomplete=\\\"off\\\"\\r\\n                           v-model=\\\"form.password160574681200012096\\\"  :style=\\\"{width:\'100%\'}\\\"\\r\\n                          :disabled=\\\"false\\\" placeholder=\\\"请输入内容\\\"></el-input>\\r\\n        </el-form-item>\\r\\n                        </el-col>\\r\\n                </el-row>\\r\\n\\r\\n\\r\\n\\r\\n\\r\\n\\r\\n\\r\\n    </el-form>\\r\\n</template>\\r\\n\",\"script\":\"       var custom_model = Vue.component(\\\"custom-model\\\",{\\r\\n            el: \'#custom-model\',\\r\\n            data:function() {\\r\\n                return {\\r\\n                    modelId:0,\\r\\n                    //表单数据\\r\\n                    form: {\\r\\n                        linkId:0,\\r\\n                    // 单行文本\\r\\n                    input160574680900056697:\'\',\\r\\n                    // 多行文本\\r\\n                    textarea160574681000051652:\'\',\\r\\n                    // 下拉选择框\\r\\n                    select160574681900069237:\'\',\\r\\n                    // 密码框\\r\\n                    password160574681200012096:\'\',\\r\\n                    },\\r\\n                select160574681900069237Options:[{\\\"value\\\":\\\"下拉框1\\\",\\\"label\\\":\\\"下拉框1\\\"},{\\\"value\\\":\\\"下拉框2\\\",\\\"label\\\":\\\"下拉框2\\\"},{\\\"value\\\":\\\"下拉框3\\\",\\\"label\\\":\\\"下拉框3\\\"}],\\r\\n                    rules:{\\r\\n                // 单行文本\\r\\n                input160574680900056697: [{\\\"min\\\":0,\\\"max\\\":20,\\\"message\\\":\\\"单行文本长度必须为0-20\\\"}],\\r\\n                    },\\r\\n\\r\\n                }\\r\\n            },\\r\\n            watch:{\\r\\n            },\\r\\n            computed:{\\r\\n            },\\r\\n            methods: {\\r\\n                validate:function(){\\r\\n                    var b = false\\r\\n                    this.$refs.form.validate((valid) => {\\r\\n                        b = valid;\\r\\n                    });\\r\\n                    return b;\\r\\n                },\\r\\n                save:function() {\\r\\n                    var that = this;\\r\\n                    var success = false;\\r\\n                    var url = ms.manager + \\\"/mdiy/model/data/save.do\\\"\\r\\n                    if (that.form.id > 0) {\\r\\n                    url = ms.manager + \\\"/mdiy/model/data/update.do\\\";\\r\\n                    }\\r\\n                    this.$refs.form.validate(function(valid) {\\r\\n                        if (valid) {\\r\\n                            var data = JSON.parse(JSON.stringify(that.form));\\r\\n                            data.modelId = that.modelId;\\r\\n                            ms.http.post(url, data).then(function (res) {\\r\\n                                if (res.data.id > 0) {\\r\\n                                    success = true;\\r\\n                                }\\r\\n                            });\\r\\n                        } else {\\r\\n                            return false;\\r\\n                        }\\r\\n                    })\\r\\n                    return success;\\r\\n                },\\r\\n                //获取当前test\\r\\n                get:function(id) {\\r\\n                    var that = this;\\r\\n                    ms.http.get(ms.manager + \\\"/mdiy/model/data.do\\\", {modelId:this.modelId,linkId:id}).then(function (res) {\\r\\n                            if(res.result&&res.data){\\r\\n                            that.form = res.data;\\r\\n                        }\\r\\n                    }).catch(function (err) {\\r\\n                        console.log(err);\\r\\n                    });\\r\\n                },\\r\\n            },\\r\\n            created:function() {\\r\\n                this.get(this.form.linkId);\\r\\n            }\\r\\n        });\\r\\n\\r\\n\"}', 'mdiy_model_test', 'test', 'cms', NULL, 0, NULL, 0, '[\r\n{\r\n            \"model\":\"input160574680900056697\",\r\n            \"key\":\"input_1605746809000_56697\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"单行文本\",\r\n            \"type\":\"input\"\r\n            }\r\n            ,{\r\n            \"model\":\"textarea160574681000051652\",\r\n            \"key\":\"textarea_1605746810000_51652\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"多行文本\",\r\n            \"type\":\"textarea\"\r\n            }\r\n            ,{\r\n            \"model\":\"select160574681900069237\",\r\n            \"key\":\"select_1605746819000_69237\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"下拉选择框\",\r\n            \"type\":\"select\"\r\n            }\r\n            ,{\r\n            \"model\":\"password160574681200012096\",\r\n            \"key\":\"password_1605746812000_12096\",\r\n            \"javaType\":\"String\",\r\n            \"jdbcType\":\"VARCHAR\",\r\n            \"name\":\"密码框\",\r\n            \"type\":\"password\"\r\n            }\r\n]', 'model', 0);
COMMIT;

-- ----------------------------
-- Table structure for mdiy_model_test
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_model_test`;
CREATE TABLE `mdiy_model_test` (
  `input_1605746809000_56697` varchar(255) DEFAULT NULL COMMENT '单行文本',
  `textarea_1605746810000_51652` varchar(255) DEFAULT NULL COMMENT '多行文本',
  `select_1605746819000_69237` varchar(255) DEFAULT NULL COMMENT '下拉选择框',
  `password_1605746812000_12096` varchar(255) DEFAULT NULL COMMENT '密码框',
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='test';

-- ----------------------------
-- Table structure for mdiy_model_xietestcomment
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_model_xietestcomment`;
CREATE TABLE `mdiy_model_xietestcomment` (
  `rate` int(11) DEFAULT NULL COMMENT '评分',
  `textarea` varchar(255) DEFAULT NULL COMMENT '内容',
  `contact_information` varchar(255) DEFAULT NULL COMMENT '联系方式',
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='评论模型';

-- ----------------------------
-- Table structure for mdiy_page
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_page`;
CREATE TABLE `mdiy_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `page_model_id` int(11) DEFAULT NULL COMMENT '模块id',
  `page_path` varchar(255) DEFAULT NULL COMMENT '自定义页面绑定模板的路径',
  `page_title` varchar(255) DEFAULT NULL COMMENT '自定义页面标题',
  `page_type` varchar(255) DEFAULT NULL COMMENT '字典分类字段',
  `page_key` varchar(255) DEFAULT NULL COMMENT '自定义页面访问路径',
  `create_date` datetime DEFAULT NULL,
  `create_by` int(11) DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `del` int(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_page_key` (`page_key`) USING BTREE,
  KEY `index_page_model_id` (`page_model_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义页面表';

-- ----------------------------
-- Table structure for mdiy_post_feedback
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_post_feedback`;
CREATE TABLE `mdiy_post_feedback` (
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机',
  `words` varchar(255) DEFAULT NULL COMMENT '留言',
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意见反馈';

-- ----------------------------
-- Table structure for mdiy_tag
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_tag`;
CREATE TABLE `mdiy_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) DEFAULT NULL COMMENT '标签名称',
  `tag_type` varchar(255) DEFAULT NULL COMMENT '标签类型',
  `tag_description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='标签';

-- ----------------------------
-- Records of mdiy_tag
-- ----------------------------
BEGIN;
INSERT INTO `mdiy_tag` VALUES (3, 'arclist', 'list', '文章列表');
INSERT INTO `mdiy_tag` VALUES (4, 'channel', 'list', '通用栏目');
INSERT INTO `mdiy_tag` VALUES (5, 'global', 'single', '全局');
INSERT INTO `mdiy_tag` VALUES (7, 'field', 'single', '文章内容');
INSERT INTO `mdiy_tag` VALUES (8, 'pre', 'single', '文章上一篇');
INSERT INTO `mdiy_tag` VALUES (9, 'page', 'single', '通用分页');
INSERT INTO `mdiy_tag` VALUES (10, 'next', 'single', '文章下一篇');
COMMIT;

-- ----------------------------
-- Table structure for mdiy_tag_sql
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_tag_sql`;
CREATE TABLE `mdiy_tag_sql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL COMMENT '自定义标签编号',
  `tag_sql` text COMMENT '自定义sql支持ftl写法',
  `sort` int(11) DEFAULT NULL COMMENT '排序升序',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_ts_tag_id` (`tag_id`) USING BTREE,
  CONSTRAINT `fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `mdiy_tag` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='标签对应多个sql语句';

-- ----------------------------
-- Records of mdiy_tag_sql
-- ----------------------------
BEGIN;
INSERT INTO `mdiy_tag_sql` VALUES (5, 3, '<#assign _typeid=\'\'/>\n<#assign _typetitle=\'\'/>\n<#assign _size=\'20\'/>\n\n<#if column?? && column.id?? && column.id?number gt 0>\n  <#assign  _typeid=\'${column.id}\'>\n</#if>\n\n<#if typeid??>\n  <#assign  _typeid=\'${typeid}\'>\n</#if>\n\n<#if typetitle??>\n  <#assign  _typetitle=\'${typetitle}\'>\n</#if>\n\n<#if size??>\n  <#assign  _size=\'${size}\'>\n</#if>\n\n<#if orderby?? >\n    <#if orderby==\'date\'> \n      <#assign  _orderby=\'content_datetime\'>\n  <#elseif orderby==\'updatedate\'>\n    <#assign  _orderby=\'content_updatetime\'>\n    <#elseif orderby==\'hit\'> \n      <#assign  _orderby=\'content_hit\'>\n    <#elseif orderby==\'sort\'>\n      <#assign  _orderby=\'content_sort\'>\n    <#else>\n        <#assign  _orderby=\'cms_content.id\'>\n     </#if>\n<#else>\n    <#assign  _orderby=\'cms_content.id\'>\n</#if>\n\nSELECT\n  cms_content.id AS id,\n  content_title AS title,\n  content_title AS fulltitle,\n  content_author AS author,\n  content_source AS source,\n  content_details AS content,\n  category.category_title AS typetitle,\n  category.id AS typeid,\n	category.category_path AS typepath,\n  category.category_img AS typelitpic,\n  category.category_keyword as typekeyword,\n  category.top_id as topId,\n  category.category_parent_ids as parentids,\n\n  <#--列表页动态链接-->\n  <#if isDo?? && isDo>\n    CONCAT(\'/${modelName}/list.do?typeid=\', category.category_id) as typelink,\n  <#else>\n    (SELECT \'index.html\') AS typelink,\n  </#if>\n    content_description AS descrip,\n    content_hit AS hit,\n    content_type AS flag,\n    cms_content.content_keyword AS keyword,\n    content_img AS litpic,\n    \n  <#--内容页动态链接-->\n  <#if isDo?? && isDo>\n    CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\n  <#else>\n    CONCAT(category.category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\n  </#if>\n  \n  <#if tableName??>${tableName}.*,</#if>\n  content_datetime AS \"date\"\nFROM\n  cms_content LEFT JOIN cms_category as category \n  ON cms_content.category_id = category.id\n\n  <#--判断是否有自定义模型表-->\n  <#if tableName??>\n    LEFT JOIN ${tableName} ON ${tableName}.link_id=cms_content.id \n  </#if>\n  WHERE  \n    content_display=0 \n    and cms_content.del=0 \n    <#--根据站点编号查询-->\n    <#if appId?? >\n      and cms_content.app_id=${appId}\n      and cms_content.id>0\n    </#if>\n    <#--判断是否有搜索分类集合-->\n    <#if search??>\n      <#if search.categoryIds??>and FIND_IN_SET(category.id,\'${search.categoryIds}\')</#if>\n        <#--标题-->\n        <#if search.content_title??> and content_title like CONCAT(\'%\',\'${search.content_title}\',\'%\')</#if>\n        <#--作者-->\n        <#if search.content_author??> and content_author like CONCAT(\'%\',\'${search.content_author}\',\'%\')</#if>\n        <#--来源-->\n        <#if search.content_source??> and content_source like CONCAT(\'%\',\'${search.content_source}\',\'%\')</#if>\n        <#--属性-->\n        <#if search.content_type??> and  (\n          <#list search.content_type?split(\',\') as item>\n            <#if item?index gt 0> or</#if>\n            FIND_IN_SET(\'${item}\',cms_content.content_type)\n          </#list>)\n        </#if>\n\n        <#--描述-->\n        <#if search.content_description??> \n        and content_description like CONCAT(\'%\',\'${search.content_description}\',\'%\')\n        </#if>\n\n        <#--关键字-->\n        <#if search.content_keyword??> and content_keyword like CONCAT(\'%\',\'${search.content_keyword}\',\'%\')</#if>\n        \n        <#--内容-->\n        <#if search.content_details??> and content_details like CONCAT(\'%\',\'${search.content_details}\',\'%\')</#if>\n      \n    <#--自定义顺序-->\n        <#if search.content_sort??> and content_sort=${search.content_sort}</#if>   \n    <#--时间范围-->\n        <#if search.content_datetime_start??&&search.content_datetime_end??> \n          and content_datetime between \'${search.content_datetime_start}\' and \'${search.content_datetime_end}\'\n        </#if>\n    <#else>\n      <#--查询栏目-->\n      <#if _typeid?has_content> \n        and (cms_content.category_id=${_typeid} or cms_content.category_id in (select id FROM cms_category where cms_category.del=0 \n        <#if _typetitle?has_content>\n        and cms_category.category_title=\'${_typetitle}\'</#if> and FIND_IN_SET(${_typeid},CATEGORY_PARENT_IDS))) \n        </#if>\n    </#if>\n      <#--标题-->\n      <#if content_title??> and content_title like CONCAT(\'%\',\'${content_title}\',\'%\')</#if>\n      <#--作者-->\n      <#if content_author??> and content_author like CONCAT(\'%\',\'${content_author}\',\'%\')</#if>\n      <#--来源-->\n      <#if content_source??> and content_source like CONCAT(\'%\',\'${content_source}\',\'%\')</#if>\n      <#--属性-->\n      <#if content_type??> and content_type like CONCAT(\'%\',\'${content_type}\',\'%\')</#if>\n      <#--描述-->\n      <#if content_description??> and content_description like CONCAT(\'%\',\'${content_description}\',\'%\')</#if>\n      <#--关键字-->\n      <#if content_keyword??> and content_keyword like CONCAT(\'%\',\'${content_keyword}\',\'%\')</#if>\n      <#--内容-->\n      <#if content_details??> and content_details like CONCAT(\'%\',\'${content_details}\',\'%\')</#if>\n      <#--自定义顺序-->\n      <#if content_sort??> and content_sort=${content_sort}</#if>\n      <#--自定义模型-->\n      <#if diyModel??> \n        <#list diyModel as dm>\n          and ${tableName}.${dm.key} like CONCAT(\'%\',\'${dm.value}\',\'%\') \n        </#list>\n      </#if>\n      <#--文章属性-->\n      <#if flag?? >\n        and(\n          <#list flag?split(\',\') as item>\n          <#if item?index gt 0> or</#if>\n          FIND_IN_SET(\'${item}\',cms_content.content_type)\n          </#list>)\n      </#if>\n      <#if noflag??>\n          and(\n          <#list noflag?split(\',\') as item>\n          <#if item?index gt 0> and</#if>\n          FIND_IN_SET(\'${item}\',cms_content.content_type)=0\n          </#list> or cms_content.content_type is null)\n      </#if>\n\n      <#--字段排序-->\n      <#if orderby?? >\n      ORDER BY \n          <#if orderby==\'date\'> content_datetime\n          <#elseif orderby==\'updatedate\'> content_updatetime\n          <#elseif orderby==\'hit\'> content_hit\n          <#elseif orderby==\'sort\'> content_sort\n        <#else>\n          cms_content.id\n        </#if>\n  <#else>\n      ORDER BY   cms_content.id\n    </#if>\n\n    <#if order?? >\n      <#if order==\'desc\'> desc</#if>\n      <#if order==\'asc\'> asc</#if>\n    <#else>\n      desc\n    </#if>\n    LIMIT \n    <#--判断是否分页-->\n    <#if ispaging?? && (pageTag.pageNo)??>\n      ${((pageTag.pageNo-1)*_size?eval)?c},${_size?default(20)}\n    <#else>\n      ${_size?default(20)}\n    </#if>', 1);
INSERT INTO `mdiy_tag_sql` VALUES (6, 4, '<#assign _typeid=\'0\'/>\n<#if column?? && column.id?? && column.id?number gt 0>\n  <#assign  _typeid=\'${column.id}\'>\n  <#assign  selfid=\'${column.id}\'>\n</#if>\n\n<#if typeid??>\n  <#assign  _typeid=\'${typeid}\'>\n</#if>\n\nselect \n  id,\n  id as typeid,\n  category_title as typetitle,\n  <#--动态链接-->\n  <#if isDo?? && isDo>\n  CONCAT(\'/${modelName}/list.do?typeid=\', id) as typelink,\n  <#else>\n    <#--栏目类型为链接-->\n    CONCAT(category_path,\'/index.html\') as typelink,\n  </#if>\n  category_keyword as typekeyword,\n  category_diy_url as typeurl,\n  category_flag as flag,\n  category_parent_ids as parentids,\n  category_descrip as typedescrip,\n	category_parent_ids as parentids,\n  category_type as type,\n	category_path as typepath,\n  leaf as leaf,\n  category_img as typelitpic ,\n  (select count(*) from cms_category c where c.category_id=id and c.del=0) as childsize\n  from cms_category  \n  where \n  cms_category.del=0 \n  <#--根据站点编号查询-->\n  <#if appId?? >\n    and cms_category.app_id=${appId}\n  </#if>\n\n  <#--栏目属性-->\n  <#if flag?? >\n  and\n    (<#list flag?split(\',\') as item>\n      <#if item?index gt 0> or</#if>\n    FIND_IN_SET(\'${item}\',category_flag)\n    </#list>)\n  </#if>\n\n  <#if noflag?? >\n    and\n    (<#list noflag?split(\',\') as item>\n      <#if item?index gt 0> and</#if>\n      FIND_IN_SET(\'${item}\',category_flag)=0\n    </#list> or category_flag is null)\n  </#if>\n\n  <#--type默认son-->\n  <#if !type??||!type?has_content>\n    <#assign type=\'son\'/>\n  </#if>\n\n  <#if type?has_content>\n  <#--顶级栏目（单个）-->\n    <#if type==\'top\'>\n      <#if _typeid != \'0\'>\n        and (id = top_id or top_id = 0)\n      </#if>\n\n    <#elseif type==\'nav\'>\n      and(category_id=0 or category_id is null)\n\n    <#--同级栏目（多个）-->\n    <#elseif type==\'level\'>\n      and\n      <#if _typeid != \'0\'>\n        category_id=(select category_id from cms_category where id=${_typeid})\n      <#else>\n        1=1\n      </#if>\n    \n    <#--当前栏目（单个）-->\n  <#elseif type==\'self\'>\n     and \n     <#if _typeid != \'0\'>\n      id=${_typeid}\n     <#else>\n     1=1\n     </#if>\n\n    <#--当前栏目的所属栏目（多个）-->\n  <#elseif type==\'path\'>\n      and \n     <#if _typeid != \'0\'>\n       id in (<#if column?? && column.categoryParentId??>${column.categoryParentId},</#if>${_typeid})\n     <#else>\n      1=1\n     </#if>\n    <#--子栏目（多个）-->\n\n  <#elseif type==\'son\'>\n      and \n     <#if _typeid != \'0\'>\n      category_id=${_typeid}\n     <#else>\n      1=1\n     </#if>\n\n  <#--上一级栏目没有则取当前栏目（单个）-->\n  <#elseif type==\'parent\'>\n      and \n     <#if _typeid != \'0\'>\n       <#if column?? && column.categoryId??>\n        id=${column.categoryId}\n       <#else>\n        id=${_typeid}\n       </#if>\n     <#else>\n        1=1\n      </#if>\n  </#if>\n\n<#else> <#--默认顶级栏目-->\n   and\n\n  <#if _typeid != \'0\'>\n   id=${_typeid} \n  <#else>\n   (category_id=0 or category_id is null)\n  </#if>\n\n</#if>\n\n<#--字段排序-->\n<#if orderby?? >\n  ORDER BY \n  <#if orderby==\'date\'> category_datetime\n  <#elseif orderby==\'sort\'> category_sort\n  <#else>cms_content.id</#if>\n</#if>\n\n<#if order?? >\n  <#if order==\'desc\'> desc</#if>\n  <#if order==\'asc\'> asc</#if>\n</#if>', 1);
INSERT INTO `mdiy_tag_sql` VALUES (7, 5, 'select \nAPP_NAME as name,\napp_logo as logo ,\napp_keyword as keyword,\napp_description as descrip,\napp_copyright as copyright,\n<#--动态解析 -->\n<#if isDo?? && isDo>\nCONCAT(\'${url}\',\'/${html}/\',app_dir) as url,\n\'${url}\' as host,\n<#--使用地址栏的域名 -->\n<#elseif url??>\nCONCAT(\'${url}\',\'/${html}/\',app_dir) as url,\n\'${url}\' as host,\n<#else>\nCONCAT(REPLACE(REPLACE(TRIM(substring_index(app_url,\'\\n\',1)), CHAR(10),\'\'), CHAR(13),\'\'),\'/html/\',app_dir) as url,\nREPLACE(REPLACE(TRIM(substring_index(app_url,\'\\n\',1)), CHAR(10),\'\'), CHAR(13),\'\') as host,\n</#if>\nCONCAT(\'template/\',id,\'/\',app_style) as \"style\" <#-- 判断是否为手机端 -->\nfrom app \n<#--根据站点编号查询-->\n<#if appId?? >\n  where id = ${appId}\n</#if>', 1);
INSERT INTO `mdiy_tag_sql` VALUES (8, 7, 'SELECT \ncms_content.id as id,\nleft(content_title,${titlelen?default(40)}) as title,\ncontent_title as fulltitle,\ncontent_author as author, \ncontent_source as source, \ncontent_details as content,\ncategory_title as typetitle,\ncms_category.id as typeid,\ncms_category.category_img AS typelitpic,\ncms_category.category_path AS typepath,\ncms_category.top_id as topId,\ncms_category.category_flag as typeflag,\ncms_category.category_parent_ids as parentids,\ncms_category.category_keyword as typekeyword,\ncms_category.category_descrip as typedescrip,\n<#--动态链接-->\n<#if isDo?? && isDo>\nCONCAT(\'/${modelName}/list.do?typeid=\', cms_category.id) as typelink,\n<#else>\n(SELECT \'index.html\') as typelink,\n</#if>\ncms_content.content_img AS litpic,\n<#--内容页动态链接-->\n<#if isDo?? && isDo>\nCONCAT(\'/mcms/view.do?id=\', cms_content.id) as \"link\",\n<#else>\ncontent_url AS \"link\",\n</#if>\ncontent_datetime as \"date\",\ncontent_description as descrip,\nCONCAT(\'<script type=\"text/javascript\" src=\"${url}/cms/content/\',cms_content.id,\'/hit.do\"></script>\') as hit,\ncontent_type as flag,\ncategory_title as typetitle,\n<#if tableName??>${tableName}.*,</#if>\ncontent_keyword as keyword\nFROM cms_content\nLEFT JOIN cms_category  ON \ncms_category.id = cms_content.category_id\n<#--判断是否有自定义模型表-->\n<#if tableName??>left join ${tableName} on ${tableName}.link_id=cms_content.id</#if>\nWHERE \n<#--如果是栏目列表页没有文章id所以只取栏目id-->\n<#if column??&&column.id??&&!id??> \ncms_category.id=${column.id} and\n</#if>\n cms_content.del=0\n<#if id??> and cms_content.id=${id}</#if>', 1);
INSERT INTO `mdiy_tag_sql` VALUES (9, 8, '<#assign select=\"(SELECT \'\')\"/>\r\n<#if orderby?? >\r\n      <#if orderby==\"date\"> \r\n	   <#assign  _orderby=\"content_datetime\">\r\n      <#elseif orderby==\"updatedate\">\r\n <#assign  _orderby=\"content_updatetime\">\r\n      <#elseif orderby==\"hit\"> \r\n	  <#assign  _orderby=\"content_hit\">\r\n      <#elseif orderby==\"sort\">\r\n	   <#assign  _orderby=\"content_sort\">\r\n      <#else><#assign  _orderby=\"cms_content.id\"></#if>\r\n   <#else>\r\n   <#assign  _orderby=\"cms_content.id\">\r\n  </#if>\r\n<#if pageTag.preId??>\r\nSELECT \r\ncms_content.id as id,\r\nleft(content_title,${titlelen?default(40)}) as title,\r\ncontent_title as fulltitle,\r\ncontent_author as author, \r\ncontent_source as source, \r\ncontent_details as content,\r\ncategory.category_title as typename,\r\ncategory.category_id as typeid,\r\n(SELECT \'index.html\') as typelink,\r\ncontent_img as litpic,\r\n<#--内容页动态链接-->\r\n  <#if isDo?? && isDo>\r\n   CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\r\n  <#else>\r\n  CONCAT(category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\r\n  </#if>\r\ncontent_datetime as \"date\",\r\ncontent_description as descrip,\r\ncontent_hit as hit,\r\ncontent_type as flag,\r\ncontent_keyword as keyword \r\nFROM cms_content \r\nLEFT JOIN cms_category as category ON cms_content.category_id=category.id \r\nWHERE cms_content.id=${pageTag.preId}\r\n<#else>\r\nSELECT \r\n${select} as id,\r\n${select} as title,\r\n${select} as fulltitle,\r\n${select} as author, \r\n${select} as source, \r\n${select} as content,\r\n${select} as typename,\r\n${select} as typeid,\r\n${select} as typelink,\r\n${select} as litpic,\r\n${select} as \"link\",\r\n${select} as \"date\",\r\n${select} as descrip,\r\n${select} as hit,\r\n${select} as flag,\r\n${select} as keyword FROM cms_content \r\n</#if>', NULL);
INSERT INTO `mdiy_tag_sql` VALUES (10, 9, 'select\n<#if !(pageTag.indexUrl??)>\n  <#--判断是否有栏目对象，用于搜索不传栏目-->\n  <#if column??>\n    <#assign path=column.categoryPath/>\n  <#else>\n    <#assign path=\"\"/>\n  </#if>\n  <#--总记录数、总页数-->\n  (SELECT ${pageTag.total}) as \"total\",\n  (SELECT ${pageTag.size}) as \"size\",\n\n  <#--记录总数-->\n  (SELECT ${pageTag.rcount}) as \"rcount\",\n  <#--当前页码-->\n  (SELECT ${pageTag.pageNo}) as \"cur\",\n  <#--首页-->\n  CONCAT(\'${path}\', \'/index.html\') as \"index\",\n  <#--上一页-->\n  <#if (pageTag.pageNo?eval-1) gt 1>\n    CONCAT(\'${path}\',\'/list-${pageTag.pageNo?eval-1}.html\') as \"pre\",\n  <#else>\n    CONCAT(\'${path}\',\'/index.html\') as \"pre\",\n  </#if>\n  \n  <#--下一页-->\n  <#if pageTag.total==1>\n  CONCAT(\'${path}\', \'/index.html\') as \"next\",\n  CONCAT(\'${path}\', \'/index.html\') as \"last\"\n  <#else>\n    <#if pageTag.pageNo?eval gte pageTag.total>\n    CONCAT(\'${path}\',\'/list-${pageTag.total}.html\') as \"next\",\n    <#else>\n    CONCAT(\'${path}\',\'/list-${pageTag.pageNo?eval+1}.html\') as \"next\",\n    </#if>\n  <#--最后一页-->\n  CONCAT(\'${path}\',\'/list-${pageTag.total}.html\') as \"last\"\n  </#if>\n\n<#else>\n  <#--判断是否是搜索页面-->\n  \'${pageTag.indexUrl}\' as \"index\",\n  \'${pageTag.lastUrl}\' as \"last\",\n  \'${pageTag.preUrl}\' as \"pre\",\n  \'${pageTag.nextUrl}\' as \"next\",\n  \'${pageTag.total}\' as \"total\",\n  \'${pageTag.size}\' as \"size\",\n  \'${pageTag.rcount}\' as \"rcount\",\n  \'${pageTag.pageNo}\' as \"cur\"\n</#if>', NULL);
INSERT INTO `mdiy_tag_sql` VALUES (11, 10, '<#assign select=\"(SELECT \'\')\"/>\r\n<#if orderby?? >\r\n      <#if orderby==\"date\"> \r\n	   <#assign  _orderby=\"content_datetime\">\r\n      <#elseif orderby==\"updatedate\">\r\n <#assign  _orderby=\"content_updatetime\">\r\n      <#elseif orderby==\"hit\"> \r\n	  <#assign  _orderby=\"content_hit\">\r\n      <#elseif orderby==\"sort\">\r\n	   <#assign  _orderby=\"content_sort\">\r\n      <#else><#assign  _orderby=\"cms_content.id\"></#if>\r\n   <#else>\r\n   <#assign  _orderby=\"cms_content.id\">\r\n  </#if>\r\n<#if pageTag.nextId??>\r\nSELECT \r\ncms_content.id as id,\r\nleft(content_title,${titlelen?default(40)}) as title,\r\ncontent_title as fulltitle,\r\ncontent_author as author, \r\ncontent_source as source, \r\ncontent_details as content,\r\ncategory.category_title as typename,\r\ncategory.category_id as typeid,\r\n(SELECT \'index.html\') as typelink,\r\ncontent_img as litpic,\r\n<#--内容页动态链接-->\r\n  <#if isDo?? && isDo>\r\n   CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\r\n  <#else>\r\n  CONCAT(category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\r\n  </#if>\r\ncontent_datetime as \"date\",\r\ncontent_description as descrip,\r\ncontent_hit as hit,\r\ncontent_type as flag,\r\ncontent_keyword as keyword \r\nFROM cms_content \r\nLEFT JOIN cms_category as category ON cms_content.category_id=category.id \r\nWHERE cms_content.id=${pageTag.nextId}\r\n<#else>\r\nSELECT \r\n${select} as id,\r\n${select} as title,\r\n${select} as fulltitle,\r\n${select} as author, \r\n${select} as source, \r\n${select} as content,\r\n${select} as typename,\r\n${select} as typeid,\r\n${select} as typelink,\r\n${select} as litpic,\r\n${select} as \"link\",\r\n${select} as \"date\",\r\n${select} as descrip,\r\n${select} as hit,\r\n${select} as flag,\r\n${select} as keyword FROM cms_content \r\n</#if>', NULL);
COMMIT;

-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS `model`;
CREATE TABLE `model` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `model_id` int(22) DEFAULT NULL COMMENT '模块的父模块id',
  `manager_id` int(11) DEFAULT NULL COMMENT '模块关联的关联员id',
  `model_parent_ids` varchar(300) DEFAULT NULL COMMENT '父级编号集合，从小到大排序',
  `model_code` varchar(255) DEFAULT NULL COMMENT '模块编码',
  `model_title` varchar(150) DEFAULT NULL COMMENT '模块标题',
  `model_url` varchar(255) DEFAULT NULL COMMENT '模块连接地址',
  `model_icon` varchar(120) DEFAULT NULL COMMENT '模块图标',
  `model_sort` int(11) DEFAULT NULL COMMENT '模块的排序',
  `model_ismenu` int(1) DEFAULT '0' COMMENT '模块是否是菜单',
  `IS_CHILD` varchar(300) DEFAULT NULL COMMENT '扩展字段',
  `model_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_model_id` (`model_id`) USING BTREE,
  CONSTRAINT `fk_model_id` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1668 DEFAULT CHARSET=utf8 COMMENT='模块表';

-- ----------------------------
-- Records of model
-- ----------------------------
BEGIN;
INSERT INTO `model` VALUES (23, NULL, 0, NULL, '01000000', '权限管理', '', 'icon-quanxianguanli', 5, 1, NULL, '2014-09-09 10:12:22');
INSERT INTO `model` VALUES (84, NULL, 0, NULL, '12000000', '系统设置', '', 'icon-xitongguanli', 3, 1, NULL, '2014-12-19 22:30:24');
INSERT INTO `model` VALUES (86, 84, 0, '84', '12010000', '应用设置', 'app/-1/edit.do', '', 2, 1, NULL, '2014-12-19 22:31:59');
INSERT INTO `model` VALUES (87, 84, 0, '84', '12020000', '模版管理', 'template/index.do', '', 1, 1, NULL, '2014-12-19 22:32:50');
INSERT INTO `model` VALUES (182, 86, 0, '84,86', '12010004', '修改', 'app:update', '', 0, 0, NULL, '2017-09-05 16:14:42');
INSERT INTO `model` VALUES (183, 23, 0, '23', '01030000', '菜单管理', 'model/index.do', '', 0, 1, NULL, '2017-09-05 13:09:26');
INSERT INTO `model` VALUES (184, 183, 0, '23,183', '01030001', '查看', 'model:view', '', 0, 0, NULL, '2017-09-05 13:10:43');
INSERT INTO `model` VALUES (201, 183, 0, '23,183', '01030002', '新增', 'model:save', NULL, 0, 0, NULL, '2019-12-28 14:26:29');
INSERT INTO `model` VALUES (202, 183, 0, '23,183', '01030004', '修改', 'model:update', NULL, 0, 0, NULL, '2019-12-28 14:26:33');
INSERT INTO `model` VALUES (204, 87, 0, '84,87', '12020002', '上传', 'template:upload', '', 0, 0, NULL, '2019-12-28 14:26:37');
INSERT INTO `model` VALUES (217, NULL, 0, NULL, '07000000', '会员中心', '', 'icon-huiyuanzhongxin', 0, 1, NULL, '2018-10-29 21:30:44');
INSERT INTO `model` VALUES (218, 217, 0, '217', '07020100', '用户管理', 'people/peopleUser/index.do', NULL, 0, 1, NULL, '2018-10-29 21:30:44');
INSERT INTO `model` VALUES (219, 218, 0, '217,218', '07020104', '修改', 'people:user:update', '', 0, 0, NULL, '2018-10-29 21:30:44');
INSERT INTO `model` VALUES (220, 218, 0, '217,218', '07020103', '删除', 'people:user:del', '', 0, 0, NULL, '2018-10-29 21:30:44');
INSERT INTO `model` VALUES (221, 218, 0, '217,218', '07020102', '新增', 'people:user:save', '', 0, 0, NULL, '2018-10-29 21:30:44');
INSERT INTO `model` VALUES (222, 218, 0, '217,218', '07020101', '查看', 'people:view', NULL, 0, 0, NULL, '2018-10-29 21:30:45');
INSERT INTO `model` VALUES (264, NULL, 0, '264', '20000000', '自定义管理', '', 'icon-zidingyiguanli', 0, 1, NULL, '2018-09-07 11:38:51');
INSERT INTO `model` VALUES (265, 264, 0, '264', '20010000', '自定义页面', 'mdiy/page/index.do', NULL, 0, 1, NULL, '2018-09-07 11:38:51');
INSERT INTO `model` VALUES (266, 269, 0, '264,269', '20010004', '修改', 'mdiy:form:update', NULL, 0, 0, NULL, '2018-09-07 11:38:51');
INSERT INTO `model` VALUES (267, 269, 0, '264,269', '20010002', '新增', 'mdiy:form:save', NULL, 0, 0, NULL, '2018-09-07 11:38:51');
INSERT INTO `model` VALUES (268, 269, 0, '264,269', '20010001', '查看', 'mdiy:form:view', NULL, 0, 0, NULL, '2018-09-07 11:38:51');
INSERT INTO `model` VALUES (269, 264, 0, '264', '20020000', '自定义表单', 'mdiy/post/index.do', NULL, 0, 1, NULL, '2018-09-07 11:38:51');
INSERT INTO `model` VALUES (280, 264, 0, '264', '20050000', '自定义字典', 'mdiy/dict/index.do', NULL, 0, 1, NULL, '2018-09-07 11:38:53');
INSERT INTO `model` VALUES (281, 280, 0, '264,280', '20050003', '删除', 'mdiy:dict:del', NULL, 0, 0, NULL, '2018-09-07 11:38:53');
INSERT INTO `model` VALUES (282, 280, 0, '264,280', '20050004', '修改', 'mdiy:dict:update', NULL, 0, 0, NULL, '2018-09-07 11:38:53');
INSERT INTO `model` VALUES (283, 280, 0, '264,280', '20050002', '新增', 'mdiy:dict:save', NULL, 0, 0, NULL, '2018-09-07 11:38:53');
INSERT INTO `model` VALUES (284, 280, 0, '264,280', '20050001', '查看', 'mdiy:dict:view', NULL, 0, 0, NULL, '2018-09-07 11:38:53');
INSERT INTO `model` VALUES (299, 265, 0, '264,265', '299', '新增', 'mdiy:page:save', '', 0, 0, NULL, '2019-05-28 18:04:32');
INSERT INTO `model` VALUES (300, 265, 0, '264,265', '300', '修改', 'mdiy:page:update', '', 0, 0, NULL, '2019-05-28 18:05:11');
INSERT INTO `model` VALUES (301, 265, 0, '264,265', '301', '删除', 'mdiy:page:del', '', 0, 0, NULL, '2019-05-28 18:42:10');
INSERT INTO `model` VALUES (406, 23, 0, '23', '406', '角色管理', 'basic/role/index.do', '', 0, 1, NULL, '2019-08-03 19:18:47');
INSERT INTO `model` VALUES (407, 406, 0, '23,406', '407', '新增', 'role:save', '', 0, 0, NULL, '2019-08-03 19:19:10');
INSERT INTO `model` VALUES (408, 406, 0, '23,406', '408', '修改', 'role:update', '', 0, 0, NULL, '2019-08-03 19:19:34');
INSERT INTO `model` VALUES (409, 406, 0, '23,406', '409', '删除', 'role:del', '', 0, 0, NULL, '2019-08-03 19:19:59');
INSERT INTO `model` VALUES (411, 23, 0, '23', '411', '管理员管理', 'basic/manager/index.do', '', 0, 1, NULL, '2019-08-04 12:54:38');
INSERT INTO `model` VALUES (412, 411, 0, '23,411', '412', '查看', 'manager:view', '', 0, 0, NULL, '2019-08-04 12:56:13');
INSERT INTO `model` VALUES (538, 264, 0, '264,264', '15730944491834300', '自定义模型', 'mdiy/model/index.do', '', 0, 1, NULL, '2019-11-08 14:36:46');
INSERT INTO `model` VALUES (540, 538, 0, '264,538', '15730944491833822', '删除', 'mdiy:model:del', NULL, 0, 0, NULL, '2019-11-08 14:36:47');
INSERT INTO `model` VALUES (542, 538, 0, '264,538', '15730944491832459', '查看', 'mdiy:model:view', NULL, 0, 0, NULL, '2019-11-08 14:36:47');
INSERT INTO `model` VALUES (553, 538, 0, '264,538', 'importJson', '导入', 'mdiy:model:importJson', '', 0, 0, NULL, '2019-11-08 17:46:53');
INSERT INTO `model` VALUES (554, 269, 0, '264,269', 'mdiy:form:del', '删除', 'mdiy:form:del', '', 0, 0, NULL, '2019-11-08 19:14:40');
INSERT INTO `model` VALUES (661, 218, 0, '217,218', '543434354', '审核', 'people:user:check', '', 0, 0, NULL, '2019-11-17 19:38:17');
INSERT INTO `model` VALUES (663, 411, 0, '23,411', '15737980803547570', '删除', 'manager:del', '', 0, 0, NULL, '2019-11-19 18:19:35');
INSERT INTO `model` VALUES (664, 411, 0, '23,411', '15737980853527702', '更新', 'manager:update', '', 0, 0, NULL, '2019-11-19 18:21:08');
INSERT INTO `model` VALUES (665, 411, 0, '23,411', '15735981803267702', '新增', 'manager:save', '', 0, 0, NULL, '2019-11-19 18:21:42');
INSERT INTO `model` VALUES (668, 183, 0, '23,183', '668', '删除', 'model:del', '', 0, 0, NULL, '2019-11-19 18:35:49');
INSERT INTO `model` VALUES (672, 87, 0, '84,87', '5434345', '删除', 'template:del', '', 0, 0, NULL, '2019-11-19 19:05:09');
INSERT INTO `model` VALUES (673, 87, 0, '84,87', '452435345', '更新', 'template:update', '', 0, 0, NULL, '2019-11-19 19:05:35');
INSERT INTO `model` VALUES (685, 84, 0, '84', '65123656532', '系统日志', 'basic/log/index.do', '', 0, 1, NULL, '2019-11-22 21:13:50');
INSERT INTO `model` VALUES (686, 685, 0, '84,685', '351463145634', '查看', 'basic:log:view', '', 0, 0, NULL, '2019-11-22 21:14:24');
INSERT INTO `model` VALUES (706, NULL, 0, NULL, '02000000', '内容管理', '', 'icon-neirongguanli', 5, 1, NULL, '2019-11-23 20:14:59');
INSERT INTO `model` VALUES (707, 706, 0, '706', '02980000', '文章管理', 'cms/content/index.do', '', 3, 1, NULL, '2019-11-23 20:16:25');
INSERT INTO `model` VALUES (708, 706, 0, '706', '02990000', '栏目管理', 'cms/category/index.do', '', 2, 1, NULL, '2019-11-23 20:16:50');
INSERT INTO `model` VALUES (709, 706, 0, '706', '02020000', '静态化', 'cms/generate/index.do', '', 1, 1, NULL, '2019-11-23 20:17:15');
INSERT INTO `model` VALUES (710, 709, 0, '706,709', '02020004', '生成文章', 'cms:generate:article', '', 0, 0, NULL, '2019-11-23 20:17:39');
INSERT INTO `model` VALUES (711, 709, 0, '706,709', '02020003', '生成栏目', 'cms:generate:column', '', 0, 0, NULL, '2019-11-23 20:18:05');
INSERT INTO `model` VALUES (713, 709, 0, '706,709', '02020001', '查看', 'cms:generate:view', '', 0, 0, NULL, '2019-11-23 20:18:48');
INSERT INTO `model` VALUES (714, 709, 0, '706,709', '56454656', '生成主页', 'cms:generate:index', '', 0, 0, NULL, '2019-11-23 20:20:10');
INSERT INTO `model` VALUES (715, 708, 0, '706,708', '02990004', '新增', 'cms:category:save', '', 0, 0, NULL, '2019-11-23 20:20:42');
INSERT INTO `model` VALUES (716, 708, 0, '706,708', '02990003', '修改', 'cms:category:update', '', 0, 0, NULL, '2019-11-23 20:21:36');
INSERT INTO `model` VALUES (717, 708, 0, '706,708', '02990001', '查看', 'cms:category:view', '', 0, 0, NULL, '2019-11-23 20:22:05');
INSERT INTO `model` VALUES (718, 707, 0, '706,707', '02980002', '新增', 'cms:content:save', '', 0, 0, NULL, '2019-11-23 20:22:35');
INSERT INTO `model` VALUES (719, 707, 0, '706,707', '02980004', '修改', 'cms:content:update', '', 0, 0, NULL, '2019-11-23 20:22:57');
INSERT INTO `model` VALUES (720, 707, 0, '706,707', '02980001', '查看', 'cms:content:view', '', 0, 0, NULL, '2019-11-23 20:23:15');
INSERT INTO `model` VALUES (721, 707, 0, '706,707', '721', '删除', 'cms:content:del', '', 0, 0, NULL, '2019-11-23 21:02:28');
INSERT INTO `model` VALUES (722, 269, 0, '264,269', '722', '导入', 'mdiy:form:importJson', '', 0, 0, NULL, '2019-12-28 16:07:24');
INSERT INTO `model` VALUES (1653, 708, 0, '706,708', '1320', '删除', 'cms:category:del', '', 0, 0, NULL, '2020-09-22 07:41:21');
INSERT INTO `model` VALUES (1654, NULL, 0, NULL, '15777732147097291', '发送', NULL, 'icon-fasong', 0, 1, NULL, '2020-12-04 22:02:15');
INSERT INTO `model` VALUES (1655, 1654, 0, '1654', '15777732147099397', '发送日志', 'msend/log/index.do', NULL, 0, 1, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1656, 1655, 0, '1654,1655', '15777732147096736', '查看', 'log:view', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1657, 1654, 0, '1654', '15777732147095432', '短信配置', 'msend/sms/form.do', NULL, 0, 1, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1658, 1657, 0, '1654,1657', '15777732147093121', '新增', 'sms:save', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1659, 1657, 0, '1654,1657', '160462902700077409', '修改', 'sms:update', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1660, 1654, 0, '1654', '15777732147094810', '邮件配置', 'msend/mail/form.do', NULL, 0, 1, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1661, 1660, 0, '1654,1660', '15777732147096294', '新增', 'mail:save', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1662, 1660, 0, '1654,1660', '16046290810006872', '修改', 'mail:update', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1663, 1654, 0, '1654', '15777732147099091', '消息模板', 'msend/template/index.do', NULL, 0, 1, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1664, 1663, 0, '1654,1663', '15777732147094910', '新增', 'sendTemplate:save', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1665, 1663, 0, '1654,1663', '15777732147093519', '删除', 'sendTemplate:del', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1666, 1663, 0, '1654,1663', '15777732147090556', '修改', 'sendTemplate:update', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
INSERT INTO `model` VALUES (1667, 1663, 0, '1654,1663', '15777732147096115', '查看', 'sendTemplate:view', NULL, 0, 0, NULL, '2020-12-04 22:02:16');
COMMIT;

-- ----------------------------
-- Table structure for msend_log
-- ----------------------------
DROP TABLE IF EXISTS `msend_log`;
CREATE TABLE `msend_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `log_datetime` datetime DEFAULT NULL COMMENT '时间',
  `log_content` varchar(1000) DEFAULT NULL COMMENT '接收内容',
  `log_receive` varchar(100) DEFAULT NULL COMMENT '接收人',
  `log_type` int(1) DEFAULT NULL COMMENT '日志类型0邮件1短信',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='发送日志';

-- ----------------------------
-- Table structure for msend_mail
-- ----------------------------
DROP TABLE IF EXISTS `msend_mail`;
CREATE TABLE `msend_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `mail_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '邮件类型',
  `mail_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '账号',
  `mail_password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `mail_port` int(11) DEFAULT NULL COMMENT '端口号',
  `mail_server` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '服务器',
  `mail_form` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `mail_form_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `mail_enable` int(11) DEFAULT '0' COMMENT '0启用 1禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for msend_sms
-- ----------------------------
DROP TABLE IF EXISTS `msend_sms`;
CREATE TABLE `msend_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `sms_type` varchar(150) COLLATE utf8_bin DEFAULT NULL COMMENT '短信接口类型',
  `sms_username` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '账号',
  `sms_password` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `sms_send_url` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '发送地址',
  `sms_account_url` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `sms_manager_url` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '短信平台后台管理地址',
  `sms_signature` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '签名',
  `sms_enable` int(11) DEFAULT '0' COMMENT '0启用 1禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for msend_template
-- ----------------------------
DROP TABLE IF EXISTS `msend_template`;
CREATE TABLE `msend_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `model_id` int(11) DEFAULT '0' COMMENT '模块编号',
  `template_title` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '标题',
  `template_mail` varchar(5000) COLLATE utf8_bin DEFAULT NULL,
  `template_sms` varchar(5000) COLLATE utf8_bin DEFAULT NULL,
  `template_code` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '邮件模块代码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='发送消息模板表';

-- ----------------------------
-- Table structure for people
-- ----------------------------
DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `people_name` varchar(30) DEFAULT NULL COMMENT '账号',
  `people_password` varchar(50) DEFAULT NULL COMMENT '密码',
  `people_ip` varchar(100) DEFAULT NULL COMMENT '用户登录ip',
  `people_phone` varchar(30) DEFAULT NULL COMMENT '手机号码',
  `people_phonecheck` int(1) DEFAULT '0' COMMENT '1手机验证通过',
  `people_mail` varchar(120) DEFAULT NULL COMMENT '用户邮箱',
  `people_maillcheck` int(1) DEFAULT '0' COMMENT '1邮箱验证通过',
  `people_state` int(2) DEFAULT '0' COMMENT '用户状态',
  `people_code` varchar(15) DEFAULT NULL COMMENT '随机验证码',
  `people_codesenddate` datetime DEFAULT NULL COMMENT '发送验证码时间',
  `people_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='户用基础表';

-- ----------------------------
-- Records of people
-- ----------------------------
BEGIN;
INSERT INTO `people` VALUES (1, 'zs', '2be9bd7a3434f7038ca27d1918de58bd', NULL, '11111111111', 1, '11111111111@qq.com', 1, 1, NULL, NULL, '2020-11-20 22:42:09');
INSERT INTO `people` VALUES (2, 'lisi', 'dc3a8f1670d65bea69b7b65048a0ac40', NULL, '', 0, '', 0, 0, NULL, NULL, '2020-11-21 13:24:00');
COMMIT;

-- ----------------------------
-- Table structure for people_address
-- ----------------------------
DROP TABLE IF EXISTS `people_address`;
CREATE TABLE `people_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `PEOPLE_ID` int(11) NOT NULL COMMENT '对应用户基础信息拓展表的id',
  `PA_CONSIGNEE_NAME` varchar(30) DEFAULT NULL COMMENT '用户收货人姓名',
  `PA_PHONE` varchar(40) DEFAULT NULL COMMENT '收货人手机',
  `PA_MAIL` varchar(40) DEFAULT NULL COMMENT '收货人邮箱',
  `PA_ADDRESS` varchar(200) DEFAULT NULL COMMENT '收货人的详细收货地址',
  `PA_PROVINCE` varchar(10) DEFAULT NULL COMMENT '收货人所在的省',
  `PA_PROVINCE_ID` bigint(11) DEFAULT '0' COMMENT '省份编号',
  `PA_CITY` varchar(10) DEFAULT NULL COMMENT '收货人所在的市',
  `PA_CITY_ID` bigint(11) DEFAULT '0' COMMENT '城市编号',
  `PA_DISTRICT` varchar(10) DEFAULT NULL COMMENT '收货人所在区(县)',
  `PA_DISTRICT_ID` bigint(11) DEFAULT '0' COMMENT '区编号',
  `PA_STREET` varchar(255) DEFAULT NULL COMMENT '街道',
  `PA_STREET_ID` bigint(11) DEFAULT '0' COMMENT '街道编号',
  `PA_DEFAULT` int(1) DEFAULT '0' COMMENT '是否是收货人最终收货地址。1代表是，0代表不是，默认为0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `PA_PEOPLE_ID` (`PEOPLE_ID`) USING BTREE,
  CONSTRAINT `fk_pa_people_id` FOREIGN KEY (`PEOPLE_ID`) REFERENCES `people` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户地址';

-- ----------------------------
-- Table structure for people_user
-- ----------------------------
DROP TABLE IF EXISTS `people_user`;
CREATE TABLE `people_user` (
  `people_id` int(11) NOT NULL COMMENT '用户id关联people表的（people_id）',
  `pu_real_name` varchar(50) DEFAULT NULL COMMENT '用户真实名称',
  `pu_address` varchar(200) DEFAULT NULL COMMENT '用户地址',
  `pu_level` varchar(200) DEFAULT NULL COMMENT '用户等级',
  `pu_level_name` varchar(200) DEFAULT NULL COMMENT '用户等级名称',
  `pu_icon` varchar(200) DEFAULT NULL COMMENT '用户头像图标地址',
  `pu_nickname` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `pu_sex` int(2) DEFAULT NULL COMMENT '用户性别(0.未知、1.男、2.女)',
  `pu_birthday` date DEFAULT NULL COMMENT '用户出生年月日',
  `pu_card` varchar(255) DEFAULT NULL COMMENT '身份证',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省编号',
  `province_name` varchar(255) DEFAULT NULL COMMENT '省',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城市编号',
  `city_name` varchar(255) DEFAULT NULL COMMENT '城市',
  `county_id` bigint(20) DEFAULT NULL COMMENT '县编号',
  `county_name` varchar(255) DEFAULT NULL COMMENT '县',
  PRIMARY KEY (`people_id`) USING BTREE,
  KEY `inx_people_id` (`people_id`) USING BTREE,
  CONSTRAINT `fk_pu_people_id` FOREIGN KEY (`people_id`) REFERENCES `people` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户基础信息表';

-- ----------------------------
-- Records of people_user
-- ----------------------------
BEGIN;
INSERT INTO `people_user` VALUES (1, '1', '1', NULL, NULL, '/upload/1/people/user/1605936220556.jpg', '张三', 1, '2020-11-08', '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `people_user` VALUES (2, NULL, NULL, NULL, NULL, '/upload/1/people/user/1605936239726.jpg', '李四', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `manager_id` int(11) DEFAULT '0' COMMENT '角色管理员编号',
  `role_name` varchar(30) DEFAULT NULL COMMENT '角色名',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `inx_role_manage_id` (`manager_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (48, 57, 'msopen');
COMMIT;

-- ----------------------------
-- Table structure for role_model
-- ----------------------------
DROP TABLE IF EXISTS `role_model`;
CREATE TABLE `role_model` (
  `model_id` int(22) DEFAULT NULL COMMENT '模块编号',
  `role_id` int(22) DEFAULT NULL COMMENT '角色编号',
  KEY `fk_model_id` (`model_id`) USING BTREE,
  KEY `fk_role_id` (`role_id`) USING BTREE,
  CONSTRAINT `fk_rm_model_id` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_rm_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色模块关联表';

-- ----------------------------
-- Records of role_model
-- ----------------------------
BEGIN;
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
INSERT INTO `role_model` VALUES (1653, 48);
INSERT INTO `role_model` VALUES (1654, 48);
INSERT INTO `role_model` VALUES (1655, 48);
INSERT INTO `role_model` VALUES (1656, 48);
INSERT INTO `role_model` VALUES (1657, 48);
INSERT INTO `role_model` VALUES (1658, 48);
INSERT INTO `role_model` VALUES (1659, 48);
INSERT INTO `role_model` VALUES (1660, 48);
INSERT INTO `role_model` VALUES (1661, 48);
INSERT INTO `role_model` VALUES (1662, 48);
INSERT INTO `role_model` VALUES (1663, 48);
INSERT INTO `role_model` VALUES (1664, 48);
INSERT INTO `role_model` VALUES (1665, 48);
INSERT INTO `role_model` VALUES (1666, 48);
INSERT INTO `role_model` VALUES (1667, 48);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
