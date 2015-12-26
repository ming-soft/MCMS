package com.mingsoft.parser.impl.general;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.mingsoft.cms.entity.ColumnEntity;

import com.mingsoft.parser.IParser;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.RegexUtil;
import com.mingsoft.util.StringUtil;

/**
 * 栏目标签 (列表标签) {ms:channel type=son typeid=}：栏目父标标签 {/ms:channel}:栏目父标签
 * [field.typeindex/]：栏目序号标签 [field.typetitle/]：栏目名称标签 [field.typelink/]：栏目链接标签
 * [field.typekeyword/]：栏目关键字 [field.typedescrip/]：栏目描述
 * 
 * @author 成卫雄 QQ:330216230 技术支持：景德镇铭飞科技 官网：www.ming-soft.com
 */
public class ChannelParser extends IParser {

	/**
	 * 列表临时标签，开始标签
	 */
	private final static String TAB_BEGIN_LIST = "{MS:TAB}";

	/**
	 * 查找HTML中栏目列表的正则表达式的开始位置标签 栏目父标签 {ms:channel type=”sun” typeid=””}
	 */
	private final static String CHANNEL_BEGIN = "\\{ms:channel.*?\\}";

	/**
	 * 列表临时标签，结束标签
	 */
	private final static String TAB_END_LIST = "{/MS:TAB}";

	/**
	 * 查找HTML中栏目列表的正则表达式的结束位置标签 栏目父标签 {/ms:channel}
	 */
	private final static String CHANNEL_END = "\\{/ms:channel\\}";

	/**
	 * 列表临时标签，内容规则
	 */
	private final static String TAB_BODY = "\\{MS:TAB\\}([\\s\\S]*?)\\{/MS:TAB}";

	/**
	 * 栏目序号 根据显示条数显示的序号1 2 …..10 栏目子标签 [field.typeindex/]
	 */
	private final static String CHANNEL_INDEX = "\\[field.typeindex/\\]";

	/**
	 * 标题 栏目名称 栏目子标签 [field.typetitle/]
	 */
	private final static String CHANNEL_TITLE = "\\[field.typetitle/\\]";

	/**
	 * 栏目连接 栏目子标签 [field.typelink/]
	 */
	private final static String CHANNEL_LINK = "\\[field.typelink/\\]";

	/**
	 * 栏目关键字 栏目子标签 [field.typekeyword/]
	 */
	private final static String CHANNEL_KEYWORD = "\\[field.typekeyword/\\]";

	/**
	 * 栏目关键字 栏目子标签 [field.typekeyword/]
	 */
	private final static String CHANNEL_DESCRIP = "\\[field.typedescrip/\\]";
	
	/**
	 * 获取栏目id
	 */
	private final static String CHANNEL_FIELE_ID="\\[field.typeid/\\]";

	/**
	 * 分类选中样式
	 */
	public static final String CHANNEL_CLASS = "class";

	/**
	 * 栏目列表的属性 类型String 取值范围：son|top son表示下级栏目(默认值) top顶级栏目（非必填） 栏目父标签
	 * {ms:channel type=”sun” typeid=””}
	 */
	public static final String CHANNEL_TYPE = "type";

	/**
	 * 栏目列表的属性 类型String 取值范围：son|top son表示下级栏目(默认值) top顶级栏目（非必填） 栏目父标签
	 * {ms:channel type=”sun” typeid=””}
	 */
	public static final String CHANNEL_TYPE_SON = "son";

	/**
	 * 栏目列表的属性 类型String 取值范围：son|top son表示下级栏目(默认值) top顶级栏目（非必填） 栏目父标签
	 * {ms:channel type=”sun” typeid=””}
	 */
	public static final String CHANNEL_TYPE_TOP = "top";

	/**
	 * 栏目列表的属性 类型String 取值范围：son|top|level son表示下级栏目(默认值) top顶级栏目（非必填） level取同一级
	 * 栏目父标签 {ms:channel type=”sun” typeid=””}
	 */
	public static final String CHANNEL_TYPE_LEVEL = "level";

	/**
	 * 栏目列表的属性 类型int 默认当前页面的栏目编号（非必填） 栏目父标签 {ms:channel type=”sun” typeid=}
	 */
	public static final String CHANNEL_TYPEID = "typeid";

	/**
	 * 当前选中类别样式
	 */
	public static final String CHANNEL_FIELD_CLASS = "\\[field.class/\\]";
	
	/**
	 * 分类是否显示子分类的属性名
	 * sibling=true：当该分类下没有子分类时显示其同级栏目
	 * sibling=false:当该分类下没有子分类时则不显示
	 */
	public static final String CHANNEL_TYP_SIBLING="sibling";

	/**
	 * 当前栏目
	 */
	private int curColumnId;

	/**
	 * 选中样式
	 */
	private String className;

	/**
	 * 构造替换栏目标签的必须参数
	 * 
	 * @param htmlCotent
	 *            HTML模版
	 * @param newContent
	 *            替换内容
	 */
	public ChannelParser(String htmlCotent, List<ColumnEntity> newContent, String page) {
		// 在HTML模版中标记出要用内容替换的标签
		String htmlCotents = channelPrplace(htmlCotent, TAB_BEGIN_LIST, CHANNEL_BEGIN);
		htmlCotents = channelPrplace(htmlCotents, TAB_END_LIST, CHANNEL_END);
		// 经过遍历后的数组标签
		super.newCotent = articleTypeList(htmlCotents, newContent, page);
		super.htmlCotent = htmlCotents;
	}

	/**
	 * 构造替换栏目标签的必须参数
	 * 
	 * @param htmlCotent
	 *            HTML模版
	 * @param newContent
	 *            替换内容
	 * @param page
	 * @param curColumnId
	 *            当前分类id
	 * @param className
	 *            选中分类样式
	 */
	public ChannelParser(String htmlCotent, List<ColumnEntity> newContent, String page, int curColumnId, String className) {
		this.curColumnId = curColumnId;
		this.className = className;
		// 在HTML模版中标记出要用内容替换的标签
		String htmlCotents = channelPrplace(htmlCotent, TAB_BEGIN_LIST, CHANNEL_BEGIN);
		htmlCotents = channelPrplace(htmlCotents, TAB_END_LIST, CHANNEL_END);
		// 经过遍历后的数组标签
		super.newCotent = articleTypeList(htmlCotents, newContent, page);
		super.htmlCotent = htmlCotents;
	}

	@Override
	public String parse() {
		// TODO Auto-generated method stub
		String channelHtml = this.replaceFirst(TAB_BODY);
		return channelHtml;
	}

	/**
	 * 将用需要用内容替换的标签换成标记标签
	 * 
	 * @param htmlCotent
	 *            原HTML文件
	 * @return 替换好标签后的HTNL文件
	 */
	private String channelPrplace(String htmlCotent, String regexTab, String regex) {
		String htmlCotents = "";
		super.htmlCotent = htmlCotent;
		super.newCotent = regexTab;
		htmlCotents = this.replaceFirst(regex);
		if (htmlCotents.equals("")) {
			htmlCotents = "标签格式错误";
		}
		return htmlCotents;
	}

	@Override
	public String replaceFirst(String regex) {
		return RegexUtil.replaceFirst(htmlCotent, regex, newCotent);
	}

	/**
	 * 替换的数组内容
	 * 
	 * @param htmlCotent
	 *            用标记标签替换好的HTML模版代码
	 * @param newContent
	 *            需要插入数组的内容
	 * @return 如果存在该标签返回替换后的标签和内容，如果不存在则返回空
	 */
	private String tabContent(String htmlCotent, String newContent, String regex) {
		if (StringUtil.isBlank(newCotent)) {
			newCotent = regex;
		}
		String htmlCotents = htmlCotent;
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(htmlCotent);
		if (matcher.find()) {
			htmlCotents = matcher.replaceAll(newContent.toString().replace("\\", "/"));
		}
		return htmlCotents;
	}

	/**
	 * 在替换好标签的HTML代码中将用标签替换的那段HTML代码截取出来
	 * 
	 * @param htmlCotent
	 *            替换好标签后的HTML代码
	 * @return 标签替换的那段HTML代码截取出来
	 */
	private String tabHtml(String htmlCotent) {
		Pattern patternList = Pattern.compile(TAB_BODY);
		Matcher matcherList = patternList.matcher(htmlCotent);
		if (matcherList.find()) {
			htmlCotent = matcherList.group(1);
		}
		return htmlCotent;
	}

	/**
	 * 遍历文章数组，将取出的内容替换标签 [field.typeindex/]：栏目序号标签 [field.typetitle/]：栏目名称标签
	 * [field.typelink/]：栏目链接标签
	 * 
	 * @param htmlCotent
	 *            原HTML代码
	 * @param articleList
	 *            文章数组
	 * @param webUrl
	 *            网站连接地址
	 * @return 用内容替换标签后的HTML代码
	 */
	private String articleTypeList(String htmlCotent, List<ColumnEntity> articleTypeList, String webUrl) {
		String tabHtml = tabHtml(htmlCotent);
		String htmlList = "";
		if (articleTypeList != null && articleTypeList.size() != 0) {
			for (int i = 0; i < articleTypeList.size(); i++) {
				ColumnEntity articleType = articleTypeList.get(i);
				// if (articleType.getCategoryCategoryId()==0) { //排除父节点
				// continue;
				// }
				// 替换栏目序号标签
				htmlList += tabContent(tabHtml, StringUtil.int2String((i + 1)), CHANNEL_INDEX);
				// 替换栏目标题标签
				htmlList = tabContent(htmlList, articleType.getCategoryTitle(), CHANNEL_TITLE);
				// 替换栏目链接标签

				String linkUrl = webUrl + File.separator + StringUtil.null2String(articleType.getColumnPath()) + File.separator + IParserRegexConstant.HTML_INDEX;
				linkUrl = StringUtil.removeRepeatStr(linkUrl, File.separator).replace(":/", "://");
				htmlList = tabContent(htmlList, linkUrl, CHANNEL_LINK);
				// 替换栏目关键字标签
				htmlList = tabContent(htmlList, articleType.getColumnKeyword(), CHANNEL_KEYWORD);
				// 替换栏目描述标签
				htmlList = tabContent(htmlList, articleType.getColumnDescrip(), CHANNEL_DESCRIP);
				//替换栏目id标签
				htmlList = tabContent(htmlList, articleType.getCategoryId()+"", CHANNEL_FIELE_ID);
				if (this.curColumnId == articleType.getCategoryId() && !StringUtil.isBlank(className)) {
					htmlList = tabContent(htmlList, className, CHANNEL_FIELD_CLASS);
				} else {
					htmlList = tabContent(htmlList, "", CHANNEL_FIELD_CLASS);
				}
			}
		}

		else {
			htmlList = IParserRegexConstant.REGEX_CHANNEL_ERRO;
		}
		return htmlList;
	}

	// ——————————————————————————————————解析父标签中的属性开始——————————————————————————————————
	/**
	 * 获取模版文件中栏目列表的个数
	 * 
	 * @param html
	 *            文件模版
	 * @return 返回该字符串的个数
	 */
	public static int channelNum(String html) {
		int channelNumBegin = count(html, CHANNEL_BEGIN);
		return channelNumBegin;
	}

	/**
	 * 定位栏目标签中所有的属性
	 */
	private final static String CHANNEL_PROPERTY = "\\{ms:channel(.*)?\\}";

	/**
	 * 取出栏目标签中的属性
	 * 
	 * @param html
	 *            HTML模版
	 * @return 属性集合
	 */
	public static Map<String, String> channelProperty(String html) {
		Map<String, String> listPropertyMap = new HashMap<String, String>();
		String listProperty = parseFirst(html, CHANNEL_PROPERTY, 1);

		List<String> listPropertyName = parseAll(listProperty, PRORETY_NAME, 1);
		List<String> listPropertyValue = parseAll(listProperty, PROPERTY_VALUE, 1);
		for (int i = 0; i < listPropertyName.size(); i++) {
			listPropertyMap.put(listPropertyName.get(i).toString(), listPropertyValue.get(i).toString());
		}
		return listPropertyMap;
	}
	// ——————————————————————————————————解析父标签中的属性结束——————————————————————————————————
}
