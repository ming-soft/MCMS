package com.mingsoft.basic.servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.base.entity.ResultJson;
import com.mingsoft.basic.biz.IAppBiz;
import com.mingsoft.basic.entity.AppEntity;
import com.mingsoft.base.constant.Const;
import com.mingsoft.base.constant.CookieConst;
import com.mingsoft.base.constant.ModelCode;
import com.mingsoft.base.constant.SessionConst;
import com.mingsoft.util.StringUtil;

/**
 * 基础通用servlet
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
@SuppressWarnings("serial")
public abstract class BaseServlet extends HttpServlet {
	
	/*
	 * log4j日志记录
	 */
	public Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 执行清理操作
	 */
	public void destroy() {
		super.destroy();
	}
	

	/** Wap网关Via头信息中特有的描述信息 */
	private static String mobileGateWayHeaders[] = new String[] { "ZXWAP",// 中兴提供的wap网关的via信息，例如：Via=ZXWAP
																			// GateWayZTE
																			// Technologies，
			"chinamobile.com",// 中国移动的诺基亚wap网关，例如：Via=WTP/1.1
								// GDSZ-PB-GW003-WAP07.gd.chinamobile.com (Nokia
								// WAP Gateway 4.1 CD1/ECD13_D/4.1.04)
			"monternet.com",// 移动梦网的网关，例如：Via=WTP/1.1
							// BJBJ-PS-WAP1-GW08.bj1.monternet.com. (Nokia WAP
							// Gateway 4.1 CD1/ECD13_E/4.1.05)
			"infoX",// 华为提供的wap网关，例如：Via=HTTP/1.1 GDGZ-PS-GW011-WAP2 (infoX-WISG
					// Huawei Technologies)，或Via=infoX WAP Gateway V300R001
					// Huawei Technologies
			"XMS 724Solutions HTG",// 国外电信运营商的wap网关，不知道是哪一家
			"wap.lizongbo.com",// 自己测试时模拟的头信息
			"Bytemobile",// 貌似是一个给移动互联网提供解决方案提高网络运行效率的，例如：Via=1.1 Bytemobile OSN
							// WebProxy/5.1
	};
	/** 电脑上的IE或Firefox浏览器等的User-Agent关键词 */
	private static String[] pcHeaders = new String[] { "Windows 98",
			"Windows ME", "Windows 2000", "Windows XP", "Windows NT", "Ubuntu" };
	/** 手机浏览器的User-Agent里的关键词 */
	private static String[] mobileUserAgents = new String[] { "Nokia",// 诺基亚，有山寨机也写这个的，总还算是手机，Mozilla/5.0
																		// (Nokia5800
																		// XpressMusic)UC
																		// AppleWebkit(like
																		// Gecko)
																		// Safari/530
			"SAMSUNG",// 三星手机
						// SAMSUNG-GT-B7722/1.0+SHP/VPP/R5+Dolfin/1.5+Nextreaming+SMM-MMS/1.2.0+profile/MIDP-2.1+configuration/CLDC-1.1
			"MIDP-2",// j2me2.0，Mozilla/5.0 (SymbianOS/9.3; U; Series60/3.2
						// NokiaE75-1 /110.48.125 Profile/MIDP-2.1
						// Configuration/CLDC-1.1 ) AppleWebKit/413 (KHTML like
						// Gecko) Safari/413
			"CLDC1.1",// M600/MIDP2.0/CLDC1.1/Screen-240X320
			"SymbianOS",// 塞班系统的，
			"MAUI",// MTK山寨机默认ua
			"UNTRUSTED/1.0",// 疑似山寨机的ua，基本可以确定还是手机
			"Windows CE",// Windows CE，Mozilla/4.0 (compatible; MSIE 6.0;
							// Windows CE; IEMobile 7.11)
			"iPhone",// iPhone是否也转wap？不管它，先区分出来再说。Mozilla/5.0 (iPhone; U; CPU
						// iPhone OS 4_1 like Mac OS X; zh-cn) AppleWebKit/532.9
						// (KHTML like Gecko) Mobile/8B117
			"iPad",// iPad的ua，Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X;
					// zh-cn) AppleWebKit/531.21.10 (KHTML like Gecko)
					// Version/4.0.4 Mobile/7B367 Safari/531.21.10
			"Android",// Android是否也转wap？Mozilla/5.0 (Linux; U; Android
						// 2.1-update1; zh-cn; XT800 Build/TITA_M2_16.22.7)
						// AppleWebKit/530.17 (KHTML like Gecko) Version/4.0
						// Mobile Safari/530.17
			"BlackBerry",// BlackBerry8310/2.7.0.106-4.5.0.182
			"UCWEB",// ucweb是否只给wap页面？ Nokia5800
					// XpressMusic/UCWEB7.5.0.66/50/999
			"ucweb",// 小写的ucweb貌似是uc的代理服务器Mozilla/6.0 (compatible; MSIE 6.0;)
					// Opera ucweb-squid
			"BREW",// 很奇怪的ua，例如：REW-Applet/0x20068888 (BREW/3.1.5.20; DeviceId:
					// 40105; Lang: zhcn) ucweb-squid
			"J2ME",// 很奇怪的ua，只有J2ME四个字母
			"YULONG",// 宇龙手机，YULONG-CoolpadN68/10.14 IPANEL/2.0 CTC/1.0
			"YuLong",// 还是宇龙
			"COOLPAD",// 宇龙酷派YL-COOLPADS100/08.10.S100 POLARIS/2.9 CTC/1.0
			"TIANYU",// 天语手机TIANYU-KTOUCH/V209/MIDP2.0/CLDC1.1/Screen-240X320
			"TY-",// 天语，TY-F6229/701116_6215_V0230 JUPITOR/2.2 CTC/1.0
			"K-Touch",// 还是天语K-Touch_N2200_CMCC/TBG110022_1223_V0801 MTK/6223
						// Release/30.07.2008 Browser/WAP2.0
			"Haier",// 海尔手机，Haier-HG-M217_CMCC/3.0 Release/12.1.2007
					// Browser/WAP2.0
			"DOPOD",// 多普达手机
			"Lenovo",// 联想手机，Lenovo-P650WG/S100 LMP/LML Release/2010.02.22
						// Profile/MIDP2.0 Configuration/CLDC1.1
			"LENOVO",// 联想手机，比如：LENOVO-P780/176A
			"HUAQIN",// 华勤手机
			"AIGO-",// 爱国者居然也出过手机，AIGO-800C/2.04 TMSS-BROWSER/1.0.0 CTC/1.0
			"CTC/1.0",// 含义不明
			"CTC/2.0",// 含义不明
			"CMCC",// 移动定制手机，K-Touch_N2200_CMCC/TBG110022_1223_V0801 MTK/6223
					// Release/30.07.2008 Browser/WAP2.0
			"DAXIAN",// 大显手机DAXIAN X180 UP.Browser/6.2.3.2(GUI) MMP/2.0
			"MOT-",// 摩托罗拉，MOT-MOTOROKRE6/1.0 LinuxOS/2.4.20 Release/8.4.2006
					// Browser/Opera8.00 Profile/MIDP2.0 Configuration/CLDC1.1
					// Software/R533_G_11.10.54R
			"SonyEricsson",// 索爱手机，SonyEricssonP990i/R100 Mozilla/4.0
							// (compatible; MSIE 6.0; Symbian OS; 405) Opera
							// 8.65 [zh-CN]
			"GIONEE",// 金立手机
			"HTC",// HTC手机
			"ZTE",// 中兴手机，ZTE-A211/P109A2V1.0.0/WAP2.0 Profile
			"HUAWEI",// 华为手机，
			"webOS",// palm手机，Mozilla/5.0 (webOS/1.4.5; U; zh-CN)
					// AppleWebKit/532.2 (KHTML like Gecko) Version/1.0
					// Safari/532.2 Pre/1.0
			"GoBrowser",// 3g GoBrowser.User-Agent=Nokia5230/GoBrowser/2.0.290
						// Safari
			"IEMobile",// Windows CE手机自带浏览器，
			"WAP2.0"// 支持wap 2.0的
	};

	/**
	 *  使过滤器为处理做准备
	 */
	public void init() throws ServletException {
		super.init();
	}

	/**
	 * 输出html文本
	 * 
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse 对象
	 * @param html html文本内容
	 */
	protected void sendHtml(HttpServletRequest request,
			HttpServletResponse response, String html) {
		try {
			PrintWriter out = response.getWriter();
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8".toString());
			out.write(html.toString());
			out.close();
		} catch (IOException e) {
			logger.error(e);
		}
	}
	

	/**
	 * 获取用户真实IP
	 * 
	 * @param request HttpServletRequest对象
	 * @return 返回用户IP
	 */
	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 获取请求的数据流，主要提供给微信平台接口使用
	 * @param request HttpServletRequest对象
	 * @return 返回请求的数据流，例如：微信平台会返回JSON或xml字符串
	 */
	public String readStreamParameter(HttpServletRequest request) {
		StringBuilder buffer = new StringBuilder();
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new InputStreamReader(request.getInputStream(),"utf-8"));
			String line = null;
			while ((line = reader.readLine()) != null) {
				buffer.append(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != reader) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return buffer.toString();
	}
	
	/**
	 * 输出String数据字符串
	 * @param response HttpServletResponse 对象
	 * @param dataStr 数据对象
	 */
	protected void outString(HttpServletResponse response,Object dataStr) {
		try {
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8".toString());
			PrintWriter out = response.getWriter();
			out.print(dataStr);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			logger.error(e);
		}
	}
	
	/**
	 * 输出json数据字符串
	 * @param response HttpServletResponse 对象
	 * @param jsonDataStr json数据对象
	 */
	protected void outJson(HttpServletResponse response,Object jsonDataStr) {
		try {
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(jsonDataStr);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 设置session
	 * @param request HttpServletRequest 对象
	 * @param key 键SessionConst里面定义
	 * @param obj 对象
	 */
	protected void setSession(HttpServletRequest request,SessionConst key,Object obj) {
		if (StringUtil.isBlank(obj.toString())) {
			return;
		}
		request.getSession().setAttribute(key.toString(), obj);
	}
	
	
	/**
	 * 获取session
	 * @param request HttpServletRequest 对象
	 * @param key 键SessionConst里面定义
	 */
	protected Object getSession(HttpServletRequest request,SessionConst key) {
		return request.getSession().getAttribute(key.toString());
	}
	
	/**
	 * 设置Cookie的attr中的值
	 * @param request HttpServletRequest对象
	 * @param response HttpServletResponse 对象
	 * @param key 枚举类中的值
	 * @param value 存储对象
	 */
	protected void setCookie(HttpServletRequest request,HttpServletResponse response,CookieConst key, Object value) {
		request.getSession().setAttribute(key.toString(), value);
		Cookie cookie = new Cookie(key.name(), (String) value);
		cookie.setPath("/");
		cookie.setValue((String) value);
		response.addCookie(cookie);
	}


	
	/**
	 * 获取项目路径
	 * @param request HttpServletRequest对象
	 * @return 返回项目路径，例如：http://www.ip.com/projectName 后面没有反斜杠，后面接地址或参数必须加/
	 */
	protected String getUrl(HttpServletRequest request) {
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName();
		if (request.getServerPort()==80) {
			basePath +=  path;
		} else {
			basePath += ":" + request.getServerPort() + path;
		}
		return basePath;
	}
	
	/**
	 * 获取请求域名，域名不包括http请求协议头
	 * @param request HttpServletRequest对象
	 * @return 返回域名地址
	 */
	protected String getDomain(HttpServletRequest request) {
		String path = request.getContextPath();
		String domain = request.getServerName();
		if (request.getServerPort() == 80) {
			domain += path;
		} else {
			domain += ":" + request.getServerPort() + path;
		}
		return domain;
	}

	/**
	 * 输出json数据
	 * @param resp HttpServletRequest对象
	 * @param code 模块编号<br/>
	 * @param flag 成功状态,true:成功、false:失败
	 * @param msg 提示信息
	 */
	protected void outJson(HttpServletResponse resp,ModelCode code, boolean flag, String msg) {
		try {
			ResultJson result = new ResultJson();
			if (code!=null) {
				result.setCode(code.toString());
			}
			result.setResult(flag);
			result.setResultMsg(msg);
			PrintWriter out = resp.getWriter();
			out.print(JSONObject.toJSON(result));
			logger.debug(JSONObject.toJSON(result));
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 输出json数据
	 * 
	 * @param resp HttpServletRequest对象
	 * @param code 模块编号<br/>
	 * @param flag 成功状态,true:成功、false:失败
	 * @param msg 提示信息
	 * @param data 返回数据
	 */
	protected void outJson(HttpServletResponse resp,ModelCode code, boolean flag, String msg,String data) {
		try {
			ResultJson result = new ResultJson();
			if (code!=null) {
				result.setCode(code.toString());
			}
			result.setResult(flag);
			result.setResultMsg(msg);
			result.setResultData(data);
			PrintWriter out = resp.getWriter();
			out.print(JSONObject.toJSON(result));
			logger.debug(JSONObject.toJSON(result));
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据字段获取请求参数中的字符串值
	 * @param request HttpServletRequest对象
	 * @param fieldName 字段名称
	 * @return 返回请求到的字符串，获取不到返回null
	 */
	protected String getString(HttpServletRequest request,String fieldName) {
		if (StringUtil.isBlank(request.getParameter(fieldName))) {
			return null;
		}
		return request.getParameter(fieldName);
	}
	
	/**
	 * 根据字段获取请求参数中的整型值
	 * @param request  HttpServletRequest对象
	 * @param fieldName 字段名称
	 * @return 返回请求到的整型值，获取不到返回0，也有例外，具体更具业务来定
	 */
	protected int getInt(HttpServletRequest request,String fieldName) {
		if (!StringUtil.isInteger(request.getParameter(fieldName))) {
			return 0;
		}
		return Integer.parseInt(request.getParameter(fieldName));
	}
	
	/**
	 * 根据字段获取请求参数中的整型值
	 * @param request HttpServletRequest对象
	 * @param fieldName 字段名称
	 * @param defaultValue 默认值
	 * @return 返回请求到的整型值，获取不到返回默认值
	 */
	protected int getInt(HttpServletRequest request,String fieldName,int defaultValue) {
		if (!StringUtil.isInteger(request.getParameter(fieldName))) {
			return defaultValue;
		}
		return Integer.parseInt(request.getParameter(fieldName));
	}
	
	/**
	 * 通过spring的webapplicationcontext上下文对象读取bean对象
	 * @param sc 上下文servletConext对象
	 * @param beanName 要读取的bean的名称
	 * @return 返回读取的对象，获取不到返回null
	 */
	protected Object getBean(ServletContext sc,String beanName) {
		return WebApplicationContextUtils.getWebApplicationContext(sc).getBean(beanName);
	}
	
	/**
	 * 获取当期项目物理路径
	 * @param request HttpServletRequest对象
	 * @param filePath　相对文件夹
	 * @return 返回当前项目的物理路径
	 */
	protected String getRealPath(HttpServletRequest request,String filePath) {
		if (filePath!=null) {
			return request.getServletContext().getRealPath(File.separator)+File.separator+filePath;
		}
		return request.getServletContext().getRealPath(File.separator);
	}
	
	/**
	 * 读取国际化资源文件
	 * @param key 资源文件键值
	 * @return 返回键对应的值
	 */
	protected String getResString(String key) {
		return Const.RESOURCES.getString(key);
	}
	
	/**
	 * 读取国际化资源文件
	 * @param key 资源文件键值
	 * @param fullStrs 需填充的值
	 * @return 返回键对应的值
	 */
	protected String getResString(String key,String ... fullStrs) {
		String temp= Const.RESOURCES.getString(key);
		for (int i=0;i<fullStrs.length;i++) {
			temp = temp.replace("{"+i+"}",fullStrs[i]);
		}
		return temp;
	}	
	
	/**
	 * 根据地址来查询对应的站点信息，依赖于websiteBiz
	 * @param request HttpServletRequest对象
	 * @param appBiz  站点业务层
	 * @return 返回站点实体
	 */
	protected  AppEntity getApp(HttpServletRequest request,IAppBiz appBiz) {
		//查询数据库获取域名对应Id
		AppEntity website = appBiz.getByUrl(this.getUrl(request));
		if(website!=null){
			return website;
		}
		return null;
	}
	

	/**
	 * 根据当前请求的特征，判断该请求是否来自手机终端，主要检测特殊的头信息，以及user-Agent这个header
	 * 
	 * @param request HttpServletRequest对象
	 * @return 如果命中手机特征规则，则返回对应的特征字符串
	 */
	public boolean isMobileDevice(HttpServletRequest request) {
		boolean b = false;
		boolean pcFlag = false;
		boolean mobileFlag = false;
		String via = request.getHeader("Via");
		String userAgent = request.getHeader("user-agent");
		for (int i = 0; via != null && !via.trim().equals("")
				&& i < mobileGateWayHeaders.length; i++) {
			if (via.contains(mobileGateWayHeaders[i])) {
				mobileFlag = true;
				break;
			}
		}
		for (int i = 0; !mobileFlag && userAgent != null
				&& !userAgent.trim().equals("") && i < mobileUserAgents.length; i++) {
			if (userAgent.contains(mobileUserAgents[i])) {
				mobileFlag = true;
				break;
			}
		}
		for (int i = 0; userAgent != null && !userAgent.trim().equals("")
				&& i < pcHeaders.length; i++) {
			if (userAgent.contains(pcHeaders[i])) {
				pcFlag = true;
				break;
			}
		}
		if (mobileFlag == true && pcFlag == false) {
			b = true;
		}
		return b;// false pc true shouji

	}
	
	/**
	 * 将请求的request的参数重新组装。主要是将空值的替换成null,因为requestMap空值是"",这样处理有利于外部判断,
	 * 同时将获取到的值映射到页面上
	 * 
	 * @param request HttpServletRequest对象
	 * @return　返回处理过后的数据
	 */
	protected Map<String, Object> assemblyRequestMap(HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, String[]> map = request.getParameterMap();
		Iterator<String> key = map.keySet().iterator();
		while (key.hasNext()) {
			String k = (String) key.next();
			String[] value = map.get(k);
			
			if (value.length == 1) {
				String temp = null;
				if (!StringUtil.isBlank(value[0])) {
					temp = value[0];
				}
				params.put(k, temp);
				request.setAttribute(k, temp);
			} else if (value.length == 0) {
				params.put(k, null);
				request.setAttribute(k, null);
			} else if (value.length > 1) {
				params.put(k, value);
				request.setAttribute(k, value);
			}
		}
		return params;
	}
	
}

