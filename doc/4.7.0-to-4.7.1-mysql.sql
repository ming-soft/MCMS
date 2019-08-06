ALTER TABLE `basic_column`
ADD COLUMN `column_flag`  varchar(100) NULL DEFAULT NULL COMMENT '栏目属性' AFTER `column_cm_id`,
ADD COLUMN `column_diy_url`  varchar(50) NULL DEFAULT NULL COMMENT '自定义链接' AFTER `column_flag`;