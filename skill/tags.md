# 模板标签

写 `.htm` 时用本文，不要发明 `<#ms>` 或 `${ms:...}`。标签由后台「全局标签」里的 SQL 模板执行，改取值规则去改那条标签，不要在 Java 里重写解析。某个参数不生效时，先看该标签 SQL 是否包含这个变量。

手册原文：http://doc.mingsoft.net/mcms/biao-qian/index.html

## 语法

三种写法，结尾的 `/` 不能省：

| 写法 | 用途 | 例子 |
|---|---|---|
| `{ms:名称.字段/}` | 单值 | `{ms:global.name/}`、`{ms:page.next/}` |
| `{@ms:名称 参数/}` | 函数 | `{@ms:file field.litpic/}`、`{@ms:len field.title 20 /}` |
| `{ms:名称 参数}...{/ms:名称}` | 循环或单篇 | `{ms:arclist}`、`{ms:channel}`、`{ms:data}` |

规则：

- 没有 `$`。`${field.title}` 是循环内部的字段，不是标签名。
- 字符串参数加引号：`type="son"`、`flag="c"`。`size=10`、`ispaging=true` 不要引号。
- 一个标签的参数写在同一行，换行会导致参数解析失败。
- 不能写进 `.css`、`.js`。公共头尾用 `<#include "header.htm">`。
- 链接用 `{ms:global.html/}` 接相对路径。栏目、文章链接不要用 `{ms:global.url/}`、`{ms:global.host/}`，否则换域名后地址被写死。
- `{@ms:file}` 前面不要再加 `/`，否则变成 `//upload/...`。`{ms:global.style/}` 引入 css、js 时，路径以 `/` 开头：`/{ms:global.style/}css/style.css`。
- 数值比较用 `gt`、`gte`、`lt`、`lte`，不要写 `>`、`<`。字符串和数字比较前加 `?number`。
- 旧写法不要再写：`{ms:include ...}`、`{ms:field.xxx/}`、`[field.date fmt=yyyy/]`。分别改成 `<#include "文件.htm">`、`{ms:channel type="self"}`、`${field.date?string("yyyy")}`。

## 页面上直接可用的 field

列表模板、内容模板里，当前栏目或当前文章的 `field` 不用包在 `{ms:channel}` 里。`{ms:channel}`、`{ms:arclist}` 内部的 `field` 是循环项，会挡住外面的当前页字段。需要把当前栏目 id 传进循环时，先赋给变量：

```html
<#assign typeid=field.typeid>
<#assign ids=field.parentids>
```

栏目类型 `field.type`：`1` 列表，`2` 封面，`3` 链接。链接栏目用 `typeurl`，其他用 `typelink`：

```html
<a href="<#if field.type==3>{ms:global.html/}${field.typeurl}<#else>{ms:global.html/}${field.typelink}</#if>">${field.typetitle}</a>
```

`field.typeleaf` 为 `1` 表示没有子栏目。导航选中：当前 `typeid` 相等，或 `parentids` 包含该项 id。

## {ms:global.* /}

首页、列表、内容、自定义页都能用。

| 标签 | 含义 |
|---|---|
| `{ms:global.name/}` | 网站标题 |
| `{ms:global.keyword/}` | 关键字 |
| `{ms:global.descrip/}` | 描述 |
| `{ms:global.logo/}` | Logo 地址，配合 `{@ms:file global.logo/}` |
| `{ms:global.ico/}` | 站点图标 |
| `{ms:global.copyright/}` | 版权 |
| `{ms:global.html/}` | 静态目录，如 `/html/web/`。栏目、文章、分页链接加在它后面 |
| `{ms:global.style/}` | 当前模板目录，如 `template/1/default/` |
| `{ms:global.contextpath/}` | `server.servlet.context-path`。项目名不是 `/` 时，资源路径加上它 |
| `{ms:global.template/}` | 当前皮肤目录名。默认皮肤的登录、注册页在用 |
| `{ms:global.host/}` | 域名。只用于必须绝对地址的跳转，不用于 css、js |
| `{ms:global.url/}` | 域名加静态目录。栏目和文章链接改用 `{ms:global.html/}` |

自定义配置（`ms-mdiy` 的 config）用模型名加字段名，字段名是数据库列转小写再变驼峰：`DATE_A` 写成 `dateA`。

```html
{ms:global.模型名.字段名/}
{@ms:file global.模型名.图片字段/}
```

本仓库不要用这些企业版或政务版标签：`{ms:global.shortswitch/}`、`{ms:global.route/}`、`{@ms:memorialday/}`、`{@ms:accessibility .../}`。

## {ms:channel}

取栏目。首页不写 `typeid` 时取顶级栏目；列表页、内容页不写时对应当前栏目。

```html
{ms:channel type="nav" flag="n" size="8" orderby="sort" order="desc"}
    <a href="{ms:global.html/}${field.typelink}">${field.typetitle}</a>
    {ms:channel typeid=field.id}
        <a href="{ms:global.html/}${field.typelink}">${field.typetitle}</a>
    {/ms:channel}
{/ms:channel}
```

| 参数 | 默认 | 含义 |
|---|---|---|
| `type` | `son` | `nav` 第一级导航；`son` 子栏目；`level` 同级（顶级无效）；`self` 指定栏目自身；`parent` 上一级，只有一条；`top` 父级的同级，要有 `typeid`；`path` 从当前栏目往上的路径 |
| `typeid` | 父级栏目 | 有值时取其子级。嵌套时写 `typeid=field.id` |
| `typeids` | | `id1,id2,id3`。有值时 `type` 无效，只取这些栏目自身 |
| `size` | 全部 | 条数 |
| `flag` / `noflag` | | 栏目属性，值来自栏目属性字典，用法同文章 `flag` |
| `orderby` | 栏目 id | `date` 更新时间，`sort` 自定义顺序 |
| `order` | 升序 | `desc` 或 `asc`，必须和 `orderby` 一起写 |
| `tableName` | | 栏目自定义模型表名，且 `type="self"` |

`order` 必须搭配 `orderby`。

循环内字段：

| 字段 | 含义 |
|---|---|
| `${field.index}` | 从 1 开始的序号 |
| `${field.id}` | 栏目 id。单篇栏目时这里可能是文章 id，栏目 id 用 `${field.typeid}` |
| `${field.typeid}` | 栏目 id |
| `${field.typetitle}` | 名称 |
| `${field.typeshorttitle}` | 副标题 |
| `${field.typekeyword}` | 关键字 |
| `${field.typedescrip}` | 描述 |
| `${field.typepath}` | 拼音路径 |
| `${field.typelink}` | 栏目链接，前面加 `{ms:global.html/}` |
| `${field.typeurl}` | 自定义链接，`type==3` 时使用 |
| `${field.type}` | `1` 列表，`2` 封面，`3` 链接 |
| `${field.typeleaf}` | `1` 无子栏目，`0` 有子栏目 |
| `${field.childsize}` | 子栏目数量 |
| `${field.parentid}` | 父级 id |
| `${field.parentids}` | 各级父 id，逗号分隔，如 `100,101,102` |
| `${field.flag}` | 栏目属性 |
| `{@ms:file field.typelitpic/}` | 栏目 banner |
| `{@ms:file field.typeico/}` | 栏目小图 |

取顶级父栏目：`parentids` 为空则当前 id 就是顶级，否则取 `ids?split(",")[0]`，再用 `{ms:channel type="self" typeid=topid}`。

父栏目模板 `<#include>` 子栏目模板时，父栏目页面不能分页；子栏目在父页面里只显示第一页。可用 `<#assign curTypeId=field.id>` 把变量带进被 include 的文件，子栏目自己的列表页读不到这个变量。

## {ms:arclist}

取文章。首页建议写 `typeid`。列表页、内容页可以不写，默认当前栏目。内容页不写 `typeid` 时，效果类似同栏目相关文章。

```html
{ms:arclist typeid="栏目id" size=10 flag="c" orderby="date" order="desc"}
    <a href="{ms:global.html/}${field.link}">
        <img src="{@ms:file field.litpic/}" alt="${field.title}">
        ${field.title}
    </a>
{/ms:arclist}
```

在 `{ms:channel}` 里套文章时，列表页和内容页必须写 `typeid=field.id`。首页、自定义页可以不写。

| 参数 | 默认 | 含义 |
|---|---|---|
| `typeid` | 当前栏目 | 栏目 id。`typeid="0"` 表示不限栏目 |
| `typeids` | | 多个栏目 id，逗号分隔。有值时 `typeid` 无效 |
| `size` | 20 | 条数。`size="1,2"` 表示跳过 1 条再取 2 条，不能和 `ispaging` 同时用 |
| `flag` | | 文章属性，多个按字典顺序写，如 `c,f`。`c` 推荐，`f` 幻灯，`p` 图片，`h` 头条，`j` 跳转。实际值以后台文章属性字典为准 |
| `noflag` | | 排除这些属性 |
| `topflag` | | 这些属性的文章排在前面，其余按 `orderby`。可以和分页一起用 |
| `orderby` | `date` | `date` 发布时间，`updatedate` 更新时间，`sort` 自定义顺序，`hit` 点击。多个字段：`orderby="sort,date"` |
| `order` | `desc` | `asc` 或 `desc`。多字段时 `order="asc,desc"`，与 `orderby` 一一对应 |
| `ispaging` | `false` | 列表分页必须写 `ispaging=true`，且该页只能有一个。不能再加 `flag`、`noflag`，否则分页和列表不一致 |
| `tableName` | | 栏目绑定的自定义模型表名，必须同时指定 `typeid` |
| `scope` | | `scope=true` 时，这个列表不受外层搜索条件影响。搜索页上「结果」和「热门」两个 `arclist` 时，热门那个加上 |

点击排序要重新静态化之后才会变。`orderby` 不要用在需要和上一篇、下一篇顺序一致的列表上。

循环内字段：

| 字段 | 含义 |
|---|---|
| `${field.index}` | 序号，从 1 开始 |
| `${field.id}` | 文章编号 |
| `${field.title}` | 标题 |
| `${field.link}` | 文章相对路径，前面加 `{ms:global.html/}` |
| `${field.outlink}` | 外链，有值时优先跳转，且以 `http` 开头 |
| `${field.litpic}` | 缩略图 JSON。展示必须用 `{@ms:file field.litpic/}`，多图时它只出第一张 |
| `${field.descrip}` | 摘要 |
| `${field.date}` | 时间，格式 `${field.date?string("yyyy-MM-dd")}` |
| `${field.author}` | 作者 |
| `${field.source}` | 来源 |
| `${field.hit}` | 点击数。列表里的这个数不是实时的 |
| `${field.keyword}` | 关键字 |
| `${field.flag}` | 属性值 |
| `${field.tags}` | 标签，逗号分隔 |
| `${field.typeid}` `${field.typetitle}` `${field.typelink}` `${field.type}` | 所属栏目 |
| `${field.typeshorttitle}` `${field.typelitpic}` `${field.typeico}` `${field.typekeyword}` | 所属栏目的副标题、banner、小图、关键字 |
| `${field.topid}` `${field.parentid}` `${field.parentids}` | 所属栏目的顶级、父级、父级链 |

列表里没有 `${field.content}`。要在列表输出正文，套 `{ms:data dataid=field.id}`。只要纯文本时用 `${MUtil.html2text(field.content)}`，再截取。摘要直接用 `descrip`，不要截 HTML。

自定义模型字段名是数据库列名，区分大小写：`${field.列名}`。

多图先判空再 `?eval`：

```html
<#if field.litpic?? && field.litpic!=''>
    <#list field.litpic?eval as img>
        ${img.url}
    </#list>
</#if>
```

没有图时用 `<#if field.litpic>` 换成默认图。标题放进 HTML 属性时用 `${field.title?replace('\"','')}`，或 `${MUtil.escape(field.title)}`。

## {ms:page.* /}

只放在列表模板，配合唯一一个 `{ms:arclist ispaging=true}`。自定义页、首页生成看不到分页。分页链接前加 `{ms:global.html/}`，搜索页 `search.htm` 除外，那里的分页地址本身已是完整路径。

| 标签 | 含义 |
|---|---|
| `{ms:page.index/}` | 首页 |
| `{ms:page.pre/}` | 上一页 |
| `{ms:page.next/}` | 下一页 |
| `{ms:page.last/}` | 末页 |
| `{ms:page.cur/}` | 当前页码 |
| `{ms:page.total/}` | 总页数 |
| `{ms:page.rcount/}` | 文章总数 |

无数据判断用 FreeMarker：`<#if page.rcount gt 0>`。默认皮肤的分页片段在 `template/1/default/page.htm`。每页条数由 `arclist` 的 `size` 决定。

`{@ms:pageurl/}` 写在列表页 `head` 里，会生成 `pageurl(页码)`。多个栏目合成一页、或分页样式要做成组件时，改调前台文章列表接口（见 [apis.md](apis.md) 的 `/cms/content/list`），不要用这组标签。

## 内容页 ${field.*}

内容模板直接写字段，对照 `template/1/default/news-detail.htm`。`${field.content}` 只能出现在内容页。`${field.hit}` 也要写在内容页，刷新才会累加点击。

| 字段 | 含义 |
|---|---|
| `${field.id}` `${field.title}` `${field.shorttitle}` | 编号、标题、副标题 |
| `${field.content}` | 正文 HTML |
| `${field.descrip}` `${field.keyword}` `${field.tags}` | 摘要、关键字、标签 |
| `${field.author}` `${field.source}` | 作者、来源 |
| `${field.date}` | `${field.date?string("yyyy-MM-dd")}` |
| `${field.hit}` | 点击，内容页会请求计数接口 |
| `${field.link}` | 当前文章路径 |
| `${field.litpic}` | 缩略图，用 `{@ms:file}` |
| `${field.typeid}` `${field.typepath}` 以及 `field.type*` | 与栏目标签相同 |
| `${pre.title}` `${pre.link}` `${pre.outlink}` | 上一篇。`pre.link` 为空时不要拼链接 |
| `${next.title}` `${next.link}` `${next.outlink}` | 下一篇 |

```html
上一篇：<a href="<#if pre.link !=''>{ms:global.html/}${pre.link}<#else>javascript:;</#if>">${pre.title}</a>
```

## {ms:data}

按文章编号取一篇，首页、列表、内容页、自定义页都能用。要自定义模型字段时必须带 `tableName`。

```html
{ms:data dataid="文章编号" tableName="mdiy_model_xxx"}
    <a href="{ms:global.html/}${field.link}">${field.title}</a>
    ${field.content}
{/ms:data}
```

字段与内容页相同。`dataid` 必填。

## 函数标签

| 标签 | 含义 |
|---|---|
| `{@ms:file 字段/}` | 上传文件的访问路径。文章图、栏目图、自定义配置里的图片都走它 |
| `{@ms:len 文本 长度/}` | 截取。超出时末尾是省略号，可见字数约为长度加 1 |
| `{@ms:tags/}` | 文章标签字符串，变量名 `tags`。首页是全部，列表页是当前栏目。拆开：`<#list tags?split(",") as content_tag>` |
| `<#include "header.htm">` | 同目录片段。不要写成相对路径 `../`，不用的 include 删掉整行 |
| `{@ms:fmt_url 变量/}` | 去掉 URL 里多余的 `//`。先 `<#assign u>...</#assign>` 再格式化 |

`{@ms:file_desc 图文字段/}` 取图文组件的描述。多张图文把字段 `?eval` 后读 `img.url`、`img.desc`。

## 搜索

默认模板是同级目录的 `search.htm`，表单提交到 `/mcms/search.do`。默认皮肤见 `header.htm`。

| 参数 | 含义 |
|---|---|
| `content_title` | 标题，默认皮肤只用了这一个 |
| `content_keyword` `content_author` `content_source` `content_description` `content_tag` `content_details` | 其他文章字段，表单 `name` 用这些名字 |
| `content_type` | 文章属性，如 `c,f` |
| `categoryIds` | 栏目范围。多个 id 逗号分隔。搜自定义模型字段时只能填一个叶子栏目 id |
| `tmpl` | 结果模板名，默认 `search.htm` |

结果页用 `{ms:arclist size=10 ispaging=true}` 输出，表单原值用 `${search.参数名}`。自定义模型列同样用 `${field.列名}`。第二个不受搜索条件影响的列表加上 `scope=true`。

## 逻辑

`<#if>`、`<#list>`、`<#assign>`、`<#include>` 与标签混写。多图、标签拆分用 `<#list 序列 as 项>`。空列表可以写成 `<#list 序列><#items as 项>...</#items><#else>无数据</#list>`。
