ALTER TABLE `model` DROP COLUMN `manager_id`;
ALTER TABLE `cms_category` DROP COLUMN `category_datetime`;
ALTER TABLE  `logger` MODIFY COLUMN `id` bigint(20) UNSIGNED NOT NULL;
ALTER TABLE `mdiy_page` ADD COLUMN `NOT_DEL` int(1) DEFAULT 0 COMMENT '删除标记';
ALTER TABLE `mdiy_model` DROP INDEX `indx_model_name`;