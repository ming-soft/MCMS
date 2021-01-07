SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE `manager` ADD COLUMN `create_date`  datetime NULL DEFAULT NULL AFTER `manager_admin`;
ALTER TABLE `manager` ADD COLUMN `update_date`  datetime NULL DEFAULT NULL AFTER `create_date`;
ALTER TABLE `manager` ADD COLUMN `update_by`  int(11) NULL DEFAULT NULL AFTER `update_date`;
ALTER TABLE `manager` ADD COLUMN `create_by`  int(11) NULL DEFAULT NULL AFTER `update_by`;
ALTER TABLE `manager` ADD COLUMN `del`  int(11) NULL DEFAULT NULL AFTER `create_by`;
ALTER TABLE `manager` MODIFY COLUMN `manager_id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '管理员id(主键)' FIRST ;

#修改id 问题开始
ALTER TABLE `manager` CHANGE COLUMN `manager_id` `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键' FIRST;
ALTER TABLE `model` CHANGE COLUMN `model_id` `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键' FIRST;
ALTER TABLE `role` CHANGE COLUMN `role_id` `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键' FIRST;
ALTER TABLE `role` DROP FOREIGN KEY `role_ibfk_1`;
ALTER TABLE `role` DROP COLUMN `app_id`;

ALTER TABLE`app`
DROP COLUMN `app_mobile_style`,
DROP COLUMN `app_mobile_state`,
DROP COLUMN `app_login_page`;
ALTER TABLE `app`
ADD COLUMN `app_dir` varchar(10) NULL DEFAULT NULL COMMENT '网站生成的目录' AFTER `app_pay_date`;

ALTER TABLE `role`
CHANGE COLUMN `role_managerid` `manager_id` int(11) NULL DEFAULT 0 COMMENT '角色管理员编号' AFTER `role_name`;
ALTER TABLE `role`
DROP INDEX `role_managerid`,
ADD INDEX `inx_role_manage_id`(`manager_id`) USING BTREE;

ALTER TABLE `model`
CHANGE COLUMN `model_modelid` `model_id` int(22) NULL DEFAULT NULL COMMENT '模块的父模块id' AFTER `model_code`,
CHANGE COLUMN `model_modelmanagerid` `manager_id` int(11) NULL DEFAULT NULL COMMENT '模块关联的关联员id' AFTER `model_icon`;
ALTER TABLE `model` DROP FOREIGN KEY `model_ibfk_1`;
ALTER TABLE `model`
MODIFY COLUMN `IS_CHILD` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展业务标记' AFTER `model_parent_ids`;

ALTER TABLE `model`
RENAME INDEX `model_modelid` TO `idx_model_id`,
DROP INDEX `sys_c009201`,
DROP INDEX `model_code`,
ADD CONSTRAINT `fk_model_id` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `role_model`
CHANGE COLUMN `rm_modelid` `model_id` int(22) NULL DEFAULT NULL COMMENT '模块编号' FIRST,
CHANGE COLUMN `rm_roleid` `role_id` int(22) NULL DEFAULT NULL COMMENT '角色编号' AFTER `model_id`;
ALTER TABLE `role_model`
RENAME INDEX `rm_modelid` TO `fk_model_id`,
RENAME INDEX `fk_role_model_role_1` TO `fk_role_id`,
DROP INDEX `index`;
ALTER TABLE `role_model` DROP FOREIGN KEY `role_model_ibfk_1`;
ALTER TABLE `role_model` DROP FOREIGN KEY `role_model_ibfk_2`;

ALTER TABLE `role_model`
ADD CONSTRAINT `fk_rm_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_rm_model_id` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `manager` DROP FOREIGN KEY `manager_ibfk_1`;
ALTER TABLE `manager`
CHANGE COLUMN `manager_roleid` `role_id` int(11) NULL DEFAULT NULL COMMENT '角色编号' AFTER `id`,
CHANGE COLUMN `manager_peopleid` `people_id` int(11) NULL DEFAULT 0 COMMENT '用户编号即商家编号' AFTER `role_id`;
ALTER TABLE `manager`
ADD CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE `manager`
RENAME INDEX `fk_manager_role_1` TO `fk_manager_role_id`;

ALTER TABLE `manager`
MODIFY COLUMN `manager_admin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员标识，超级管理员：super，子管理员：open' AFTER `manager_system_skin_id`;
ALTER TABLE `manager`
DROP COLUMN `manager_time`,
DROP COLUMN `manager_system_skin_id`;

DROP TABLE IF EXISTS `file` ;

ALTER TABLE `mdiy_dict` DROP FOREIGN KEY `mdiy_dict_ibfk_1`;
ALTER TABLE `mdiy_dict` CHANGE COLUMN `dict_id` `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键' FIRST;
ALTER TABLE `mdiy_dict` DROP COLUMN `app_id`;

ALTER TABLE `mdiy_dict` ADD COLUMN `dict_enable`  varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '1' COMMENT '启用状态' AFTER `is_child`;
ALTER TABLE `mdiy_dict`
MODIFY COLUMN `dict_remarks`  varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注信息' AFTER `dict_parent_id`;
ALTER TABLE `mdiy_dict`
RENAME INDEX `dict_value` TO `inx_dict_value`,
RENAME INDEX `dict_label` TO `inx_dict_label`;
ALTER TABLE `mdiy_dict`
DROP COLUMN `dict_parent_id`;

ALTER TABLE `mdiy_page` CHANGE COLUMN `page_id` `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键' FIRST;
ALTER TABLE `mdiy_page` DROP FOREIGN KEY `mdiy_page_ibfk_1`;
ALTER TABLE `mdiy_page` DROP INDEX `index_page_app_id`;
ALTER TABLE `mdiy_page` DROP COLUMN `page_app_id`;

ALTER TABLE `mdiy_tag_sql` DROP FOREIGN KEY `mdiy_tag_sql_ibfk_1`;
ALTER TABLE `mdiy_tag_sql`
ADD CONSTRAINT `fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `mdiy_tag` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `mdiy_model` DROP COLUMN `model_app_id`;
ALTER TABLE `mdiy_model`
MODIFY COLUMN `model_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义模型类型，自定义表单不用该字段' AFTER `model_name`,
MODIFY COLUMN `model_field` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '模型字段' AFTER `create_by`,
MODIFY COLUMN `model_custom_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型，自定义表单：post，自定义模型：model' AFTER `model_field`;


ALTER TABLE `people` CHANGE COLUMN `people_id` `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键' FIRST;
ALTER TABLE `people` DROP FOREIGN KEY `people_ibfk_1`;
ALTER TABLE `people` DROP COLUMN `people_app_id`;


ALTER TABLE `people_address` CHANGE COLUMN `PA_ID` `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键' FIRST;
ALTER TABLE `people_address` DROP COLUMN `PA_APP_ID`;
ALTER TABLE `people_address` DROP FOREIGN KEY `people_address_ibfk_1`;
ALTER TABLE `people_address`
CHANGE COLUMN `PA_PEOPLE_ID` `PEOPLE_ID` int(11) NOT NULL COMMENT '对应用户基础信息拓展表的id' AFTER `id`;
ALTER TABLE `people_address`
ADD CONSTRAINT `fk_pa_people_id` FOREIGN KEY (`PEOPLE_ID`) REFERENCES `people` (`id`) ON DELETE CASCADE;
ALTER TABLE `people_address`
RENAME INDEX `PA_PEOPLE_ID` TO `inx_people_id`;

ALTER TABLE `people_user`
CHANGE COLUMN `pu_people_id` `people_id` int(11) NOT NULL COMMENT '用户id关联people表的（people_id）' FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`people_id`) USING BTREE;


ALTER TABLE `people_user`
RENAME INDEX `pu_people_id` TO `inx_people_id`;
ALTER TABLE `people_user`
ADD CONSTRAINT `fk_pu_people_id` FOREIGN KEY (`people_id`) REFERENCES `people` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `people_user` DROP FOREIGN KEY `people_user_ibfk_1`;


ALTER TABLE `cms_category` ADD COLUMN `leaf`  bigint(1) NULL DEFAULT NULL COMMENT '是否是叶子节点' AFTER `category_pinyin`;
ALTER TABLE `cms_category` ADD COLUMN `top_id`  bigint(20) NULL DEFAULT NULL COMMENT '顶级id' AFTER `leaf`;
ALTER TABLE `cms_category`
CHANGE COLUMN `category_parent_id` `category_parent_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父类型编号，多个id逗号' AFTER `mdiy_model_id`;
ALTER TABLE `cms_category` MODIFY COLUMN `id`  bigint(20) UNSIGNED NOT NULL FIRST ;

UPDATE `cms_category` SET `category_id` = NULL WHERE `category_id` = "";
UPDATE `cms_category` SET `category_id` = NULL WHERE `category_id` = 0;
ALTER TABLE `cms_category`
DROP COLUMN `category_manager_id`;
ALTER TABLE `cms_category`
DROP COLUMN `app_id`;
ALTER TABLE `cms_category`
MODIFY COLUMN `category_id` bigint(20) unsigned DEFAULT NULL COMMENT '所属栏目' AFTER `id`,
MODIFY COLUMN `mdiy_model_id` int(11) NULL DEFAULT NULL COMMENT '栏目管理的内容模型id' AFTER `dict_id`;


ALTER TABLE `cms_content`
CHANGE COLUMN `content_category_id` `category_id` bigint(20) UNSIGNED NULL COMMENT '所属栏目' AFTER `id`;
ALTER TABLE `cms_content` MODIFY COLUMN `id`  bigint(20) UNSIGNED NOT NULL FIRST ;
ALTER TABLE `cms_content`
ADD CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `cms_category` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `cms_content`
DROP COLUMN `app_id`;

ALTER TABLE `cms_history_log`
CHANGE COLUMN `hl_people_id` `people_id` int(20) NULL DEFAULT NULL COMMENT '用户id' AFTER `content_id`,
MODIFY COLUMN `content_id` bigint(20) UNSIGNED NOT NULL COMMENT '文章编号' AFTER `id`;


#规范字段结束


DROP TABLE IF EXISTS `system_log`;

 CREATE TABLE If Not Exists `log` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `log_error_msg` VARCHAR(4000) DEFAULT NULL COMMENT '错误消息',
        `log_result` VARCHAR(4000) DEFAULT NULL COMMENT '返回参数',
        `log_param` VARCHAR(4000) DEFAULT NULL COMMENT '请求参数',
        `log_location` VARCHAR(255) DEFAULT NULL COMMENT '所在地区',
        `log_user` VARCHAR(255) DEFAULT NULL COMMENT '操作人员',
        `log_user_type` VARCHAR(255) DEFAULT NULL COMMENT '用户类型',
        `log_business_type` VARCHAR(255) DEFAULT NULL COMMENT '业务类型',
        `log_status` VARCHAR(255) DEFAULT NULL COMMENT '请求状态',
        `log_url` VARCHAR(255) DEFAULT NULL COMMENT '请求地址',
        `log_request_method` VARCHAR(255) DEFAULT NULL COMMENT '请求方式',
        `log_method` VARCHAR(255) DEFAULT NULL COMMENT '请求方法',
        `log_ip` VARCHAR(255) DEFAULT NULL COMMENT 'IP',
        `log_title` VARCHAR(255) DEFAULT NULL COMMENT '标题',
        `del` INT(1) DEFAULT 0 COMMENT '删除标记',
        `update_date` DATETIME DEFAULT NULL COMMENT '修改时间',
        `update_by` INT(11) DEFAULT NULL COMMENT '修改人',
        `create_date` DATETIME DEFAULT NULL COMMENT '创建时间',
        `create_by` INT(11) DEFAULT NULL COMMENT '创建人',
     PRIMARY KEY (`id`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统日志';



UPDATE `mdiy_tag_sql` SET `tag_id` = 3, `tag_sql` = '<#assign _typeid=\'\'/>\n<#assign _typetitle=\'\'/>\n<#assign _size=\'20\'/>\n\n<#if column?? && column.id?? && column.id?number gt 0>\n  <#assign  _typeid=\'${column.id}\'>\n</#if>\n\n<#if typeid??>\n  <#assign  _typeid=\'${typeid}\'>\n</#if>\n\n<#if typetitle??>\n  <#assign  _typetitle=\'${typetitle}\'>\n</#if>\n\n<#if size??>\n  <#assign  _size=\'${size}\'>\n</#if>\n\n<#if orderby?? >\n    <#if orderby==\'date\'> \n      <#assign  _orderby=\'content_datetime\'>\n  <#elseif orderby==\'updatedate\'>\n    <#assign  _orderby=\'content_updatetime\'>\n    <#elseif orderby==\'hit\'> \n      <#assign  _orderby=\'content_hit\'>\n    <#elseif orderby==\'sort\'>\n      <#assign  _orderby=\'content_sort\'>\n    <#else>\n        <#assign  _orderby=\'cms_content.id\'>\n     </#if>\n<#else>\n    <#assign  _orderby=\'cms_content.id\'>\n</#if>\n\nSELECT\n  cms_content.id AS id,\n  content_title AS title,\n  content_title AS fulltitle,\n  content_author AS author,\n  content_source AS source,\n  content_details AS content,\n  category.category_title AS typetitle,\n  category.id AS typeid,\n	category.category_path AS typepath,\n  category.category_img AS typelitpic,\n  category.category_keyword as typekeyword,\n  category.top_id as topId,\n  category.category_parent_ids as parentids,\n\n  <#--列表页动态链接-->\n  <#if isDo?? && isDo>\n    CONCAT(\'/${modelName}/list.do?typeid=\', category.category_id) as typelink,\n  <#else>\n    (SELECT \'index.html\') AS typelink,\n  </#if>\n    content_description AS descrip,\n    content_hit AS hit,\n    content_type AS flag,\n    cms_content.content_keyword AS keyword,\n    content_img AS litpic,\n    \n  <#--内容页动态链接-->\n  <#if isDo?? && isDo>\n    CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\n  <#else>\n    CONCAT(category.category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\n  </#if>\n  \n  <#if tableName??>${tableName}.*,</#if>\n  content_datetime AS \"date\"\nFROM\n  cms_content LEFT JOIN cms_category as category \n  ON cms_content.category_id = category.id\n\n  <#--判断是否有自定义模型表-->\n  <#if tableName??>\n    LEFT JOIN ${tableName} ON ${tableName}.link_id=cms_content.id \n  </#if>\n  WHERE  \n    content_display=0 \n    and cms_content.del=0 \n    <#--根据站点编号查询-->\n    <#if appId?? >\n      and cms_content.app_id=${appId}\n      and cms_content.id>0\n    </#if>\n    <#--判断是否有搜索分类集合-->\n    <#if search??>\n      <#if search.categoryIds??>and FIND_IN_SET(category.id,\'${search.categoryIds}\')</#if>\n        <#--标题-->\n        <#if search.content_title??> and content_title like CONCAT(\'%\',\'${search.content_title}\',\'%\')</#if>\n        <#--作者-->\n        <#if search.content_author??> and content_author like CONCAT(\'%\',\'${search.content_author}\',\'%\')</#if>\n        <#--来源-->\n        <#if search.content_source??> and content_source like CONCAT(\'%\',\'${search.content_source}\',\'%\')</#if>\n        <#--属性-->\n        <#if search.content_type??> and  (\n          <#list search.content_type?split(\',\') as item>\n            <#if item?index gt 0> or</#if>\n            FIND_IN_SET(\'${item}\',cms_content.content_type)\n          </#list>)\n        </#if>\n\n        <#--描述-->\n        <#if search.content_description??> \n        and content_description like CONCAT(\'%\',\'${search.content_description}\',\'%\')\n        </#if>\n\n        <#--关键字-->\n        <#if search.content_keyword??> and content_keyword like CONCAT(\'%\',\'${search.content_keyword}\',\'%\')</#if>\n        \n        <#--内容-->\n        <#if search.content_details??> and content_details like CONCAT(\'%\',\'${search.content_details}\',\'%\')</#if>\n      \n    <#--自定义顺序-->\n        <#if search.content_sort??> and content_sort=${search.content_sort}</#if>   \n    <#--时间范围-->\n        <#if search.content_datetime_start??&&search.content_datetime_end??> \n          and content_datetime between \'${search.content_datetime_start}\' and \'${search.content_datetime_end}\'\n        </#if>\n    <#else>\n      <#--查询栏目-->\n      <#if _typeid?has_content> \n        and (cms_content.category_id=${_typeid} or cms_content.category_id in (select id FROM cms_category where cms_category.del=0 \n        <#if _typetitle?has_content>\n        and cms_category.category_title=\'${_typetitle}\'</#if> and FIND_IN_SET(${_typeid},CATEGORY_PARENT_IDS))) \n        </#if>\n    </#if>\n      <#--标题-->\n      <#if content_title??> and content_title like CONCAT(\'%\',\'${content_title}\',\'%\')</#if>\n      <#--作者-->\n      <#if content_author??> and content_author like CONCAT(\'%\',\'${content_author}\',\'%\')</#if>\n      <#--来源-->\n      <#if content_source??> and content_source like CONCAT(\'%\',\'${content_source}\',\'%\')</#if>\n      <#--属性-->\n      <#if content_type??> and content_type like CONCAT(\'%\',\'${content_type}\',\'%\')</#if>\n      <#--描述-->\n      <#if content_description??> and content_description like CONCAT(\'%\',\'${content_description}\',\'%\')</#if>\n      <#--关键字-->\n      <#if content_keyword??> and content_keyword like CONCAT(\'%\',\'${content_keyword}\',\'%\')</#if>\n      <#--内容-->\n      <#if content_details??> and content_details like CONCAT(\'%\',\'${content_details}\',\'%\')</#if>\n      <#--自定义顺序-->\n      <#if content_sort??> and content_sort=${content_sort}</#if>\n      <#--自定义模型-->\n      <#if diyModel??> \n        <#list diyModel as dm>\n          and ${tableName}.${dm.key} like CONCAT(\'%\',\'${dm.value}\',\'%\') \n        </#list>\n      </#if>\n      <#--文章属性-->\n      <#if flag?? >\n        and(\n          <#list flag?split(\',\') as item>\n          <#if item?index gt 0> or</#if>\n          FIND_IN_SET(\'${item}\',cms_content.content_type)\n          </#list>)\n      </#if>\n      <#if noflag??>\n          and(\n          <#list noflag?split(\',\') as item>\n          <#if item?index gt 0> and</#if>\n          FIND_IN_SET(\'${item}\',cms_content.content_type)=0\n          </#list> or cms_content.content_type is null)\n      </#if>\n\n      <#--字段排序-->\n      <#if orderby?? >\n      ORDER BY \n          <#if orderby==\'date\'> content_datetime\n          <#elseif orderby==\'updatedate\'> content_updatetime\n          <#elseif orderby==\'hit\'> content_hit\n          <#elseif orderby==\'sort\'> content_sort\n        <#else>\n          cms_content.id\n        </#if>\n  <#else>\n      ORDER BY   cms_content.id\n    </#if>\n\n    <#if order?? >\n      <#if order==\'desc\'> desc</#if>\n      <#if order==\'asc\'> asc</#if>\n    <#else>\n      desc\n    </#if>\n    LIMIT \n    <#--判断是否分页-->\n    <#if ispaging?? && (pageTag.pageNo)??>\n      ${((pageTag.pageNo-1)*_size?eval)?c},${_size?default(20)}\n    <#else>\n      ${_size?default(20)}\n    </#if>', `sort` = 1 WHERE `id` = 5;
UPDATE `mdiy_tag_sql` SET `tag_id` = 4, `tag_sql` = '<#assign _typeid=\'0\'/>\n<#if column?? && column.id?? && column.id?number gt 0>\n  <#assign  _typeid=\'${column.id}\'>\n  <#assign  selfid=\'${column.id}\'>\n</#if>\n\n<#if typeid??>\n  <#assign  _typeid=\'${typeid}\'>\n</#if>\n\nselect \n  id,\n  id as typeid,\n  category_title as typetitle,\n  <#--动态链接-->\n  <#if isDo?? && isDo>\n  CONCAT(\'/${modelName}/list.do?typeid=\', id) as typelink,\n  <#else>\n    <#--栏目类型为链接-->\n    CONCAT(category_path,\'/index.html\') as typelink,\n  </#if>\n  category_keyword as typekeyword,\n  category_diy_url as typeurl,\n  category_flag as flag,\n  category_parent_ids as parentids,\n  category_descrip as typedescrip,\n	category_parent_ids as parentids,\n  category_type as type,\n	category_path as typepath,\n  leaf as leaf,\n  category_img as typelitpic ,\n  (select count(*) from cms_category c where c.category_id=id and c.del=0) as childsize\n  from cms_category  \n  where \n  cms_category.del=0 \n  <#--根据站点编号查询-->\n  <#if appId?? >\n    and cms_category.app_id=${appId}\n  </#if>\n\n  <#--栏目属性-->\n  <#if flag?? >\n  and\n    (<#list flag?split(\',\') as item>\n      <#if item?index gt 0> or</#if>\n    FIND_IN_SET(\'${item}\',category_flag)\n    </#list>)\n  </#if>\n\n  <#if noflag?? >\n    and\n    (<#list noflag?split(\',\') as item>\n      <#if item?index gt 0> and</#if>\n      FIND_IN_SET(\'${item}\',category_flag)=0\n    </#list> or category_flag is null)\n  </#if>\n\n  <#--type默认son-->\n  <#if !type??||!type?has_content>\n    <#assign type=\'son\'/>\n  </#if>\n\n  <#if type?has_content>\n  <#--顶级栏目（单个）-->\n    <#if type==\'top\'>\n      <#if _typeid != \'0\'>\n        and (id = top_id or top_id = 0)\n      </#if>\n\n    <#elseif type==\'nav\'>\n      and(category_id=0 or category_id is null)\n\n    <#--同级栏目（多个）-->\n    <#elseif type==\'level\'>\n      and\n      <#if _typeid != \'0\'>\n        category_id=(select category_id from cms_category where id=${_typeid})\n      <#else>\n        1=1\n      </#if>\n    \n    <#--当前栏目（单个）-->\n  <#elseif type==\'self\'>\n     and \n     <#if _typeid != \'0\'>\n      id=${_typeid}\n     <#else>\n     1=1\n     </#if>\n\n    <#--当前栏目的所属栏目（多个）-->\n  <#elseif type==\'path\'>\n      and \n     <#if _typeid != \'0\'>\n       id in (<#if column?? && column.categoryParentId??>${column.categoryParentId},</#if>${_typeid})\n     <#else>\n      1=1\n     </#if>\n    <#--子栏目（多个）-->\n\n  <#elseif type==\'son\'>\n      and \n     <#if _typeid != \'0\'>\n      category_id=${_typeid}\n     <#else>\n      1=1\n     </#if>\n\n  <#--上一级栏目没有则取当前栏目（单个）-->\n  <#elseif type==\'parent\'>\n      and \n     <#if _typeid != \'0\'>\n       <#if column?? && column.categoryId??>\n        id=${column.categoryId}\n       <#else>\n        id=${_typeid}\n       </#if>\n     <#else>\n        1=1\n      </#if>\n  </#if>\n\n<#else> <#--默认顶级栏目-->\n   and\n\n  <#if _typeid != \'0\'>\n   id=${_typeid} \n  <#else>\n   (category_id=0 or category_id is null)\n  </#if>\n\n</#if>\n\n<#--字段排序-->\n<#if orderby?? >\n  ORDER BY \n  <#if orderby==\'date\'> category_datetime\n  <#elseif orderby==\'sort\'> category_sort\n  <#else>cms_content.id</#if>\n</#if>\n\n<#if order?? >\n  <#if order==\'desc\'> desc</#if>\n  <#if order==\'asc\'> asc</#if>\n</#if>', `sort` = 1 WHERE `id` = 6;
UPDATE `mdiy_tag_sql` SET `tag_id` = 5, `tag_sql` = 'select \nAPP_NAME as name,\napp_logo as logo ,\napp_keyword as keyword,\napp_description as descrip,\napp_copyright as copyright,\n<#--动态解析 -->\n<#if isDo?? && isDo>\nCONCAT(\'${url}\',\'/${html}/\',app_dir) as url,\n\'${url}\' as host,\n<#--使用地址栏的域名 -->\n<#elseif url??>\nCONCAT(\'${url}\',\'/${html}/\',app_dir) as url,\n\'${url}\' as host,\n<#else>\nCONCAT(REPLACE(REPLACE(TRIM(substring_index(app_url,\'\\n\',1)), CHAR(10),\'\'), CHAR(13),\'\'),\'/html/\',app_dir) as url,\nREPLACE(REPLACE(TRIM(substring_index(app_url,\'\\n\',1)), CHAR(10),\'\'), CHAR(13),\'\') as host,\n</#if>\nCONCAT(\'template/\',id,\'/\',app_style) as \"style\" <#-- 判断是否为手机端 -->\nfrom app \n<#--根据站点编号查询-->\n<#if appId?? >\n  where id = ${appId}\n</#if>', `sort` = 1 WHERE `id` = 7;
UPDATE `mdiy_tag_sql` SET `tag_id` = 7, `tag_sql` = 'SELECT \ncms_content.id as id,\nleft(content_title,${titlelen?default(40)}) as title,\ncontent_title as fulltitle,\ncontent_author as author, \ncontent_source as source, \ncontent_details as content,\ncategory_title as typetitle,\ncms_category.id as typeid,\ncms_category.category_img AS typelitpic,\ncms_category.category_path AS typepath,\ncms_category.top_id as topId,\ncms_category.category_flag as typeflag,\ncms_category.category_parent_ids as parentids,\ncms_category.category_keyword as typekeyword,\ncms_category.category_descrip as typedescrip,\n<#--动态链接-->\n<#if isDo?? && isDo>\nCONCAT(\'/${modelName}/list.do?typeid=\', cms_category.id) as typelink,\n<#else>\n(SELECT \'index.html\') as typelink,\n</#if>\ncms_content.content_img AS litpic,\n<#--内容页动态链接-->\n<#if isDo?? && isDo>\nCONCAT(\'/mcms/view.do?id=\', cms_content.id) as \"link\",\n<#else>\ncontent_url AS \"link\",\n</#if>\ncontent_datetime as \"date\",\ncontent_description as descrip,\nCONCAT(\'<script type=\"text/javascript\" src=\"${url}/cms/content/\',cms_content.id,\'/hit.do\"></script>\') as hit,\ncontent_type as flag,\ncategory_title as typetitle,\n<#if tableName??>${tableName}.*,</#if>\ncontent_keyword as keyword\nFROM cms_content\nLEFT JOIN cms_category  ON \ncms_category.id = cms_content.category_id\n<#--判断是否有自定义模型表-->\n<#if tableName??>left join ${tableName} on ${tableName}.link_id=cms_content.id</#if>\nWHERE \n<#--如果是栏目列表页没有文章id所以只取栏目id-->\n<#if column??&&column.id??&&!id??> \ncms_category.id=${column.id} and\n</#if>\n cms_content.del=0\n<#if id??> and cms_content.id=${id}</#if>', `sort` = 1 WHERE `id` = 8;
UPDATE `mdiy_tag_sql` SET `tag_id` = 8, `tag_sql` = '<#assign select=\"(SELECT \'\')\"/>\r\n<#if orderby?? >\r\n      <#if orderby==\"date\"> \r\n	   <#assign  _orderby=\"content_datetime\">\r\n      <#elseif orderby==\"updatedate\">\r\n <#assign  _orderby=\"content_updatetime\">\r\n      <#elseif orderby==\"hit\"> \r\n	  <#assign  _orderby=\"content_hit\">\r\n      <#elseif orderby==\"sort\">\r\n	   <#assign  _orderby=\"content_sort\">\r\n      <#else><#assign  _orderby=\"cms_content.id\"></#if>\r\n   <#else>\r\n   <#assign  _orderby=\"cms_content.id\">\r\n  </#if>\r\n<#if pageTag.preId??>\r\nSELECT \r\ncms_content.id as id,\r\nleft(content_title,${titlelen?default(40)}) as title,\r\ncontent_title as fulltitle,\r\ncontent_author as author, \r\ncontent_source as source, \r\ncontent_details as content,\r\ncategory.category_title as typename,\r\ncategory.category_id as typeid,\r\n(SELECT \'index.html\') as typelink,\r\ncontent_img as litpic,\r\n<#--内容页动态链接-->\r\n  <#if isDo?? && isDo>\r\n   CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\r\n  <#else>\r\n  CONCAT(category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\r\n  </#if>\r\ncontent_datetime as \"date\",\r\ncontent_description as descrip,\r\ncontent_hit as hit,\r\ncontent_type as flag,\r\ncontent_keyword as keyword \r\nFROM cms_content \r\nLEFT JOIN cms_category as category ON cms_content.category_id=category.id \r\nWHERE cms_content.id=${pageTag.preId}\r\n<#else>\r\nSELECT \r\n${select} as id,\r\n${select} as title,\r\n${select} as fulltitle,\r\n${select} as author, \r\n${select} as source, \r\n${select} as content,\r\n${select} as typename,\r\n${select} as typeid,\r\n${select} as typelink,\r\n${select} as litpic,\r\n${select} as \"link\",\r\n${select} as \"date\",\r\n${select} as descrip,\r\n${select} as hit,\r\n${select} as flag,\r\n${select} as keyword FROM cms_content \r\n</#if>', `sort` = NULL WHERE `id` = 9;
UPDATE `mdiy_tag_sql` SET `tag_id` = 9, `tag_sql` = 'select\n<#if !(pageTag.indexUrl??)>\n  <#--判断是否有栏目对象，用于搜索不传栏目-->\n  <#if column??>\n    <#assign path=column.categoryPath/>\n  <#else>\n    <#assign path=\"\"/>\n  </#if>\n  <#--总记录数、总页数-->\n  (SELECT ${pageTag.total}) as \"total\",\n  (SELECT ${pageTag.size}) as \"size\",\n\n  <#--记录总数-->\n  (SELECT ${pageTag.rcount}) as \"rcount\",\n  <#--当前页码-->\n  (SELECT ${pageTag.pageNo}) as \"cur\",\n  <#--首页-->\n  CONCAT(\'${path}\', \'/index.html\') as \"index\",\n  <#--上一页-->\n  <#if (pageTag.pageNo?eval-1) gt 1>\n    CONCAT(\'${path}\',\'/list-${pageTag.pageNo?eval-1}.html\') as \"pre\",\n  <#else>\n    CONCAT(\'${path}\',\'/index.html\') as \"pre\",\n  </#if>\n  \n  <#--下一页-->\n  <#if pageTag.total==1>\n  CONCAT(\'${path}\', \'/index.html\') as \"next\",\n  CONCAT(\'${path}\', \'/index.html\') as \"last\"\n  <#else>\n    <#if pageTag.pageNo?eval gte pageTag.total>\n    CONCAT(\'${path}\',\'/list-${pageTag.total}.html\') as \"next\",\n    <#else>\n    CONCAT(\'${path}\',\'/list-${pageTag.pageNo?eval+1}.html\') as \"next\",\n    </#if>\n  <#--最后一页-->\n  CONCAT(\'${path}\',\'/list-${pageTag.total}.html\') as \"last\"\n  </#if>\n\n<#else>\n  <#--判断是否是搜索页面-->\n  \'${pageTag.indexUrl}\' as \"index\",\n  \'${pageTag.lastUrl}\' as \"last\",\n  \'${pageTag.preUrl}\' as \"pre\",\n  \'${pageTag.nextUrl}\' as \"next\",\n  \'${pageTag.total}\' as \"total\",\n  \'${pageTag.size}\' as \"size\",\n  \'${pageTag.rcount}\' as \"rcount\",\n  \'${pageTag.pageNo}\' as \"cur\"\n</#if>', `sort` = NULL WHERE `id` = 10;
UPDATE `mdiy_tag_sql` SET `tag_id` = 10, `tag_sql` = '<#assign select=\"(SELECT \'\')\"/>\r\n<#if orderby?? >\r\n      <#if orderby==\"date\"> \r\n	   <#assign  _orderby=\"content_datetime\">\r\n      <#elseif orderby==\"updatedate\">\r\n <#assign  _orderby=\"content_updatetime\">\r\n      <#elseif orderby==\"hit\"> \r\n	  <#assign  _orderby=\"content_hit\">\r\n      <#elseif orderby==\"sort\">\r\n	   <#assign  _orderby=\"content_sort\">\r\n      <#else><#assign  _orderby=\"cms_content.id\"></#if>\r\n   <#else>\r\n   <#assign  _orderby=\"cms_content.id\">\r\n  </#if>\r\n<#if pageTag.nextId??>\r\nSELECT \r\ncms_content.id as id,\r\nleft(content_title,${titlelen?default(40)}) as title,\r\ncontent_title as fulltitle,\r\ncontent_author as author, \r\ncontent_source as source, \r\ncontent_details as content,\r\ncategory.category_title as typename,\r\ncategory.category_id as typeid,\r\n(SELECT \'index.html\') as typelink,\r\ncontent_img as litpic,\r\n<#--内容页动态链接-->\r\n  <#if isDo?? && isDo>\r\n   CONCAT(\'/${modelName}/view.do?id=\', cms_content.id,\'&orderby=${_orderby}\',\'&order=${order!\'ASC\'}\',\'&typeid=${typeid}\') as \"link\",\r\n  <#else>\r\n  CONCAT(category_path,\'/\',cms_content.id,\'.html\') AS \"link\",\r\n  </#if>\r\ncontent_datetime as \"date\",\r\ncontent_description as descrip,\r\ncontent_hit as hit,\r\ncontent_type as flag,\r\ncontent_keyword as keyword \r\nFROM cms_content \r\nLEFT JOIN cms_category as category ON cms_content.category_id=category.id \r\nWHERE cms_content.id=${pageTag.nextId}\r\n<#else>\r\nSELECT \r\n${select} as id,\r\n${select} as title,\r\n${select} as fulltitle,\r\n${select} as author, \r\n${select} as source, \r\n${select} as content,\r\n${select} as typename,\r\n${select} as typeid,\r\n${select} as typelink,\r\n${select} as litpic,\r\n${select} as \"link\",\r\n${select} as \"date\",\r\n${select} as descrip,\r\n${select} as hit,\r\n${select} as flag,\r\n${select} as keyword FROM cms_content \r\n</#if>', `sort` = NULL WHERE `id` = 11;

SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE `log`
MODIFY COLUMN `log_error_msg`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '错误消息' AFTER `id`,
MODIFY COLUMN `log_result`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '返回参数' AFTER `log_error_msg`,
MODIFY COLUMN `log_param`  text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数' AFTER `log_result`;

alter table log rename to logger;

ALTER TABLE `role`
ADD COLUMN `create_by` int(10) NULL COMMENT '创建人',
ADD COLUMN `create_date` datetime(0) NULL COMMENT '创建时间',
ADD COLUMN `update_by` int(10) NULL COMMENT '更新人',
ADD COLUMN `update_date` datetime(0) NULL COMMENT '更新时间',
ADD COLUMN `del` int(1) NULL COMMENT '删除标识';

ALTER TABLE `model`
ADD COLUMN `create_by` int(10) NULL COMMENT '创建人',
ADD COLUMN `create_date` datetime(0) NULL COMMENT '创建时间',
ADD COLUMN `update_by` int(10) NULL COMMENT '更新人',
ADD COLUMN `update_date` datetime(0) NULL COMMENT '更新时间',
ADD COLUMN `del` int(1) NULL COMMENT '删除标识';

ALTER TABLE `people`
ADD COLUMN `create_by` int(10) NULL COMMENT '创建人',
ADD COLUMN `create_date` datetime(0) NULL COMMENT '创建时间',
ADD COLUMN `update_by` int(10) NULL COMMENT '更新人',
ADD COLUMN `update_date` datetime(0) NULL COMMENT '更新时间',
ADD COLUMN `del` int(1) NULL COMMENT '删除标识';

UPDATE app set app_dir = id;

update model as tmp1
    INNER JOIN
    (select id from model WHERE model_url="basic/systemLog/index.do" limit 1) as tmp2
set model_url="basic/log/index.do"
WHERE tmp1.id = tmp2.id;

update model as tmp1
    INNER JOIN
    (select id from model WHERE model_url="basic:systemlog:view" limit 1) as tmp2
set model_url="basic:log:view"
WHERE tmp1.id = tmp2.id;

UPDATE `mdiy_tag` SET `tag_name` = 'arclist', `tag_type` = 'list', `tag_description` = '文章列表' WHERE `id` = 3;
UPDATE `mdiy_tag` SET `tag_name` = 'channel', `tag_type` = 'list', `tag_description` = '通用栏目' WHERE `id` = 4;
UPDATE `mdiy_tag` SET `tag_name` = 'global', `tag_type` = 'single', `tag_description` = '全局' WHERE `id` = 5;
UPDATE `mdiy_tag` SET `tag_name` = 'field', `tag_type` = 'single', `tag_description` = '文章内容' WHERE `id` = 7;
UPDATE `mdiy_tag` SET `tag_name` = 'pre', `tag_type` = 'single', `tag_description` = '文章上一篇' WHERE `id` = 8;
UPDATE `mdiy_tag` SET `tag_name` = 'page', `tag_type` = 'single', `tag_description` = '通用分页' WHERE `id` = 9;
UPDATE `mdiy_tag` SET `tag_name` = 'next', `tag_type` = 'single', `tag_description` = '文章下一篇' WHERE `id` = 10;
