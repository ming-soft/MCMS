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

package com.mingsoft.base.entity;


/**
 * json数据返回数据格式
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ResultJson {

	/**
	 * 模块编号
	 */
	private String code;
	
	/**
	 * 返回状态:true成功 false:失败
	 */
	private boolean result;
	
	/**
	 * 返回信息提示
	 */
	private String resultMsg;
	
	
	/**
	 * 返回数据
	 */
	private String resultData = "";

	/**
	 * 返回后跳的地址
	 */
	private String url;

	/**
	 * 获取后跳的地址
	 * @return 返回后跳的地址
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * 设置后跳的地址
	 * @param url 后跳地址
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * 获取模块编号
	 * @return 返回模块编号
	 */
	public String getCode() {
		return code;
	}

	/**
	 * 设置模块编号
	 * @param code 模块编号
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * 获取返回状态
	 * @return 返回状态
	 */
	public boolean isResult() {
		return result;
	}

	/**
	 * 设置返回状态
	 * @param result 返回状态
	 */
	public void setResult(boolean result) {
		this.result = result;
	}

	/**
	 * 设置返回信息提示
	 * @return 返回提示信息
	 */
	public String getResultMsg() {
		return resultMsg;
	}

	/**
	 * 设置返回信息提示
	 * @param resultMsg 返回提示信息
	 */
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	
	/**
	 * 获取返回数据
	 * @return 返回数据
	 */
	public String getResultData() {
		return resultData;
	}

	/**
	 *  设置返回数据
	 * @param resultData 返回数据
	 */
	public void setResultData(String resultData) {
		this.resultData = resultData;
	}

	
}