# 安装与部署

本文件给任何编程助手使用。环境以这个仓库为准：Java 17、Spring Boot 3.5.11、MySQL、启动类 `net.mingsoft.MSApplication`。完整手册在 http://doc.mingsoft.net/server/ 。不要编造本仓库没有的脚本或表结构。

生产密码、证书密码只改运行机器上的配置，不要写进仓库，也不要写进对话记录。

## 本地启动

1. 安装 JDK 17 和 Maven。数据库用 MySQL，库字符集 `utf8mb4`，时区 `Asia/Shanghai`。连接串已带 `serverTimezone=Asia/Shanghai`，库的时区要一致。
2. 建库名默认 `mcms`。脚本是仓库根目录 README 里的 `mcms-dev.sql.zip`。工作区里没有这个文件时，向用户要脚本再导入，不要自己写一套建表语句。城市表数据和现成皮肤从 MStore 或官网获取，见 [mstore.md](mstore.md)。
3. 改 `ms-mcms/src/main/resources/application-dev.yml` 的地址、账号、密码。`application.yml` 里 `spring.profiles.active` 默认是 `dev`。
4. 用 `ms-mcms` 目录作为进程工作目录，运行 `MSApplication`。工作目录指到仓库根或其他模块时，后台 404，模板管理也是空的。
5. 后台是 `http://localhost:8080/ms/login.do`。端口是 `server.port`，后台前缀是 `ms.manager.path`。本地默认账号写在仓库根目录 README 里，上线前改掉。

在仓库根目录编译：`mvn -pl ms-mcms -am package`。可执行包是 `ms-mcms/target/ms-mcms.jar`。

## 生产用 jar

优先 jar，不要为了部署改成 war。war 只在必须使用国产中间件、且用户明确要求时再考虑，并按手册处理 jar 加载顺序。本仓库 `ms-mcms/pom.xml` 当前按 jar 打包。

打包前在 `ms-mcms/pom.xml` 的 `src/main/webapp` 资源里放开这些排除，再在仓库根目录执行 `mvn clean package`：

- `static/`、`html/`、`upload/`、`template/`
- 需要在服务器上直接改后台页面时，再排除 `WEB-INF/`

只部署 `ms-mcms.jar`。在 jar 旁边建目录，并从这个目录执行 `java -jar ms-mcms.jar`：

| 目录或文件 | 作用 |
|---|---|
| `config/` | 从 `src/main/resources` 复制出来的 yml。同名配置优先于 jar 内部 |
| `template/` | 必须有。从 `src/main/webapp/template` 复制 |
| `upload/` | 必须有，可先为空目录 |
| `static/` | 静态资源。排除出 jar 后要复制出来 |
| `WEB-INF/` | 排除出 jar 后才需要复制 |
| `html/` | 静态化生成，可为空，运行后自动写 |

`config/application.yml` 里把 `spring.profiles.active` 改为 `prod`，并改 `application-prod.yml` 的数据源。同时做这些事：

- 修改数据库账号密码，以及后台管理员密码。
- 修改 `ms.manager.path`，不要继续用默认 `/ms`。
- `springdoc.api-docs.enabled` 和 `springdoc.swagger-ui.enabled` 都设为 `false`。
- 不要打开 Druid 监控页，`stat-view-servlet.enabled` 保持 `false`。
- 上传目录、模板目录用目录名，不要写成任意绝对路径。已有上传文件时不要改 `ms.upload.mapping`。

更新程序时替换 jar，保留 `template`、`upload`、`html`、`config`。不要用新的空目录盖掉已有上传和已生成页面。

## Nginx

静态页和上传文件由 Nginx 直接读 jar 所在目录，`.do` 请求转发到本机 `8080`。`/WEB-INF/` 禁止对外访问。

生成的栏目、文章链接依赖 Host。外网端口和 `server.port` 不一致时，反代要带上浏览器实际访问的主机和端口，否则后台预览和静态化地址会错。

项目名 `server.servlet.context-path` 若不是 `/`，Nginx 路径和模板里的 `{ms:global.contextpath/}` 要一起改。

## Docker

目录仍按上一节的 jar 布局放到宿主机，例如 `/data/mcms`，再挂进容器。MySQL 使用 `utf8mb4`。Linux 上若表名大小写和脚本不一致，把 `lower_case_table_names` 设为 `1` 后再初始化数据，已有数据的库不要中途改这个参数。

镜像名、网段、root 密码以当时的部署手册为准，不要沿用手册示例里的密码。
