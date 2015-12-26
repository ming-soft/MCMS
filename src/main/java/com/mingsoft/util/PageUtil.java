package com.mingsoft.util;

/**
 * 
 * <p>
 * <b>铭飞基础框架</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author wangtp
 * 
 * @version 300-001-001
 * 
 *          <p>
 *          版权所有 铭飞科
 *          </p>
 * 
 *          <p>
 *          Comments: 分页通用模块<br/>
 *          提供两个构造方式：
 *           PageUtil(int pageNo, int recordCount, String linkUrl) 不需要设置一页显示数量 默认每页10条
 *           public PageUtil(int pageNo, int pageSize, int recordCount, String linkUrl) 可以手动设置分页数量
 *           
 * 
 *          </p>
 * 
 *          <p>
 *          Create Date:2013-12-29
 *          </p>
 * 
 *          <p>
 *          Modification history:
 *          </p>
 */
public class PageUtil {

	/**
	 * 首页
	 */
	protected int index;

	/**
	 * 首页连接地址
	 */
	protected String indexUrl;

	/**
	 * 上一页
	 */
	protected int previous;

	/**
	 * 上一页连接地址
	 */
	protected String previousUrl;

	/**
	 * 下一页
	 */
	protected int next;

	/**
	 * 下一页连接地址
	 */
	protected String nextUrl;

	/**
	 * 最后一页
	 */
	protected int last;

	/**
	 * 最后一页连接地址
	 */
	protected String lastUrl;
	/**
	 * 总记录数
	 */
	protected int recordCount;

	/**
	 * 连接地址，带http格式
	 */
	protected String linkUrl;

	/**
	 * 当前页码
	 */
	protected int pageNo;

	public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    /**
	 * 总页数
	 */
	protected int pageCount;

	/**
	 * 一页显示数量
	 */
	protected int pageSize = 10;
	
	/**
	 * 连接地址是否有参数 false:没有 true:有
	 */
	private boolean hasParams;
	
	
	/**
	 * 获取总页数
	 * @return
	 */
	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	/**
	 * 只提供给数据查询用。例如导出数据的记录现在，pageSize=9999,表示查询9999条记录，没有分页效果
	 * @param pageSize
	 */
	public PageUtil(int pageSize) {
		this.pageSize = pageSize;
		this.pageNo =0;
	}
	/**
	 * 初始化分页实体类,默认每页10条
	 * 
	 * @param pageNo
	 *            当前页码默认调用BaseAction的getPageNo()方法
	 * @param recordCount
	 *            总记录数
	 * @param linkUrl
	 *            分页连接地址
	 */
	public PageUtil(int pageNo, int recordCount, String linkUrl) {
		this.pageNo = pageNo-1;
		this.recordCount = recordCount;
		this.linkUrl = linkUrl==null?"":linkUrl;
		
		calculatePageCount();
	
	}

	/**
	 * 初始化分页实体类
	 * 
	 * @param pageNo
	 *            当前页码
	 * @param pageSize
	 * 			  一页显示的数量           
	 * @param recordCount
	 *            总记录数
	 * @param linkUrl
	 *            分页连接地址
	 */
	public PageUtil(int pageNo, int pageSize, int recordCount, String linkUrl) {
		this(pageNo,recordCount,linkUrl);
		this.pageSize = pageSize;
		calculatePageCount();
		
		if (this.pageNo+1>this.pageCount && this.pageCount>1) {
			this.pageNo = this.pageCount-1;
		}
	}
	
	/**
	 * 计算总页数
	 */
	private void calculatePageCount() {
		//判读连接地址是否有参数
		if (linkUrl.indexOf("?")>0) {
			hasParams = true;
		}
		//计算总页数
		if (this.recordCount==0) {
			pageCount = 0;
		} else {
			//判断是否有余数
			if(recordCount % pageSize==0){
				pageCount = recordCount / pageSize;
			} else {
				pageCount = recordCount / pageSize + 1;
			}
		}
		
		
	}
	
	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getPrevious() {
		return previous;
	}

	public void setPrevious(int previous) {
		this.previous = previous;
	}

	public int getNext() {
		return next;
	}

	public void setNext(int next) {
		this.next = next;
	}

	public int getLast() {
		return last;
	}

	public void setLast(int last) {
		this.last = last;
	}

	public int getRecordCound() {
		return recordCount;
	}
	
	/**
	 * 获取当前页码
	 * @return
	 */
	public int getPageNo() {
		return pageNo;
	}
	
	/**
	 * 获取首页链接地址
	 * @return
	 */
	public String getIndexUrl() {
		if (pageNo == 0) {
			indexUrl = "#";
		} else {
			indexUrl = this.linkUrl + (hasParams?"&":"?") +"pageNo=1";
		}
		return indexUrl;
	}

	/**
	 * 获取上一页的连接地址
	 * @return
	 */
	public String getPreviousUrl() {
		if (pageNo == 0) {
			previousUrl = "#";
		} else {
			previousUrl = this.linkUrl + (hasParams?"&":"?")+"pageNo=" + (pageNo);
		}
		return previousUrl;
	}
	
	/**
	 * 获取下也页的连接地址
	 * @return
	 */
	public String getNextUrl() {
		if (pageNo == pageCount) {
			nextUrl = "#";
		} else {
			if (pageNo+2>pageCount) {
				nextUrl = this.linkUrl + (hasParams?"&":"?") +"pageNo=" + pageCount;
			} else {
				nextUrl = this.linkUrl + (hasParams?"&":"?") +"pageNo=" + (pageNo+2);
			}
		}
		return nextUrl;
	}


	/**
	 * 获取最后一页
	 * @return http://weburl/?pageNo
	 */
	public String getLastUrl() {
		if (pageNo == pageCount) {
			lastUrl = "#";
		} else {
			lastUrl = this.linkUrl + (hasParams?"&":"?") +"pageNo=" + pageCount;
		}
		return lastUrl;
	}

	public int getPageSize() {
		return pageSize;
	}

	public String getLinkUrl() {
		return linkUrl+(hasParams?"&":"?");
	}

	public void setLinkUrl(String linkUrl) {
		
		this.linkUrl = linkUrl;
	}
	
	
	public static void main(String[] args) {
		String url = "http://localhost/mswx/admin/hotel/listHotel.do?1=1";
		System.out.println(url.indexOf("?"));
	}
}
