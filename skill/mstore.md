# MStore 与现成模板

做新站、换皮肤时，优先用现成模板，不要从零拼标签。来源按下面顺序选。

1. 本仓库已有皮肤 `ms-mcms/src/main/webapp/template/1/default/`
2. 铭飞官网或 MStore 下载的模板包
3. 在现有皮肤上改页面和标签（见 [templates.md](templates.md)、[tags.md](tags.md)）

城市表数据也从 MStore 下载，不在本仓库里。

## 本仓库当前状态

`ms-mcms/pom.xml` 里 `store-client` 依赖是注释掉的。后台 `head-file.ftl` 仍可能加载 `ms-store` 前端脚本，但没有依赖时后台 Store 入口不能完整使用。

需要后台进入 MStore 时：

1. 打开 `ms-mcms/pom.xml` 里 `store-client` 那段依赖，版本以注释或开源最新为准，当前仓库注释里是 `3.0.6.1`
2. 重新编译并重启
3. 仍进不去时，对照手册 http://doc.mingsoft.net/mcms/chang-jian-wen-ti/mo-ban-wen-ti.html

线上环境用 HTTPS 时，不要依赖浏览器里直接打开 MStore 装插件。模板可在官网下载后本地导入；插件在本地装好、合并冲突、测通后再部署。

## 推荐怎么用模板

| 需求 | 做法 |
|---|---|
| 快速有一个能静态化的站 | 用默认 `default` 皮肤，或导入带演示数据的皮肤 |
| 只要页面文件、自己配栏目 | 后台「模板管理」上传 zip，再到「应用设置」选站点风格 |
| 要和演示站一样的栏目、文章、效果 | 用分享插件导入带演示数据的包，不要只上传 htm |
| 只要某套皮肤的页面结构 | 解压后把皮肤目录拷进 `template/{站点id}/`，再绑栏目模板 |

上传 zip 后若栏目编辑里看不到新模板，多半是还没在应用设置里选定站点风格。

带演示数据的导入会覆盖当前站的文章、栏目和相关自定义数据。导入前先备份库和 `template`、`upload`。

模板包里若有 SQL：按控制台报错修正后再执行，常见是旧字段名与当前库不一致。没有数据文件时，手动建栏目并绑定列表模板、内容模板，再静态化。

## 旧模板标签

MStore 或旧皮肤里若仍是下面写法，按 [tags.md](tags.md) 改掉再生成：

- `{ms:field.xxx/}` → 列表或内容页的 `${field.xxx}`，或 `{ms:channel type="self"}`
- `{ms:include filename=.../}` → `<#include "文件.htm">`
- `[field.date fmt=yyyy/]` → `${field.date?string("yyyy")}`
- 栏目、文章链接里的 `${global.url}` → `{ms:global.html/}`

## 插件

自动静态化、新编辑器、审批等来自 MStore 或选配插件。安装前确认：

- 是否改 `pom`、是否要合并冲突类（如 `CmsParserUtil`、`GeneraterAction`）
- 菜单是否出现在「功能大全」，需要收藏后才显示在侧栏
- 短链、站群、审批等组合可能有文件冲突，不要直接整目录覆盖

用户没有明确要求时，不要主动加插件依赖，也不要为了装插件改框架核心类。
