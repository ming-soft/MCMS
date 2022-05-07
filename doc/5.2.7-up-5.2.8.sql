SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `mdiy_page` ADD INDEX `idx_page_model_id`(`page_model_id`) USING BTREE;
DROP TABLE `mdiy_form`;
UPDATE mdiy_model SET MODEL_CUSTOM_TYPE = 'form' WHERE MODEL_CUSTOM_TYPE = 'post';
UPDATE `mdiy_tag` SET `TAG_SQL` = '<#assign _typeid=\'\'/>\n<#assign _typetitle=\'\'/>\n<#assign _size=\'20\'/>\n\n<#if column?? && column.id?? && column.id?number gt 0>\n  <#assign  _typeid=\'${column.id}\'>\n</#if>\n\n<#if typeid??>\n  <#assign  _typeid=\'${typeid}\'>\n</#if>\n\n<#if typetitle??>\n  <#assign  _typetitle=\'${typetitle}\'>\n</#if>\n\n<#if size??>\n  <#assign  _size=\'${size}\'>\n</#if>\n\n<#if orderby?? >\n    <#if orderby==\'date\'>\n      <#assign  _orderby=\'content_datetime\'>\n  <#elseif orderby==\'updatedate\'>\n    <#assign  _orderby=\'content_updatetime\'>\n    <#elseif orderby==\'hit\'>\n      <#assign  _orderby=\'content_hit\'>\n    <#elseif orderby==\'sort\'>\n      <#assign  _orderby=\'content_sort\'>\n    <#else>\n        <#assign  _orderby=\'cms_content.id\'>\n     </#if>\n<#else>\n    <#assign  _orderby=\'cms_content.id\'>\n</#if>\n\nSELECT\n    cms_content.id AS id,\n    content_title AS title,\n    content_title AS fulltitle,\n    content_author AS author,\n    content_source AS source,\n    category.category_title AS typetitle,\n    category.id AS typeid,\n    category.category_path AS typepath,\n    category.category_img AS typelitpic,\n    category.category_keyword as typekeyword,\n    category.top_id as topId,\n    category.category_parent_ids as parentids,\n    category.category_type AS \"type\",\n\n        <#--列表页动态链接-->\n        <#if isDo?? && isDo>\n    CONCAT(\'${modelName}/list.do?style=${appTemplate!\"\"}&typeid=\', category.category_id) as typelink,\n        <#else>\n    (SELECT CONCAT(category_path,\'/index.html\')) AS typelink,\n        </#if>\n    content_description AS descrip,\n    content_hit AS hit,\n    content_type AS flag,\n    cms_content.content_keyword AS keyword,\n    content_img AS litpic,\n\n        <#--内容页动态链接-->\n        <#if isDo?? && isDo>\n    CONCAT(\'${modelName}/view.do?style=${appTemplate!\"\"}&id=\', cms_content.id) as \"link\",\n        <#else>\n    CONCAT(category.category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\n        </#if>\n\n        <#if tableName??>${tableName}.*,</#if>\n    content_datetime AS \"date\"\nFROM\n    cms_content LEFT JOIN cms_category as category\nON cms_content.category_id = category.id\n\n    <#--判断是否有自定义模型表-->\n    <#if tableName??>\n    LEFT JOIN ${tableName} ON ${tableName}.link_id=cms_content.id\n    </#if>\nWHERE\n    content_display=0\n  and cms_content.del=0\n\n    <#--gov 判断发布到-->\n    <#if style?? >\n  and(\n    <#list style?split(\',\') as item>\n    <#if item?index gt 0> or</#if>\n    FIND_IN_SET(\'${item}\',cms_content.content_style)\n    </#list>)\n    </#if>\n    <#--根据站点编号查询-->\n    <#if appId?? >\n  and cms_content.app_id=${appId}\n  and cms_content.id>0\n    </#if>\n    <#--判断是否有搜索分类集合-->\n    <#if search?? && _typeid==\"\">\n    <#if search.categoryIds?has_content>and FIND_IN_SET(category.id,\'${search.categoryIds}\')</#if>\n    <#--标题-->\n    <#if search.content_title??> and content_title like CONCAT(\'%\',\'${search.content_title}\',\'%\')</#if>\n    <#--作者-->\n    <#if search.content_author??> and content_author like CONCAT(\'%\',\'${search.content_author}\',\'%\')</#if>\n    <#--来源-->\n    <#if search.content_source??> and content_source like CONCAT(\'%\',\'${search.content_source}\',\'%\')</#if>\n    <#--属性-->\n    <#if search.content_type??> and  (\n    <#list search.content_type?split(\',\') as item>\n    <#if item?index gt 0> or</#if>\n    FIND_IN_SET(\'${item}\',cms_content.content_type)\n    </#list>)\n    </#if>\n\n    <#--描述-->\n    <#if search.content_description??>\n  and content_description like CONCAT(\'%\',\'${search.content_description}\',\'%\')\n    </#if>\n\n    <#--关键字-->\n    <#if search.content_keyword??> and content_keyword like CONCAT(\'%\',\'${search.content_keyword}\',\'%\')</#if>\n\n    <#--内容-->\n    <#if search.content_details??> and content_details like CONCAT(\'%\',\'${search.content_details}\',\'%\')</#if>\n\n    <#--自定义顺序-->\n    <#if search.content_sort??> and content_sort=${search.content_sort}</#if>\n    <#--时间范围-->\n    <#if search.content_datetime_start??&&search.content_datetime_end??>\n  and content_datetime between \'${search.content_datetime_start}\' and \'${search.content_datetime_end}\'\n    </#if>\n    <#else>\n    <#--查询栏目-->\n    <#if _typeid?has_content>\n  and (cms_content.category_id=${_typeid}\n    or cms_content.category_id in (select id FROM cms_category where cms_category.del=0\n    <#if _typetitle?has_content>\n  and cms_category.category_title=\'${_typetitle}\'</#if> and FIND_IN_SET(${_typeid},CATEGORY_PARENT_IDS)))\n    </#if>\n    </#if>\n    <#--标题-->\n    <#if content_title??> and content_title like CONCAT(\'%\',\'${content_title}\',\'%\')</#if>\n    <#--作者-->\n    <#if content_author??> and content_author like CONCAT(\'%\',\'${content_author}\',\'%\')</#if>\n    <#--来源-->\n    <#if content_source??> and content_source like CONCAT(\'%\',\'${content_source}\',\'%\')</#if>\n    <#--属性-->\n    <#if content_type??> and content_type like CONCAT(\'%\',\'${content_type}\',\'%\')</#if>\n    <#--描述-->\n    <#if content_description??> and content_description like CONCAT(\'%\',\'${content_description}\',\'%\')</#if>\n    <#--关键字-->\n    <#if content_keyword??> and content_keyword like CONCAT(\'%\',\'${content_keyword}\',\'%\')</#if>\n    <#--内容-->\n    <#if content_details??> and content_details like CONCAT(\'%\',\'${content_details}\',\'%\')</#if>\n    <#--自定义顺序-->\n    <#if content_sort??> and content_sort=${content_sort}</#if>\n    <#--自定义模型-->\n    <#if diyModel??>\n    <#list diyModel as dm>\n      <#assign json=\"${dm}\"?eval />\n      and ${tableName}.${json.key} like CONCAT(\'%\',\'${json.value}\',\'%\')\n    </#list>\n    </#if>\n    <#--文章属性-->\n    <#if flag?? >\n  and(\n    <#list flag?split(\',\') as item>\n    <#if item?index gt 0> or</#if>\n    FIND_IN_SET(\'${item}\',cms_content.content_type)\n    </#list>)\n    </#if>\n    <#if noflag??>\n  and(\n    <#list noflag?split(\',\') as item>\n    <#if item?index gt 0> and</#if>\n    FIND_IN_SET(\'${item}\',cms_content.content_type)=0\n    </#list> or cms_content.content_type is null)\n    </#if>\n\n    <#--字段排序-->\n    <#if orderby?? >\nORDER BY\n        <#if orderby==\'date\'> content_datetime\n        <#elseif orderby==\'updatedate\'> content_updatetime\n        <#elseif orderby==\'hit\'> content_hit\n        <#elseif orderby==\'sort\'> content_sort\n        <#else>\n    cms_content.id\n        </#if>\n        <#else>\nORDER BY   cms_content.id\n        </#if>\n\n        <#if order?? >\n        <#if order==\'desc\'> desc</#if>\n        <#if order==\'asc\'> asc</#if>\n        <#else>\n        desc\n        </#if>\n    LIMIT\n        <#--判断是否分页-->\n        <#if ispaging?? && (pageTag.pageNo)??>\n                 ${((pageTag.pageNo-1)*_size?eval)?c},${_size?default(20)}\n        <#else>\n                 ${_size?default(20)}\n        </#if>\n' WHERE `TAG_NAME` = 'arclist';
DROP TABLE IF EXISTS `model`;
CREATE TABLE `model` (
                         `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
                         `model_id` int(22) DEFAULT NULL COMMENT '模块的父模块id',
                         `model_parent_ids` varchar(300) DEFAULT NULL COMMENT '父级编号集合，从小到大排序',
                         `model_code` varchar(255) DEFAULT NULL COMMENT '模块编码',
                         `model_title` varchar(150) DEFAULT NULL COMMENT '模块标题',
                         `model_url` varchar(255) DEFAULT NULL COMMENT '模块连接地址',
                         `model_icon` varchar(120) DEFAULT NULL COMMENT '模块图标',
                         `model_sort` int(11) DEFAULT NULL COMMENT '模块的排序',
                         `model_ismenu` int(1) DEFAULT '0' COMMENT '模块是否是菜单',
                         `IS_CHILD` varchar(300) DEFAULT NULL COMMENT '扩展字段',
                         `model_datetime` datetime DEFAULT NULL,
                         `UPDATE_BY` varchar(11) DEFAULT NULL COMMENT '更新人',
                         `UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间',
                         `CREATE_BY` varchar(11) DEFAULT NULL COMMENT '创建人',
                         `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
                         `DEL` int(1) DEFAULT '0' COMMENT '删除标记',
                         PRIMARY KEY (`id`) USING BTREE,
                         KEY `idx_model_id` (`model_id`) USING BTREE,
                         KEY `idx_model_title` (`model_title`,`model_url`),
                         CONSTRAINT `fk_model_id` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1768 DEFAULT CHARSET=utf8 COMMENT='模块表';

-- ----------------------------
-- Records of model
-- ----------------------------
BEGIN;
INSERT INTO `model` VALUES (23, NULL, NULL, '01000000', '权限管理', '', 'icon-quanxianguanli', 5, 1, NULL, '2014-09-09 10:12:22', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (84, NULL, NULL, '12000000', '系统设置', '', 'icon-xitongguanli', 3, 1, NULL, '2014-12-19 22:30:24', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (86, 84, '84', '12010000', '应用设置', 'app/-1/edit.do', '', 2, 1, NULL, '2014-12-19 22:31:59', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (87, 84, '84', '12020000', '模版管理', 'template/index.do', '', 1, 1, NULL, '2014-12-19 22:32:50', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (182, 86, '84,86', '12010004', '修改', 'app:update', '', 0, 0, NULL, '2017-09-05 16:14:42', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (183, 23, '23', '01030000', '菜单管理', 'model/index.do', '', 0, 1, NULL, '2017-09-05 13:09:26', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (184, 183, '23,183', '01030001', '查看', 'model:view', '', 0, 0, NULL, '2017-09-05 13:10:43', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (201, 183, '23,183', '01030002', '新增', 'model:save', NULL, 0, 0, NULL, '2019-12-28 14:26:29', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (202, 183, '23,183', '01030004', '修改', 'model:update', NULL, 0, 0, NULL, '2019-12-28 14:26:33', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (204, 87, '84,87', '12020002', '上传', 'template:upload', '', 0, 0, '', '2019-12-28 14:26:37', '', NULL, '', NULL, 0);
INSERT INTO `model` VALUES (406, 23, '23', '406', '角色管理', 'basic/role/index.do', '', 0, 1, NULL, '2019-08-03 19:18:47', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (407, 406, '23,406', '407', '新增', 'role:save', '', 0, 0, NULL, '2019-08-03 19:19:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (408, 406, '23,406', '408', '修改', 'role:update', '', 0, 0, NULL, '2019-08-03 19:19:34', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (409, 406, '23,406', '409', '删除', 'role:del', '', 0, 0, NULL, '2019-08-03 19:19:59', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (411, 23, '23', '411', '管理员管理', 'basic/manager/index.do', '', 0, 1, NULL, '2019-08-04 12:54:38', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (412, 411, '23,411', '412', '查看', 'manager:view', '', 0, 0, NULL, '2019-08-04 12:56:13', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (663, 411, '23,411', '15737980803547570', '删除', 'manager:del', '', 0, 0, NULL, '2019-11-19 18:19:35', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (664, 411, '23,411', '15737980853527702', '更新', 'manager:update', '', 0, 0, NULL, '2019-11-19 18:21:08', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (665, 411, '23,411', '15735981803267702', '新增', 'manager:save', '', 0, 0, NULL, '2019-11-19 18:21:42', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (668, 183, '23,183', '668', '删除', 'model:del', '', 0, 0, NULL, '2019-11-19 18:35:49', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (672, 87, '84,87', '5434345', '删除', 'template:del', '', 0, 0, '', '2019-11-19 19:05:09', '', NULL, '', NULL, 0);
INSERT INTO `model` VALUES (673, 87, '84,87', '452435345', '更新', 'template:update', '', 0, 0, '', '2019-11-19 19:05:35', '', NULL, '', NULL, 0);
INSERT INTO `model` VALUES (685, 84, '84', '65123656532', '系统日志', 'basic/log/index.do', '', 0, 1, NULL, '2019-11-22 21:13:50', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (686, 685, '84,685', '351463145634', '查看', 'basic:log:view', '', 0, 0, NULL, '2019-11-22 21:14:24', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (706, NULL, NULL, '02000000', '内容管理', '', 'icon-neirongguanli', 5, 1, NULL, '2019-11-23 20:14:59', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (707, 706, '706', '02980000', '文章管理', 'cms/content/index.do', '', 3, 1, NULL, '2019-11-23 20:16:25', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (708, 706, '706', '02990000', '栏目管理', 'cms/category/index.do', '', 2, 1, NULL, '2019-11-23 20:16:50', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (709, 706, '706', '02020000', '静态化', 'cms/generate/index.do', '', 1, 1, NULL, '2019-11-23 20:17:15', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (710, 709, '706,709', '02020004', '生成文章', 'cms:generate:article', '', 0, 0, NULL, '2019-11-23 20:17:39', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (711, 709, '706,709', '02020003', '生成栏目', 'cms:generate:column', '', 0, 0, NULL, '2019-11-23 20:18:05', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (713, 709, '706,709', '02020001', '查看', 'cms:generate:view', '', 0, 0, NULL, '2019-11-23 20:18:48', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (714, 709, '706,709', '56454656', '生成主页', 'cms:generate:index', '', 0, 0, NULL, '2019-11-23 20:20:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (715, 708, '706,708', '02990004', '新增', 'cms:category:save', '', 0, 0, NULL, '2019-11-23 20:20:42', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (716, 708, '706,708', '02990003', '修改', 'cms:category:update', '', 0, 0, NULL, '2019-11-23 20:21:36', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (717, 708, '706,708', '02990001', '查看', 'cms:category:view', '', 0, 0, NULL, '2019-11-23 20:22:05', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (718, 707, '706,707', '02980002', '新增', 'cms:content:save', '', 0, 0, NULL, '2019-11-23 20:22:35', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (719, 707, '706,707', '02980004', '修改', 'cms:content:update', '', 0, 0, NULL, '2019-11-23 20:22:57', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (720, 707, '706,707', '02980001', '查看', 'cms:content:view', '', 0, 0, NULL, '2019-11-23 20:23:15', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (721, 707, '706,707', '721', '删除', 'cms:content:del', '', 0, 0, NULL, '2019-11-23 21:02:28', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1653, 708, '706,708', '1320', '删除', 'cms:category:del', '', 0, 0, NULL, '2020-09-22 07:41:21', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1700, NULL, NULL, '16197622071887865', '自定义模块', '', 'icon-zhanqun', 0, 1, '', '2021-05-25 22:07:10', '57', '2022-02-28 09:40:50', '', NULL, 0);
INSERT INTO `model` VALUES (1701, 1700, '1700', '16197622071885990', '自定义页面', 'mdiy/page/index.do', '', 0, 1, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1702, 1701, '1700,1701', '16197622071882306', '新增', 'mdiy:page:save', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1703, 1701, '1700,1701', '16197622071889774', '删除', 'mdiy:page:del', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1704, 1701, '1700,1701', '16197622071883980', '更新', 'mdiy:page:update', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1705, 1701, '1700,1701', '16197622071888834', '查看', 'mdiy:page:view', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1706, 1701, '1700,1701', '161976235700096088', '导入', 'mdiy:form:importJson', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1707, 1700, '1700', '16197622071880623', '自定义模型', 'mdiy/model/index.do', '', 0, 1, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1708, 1707, '1700,1707', '16197622071887303', '新增', 'mdiy:model:save', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1709, 1707, '1700,1707', '16197622071881168', '删除', 'mdiy:model:del', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1710, 1707, '1700,1707', '16197622071881215', '更新', 'mdiy:model:update', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1711, 1707, '1700,1707', '16197622071884291', '查看', 'mdiy:model:view', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1712, 1707, '1700,1707', '161976234500028132', '导入', 'mdiy:model:importJson', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1713, 1700, '1700', '16197622071884456', '自定义配置', 'mdiy/config/index.do', '', 0, 1, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1714, 1713, '1700,1713', '16197622071881449', '新增', 'mdiy:config:save', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1715, 1713, '1700,1713', '16197622071889126', '删除', 'mdiy:config:del', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1716, 1713, '1700,1713', '16197622071888369', '更新', 'mdiy:config:update', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1717, 1713, '1700,1713', '16197622071882134', '查看', 'mdiy:config:view', NULL, 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1718, 1713, '1700,1713', '161976231700026503', '导入', 'mdiy:config:importJson', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1719, 1700, '1700', '15725929177747726', '自定义字典', 'mdiy/dict/index.do', '', 0, 1, NULL, '2021-05-25 22:07:10', '0', NULL, '0', NULL, 0);
INSERT INTO `model` VALUES (1720, 1719, '1700,1719', '15725929177745034', '查看', 'mdiy:dict:view', NULL, 0, 0, NULL, '2021-05-25 22:07:10', '0', NULL, '0', NULL, 0);
INSERT INTO `model` VALUES (1721, 1719, '1700,1719', '15725929177742474', '新增', 'mdiy:dict:save', NULL, 0, 0, NULL, '2021-05-25 22:07:10', '0', NULL, '0', NULL, 0);
INSERT INTO `model` VALUES (1722, 1719, '1700,1719', '15725929177744138', '修改', 'mdiy:dict:update', NULL, 0, 0, NULL, '2021-05-25 22:07:10', '0', NULL, '0', NULL, 0);
INSERT INTO `model` VALUES (1723, 1719, '1700,1719', '15725929177748034', '删除', 'mdiy:dict:del', NULL, 0, 0, NULL, '2021-05-25 22:07:10', '0', NULL, '0', NULL, 0);
INSERT INTO `model` VALUES (1724, 1700, '1700', '162034834200049578', '自定义业务', 'mdiy/form/index.do', 'icon-caidan', 0, 1, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1725, 1724, '1700,1724', '162034839300098062', '导入', 'mdiy:form:importJson', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1726, 1724, '1700,1724', '162034842600047746', '删除', 'mdiy:form:del', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1727, 1724, '1700,1724', '16203484400006602', '查看', 'mdiy:form:view', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1728, 1724, '1700,1724', '162034845600099530', '保存', 'mdiy:form:save', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1729, 1724, '1700,1724', '162034847100023820', '更新', 'mdiy:form:update', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1730, 1724, '1700,1724', '162143180100032708', '新增业务数据', 'mdiy:formData:save', '', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1731, 1724, '1700,1724', '162143181700031623', '删除业务数据', 'mdiy:formData:del', 'icon-caidan', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1732, 1724, '1700,1724', '162143576500025187', '更新业务数据', 'mdiy:formData:update', 'icon-caidan', 0, 0, NULL, '2021-05-25 22:07:10', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1733, 1713, '1700,1713', '', '更新数据', 'mdiy:configData:update', '', 0, 0, '', '2021-12-28 22:05:33', '57', '2021-12-28 22:06:19', '', '2021-12-28 22:05:33', 0);
INSERT INTO `model` VALUES (1764, 406, '406', '409', '查看', 'role:view', NULL, 0, 0, NULL, '2022-05-07 14:12:58', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1765, 86, '86', '12010004', '查看', 'app:view', NULL, 0, 0, NULL, '2022-05-07 14:13:36', NULL, NULL, NULL, NULL, 0);
INSERT INTO `model` VALUES (1767, 87, '84,87', '12010004', '查看', 'template:view', '', 0, 0, '', '2022-05-07 14:17:03', '57', '2022-05-07 14:17:18', '', NULL, 0);
COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
