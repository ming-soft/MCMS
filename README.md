<p align="center">
  <a href="https://www.mingsoft.net/" target="_blank" rel="noopener">
    <img src="https://cdn.mingsoft.net/global/images/logo-blue.png" alt="铭飞 MCms 开源 Java 内容管理系统" width="64" height="64">
  </a>
</p>

<h1 align="center">MCms — 开源 Java 内容管理系统</h1>

<p align="center">
  <strong>让内容管理更简单，让开发与分享创造更多价值。</strong>
</p>

<p align="center">
  MCms 是一款基于 Java 技术栈的开源内容管理系统，面向企业官网建设、内容管理和业务开发场景。
  除了内容管理能力，还提供可视化皮肤设计、代码生成以及模板和插件扩展能力，
  帮助企业和开发者更高效地搭建网站、扩展业务。
</p>

<p align="center">
  <a href="https://search.maven.org/search?q=ms-MCms" target="_blank" rel="noopener">
    <img src="https://img.shields.io/maven-central/v/net.mingsoft/ms-mcms.svg?label=Maven%20Central" alt="Maven Central 版本">
  </a>
  <a href="https://baike.baidu.com/item/MIT%E8%AE%B8%E5%8F%AF%E8%AF%81/6671281" target="_blank" rel="noopener">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License">
  </a>
  <a href="https://gitee.com/mingSoft/MCms/stargazers" target="_blank" rel="noopener">
    <img src="https://gitee.com/mingSoft/MCms/badge/star.svg?theme=dark" alt="Gitee Stars">
  </a>
  <a href="https://github.com/ming-soft/MCms" target="_blank" rel="noopener">
    <img src="https://img.shields.io/github/stars/ming-soft/MCms.svg?style=social" alt="GitHub Stars">
  </a>
  <img src="https://img.shields.io/badge/JDK-17%2B-green.svg" alt="JDK 17+">
</p>

<p align="center">
  <a href="#核心能力">核心能力</a> ·
  <a href="#快速开始">快速开始</a> ·
  <a href="#技术架构">技术架构</a> ·
  <a href="#国产化与信创适配">国产化与信创</a> ·
  <a href="#安全建设与等保支持">安全与等保</a> ·
  <a href="#生态工具">生态工具</a> ·
  <a href="#文档与支持">文档与支持</a>
</p>

<p align="center">
  <a href="https://a.cms.demo.mingsoft.net/ms/login.do" target="_blank" rel="noopener">后台演示</a> ·
  <a href="https://a.cms.demo.mingsoft.net/" target="_blank" rel="noopener">前台演示</a> ·
  <a href="https://doc.mingsoft.net/MCms/" target="_blank" rel="noopener">在线文档</a> ·
  <a href="https://space.bilibili.com/1825880395" target="_blank" rel="noopener">视频教程</a>
</p>

---


## QQ 技术交流群

欢迎开发者交流使用问题、开发经验和功能建议。部分群聊已满，请优先选择仍可加入的群。


[![加入QQ群](https://img.shields.io/badge/QQ一群(已满)-231212174-red.svg?logo=tencentqq&style=for-the-badge)](https://qm.qq.com/cgi-bin/qm/qr?k=FVvyoF1YwtFpCGLf--h42_AwtF6JOD9M&jump_from=webapi&authKey=EyNayGyX0U/6hJKtpBInh9FsCpeM8Vx2KqrmmCZyXe3f1PD5kboChBSIWkB6SOb5)
[![加入QQ群](https://img.shields.io/badge/QQ二群(已满)-221335098-red.svg?logo=tencentqq&style=for-the-badge)](https://qm.qq.com/cgi-bin/qm/qr?k=fedNH1fR6niG16cYVPXPZJ3U8m9Hfxaf&jump_from=webapi&authKey=6rMUTyta7sKlSpeF/fYkVHp6mF9sZc6i5vmHzGgdh6WHW34yww5eDBXJwCVmoMyl)
[![加入QQ群](https://img.shields.io/badge/QQ三群(已满)-242805203-red.svg?logo=tencentqq&style=for-the-badge)](https://qm.qq.com/cgi-bin/qm/qr?k=1K_RsMwZcf09Y-_74PhA_NfI85RqeDyK&jump_from=webapi&authKey=vCeXrE2f5QCobzDFZ4lHzHyH7sGtmhVfR326MjEmeMy6u0NgHlIglCCxD/6b7tEK)
[![加入QQ群](https://img.shields.io/badge/QQ四群(已满)-881894877-red.svg?logo=tencentqq&style=for-the-badge)](https://qm.qq.com/cgi-bin/qm/qr?k=TzRiJf4x7tZsjKEzo8EuwuHqTALc0xCA&jump_from=webapi&authKey=04YpueACppV1tLykhOQ+fdzPhPwOkIU685LgCOQqrwEjtVQCOvTAyd6qn3xAiXl2)
[![加入QQ群](https://img.shields.io/badge/QQ五群(已满)-231211521-red.svg?logo=tencentqq&style=for-the-badge)](https://qm.qq.com/cgi-bin/qm/qr?k=IfVdHXCm13Ui6NrcjvrraFkGsI8L3U1r&jump_from=webapi&authKey=Go37VdoKublA0p47ww9fS+fxt2DAh1URslG0/7ugg8zs1b+heVlGZwkASM/PlJPG)
[![加入QQ群](https://img.shields.io/badge/QQ六群-527579891-red.svg?logo=tencentqq&style=for-the-badge)](https://qm.qq.com/cgi-bin/qm/qr?k=9ABLBuNghNaL5_IhGg9au-3vw4kkey8Y&jump_from=webapi&authKey=Ss0dwGvqEbAdomp5y5qcQNYTNT00Z8Zxkwg56qenBC4hBPwj0sXqZnLoxYkHIB7X)



## 项目简介

MCms（铭飞内容管理系统）是一款面向企业网站建设与内容管理的 Java 开源项目。系统采用模块化设计，提供内容管理、栏目管理、模板管理、静态化等基础能力，并围绕实际建站和开发需求，形成由 **MCms、MDesigner、MCode、MStore** 等工具组成的开发生态。

- **MCms：内容管理核心** — 管理站点、栏目、文章及相关内容，支持模板驱动的网站建设。
- **MDesigner：可视化皮肤设计器** — 通过拖拽方式设计页面和网站模板，降低页面制作门槛。
- **MCode：代码生成器** — 根据业务模型和表单配置生成代码，减少重复开发工作。
- **MStore：模板与插件生态** — 提供模板和插件的分享、获取与扩展渠道，帮助项目按需扩展。

项目坚持开源共享，适合希望使用 Java 技术建设网站、开展二次开发或学习内容管理系统实现方式的团队与开发者。

## 核心能力

### 1. 内容管理与网站建设

- **栏目与内容管理**：集中管理网站栏目、文章及相关内容。
- **模板标签建站**：通过系统标签调用内容数据，结合模板完成页面开发。
- **静态化支持**：支持生成网站首页、栏目页和内容页等静态页面。
- **多终端展示**：支持 PC 与移动端网站展示，内容由系统统一管理。
- **SEO 辅助**：结合静态化、页面模板及站点内容配置，支持网站搜索引擎优化工作。

### 2. 可视化页面设计

通过 MDesigner 在线设计网站页面和皮肤模板，支持拖拽式编辑。设计完成后可结合 MCms 模板机制使用，减少重复编写页面的工作。

### 3. 代码生成与业务扩展

通过 MCode 配置业务模型和表单，辅助生成前后端代码，适用于常见管理功能的开发场景。开发者可在生成代码的基础上继续调整和扩展。

### 4. 模板与插件扩展

通过 MStore 获取或分享网站模板、功能插件。可根据项目需求选择相应扩展，例如站群、微信、商城等类型的插件（具体功能以插件实际版本和说明为准）。

### 5. 模块化与持续维护

- 项目采用模块化开发方式，相关模块可通过 Maven 依赖进行引入。
- 铭飞团队持续维护开源版本，并定期整理问题与发布更新。
- 提供使用文档、开发文档和视频教程，方便部署、使用与二次开发。

## 适用场景

| 使用对象 | 典型场景 |
| --- | --- |
| 企业与组织 | 企业官网、品牌网站、信息发布网站和内容门户建设 |
| 软件开发团队 | 在现有 Java 技术体系中集成内容管理能力，减少基础功能重复开发 |
| 独立开发者 | 快速搭建项目基础框架，开展定制开发或交付网站项目 |
| Java 学习者 | 学习内容管理系统的模块组织、模板机制和常见业务实现 |

## 开源协议与商用说明

MCms 开源版本采用 **MIT License**。使用、修改和分发前，请阅读项目根目录中的 `LICENSE` 文件，并根据 MIT 协议要求保留版权和许可声明。

项目欢迎企业和开发者基于开源代码开展学习、集成、二次开发与商业项目应用。使用过程中，请尊重开源协议及项目原有版权信息。

## 快速开始

### 环境要求

以下为项目 README 当前列出的开发环境建议。实际运行时，请结合所使用的 MCms 分支、依赖版本和部署方式核对兼容性。

| 环境 | 建议版本或说明 |
| --- | --- |
| 操作系统 | Windows、Linux |
| JDK | 17 或以上 |
| 数据库 | MySQL 8 或以上，按项目要求配置大小写规则 |
| 构建工具 | Maven |
| IDE | IntelliJ IDEA 或 Eclipse |
| Web 容器 | 原项目开发说明列出 Tomcat 10；请以当前分支的启动方式和配置为准 |

### 方式一：从源码运行

**1. 获取源代码**

```bash
git clone https://gitee.com/mingSoft/MCms.git
```

**2. 导入项目**

- IntelliJ IDEA：通过 `pom.xml` 导入 Maven 项目，等待依赖加载完成。
- Eclipse：选择 `File -> Import -> Maven -> Existing Maven Projects`，然后选择项目目录。

首次导入时，Maven 需要下载项目依赖，耗时取决于网络环境。

**3. 创建数据库**

创建名为 `MCms` 的数据库，并使用 UTF-8 编码。根据项目版本导入 `doc` 目录中对应的完整数据库 SQL 文件。

如果是从旧版本升级，请先确认升级路径，再使用对应的 `*-up-*.sql` 升级脚本。已经导入对应版本完整 SQL 的环境，不要重复执行同一版本的升级脚本。

**4. 配置数据库连接**

根据本地环境修改：

```text
src/main/resources/application-dev.yml
```

请确认数据库地址、端口、库名、用户名和密码与实际环境一致。

**5. 启动项目**

在 IDE 中运行 `MSApplication.java` 的 `main` 方法。启动类、配置文件和启动参数请以当前检出的分支为准。

**6. 登录后台并生成页面**

后台地址：

```text
http://localhost:8080/ms/login.do
```

原项目示例初始账号：

```text
用户名：msopen
密码：msopen
```

首次体验时，登录后台后进入“内容管理 -> 静态化”，按需生成首页、栏目和文章页面。

> 安全提示：示例账号仅用于本地体验。正式部署前，请立即修改默认账号密码，并完成必要的安全配置；不要将示例账号直接用于公网环境。

### 方式二：Docker 快速体验

以下命令用于快速体验一体化镜像。正式部署前，建议根据实际版本确认镜像标签、数据持久化目录、端口和安全配置。

```bash
docker run -d \
  -p 3366:3306 \
  -p 8181:8181 \
  --name MCms \
  -e TZ=Asia/Shanghai \
  -e MYSQL_ROOT_PASSWORD='请替换为强密码' \
  docker.1ms.run/mingsoft/MCms \
  --sql-mode=STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION \
  --lower-case-table-names=1 \
  --max-connections=1000
```

后台访问地址：

```text
http://localhost:8181/ms/login.do
```

原项目示例初始账号：

```text
用户名：msopen
密码：msopen
```

**部署注意事项：**

- 请将示例数据库密码替换为强密码，不要在生产环境使用示例密码。
- 建议按镜像说明将数据库数据目录和 MCms 文件目录挂载到宿主机，避免容器重建导致数据丢失。
- 正式环境应配置访问控制、HTTPS、定期备份和日志管理。
- `docker.1ms.run/mingsoft/MCms` 为原说明中提供的镜像地址；镜像标签和最新使用方式请以项目发布信息为准。

### 方式三：一键运行版本

不希望自行准备开发环境的用户，可以使用项目提供的一键运行包进行体验：

[一键运行版本下载（天翼云盘）](https://cloud.189.cn/web/share?code=7veQBn3i267f%EF%BC%88%E8%AE%BF%E9%97%AE%E7%A0%81%EF%BC%9Aapz2%EF%BC%89)

## Maven 模块引用

MCms 采用模块化开发方式。铭飞发布到 Maven 中央仓库的模块，可根据实际项目需要在 `pom.xml` 中添加依赖。

如需获取模块源码，可参考以下依赖配置示例，并将模块名称和版本号替换为实际坐标：

```xml
<dependency>
    <groupId>net.mingsoft</groupId>
    <artifactId>模块名称</artifactId>
    <version>版本号</version>
    <classifier>sources</classifier>
    <scope>provided</scope>
</dependency>
```

可在 [Maven Central](https://search.maven.org/search?q=ms-MCms) 查询已发布的模块及版本。

## 技术架构

MCms 使用 Java 后端技术栈，并结合前端框架、缓存和搜索组件构建网站内容管理与扩展能力。以下为项目原说明中列出的主要技术组件，具体依赖版本请以当前分支的 `pom.xml` 和前端项目配置为准。

### 后端技术

| 技术 | 主要用途 | 官方地址 |
| --- | --- | --- |
| Spring Framework | 应用基础框架与容器 | [官网](https://spring.io/projects/spring-framework) |
| Spring Boot | 应用配置与启动 | [官网](https://spring.io/projects/spring-boot) |
| Apache Shiro | 权限与安全框架 | [官网](https://shiro.apache.org/) |
| MyBatis | 持久层框架 | [官网](https://mybatis.org/mybatis-3/) |
| MyBatis-Plus | MyBatis 增强工具 | [官网](https://baomidou.com/) |
| FreeMarker | 模板引擎 | [官网](https://freemarker.apache.org/) |
| PageHelper | MyBatis 分页插件 | [项目地址](https://gitee.com/free/Mybatis_PageHelper) |
| Log4j | 日志组件 | [官网](https://logging.apache.org/) |
| Maven | 项目构建与依赖管理 | [官网](https://maven.apache.org/) |
| Elasticsearch | 搜索与检索 | [官网](https://www.elastic.co/) |
| Redis | 缓存与数据服务 | [官网](https://redis.io/) |
| Hutool | Java 工具库 | [官网](https://hutool.cn/) |

### 前端技术

| 技术 | 主要用途 | 官方地址 |
| --- | --- | --- |
| Vue 3 | 前端框架 | [官网](https://cn.vuejs.org/) |
| Element Plus | Vue 组件库 | [官网](https://element-plus.org/) |
| jQuery | JavaScript 工具库 | [官网](https://jquery.com/) |
| hover.css | CSS 交互效果 | [项目地址](https://github.com/IanLunn/Hover) |
| Validator.js | 数据校验 | [项目地址](https://github.com/validatorjs/validator.js) |
| Animate.css | CSS 动画 | [项目地址](https://animate.style/) |
| Iconfont | 图标资源 | [官网](https://www.iconfont.cn/) |

## 国产化与信创适配

MCms 基于 Java 技术体系构建，采用模块化架构，能够结合项目实际环境开展国产化软硬件适配与部署验证，满足企业官网、内容管理平台等系统在信创环境中的建设需求。

信创项目通常涉及处理器、操作系统、数据库、中间件及应用软件等多个层面。MCms 可作为应用层内容管理系统，结合目标环境进行兼容性评估、配置调整、功能测试和部署验证。

### 信创环境适配范围

以下列出的是国产化项目中常见的软硬件生态类型及产品示例，**不代表 MCms 已对表中所有产品完成认证或全量兼容测试**。具体适配情况应以 MCms 对应版本、项目测试结果及厂商兼容性清单为准。

| 适配层级 | 国产化产品/生态示例 | 适配说明 |
| --- | --- | --- |
| 处理器（CPU） | 鲲鹏、飞腾、海光、兆芯、龙芯等 | 根据处理器架构选择匹配的 JDK、系统依赖及运行镜像 |
| 操作系统 | 银河麒麟、统信 UOS、中科方德等 | 核对系统版本、系统架构、运行环境及部署方式 |
| 数据库 | 达梦、人大金仓、南大通用 GBase、 openGauss 等 | 根据数据库差异开展 SQL、数据类型、分页、函数及驱动适配 |
| 应用服务器/中间件 | 东方通 TongWeb、宝兰德等 | 根据目标中间件的部署规范调整应用打包、配置和运行参数 |
| Java 运行环境 | 国产化适配 JDK 发行版及对应版本 | 验证 JDK 版本、依赖组件和运行行为 |

### 适配实施建议

信创适配不是简单替换服务器或数据库，需要对应用及其依赖进行整体验证。建议按以下步骤实施：

1. **明确目标环境**：确认 CPU 架构、操作系统版本、JDK 发行版、数据库和中间件版本。
2. **开展依赖检查**：检查 Java 依赖、原生库、文件处理、字体、加密组件及第三方服务是否存在平台限制。
3. **完成数据库适配**：核对 SQL 语法、字段类型、分页方式、函数、索引及事务行为，必要时调整数据访问层。
4. **完成部署适配**：根据目标应用服务器或容器环境调整启动参数、资源路径、日志和文件权限。
5. **开展兼容性测试**：覆盖登录认证、栏目与内容管理、模板渲染、静态化、文件上传、搜索、缓存及定时任务等核心业务。
6. **形成适配记录**：记录软硬件版本、问题清单、修改内容和测试结论，便于后续升级与运维。

> 说明：国产化适配结果与 MCms 版本、第三方依赖及项目部署架构有关。若项目有明确的信创目录、兼容性认证或验收要求，应以对应检测报告、认证证书和项目实测结果为准，不应仅凭软件技术栈推定已完成认证。

## 安全建设与等保支持

网站和内容管理平台通常承载账号、内容、文件及业务数据，需要结合实际部署环境建立完整的安全防护体系。MCms 可作为应用层的一部分，配合身份认证、权限控制、日志审计、网络边界防护和数据备份等措施开展安全建设。

### 应用层安全建设

结合项目版本、部署配置和实际业务需求，可重点关注以下方面：

- **身份认证与访问控制**：合理配置管理员账号、角色和访问权限，遵循最小权限原则；及时停用无效账号并修改初始密码。
- **操作记录与审计**：结合系统日志及管理操作记录，留存必要的操作信息，便于问题追踪和安全审计。
- **输入与参数校验**：对用户输入、请求参数、文件上传及接口调用进行必要的校验和限制。
- **数据与文件保护**：合理设置上传目录权限，限制敏感文件访问，做好数据库和业务文件备份。
- **安全更新与依赖管理**：关注 MCms 版本更新及第三方依赖的安全公告，及时评估和修复已知风险。
- **传输安全**：生产环境建议启用 HTTPS，并妥善管理证书、密钥和后台访问入口。

以上为安全建设关注点，具体控制措施是否具备、是否启用以及是否满足项目要求，应结合实际版本、配置和测试结果确认。

### 等级保护建设配合

依据项目适用的网络安全等级保护要求，MCms 可纳入网站或业务系统整体安全建设方案。实施时建议从以下方面进行规划：

| 建设方向 | 建议措施 |
| --- | --- |
| 安全通信网络 | 根据网络架构配置访问边界、网络隔离、防火墙及必要的通信保护措施 |
| 安全区域边界 | 对管理后台、业务接口、数据库和运维入口实施合理的访问控制 |
| 安全计算环境 | 做好身份鉴别、权限管理、主机加固、恶意代码防护和安全更新 |
| 安全管理中心 | 结合日志平台、集中监控和审计系统，实现必要的日志留存与告警分析 |
| 数据安全 | 根据数据重要程度实施备份恢复、访问控制、传输保护及必要的数据保护措施 |
| 安全运维管理 | 建立账号管理、变更管理、漏洞修复、应急响应和定期检查机制 |

### 等保实施边界说明

**等级保护是面向网络和信息系统整体的定级、备案、建设整改、测评及持续运维工作，不是单一 CMS 软件能够独立完成或替代的。**

MCms 本身不等同于等保认证产品，也不代表部署 MCms 后系统即可自动满足等保要求。最终是否符合相应等级要求，需要结合业务系统边界、网络拓扑、服务器和数据库配置、安全设备、运维制度等整体情况，由具备相应资质的测评机构依据适用标准开展测评。

对于有等保或行业合规要求的项目，建议在方案阶段明确系统定级、部署边界和测评要求，并在实施过程中保留配置基线、测试记录、整改记录及运维制度等材料。

## 项目目录

| 路径 | 说明 |
| --- | --- |
| `doc/` | 项目文档及数据库脚本 |
| `src/main/java/` | Java 源代码 |
| `src/main/resources/` | 应用资源与配置文件 |
| `src/main/webapp/static/` | JavaScript、CSS、图片等静态资源 |
| `src/main/webapp/html/` | 示例静态页面目录，用于预览生成效果 |
| `src/main/webapp/templet/` | 网站模板目录 |
| `src/main/webapp/upload/` | 上传资源目录 |
| `src/main/webapp/WEB-INF/manager/` | 后台视图页面 |
| `LICENSE` | 开源协议 |
| `README.md` | 项目说明 |
| `pom.xml` | Maven 项目依赖与构建配置 |

## 生态工具

MCms 不仅提供内容管理功能，也围绕网站建设和开发过程提供配套工具。以下平台可用于在线体验，具体功能以各平台实际开放内容为准。

### MDesigner — 可视化皮肤设计器

通过在线拖拽方式设计网站页面和模板，帮助开发者更直观地完成页面布局与样式制作。

[进入 MDesigner](https://designer.mingsoft.net/)

![MCms 可视化皮肤设计器演示](https://cdn.mingsoft.net/gif/designer.gif)

### MStore — 模板与插件生态

MStore 提供网站模板和功能插件。用户可以根据项目需要获取模板或扩展功能；开发者也可以分享模板、插件等内容，让开发成果获得更多使用机会。

**在线设计模板：**

![MStore 模板在线设计演示](https://cdn.mingsoft.net/gif/store-local.gif)

**远程安装模板：**

![MStore 远程安装模板演示](https://cdn.mingsoft.net/gif/store-remote.gif)

[进入 MStore](https://store.mingsoft.net/)

### MCode — Java 代码生成器

通过配置业务模型和表单，辅助生成前后端业务代码，减少常见管理功能的重复开发工作。

[进入代码生成器](https://coder.mingsoft.net/)

![Java 代码生成器配置演示](https://cdn.mingsoft.net/gif/code1.gif)

![Java 代码生成器代码生成演示](https://cdn.mingsoft.net/gif/code2.gif)

### 项目管理平台

提供项目协作、任务管理和研发过程管理等工具，帮助团队组织项目开发工作。

[进入项目管理平台](https://pm.mingsoft.net/people/index.do)

![项目管理平台任务协作演示](https://cdn.mingsoft.net/gif/pm1.gif)

![项目管理平台看板与统计演示](https://cdn.mingsoft.net/gif/pm2.gif)

### 铭软 SaaS 建站服务

除开源部署方式外，也可了解铭软提供的 SaaS 建站服务，按实际需求选择在线建站方案。

[了解 SaaS 建站服务](https://store.mingsoft.net/saas)

## 系统界面

以下为 MCms 后台部分功能界面示意：

| 登录界面 | 控制台 |
| --- | --- |
| ![MCms 后台登录界面](https://cdn.mingsoft.net/ad/1.png) | ![MCms 系统控制台](https://cdn.mingsoft.net/ad/2.png) |
| 插件管理 | 栏目管理 |
| ![MCms 插件管理界面](https://cdn.mingsoft.net/ad/3.png) | ![MCms 栏目编辑界面](https://cdn.mingsoft.net/ad/4.png) |
| 静态化管理 | 内容管理 |
| ![MCms 静态化管理界面](https://cdn.mingsoft.net/ad/5.png) | ![MCms 文章管理界面](https://cdn.mingsoft.net/ad/6.png) |
| 系统配置 | 模板管理 |
| ![MCms 系统配置界面](https://cdn.mingsoft.net/ad/7.png) | ![MCms 模板管理界面](https://cdn.mingsoft.net/ad/8.png) |
| 日志管理 | 栏目结构 |
| ![MCms 日志管理界面](https://cdn.mingsoft.net/ad/9.png) | ![MCms 栏目结构管理界面](https://cdn.mingsoft.net/ad/10.png) |

## 版本说明

- **开源版本**：永久免费开放源代码，供开发者和企业使用、学习与二次开发。开源版本的更新安排以项目实际发布记录为准。
- **企业版本及其他版本**：在功能范围、更新节奏、配套插件和技术服务等方面可能有所不同，具体权益以官方版本说明为准。

[查看版本功能对比](https://www.mingsoft.net/banben.html)

## 文档与支持

- [MCms 使用手册](https://doc.mingsoft.net/MCms/)
- [插件开发与使用手册](https://doc.mingsoft.net/plugs/)
- [服务器部署手册](https://doc.mingsoft.net/server/)
- [Maven Central 模块查询](https://search.maven.org/search?q=ms-MCms)
- [Gitee 源码仓库](https://gitee.com/mingSoft/MCms)
- [GitHub 源码仓库](https://github.com/ming-soft/MCms)
- [Bilibili 视频教程](https://space.bilibili.com/1825880395)


## 参与项目

欢迎通过以下方式参与 MCms：

- 提交 Issue，反馈问题或提出功能建议。
- 提交 Pull Request，参与代码改进。
- 分享模板、插件和使用经验，丰富项目生态。
- 完善文档和示例，帮助更多开发者快速上手。

## 关于铭飞

铭飞持续投入 MCms 及相关开发工具的建设，希望通过开源代码、开发工具、模板插件和文档社区，让企业建站与 Java 应用开发更加高效。

**价值源自分享。欢迎使用 MCms，也欢迎参与共建。**

[铭飞官网](https://www.mingsoft.net/) · [MStore](https://store.mingsoft.net/) · [在线文档](https://doc.mingsoft.net/MCms/)
