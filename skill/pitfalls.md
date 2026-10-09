# 容易踩错的地方

## 工作目录

`application.yml` 里 FreeMarker 会从进程工作目录读 `file:WEB-INF/`。IDE 的 Working directory 必须能读到 `WEB-INF` 和站点 `template`。设成模块里某个子目录时，后台页面 404，模板管理也读不到文件。

前台源文件在 `ms-mcms/src/main/webapp/template/`。后台源文件在各模块 `src/main/webapp/WEB-INF/manager/`。改 `target/` 里的同名文件会在下次编译时被覆盖。

## Bean 名

`@Controller`、`@Service`、`@Component` 在跨模块扫描后共用一个容器。后台和前台经常有同名 `ContentAction`、`CategoryAction`。必须写成 `@Controller("cmsCategoryAction")`、`@Controller("WebcmsContentAction")` 这种显式名字。新增类沿用「模块 + 功能 + 层」的名字。

## Mapper XML

父 POM 把 `src/main/java` 下的 XML 复制到 classpath，所以 XML 和 Dao 接口放在一起。

`application.yml` 的 `mybatis-plus.mapper-locations` 目前只有：

`classpath*:/net/mingsoft/base/dao/IBaseDao.xml`

单表走 MyBatis-Plus 的 `BaseMapper` 时不受影响。新增的自定义 SQL 如果运行时提示找不到 statement，把对应 XML 补进 `mapper-locations`，保留原来的 `IBaseDao.xml` 这一条。`namespace` 必须是 Dao 接口全名。

`where-strategy` 是 `not_empty`，空字符串不会进条件。需要把列更新成空时，在实体字段上使用 `FieldStrategy.ALWAYS`。

## 权限和菜单

三处名字要一致：

1. `@RequiresPermissions("cms:category:save")`
2. ftl 里的 `<@shiro.hasPermission name="cms:category:save">`
3. 角色在模块管理里勾选的菜单

缺菜单时侧栏没有入口。缺注解或角色未勾选时，页面能开但保存返回无权限。

## XSS

`ms.xss.enable` 为 true，默认过滤 `/**`。后台路径、静态资源、上传接口已在 `exclude-url`。富文本、模板正文、自定义模型 JSON 靠 `exclude-field` 放行，现有字段包括 `menuStr`、`modelField`、`modelJson`、`fileContent`、`contentDetails`。新的富文本字段提交后被剥标签时，把字段名加进 `exclude-field`，不要关掉整个过滤器。

## 上传

`ms.upload.denied` 禁止 `exe,jsp,xml,sh,bat,py,ftl,jspx`。不要把可执行或模板后缀放进允许列表。`ms.upload.mapping` 一旦有了线上文件，就不要再改，否则旧地址 404。

## 接口文档

`springdoc` 在 dev 开启，包扫描 `net.mingsoft`。后台接口保留 `@Tag`、`@Operation`。页面跳转方法加 `@Hidden`，与 `CategoryAction.index` 一致。生产配置要关掉 swagger。
