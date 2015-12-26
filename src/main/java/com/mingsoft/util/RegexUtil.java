package com.mingsoft.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * 解析模版中正则表达式的工具类
 * 
 * @author 成卫雄 QQ:330216230 技术支持：景德镇铭飞科技 官网：www.ming-soft.com
 */
public class RegexUtil {
	/**
	 * 返回所有匹配的结果，并且是第find组
	 * 
	 * @param source
	 *            　模版
	 * @param regex
	 *            　标签
	 * @param find
	 *            　第几组　0:返回所有
	 * @return 匹配一次的值
	 */
	public static String parseFirst(String source, String regex, int find) {
		String content = null;
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(source);
		if (matcher.find()) {
			content = matcher.group(find);
		}
		return content;
	}

	/**
	 * 从find位置开始匹配所有返回
	 * 
	 * @param source
	 *            　模版
	 * @param regex
	 *            　标签
	 * @param find
	 *            　第几组　0:返回所有
	 * @return 匹配一次的值
	 */
	public static List<String> parseAll(String source, String regex, int find) {
		List<String> content = new ArrayList<String>();
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(source);
		while (matcher.find()) {
			content.add(matcher.group(find));
		}
		return content;
	}

	/**
	 * 从find位置开始匹配提供返回
	 * 
	 * @param source
	 *            　模版
	 * @param regex
	 *            　标签
	 * @param newContent
	 *            　新的内容
	 * @return 替换好的内容
	 */
	public static String replaceAll(String source, String regex, String newContent) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(source);
		while (matcher.find()) {
			source = matcher.replaceAll(Matcher.quoteReplacement(newContent.toString().replace("\\", "/")));
		}
		return source;
	}

	/**
	 * 替换第一个
	 * 
	 * @param source
	 *            原始内容
	 * @param regex
	 *            　正则
	 * @param newContent
	 *            　新内容
	 * @return　替换后的内容
	 */
	public static String replaceFirst(String source, String regex, String newContent) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(source);
		if (matcher.find()) {
			source = matcher.replaceFirst(Matcher.quoteReplacement(newContent));
		}
		return source;
	}

	/**
	 * 查询规则匹配次数
	 * 
	 * @param source
	 *            模版
	 * @param regex
	 *            标签
	 * @return 标签的数量
	 */
	public static int count(String source, String regex) {
		Pattern patternList = Pattern.compile(regex);
		Matcher matcherList = patternList.matcher(source);
		int i = 0;
		while (matcherList.find()) {
			i++;
		}
		return i;
	}
	
	/**
	 * 双重匹配(采集使用)
	 * @param globalRegex 第一层匹配正则表达式
	 * @param singleRegex 内层匹配正则表达式
	 * @param context 需要截取的内容
	 * @return Map key:在系统中的数据编号 value:名称
	 */
	public static Map<String,String> doubleRegex(String globalRegex,String singleRegex,String content){
		Map<String,String> map = new HashMap<String, String>();
		Pattern patternList = Pattern.compile(globalRegex);
		Matcher matcherList = patternList.matcher(content);		
		
		while (matcherList.find()) {
			Pattern _patternList = Pattern.compile(singleRegex);
			Matcher _matcherList = _patternList.matcher(matcherList.group());
			
			while (_matcherList.find()) {
				if(!StringUtil.isBlank(_matcherList.group(1)) && !StringUtil.isBlank(_matcherList.group(2))){
					map.put(_matcherList.group(1), _matcherList.group(2));
				}
			}		
			
		}
		return map;
	}
	
	/**
	 * 双重匹配;自定义map数据的数量(采集使用)
	 * @param globalRegex 第一层匹配正则表达式
	 * @param singleRegex 内层匹配正则表达式
	 * @param context 需要截取的内容
	 * @return Map key:i value:名称
	 */
	public static List<Map<Integer,String>> doubleRegexToMap(String globalRegex,String singleRegex,String content,int find){
		List<Map<Integer,String>> listAll = new ArrayList<Map<Integer,String>>();
		Pattern patternList = Pattern.compile(globalRegex);
		Matcher matcherList = patternList.matcher(content);		
		
		while (matcherList.find()) {
			Pattern _patternList = Pattern.compile(singleRegex);
			Matcher _matcherList = _patternList.matcher(matcherList.group());
			Map<Integer,String> map = new HashMap<Integer, String>();
			while (_matcherList.find()) {
				
				for(int i=0;i<find;i++){
					if(!StringUtil.isBlank(_matcherList.group(i+1))){
						map.put(i, _matcherList.group(i+1));
					}
				}
				
				listAll.add(map);
			}		
		}
		return listAll;
	}	
	
	/**
	 * 匹配一个正则表达式中的多个值
	 * @param content 匹配内容
	 * @param regex 正则表达式
	 * @param find 匹配值中的数量
	 * @return List
	 */
	public static List<String> parseAllToList(String content, String regex, int find) {
		List<String> list = new ArrayList<String>();
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(content);
		if (matcher.find()) {
			for(int i=0;i<find;i++){
				list.add( matcher.group(i+1));
			}
		}
		return list;
	}	
	
}
