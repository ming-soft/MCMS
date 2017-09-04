set FOREIGN_KEY_CHECKS=0;
ALTER TABLE `app` MODIFY COLUMN `app_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '站点id' FIRST;
ALTER TABLE `basic_column` MODIFY COLUMN `column_category_id` int(11) NOT NULL COMMENT '关联category表（类别表ID）' FIRST;
ALTER TABLE `category` MODIFY COLUMN `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别ID' FIRST;
ALTER TABLE `comment` MODIFY COLUMN `comment_content` varchar(2000) NULL COMMENT '评论的内容' AFTER `comment_commentid`;
ALTER TABLE `mdiy_page` ADD COLUMN `create_date` datetime NULL AFTER `page_key`;
ALTER TABLE `mdiy_page` MODIFY COLUMN `page_app_id` int(11) NOT NULL COMMENT '应用id' AFTER `page_id`;
ALTER TABLE `people_user` DROP COLUMN `PU_APP_ID`;
ALTER TABLE `people` MODIFY COLUMN `people_app_id` int(11) NOT NULL COMMENT '应用编号' AFTER `people_datetime`;
ALTER TABLE `mdiy_content_model` MODIFY COLUMN `create_by` int(11) NULL AFTER `cm_app_id`;
ALTER TABLE `mdiy_content_model` MODIFY COLUMN `update_by` int(11) NULL AFTER `creaet_date`;
ALTER TABLE `model` ADD COLUMN `model_parent_ids` varchar(300) NULL COMMENT '父级编号集合，从小到大排序' AFTER `model_ismenu`;
ALTER TABLE `model` ADD FOREIGN KEY (`model_modelid`) REFERENCES `model` (`model_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

update model  set model_url = 'manager/querylist.do' where model_url = 'manager/index.do';
update model  set model_url = 'role/querylist.do' where model_url = 'role/index.do';
update model  set model_url = 'basic/manager/index.do' where model_url = 'manager/queryList.do';
update model  set model_url = 'basic/role/index.do' where model_url = 'role/queryList.do';
update model  set model_url = 'people/peopleUser/index.do ' where model_url = 'people/user/list.do';
update model  set model_title = '静态化',model_modelid=1 where model_url = 'cms/generate/index.do';
update model  set model_ismenu = 1;
update model  set model_modelid = null where model_modelid=0;

delete from model where model_url = 'cms/generate/column.do' or model_url='cms/generate/article.do';
delete from model where model_code = '11000000' or  model_code = '12030100' or  model_code = '12050000' or  model_code = '02060000'  or  model_code = '02050000' ;