
<p align="center">
	<a href="https://ms.mingsoft.net/"><img src="http://ms.mingsoft.net/templets/1/ms/images/logo-blue.png" ></a>
</p>
<p align="center">
	<strong>价值源自分享</strong>
</p>
<p align="center">
	<a target="_blank" href="https://search.maven.org/search?q=ms-mcms">
        <img src="https://img.shields.io/maven-central/v/net.mingsoft/ms-mcms.svg?label=Maven%20Central" />
	</a>
	<a target="_blank" href="hhttps://baike.baidu.com/item/MIT%E8%AE%B8%E5%8F%AF%E8%AF%81/6671281?fr=aladdin">
        <img src="https://img.shields.io/:license-MIT-blue.svg" />
	</a>
	<a target="_blank" href="https://www.oracle.com/technetwork/java/javase/downloads/index.html">
		<img src="https://img.shields.io/badge/JDK-8+-green.svg" />
	</a>
	<a target="_blank" href="https://gitee.com/mingSoft/MCMS/stargazers">
		<img src="https://gitee.com/mingSoft/MCMS/badge/star.svg?theme=dark" alt='gitee star'/>
	</a>
	<a target="_blank" href='https://github.com/ming-soft/mcms'>
		<img src="https://img.shields.io/github/stars/ming-soft/mcms.svg?style=social" alt="github star"/>
	</a>
	
</p>
<p align="center">
	<a href="https://ms.mingsoft.net" target="_blank">铭飞平台</a> 
	<a href="http://demo.cms.mingsoft.net/ms/login.do"  target="_blank">在线演示</a> 
	<a href="http://doc.ms.mingsoft.net/plugs-cms/"  target="_blank">在线使用手册</a>
	<a href="https://mingsoft.ke.qq.com/?tuin=383187f3#tab=1&category=-1" target="_blank">腾讯课堂在线视频</a><br/>
	<a href="https://ke.qq.com/course/478498"  target="_blank">代码生成器视频教程</a><br/>
	<a href="http://file.mingsoft.net/ms-runner-5.0.0.zip"  target="_blank">Windows一键运行版本\Linux一键运行版本</a>
</p>

-------------------------------------------------------------------------------

很多人说铭飞是大天朝国唯一完整开源的J2EE系统！团队希望看到更多的优秀好用的开源系统，我们一直会努力下去！<br/>

QQ交流群号：[![加入QQ群](https://img.shields.io/badge/一群-231212174-blue.svg)](https://jq.qq.com/?_wv=1027&k=5zykX7V)  [![加入QQ群](https://img.shields.io/badge/二群-221335098-blue.svg)](https://jq.qq.com/?_wv=1027&k=56BqFKu) [![加入QQ群](https://img.shields.io/badge/三群-242805203-blue.svg)](https://jq.qq.com/?_wv=1027&k=5oF19sl)


# 开源说明
* 系统100%开源
* 模块化开发模式，铭飞所开发的模块都发布到了maven中央库。 可以通过pom.xml文件的方式拉取源代码

```
<dependency>
	<groupId>net.mingsoft</groupId>
	<artifactId>模块</artifactId>
	<version>版本号</version>
	<classifier>sources</classifier>
	<scope>provided</scope>
</dependency>
```
# 商用
基于[MIT](https://www.oschina.net/question/12_2829)开源协议，可直接商用无需授权，但请尊重开源精神不要去掉代码中铭飞的注释和版权信息


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
* 企 业：帮助创立初期的公司或团队快速搭建产品的技术平台，加快公司项目开发进度；
* 开发者：帮助开发者快速完成承接外包的项目，避免从零搭建系统；
* 学习者：初学JAVA的同学可以下载源代码来进行学习交流；

# 开发环境
建议开发者使用以下环境，这样避免版本带来的问题
* Windows、Linux
* Eclipse、Idea
* Mysql≧5.7
* JDK≧8
* Tomcat≧8


# 快速体验（导入到 Eclipse 或 IDEA）

1、检出源代码：
git clone https://gitee.com/mingSoft/MCMS.git<br/>
2、导入项目<br/>
* Eclipse导入，菜单 File -> Import，然后选择 Maven -> Existing Maven Projects，点击 Next> 按钮，选择检出的项目MCMS文件夹，然后点击 Finish 按钮，即可成功导入
* IDEA导入，点击 Import Project，选择 pom.xml 文件，点击 Next 按钮，选择 Import Maven projects automatically 复选框，然后一直点击 Next 按钮，直到点击 Finish 按钮，即可成功导入<br/>

4、Eclipse（IDEA）会自动加载 Maven 依赖包，初次加载会比较慢（根据自身网络情况而定），若工程上有小叉号，请打开 Problems 窗口，查看具体错误内容，直到无错误为止<br/>
5、创建数据库db-mcms-open（数据库使用utf-8编码），导入doc/db-mcms-open-版本号.sql，如果升级现有系统请使用＊-up-*.sql升级，如果导入了系统对应的完整版SQL，sql升级补丁不需要重复导入；<br/>
6、修改src\main\resources\application-dev.yml文件中的数据库设置参数；<br/>
7、运行MSApplication.java main方法<br/>
8、首先先访问后台地址：http://ip|域名/项目发布名/ms/login.do，管理员账号，用户名：msopen 密码：msopen，进入后台点击内容管理->静态化菜单，进行"生成主页"，"生成栏目","生成文章"操作一遍 （注意！！！是后台登录界面，不是会员中心登录界面）


# 技术选型

## 后端框架

| 技术 | 名称 | 官网 |
| :--- | :--- | :--- |
| Spring Framework | 容器 | [http://projects.spring.io/spring-framework](http://projects.spring.io/spring-framework/) |
| Spring Boot | MVC框架 | [https://spring.io/projects/spring-boot](https://spring.io/projects/spring-boot) |
| Apache Shiro | 安全框架 | [http://shiro.apache.org](http://shiro.apache.org/) |
| Spring session | 分布式Session管理 | [http://projects.spring.io/spring-session](http://projects.spring.io/spring-session) |
| MyBatis | ORM框架 | [http://www.mybatis.org](http://www.mybatis.org/mybatis-3/zh/index.html) |
| Freemarker | 视图框架 | [http://freemarker.foofun.cn](http://freemarker.foofun.cn/) |
| PageHelper | MyBatis分页插件 | [http://git.oschina.net/free/Mybatis\_PageHelper](http://git.oschina.net/free/Mybatis_PageHelper) |
| Log4J | 日志组件 | [http://logging.apache.org](http://logging.apache.org) |
| Maven | 项目构建 | [http://maven.apache.org](http://maven.apache.org/) |
| Elasticsearch | 分布式搜索引擎 | [https://www.elastic.co](https://www.elastic.co/) |
| Redis | 分布式缓存数据库 | [https://redis.io](https://redis.io) |
| hutool | 工具类 | [http://hutool.mydoc.io](http://hutool.mydoc.io) |

## 前端框架

| 技术 | 名称 | 官网 |
| :--- | :--- | :--- |
| vue| 函式库 | [https://cn.vuejs.org//](https://cn.vuejs.org//) |
| element ui| UI库 | [https://element.eleme.cn/2.0/#/zh-CN](https://element.eleme.cn/2.0/#/zh-CN) |
| jQuery | 函式库 | [http://jquery.com/](http://jquery.com/) |
| Bootstrap | 前端框架 | [http://getbootstrap.com/](http://getbootstrap.com/) |
| Bootstrap-table | Bootstrap数据表格 | [http://bootstrap-table.wenzhixin.net.cn/](http://bootstrap-table.wenzhixin.net.cn/) |
| BootstrapValidator | 表单验证 | [http://bootstrapvalidator.com/](http://bootstrapvalidator.com) |
| Font-awesome | 字体图标 | [http://fontawesome.io/](http://fontawesome.io/) |
| Waves | 点击效果插件 | [https://github.com/fians/Waves/](https://github.com/fians/Waves) |
| zTree | 树插件 | [http://www.treejs.cn/v3/](http://www.treejs.cn/v3/) |
| Select2 | 选择框插件 | [https://github.com/select2/select2](https://github.com/select2/select2) |
| Vue | MVVM框架 | [https://cn.vuejs.org/](https://cn.vuejs.org/) |
| AmazeUI | 移动端UI | [http://amazeui.org/](http://amazeui.org/) |
| Plupload | 上传控件 | [http://www.plupload.com/](http://www.plupload.com/) |
| freemarker | 模板引擎 | [http://freemarker.foofun.cn/toc.html](http://freemarker.foofun.cn/toc.html) |
| validator | 验证库 | [https://github.com/chriso/validator.js](https://github.com/chriso/validator.js) |
| animate | 动画 | [http://daneden.github.io/animate.css/](http://daneden.github.io/animate.css/) |
| icon | 矢量小图标\(待更新\) | [http://ms.mingsoft.net/html/86//6048/index.html](http://ms.mingsoft.net/html/86//6048/index.html) |


# 文件说明 
* doc 项目文档文件夹，里面有数据库文件
* src/main/java java源代码
* src/main/resources 项目的资源配置文件
* src/main/webapp
* src/main/webapp/static 静态资源文件，如：js、css、image、等第三方前端插件库
* src/main/webapp/html 生成的静态页面，实际项目需要删除，只是提供给开发者快速预览生成后的静态页面
* src/main/webapp/templets 模版文件夹
* src/main/webapp/upload 上传资源文件夹
* src/main/webapp/WEB-INF/manager 后端视图页面
* LICENSE 项目协议说明
* README.md 项目说明文档
* pom.xml 依赖配置文件



# 文档
* MCms标签手册 http://doc.ms.mingsoft.net/mcms-tag-guide
* 快速开发手册 http://doc.ms.mingsoft.net/dev-guide/

# 软件截图

<table>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/121402_82521059_1795833.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/120836_8a943ad5_1795833.png"/></td>
    </tr>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/120927_8a3f93e3_1795833.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/120939_7e5281db_1795833.png"/></td>
    </tr>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/120951_9d3a50b2_1795833.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/121003_9c68e090_1795833.png"/></td>
    </tr>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/121020_34c8e0ab_1795833.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/121033_b425e406_1795833.png"/></td>
    </tr>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/121044_41cc0d00_1795833.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/121059_48b4cd7b_1795833.png"/></td>
    </tr>
     <tr>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/121112_8581de9a_1795833.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2019/0523/121122_8b513dd1_1795833.png"/></td>
    </tr>
</table>

# 铭飞平台

做开源我们是业余的，写代码我们是认真的。研发产品的路上我们一直在探索、一直在学习、一直在用心投入，希望能给更多的企业与开发者提供一些更有价值的服务。

## 项目管理

<table>
	<tr>
		<td><img src="http://ms.mingsoft.net/upload/1/article/1572421127803.gif"/></td>
	</tr>
	<tr>
		<td><img src="http://ms.mingsoft.net/upload/1/article/1572421308885.gif"/></td>
	</tr>	
</table>

## 代码生成器

<table>
	<tr>
		<td><img src="http://ms.mingsoft.net/upload/1/article/1572419454270.gif"/></td>
	</tr>
	<tr>
		<td><img src="http://ms.mingsoft.net/upload/1/article/1572419347761.gif"/></td>
	</tr>	
</table>






