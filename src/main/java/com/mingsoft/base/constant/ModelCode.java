package com.mingsoft.base.constant;

import com.mingsoft.base.constant.e.BaseEnum;

/**
 * 模块编号<br/>
 * 模块编号说明：八位整型数据<br/>
 *          项目编号(2位)+模块编号(2位)+功能编号(2位)+子功能编号(2位)<br/>
 *          如：01(微信项目编号)01(微页面模块编号)01(模版管理编号)01(添加模版)<br/>
 *          若为：01010100则代表整个模块管理功能模块<br/>
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public enum ModelCode implements BaseEnum{

	/**
	 * 登录模块编号
	 */
	ADMIN_LOGIN("00000000"),
	/**
	 * 权限管理:角色权限模块编号
	 */
	ROLE("01010000"),

	/**
	 * 管理员管理
	 */
	ROLE_MANAGER("01020000"),

	/**
	 * 内容：站点模块编号
	 */
	APP("02010000"),
	/**
	 * 内容：栏目模块编号
	 */
	CMS_COLUMN("02990000"),

	/**
	 * 内容：文章模块编号
	 */
	CMS_ARTICLE("02980100"),
	/**
	 * 内容：文章列表
	 */
	CMS_ARTICLE_BASIC("02980000"),
	/**
	 * 内容：自定义搜索
	 */
	CMS_SEARCH("02050000"),

	/**
	 * 内容：自定义模型
	 */
	CMS_CONTENT_MODEL("02060000"),

	/**
	 * 内容：一键更新
	 */
	CMS_GENERATE_ALL("02070100"),

	/**
	 * 内容：更新主页
	 */
	CMS_GENERATE_INDEX("02070200"),

	/**
	 * 内容：更新文档
	 */
	CMS_GENERATE_ARTICLE("02070300"),

	/**
	 * 内容： 更新栏目
	 */
	CMS_GENERATE_COLUMN("02070400"),

	/**
	 * 内容：模版
	 */
	CMS_TEMPLETSKIN("02080000"),
	
	
	
	/**
	 * 内容：织梦数据导入
	 */
	COM_DEDE_DATA_IMPORT("02090100"),
	
	/**
	 * 内容：栏目属性管理模块
	 */
	CMS_COLUMN_TYPE("02090200"),

	/**
	 * 评论系统:评论模块编号
	 */
	COMMENT("05010000"),



	/**
	 * 学校管理
	 */
	CURRICULUM_SCHOOL("03010100"),

	/**
	 * 系管理
	 */
	CURRICULUM_FACULTY("03010200"),

	/**
	 * 教室管理
	 */
	CURRICULUM_CLASS_ROOM("03010300"),

	/**
	 * 老师管理
	 */
	CURRICULUM_TEACHER("03010400"),

	/**
	 * 课程管理编号
	 */
	CURRICULUM_COURSE("03010500"),

	/**
	 * 初始化课表管理
	 */
	CURRICULUM("03020100"),

	/**
	 * 自定义课表管理
	 */
	CURRICULUM_CUSTOM("03020200"),

	/**
	 * 课表用户管理
	 */
	CURRICULUM_PEOPLE("03020300"),
	
	/**
	 * 微信图文素材
	 */
	WEIXIN_NEWS("05030100"),

	/**
	 * 微信图片素材
	 */
	WEIXIN_NEWS_IMAGE("05030200"),
	
	/**
	 * 微信文本素材
	 */
	WEIXIN_NEWS_TEXT("05030300"),
	
	/**
	 * 微信消息模块
	 */
	WEIXIN_MESSAGE("05050000"),
	
	/**
	 * 微信网页2.0授权管理
	 */
	WEIXIN_OAUTH("05070000"),
	
	/**
	 * 用户信息模块
	 */
	PEOPLE("07000000"),
	
	/**
	 * 用户注册
	 */
	PEOPLE_REGISTER("07010100"),
	
	/**
	 * 用户登录
	 */
	PEOPLE_LOGIN("07010200"),
	
	/**
	 * 普通用户管理
	 */
	PEOPLE_USER("07020100"),
	
	
	
	/**
	 * 关注
	 */
	ATTENTION("09000000"),
	

	
	/**
	 * 快递单号
	 */
	EXPRESS_NO("03980000"),
	/**
	 * 城市
	 */
	CITY("10990000"),
	
	/**
	 * 学校
	 */
	SCHOOL("10980000");
	

	
	/**
	 * 设置modelCode的常量
	 * @param code 常量
	 */
	ModelCode(String code) {
		this.code = code;
	}

	private String code;

	/**
	 * 返回该modelCode常量的字符串表示
	 * @return 字符串
	 */
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return code;
	}

	/**
	 * 返回该modelCode常量的整型表示
	 * @return 整型
	 */
	public int toInt() {
		// TODO Auto-generated method stub
		return Integer.parseInt(code);
	}
}
