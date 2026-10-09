# 模板

两套模板不要混放。

| 用途 | 位置 | 后缀 | 语法 |
|---|---|---|---|
| 网站前台 | `ms-mcms/src/main/webapp/template/{站点id}/` | `.htm` | 铭飞标签 + FreeMarker |
| 管理后台 | 各模块 `src/main/webapp/WEB-INF/manager/{模块}/{功能}/` | `.ftl` | FreeMarker + Element |

默认站点是 `template/1/`，其下 `default/` 是一套完整皮肤（`index.htm`、`news-list.htm`、`news-detail.htm`、`header.htm`、`footer.htm`）。新皮肤沿用「站点 id / 皮肤名」这两级目录。

换整站或要演示效果时，优先用默认皮肤或按 [mstore.md](mstore.md) 导入现成模板，不要从空白页拼全站标签。首页文件名必须是 `index.htm`。

## 前台 .htm

先复制同目录里最接近的页面，再改。标签的参数、字段和搜索写法见 [tags.md](tags.md)。

| 页面 | 对照文件 |
|---|---|
| 首页 | `index.htm` |
| 列表 | `news-list.htm`，分页片段 `page.htm` |
| 内容 | `news-detail.htm` |
| 导航 | `header.htm`、`footer.htm` |
| 搜索 | `search.htm`，表单在 `header.htm`，提交 `/mcms/search.do` |

栏目在后台绑定的列表模板、内容模板，填的是该站点目录下的文件名，不是 Java 路径。生成后的静态文件在 `ms-mcms/src/main/webapp/html/`，改htm 后要重新生成。

## 后台 .ftl

目录与 Action 返回值对应。`return "/cms/category/index"` 对应：

`ms-mcms/src/main/webapp/WEB-INF/manager/cms/category/index.ftl`

头部引入相对路径上的公共文件：

```html
<#include "../../include/head-file.ftl">
```

`head-file.ftl` 在 `ms-basic` 的 `WEB-INF/manager/include/`。

页面是 Vue + Element。根节点用 `ms-index`，按钮用 Shiro 宏包住，名字与 Java 注解一致：

```html
<@shiro.hasPermission name="cms:category:save">
    <el-button type="primary" @click="save()">新增</el-button>
</@shiro.hasPermission>
```

列表、表单、删除请求打到该功能已有的 `/list`、`/save`、`/update`、`/delete`，前缀是后台路径 `/ms`（即 `ms.manager.path`）。新页面照 `category/index.ftl` 和 `category/form.ftl` 的数据字段命名，不要另起一套前端工程。
