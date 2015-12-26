package com.mingsoft.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 * 
 * <p>
 * <b>铭飞科技J2EE基础框架</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2013 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author killfen
 * 
 * @version 100-000-000
 * 
 *          <p>
 *          版权所有
 *          </p>
 * 
 *          <p>
 *          Comments:字符串解析
 *          </p>
 * 
 *          <p>
 *          Create Date:2013-3-26
 *          </p>
 * 
 *          <p>
 *          Modification history:暂无
 *          </p>
 */
public class StringUtil {

	private static StringBuilder sb = new StringBuilder();

	public static boolean checkEmail(String email) {
		String regex = "^[a-zA-Z][a-zA-Z0-9._-]*\\@\\w+(\\.)*\\w+\\.\\w+$";
		Pattern p = Pattern.compile(regex);
		Matcher matcher = p.matcher(email);
		return matcher.matches();
	}

	/**
	 * 过滤html
	 * 
	 * @param html
	 * @return
	 */
	public static String formatHTMLIn(String html) {
		html = html.replaceAll("&", "&amp;");
		html = html.replaceAll("<", "&lt;");
		html = html.replaceAll(">", "&gt;");
		html = html.replaceAll("\"", "&quot;");
		return html;
	}

	/**
	 * 解析html
	 * 
	 * @param html
	 * @return
	 */
	public static String formatHTMLOut(String html) {
		html = html.replaceAll("&amp;", "&");
		html = html.replaceAll("&lt;", "<");
		html = html.replaceAll("&gt;", ">");
		html = html.replaceAll("&quot;", "\"");
		return html;
	}

	/**
	 * 截取字符长度
	 * 
	 * @param s
	 * @param length
	 * @return
	 */
	public static String subString(String s, int length) {
		if (isBlank(s))
			return "";
		if (s.getBytes().length <= length)
			return s;
		char ch[] = null;
		if (s.length() >= length)
			ch = s.substring(0, length).toCharArray();
		else
			ch = s.toCharArray();
		int readLen = 0;
		StringBuffer sb = new StringBuffer("");
		for (int i = 0; i < ch.length; i++) {
			String c = String.valueOf(ch[i]);
			readLen += c.getBytes().length;
			if (readLen > length)
				return sb.toString();
			sb.append(c);
		}
		return sb.toString();
	}

	/**
	 * 验证长度
	 * 
	 * @param str
	 * @param minLength
	 * @param maxLength
	 * @return
	 */
	public static boolean checkLength(String str, int minLength, int maxLength) {
		if (str != null) {
			int len = str.length();
			if (minLength == 0)
				return len <= maxLength;
			else if (maxLength == 0)
				return len >= minLength;
			else
				return (len >= minLength && len <= maxLength);
		}
		return false;
	}

	/**
	 * 解码
	 * 
	 * @param str
	 * @return
	 */
	public static String decodeStringByUTF8(String str) {
		if (isBlank(str))
			return "";
		try {
			return URLDecoder.decode(str, "utf-8");
		} catch (UnsupportedEncodingException e) {
		}
		return "";
	}

	/**
	 * 转码
	 * 
	 * @param str
	 * @return
	 */
	public static String encodeStringByUTF8(String str) {
		if (isBlank(str))
			return "";
		try {
			return URLEncoder.encode(str,"utf-8");
		} catch (UnsupportedEncodingException e) {
		}
		return "";
	}

	/**
	 * 程序内部字符串转码
	 * 
	 * @param str
	 * @return utf8编码字符串
	 */
	public static String isoToUTF8(String str) {
		if (isBlank(str))
			return "";
		try {
			return new String(str.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
		}
		return "";
	}

	/**
	 * 程序内部字符串转码
	 * 
	 * @param str
	 * @return utf8编码字符串
	 */
	public static String utf8ToISO(String str) {
		if (isBlank(str))
			return "";
		try {
			return new String(str.getBytes("UTF-8"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
		}
		return "";
	}

	public static String utf8Togb2312(String str) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);
			switch (c) {
			case '+':
				sb.append(' ');
				break;
			case '%':
				try {
					sb.append((char) Integer.parseInt(str.substring(i + 1, i + 3), 16));
				} catch (NumberFormatException e) {
					throw new IllegalArgumentException();
				}
				i += 2;
				break;
			default:
				sb.append(c);
				break;
			}
		}
		// Undo conversion to external encoding
		String result = sb.toString();
		String res = null;
		try {
			byte[] inputBytes = result.getBytes("8859_1");
			res = new String(inputBytes, "UTF-8");
		} catch (Exception e) {
		}
		return res;
	}

	/**
	 * 格式化时间
	 * 
	 * @param d
	 * @param pattern
	 * @return
	 */
	public static String getFormatDateStr(Date d, String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		return format.format(d);
	}

	/**
	 * 字段串是否为空
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isBlank(String str) {
		return (str == null || str.trim().equals("") || str.length() < 0);
	}

	/**
	 * 字段串是否为空
	 * 
	 * @param str
	 *            object对象
	 * @return
	 */
	public static boolean isBlank(Object str) {
		return (str == null || str.toString().trim().equals("") || str.toString().length() < 0);
	}

	/**
	 * 是否为数组
	 * 
	 * @param args
	 * @return
	 */
	public static boolean isBlank(String[] args) {
		return args == null || args.length == 0 ? true : false;
	}
	
	
	/**
	 * 判断数字类型
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isInteger(String str) {
		if (isBlank(str))
			return false;
		try {
			Integer.parseInt(str);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 判断数字类型
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isInteger(Object str) {
		String temp = str + "";
		if (isBlank(str))
			return false;
		try {
			Integer.parseInt(temp);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 当传入的值为NULL是将其转化为String
	 * 
	 * @param str
	 * @return""
	 */
	public static String null2String(String str) {
		if (str == null || str.equals("") || str.trim().length() == 0) {
			return str = "";
		}
		return str;
	}

	/**
	 * 将String型转换成Int型并判断String是否是NULL
	 * 
	 * @param str
	 * @return int
	 */
	public static int string2Int(String str) {
		int valueInt = 0;
		if (!StringUtil.isBlank(str)) {
			valueInt = Integer.parseInt(str);
		}
		return valueInt;
	}

	/**
	 * 变量形态转换 int型转为String型
	 * 
	 * @param comment
	 * @return
	 */
	public static String int2String(int comment) {
		String srt = "";
		srt = Integer.toString(comment);
		return srt;
	}

	/**
	 * 判断是否是大于0的参数
	 * 
	 * @param str
	 *            字符串参数
	 * @return true:大于0 false:非0 或小于0
	 */
	public static boolean isMaxZeroInteger(Object str) {
		if (isBlank(str))
			return false;
		try {
			int temp = Integer.parseInt(str.toString());
			return temp > 0;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 判断长整型
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isLong(String str) {
		if (isBlank(str))
			return false;
		try {
			Long.parseLong(str);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 判断长整型数组
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isLongs(String str[]) {
		try {
			for (int i = 0; i < str.length; i++)
				Long.parseLong(str[i]);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 判断数字数组
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isIntegers(String str[]) {
		try {
			for (int i = 0; i < str.length; i++)
				Integer.parseInt(str[i]);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 判断数字数组
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isDoubles(String str[]) {
		try {
			for (int i = 0; i < str.length; i++)
				Double.parseDouble(str[i]);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * md5
	 * 
	 * @param plainText
	 * @return
	 */
	public static String Md5(String plainText) {
		StringBuffer buf = new StringBuffer("");
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes());
			byte b[] = md.digest();
			int i = 0;
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return buf.toString();
	}

	/**
	 * 字符串转长整型数组
	 * 
	 * @param str
	 * @return
	 */
	public static long[] stringsToLongs(String str[]) {
		long lon[] = new long[str.length];
		for (int i = 0; i < lon.length; i++)
			lon[i] = Long.parseLong(str[i]);
		return lon;
	}

	/**
	 * 字符串转数字型数组
	 * 
	 * @param str
	 * @return
	 */
	public static Integer[] stringsToIntegers(String str[]) {
		Integer array[] = new Integer[str.length];
		for (int i = 0; i < array.length; i++)
			array[i] = Integer.parseInt(str[i]);
		return array;
	}

	/**
	 * 除去字符串数组中相同的值
	 * 
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String[] delLopStrings(String str[]) {
		@SuppressWarnings("rawtypes")
		ArrayList list = new ArrayList();
		for (int i = 0; i < str.length; i++) {
			if (!list.contains(str[i]))
				list.add(str[i]);
		}
		String array[] = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			array[i] = (String) list.get(i);
		}
		return array;
	}

	/**
	 * 字符串转布尔型数组
	 * 
	 * @param str
	 * @return
	 */
	public static boolean[] stringsToBooleans(String str[]) {
		boolean array[] = new boolean[str.length];
		for (int i = 0; i < array.length; i++)
			array[i] = Boolean.parseBoolean(str[i]);
		return array;
	}

	/**
	 * 判断日期
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isTimestamp(String str) {
		try {
			@SuppressWarnings("unused")
			Date d = java.sql.Date.valueOf(str);
			return true;
		} catch (Exception e) {
		}
		return false;
	}

	/**
	 * 当前页
	 * 
	 * @param start
	 * @return
	 */
	public static int getPageStart(String start) {
		int istart = 1;
		if (isBlank(start)) {
			return istart;
		}
		try {
			istart = Integer.parseInt(start) < 0 ? istart : Integer.parseInt(start);
		} catch (NumberFormatException e) {
		}
		return istart;
	}

	/**
	 * 获取时间戳
	 * 
	 * @return
	 */
	public static String getDateSimpleStr() {
		return String.valueOf(System.currentTimeMillis());
	}

	/**
	 * 字符串TO长整型
	 * 
	 * @param args
	 * @return
	 */
	public static Long[] StrToLong(String[] args) {
		if (args == null)
			return null;
		Long[] _ref = new Long[args.length];
		for (int i = 0; i < args.length; i++) {
			_ref[i] = new Long(args[i]);
		}
		return _ref;
	}

	/**
	 * 字符串TO整型
	 * 
	 * @param args
	 * @return
	 */
	public static Integer[] StrToInteger(String[] args) {
		if (args == null)
			return null;
		Integer[] _ref = new Integer[args.length];
		for (int i = 0; i < args.length; i++) {
			_ref[i] = new Integer(args[i]);
		}
		return _ref;
	}

	/**
	 * 获取日期字符串
	 * 
	 * @param d
	 * @param fomStr
	 * @return
	 */
	public static String getSimpleDateStr(Date d, String fomStr) {
		SimpleDateFormat format = new SimpleDateFormat(fomStr);
		return format.format(d);
	}

	/**
	 * 字符串返回时间
	 * 
	 * @param str
	 * @return
	 */
	public static Date getDateForStr(String str) {
		java.sql.Date sqlDate = java.sql.Date.valueOf(str);
		return sqlDate;
	}
	

	/**
	 * 指定时间增加天数
	 * 
	 * @param t
	 *            时间
	 * @param day
	 *            天数
	 * @return
	 */
	public static Date addDays(Date t, int day) {
		if (t == null)
			return null;
		Calendar c = Calendar.getInstance();
		c.setTime(t);
		c.set(Calendar.DAY_OF_MONTH, c.get(Calendar.DAY_OF_MONTH) + day);
		return c.getTime();
	}

	/**
	 * 指定时间增加月份
	 * 
	 * @param t
	 *            时间
	 * @param month
	 *            月份
	 * @return
	 */
	public static Date addMonths(Date t, int month) {
		if (t == null)
			return null;
		Calendar c = Calendar.getInstance();
		c.setTime(t);
		c.set(Calendar.MONTH, c.get(Calendar.MONTH) + month);
		return c.getTime();
	}

	/**
	 * 组合ip
	 * 
	 * @param ip
	 *            ip的字节数组形式
	 * @return 字符串形式的ip
	 */
	public static String getIpStringFromBytes(byte[] ip) {
		sb.delete(0, sb.length());
		sb.append(ip[0] & 0xFF);
		sb.append('.');
		sb.append(ip[1] & 0xFF);
		sb.append('.');
		sb.append(ip[2] & 0xFF);
		sb.append('.');
		sb.append(ip[3] & 0xFF);
		return sb.toString();
	}

	/**
	 * 判断IP是否相等
	 * 
	 * @param ip1
	 *            IP的字节数组形式
	 * @param ip2
	 *            IP的字节数组形式
	 * @return true如果两个IP相等
	 */
	public static boolean isIpEquals(byte[] ip1, byte[] ip2) {
		return (ip1[0] == ip2[0] && ip1[1] == ip2[1] && ip1[2] == ip2[2] && ip1[3] == ip2[3]);
	}

	/**
	 * 根据某种编码方式将字节数组转换成字符串
	 * 
	 * @param b
	 *            字节数组
	 * @param offset
	 *            要转换的起始位置
	 * @param len
	 *            要转换的长度
	 * @param encoding
	 *            编码方式
	 * @return 如果encoding不支持，返回一个缺省编码的字符串
	 */
	public static String getString(byte[] b, int offset, int len, String encoding) {
		try {
			return new String(b, offset, len, encoding);
		} catch (UnsupportedEncodingException e) {
			return new String(b, offset, len);
		}
	}

	/**
	 * 字符转换二进制数据
	 * 
	 * @param src
	 *            字节数组
	 * @return 字符串
	 */
	public static String stringToBinary(byte[] src) {
		StringBuffer sb = new StringBuffer();
		byte[][] des = new byte[src.length][16];
		for (int i = 0; i < src.length; i++)
			for (int j = 0; j < 16; j++)
				des[i][j] = (byte) ((src[i] >> j) & 0x1);

		for (int i = 0; i < src.length; i++) {
			for (int j = 0; j < 16; j++)
				sb.append(des[i][j]);
		}
		return sb.toString();
	}

	/**
	 * 生成随机数
	 * 
	 * @param len
	 *            随机数长度
	 * @return
	 */
	public static String randomNumber(int len) {
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < len; i++) {
			sb.append(Math.abs(random.nextInt()) % 10);
		}
		return sb.toString();
	}

	/**
	 * 系统时间秒
	 * 
	 * @return
	 */
	public static String timeForString() {
		Long l = System.currentTimeMillis();
		return String.valueOf(Math.abs(l.intValue()));
	}

	/**
	 * 获取参数
	 * 
	 * @param str
	 *            字符串
	 * @return 如果字符串为null 则返回一个空字符串
	 */
	public static String getParString(String str) {
		if (StringUtil.isBlank(str))
			return "";
		return str;
	}

	/**
	 * 判断是否是中文字符
	 * 
	 * @param c
	 * @return
	 */
	public static boolean isChinese(char c) {
		Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
		if (ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS || ub == Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS || ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A || ub == Character.UnicodeBlock.GENERAL_PUNCTUATION || ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION || ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS) {
			return true;
		}
		return false;
	}

	/**
	 * 验证手机号码
	 * 
	 * @param str
	 *            手机号码
	 * @return true:正确
	 */
	public static boolean isMobile(String str) {
		str = str.trim();
		String pattern = "^[1][1-8][0-9]{9}";
		return str.matches(pattern);
	}

	public static String formatResource(Object[] info, String require) {
		require = require.replaceAll("\'", "\"");
		String result = MessageFormat.format(require, info);
		return result.replaceAll("\"", "\'");
	}

	/**
	 * 计算两个时间间隔天数
	 * 
	 * @param startday
	 * @param endday
	 * @return
	 */
	public static int getDaysBetween(Calendar d1, Calendar d2) {
		if (d1.after(d2)) {
			java.util.Calendar swap = d1;
			d1 = d2;
			d2 = swap;
		}
		int days = d2.get(Calendar.DAY_OF_YEAR) - d1.get(Calendar.DAY_OF_YEAR);
		int y2 = d2.get(Calendar.YEAR);
		if (d1.get(Calendar.YEAR) != y2) {
			d1 = (Calendar) d1.clone();
			do {
				days += d1.getActualMaximum(Calendar.DAY_OF_YEAR);// 得到当年的实际天数
				d1.add(Calendar.YEAR, 1);
			} while (d1.get(Calendar.YEAR) != y2);
		}
		return days;
	}

	/**
	 * 读取文件后缀名称
	 * 
	 * @param filePath
	 *            文件路径 格式如:/../a.txt
	 * @return
	 */
	public static String getFileFix(String filePath) {
		String temp = "";
		if (filePath != null) {
			temp = filePath.substring(filePath.indexOf("."), filePath.length());
		}
		return temp;
	}

	/**
	 * 将数据流转换成字符串
	 * 
	 * @param is
	 *            数据流
	 * @return
	 */
	public static String convertStreamToString(InputStream is) {

		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();
		String line = null;

		try {

			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return sb.toString();

	}

	/**
	 * 检测字符串,处理utf-8的4个字节的问题
	 */
	public static String checkStr(String str) {
		String s = null;
		char[] cc = str.toCharArray();
		for (int i = 0; i < cc.length; i++) {
			boolean b = isValidChar(cc[i]);
			if (!b)
				cc[i] = ' ';
		}
		s = String.valueOf(cc);
		return s;
	}

	/**
	 * 判断是否是有效的中文字
	 */
	private static boolean isValidChar(char ch) {
		if ((ch >= '0' && ch <= '9') || (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z'))
			return true;
		if ((ch >= 0x4e00 && ch <= 0x7fff) || (ch >= 0x8000 && ch <= 0x952f))
			return true;// 简体中文汉字编码
		return false;
	}

	/**
	 * 除去字符窜中重复的字符
	 * 
	 * @param content
	 *            　原始内容
	 * @param target
	 *            　重复内容
	 * @return　除去后的字符串
	 */
	public static String removeRepeatStr(String content, String target) {
		// int index = content.indexOf(target);
		// content = checkRepeatStr( content,target,index);
		String newString = "";
		StringBuffer sb = new StringBuffer(content);
		for (int i = 0; i < sb.length()-1; i++) {

			if (sb.substring(i, i + target.length()).equals(target) && sb.substring(i, i + target.length()).equals(sb.substring(i + 1, i + target.length() + 1))) {
				sb.delete(i, i + target.length());
				if (i + target.length() + 1 > sb.length()) {
					break;
				} else {
					i--;
				}
			}

		}
		return sb.toString();
	}

	/**
	 * 验证邮箱格式
	 * 
	 * @param email
	 *            邮箱
	 * @return true:正确
	 */
	public static Boolean isEmail(String email) {
		boolean tag = true;
		final String pattern1 = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
		final Pattern pattern = Pattern.compile(pattern1);
		final Matcher mat = pattern.matcher(email);
		if (!mat.find()) {
			tag = false;
		}
		return tag;
	}

	/**
	 * 组织url 的get请求地址
	 * 
	 * @param url
	 *            原地址
	 * @param parm
	 *            参数 推荐格式:参数=值
	 * @return 新的地址
	 */
	public static String buildUrl(String url, String parm) {
		if (url.indexOf("?") > 0) {
			return url += "&" + parm;
		} else {
			return url += "?" + parm;
		}
	}
	
	/**
	 * 组织path路径, 例如:buildPath(a,b,c); 返回:a/b/c
	 * @param params 所有对象
	 * @return 新的路径地址
	 */
	public static String buildPath(Object... params) {
		String temp = "";
		for(Object o:params) {
			temp+=File.separator+o;
		} 
		return temp;
	}

	/**
	 * 组织url 的get请求地址
	 * 
	 * @param url
	 *            原地址
	 * @param parm
	 *            参数集合 格式:key参数=值value
	 * @return 新的地址
	 */
	public static String buildUrl(String url, Map parms) {
		Iterator key = parms.keySet().iterator();
		String paramsStr = "";
		while (key.hasNext()) {
			Object temp = key.next();
			if (isBlank(parms.get(temp))) {
				continue;
			}
			if (paramsStr != "") {
				paramsStr += "&";
			}
			paramsStr += (temp + "=" + parms.get(temp));
		}

		if (paramsStr != "") {
			if (url.indexOf("?") > 0) {
				return url += "&" + paramsStr;
			} else {
				return url += "?" + paramsStr;
			}
		}
		return url;
	}

	/**
	 * 使用 Map按key进行排序
	 * 
	 * @param map
	 * @return
	 */
	public static Map<String, String> sortMapByKey(Map<String, String> map) {
		if (map == null || map.isEmpty()) {
			return null;
		}
		Map<String, String> sortMap = new TreeMap<String, String>(new MapKeyComparator());
		sortMap.putAll(map);
		return sortMap;
	}
	
    /** 
     * 使用 Map按value进行排序 
     * @param map 
     * @return 
     */  
    public static Map<String, String> sortMapByValue(Map<String, String> map) {  
        if (map == null || map.isEmpty()) {  
            return null;  
        }  
        Map<String, String> sortedMap = new LinkedHashMap<String, String>();  
        List<Map.Entry<String, String>> entryList = new ArrayList<Map.Entry<String, String>>(map.entrySet());  
        Collections.sort(entryList, new MapValueComparator());  
        Iterator<Map.Entry<String, String>> iter = entryList.iterator();  
        Map.Entry<String, String> tmpEntry = null;  
        while (iter.hasNext()) {  
            tmpEntry = iter.next();  
            sortedMap.put(tmpEntry.getKey(), tmpEntry.getValue());  
        }  
        return sortedMap;  
    }  
    
	/**
	 * 字符串转数字型数组
	 * 
	 * @param str String字符串
	 * @return 返回数字型数组
	 */
	public static int[] stringsToInts(String str[]) {
		int array[] = new int[str.length];
		for (int i = 0; i < array.length; i++)
			array[i] = Integer.parseInt(str[i]);
		return array;
	}
    
    
    /**
     * 验证字符串是否符合单号规则，
     * 申通单号由12位数字组成，常见以268**、368**、58**等开头
     * EMS单号由13位字母和数字组成，开头和结尾二位是字母，中间是数字
     * 顺丰单号由12位数字组成，常见以电话区号后三位开头
     * 圆通单号由10位字母数字组成，常见以1*、2*、6*、8*、D*及V*等开头
     * 中通单号由12位数字组成，常见以2008**、6**、010等开头
     * 韵达单号由13位数字组成，常见以10*、12*、19*等开头
     * 天天单号由14位数字组成，常见以6**、5*、00*等开头
     * 汇通快递查询单号由13位数字编码组成，常见以0*或者B*、H*开头
     * 速尔的快递单号由12位数字组成的
     * 德邦的货运单号现在是以1或2开头的8位数字组成
     * 宅急送单号由10位数字组成，常见以7**、6**、5**等开头
     * @param no 需要验证的字符串
     * @return true是单号 false:不是单号
     */
    public static boolean isExpressNo(String no) {
    	if (StringUtil.isBlank(no)) {
    		return false;
    	}
    	//根据长度来判断
    	if (no.length()==13)  { //邮政EMS
    		return true;
    	} else if (no.length()==12)  { //中通
    		return true;
    	}
    	return true;
    }
}  

class MapKeyComparator implements Comparator<String> {
	public int compare(String str1, String str2) {
		return str1.compareTo(str2);
	}
}

class MapValueComparator implements Comparator<Map.Entry<String, String>> {  
    public int compare(Entry<String, String> me1, Entry<String, String> me2) {  
        return me1.getValue().compareTo(me2.getValue());  
    }  
}  
