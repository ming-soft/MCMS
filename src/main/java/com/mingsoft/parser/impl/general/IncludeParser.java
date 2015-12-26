package com.mingsoft.parser.impl.general;

import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.mingsoft.parser.IParser;
import com.mingsoft.util.FileUtil;
import com.mingsoft.util.StringUtil;


/**
 * 引入文件标签 ,主要用于引入公用的HTML等文件 .filename 是相对ms:global.skin下面的文件名称(单标签) 网站全局标签 {ms:include filename="url"/}
 * 
 * @author 成卫雄 QQ:330216230 技术支持：景德镇铭飞科技 官网：www.ming-soft.com
 */
public class IncludeParser extends IParser {
	/**
	 * 文件的路径
	 */
	String path;
	
	
	/**
	 * 引入文件标签 ,主要用于引入公用的HTML等文件 .filename 是相对ms:global.skin下面的文件名称 网站全局标签 {ms:include filename="url"/}
	 */
	private final static String INCLUDE="\\{ms:include filename\\=(.*?)\\s*/}";

	/**
	 * include标签，
	 * @param htmlContent 原始html内容
	 * @param path 引入文件
	 * @param mobilePath 移动端模版目录名称，推荐mu
	 */
	public IncludeParser(String htmlContent, String path,String mobilePath) {
		super.mobilePath = mobilePath;
		super.htmlCotent = htmlContent;
		this.path = path;
		if (!StringUtil.isBlank(mobilePath)) {
			this.path =  path+File.separator+super.mobilePath;
		}
		
	}
	
	public IncludeParser(String htmlContent, String path) {
		super.htmlCotent = htmlContent;
		this.path = path;
	}

	@Override
	public String parse() {
		String html = super.htmlCotent; //原始内容
		int strNum = includeNum(super.htmlCotent);//检查个数
		while (strNum != 0) { //迭代
			// 取出模版内容
			String htmlInclude = includeContentPrase(super.htmlCotent, this.path);
			super.newCotent = htmlInclude;
			// 将取出的内容替换标签
			super.htmlCotent = super.replaceFirst(INCLUDE);
			html = super.htmlCotent;
			strNum = includeNum(super.htmlCotent);
		}

		return html;
	}

	/**
	 * 获取模中的要替换的引入文件的名字并读取出该文件
	 * 
	 * @param html
	 *            html模版
	 * @param path
	 *            文件的项目路径
	 * @return 返回读取出来的文件HTML
	 */
	private static String includeContentPrase(String html, String path) {
		String includeContent = "";
		Pattern patternL = Pattern.compile(INCLUDE);
		Matcher matcherL = patternL.matcher(html);
		if (matcherL.find()) {
			String includeName = matcherL.group(1);
			// 判断include文件是否存在
			File file = new File(path + File.separator + includeName);
			if (!file.exists()) {
				includeContent = includeName + "不存在，请仔细检查该模版的文件！";
			} else {
				includeContent = FileUtil.readFile(path + File.separator + includeName);
			}
		}
		return includeContent;
	}

	/**
	 * 获取模版文件中引入标签的个数
	 * 
	 * @param html
	 *            文件模版
	 * @return 返回该字符串的个数
	 */
	private int includeNum(String html) {
		int includeNum = count(html,INCLUDE);
		return includeNum;
	}
}
