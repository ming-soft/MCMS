SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE `cms_content` MODIFY COLUMN `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间' ;
ALTER TABLE `app` MODIFY COLUMN `id` varchar(20) NOT NULL COMMENT '站点id';
ALTER TABLE `mdiy_model` MODIFY COLUMN `model_json` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'json';
ALTER TABLE `logger` MODIFY COLUMN `log_param` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数';

SET FOREIGN_KEY_CHECKS = 1;
