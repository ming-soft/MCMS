# 铭飞 MCMS 项目说明（给任意 AI 工具）

本目录是普通 Markdown，不依赖 Cursor、WorkBuddy、豆包、千问或任何一家产品的私有 skill 格式。各工具只需要把文件交给模型阅读，内容保持这一份。

## 助手怎么用

1. 先读同目录的 [SKILL.md](SKILL.md)。
2. 按其中的「任务路由」再打开对应文件，不要一次把全部文件塞进上下文。
3. 改代码前对照硬规则；缺数据库脚本、缺模板包时向用户索取，不要编造。

| 任务 | 文件 |
|---|---|
| 总入口、决策、硬规则 | [SKILL.md](SKILL.md) |
| 安装、连库、jar、Nginx | [deploy.md](deploy.md) |
| MStore、现成皮肤导入 | [mstore.md](mstore.md) |
| 标签用法 | [tags.md](tags.md) |
| 前台 JS 读栏目/文章接口 | [apis.md](apis.md) |
| 模板放哪 | [templates.md](templates.md) |
| 模板/静态化排错 | [faq.md](faq.md) |
| 新 Java 分层 | [layers.md](layers.md) |
| Bean、Mapper、权限、XSS | [pitfalls.md](pitfalls.md) |

## 各工具接入方式

把本目录当作项目知识，或在每次开发对话开头附上 `SKILL.md`。

- 支持 `@文件` 的工具：先引用 `ms-mcms/skill/SKILL.md`，需要时再引用同目录其他文件。
- 只支持系统提示或知识库的工具：把 `SKILL.md` 设为项目指令；任务涉及模板、部署、新接口时，再附上对应文件。
- 本目录不在 Cursor 内置自动技能路径里，不会自己加载，必须显式引用。

不要把这些文件改写成某一家的 YAML skill、插件配置或专有目录结构。相对链接保持同一目录、一层深度。

## 验收清单

助手或维护者可用下面几条确认这套说明可用：

- [ ] 只读 `SKILL.md` 时，能知道工作目录必须是 `ms-mcms`、启动类是 `MSApplication`、后台是 `/ms/login.do`
- [ ] 用户说「做一套新站皮肤」时，会先走默认皮肤或 [mstore.md](mstore.md)，而不是从零发明标签
- [ ] 用户说「安装/部署」时，会打开 [deploy.md](deploy.md)，且在缺少 `mcms-dev.sql.zip` 时向用户要脚本
- [ ] 用户说「写栏目列表标签」时，会打开 [tags.md](tags.md)，参数同一行、链接用 `{ms:global.html/}`
- [ ] 用户说「接口取某栏目文章」时，会打开 [apis.md](apis.md)，用 `/cms/content/list.do`，不编造路径
- [ ] 用户说「加一个后台模块」时，会打开 [layers.md](layers.md)，并提醒登记菜单和 Shiro 权限
- [ ] 知道当前仓库 `store-client` 默认关闭，不会假定 MStore 已可用
- [ ] 所有内部链接都能在 `ms-mcms/skill/` 下打开，且未写入生产密码
