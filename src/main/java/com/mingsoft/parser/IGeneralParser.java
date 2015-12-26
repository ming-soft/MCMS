/**
 * 
 */
package com.mingsoft.parser;

import java.io.File;

import org.apache.log4j.Logger;

import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.base.constant.Const;
import com.mingsoft.parser.impl.general.GlobalCopyrightParser;
import com.mingsoft.parser.impl.general.GlobalDescripParser;
import com.mingsoft.parser.impl.general.GlobalHostParser;
import com.mingsoft.parser.impl.general.GlobalKeywordParser;
import com.mingsoft.parser.impl.general.GlobalLogoParser;
import com.mingsoft.parser.impl.general.GlobalNameParser;
import com.mingsoft.parser.impl.general.GlobalSkinUrlParser;
import com.mingsoft.parser.impl.general.GlobalUrlParser;
import com.mingsoft.parser.impl.general.IncludeParser;
import com.mingsoft.util.PageUtil;
import com.mingsoft.util.StringUtil;
 
/**
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * @author killfen
 * 
 *         <p>
 *         Comments:　ms平台通用标签解析
 *         </p>
 * 
 *         <p>
 *         Create Date:2015-4-19
 *         </p>
 * 
 *         <p>
 *         Modification history:
 *         </p>
 */
public abstract class IGeneralParser extends IParser {

	/**
	 * 移动端生成路径
	 */
	public static final Object MOBILE = "mobilePath";



	protected AppEntity app;

	protected String mobilePath = "";

	protected String htmlContent;

	protected PageUtil page;

	/**
	 * 模块模板路径，例如论坛、商城等
	 */
	protected String modelPath = "";

	/**
	 * 模块编号
	 */
	protected int modelId;

	public static final String MODEL_ID = "modelId", CUR_COLUMNID = "curColumnId", PREVIOUS = "previous", NEXT = "next", CUR_PAGE_NO = "curPageNo", LIST_LINK_PATH = "listLinkPath";

	/**
	 * 通用的标签解析方法，其他扩展方法务必要调用该方法，否则导致模板页面取不出基本数据，如：网站名称，网站的地址，关键字等待
	 * 
	 * @return　解析好的内容，一般不会出现什么问题，如果出现问题会返回注释格式的提示信息
	 */
	protected String parseGeneral() {
		htmlContent = new IncludeParser(htmlContent, Const.PROJECT_PATH + File.separator + IParserRegexConstant.REGEX_SAVE_TEMPLATE + File.separator + app.getAppId() + File.separator + app.getAppStyle() + File.separator + modelPath + File.separator, mobilePath).parse();
		// 替换网站版权信息标签：{ms: global.copyright/}
		htmlContent = new GlobalCopyrightParser(htmlContent, app.getAppCopyright()).parse();

		// 替换网站关键字标签:{ms: global.keyword/}
		htmlContent = new GlobalKeywordParser(htmlContent, app.getAppKeyword()).parse();

		// 替换网站LOGO标签：{ms: global.logo/}
		htmlContent = new GlobalLogoParser(htmlContent, app.getAppLogo()).parse();

		// 替换网站名称标签：{ms:global.name /}
		htmlContent = new GlobalNameParser(htmlContent, app.getAppName()).parse();

		// 替换模版链接地址标签：{ms: globalskin.url/}
		String tmpSkinUrl = app.getAppHostUrl() +  StringUtil.removeRepeatStr(File.separator + IParserRegexConstant.REGEX_SAVE_TEMPLATE + File.separator + app.getAppId() + File.separator + app.getAppStyle(), File.separator)+File.separator;
		// 替换网站链接地址标签:{ms:global.url/}
		String linkUrl = app.getAppHostUrl() + File.separator + IParserRegexConstant.HTML_SAVE_PATH + File.separator + app.getAppId()+File.separator;
		//如果论坛模板不为空，模板连接地址=原有地址+"/"+论坛模板
		if(!StringUtil.isBlank(modelPath)){
			tmpSkinUrl=tmpSkinUrl+ File.separator +modelPath;
			linkUrl=linkUrl+File.separator +modelPath;
		}
		//如果手机端模板不为空，模板连接地址=原有地址+"/"+手机模板
		if(!StringUtil.isBlank(this.mobilePath)){
			tmpSkinUrl=tmpSkinUrl+File.separator + this.mobilePath;
			linkUrl=linkUrl+File.separator +this.mobilePath;
		}
		//去掉重复的"/"
		//tmpSkinUrl = StringUtil.removeRepeatStr(tmpSkinUrl, File.separator);
		//linkUrl = StringUtil.removeRepeatStr(linkUrl, File.separator);
		htmlContent = new GlobalSkinUrlParser(htmlContent, tmpSkinUrl).parse();
		
		htmlContent = new GlobalUrlParser(htmlContent, linkUrl).parse();

		// 替换网站链接地址标签:{ms:global.host/}
		htmlContent = new GlobalHostParser(htmlContent, app.getAppHostUrl()).parse();

		// 替换网站描述标签:{ms: global.descrip/}
		htmlContent = new GlobalDescripParser(htmlContent, app.getAppDescription()).parse();
		return htmlContent;
	}

	/**
	 * 生成通用标签，
	 * 
	 * @param modelPath
	 *            对用模块模板路径
	 * @return 解析后的结果
	 */
	protected String parseGeneral(String modelPath) {
		this.modelPath = modelPath;
		return parseGeneral();
	}

	/**
	 * 会根据用户的请求客户端返回pc页面＼手机页面主机地址
	 * 
	 * @return　应用的主机地址
	 */
	protected String getWebsiteUrl() {
		if (!StringUtil.isBlank(mobilePath)) {
			return StringUtil.removeRepeatStr(app.getAppHostUrl() + File.separator + IParserRegexConstant.HTML_SAVE_PATH + File.separator + app.getAppId() + File.separator + mobilePath,File.separator);
		}
		return app.getAppHostUrl() + File.separator + IParserRegexConstant.HTML_SAVE_PATH + File.separator + app.getAppId();
	}

	/**
	 * 解析方法模板，最后调用该方法返回生成后的数据
	 * 
	 * @param html
	 *            模板源代码
	 * @param obj
	 *            　可选：便于子模块调用的时候进行参数扩展，具体的参数由子模块控制，例如解析分页模板的时候就需要外部传入地址，
	 * @return　生成好的html内容
	 */
	public abstract String parse(String html, Object... obj);

	@Override
	public String parse() {
		// TODO Auto-generated method stub
		return this.parse();
	}

	/**
	 * 解析器入口,通常第一个参数未appEntity,如果存在map类型,那么map的的键值为IGeneralParser常量
	 * 1、内容数据显示、列表数据、 a、cms 下的文章显示，当前文章的上一篇、下一篇、当前文章栏目 MsTagParser mtp = new
	 * MsTagParser(模块代码,ServletConext); Map map = new HashMap();
	 * map.put(CmsParser.PREVIOUS,preArticle);
	 * map.put(CmsParser.NEXT,preArticle); mtp.parse(app,article,);
	 * 
	 * b、cms列表，必须知道当前栏目信息 mtp.parse(app,article,column); 2、自动定义页面
	 * 
	 * @param obj
	 *            ，可以存在多个，对于基础数据类型可以使用map存储，对象直接传入
	 * @return
	 */
	public void init(Object... obj) {
		for (Object o : obj) {
			if (o != null) {
				if (o instanceof AppEntity) {
					this.app = (AppEntity) o;
				}
				if (o instanceof PageUtil) {
					this.page = (PageUtil) o;
				}
			}
		}
	}

}
