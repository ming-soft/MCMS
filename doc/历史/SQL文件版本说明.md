# 温馨提示，请使用master分支
db-mcms-mysql-4.7.0 最低版本mysql 5.7
db-mcms-sqlserver-4.7.0 最低版本 SQLServer2012

如果使用低与要求版本数据库会出现如下错误
1、导入 mysql文件 datetime时间函数报错，请使用4.6.5版本以下的SQL文件（不包含4.6.5）
2、SQLServer数据库版本 自定义标签 使用了SQLServer2012最新的分页函数 ，
	请自行修改mdiy_tag_sql表中的分页函数
	
数据库类型切换 ：修改application.yml中	
	database-id: mysql、sqlServer、oracle
数据库连接切换：修改
spring:
  http.multipart.enabled: false
  profiles:
    active: dev、prod、test