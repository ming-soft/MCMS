package com.mingsoft.util;


import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


/**
 * 
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
 * <p>
 * 版权所有
 * </p>
 *  
 * <p>
 * Comments:日期通用处理类
 * </p>
 *  
 * <p>
 * Create Date:2013-9-2
 * </p>
 *
 * <p>
 * Modification history:暂无
 * </p>
 */
public class DateUtil {

	private int year;

	private int month;

	private int day;

	private int hour;

	private int minute;

	private int second;

	private static final int[] dayArray = new int[] { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };// 每月的天数

	/**
	 * 标准日期格式 MM/dd/yyyy
	 */
	public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy");

	/**
	 * 标准时间格式 MM/dd/yyyy HH:mm
	 */
	public static final SimpleDateFormat DATE_TIME_FORMAT = new SimpleDateFormat("MM/dd/yyyy HH:mm");

	/**
	 * 带时分秒的标准时间格式 MM/dd/yyyy HH:mm:ss
	 */
	public static final SimpleDateFormat DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");

	/**
	 * ORA标准日期格式 yyyyMMdd
	 */
	public static final SimpleDateFormat ORA_DATE_FORMAT = new SimpleDateFormat("yyyyMMdd");

	/**
	 * ORA标准时间格式 yyyyMMddHHmm
	 */
	public static final SimpleDateFormat ORA_DATE_TIME_FORMAT = new SimpleDateFormat("yyyyMMddHHmm");

	/**
	 * 带时分秒的ORA标准时间格式 yyyyMMddHHmmss
	 */
	public static final SimpleDateFormat ORA_DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat("yyyyMMddHHmmss");

	/**
	 * yyyy-MM-dd
	 */
	public static final SimpleDateFormat CHN_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

	/**
	 * yyyy-MM-dd HH:mm
	 */
	public static final SimpleDateFormat CHN_DATE_TIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	/**
	 * yyyy-MM-dd HH:mm:ss
	 */
	public static final SimpleDateFormat CHN_DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /** 年月日时分秒(无下划线) yyyyMMddHHmmss */
    public static final String dtLong = "yyyyMMddHHmmss";
    
    /** 完整时间 yyyy-MM-dd HH:mm:ss */
    public static final String simple = "yyyy-MM-dd HH:mm:ss";
    
    /** 年月日(无下划线) yyyyMMdd */
    public static final String dtShort = "yyyyMMdd";	

    
    /**
     * 返回系统当前时间(精确到毫秒)</br>
     * @return
     *      以yyyyMMddHHmmss为格式的当前系统时间
     */
	public  static String getOrderNum(){
		Date date=new Date();
		DateFormat df=new SimpleDateFormat(dtLong);
		return df.format(date);
	}    
    
	/**
	 * 无参构造函数，默认的日期为系统时间
	 */
	public DateUtil() {
		today();
	}

	/**
	 * 有参构造函数
	 * 
	 * @param String
	 *            inValue 14位日期格式的字符串，不满14位的，后面补0处理<br>
	 *            列：new DataUtil("yyyyMMddHHmmss");
	 */
	DateUtil(String inValue) {
		SetDate(inValue);
	}

	/**
	 * 有参构造函数
	 * 
	 * @param long
	 *            mills 毫秒数<br>
	 */
	public DateUtil(long mills) {
		setTimeInMillis(mills);
	}

	/**
	 * 有参构造函数
	 * 
	 * @param int
	 *            year 年<br>
	 * @param int
	 *            month 月<br>
	 * @param int
	 *            day 日<br>
	 * @param int
	 *            hour 时<br>
	 * @param int
	 *            minute 分<br>
	 * @param int
	 *            second 秒<br>
	 */
	public DateUtil(int year, int month, int day, int hour, int minute, int second) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, day, hour, minute, second);
		this.year = calendar.get(Calendar.YEAR);
		this.month = calendar.get(Calendar.MONTH) + 1;
		this.day = calendar.get(Calendar.DAY_OF_MONTH);
		this.hour = calendar.get(Calendar.HOUR_OF_DAY);
		this.minute = calendar.get(Calendar.MINUTE);
		this.second = calendar.get(Calendar.SECOND);

	}

	/**
	 * 设置日期函数
	 * 
	 * @param inValue
	 */
	private void SetDate(String inValue) {
		if (inValue.length() != 14) {// 不够14位日期格式的，后面都补0处理
			for (int i = inValue.length(); i < 14; i++) {
				inValue = inValue + "0";
			}
			System.out.println(inValue);
		}
		try {

			int year = Integer.parseInt(inValue.substring(0, 4));
			int month = Integer.parseInt(inValue.substring(4, 6));
			int day = Integer.parseInt(inValue.substring(6, 8));
			int hour = Integer.parseInt(inValue.substring(8, 10));
			int minute = Integer.parseInt(inValue.substring(10, 12));
			int second = Integer.parseInt(inValue.substring(12));

			Calendar calendar = Calendar.getInstance();
			calendar.set(year, month - 1, day, hour, minute, second);
			this.year = calendar.get(Calendar.YEAR);
			this.month = calendar.get(Calendar.MONTH) + 1;
			this.day = calendar.get(Calendar.DAY_OF_MONTH);
			this.hour = calendar.get(Calendar.HOUR_OF_DAY);
			this.minute = calendar.get(Calendar.MINUTE);
			this.second = calendar.get(Calendar.SECOND);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	/**
	 * 取得当前时间
	 */
	private void today() {
		Calendar calendar = Calendar.getInstance();
		this.year = calendar.get(Calendar.YEAR);
		this.month = calendar.get(Calendar.MONTH) + 1;
		this.day = calendar.get(Calendar.DAY_OF_MONTH);
		this.hour = calendar.get(Calendar.HOUR_OF_DAY);
		this.minute = calendar.get(Calendar.MINUTE);
		this.second = calendar.get(Calendar.SECOND);
	}

	/**
	 * 
	 * 格式化日期
	 * 
	 * @param SimpleDateFormat
	 *            df 日期的格式 <br>
	 * @return String 字符串日期
	 */
	public String format(SimpleDateFormat df) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year, this.month - 1, this.day, this.hour, this.minute, this.second);
		return df.format(calendar.getTime());
	}

	/**
	 * toString方法 用yyyy-MM-dd HH:mm:ss格式
	 */
	public String toString() {
		return this.format(DateUtil.CHN_DATE_TIME_EXTENDED_FORMAT);
	}

	public Date getDate() {
		
		 Calendar date = Calendar.getInstance();
         date.set(Calendar.DAY_OF_MONTH, this.getDay());
         date.set(Calendar.MONTH,this.getMonth()-1);
         date.set(Calendar.YEAR,this.getYear());
         date.set(Calendar.HOUR_OF_DAY,this.getHour());
         date.set(Calendar.MINUTE,this.getMinute());
         date.set(Calendar.SECOND,this.getSecond());
		return date.getTime();

	}

	/**
	 * 
	 * 得到毫秒数 长整型
	 * 
	 * @return long
	 */
	public long getTimeInMillis() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year, this.month - 1, this.day, this.hour, this.minute, this.second);
		return calendar.getTime().getTime();
	}

	/**
	 * 根据毫秒数来设置日期
	 * 
	 * @param long mills 毫秒数
	 */
	public void setTimeInMillis(long mills) {
		Date dd = new Date(mills);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dd);
		this.year = calendar.get(Calendar.YEAR);
		this.month = calendar.get(Calendar.MONTH) + 1;
		this.day = calendar.get(Calendar.DAY_OF_MONTH);
		this.hour = calendar.get(Calendar.HOUR_OF_DAY);
		this.minute = calendar.get(Calendar.MINUTE);
		this.second = calendar.get(Calendar.SECOND);

	}

	/**
	 * 判断当前年是否是闰年
	 * 
	 * @return boolean true:闰年
	 */
	public boolean isLeapYear() {
		return this.isLeapYear(year);
	}

	/**
	 * 判断是否是闰年
	 * 
	 * @param int
	 *            year 年<br>
	 * @return boolean true:闰年
	 */
	public boolean isLeapYear(int year) {
		if ((year % 400) == 0)
			return true;
		else if ((year % 4) == 0) {
			if ((year % 100) == 0)
				return false;
			else
				return true;
		} else
			return false;
	}

	/**
	 * 日期增减操作
	 * 
	 * @param int
	 *            years 年数<br>
	 * @param int
	 *            months 月数<br>
	 * @param int
	 *            days 日数<br>
	 * @param int
	 *            hours 小时数<br>
	 * @param int
	 *            minutes 分数<br>
	 * @param int
	 *            seconds 秒数<br>
	 */
	public void setDateTime(int years, int months, int days, int hours, int minutes, int seconds) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year + years, this.month - 1 + months, this.day + days, this.hour + hours, this.minute + minutes, this.second + seconds);
		setTimeInMillis(calendar.getTime().getTime());
	}

	/**
	 * 年增减操作
	 * 
	 * @param int
	 *            years 年数 <br>
	 */
	public void addYear(int years) {
		if (month == 2 && day == 29)// 当前时间是闰年并且日期是2月29号
		{
			if (this.isLeapYear(year + years) == true)// 目标年是闰年时
				this.setDateTime(years, 0, 0, 0, 0, 0);
			else
				this.setDateTime(years, 0, -1, 0, 0, 0);// 目标年不是闰年，则2月只有28天，天数减去1
		} else
			this.setDateTime(years, 0, 0, 0, 0, 0);
	}

	/**
	 * 月增减操作(与oracle对月份增减的操作一样)
	 * 
	 * @param months
	 *            月数 <br>
	 */
	public void addMonth(int months) {
		int this_day_end = daysOfMonth();// 本月的天数
		int that_day_end = dayOfMonth(months);// 离现在n个月的天数
		if (this.day == this_day_end)
			this.day = that_day_end;// 如果现在是本月的最后一天,则day设置成that_day_end
		else if (this.day > that_day_end)
			this.day = that_day_end; // 如果离现在n个月的天数that_day_end比现在的day小,则现在的day设置成that_day_end

		this.setDateTime(0, months, 0, 0, 0, 0);
	}

	/**
	 * 天数增减操作
	 * 
	 * @param days
	 *            天数
	 */
	public void addDay(int days) {
		this.setDateTime(0, 0, days, 0, 0, 0);
	}

	/**
	 * 小时增减操作
	 * 
	 * @param hours
	 *            小时数
	 */
	public void addHour(int hours) {
		this.setDateTime(0, 0, 0, hours, 0, 0);
	}

	/**
	 * 分钟增减操作
	 * 
	 * @param minutes
	 *            分钟数
	 */
	public void addMinute(int minutes) {
		this.setDateTime(0, 0, 0, 0, minutes, 0);
	}

	/**
	 * 秒增减操作
	 * 
	 * @param seconds
	 *            秒数
	 */
	public void addSecond(int seconds) {
		this.setDateTime(0, 0, 0, 0, 0, seconds);
	}

	/**
	 * 取本月中有多少天
	 * 
	 * @return int 本月的实际天数
	 */
	public int daysOfMonth() {
		if (month > 12 || month < 0)
			return 0;
		if (month == 2 && this.isLeapYear())
			return 29;
		else
			return dayArray[month - 1];
	}

	/**
	 * 获取离当前时间ms个月的月份的天数
	 * 
	 * @param ms
	 *            月份<br>
	 * @return
	 */
	public int dayOfMonth(int ms) {
		int yy = ms / 12;
		int mm = ms % 12;
		int year = this.year + yy;
		int month = this.month + mm;

		if (month > 12) {
			month = month - 12;
			year = year + 1;
		}
		if (month < 1) {
			month = month + 12;
			year = year - 1;
		}

		if (month == 2 && isLeapYear(year))
			return 29;
		else
			return dayArray[month - 1];
	}

	/**
	 * 两个日期之间的秒数,静态方法
	 * 
	 * @param DateUtil
	 *            mydate1<br>
	 * @param DateUtil
	 *            mydate2<br>
	 * @return long
	 */
	public static long diffSec(DateUtil mydate1, DateUtil mydate2) {
		return (mydate1.getTimeInMillis() - mydate2.getTimeInMillis()) / 1000;
	}

	/**
	 * 两个日期之间之间的天数
	 * 
	 * @param Date 
	 *            start开始时间<br>
	 * @param Date
	 *            end结束时间<br>
	 * @return int
	 */
	public static int diffMonth(Date start, Date end) {
			if (start.after(end)) {
				Date t = start;
				start = end;
				end = t;
			}
			Calendar startCalendar = Calendar.getInstance();
			startCalendar.setTime(start);
			Calendar endCalendar = Calendar.getInstance();
			endCalendar.setTime(end);
			Calendar temp = Calendar.getInstance();
			temp.setTime(end);
			temp.add(Calendar.DATE, 1);

			int year = endCalendar.get(Calendar.YEAR) - startCalendar.get(Calendar.YEAR);
			int month = endCalendar.get(Calendar.MONTH) - startCalendar.get(Calendar.MONTH);

			if ((startCalendar.get(Calendar.DATE) == 1) && (temp.get(Calendar.DATE) == 1)) {
				return year * 12 + month + 1;
			} else if ((startCalendar.get(Calendar.DATE) != 1) && (temp.get(Calendar.DATE) == 1)) {
				return year * 12 + month;
			} else if ((startCalendar.get(Calendar.DATE) == 1) && (temp.get(Calendar.DATE) != 1)) {
				return year * 12 + month;
			} else {
				return (year * 12 + month - 1) < 0 ? 0 : (year * 12 + month);
			}
	}
	
	/**
	 * 两个日期之间之间的天数
	 * 
	 * @param DateUtil
	 *            mydate1<br>
	 * @param DateUtil
	 *            mydate2<br>
	 * @return int
	 */
	public static int diffDay(DateUtil mydate1, DateUtil mydate2) {
		return (int) (mydate1.getTimeInMillis() - mydate2.getTimeInMillis()) / 1000 / (3600 * 24);
	}
	/**
	 * 两个日期之间之间的天数 mydate1-mydate2的天数
	 * 
	 * @param Date
	 *            mydate1<br>
	 * @param Date
	 *            mydate2<br>
	 * @return int
	 */
	public static int diffDay(Date mydate1, Date mydate2) {
		mydate1 = DateUtil.stringToDate(DateUtil.dateFmtToString(mydate1, "yyyy-MM-dd"),"yyyy-MM-dd");
		mydate2 = DateUtil.stringToDate(DateUtil.dateFmtToString(mydate2, "yyyy-MM-dd"),"yyyy-MM-dd");
		int _day = (int) ((mydate1.getTime()- mydate2.getTime()) / 1000 / (3600 * 24));
		return _day;
	}
	
	/**
	 * 计算两个时间间隔天数
	 * 
	 * @param startday
	 * @param endday
	 * @return
	 */
	public static int diffDays(Calendar d1, Calendar d2) {
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
	 * 增加天数
	 * 
	 * @param Date
	 *            date 时间<br>
	 * @param int
	 *            day 天数<br>
	 * @return Date,增加过后的日期
	 */
	public static Date addDays(Date date, int day) {
		if (date == null)
			return null;
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.DAY_OF_MONTH, c.get(Calendar.DAY_OF_MONTH) + day);
		return c.getTime();
	}
	
	/**
	 * 减少天数
	 * 
	 * @param Date
	 *            date 时间<br>
	 * @param int
	 *            day 天数<br>
	 * @return Date,减少过后的日期
	 */
	public static Date removeDays(Date date, int day) {
		if (date == null)
			return null;
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.DAY_OF_MONTH, c.get(Calendar.DAY_OF_MONTH) - day);
		return c.getTime();
	}
	
	/**
	 * 增加月份
	 * 
	 * @param Date
	 *            date 时间<br>
	 * @param int
	 *            month 天数<br>
	 * @return Date,增加过后的日期
	 */
	public static Date addMonths(Date date, int month) {
		if (date == null)
			return null;
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.MONTH, c.get(Calendar.MONTH) + month);
		return c.getTime();
	}
	
	/**
	 * 减少月份
	 * 
	 * @param Date
	 *            date 时间<br>
	 * @param int
	 *            month 月数<br>
	 * @return Date,减少过后的日期
	 */
	public static Date removeMonths(Date date, int month) {
		if (date == null)
			return null;
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.MONTH, c.get(Calendar.MONTH) - month);
		return c.getTime();
	}

	/**
	 * 格式化时间
	 * 
	 * @param Date
	 *            date Date类型日期<br>
	 * @param SimpleDateFormat
	 *            fmt 格式化格式<br>
	 * @return String
	 */
	public static String dateFmtToString(Date date, SimpleDateFormat fmt) {
		return fmt.format(date);
	}
	
	/**
	 * 格式化时间,默认格式yyyy-MM-dd hh:mm:ss
	 * 
	 * @param Date
	 *            date Date类型日期<br>
	 * @param SimpleDateFormat
	 *            fmt 格式化格式<br>
	 * @return String
	 */
	public static String dateFmtToString(Date date) {
		return new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date);
	}

	
	/**
	 * 格式化时间
	 * 
	 * @param Date
	 *            date Date类型日期<br>
	 * @param SimpleDateFormat
	 *            fmt 格式化格式<br>
	 * @return String
	 */
	public static String dateFmtToString(Date date, String fmt) {
		return new SimpleDateFormat(fmt).format(date);
	}

	/**
	 * 字符串转日期
	 * 
	 * @param String
	 *            date 日期字符串类<br>
	 * @return java.sql.Date
	 */
	public static Date stringToDate(String date) {
		return java.sql.Date.valueOf(date);
	}


	/**
	 * 字符串转时间
	 * @param date 日期字符串
	 * @param ftm 格式
	 * @return 转换失败返回null
	 */
	public static Date stringToDate(String date,String ftm) {
		SimpleDateFormat sdf = new SimpleDateFormat(ftm);
		try {
			return sdf.parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 字符串转日期，可以按一定格式
	 * 
	 * @param String
	 *            date 日期字符串<br>
	 * @param String
	 *            dataFmt 格式化后的日期<br>
	 * @return Date
	 */
	public static Date stringFmtToDate(String date, String dataFmt) {
		SimpleDateFormat df = new SimpleDateFormat(dataFmt);
		return java.sql.Date.valueOf(df.format(java.sql.Date.valueOf(date)));
	}

	/**
	 * Data类型转换成Timestamp类型
	 * 
	 * @param Date
	 *            date日期
	 * @return Timestamp
	 */
	public static Timestamp dateToTimestamp(Date date) {
		String temp = CHN_DATE_TIME_EXTENDED_FORMAT.format(date);
		return Timestamp.valueOf(temp);
	}

	/**
	 * 获取当前日
	 * 
	 * @return int
	 */
	public int getDay() {
		return day;
	}

	/**
	 * 设置当前日
	 * 
	 * @param int
	 *            day
	 */
	public void setDay(int day) {
		this.day = day;
	}

	/**
	 * 获取当前时
	 * 
	 * @return int
	 */
	public int getHour() {
		return hour;
	}

	/**
	 * 设置当前时
	 * 
	 * @param int
	 *            hour
	 */
	public void setHour(int hour) {
		this.hour = hour;
	}

	/**
	 * 获取当前分
	 * 
	 * @return int
	 */
	public int getMinute() {
		return minute;
	}

	/**
	 * 设置当前分
	 * 
	 * @param int
	 *            minute
	 */
	public void setMinute(int minute) {
		this.minute = minute;
	}

	/**
	 * 获取当前月
	 * 
	 * @return int
	 */
	public int getMonth() {
		return month;
	}

	/**
	 * 设置当前月
	 * 
	 * @param int
	 *            month
	 */
	public void setMonth(int month) {
		this.month = month;
	}

	/**
	 * 获取当前秒
	 * 
	 * @return int
	 */
	public int getSecond() {
		return second;
	}

	/**
	 * 设置当前秒
	 * 
	 * @param int
	 *            second
	 */
	public void setSecond(int second) {
		this.second = second;
	}

	/**
	 * 获取当前年
	 * 
	 * @return int
	 */
	public int getYear() {
		return year;
	}

	/**
	 * 设置当前年
	 * 
	 * @param int
	 *            year
	 */
	public void setYear(int year) {
		this.year = year;
	}
	
	/**
	 * 判断两时间段是否有交集
	 * @param Date start1
	 * @param Date end1
	 * @param Date start2
	 * @param Date end2
	 * @return boolean true：有交集 false：没有交集
	 */
	public boolean hasCommon(Date start1 , Date end1 ,Date start2 , Date end2){
		if(end1.before(start2)||end2.before(start1))
			return false;
		else
			return true;
	}
	
	/**
	 * 判断日期格式 是否有字母等 不合法的
	 * @param date 字符串的日期
	 * @return true:正确 false:失败
	 */
	public static boolean judgeDateMsg(String date){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");// 日期格式化
		try{
			java.sql.Date.valueOf(df.format(java.sql.Date.valueOf(date)));
		}catch (NumberFormatException e){
			return false;
		}
		return true;
	}
	
	/**
	 * 计算两个日期之间的间隔的天数
	 * @param  beginDate 开始日期
	 * @param  endDate 结束日期
	 * @return 间隔的天数
	 */
	public static int daysBetween(String beginDate,String endDate){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        Calendar cal = Calendar.getInstance();    
        Calendar cal2 = Calendar.getInstance();
        try {
			cal.setTime(sdf.parse(beginDate));
			cal2.setTime(sdf.parse(endDate));    
			long time1 = cal.getTimeInMillis();                 
	        long time2 = cal2.getTimeInMillis();         
	        long between_days=(time2-time1)/(1000*3600*24);  
	        return (int) between_days;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   
		return 1;
	}
	
	/**
	 * 计算系统当前时间和传入时间相差的时间(精确到秒)
	 * 如果结果大于零则当前系统时间大于传入的时间，小于零则相反
	 * @param date 传入的时间
	 * @return 相差的时间
	 */
	public static int secondBetween(String date){
		SimpleDateFormat sdfSecond = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			long presentDate = sdfSecond.parse(sdfSecond.format(new Date())).getTime();
			long enterDate = sdfSecond.parse(date).getTime();
			return (int) ((presentDate-enterDate)/1000);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 1;
	}
	
	/**
	 * 计算系统当前时间和传入时间相差的时间(精确到秒)
	 * 如果结果大于零则当前系统时间大于传入的时间，小于零则相反
	 * @param date 传入的时间
	 * @return 相差的时间
	 */
	public static int secondBetween(Date date){
		if (date==null) {
			return 0;
		}
		SimpleDateFormat sdfSecond = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			long presentDate = sdfSecond.parse(sdfSecond.format(new Date())).getTime();
			long enterDate =  date.getTime();
			return (int) ((presentDate-enterDate)/1000);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 1;
	}
	
	/**
	 * 计算过去时间，将date与当前系统时间进行对比
	 * @param date 要进行比较的时间，
	 * @return 字符串
	 */
	public static String pastTime(Date date) {
		int second = secondBetween(date);
		if (second<60) {
			return second+"秒前";
		} else if (second>60 && second < 30*60) {
			return (second/60)+"分钟前";
		} else if (second>30*60 && second < 60*60) {
			return "半小时前";
		} else if (second>60*60 && second < 24*60*60) {
			return (second/60/60)+"小时前";
		} else {
			return DateUtil.dateFmtToString(date,"yyyy-MM-dd HH:mm:ss");
		}
		
		
	}
	
	/**
	 * 计算两个传入时间相差的时间(精确到秒)
	 * 如果结果大于零则传入的开始时间大于结束时间，小于零则相反
	 * @param beginDate 开始的时间
	 * @param endDate 结束时间
	 * @return 相差的时间
	 */
	public static int secondBetween(String beginDate,String endDate){
		SimpleDateFormat sdfSecond = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			long _enginDate = sdfSecond.parse(beginDate).getTime();
			long _endDate = sdfSecond.parse(endDate).getTime();
			return (int) ((_enginDate-_endDate)/1000);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 1;
	}	
	
	/**
	 * 将开始时间与结束时间转换成时间格式,eg:2015-4-5至2015-3-2
	 * @param date 2015-4-5至2015-3-2
	 * @param split 至
	 * @param fmt 格式
	 * @return 转换失败null
	 */
	public static Date[] beginEndStringToDate(String date,String split,String fmt) {
		if (StringUtil.isBlank(date) || StringUtil.isBlank(split)) {
			return null;
		}
		String[] _date = date.split(split);
		if (_date.length==2) {
			Date[] d = new Date[2];
			d[0] = DateUtil.stringFmtToDate(_date[0], fmt);
			d[1] = DateUtil.stringFmtToDate(_date[1], fmt);
			return d;
		}
		return null;
	}
	
	/**
	 * 将date转换为日历
	 * @param date　时间
	 * @return Calendarl类型
	 */
	public static Calendar date2Calendar(Date date) {
		Calendar calendar = Calendar.getInstance(); //得到日历
		 calendar.setTime(date);
		return calendar;
	}
}
