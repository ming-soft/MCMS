set FOREIGN_KEY_CHECKS=0;
UPDATE model  SET MODEL_URL = 'mdiy/search/index.do?modelName=cms' WHERE MODEL_URL = 'mdiy/search/list.do' OR MODEL_URL='mdiy/search/list.do?modelName=cms';
UPDATE model  SET MODEL_URL = 'mdiy/page/index.do' WHERE MODEL_URL = 'mdiy/modeltemplate/list.do';
UPDATE model  SET MODEL_URL = 'mdiy/contentModel/index.do' WHERE MODEL_URL = 'mdiy/contentModel/list.do';
UPDATE model  SET MODEL_URL = 'mdiy/form/index.do' WHERE MODEL_URL = 'mdiy/diyForm/form/list.do';
UPDATE model  SET MODEL_URL = 'column/index.do' WHERE MODEL_URL = 'cms/column/list.do';
UPDATE model  SET MODEL_URL = 'mall/column/index.do' WHERE MODEL_URL = 'cms/column/list.do' AND MODEL_CODE='06990000';

alter table cms_column rename to basic_column;
alter table basic_column change column_categoryid `column_category_id` int(22) not null default '0' comment '关联category表（类别表id）';
alter table basic_column change column_contentmodelid `column_cm_id` int(11) default null comment '栏目管理的内容模型id';
alter table basic_column drop column `column_tentmodelid`;
alter table basic_column drop column `column_websiteid`;

alter table model_template rename to mdiy_page;
alter table mdiy_page change mt_id page_id int(11)  not null auto_increment comment '自增长id';
alter table mdiy_page change mt_modelid page_model_id  int(11) default null comment '模块id';
alter table mdiy_page change mt_appid page_app_id  int(11) default null comment '应用id';
alter table mdiy_page change mt_path page_path  varchar(255) default null comment '自定义页面绑定模板的路径';
alter table mdiy_page change mt_title page_title varchar(255) default null comment '自定义页面标题';
alter table mdiy_page change mt_key page_key varchar(255) default null comment '自定义页面访问路径';
alter table mdiy_page drop index mt_key;
alter table mdiy_page add index index_page_key(page_key);
alter table mdiy_page drop index mt_appid;
alter table mdiy_page add index index_page_app_id(page_app_id);
alter table mdiy_page drop index mt_modelid;
alter table mdiy_page add index index_page_model_id(page_model_id);
alter table `mdiy_content_model` add column `cm_app_id` int(0) comment '应用编号' after `cm_model_id`;
alter table `mdiy_content_model` drop column `cm_managerid`;
alter table `mdiy_content_model` change cm_tipsname cm_tips_name varchar(30) not null comment '表单提示文字';
alter table `mdiy_content_model` change cm_tablename cm_table_name  varchar(20) not null comment '表单名称';

alter table diy_form rename to mdiy_form;
alter table mdiy_form change df_id `form_id` int(11) not null auto_increment comment '自增长id';
alter table mdiy_form change df_tipsname `form_tips_name` varchar(30) not null comment '自定义表单提示文字';
alter table mdiy_form change df_tablename `form_table_name` varchar(20) not null comment '自定义表单表名';
alter table mdiy_form change df_appid `form_app_id` int(11) default null comment '自定义表单关联的应用编号';
alter table `mdiy_form` add column `create_by` int(11) default '0' comment '创建者';
alter table `mdiy_form` add column `create_date` datetime  comment '创建时间';
alter table `mdiy_form` add column `update_by` int(11)  default '0' comment '更新者';
alter table `mdiy_form` add column `update_date` datetime  comment '更新时间';

alter table diy_form_field rename to mdiy_form_field;
alter table mdiy_form_field change dff_id `ff_id` int(11) not null auto_increment comment '字段自增长id';
alter table mdiy_form_field change dff_tipsname `ff_tipsname` varchar(30) default null comment '字段提示文字';
alter table mdiy_form_field change dff_fieldname `ff_fieldname` varchar(20) default null comment '字段名称';
alter table mdiy_form_field change dff_type `ff_type` int(11) default null comment '字段类型（如1.单行，2.多行，3.图片，等）';
alter table mdiy_form_field change dff_default `ff_default` varchar(250) default null comment '字段的默认值';
alter table mdiy_form_field change dff_isnull `ff_isnull` int(11) default null comment '字段是否为空';
alter table mdiy_form_field change dff_sort `ff_sort` int(11) default null comment '自定义表单的排序';
alter table mdiy_form_field change dff_formid `ff_formid` int(11) default null comment '字段管理的表单id';
alter table `mdiy_form_field` add column `create_by` int(11) default '0' comment '创建者';
alter table `mdiy_form_field` add column `create_date` datetime  comment '创建时间';
alter table `mdiy_form_field` add column `update_by` int(11)  default '0' comment '更新者';
alter table `mdiy_form_field` add column `update_date` datetime  comment '更新时间';

alter table mdiy_search change search_websiteid `search_app_id` int(11) not null comment '搜索管理的应用id';

alter table basic_attention change ba_peopleid ba_people_id  int(11) default null comment '用户id';
alter table basic_attention change ba_appid ba_app_id  int(11) default null comment '用户应用id';
alter table basic_attention change ba_basicid ba_basic_id  int(11) default null comment '用户收藏关联的基础id';

alter table `comment` engine = innodb;
alter table `cms_article` engine = innodb;
alter table `app` engine = innodb;
alter table `basic_attention` engine = innodb;
alter table `role` change role_id `role_id`  int(11) not null auto_increment comment '角色id，自增长';
alter table `manager` change manager_roleid `manager_roleid`  int(11) default null comment '角色编号';
alter table `manager` change manager_id `manager_id`  int(11) not null auto_increment comment '管理员id(主键)';
alter table `app` add constraint `fk_app_manager_1` foreign key (`app_managerid`) references `manager` (`manager_id`) on delete set null on update no action;
alter table `basic` add constraint `fk_basic_category_1` foreign key (`basic_categoryid`) references `category` (`category_id`) on delete cascade on update no action;
alter table `basic` add constraint `fk_basic_app_1` foreign key (`basic_appid`) references `app` (`app_id`) on delete cascade on update no action;
alter table `basic_attention` add constraint `fk_basic_attention_basic_1` foreign key (`ba_basic_id`) references `basic` (`basic_id`) on delete cascade;
alter table `basic_column` add constraint `fk_basic_column` foreign key (`column_category_id`) references `category` (`category_id`) on delete cascade on update no action;
alter table `basic_log` add constraint `fk_basic_log_basic_1` foreign key (`bl_basic_id`) references `basic` (`basic_id`) on delete cascade on update no action;
alter table `category` add constraint `fk_category` foreign key (`category_categoryid`) references `category` (`category_id`) on delete cascade on update no action;
alter table `category` add constraint `fk_category_1` foreign key (`category_appid`) references `app` (`app_id`) on delete cascade on update no action;
alter table `manager` add column `manager_system_skin_id` int null default 0 comment '管理员主界面样式' after `manager_time`;


alter table `manager` add constraint `fk_manager_role_1` foreign key (`manager_roleid`) references `role` (`role_id`) on delete set null on update no action;
alter table `manager_model_page` change mmp_modelid `mmp_model_id` int(11) null default null comment '模块编号';
alter table `manager_model_page` change mmp_managerid `mmp_manager_id` int(11) null default null comment '自增长id';
alter table `manager_model_page` add constraint `fk_manager_model_page_manager_1` foreign key (`mmp_manager_id`) references `manager` (`manager_id`) on delete cascade on update no action;
alter table `manager_model_page` add constraint `fk_manager_model_page_model_1` foreign key (`mmp_model_id`) references `model` (`model_id`) on delete cascade on update no action;

alter table `role_model` drop foreign key `role_model_ibfk_1`;
alter table `role_model` add constraint `role_model_ibfk_1` foreign key (`rm_modelid`) references `model` (`model_id`) on delete cascade on update no action;
alter table `role_model` add constraint `fk_role_model_role_1` foreign key (`rm_roleid`) references `role` (`role_id`) on delete cascade on update no action;
alter table `system_skin` change  ss_appid `ss_app_id` int(11) null default null comment '0后台发布大于０表示是应用自定义';
alter table `system_skin` change ss_categoryid `ss_category_id` int(11) null default null comment '主题分类';
alter table `system_skin` add constraint `fk_system_skin_app_1` foreign key (`ss_app_id`) references `app` (`app_id`) on delete cascade on update no action;
alter table `basic` modify column `basic_appid` int(11) not null comment '应用编号' after `basic_categoryid`;
drop index `sys_c009068` on `basic`;
create unique index `basic_id` on `basic` (`basic_id` asc);
alter table `category` modify column `category_smallimg` varchar(2000) null default null comment '略缩图' after `category_categoryid`;
alter table `category` modify column `category_categoryid` int(11) null default null comment '父类别编号' after `category_modelid`;
alter table `category` add column `create_by` int(11) null default 0 comment '创建人' after `category_dict_id`;
alter table `category` add column `create_date` datetime null default null comment '创建时间' after `create_by`;
alter table `category` add column `update_by` int(11) null default 0 comment '更新人' after `create_date`;
alter table `category` add column `update_date` datetime null default null comment '更新时间' after `update_by`;
alter table `category` add column `del` int(11) not null default 0 comment '删除状态' after `update_date`;


drop index `basic_datetime` on `basic`;
alter table `category` drop column `category_create_by`;
alter table `category` drop column `category_create_date`;
alter table `category` drop column `category_update_by`;
alter table `category` drop column `category_update_date`;
alter table `category` drop column `category_del`;
alter table `role` modify column `role_managerid` int(11) null default 0 comment '角色管理员编号' after `role_name`;
alter table `system_skin` drop column `ss_loginpage`;
alter table `model` modify column `model_id` int(11) not null auto_increment comment '模块自增长id' first;
alter table `manager_model_page` comment = '管理员对应的每个模块的主界面自定义';


alter table `mdiy_form_field` engine = innodb;
alter table `mdiy_form` engine = innodb;
alter table `mdiy_page` engine = innodb;
alter table `mdiy_content_model` engine = innodb;
alter table `mdiy_content_mode_field` engine = innodb;
alter table `basic_column` add constraint `fk_basic_column_1` foreign key (`column_cm_id`) references `mdiy_content_model` (`cm_id`) on delete set null on update no action;
alter table `mdiy_content_mode_field` add constraint `fk_mdiy_content_mode_field_mdiy_content_model_1` foreign key (`field_cmid`) references `mdiy_content_model` (`cm_id`) on delete cascade on update no action;
alter table `mdiy_content_model` add constraint `fk_mdiy_content_model` foreign key (`cm_app_id`) references `app` (`app_id`) on delete cascade on update no action;
alter table `mdiy_form` drop column `df_managerid`;
alter table `mdiy_form` modify column `form_app_id` int(11) not null comment '自定义表单关联的应用编号' after `form_table_name`;
alter table `mdiy_form` modify column `create_by` int(11) null after `form_app_id`;	
alter table `mdiy_form` modify column `create_date` datetime null ;
alter table `mdiy_form` modify column `update_by` int(11) null after `create_date`;
alter table `mdiy_form` modify column `update_date` datetime null ;
alter table `mdiy_form` add constraint `fk_mdiy_form` foreign key (`form_app_id`) references `app` (`app_id`) on delete cascade on update no action;
alter table `mdiy_form_field` add constraint `fk_mdiy_form_field` foreign key (`ff_formid`) references `mdiy_form` (`form_id`) on delete cascade on update no action;
alter table `mdiy_page` add constraint `fk_model_template_app_1` foreign key (`page_app_id`) references `app` (`app_id`) on delete cascade on update no action;
alter table `mdiy_search` add constraint `fk_mdiy_search` foreign key (`search_app_id`) references `app` (`app_id`) on delete cascade on update no action;
alter table `mdiy_search` modify column `search_type` varchar(20) not null default 'cms' comment '搜索类型' after `search_app_id`;

alter table `mdiy_content_model` add column `create_by` int(255) null after `cm_app_id`;
alter table `mdiy_content_model` add column `creaet_date` datetime null ;
alter table `mdiy_content_model` add column `update_by` int null after `creaet_date`;	
alter table `mdiy_content_model` add column `update_date` datetime null ;
create table `mdiy_dict` (
`dict_id` int(11) not null auto_increment comment '编号',
`app_id` int null comment '应用编号',
`dict_value` varchar(100) not null comment '数据值',
`dict_label` varchar(100) not null comment '标签名',
`dict_type` varchar(100) not null comment '类型',
`dict_description` varchar(100) not null comment '描述',
`dict_sort` int(10) not null default 0 comment '排序（升序）',
`dict_parent_id` varchar(64) null default '0' comment '父级编号',
`dict_remarks` varchar(255) null default null comment '备注信息',
`create_by` int(64) null default 0 comment '创建者',
`create_date` datetime null comment '创建时间',
`update_by` int(64) null default 0 comment '更新者',
`update_date` datetime null default null comment '更新时间',
`del` int(1) not null default 0 comment '删除标记',
primary key (`dict_id`) 
)
engine = innodb
comment = '字典表';
alter table `mdiy_dict` add constraint `fk_mdiy_dict` foreign key (`app_id`) references `app` (`app_id`) on delete cascade on update no action;
alter table `mdiy_content_mode_field` add column `create_by` int(11) null after `field_length`;
alter table `mdiy_content_mode_field` add column `create_date` datetime null ;
alter table `mdiy_content_mode_field` add column `update_by` int(11) null after `create_date`;
alter table `mdiy_content_mode_field` add column `update_date` datetime null;
alter table `mdiy_content_mode_field` add column `del` int(1) null after `update_date`;
alter table `mdiy_form_field` drop column `create_by`;
alter table `mdiy_form_field` drop column `create_date`;
alter table `mdiy_form_field` drop column `update_by`;
alter table `mdiy_form_field` drop column `update_date`;

alter table `people` modify column `people_codesenddate` datetime null comment '发送验证码时间' after `people_code`;
alter table `people` modify column `people_phonecheck` int(1) null default 0 comment '1手机验证通过' after `people_codesenddate`;
alter table `people` add constraint `fk_people` foreign key (`people_app_id`) references `app` (`app_id`) on delete cascade on update no action;
alter table `people_user` add constraint `fk_people_user_people_1` foreign key (`pu_people_id`) references `people` (`people_id`) on delete cascade on update no action;


alter table `comment` add column `comment_is_anonymous` int(11) null default 0 comment '是否匿名' after `comment_file_path`;
alter table `comment` add column `comment_audit` int(1) null default 0 comment '0默认显示 1:审核不通过' after `comment_is_anonymous`;
alter table `comment` add constraint `fk_comment` foreign key (`comment_basicid`) references `basic` (`basic_id`) on delete cascade on update no action;
alter table `comment` add constraint `fk_comment_people_1` foreign key (`comment_peopleid`) references `people` (`people_id`) on delete cascade on update no action;
alter table `people` modify column `people_maillcheck` int(1) null default 0 comment '1邮箱验证通过' after `people_phonecheck`;
alter table `people` modify column `people_datetime` timestamp not null default current_timestamp comment '注册时间' after `people_password`;
alter table cms_article add constraint `fk_cms_article_basic_1` foreign key (`article_basicid`) references `basic` (`basic_id`) on delete cascade on update no action;
drop table `system_skin_manager`;
drop table `system_main_page`;
drop table `basic_child`;
drop table `basic_category`;
drop table `basic_type`;
drop view `v_article`;
drop view `v_people_user`;
drop table `dict`;
set foreign_key_checks=1;