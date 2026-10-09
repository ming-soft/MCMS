---
name: mcms-dev
description: 指导铭飞 MCMS（ms-parent）的二次开发、模板、前台读数接口、MStore 皮肤、本地启动、打包和部署。在本仓库新增或修改栏目、文章、模板、自定义模型、后台菜单、接口，或处理安装、数据库、jar、Nginx、MStore、JS 调接口取数时使用。触发词包括 MCMS、铭飞、二次开发、模板标签、内容接口、MStore、安装、部署、打包。
---

# 铭飞 MCMS 二次开发

本目录是普通 Markdown，给任意编程助手使用。先读本文件，再按任务打开同目录链接。不要把这些文件改写成某一家产品的私有格式。

只写本仓库特有约定。Spring、MyBatis-Plus、Shiro、FreeMarker 的通用用法不在这里重复。不要编造本仓库没有的表结构、脚本、标签或插件。

## 任务路由

| 用户在做什么 | 接着读 |
|---|---|
| 安装、连库、本地启动、打 jar、Nginx、Docker | [deploy.md](deploy.md) |
| 换皮肤、用 MStore 模板、导入演示站 | [mstore.md](mstore.md)、[templates.md](templates.md) |
| 写或改前台 `.htm` 标签 | [tags.md](tags.md)、[templates.md](templates.md) |
| 前台 JS 调接口读栏目、文章 | [apis.md](apis.md) |
| 页面不更新、标签报错、路径不对 | [faq.md](faq.md) |
| 新后台业务、接口、菜单 | [layers.md](layers.md) |
| Bean 名、Mapper、权限、XSS | [pitfalls.md](pitfalls.md) |

## 工程

Java 17，Spring Boot 3.5.11。启动类是 `ms-mcms` 的 `net.mingsoft.MSApplication`，只扫描 `net.mingsoft`。Mapper 扫描 `**.dao`。

| 模块 | 职责 | 二次开发时 |
|---|---|---|
| `ms-base` | `BaseEntity`、`IBaseDao`、`IBaseBiz`、`ResultData` | 只继承、只调用 |
| `ms-basic` | 管理员、角色、模块菜单、日志、模板文件、应用 | 登记菜单、沿用权限和日志 |
| `ms-mdiy` | 自定义模型、表单、配置、字典、全局标签 | 扩展字段和表单时优先用它 |
| `ms-mpeople` | 会员 | 只改会员相关需求 |
| `ms-mcms` | 栏目、文章、静态化，也是启动模块 | 内容和前台模板放这里 |

配置在 `ms-mcms/src/main/resources/application.yml`。后台路径由 `ms.manager.path` 决定，默认 `/ms`，登录页是 `/ms/login.do`。本地 profile 是 `dev`。

父 POM 会把各模块 `src/main/java` 里的非 `.java` 文件打进包，所以 Dao 的 XML 放在接口旁边，不放 `src/main/resources`。

`store-client` 在 `ms-mcms/pom.xml` 里默认注释掉。MStore 用法见 [mstore.md](mstore.md)。

## 先选改法

按下面顺序判断，能用上面的就不要落到下面。

1. **新站或换整套皮肤**  
   先用本仓库 `template/1/default/`，或按 [mstore.md](mstore.md) 导入现成模板。不要从空白页手写全站标签。

2. **只改页面、列表、详情**  
   改 `ms-mcms/src/main/webapp/template/{站点id}/` 下的 `.htm`。文件放哪见 [templates.md](templates.md)，标签按 [tags.md](tags.md) 写。异步取数、自定义分页组件用 [apis.md](apis.md)，不要在静态页里手写一套查询。改完要重新静态化，生成物在 `html/`，不要手改。常见现象见 [faq.md](faq.md)。

3. **文章或栏目多字段，或要自定义表单、字典、站点配置、全局标签**  
   用 `ms-mdiy`，不要先改 `cms_content` / `cms_category` 表结构。类型对应 `ModelCustomTypeEnum`：`model` 自定义模型，`form` 自定义表单，`config` 自定义配置，`tag` 全局标签。栏目上的 `mdiyModelId` 用来挂内容模型。

4. **在现有栏目、文章、会员上加校验或连带动作**  
   在对应模块的 Action、Biz 或 `aop` 包里扩展。切面对照 `ms-mcms` 的 `ContentAop`、`CategoryAop`，继承 `net.mingsoft.basic.aop.BaseAop`。

5. **平台能力盖不住的新后台业务**  
   在 `net.mingsoft` 下按现有功能复制一整套。栏目是完整参照：`CategoryEntity`、`ICategoryDao`、`ICategoryBiz`、`CategoryBizImpl`、`cms.action.CategoryAction`、`cms.action.web` 下的前台接口、`WEB-INF/manager/cms/category/` 的页面。分层清单见 [layers.md](layers.md)。

新代码必须放在 `net.mingsoft` 下，否则启动类扫不到。不要为了加字段新建一个 Maven 模块。

## 硬规则

- 不改 `ms-base`，除非任务本身就是改框架。
- 没有 `mcms-dev.sql.zip` 时向用户要脚本，不要自己写建库建表语句。
- 不要发明标签写法；只用 [tags.md](tags.md) 和现有 `.htm` 里的形态。
- 用户未要求时，不要主动打开 `store-client`、不要安装 MStore 插件、不要合并冲突类。
- 后台接口返回 `ResultData`。列表外包 `net.mingsoft.basic.bean.EUListBean`。
- 后台 Controller 的 bean 名必须全局唯一，例如 `cmsCategoryAction`、`WebcmsContentAction`。
- 后台映射带 `/${ms.manager.path}`。前台接口放在 `action.web`，映射不带后台前缀。
- 增删改加 `@LogAnn`，权限用 `@RequiresPermissions("模块:功能:view|save|update|del")`。页面按钮用同样字符串写 `<@shiro.hasPermission>`。
- 校验失败用 `getResString`，文案写在该模块 `resources/resources_zh_CN.properties`，并补英文文件。
- 实体继承 `BaseEntity`。业务表主键用 `@TableId(type = IdType.ASSIGN_ID)`。
- 菜单要在后台「模块管理」登记，再在角色里勾选。
- 源码只改 `src`。`target/` 是编译产物。
- 用户输入进 SQL 时走 `SqlQueryWrapper` 或预处理参数，不要拼接。
- 生产密码、证书只改运行环境配置，不要写进仓库或对话。

## 做完核对

- 改动落在上表对应的模块，没有顺手改框架。
- 后台接口、Shiro 权限串、ftl 按钮、角色菜单是同一套名字。
- 新 Dao 方法的 XML 与接口同目录，`namespace` 是接口全名。
- 运行工作目录是 `ms-mcms`。设错时后台 404、模板管理读不到文件。
- 改了前台模板后已提示或完成静态化。
- 只编译相关模块。启动模块是 `ms-mcms`。上线前按 [deploy.md](deploy.md) 关掉接口文档并改掉默认口令。

## 参考

- 安装、打包、部署：[deploy.md](deploy.md)
- MStore 与现成模板：[mstore.md](mstore.md)
- 模板标签：[tags.md](tags.md)
- 前台读数接口：[apis.md](apis.md)
- 模板目录与后台页面：[templates.md](templates.md)
- 模板和静态化常见问题：[faq.md](faq.md)
- 新 Java 功能文件清单：[layers.md](layers.md)
- 路径、权限、XML、XSS：[pitfalls.md](pitfalls.md)
