# 铭飞业务系统开发基础平台
当前版本:4.7.0 <br/>
铭飞MS官网:http://ms.mingsoft.net<br/>
官网同时提供一键运行版本下载，请步移官网....<br/>
QQ交流群号： ①242805203 ②231212174（满） ③221335098（满） <br/>
很多人说铭飞MCMS是大天朝国唯一完整开源的J2EE系统！团队希望看到更多的优秀好用的开源系统，我们一直会努力下去！
# 特点 
* 免费完整开源：基于MIT协议，源代码完全开源，无商业限制,MS开发团队承诺将MCMS内容系统永久完整开源；<br/>
* 标签化建站：不需要专业的后台开发技能，只要使用系统提供的标签，就能轻松建设网站；<br/>
* html静态化：系统支持全站静态化；<br/>
* 跨终端：站点同时支持PC与移动端访问，同时会自动根据访问的终端切换到对应的界面，数据由系统统一管理；<br/>
* 海量模版：铭飞通过MStore（MS商城）分享更多免费、精美的企业网站模版，降低建站成本；<br/>
* 丰富插件：为了让MCms适应更多的业务场景，在MStore用户可以下载对应的插件，如：站群插件、微信插件、商城插件等；<br/>
* 每月更新：铭飞团队承诺每月28日为系统升级日，分享更多好用等模版与插件；<br/>
* 文档丰富：为了让用户更快速的使用MCms系统进行开发，铭飞团队持续更新开发相关文档，如标签文档、使用文档、视频教程等；<br/>
# 面向对象
* 铭飞MCMS是企业在创立初期很好的技术基础框架，加快公司项目开发进度，当然也可以对现有的系统进行升级；
* 个人开发者也可以使用MCMS承接外包项目；
* 初学JAVA的同学可以下载源代码来进行学习交流；

# 技术框架
* 核心框架：Spring Boot 2
* 安全框架：Apache Shiro 1.2
* 持久层框架：MyBatis 3
* 数据库连接池：Alibaba Druid 1.0
* 日志管理：SLF4J 1.7、Log4j
* JS框架：jQuery 1.10
* CSS框架：Twitter Bootstrap 2.3.1。
* 富文本：Ueditor

#
## 后端框架

| 技术 | 名称 | 官网 |
| :--- | :--- | :--- |
| Spring Framework | 容器 | [http://projects.spring.io/spring-framework](http://projects.spring.io/spring-framework/) |
| SpringMVC | MVC框架 | [http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/\#mvc](http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/#mvc) |
| Apache Shiro | 安全框架 | [http://shiro.apache.org](http://shiro.apache.org/) |
| Spring session | 分布式Session管理 | [http://projects.spring.io/spring-session](http://projects.spring.io/spring-session) |
| MyBatis | ORM框架 | [http://www.mybatis.org](http://www.mybatis.org/mybatis-3/zh/index.html) |
| PageHelper | MyBatis分页插件 | [http://git.oschina.net/free/Mybatis\_PageHelper](http://git.oschina.net/free/Mybatis_PageHelper) |
| Log4J | 日志组件 | [http://logging.apache.org](http://logging.apache.org) |
| Maven | 项目构建 | [http://maven.apache.org](http://maven.apache.org/) |
| Elasticsearch | 分布式搜索引擎 | [https://www.elastic.co](https://www.elastic.co/) |
| Redis | 分布式缓存数据库 | [https://redis.io](https://redis.io) |

### 前端框架

| 技术 | 名称 | 官网 |
| :--- | :--- | :--- |
| jQuery | 函式库 | [http://jquery.com/](http://jquery.com/) |
| Bootstrap | 前端框架 | [http://getbootstrap.com/](http://getbootstrap.com/) |
| Bootstrap-table | Bootstrap数据表格 | [http://bootstrap-table.wenzhixin.net.cn/](http://bootstrap-table.wenzhixin.net.cn/) |
| BootstrapValidator | 表单验证 | [http://bootstrapvalidator.com/](http://bootstrapvalidator.com) |
| Font-awesome | 字体图标 | [http://fontawesome.io/](http://fontawesome.io/) |
| Waves | 点击效果插件 | [https://github.com/fians/Waves/](https://github.com/fians/Waves) |
| zTree | 树插件 | [http://www.treejs.cn/v3/](http://www.treejs.cn/v3/) |
| Select2 | 选择框插件 | [https://github.com/select2/select2](https://github.com/select2/select2) |
| jQuery EasyUI | 基于jQuery的UI插件集合体 | [http://www.jeasyui.com/](http://www.jeasyui.com) |
| Vue | MVVM框架 | [https://cn.vuejs.org/](https://cn.vuejs.org/) |
| AmazeUI | 移动端UI | [http://amazeui.org/](http://amazeui.org/) |
| Plupload | 上传控件 | [http://www.plupload.com/](http://www.plupload.com/) |
| freemarker | 模板引擎 | http://freemarker.foofun.cn/toc.html |

# 系统结构
![输入图片说明](http://doc.ms.mingsoft.net/dev-guide/%E9%93%AD%E9%A3%9E%E5%BA%95%E5%B1%82%E6%95%B4%E4%BD%93%E7%BB%93%E6%9E%84%E5%9B%BE/%E6%95%B4%E4%BD%93%E7%BB%93%E6%9E%84.png "铭飞系统结构")

# 开发环境
建议开发者使用以下环境，这样避免版本带来的问题
* IDE:eclipse
* DB:Mysql5.7
* JDK:JAVA 8
* WEB:Tomcat8

# 运行环境
* WEB服务器：Weblogic、Tomcat、WebSphere、JBoss、Jetty 等
* 数据库服务器：Mysql5.7
* 操作系统：Windows、Linux、Unix 等


# 快速体验
* 将MCMS项目源码导入eclipse；
* 创建数据库db-mcms-open,注意：数据库使用utf-8编码，导入doc/db-mcms-open-4.6.3.sql,＊-up-*.sql表示sql升级补丁是手动升级包，如果导入了系统对应的完整版SQL，sql升级补丁不需要重复导入； 
* 修改src\main\resources\application-dev.yml文件中的数据库设置参数；
* 首先先访问后台地址：http://ip|域名/项目发布名/ms/login.do <font color="red">，进入后台点击内容管理->静态化菜单，进行"生成主页"，"生成栏目","生成文章"操作
* 管理员账号，用户名：msopen 密码：msopen

# 文件说明 
* .externalToolBuilders eclipse缓存文件
* .settings  eclipse配置缓存文件
* doc  项目文档文件夹，里面有数据库文件
* src/main maven结构的项目源代码  
* java/com/mingsoft java源代码文件
* resources 项目的资源配置文件
* webapp<br/>
   	 META-INF <br/>
	 WEB-INF <br/>
	 	 manager <br/>
	 html/1 <font color="red">默认生成的静态代码，实际项目需要删除，只是提供给开发者快速预览生成后的静态页面</font><br/>
	 templets/1/mooc  <font color="red">默认模版</font><br/>
	 upload  <br/>
*   target  临时文件，可以删除让maven自动生成
* .classpath eclipse配置缓存文件
* .project  eclipse配置缓存文件
* LICENSE 项目协议说明
* README.md 项目说明文档
* pom.xml maven的依赖配置文件

# 代码部署与常见问题
* 铭飞MCms 部署视频 http://ms.mingsoft.net/mbbs/13988/detail.do
* MCms环境配置常见问题  http://ms.mingsoft.net/mbbs/13000/detail.do
* MStore使用方式：http://ms.mingsoft.net/mbbs/13008/detail.do

# 文档
* MCms标签手册 http://doc.ms.mingsoft.net/mcms-tag-guide
* 快速开发手册 http://doc.ms.mingsoft.net/dev-guide/


# 开源说明
* 系统100%开源
* 铭飞MCms是铭飞MS平台的一个子模块，同时铭飞MCms所依赖的模块都是用maven方式提供了源码获取方式,具体看pom.xml

```
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-base</artifactId>
			<version>${ms.base.version}</version>
		</dependency>
		<!-- ms-base源码jar包 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-base</artifactId>
			<version>${ms.base.version}</version>
			<classifier>sources</classifier>
			<scope>provided</scope>
		</dependency>

		<!-- ms-basic基础模块war包，包含后台管理的基础功能 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-basic</artifactId>
			<version>${ms.basic.version}</version>
			<type>war</type>
		</dependency>
		<!-- ms-basic源码jar包 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-basic</artifactId>
			<version>${ms.basic.version}</version>
			<classifier>sources</classifier>
			<scope>provided</scope>
		</dependency>

		<!-- ms-basic开发依赖，主要方便业务开发 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-basic</artifactId>
			<version>${ms.basic.version}</version>
			<classifier>classes</classifier>
			<scope>provided</scope>
		</dependency>

		<!-- ms-mdiy自定义模块，自定义表单、自定义搜索、自定义页面等 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-mdiy</artifactId>
			<version>${ms.mdiy.version}</version>
			<type>war</type>
		</dependency>
		<!-- ms-mdiy自定义模块源码 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-mdiy</artifactId>
			<version>${ms.mdiy.version}</version>
			<classifier>sources</classifier>
			<scope>provided</scope>
		</dependency>
		<!-- ms-mdiy开发依赖，主要方便业务开发 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-mdiy</artifactId>
			<version>${ms.mdiy.version}</version>
			<classifier>classes</classifier>
			<scope>provided</scope>
		</dependency>

		<!-- ms-mpeople用户模块，包含用户的常规功能，详细描述见MStore -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-mpeople</artifactId>
			<version>${ms.mpeople.version}</version>
			<type>war</type>
		</dependency>
		<!-- ms-mpeople用户模块源码 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-mpeople</artifactId>
			<version>${ms.mpeople.version}</version>
			<classifier>sources</classifier>
			<scope>provided</scope>
		</dependency>
		<!-- ms-mpeople开发依赖，主要方便业务开发 -->
		<dependency>
			<groupId>net.mingsoft</groupId>
			<artifactId>ms-mpeople</artifactId>
			<version>${ms.mpeople.version}</version>
			<classifier>classes</classifier>
			<scope>provided</scope>
		</dependency>
```
# 系统美图
![输入图片说明](http://git.oschina.net/uploads/images/2015/1029/110523_6727b755_542665.jpeg "铭飞模版商城，模版商城")
![输入图片说明](http://git.oschina.net/uploads/images/2015/1108/143215_21e5f30a_542665.png "铭飞模版商城，插件商城")
![输入图片说明](http://git.oschina.net/uploads/images/2015/1029/105109_bf9db869_542665.png "铭飞内容管理系统后台演示")
