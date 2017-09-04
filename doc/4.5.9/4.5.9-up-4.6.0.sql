
ALTER TABLE `category` ADD COLUMN `CATEGORY_PARENT_ID` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '父类型编号' after `CATEGORY_DESCRIPTION`;
ALTER TABLE `category` ADD COLUMN `CATEGORY_DICT_ID` int(11) DEFAULT 0 COMMENT '字典对应编号' after `CATEGORY_PARENT_ID`;
ALTER TABLE `category` ADD COLUMN `CATEGORY_CREATE_BY` int(11) DEFAULT 0 COMMENT '创建人' after `CATEGORY_DICT_ID`;
ALTER TABLE `category` ADD COLUMN `CATEGORY_CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间' after `CATEGORY_CREATE_BY`;
ALTER TABLE `category` ADD COLUMN `CATEGORY_UPDATE_BY` int(11) DEFAULT 0 COMMENT '更新人' after `CATEGORY_CREATE_DATE`;
ALTER TABLE `category` ADD COLUMN `CATEGORY_UPDATE_DATE` datetime DEFAULT NULL COMMENT '更新时间' after `CATEGORY_UPDATE_BY`;
ALTER TABLE `category` ADD COLUMN `CATEGORY_DEL` int(11) NOT NULL DEFAULT 0 COMMENT '删除状态' after `CATEGORY_UPDATE_DATE`;
CREATE TABLE `dict` (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `dict_value` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `dict_label` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `dict_type` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '类型',
  `dict_description` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '描述',
  `dict_sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序（升序）',
  `dict_parent_id` varchar(64) COLLATE utf8_bin DEFAULT '0' COMMENT '父级编号',
  `dict_create_by` int(64) NOT NULL DEFAULT '0' COMMENT '创建者',
  `dict_create_date` datetime NOT NULL COMMENT '创建时间',
  `dict_update_by` int(64) DEFAULT '0' COMMENT '更新者',
  `dict_update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `dict_remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `dict_del` int(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`dict_id`),
  KEY `dict_value` (`dict_value`),
  KEY `dict_label` (`dict_label`),
  KEY `dict_del` (`dict_del`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='字典表'