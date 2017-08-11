UPDATE model  SET MODEL_URL = 'mdiy/search/index.do?modelName=cms' WHERE MODEL_URL = 'mdiy/search/list.do';
ALTER TABLE cms_column RENAME TO basic_column;
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
ALTER TABLE `mdiy_content_model` 
ADD COLUMN `CM_APP_ID` int(0) COMMENT '应用编号' AFTER `CM_MODEL_ID`