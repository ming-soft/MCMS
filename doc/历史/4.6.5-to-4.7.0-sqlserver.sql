ALTER TABLE [dbo].[model] ADD [is_child] varchar(255) NULL
GO

ALTER TABLE [dbo].[mdiy_dict] ALTER COLUMN [dict_value] nvarchar ( 100 ) COLLATE SQL_Latin1_General_CP1_CI_AS NULL

EXEC sp_addextendedproperty
'MS_Description', N'扩展业务标记',
'SCHEMA', N'dbo',
'TABLE', N'model',
'COLUMN', N'is_child';

ALTER TABLE [dbo].[mdiy_dict] ADD [is_child] varchar(255) NULL
GO

EXEC sp_addextendedproperty
'MS_Description', N'扩展业务标记',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_dict',
'COLUMN', N'is_child';

ALTER TABLE [dbo].[role] ALTER COLUMN [app_id] int NULL;

-- ----------------------------
-- Records of [model]
-- ----------------------------
SET IDENTITY_INSERT [dbo].[model] ON
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'153', N'自定义标签', N'20060000', N'104', N'mdiy/tag/index.do', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'1', N'104', NULL)
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'154', N'新增', N'20060001', N'153', N'mdiy:tag:save', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'0', N'104,153', NULL)
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'155', N'查看', N'20060002', N'153', N'mdiy:tag:view', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'0', N'104,153', NULL)
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'156', N'修改', N'20060003', N'153', N'mdiy:tag:update', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'0', N'104,153', NULL)
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'157', N'删除', N'20060004', N'153', N'mdiy:tag:del', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'0', N'104,153', NULL)
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'158', N'新增SQL', N'20060005', N'153', N'mdiy:tagSql:save', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'0', N'104,153', NULL)
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'159', N'查看SQL', N'20060006', N'153', N'mdiy:tagSql:view', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'0', N'104,153', NULL)
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'160', N'修改SQL', N'20060007', N'153', N'mdiy:tagSql:update', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'0', N'104,153', NULL)
GO

INSERT INTO [dbo].[model] ([model_id], [model_title], [model_code], [model_modelid], [model_url], [model_datetime], [model_icon], [model_modelmanagerid], [model_sort], [model_ismenu], [model_parent_ids], [is_child]) VALUES (N'161', N'删除SQL', N'20060008', N'153', N'mdiy:tagSql:del', N'2019-02-19 11:34:02.0000000', NULL, N'0', N'0', N'0', N'104,153', NULL)
GO

SET IDENTITY_INSERT [dbo].[model] OFF
GO

-- ----------------------------
-- Table structure for file
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[file]') AND type IN ('U'))
	DROP TABLE [dbo].[file]
GO

CREATE TABLE [dbo].[file] (
  [id] int NOT NULL,
  [category_id] int NULL,
  [app_id] int NULL,
  [file_name] nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [file_url] nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [file_size] int NULL,
  [file_json] nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [file_type] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [is_child] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [update_date] datetime2(7) NULL,
  [update_by] int NULL,
  [create_by] int NULL,
  [create_date] datetime2(7) NULL,
  [del] int NULL
)
GO

ALTER TABLE [dbo].[file] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件编号',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件分类编号',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'category_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'APP编号',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'app_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件名称',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'file_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件链接',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'file_url'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件大小',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'file_size'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件详情Json数据',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'file_json'
GO

EXEC sp_addextendedproperty
'MS_Description', N'文件类型：图片、音频、视频等',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'file_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'子业务',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'is_child'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新时间',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'update_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'更新者',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'update_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建者',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'create_by'
GO

EXEC sp_addextendedproperty
'MS_Description', N'创建时间',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'create_date'
GO

EXEC sp_addextendedproperty
'MS_Description', N'删除标记',
'SCHEMA', N'dbo',
'TABLE', N'file',
'COLUMN', N'del'
GO

EXEC sp_addextendedproperty
'MS_Description', N'基础文件表',
'SCHEMA', N'dbo',
'TABLE', N'file'
GO


-- ----------------------------
-- Primary Key structure for table file
-- ----------------------------
ALTER TABLE [dbo].[file] ADD CONSTRAINT [PK__file__3213E83FB0167B55] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO

-- ----------------------------
-- Table structure for mdiy_tag
-- ----------------------------

IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mdiy_tag]') AND type IN ('U'))
	DROP TABLE [dbo].[mdiy_tag]
GO

CREATE TABLE [dbo].[mdiy_tag] (
  [id] int NOT NULL,
  [tag_name] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [tag_type] int NULL,
  [tag_description] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO

ALTER TABLE [dbo].[mdiy_tag] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'标签名称',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_tag',
'COLUMN', N'tag_name'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标签类型',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_tag',
'COLUMN', N'tag_type'
GO

EXEC sp_addextendedproperty
'MS_Description', N'描述',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_tag',
'COLUMN', N'tag_description'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标签',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_tag'
GO


-- ----------------------------
-- Records of [mdiy_tag]
-- ----------------------------
INSERT INTO [dbo].[mdiy_tag]  VALUES (N'3', N'arclist', N'3', N'文章列表')
GO

INSERT INTO [dbo].[mdiy_tag]  VALUES (N'4', N'channel', N'3', N'通用栏目')
GO

INSERT INTO [dbo].[mdiy_tag]  VALUES (N'5', N'global', N'2', N'全局')
GO

INSERT INTO [dbo].[mdiy_tag]  VALUES (N'7', N'field', N'3', N'文章内容')
GO

INSERT INTO [dbo].[mdiy_tag]  VALUES (N'8', N'pre', N'0', N'文章上一篇')
GO

INSERT INTO [dbo].[mdiy_tag]  VALUES (N'9', N'page', N'2', N'通用分页')
GO

INSERT INTO [dbo].[mdiy_tag]  VALUES (N'10', N'next', N'0', N'文章下一篇')
GO

INSERT INTO [dbo].[mdiy_tag]  VALUES (N'12', N'prclist', N'3', N'商品列表')
GO

INSERT INTO [dbo].[mdiy_tag]  VALUES (N'13', N'goods', N'3', N'商品详情')
GO


-- ----------------------------
-- Primary Key structure for table mdiy_tag
-- ----------------------------
ALTER TABLE [dbo].[mdiy_tag] ADD CONSTRAINT [PK__mdiy_tag__3213E83FB83AEC2F] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO

-- ----------------------------
-- Table structure for mdiy_tag_sql
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[mdiy_tag_sql]') AND type IN ('U'))
	DROP TABLE [dbo].[mdiy_tag_sql]
GO

CREATE TABLE [dbo].[mdiy_tag_sql] (
  [id] int NOT NULL,
  [tag_id] int NOT NULL,
  [tag_sql] nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [sort] int NULL
)
GO

ALTER TABLE [dbo].[mdiy_tag_sql] SET (LOCK_ESCALATION = TABLE)
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义标签编号',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_tag_sql',
'COLUMN', N'tag_id'
GO

EXEC sp_addextendedproperty
'MS_Description', N'自定义sql支持ftl写法',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_tag_sql',
'COLUMN', N'tag_sql'
GO

EXEC sp_addextendedproperty
'MS_Description', N'排序升序',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_tag_sql',
'COLUMN', N'sort'
GO

EXEC sp_addextendedproperty
'MS_Description', N'标签对应多个sql语句',
'SCHEMA', N'dbo',
'TABLE', N'mdiy_tag_sql'
GO

-- ----------------------------
-- Records of mdiy_tag_sql
-- ----------------------------
INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'5', N'3', N'select 
			basic_id AS id,
			LEFT (basic_title, ${titlelen ?default(40)}) AS title,
			basic_title AS fulltitle,
			article_author AS author,
			article_source AS source,
			article_content AS content,
			category.category_title AS typename,
			category.category_id AS typeid,
			<#--列表页动态链接-->
			<#if isDo?? && isDo>
			''/${modelName}/list.do?typeid=''+convert(varchar(50),category.category_id) as typelink,
			<#else>
			(SELECT ''index.html'') AS typelink,
			</#if>
			basic.basic_thumbnails AS litpic,
			<#--内容页动态链接-->
			<#if isDo?? && isDo>
			+''/mcms/view.do?id=''+convert(varchar(50),basic_id) as link,
			<#else>
			cms_article.article_url AS link,
			</#if>
			basic_datetime AS date,<#if tableNname??>${tableNname}.*,</#if>
			basic_description AS descrip,
			basic_hit AS hit,
			article_type AS flag,
			category_title AS typetitle,
			cms_article.article_keyword AS keyword
	<#if ispaging?? && pageNo??> <#--分页-->
			from
			( SELECT ROW_NUMBER ( ) OVER ( ORDER BY dbo.basic.basic_id DESC ) AS rownum, * FROM basic ) AS basic
			<#else>
			from basic 
		</#if>
		LEFT JOIN cms_article ON cms_article.article_basicid = basic.basic_id
		LEFT JOIN category ON basic_categoryid = category.category_id
		LEFT JOIN basic_column ON basic_column.column_category_id = basic.basic_categoryid 
	<#--判断是否有自定义模型表-->
	<#if tableNname??>LEFT JOIN ${tableNname} ON ${tableNname}.basicId=cms_article.article_basicid </#if>
		where
			1 = 1 <#if typeid??> and (basic_categoryid=${typeid} or basic_categoryid in 
	(select category_id FROM category where category.del=0 and CHARINDEX('',''+''${typeid}''+'','' , '',''+CATEGORY_PARENT_ID +'','')>0))</#if>
	<#--标题-->
	<#if basic_title??> and basic_title like ''%''+''${basic_title}''+''%'')</#if>
	<#--作者-->
	<#if article_author??> and article_author like ''%''+''${article_author}''+''%'')</#if>
	<#--来源-->
	<#if article_source??> and article_source like ''%''+''${article_source}''+''%'')</#if>
	<#--属性-->
	<#if article_type??> and article_type like ''%''+''${article_type}''+''%'')</#if>
	<#--图片-->
	<#if basic_thumbnails??> and basic_thumbnails like ''%''+''${basic_thumbnails}''+''%'')</#if>
	<#--描述-->
	<#if basic_description??> and basic_description like ''%''+''${basic_description}''+''%'')</#if>
	<#--关键字-->
	<#if article_keyword??> and article_keyword like ''%''+''${article_keyword}''+''%'')</#if>
	<#--内容-->
	<#if article_content??> and article_content like ''%''+''${article_content}''+''%'')</#if>
	<#--自定义顺序-->
	<#if article_freeorder??> and article_freeorder=${article_freeorder}</#if>
	<#if ispaging?? && pageNo??><#--分页-->
		and basic.rownum BETWEEN ${(pageNo?eval-1)*size?eval} AND ${size?default(20)}
	</#if>', N'1')
GO

INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'6', N'4', N'select category_id as id,category_id as typeid,category_title as typetitle,
<#--动态链接-->
    <#if isDo?? && isDo>
    ''/${modelName}/list.do?typeid=''+convert(varchar(50),category_id) as typelink,
    <#else>
column_path+''/index.html'' as typelink,
    </#if>column_keyword as typekeyword,column_descrip as typedescrip,category_smallimg as typelitpic  from category  
LEFT JOIN basic_column bc on bc.column_category_id=category.category_id where 
<#if type?has_content>
    <#--顶级栏目-->
    <#if type==''top''>
        <#if typeid??>
            category_categoryid=(select category_categoryid from category where category_id=(select category_categoryid from category  where category_id=${typeid}))    
        <#else>
            category_categoryid=0
        </#if>
    <#--同级栏目-->
    <#elseif type==''level''>
        <#if typeid??>
        category_categoryid=(select category_categoryid from category where category_id=${typeid})
        <#else>
         1=1
        </#if>
  <#--当前栏目-->
    <#elseif type==''self''>
         <#if typeid??>
         category_id=${typeid}
         <#else>
         1=1
         </#if>
    <#--子栏目-->
    <#elseif type==''son''>
         <#if typeid??>
         category_categoryid=${typeid}
         <#else>
         1=1
         </#if>
    </#if>
<#else> <#--默认son-->
    <#if typeid??>
    category_categoryid=${typeid}
    <#else>
    category_categoryid=0
    </#if>
</#if>', N'1')
GO

INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'7', N'5', N'select 
APP_NAME as name,
app_logo as logo,
app_keyword as keyword,
app_description as descrip,
app_copyright as copyright,
<#--动态解析 -->
<#if isDo?? && isDo>
''${url}'' as url,
''${url}'' as host,
<#--使用地址栏的域名 -->
<#elseif url??>
''${url}/${html}/''+app_id+''/<#if m??>${m}</#if>'' as url,
''${url}'' as host,
<#else>
REPLACE(<#-- 剔除换行符 -->
substring( app_url, 0, CHARINDEX ( CHAR ( 10 ), app_url ) ),CHAR ( 13 ),'''')+''/${html}/''+convert(varchar(50),app_id)+''/<#if m??>${m}</#if>'' as url, 
REPLACE(<#-- 剔除换行符 -->
substring( app_url, 0, CHARINDEX ( CHAR ( 10 ), app_url ) ),CHAR ( 13 ),'''') as host,
</#if>
''templets/''+convert(varchar(50),app_id)+''/''<#if m??>+app_style+''/${m}''<#else>+app_style</#if> as style <#-- 判断是否为手机端 -->
from app', N'1')
GO

INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'8', N'7', N'SELECT 
basic_id as id,
left(basic_title,${titlelen?default(40)}) as title,
basic_title as fulltitle,
article_author as author, 
article_source as source, 
article_content as content,
category.category_title as typename,
category.category_id as typeid,
<#--动态链接-->
<#if isDo?? && isDo>
''/${modelName}/list.do?typeid=''+convert(varchar(50),category.category_id) as typelink,
<#else>
(SELECT ''index.html'') as typelink,
</#if>
basic.basic_thumbnails as litpic,
<#--内容页动态链接-->
<#if isDo?? && isDo>
''/mcms/view.do?id=''+convert(varchar(50),basic_id) as link,
<#else>
cms_article.article_url AS link,
</#if>
basic_datetime as date,
basic_description as descrip,
basic_hit as hit,
article_type as flag,
category_title as typetitle,
<#if tableName??>${tableName}.*,</#if>
cms_article.article_keyword as keyword
FROM basic LEFT JOIN cms_article ON cms_article.article_basicid = basic.basic_id 
LEFT JOIN category ON basic_categoryid=category.category_id 
LEFT JOIN basic_column ON basic_column.column_category_id=basic.basic_categoryid
<#--判断是否有自定义模型表-->
<#if tableName??>left join ${tableName} on ${tableName}.basicId=cms_article.ARTICLE_BASICID</#if>
WHERE 
1=1
<#if id??> and basic_id=${id}</#if>', N'1')
GO

INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'9', N'8', N'<#assign select="(SELECT '''')"/>
<#if preId??>
SELECT 
basic_id as id,
left(basic_title,${titlelen?default(40)}) as title,
basic_title as fulltitle,
article_author as author, 
article_source as source, 
article_content as content,
category.category_title as typename,
category.category_id as typeid,
(SELECT ''index.html'') AS typelink,
basic.basic_thumbnails as litpic,
cms_article.article_url as link,
basic_datetime as date,
basic_description as descrip,
basic_hit as hit,
article_type as flag,
cms_article.article_keyword as keyword 
FROM basic LEFT JOIN cms_article ON cms_article.article_basicid = basic.basic_id 
LEFT JOIN category ON basic_categoryid=category.category_id 
LEFT JOIN basic_column ON basic_column.column_category_id=basic.basic_categoryid 
WHERE basic_id=${preId}
<#else><#--没有上一页返回空字符串-->
SELECT 
${select} as id,
${select} as title,
${select} as fulltitle,
${select} as author, 
${select} as source, 
${select} as content,
${select} as typename,
${select} as typeid,
${select} as typelink,
${select} as litpic,
${select} as link,
${select} as date,
${select} as descrip,
${select} as hit,
${select} as flag,
${select} as keyword FROM basic
</#if>', NULL)
GO

INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'10', N'9', N'  select
    <#--判断是否有栏目对象，用于搜索不传栏目-->
    <#if column??>
        <#--顶级栏目处理-->
        <#if column.categoryCategoryId==0>
            <#assign path=column.columnPath/>
        <#else>
            <#assign path=column.columnPath/>
        </#if>
    <#else>
        <#assign path=''''/>
    </#if>
  <#--总记录数、总页数-->
    (SELECT ${total}) as total,
    <#--记录总数-->
    (SELECT ${rcount}) as rcount,
    <#--当前页码-->
    (SELECT ${pageNo}) as cur,
    <#--首页-->
  ''${path}''+''/index.html'' as [index],
    <#--上一页-->
    <#if (pageNo?eval-1) gt 1>
    ''${path}''+''/list-${pageNo?eval-1}.html'' as pre,
    <#else>
    ''${path}''+''/index.html'' as pre,
    </#if>
    <#--下一页-->
    <#if total==1>
        ''${path}''+''/index.html'' as [next],
        ''${path}''+''/index.html'' as [last]
    <#else>
        <#if pageNo?eval gte total>
        ''${path}''+''/list-${total}.html'' as next,
        <#else>
        ''${path}''+''/list-${pageNo?eval+1}.html'' as [next],
        </#if>
        <#--最后一页-->
        ''${path}''+''/list-${total}.html'' as [last]
    </#if>', NULL)
GO

INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'11', N'10', N'<#assign select="(SELECT '''')"/>
<#if nextId??>
SELECT 
basic_id as id,
left(basic_title,${titlelen?default(40)}) as title,
basic_title as fulltitle,
article_author as author, 
article_source as source, 
article_content as content,
category.category_title as typename,
category.category_id as typeid,
(SELECT ''index.html'') as typelink,
basic.basic_thumbnails as litpic,
cms_article.article_url as link,
basic_datetime as date,
basic_description as descrip,
basic_hit as hit,
article_type as flag,
cms_article.article_keyword as keyword 
FROM basic LEFT JOIN cms_article ON cms_article.article_basicid = basic.basic_id 
LEFT JOIN category ON basic_categoryid=category.category_id 
LEFT JOIN basic_column ON basic_column.column_category_id=basic.basic_categoryid 
WHERE basic_id=${nextId}
<#else>
SELECT 
${select} as id,
${select} as title,
${select} as fulltitle,
${select} as author, 
${select} as source, 
${select} as content,
${select} as typename,
${select} as typeid,
${select} as typelink,
${select} as litpic,
${select} as link,
${select} as date,
${select} as descrip,
${select} as hit,
${select} as flag,
${select} as keyword FROM basic
</#if>', NULL)
GO

INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'13', N'12', N'SELECT
	basic_id AS id,
	product_price as price,
	product_cost_price AS costprice,
	product_content AS content,
	product_code AS code,
	<#--详情页动态链接-->
	<#if isDo?? && isDo>
	''/${modelName}/view.do?id=''+convert(varchar(50),basic_id) as link,
	<#else>
	product_linkUrl AS link,
	</#if>
	basic_title AS title,
	product_sale AS sale,
	product_good AS specification,
	product_inventory AS stock,
	basic.basic_categoryid AS typeid,
	basic_thumbnails AS litpic,
	<#--列表页动态链接-->
	<#if isDo?? && isDo>
	''/mmall/list.do?typeid=''+convert(varchar(50),category.category_id) as typelink,
	<#else>
	(SELECT ''index.html'') AS typelink,
	</#if>
	<#--判断是否有自定义模型表-->
	<#if tableNname??>${tableNname}.*,</#if>
	category_title AS typetitle
FROM
	mall_product 
	LEFT JOIN basic ON mall_product.product_basicID = basic.basic_id
	LEFT JOIN category ON basic_categoryid = category.category_id
	<#--判断是否有自定义模型表-->
	<#if tableNname??>LEFT JOIN ${tableNname} ON ${tableNname}.basicId=mall_product.product_basicID </#if>
WHERE
	1 = 1 <#--查询栏目-->
	<#if (typeid)??> and (basic_categoryid=${typeid} or basic_categoryid in 
	(select category_id FROM category where CHARINDEX('',''+''${categoryId}''+'','' , '',''+CATEGORY_PARENT_ID +'','')>0))
	</#if>
	<#--模糊查询商品标题-->
	<#if basic_title??> and basic_title like ''%''+''${basic_title}''+''%''</#if> 
	LIMIT <#--判断是否分页-->
	<#if ispaging?? && pageNo??>${(pageNo?eval-1)*size?eval},${size?default(20)}
	<#else>${size?default(20)}</#if>', NULL)
GO

INSERT INTO [dbo].[mdiy_tag_sql]  VALUES (N'14', N'13', N'SELECT
	basic_id AS id,
	product_price as price,
	product_cost_price AS costprice,
	product_content AS content,
	product_code AS code,
	<#--详情页动态链接-->
	<#if isDo?? && isDo>
	CONCAT("/${modelName}/view.do?id=", basic_id) as link,
	<#else>
	product_linkUrl AS link,
	</#if>
	basic_title AS title,
	product_sale AS sale,
	product_good AS specification,
	product_inventory AS stock,
	basic.basic_categoryid AS typeid,
	basic_thumbnails AS litpic,
	<#--列表页动态链接-->
	<#if isDo?? && isDo>
	CONCAT("/mmall/list.do?id=", category.category_id) as typelink,
	<#else>
	(SELECT "index.html") AS typelink,
	</#if>
	<#--判断是否有自定义模型表-->
	<#if tableNname??>${tableNname}.*,</#if>
	category_title AS typetitle
FROM
	mall_product 
	LEFT JOIN basic ON mall_product.product_basicID = basic.basic_id
	LEFT JOIN category ON basic_categoryid = category.category_id
	LEFT JOIN basic_column ON basic_column.column_category_id = basic.basic_categoryid
	<#--判断是否有自定义模型表-->
	<#if tableNname??>LEFT JOIN ${tableNname} ON ${tableNname}.basicId=mall_product.product_basicID </#if>
WHERE
	1 = 1 <#if id??> and basic_id=${id} </#if>', NULL)
GO


-- ----------------------------
-- Indexes structure for table mdiy_tag_sql
-- ----------------------------
CREATE NONCLUSTERED INDEX [fk_mdiy_tag_id]
ON [dbo].[mdiy_tag_sql] (
  [tag_id] ASC
)
GO


-- ----------------------------
-- Primary Key structure for table mdiy_tag_sql
-- ----------------------------
ALTER TABLE [dbo].[mdiy_tag_sql] ADD CONSTRAINT [PK__mdiy_tag__3213E83F3CD78087] PRIMARY KEY CLUSTERED ([id])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)  
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table mdiy_tag_sql
-- ----------------------------
ALTER TABLE [dbo].[mdiy_tag_sql] ADD CONSTRAINT [mdiy_tag_sql_ibfk_1] FOREIGN KEY ([tag_id]) REFERENCES [mdiy_tag] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Records of role_model
-- ----------------------------


INSERT INTO [role_model]  VALUES (N'153', N'48')
GO

INSERT INTO [role_model]  VALUES (N'154', N'48')
GO

INSERT INTO [role_model]  VALUES (N'155', N'48')
GO

INSERT INTO [role_model]  VALUES (N'156', N'48')
GO

INSERT INTO [role_model]  VALUES (N'157', N'48')
GO

INSERT INTO [role_model]  VALUES (N'158', N'48')
GO

INSERT INTO [role_model]  VALUES (N'159', N'48')
GO

INSERT INTO [role_model]  VALUES (N'160', N'48')
GO

INSERT INTO [role_model]  VALUES (N'161', N'48')
GO
