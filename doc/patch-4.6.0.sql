UPDATE model  SET MODEL_URL = 'mdiy/search/index.do?modelName=cms' WHERE MODEL_URL = 'mdiy/search/list.do';
UPDATE model  SET MODEL_URL = 'mdiy/page/index.do' WHERE MODEL_URL = 'mdiy/modeltemplate/list.do';
UPDATE model  SET MODEL_URL = 'mdiy/contentModel/index.do' WHERE MODEL_URL = 'mdiy/contentModel/list.do';
UPDATE model  SET MODEL_URL = 'column/index.do' WHERE MODEL_URL = 'cms/column/list.do';
UPDATE model  SET MODEL_URL = 'mall/column/index.do' WHERE MODEL_URL = 'cms/column/list.do' AND MODEL_CODE='06990000';

ALTER TABLE cms_column RENAME TO basic_column;
ALTER TABLE basic_column CHANGE COLUMN_CATEGORYID `COLUMN_CATEGORY_ID` int(22) NOT NULL DEFAULT '0' COMMENT '关联category表（类别表ID）';
ALTER TABLE basic_column CHANGE COLUMN_CONTENTMODELID `COLUMN_CM_ID` int(11) DEFAULT '0' COMMENT '栏目管理的内容模型id';

ALTER TABLE model_template RENAME TO mdiy_page;
ALTER TABLE mdiy_page CHANGE mt_id page_id int(11)  NOT NULL AUTO_INCREMENT COMMENT '自增长id';
ALTER TABLE mdiy_page CHANGE mt_modelID page_model_id  int(11) DEFAULT NULL COMMENT '模块id';
ALTER TABLE mdiy_page CHANGE mt_appID page_app_id  int(11) DEFAULT NULL COMMENT '应用id';
ALTER TABLE mdiy_page CHANGE mt_path page_path  varchar(255) DEFAULT NULL COMMENT '自定义页面绑定模板的路径';
ALTER TABLE mdiy_page CHANGE mt_title page_title varchar(255) DEFAULT NULL COMMENT '自定义页面标题';
ALTER TABLE mdiy_page CHANGE mt_key page_key varchar(255) DEFAULT NULL COMMENT '自定义页面访问路径';
ALTER TABLE mdiy_page 
RENAME INDEX `mt_key` TO `page_key`,
RENAME INDEX `mt_appID` TO `page_app_id`,
RENAME INDEX `mt_modelID` TO `page_model_id`;
ALTER TABLE `mdiy_content_model` ADD COLUMN `CM_APP_ID` int(0) COMMENT '应用编号' AFTER `CM_MODEL_ID`;
ALTER TABLE `mdiy_content_model` CHANGE CM_TIPSNAME CM_TIPS_NAME varchar(30) NOT NULL COMMENT '表单提示文字';
ALTER TABLE `mdiy_content_model` CHANGE CM_TABLENAME CM_TABLE_NAME  varchar(20) NOT NULL COMMENT '表单名称';

ALTER TABLE diy_form RENAME TO mdiy_form;
ALTER TABLE mdiy_form CHANGE DF_ID `FORM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id';
ALTER TABLE mdiy_form CHANGE DF_TIPSNAME `FORM_TIPS_NAME` varchar(30) NOT NULL COMMENT '自定义表单提示文字';
ALTER TABLE mdiy_form CHANGE DF_TABLENAME `FORM_TABLE_NAME` varchar(20) NOT NULL COMMENT '自定义表单表名';
ALTER TABLE mdiy_form CHANGE DF_APPID `FORM_APP_ID` int(11) DEFAULT NULL COMMENT '自定义表单关联的应用编号';
ALTER TABLE `mdiy_form` ADD COLUMN `CREATE_BY` int(11) DEFAULT '0' COMMENT '创建者';
ALTER TABLE `mdiy_form` ADD COLUMN `CREATE_DATE` datetime  COMMENT '创建时间';
ALTER TABLE `mdiy_form` ADD COLUMN `UPDATE_BY` int(11)  DEFAULT '0' COMMENT '更新者';
ALTER TABLE `mdiy_form` ADD COLUMN `UPDATE_DATE` datetime  COMMENT '更新时间';

ALTER TABLE diy_form_field RENAME TO mdiy_form_field;
ALTER TABLE mdiy_form_field CHANGE DFF_ID `FF_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段自增长id';
ALTER TABLE mdiy_form_field CHANGE DFF_TIPSNAME `FF_TIPSNAME` varchar(30) DEFAULT NULL COMMENT '字段提示文字';
ALTER TABLE mdiy_form_field CHANGE DFF_FIELDNAME `FF_FIELDNAME` varchar(20) DEFAULT NULL COMMENT '字段名称';
ALTER TABLE mdiy_form_field CHANGE DFF_TYPE `FF_TYPE` int(11) DEFAULT NULL COMMENT '字段类型（如1.单行，2.多行，3.图片，等）';
ALTER TABLE mdiy_form_field CHANGE DFF_DEFAULT `FF_DEFAULT` varchar(250) DEFAULT NULL COMMENT '字段的默认值';
ALTER TABLE mdiy_form_field CHANGE DFF_ISNULL `FF_ISNULL` int(11) DEFAULT NULL COMMENT '字段是否为空';
ALTER TABLE mdiy_form_field CHANGE DFF_SORT `FF_SORT` int(11) DEFAULT NULL COMMENT '自定义表单的排序';
ALTER TABLE mdiy_form_field CHANGE DFF_FORMID `FF_FORMID` int(11) DEFAULT NULL COMMENT '字段管理的表单id';
ALTER TABLE `mdiy_form_field` ADD COLUMN `CREATE_BY` int(11) DEFAULT '0' COMMENT '创建者';
ALTER TABLE `mdiy_form_field` ADD COLUMN `CREATE_DATE` datetime  COMMENT '创建时间';
ALTER TABLE `mdiy_form_field` ADD COLUMN `UPDATE_BY` int(11)  DEFAULT '0' COMMENT '更新者';
ALTER TABLE `mdiy_form_field` ADD COLUMN `UPDATE_DATE` datetime  COMMENT '更新时间';

ALTER TABLE mdiy_search CHANGE SEARCH_WEBSITEID `SEARCH_APP_ID` int(11) NOT NULL COMMENT '搜索管理的应用id';

ALTER TABLE basic_attention CHANGE SEARCH_WEBSITEID ba_people_id `ba_peopleID` int(11) DEFAULT NULL COMMENT '用户id';
ALTER TABLE basic_attention CHANGE SEARCH_WEBSITEID ba_app_id `ba_appID` int(11) DEFAULT NULL COMMENT '用户应用id';
ALTER TABLE basic_attention CHANGE SEARCH_WEBSITEID ba_basic_id `ba_basicID` int(11) DEFAULT NULL COMMENT '用户收藏关联的基础id';