package com.mingsoft.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;


public class JsonUtil {

	/**
	 * 从一个JSON 对象字符格式中得到一个java对象
	 * 
	 * @param jsonString
	 * @param pojoCalss
	 * @return
	 */
	public static Object getObject4JsonString(String jsonString, Class<?> pojoCalss) {
		Object pojo;
//		JSONObject jsonObject = JSONObject.fromObject(jsonString);
//		pojo = JSONObject.toBean(jsonObject, pojoCalss);
		JSONObject jsonObject = JSONObject.parseObject(jsonString);
		pojo = JSONObject.toJavaObject(jsonObject, pojoCalss);
		return pojo;
	}

	/**
	 * 从json HASH表达式中获取一个map，改map支持嵌套功能
	 * 
	 * @param jsonString
	 * @return
	 */
	public static Map<String,Object> getMap4Json(String jsonString) {
//		JSONObject jsonObject = JSONObject.fromObject(jsonString);
		JSONObject jsonObject = JSONObject.parseObject(jsonString);
//		Iterator keyIter = jsonObject.keys();
		Iterator<String> keyIter = jsonObject.keySet().iterator();
		String key;
		Object value;
		Map<String,Object> valueMap = new HashMap<String,Object>();

		while (keyIter.hasNext()) {
			key = (String) keyIter.next();
			value = jsonObject.get(key);
			valueMap.put(key, value);
		}

		return valueMap;
	}

	/**
	 * 从json数组中得到相应java数组
	 * 
	 * @param jsonString
	 * @return
	 */
	public static Object[] getObjectArray4Json(String jsonString) {
//		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		return jsonArray.toArray();
	}

	/**
	 * 将一个对象转换为JSON字符串
	 * @param obj
	 * @return
	 */
	public static String getObjectToJsonObject(Object obj){
		return JSON.toJSON(obj).toString();
	}	
	
//	/**
//	 * 从json对象集合表达式中得到一个java对象列表
//	 * 
//	 * @param jsonString
//	 * @param pojoClass
//	 * @return
//	 */
//	@SuppressWarnings("unchecked")
//	public static List getList4Json(String jsonString, Class pojoClass) {
//
////		JSONArray jsonArray = JSONArray.fromObject(jsonString);
//		JSONObject jsonArray = JSONObject.parseObject(jsonString);
//		JSONObject jsonObject;
//		Object pojoValue;
//
//		List list = new ArrayList();
//		for (int i = 0; i < jsonArray.size(); i++) {
//
////			jsonObject = jsonArray.getJSONObject(i);
////			pojoValue = JSONObject.toBean(jsonObject, pojoClass);
//			jsonObject = jsonArray.get(i);
//			list.add(pojoValue);
//
//		}
//		return list;
//
//	}

	/**
	 * 从json数组中解析出java字符串数组
	 * 
	 * @param jsonString
	 * @return
	 */
	public static String[] getStringArray4Json(String jsonString) {

//		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		JSONArray jsonArray = JSONArray.parseArray(jsonString);
		
		String[] stringArray = new String[jsonArray.size()];
		
		for (int i = 0; i < jsonArray.size(); i++) {
			stringArray[i] = jsonArray.get(i).toString();
		}

		return stringArray;
	}

//	/**
//	 * 从json数组中解析出javaLong型对象数组
//	 * 
//	 * @param jsonString
//	 * @return
//	 */
//	public static Long[] getLongArray4Json(String jsonString) {
//
//		JSONArray jsonArray = JSONArray.fromObject(jsonString);
//		Long[] longArray = new Long[jsonArray.size()];
//		for (int i = 0; i < jsonArray.size(); i++) {
//			longArray[i] = jsonArray.getLong(i);
//
//		}
//		return longArray;
//	}
//
//	/**
//	 * 从json数组中解析出java Integer型对象数组
//	 * 
//	 * @param jsonString
//	 * @return
//	 */
//	public static Integer[] getIntegerArray4Json(String jsonString) {
//
//		JSONArray jsonArray = JSONArray.fromObject(jsonString);
//		Integer[] integerArray = new Integer[jsonArray.size()];
//		for (int i = 0; i < jsonArray.size(); i++) {
//			integerArray[i] = jsonArray.getInt(i);
//
//		}
//		return integerArray;
//	}
//
//	/**
//	 * 从json数组中解析出java Date 型对象数组，使用本方法必须保证
//	 * 
//	 * @param jsonString
//	 * @return
//	 */
//	public static Date[] getDateArray4Json(String jsonString, String DataFormat) {
//
//		JSONArray jsonArray = JSONArray.fromObject(jsonString);
//		Date[] dateArray = new Date[jsonArray.size()];
//		@SuppressWarnings("unused")
//		String dateString;
//		Date date = null;
//		for (int i = 0; i < jsonArray.size(); i++) {
//			dateString = jsonArray.getString(i);
//			// date = DateUtil.stringToDate(dateString, DataFormat);
//			dateArray[i] = date;
//
//		}
//		return dateArray;
//	}
//
//	/**
//	 * 从json数组中解析出java Integer型对象数组
//	 * 
//	 * @param jsonString
//	 * @return
//	 */
//	public static Double[] getDoubleArray4Json(String jsonString) {
//
//		JSONArray jsonArray = JSONArray.fromObject(jsonString);
//		Double[] doubleArray = new Double[jsonArray.size()];
//		for (int i = 0; i < jsonArray.size(); i++) {
//			doubleArray[i] = jsonArray.getDouble(i);
//
//		}
//		return doubleArray;
//	}
//
//	/**
//	 * 将java对象转换成json字符串
//	 * 
//	 * @param javaObj
//	 * @return
//	 */
//	public static String getJsonString4JavaPOJO(Object javaObj) {
//
//		JSONObject json;
//		json = JSONObject.fromObject(javaObj);
//		return json.toString();
//
//	}
//
//	/**
//	 * 将java对象转换成json字符串,并设定日期格式
//	 * 
//	 * @param javaObj
//	 * @param dataFormat
//	 * @return
//	 */
//	public static String getJsonString4JavaPOJO(Object javaObj, String dataFormat) {
//
//		JSONObject json;
//		JsonConfig jsonConfig = configJson(dataFormat);
//		json = JSONObject.fromObject(javaObj, jsonConfig);
//		return json.toString();
//
//	}
//
//	/**
//	 * JSON 时间解析器具
//	 * 
//	 * @param datePattern
//	 * @return
//	 */
//	public static JsonConfig configJson(String datePattern) {
//		JsonConfig jsonConfig = new JsonConfig();
//		jsonConfig.setExcludes(new String[] { "" });
//		jsonConfig.setIgnoreDefaultExcludes(false);
//		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
//		jsonConfig.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor(datePattern));
//
//		return jsonConfig;
//	}
//
//	/**
//	 * @param object
//	 *            任意对象
//	 * @return java.lang.String
//	 */
//	public static String objectToJson(Object object) {
//		StringBuilder json = new StringBuilder();
//		if (object == null) {
//			json.append("\"\"");
//		} else if (object instanceof String || object instanceof Integer) {
//			json.append("\"").append(object.toString()).append("\"");
//		} else {
//			json.append(beanToJson(object));
//		}
//		return json.toString();
//	}
//
//	/**
//	 * 功能描述:传入任意一个 javabean 对象生成一个指定规格的字符串
//	 * 
//	 * @param bean
//	 *            bean对象
//	 * @return String
//	 */
//	public static String beanToJson(Object bean) {
//		StringBuilder json = new StringBuilder();
//		json.append("{");
//		PropertyDescriptor[] props = null;
//		try {
//			props = Introspector.getBeanInfo(bean.getClass(), Object.class).getPropertyDescriptors();
//		} catch (IntrospectionException e) {
//		}
//		if (props != null) {
//			for (int i = 0; i < props.length; i++) {
//				try {
//					String name = objectToJson(props[i].getName());
//					String value = objectToJson(props[i].getReadMethod().invoke(bean));
//					json.append(name);
//					json.append(":");
//					json.append(value);
//					json.append(",");
//				} catch (Exception e) {
//				}
//			}
//			json.setCharAt(json.length() - 1, '}');
//		} else {
//			json.append("}");
//		}
//		return json.toString();
//	}
//
//	
//
//	
//	/**
//	 * 数组转换成json格式
//	 * @param list list集合
//	 * @return
//	 */
//	public static String listToJson(List list) {
//		return JSONArray.fromObject(list).toString();
//	}
//	/**
//	 * 
//	 * @param excludes
//	 * @param datePattern
//	 * @return
//	 */
//	public static JsonConfig configJson(String[] excludes, String datePattern) {
//		JsonConfig jsonConfig = new JsonConfig();
//		jsonConfig.setExcludes(excludes);
//		jsonConfig.setIgnoreDefaultExcludes(false);
//		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
//		jsonConfig.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor(datePattern));
//
//		return jsonConfig;
//	}
}