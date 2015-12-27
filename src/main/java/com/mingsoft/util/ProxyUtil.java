/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.mingsoft.util;

import java.util.Map;

import com.mingsoft.util.proxy.Proxy;
import com.mingsoft.util.proxy.Result;
/**
 * 
 *
 * <p>
 * <b>铭飞基础框架</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c)  2015-2016
 * </p>
 * 
 * @author 成卫雄 (qq:330216230)
 * 
 * <p>
 * Comments:代理请求工具类
 * </p>
 * 
 * <p>
 * Create Date:2015-5-11 下午7:42:09
 * </p>
 * 
 * <p>
 * Modification history:
 * </p>
 *
 */
public class ProxyUtil {
	
	/**
	 * 发送不带头部参数的post请求</br>
	 * @param url 发送请求的地址
	 * @param encode 请求编码
	 * @param params 发送参数
	 * @return 请求返回内容
	 */
	public static String postToContent(String url,String encode,Map<String,String> params){
		//实例化请求代理
		Proxy proxy = new Proxy();
		//通过代理发送请求
		Result result = proxy.post(url,null, params, encode);
		if(result == null){
			return null;
		}
		return result.getContent(encode);
	}
	
	
	public static String getToContent(String url,String encode,Map<String,String> params){
		//实例化请求代理
		Proxy proxy = new Proxy();
		//通过代理发送请求
		Result result = proxy.get(url,null, params,encode);
		if(result == null){
			return null;
		}
		return result.getContent(encode);		
	}
	
	
}