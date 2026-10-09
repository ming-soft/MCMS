# Java 分层

新后台业务按这个顺序加文件。包名用 `net.mingsoft.{模块}`，类名和表名沿用该模块已有前缀（内容模块是 `cms_`、`ICategoryDao`）。

对照实现（都在 `ms-mcms`）：

| 层 | 参照 |
|---|---|
| 实体 | `net.mingsoft.cms.entity.CategoryEntity` |
| Dao | `net.mingsoft.cms.dao.ICategoryDao` 与同目录 `ICategoryDao.xml` |
| Biz | `ICategoryBiz`、`CategoryBizImpl` |
| 后台接口 | `net.mingsoft.cms.action.CategoryAction` |
| 前台接口 | `net.mingsoft.cms.action.web.ContentAction` |
| 模块基类 | `net.mingsoft.cms.action.BaseAction` |
| 文案 | `net.mingsoft.cms.resources.resources_zh_CN.properties` |

## 实体

- 继承 `net.mingsoft.base.entity.BaseEntity`。基类已有 `id`、`createBy`、`createDate`、`updateBy`、`updateDate`、`del`。`remarks` 不是表字段。
- `@TableName("表名")`。主键字段再标 `@TableId(type = IdType.ASSIGN_ID)`，并覆盖 `getId` / `setId`。
- 允许更新成空的列，用 `@TableField(updateStrategy = FieldStrategy.ALWAYS)`，与栏目上的模板、父级字段同一写法。
- 不入库的属性加 `@TableField(exist = false)`。

## Dao

```java
@Component("模块功能Dao")
public interface IXxxDao extends IBaseDao<XxxEntity> {
}
```

`IBaseDao` 已继承 MyBatis-Plus 的 `BaseMapper`，单表增删改查不必再写 XML。自定义 SQL 才在接口同目录增加 `IXxxDao.xml`，`namespace` 写接口全限定名。

## Biz

```java
public interface IXxxBiz extends IBaseBiz<XxxEntity> {
}

@Service("模块功能BizImpl")
public class XxxBizImpl extends BaseBizImpl<IXxxDao, XxxEntity> implements IXxxBiz {
    @Autowired
    private IXxxDao xxxDao;

    @Override
    protected IBaseDao getDao() {
        return xxxDao;
    }
}
```

`IBaseBiz` 已包含 `IService` 的单表方法，以及 `queryForList`、`update` 等 SQL 入口。业务规则放 Biz，不放 Action。

## 后台 Action

```java
@Tag(name = "后端-某某模块接口")
@Controller("模块功能Action")
@RequestMapping("/${ms.manager.path}/模块/功能")
public class XxxAction extends BaseAction {
    @GetMapping("/index")
    @RequiresPermissions("模块:功能:view")
    public String index() {
        return "/模块/功能/index";
    }

    @PostMapping("/save")
    @ResponseBody
    @LogAnn(title = "保存某某", businessType = BusinessTypeEnum.INSERT)
    @RequiresPermissions("模块:功能:save")
    public ResultData save(@ModelAttribute XxxEntity entity) {
        return ResultData.build().success();
    }
}
```

约定：

- 页面方法返回模板路径，如 `/cms/category/index`，对应 `WEB-INF/manager` 下的 ftl。接口方法加 `@ResponseBody`。
- 查询用 `@GetMapping` 或 GET/POST 都接受的 `@RequestMapping`。保存 `@PostMapping("/save")`，更新 `/update`，删除 `/delete`。
- 空值和长度用 `StringUtils`、`StringUtil.checkLength`，错误信息走 `getResString("err.empty", ...)` 这类已有键。
- 权限四个动作固定为 `view`、`save`、`update`、`del`。查看和表单页用 `view`。
- `@LogAnn` 的 `businessType` 用 `BusinessTypeEnum` 的 `INSERT`、`UPDATE`、`DELETE`。

## 前台 Action

放在 `action.web`。`@Controller` 名字加 `Web` 前缀，映射不要带 `${ms.manager.path}`，不要加后台的 `@RequiresPermissions`。返回同样用 `ResultData`。

现成前台读栏目、文章的路径与参数见 [apis.md](apis.md)，二开调用先对照那里，不要另起一套 URL。

## 菜单

页面能打开之后，在后台模块管理新增菜单：

- `modelTitle`：菜单名
- `modelUrl`：去掉 `/ms` 后的页面地址，例如 `cms/category/index.do`
- `modelCode`：模块编码，不能与已有编码重复
- 父级用 `modelId`

然后给角色勾选该菜单。只加 Java 注解时，侧栏不会出现入口。
