# 常见问题

只写改模板、改内容和本地跑起来时会反复碰到的情况。数据库、打包、Nginx 见 [deploy.md](deploy.md)。企业版迁移不在这里。

## 后台 404，或模板管理是空的

启动配置的 Working directory 设为 `ms-mcms` 所在目录（`MSApplication` 所在模块），然后重启。FreeMarker 从该目录读 `WEB-INF/`，站点模板从 `template/{站点id}/` 读。工作目录指到别的模块时，后台页面和模板管理都会找不到文件。

模板放在 `ms-mcms/src/main/webapp/template/` 里改。不要靠后台上传后再重启，上传文件若落在容器临时目录，重启会丢。

## 改了 htm，网站还是旧的

前台静态页在 `ms-mcms/src/main/webapp/html/`，配置项 `ms.diy.html-dir` 默认是 `html`。改模板后要在后台重新静态化对应栏目或首页，否则浏览器仍打开旧 html。

不要手改 `html/` 里的文件，下次生成会覆盖。

静态路径大致是：`html` / 网站生成目录 / 栏目拼音 / 文章 id。短链、多皮肤会少掉或多出中间目录。网站生成目录在应用设置里。

调试模板可先走动态地址，确认后再生成。首页动态入口形如 `/mcms/index.do`，`style` 参数指定皮肤目录名。

## 标签不解析或整页报错

- 参数必须在同一行，字符串要加引号。
- `{ms:...}` 不要写成 `${ms:...}`，也不要写进 css、js。
- 列表页、首页不要写 `${field.content}`。正文只在内容模板，或包在 `{ms:data}` 里。
- 缩略图用 `{@ms:file field.litpic/}`。多图先判断 `field.litpic` 非空再 `?eval`。
- `{ms:arclist ispaging=true}` 一页只能有一个，且不要同时写 `flag`、`noflag`。
- 分页标签只对「列表模板 + 已生成的栏目」生效。只生成首页看不到分页。
- 自定义模型字段用数据库列名，区分大小写，并带上 `tableName`。全局配置字段才是小写驼峰。
- 从旧模板升级时，把 `{ms:include}`、`[field.xxx/]`、`{ms:field.xxx/}` 换成 [tags.md](tags.md) 里的写法。

## 图片或栏目链接不对

- `{@ms:file}` 前不要加 `/`。
- `{ms:global.style/}` 前要加 `/`。
- 栏目、文章、分页用 `{ms:global.html/}`，不要用 `{ms:global.url/}`。
- `field.type` 为 `3` 时走 `typeurl`，否则走 `typelink`。
- `server.servlet.context-path` 不是 `/` 时，css、js、图片路径加上 `{ms:global.contextpath/}`。
- `ms.upload.template` 只能改文件夹名，不能写成路径。改名后要把原来的 `template` 目录一起改名。已有上传文件时不要改 `ms.upload.mapping`。

## 搜索没有结果

表单 `action` 为 `/mcms/search.do`，标题字段名是 `content_title`。结果页必须是 `search.htm`（或 `tmpl` 指定的文件），里面用带 `ispaging=true` 的 `{ms:arclist}`。搜自定义模型时，`categoryIds` 只能是一个没有子栏目的栏目 id。

## 栏目绑错模板

后台栏目上的列表模板、内容模板填的是皮肤目录里的文件名，例如 `news-list.htm`、`news-detail.htm`，不是 Java 路径，也不是 `html/` 下的生成文件。

`1` 列表用列表模板，`2` 封面用内容模板，`3` 链接用自定义地址。父栏目如果只想打开第一个子栏目，把父栏目做成链接，自定义地址填子栏目的静态路径。

## 导入了模板但栏目里看不到，或和演示站差很多

上传 zip 后要到「应用设置」选定站点风格。只要页面文件时用模板管理上传；要演示站同款栏目和文章时，按 [mstore.md](mstore.md) 用分享插件导入，并先备份。导入会覆盖当前站内容相关数据。
