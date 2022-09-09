SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE `cms_category` MODIFY COLUMN `mdiy_model_id` varchar(50) NULL DEFAULT NULL COMMENT '栏目管理的内容模型ID' AFTER `dict_id`;

ALTER TABLE `cms_content` ADD COLUMN `HAS_DETAIL_HTML` int(1) NULL DEFAULT 0 COMMENT '文章静态化标识 0表示未被自动静态化,1反之' AFTER `content_hit`;

ALTER TABLE `cms_content` ADD COLUMN `HAS_LIST_HTML` int(1) NULL DEFAULT 0 COMMENT '栏目静态化标识 0表示未被自动静态化,1反之' AFTER `HAS_DETAIL_HTML`;

ALTER TABLE `cms_content` MODIFY COLUMN `content_datetime` timestamp NULL DEFAULT NULL COMMENT '发布时间' AFTER `content_type`;

ALTER TABLE `logger` ADD COLUMN `BUSINESS_ID` varchar(255) NULL DEFAULT NULL COMMENT '业务id' AFTER `log_title`;

ALTER TABLE `mdiy_model` MODIFY COLUMN `id` bigint(19) UNSIGNED NOT NULL FIRST;

ALTER TABLE `mdiy_page` ADD COLUMN `PAGE_ENABLE` int(1) NULL DEFAULT 1 COMMENT '启用状态 0-关闭 1-启用' AFTER `page_key`;

SET FOREIGN_KEY_CHECKS=1;
