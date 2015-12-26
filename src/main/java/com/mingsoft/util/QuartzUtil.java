package com.mingsoft.util;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.StdSchedulerFactory;

/**
 * 
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
 *         Comments:定时任务管理类
 *         </p>
 * 
 *         <p>
 *         Create Date:2015-5-26
 *         </p>
 * 
 *         <p>
 *         Modification history:
 *         </p>
 */
public class QuartzUtil {
	private static SchedulerFactory gSchedulerFactory = new StdSchedulerFactory();


	private static String JOB_GROUP_NAME = "EXTJWEB_JOBGROUP_NAME";
	private static String TRIGGER_GROUP_NAME = "EXTJWEB_TRIGGERGROUP_NAME";

	/**
	 * @Description: 添加一个定时任务，使用默认的任务组名，触发器名，触发器组名
	 * 
	 * @param jobName
	 *            任务名
	 * @param cls
	 *            任务
	 * @param time
	 *            时间设置，参考quartz说明文档
	 * 
	 * @Title: QuartzManager.java
	 * @Copyright: Copyright (c) 2014
	 * 
	 * @author Comsys-LZP
	 * @date 2014-6-26 下午03:47:44
	 * @version V2.0
	 */
	@SuppressWarnings("unchecked")
	public static void addJob(String jobName, Class cls, String time) {
		try {
			Scheduler sched = gSchedulerFactory.getScheduler();
			JobDetail jobDetail = JobBuilder.newJob(cls).withIdentity(jobName, JOB_GROUP_NAME).build();// 任务名，任务组，任务执行类
			Trigger trigger = TriggerBuilder.newTrigger().withIdentity(new TriggerKey(jobName, TRIGGER_GROUP_NAME)).startNow().withSchedule(CronScheduleBuilder.cronSchedule(time)).build();
			sched.scheduleJob(jobDetail, trigger);
			// 启动
			if (!sched.isShutdown()) {
				sched.start();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 添加一个定时任务
	 * 
	 * @param jobName
	 *            任务名
	 * @param jobGroupName
	 *            任务组名
	 * @param triggerName
	 *            触发器名
	 * @param triggerGroupName
	 *            触发器组名
	 * @param jobClass
	 *            任务
	 * @param time
	 *            时间设置，参考quartz说明文档
	 * 
	 * @Title: QuartzManager.java
	 * @Copyright: Copyright (c) 2014
	 * 
	 * @author Comsys-LZP
	 * @date 2014-6-26 下午03:48:15
	 * @version V2.0
	 */
	@SuppressWarnings("unchecked")
	public static void addJob(String jobName, String jobGroupName, String triggerName, String triggerGroupName, Class jobClass, String time) {
		try {
			Scheduler sched = gSchedulerFactory.getScheduler();
			JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(jobName, jobGroupName).build();// 任务名，任务组，任务执行类
			Trigger trigger = TriggerBuilder.newTrigger().withIdentity(new TriggerKey(triggerName, triggerGroupName)).startNow().withSchedule(CronScheduleBuilder.cronSchedule(time)).build();
			sched.scheduleJob(jobDetail, trigger);			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 修改一个任务的触发时间(使用默认的任务组名，触发器名，触发器组名)
	 * 
	 * @param jobName
	 * @param time
	 * 
	 * @Title: QuartzManager.java
	 * @Copyright: Copyright (c) 2014
	 * 
	 * @author Comsys-LZP
	 * @date 2014-6-26 下午03:49:21
	 * @version V2.0
	 */
	@SuppressWarnings("unchecked")
	public static void modifyJobTime(String jobName, String time) {
		try {
			Scheduler sched = gSchedulerFactory.getScheduler();
			TriggerKey triggerKey = TriggerKey.triggerKey(jobName,TRIGGER_GROUP_NAME);
			CronTrigger trigger = (CronTrigger) sched.getTrigger(triggerKey);
			if (trigger == null) {
				return;
			}
			String oldTime = trigger.getCronExpression();
			if (!oldTime.equalsIgnoreCase(time)) {
				JobKey job = JobKey.jobKey(jobName);
				JobDetail jobDetail = sched.getJobDetail(job);
				Class objJobClass = jobDetail.getJobClass();
				removeJob(jobName);
				addJob(jobName, objJobClass, time);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 修改一个任务的触发时间
	 * 
	 * @param triggerName
	 * @param triggerGroupName
	 * @param time
	 * 
	 * @Title: QuartzManager.java
	 * @Copyright: Copyright (c) 2014
	 * 
	 * @author Comsys-LZP
	 * @date 2014-6-26 下午03:49:37
	 * @version V2.0
	 */
	public static void modifyJobTime(String triggerName, String triggerGroupName, String time) {
		try {
			Scheduler sched = gSchedulerFactory.getScheduler();
			TriggerKey triggerKey = TriggerKey.triggerKey(triggerName);
			CronTrigger trigger = (CronTrigger) sched.getTrigger(triggerKey);
			if (trigger == null) {
				return;
			}
			String oldTime = trigger.getCronExpression();
			if (!oldTime.equalsIgnoreCase(time)) {
				trigger.getTriggerBuilder().startNow().withSchedule(CronScheduleBuilder.cronSchedule(time));
				// 重启触发器
				sched.resumeTrigger(triggerKey);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 移除一个任务(使用默认的任务组名，触发器名，触发器组名)
	 * 
	 * @param jobName
	 * 
	 * @Title: QuartzManager.java
	 * @Copyright: Copyright (c) 2014
	 * 
	 * @author Comsys-LZP
	 * @date 2014-6-26 下午03:49:51
	 * @version V2.0
	 */
	public static void removeJob(String jobName) {
		try {
			Scheduler sched = gSchedulerFactory.getScheduler();
			JobKey job = JobKey.jobKey(jobName,JOB_GROUP_NAME);
			TriggerKey triggerKey = TriggerKey.triggerKey(jobName,TRIGGER_GROUP_NAME);
			sched.pauseTrigger(triggerKey);// 停止触发器
			sched.unscheduleJob(triggerKey);// 移除触发器
			sched.deleteJob(job);// 删除任务
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 移除一个任务
	 * 
	 * @param jobName
	 * @param jobGroupName
	 * @param triggerName
	 * @param triggerGroupName
	 * 
	 * @Title: QuartzManager.java
	 * @Copyright: Copyright (c) 2014
	 * 
	 * @author Comsys-LZP
	 * @date 2014-6-26 下午03:50:01
	 * @version V2.0
	 */
	public static void removeJob(String jobName, String jobGroupName, String triggerName, String triggerGroupName) {
		try {
			Scheduler sched = gSchedulerFactory.getScheduler();
			JobKey job = JobKey.jobKey(jobName, jobGroupName);
			TriggerKey triggerKey = TriggerKey.triggerKey(jobName, jobGroupName);
			sched.pauseTrigger(triggerKey);// 停止触发器
			sched.unscheduleJob(triggerKey);// 移除触发器
			sched.deleteJob(job);// 删除任务
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description:启动所有定时任务
	 * 
	 * 
	 * @Title: QuartzManager.java
	 * @Copyright: Copyright (c) 2014
	 * 
	 * @author Comsys-LZP
	 * @date 2014-6-26 下午03:50:18
	 * @version V2.0
	 */
	public static void startJobs() {
		try {
			Scheduler sched = gSchedulerFactory.getScheduler();
			sched.start();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description:关闭所有定时任务
	 * 
	 * 
	 * @Title: QuartzManager.java
	 * @Copyright: Copyright (c) 2014
	 * 
	 * @author Comsys-LZP
	 * @date 2014-6-26 下午03:50:26
	 * @version V2.0
	 */
	public static void shutdownJobs() {
		try {
			Scheduler sched = gSchedulerFactory.getScheduler();
			if (!sched.isShutdown()) {
				sched.shutdown();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
