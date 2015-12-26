package com.mingsoft.parser.impl.general;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import com.mingsoft.base.entity.BaseEntity;
import com.mingsoft.cms.biz.IContentModelBiz;
import com.mingsoft.cms.biz.IFieldBiz;
import com.mingsoft.cms.entity.ColumnEntity;
import com.mingsoft.cms.entity.ContentModelEntity;
import com.mingsoft.cms.entity.FieldEntity;

import com.mingsoft.parser.IParser;
import com.mingsoft.parser.IParserRegexConstant;
import com.mingsoft.util.RegexUtil;
import com.mingsoft.util.StringUtil;

/** 
 * 解析列表标签, {ms:arclist typeid= size= titlelen= flag = }:列表头标签,<br/>
 * {/ms:arclist}:列表尾标签,<br/>
 * 列表中的属性：<br/>
 * typeid 类型 int栏目ID,在列表模板和档案模板中一般不需要指定，在首页模板中允许用","分开表示多个栏目,<br/>
 * size 类型 int 返回文档列表总数,默认为20条全部返回，也可以配合分页使用,<br/>
 * titlelen 类型 int 标题长度,等同于titlelength。默认40个汉字,<br/>
 * flag 类型 String flag = c 自定义属性值：推荐[c]幻灯[f],<br/>
 * [field.index/]:序号,根据显示条数显示的序号1 2 …..10,<br/>
 * [field.id/]:编号,对应文章在数据库里的自动编号,<br/>
 * [field.title/]:标题,标题长度根据titlelen的属性值指定，默认40个汉字,<br/>
 * [field.fulltitle/]:全部标题,显示完整的标题,<br/>
 * [field.author/]:作者,<br/>
 * [field.source/]:来源,<br/>
 * [field.date fmt=”yyyy-mm-dd”/]:时间(非必填),<br/>
 * [field.content length=/]:内容,length=:内容的长度,指定获取文章长度(非必填),<br/>
 * [field.typename/]:分类名称，文章所属分类的名称,<br/>
 * [field.typeid/]:分类编号,文章所属分类的编号,<br/>
 * [field.typelink/]:分类连接,点击连接连接到当前分类的列表,<br/>
 * [field.link/]:内容链接,点击显示文章具体的内容地址,<br/>
 * 
 * @author 成卫雄 QQ:330216230 技术支持：景德镇铭飞科技 官网：www.ming-soft.com
 */
public abstract class ListParser extends IParser {
	
	/**
	 * 列表中的属性，noflag 类型 int noflag = 1 自定义属性值：不推荐[1]不幻灯[2] 文章列表属性标签 非必填
	 */
	public static final String LIST_NOFLAG = "noflag";
	/**
	 * 列表中的属性, typeid 类型 int栏目ID,在列表模板和档案模板中一般不需要指定，在首页模板中允许用","分开表示多个栏目
	 * 文章列表属性标签 必填
	 */
	public static final String LIST_TYPEID = "typeid";

	/**
	 * 列表中的属性，size 类型 int 返回文档列表总数,默认为20条全部返回，也可以配合分页使用 文章列表属性标签 非必填
	 */
	public static final String LIST_SIZE = "size";

	/**
	 * 列表中的属性，titlelen 类型 int 标题长度,等同于titlelength。默认40个汉字 文章列表属性标签 非必填
	 */
	public static final String LIST_TITLELENGTH = "titlelen";

	/**
	 * 列表中的属性，flag 类型 int flag = 1 自定义属性值：推荐[1]幻灯[2] 文章列表属性标签 非必填
	 */
	public static final String LIST_FLAG = "flag";

	/**
	 * 分页标签，true表示有分页
	 */
	public static final String LIST_ISPAGING = "ispaging";

	/**
	 * 文章列表中的属性, orderby 要进行排序的字段
	 */
	public static final String LIST_ORDERBY = "orderby";

	/**
	 * 文章列表中的属性, 默认(desc)升序，asc降序
	 */
	public static final String LIST_ORDER = "order";

	/**
	 * 列表属性
	 */
	protected Map<String, String> listProperty;
	
	/**
	 * 新增字段业务层
	 */

	protected IFieldBiz fieldBiz;
	
	/**
	 * 内容模型业务层
	 */

	protected IContentModelBiz contentBiz;
	
	/**
	 * option 选择框
	 */
	protected final static int OPTION=9;
	
	/**
	 * radio 选择按钮
	 */
	protected final static int RADIO=10;
	
	/**
	 * 图片路径分割符
	 */
	protected final static String OPREATE="\\|";
	
	/**
	 * 基础类中的基础id属性名
	 */
	protected final static String BasicID="basicId";
	
	/**
	 * checkbox 多选框
	 */
	protected final static int CHECKBOX = 11;
	
	/**
	 *  带分页列表头标签, 文章列表标签 {ms:arclist typeid= size= titlelen= flag = ispaging=}
	 */
	protected final static String LIST_PAGING="\\{ms:arclist.*.(ispaging=true){1}.*\\}";
	
	/**
	 *不带分页列表头标签, 文章列表标签 {ms:arclist typeid= size= titlelen= flag = }
	 */
	protected final static String LIST_NOPAGING="\\{ms:arclist(?![^\\{\\}]*? ispaging=true[^\\{\\}]*?}).*?\\}";
	
	/**
	 * 列表临时标签，内容规则
	 */
	protected final static String TAB_BODY="\\{MS:TAB\\}([\\s\\S]*?)\\{/MS:TAB}";
	
	/**
	 * 列表临时标签，开始标签
	 */
	protected final static String TAB_BEGIN_LIST="{MS:TAB}";
	
	/**
	 * 临时列表结束标签
	 */
	protected final static String LIST_TEMP_TAB_END="\\{MS:TAB}([\\s\\S]*?)(\\{\\/ms:arclist})";
	
	/**
	 * 列表尾标签 文章列表标签 {/ms:arclist}
	 */
	protected final static String LIST_END="\\{/ms:arclist\\}";
	
	/**
	 *  列表临时标签，结束标签
	 */
	protected final static String TAB_END_LIST="\\{/MS:TAB\\}";
	
	/**
	 * 文章列表子标签:序号,根据显示条数显示的序号1 2 …..10 文章列表子标签 [field.index/]
	 */
	protected final static String INDEX_FIELD_LIST="\\[field.index/\\]";
	
	/**
	 * 文章列表子标签:编号,对应文章在数据库里的自动编号 文章列表子标签 [field.id/]
	 */
	protected final static String ID_FIELD_LIST="\\[field.id/\\]";
	
	/**
	 * 标题,标题长度根据titlelen的属性值指定，默认40个汉字 文章列表子标签 [field.title/]
	 */
	protected final static String TITLE_FIELD_LIST="\\[field.title/\\]";
	
	/**
	 * 全部标题,显示完整的标题 文章列表子标签 [field.fulltitle/]
	 */
	protected final static String FULLTITLE_FIELD_LIST="\\[field.fulltitle/\\]";
	
	/**
	 * 作者 文章列表子标签 [field.author/]
	 */
	protected final static String AUTHOR_FIELD_LIST="\\[field.author/\\]";
	
	/**
	 *  来源 文章列表子标签 [field.source/]
	 */
	protected final static String SOURCE_FIELD_LIST="\\[field.source/\\]";
	
	/**
	 * 时间 文章列表子标签 fmt:时间的显示格式(非必填项) [field.date fmt="yyyy-mm-dd"/]
	 */
	protected final static String DATE_FIELD_LIST="\\[field.date\\s{0,}(fmt=(.*?))?/]";
	
	/**
	 *  内容 文章列表子标签 length:内容的长度,指定获取文章长度)(非必填) [field.content length=/]
	 */
	protected final static String CONTENT_FIELD_LIST="\\[field.content\\s{0,}(length=(\\d*).{0,})?/]";
	
	/**
	 * 分类名称，文章所属分类的名称 文章列表子标签 [field.typename/]
	 */
	protected final static String TYPENAME_FIELD_LIST="\\[field.typename/\\]";
	
	/**
	 *  内容链接 ,点击显示文章具体的内容地址 文章列表子标签 [field.link/]
	 */
	protected final static String LINK_FIELD_LIST="\\[field.link/\\]";
	
	/**
	 * 分类编号,文章所属分类的编号 文章列表子标签 [field.typeid/]
	 */
	protected final static String TYPEID_FIELD_LIST="\\[field.typeid/\\]";
	
	/**
	 * 文章缩略图 文章列表子标签 [field.litpic/]
	 */
	protected final static String LITPIC_FIELD_LIST="\\[field.litpic/\\]";
	
	/**
	 *  文章描述标签文章列表子标签[field.descrip/]
	 */
	protected final static String DESCIRIP_FIELD_LIST="\\[field.descrip/\\]";
	
	/**
	 * 当前页面文章的数量 文章列表子标签 [field.num/]
	 */
	protected final static String NUM_ARTICLE_LIST="\\[field.num/\\]";
	
	/**
	 * 分类连接, 点击连接连接到当前分类的列表 文章列表子标签 [field.typelink/]
	 */
	protected final static String TTYPELINK_FIELD_LIST="\\[field.typelink/\\]";
	
	
	/**
	 * 当前文章中的自定义标签[cfield.]
	 */
	protected final static String TAGLIB_ARTICLE_LIST="\\[cfield.(.*?)\\s*/\\]";
	
	/**
	 * 定位有分页列表标签属性
	 */
	protected final static String LIST_PAGING_PROPERTY="\\{ms:arclist(.*.(ispaging=true){1}.*)\\}";
	
	/**
	 * 定位没有分页列表标签中所有的属性
	 */
	protected final static String LIST_PROPERTY="\\{ms:arclist((?![^\\{\\}]*?ispaging=true[^{}]*?}).*?)\\}";
	
	/**
	 *  定位标签中属性的名称
	 */
	protected final static String PRORETY_NAME="(\\w*)\\s*=";
	
	/**
	 * 定位标签中属性的值
	 */
	protected final static String PROPERTY_VALUE="=\\s*((\\w.*?)[(?\\s)|}]|(\\w*)|)";// =\\s*(\\w.*?)[(?\\s)|}]
	
	
	@Override
	public String parse() {
		String listHtml = super.replaceAll(TAB_BODY);
		return listHtml;
	}
	
	protected abstract String list(String tabHtmlContent, String htmlContent, List<BaseEntity> articleList, String path) ;
	/**
	 * 临时将arclist替换成ms:tab
	 * 
	 * @param htmlCotent
	 *            原始内容
	 * @param regex
	 *            　规则，主要是两种，一种有分页，一种没有分页
	 * @return　替换好的内容
	 */
	protected String replaceStartAndEnd(String htmlCotent,String regex) {
		super.htmlCotent = htmlCotent;
		super.newCotent = TAB_BEGIN_LIST;
		htmlCotent = super.replaceFirst(regex);
		if (htmlCotent.equals("")) {
			htmlCotent = IParserRegexConstant.REGEX_ERRO;
		}
		Pattern pattern = Pattern.compile(LIST_TEMP_TAB_END);
		Matcher matcher = pattern.matcher(htmlCotent);
		if (matcher.find()) {
			String tmp = matcher.group();
			String tmp2 = tmp;
			tmp = tmp.replaceAll(LIST_END,TAB_END_LIST);
			htmlCotent = htmlCotent.replace(tmp2, tmp);
		}
		if (htmlCotent.equals("")) {
			htmlCotent = IParserRegexConstant.REGEX_ERRO;
		}
		return htmlCotent;
	}
	
	
	/**
	 * 替换自定义字段
	 * @param column 栏目id
	 * @param basicId 实体id
	 * @return
	 */
	protected String  replaceField(String htmlList,ColumnEntity column,int basicId){
		
		//判断该文章是否有扩展字段
		if(column.getColumnContentModelId()!=0){
			// 根据表单类型id查找出所有的字段信息
			List<BaseEntity> listField = fieldBiz.queryListByCmid(column.getColumnContentModelId());
			//遍历所有的字段实体,得到字段名列表信息
			List<String> listFieldName = new ArrayList<String>();
			for(int j = 0;j<listField.size();j++){
				FieldEntity field = (FieldEntity) listField.get(j);
				listFieldName.add(field.getFieldFieldName());
			}
			ContentModelEntity contentModel = (ContentModelEntity) contentBiz.getEntity(column.getColumnContentModelId());
			//判断内容模型是否存在
			if(contentModel==null){
				return htmlList;
			}
			// 组织where条件
			Map<String, Integer> where = new HashMap<String, Integer>();
			where.put(BasicID,basicId);
			// 获取各字段的值
			List fieldLists = fieldBiz.queryBySQL(contentModel.getCmTableName(), listFieldName, where);
			
			if(fieldLists!=null && fieldLists.size()>0){
				Map fields = (Map)fieldLists.get(0);
				//计算标签的个数
				int taglibNum = count(htmlList,TAGLIB_ARTICLE_LIST);
				while(taglibNum!=0){
					//String newCotent=taglibContentParser(htmlList,fields,contentModel.getCmId());
					String newCotent= taglibContentParser(listField,htmlList,fields,contentModel.getCmId());
					// 将取出的内容替换标签
					htmlList = replaceFirst(newCotent,TAGLIB_ARTICLE_LIST,htmlList);
					taglibNum = count(htmlList,TAGLIB_ARTICLE_LIST);
				}
			}
		}else{
			Pattern patternL = Pattern.compile(TAGLIB_ARTICLE_LIST);
			Matcher matcherL = patternL.matcher(htmlList);
			if (matcherL.find()){
				//查找出用户填写的自定义标签字段名
				htmlList = tabContent(htmlList, "",TAGLIB_ARTICLE_LIST);
			}
		}
		return htmlList;
	}
	
	/**
	 * 用该内容替换第一个当前找到的第一个标签
	 * 
	 * @param htmlCotent
	 *            源内容
	 * @param newCotent
	 *            替换内容
	 * @param regex
	 *            替换规则，
	 * @return 替换完成的HTML模版
	 */
	public String replaceFirst(String newContent ,String regex,String htmlList) {
		if (StringUtil.isBlank(newContent)) {
			newContent = IParserRegexConstant.REGEX_ERRO;
		}
		return RegexUtil.replaceFirst(htmlList, regex, newContent);
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
	protected String tabContent(String htmlCotent, Object newContent, String regex) {
		if (StringUtil.isBlank(newContent)) {
			newContent = IParserRegexConstant.REGEX_ERRO;
		}
		return RegexUtil.replaceAll(htmlCotent, regex, newContent.toString());
	}
	
	/**
	 * 获取字段名并获取相应的值
	 * @param html 原html代码
	 * @param field 各字段对应的值Map
	 * @param contentModelId 内容模型id
	 * @return
	 */
	protected String taglibContentParser(List<BaseEntity> listField,String html,Map field,int contentModelId){
		String taglibContent = "";
		Pattern patternL = Pattern.compile(TAGLIB_ARTICLE_LIST);
		Matcher matcherL = patternL.matcher(html);
		if (matcherL.find()) {
			//查找出用户填写的自定义标签字段名
			String fieldName = matcherL.group(1);
			Iterator<String> iter = field.keySet().iterator();
			FieldEntity fieldEntity =null;
			//判断该字段是否存在
			while (iter.hasNext()) {
			    String key = iter.next();
			    if(fieldName.equals(key)){
			    	for(int j = 0;j<listField.size();j++){
						FieldEntity fieldNewEntity = (FieldEntity) listField.get(j);
						if(fieldNewEntity.getFieldFieldName().equals(fieldName)){
							fieldEntity = fieldNewEntity;
						}
					}
			    	if(fieldEntity==null){
			    		break;
			    	}
			    	// 字段的实际值
	    			String fieldValue=String.valueOf(field.get(key));
			    	//判断是否为checkBox,或option类型
			    	if(fieldEntity.getFieldType()==OPTION || fieldEntity.getFieldType()==RADIO || fieldEntity.getFieldType()==CHECKBOX){
			    		String fieldDefault = fieldEntity.getFieldDefault();
			    		if(!StringUtil.isBlank(fieldDefault)){
			    			String[] filedNew = fieldDefault.split(",");
				    		//判断是否为checkBox
				    		if(fieldEntity.getFieldType()==CHECKBOX){
				    			String[] checkBox = field.get(key).toString().split(",");
				    			fieldValue = "";
				    			for(int i= 0;i<checkBox.length;i++){
				    				fieldValue+=filedNew[Integer.valueOf(checkBox[i].toString())-1];
				    			}
				    		}else{
				    			fieldValue = filedNew[Integer.valueOf(field.get(key).toString())-1];
				    		}
			    		}
			    	}
			    	taglibContent=fieldValue;
			    	break;
			    }
			}
		}
		return taglibContent;
	}
	

	/**
	 * 在替换好标签的HTML代码中将用标签替换的那段HTML代码截取出来
	 * 
	 * @param htmlCotent
	 *            替换好标签后的HTML代码
	 * @return 标签替换的那段HTML代码截取出来
	 */
	protected String tabHtml(String htmlCotent) {
		return RegexUtil.parseFirst(htmlCotent,TAB_BODY, 1);
	}

	/**
	 * 判断列表父标签中标题的长度
	 * 
	 * @param content
	 *            标题的内容
	 * @param htmlCotent
	 *            HTML模版
	 * @return 截取后的文章标题
	 */
	protected String titleLength(String content, String htmlCotent) {
		// 根据长度取出标题
		String contentNew = content;
		int length = StringUtil.string2Int(listProperty.get(LIST_TITLELENGTH));
		if (length != 0 && length < contentNew.length()) {
			StringBuffer strBuff = new StringBuffer(contentNew);
			contentNew = strBuff.substring(0, length);
		}
		return contentNew;
	}


	/**
	 * 判断列表标签中内容的长度
	 * 
	 * @param content
	 *            标题的内容
	 * @param htmlCotent
	 *            HTML模版
	 * @return 截取后的内容长度 v/
	 */
	protected String contentLength(String content, String htmlCotent) {
		// 从HTML代码中内容的长度，默认为全部显示
		int lengthCon = 0;
		String length = parseFirst(htmlCotent,CONTENT_FIELD_LIST, 2);
		if (!StringUtil.isBlank(length)) {
			lengthCon = Integer.parseInt(length);
		}
		// 根据长度取出内容
		String contentNew = content;
		if (lengthCon != 0 && !(lengthCon > contentNew.length())) {
			StringBuffer strBuff = new StringBuffer(contentNew);
			contentNew = strBuff.substring(0, lengthCon);
		}
		return contentNew;
	}

	/**
	 * 获取模版文件中文章列表的个数
	 * 
	 * @param html
	 *            文件模版
	 * @return 返回该字符串的个数
	 */
	public static int countArcList(String html) {
		int listNumBegin = count(html,LIST_NOPAGING);
		return listNumBegin;
	}
	
	
	
	/**
	 * 取出列表标签中的属性
	 * 
	 * @param html
	 *            HTML模版
	 * @param isPaging
	 *            true;为分页属性，false:为普通列表属性
	 * @return 属性集合Map(属性名称,属性值)
	 */
	public static Map<String, String> listProperty(String html, boolean isPaging) {
		Map<String, String> listPropertyMap = new HashMap<String, String>();
		String listProperty = "";
		if (isPaging) {
			listProperty = parseFirst(html,LIST_PAGING_PROPERTY, 1);
		} else {
			listProperty = parseFirst(html,LIST_PROPERTY, 1);
		}
		if (listProperty == null) {
			return listPropertyMap;
		}
		List<String> listPropertyName = parseAll(listProperty,PRORETY_NAME, 1);
		List<String> listPropertyValue = parseAll(listProperty,PROPERTY_VALUE, 1);
		for (int i = 0; i < listPropertyName.size(); i++) {
			listPropertyMap.put(listPropertyName.get(i).trim(), listPropertyValue.get(i).trim());
		}
		return listPropertyMap;
	}

}
