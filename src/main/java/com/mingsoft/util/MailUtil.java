package com.mingsoft.util;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.internet.MimeMessage;

import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.messaging.MessagingException;

/**
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
 * @author 王天培 QQ:78750478
 * 
 *         <p>
 *         Comments:邮件发送通用，依赖spring的mail,
 *         </p>
 * 
 *         <p>
 *         Create Date:2014-11-4
 *         </p>
 * 
 *         <p>
 *         Modification history:
 *         </p>
 */
public class MailUtil {

	/**
	 * 发送简单的文字邮件
	 * 
	 * @param host 主机
	 * @param port　端口
	 * @param userName　账号
	 * @param password　密码
	 * @param title　标题
	 * @param content　内容
	 * @param toUser　接收人
	 */
	public static void sendText(String host, int port, String userName, String password, String title, String content, String[] toUser) {
		JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();
		// 设定mail server
		senderImpl.setHost(host);
		senderImpl.setPort(port);
		// 建立邮件消息
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		// 设置收件人，寄件人 用数组发送多个邮件
		// String[] array = new String[] {"sun111@163.com","sun222@sohu.com"};
		// mailMessage.setTo(array);
		mailMessage.setTo(toUser);
		mailMessage.setFrom(userName);
		mailMessage.setSubject(title);
		mailMessage.setText(content);

		senderImpl.setUsername(userName); // 根据自己的情况,设置username
		senderImpl.setPassword(password); // 根据自己的情况, 设置password

		Properties prop = new Properties();
		prop.put(" mail.smtp.auth ", " true "); // 将这个参数设为true，让服务器进行认证,认证用户名和密码是否正确
		prop.put(" mail.smtp.timeout ", " 25000 ");
		senderImpl.setJavaMailProperties(prop);
		// 发送邮件
		senderImpl.send(mailMessage);
	}

	/**
	 * 发送简html内容的邮件
	 * 
	 * @param host 主机
	 * @param port　端口
	 * @param userName　账号
	 * @param password　密码
	 * @param title　标题
	 * @param content　html内容
	 * @param toUser　接收人
	 * @throws javax.mail.MessagingException 
	 */
	public static void sendHtml(String host, int port, String userName, String password, String title, String content, String[] toUser){
		JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();
		// 设定mail server
		senderImpl.setHost(host);
		senderImpl.setPort(port);
		// 建立邮件消息,发送简单邮件和html邮件的区别
		MimeMessage mailMessage = senderImpl.createMimeMessage();
		
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(mailMessage,true,"UTF-8");
			
			try {
				// 设置收件人，寄件人
				messageHelper.setTo(toUser);
				messageHelper.setFrom(userName);
				messageHelper.setSubject(title);
				// true 表示启动HTML格式的邮件
				messageHelper.setText(content, true);
			} catch (javax.mail.MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


			senderImpl.setUsername(userName); // 根据自己的情况,设置username
			senderImpl.setPassword(password); // 根据自己的情况, 设置password
			Properties prop = new Properties();
			prop.put("mail.smtp.auth", "true"); // 将这个参数设为true，让服务器进行认证,认证用户名和密码是否正确
			prop.put("mail.smtp.timeout", "25000");
			senderImpl.setJavaMailProperties(prop);
			// 发送邮件
			senderImpl.send(mailMessage);
		} catch (javax.mail.MessagingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 


	}

	/**
	 * 发送带图片的html邮件，
	 * 
	 * @param host 主机
	 * @param port　端口
	 * @param userName　账号
	 * @param password　密码
	 * @param title　标题
	 * @param content　带图片的html内容 
	 * @param imgs　图片地址，
	 * @param toUser　接收人
	 * @throws javax.mail.MessagingException 
	 */
	public static void sendNews(String host, int port, String userName, String password, String title, String content, List<String> imgs,
			String[] toUser) throws MessagingException, javax.mail.MessagingException {
		JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();
		// 设定mail server
		senderImpl.setHost(host);

		// 建立邮件消息,发送简单邮件和html邮件的区别
		MimeMessage mailMessage = senderImpl.createMimeMessage();
		// 注意这里的boolean,等于真的时候才能嵌套图片，在构建MimeMessageHelper时候，所给定的值是true表示启用，
		// multipart模式
		MimeMessageHelper messageHelper = new MimeMessageHelper(mailMessage, true);

		// 设置收件人，寄件人
		messageHelper.setTo(toUser);
		messageHelper.setFrom(userName);
		messageHelper.setSubject(title);
		// true 表示启动HTML格式的邮件
		messageHelper.setText(content, true);

		int i = 0;
		for (String imagePath : imgs) {
			FileSystemResource img = new FileSystemResource(new File(imagePath));
			messageHelper.addInline(i + "", img);
			i++;
		}

		senderImpl.setUsername(userName); // 根据自己的情况,设置username
		senderImpl.setPassword(password); // 根据自己的情况, 设置password
		Properties prop = new Properties();
		prop.put("mail.smtp.auth", "true"); // 将这个参数设为true，让服务器进行认证,认证用户名和密码是否正确
		prop.put("mail.smtp.timeout", "25000");
		senderImpl.setJavaMailProperties(prop);
		// 发送邮件
		senderImpl.send(mailMessage);

		// 发送邮件
		senderImpl.send(mailMessage);
	}

	/**
	 * 发送带附件的html邮件，
	 * 
	 * @param host 主机
	 * @param port　端口
	 * @param userName　账号
	 * @param password　密码
	 * @param title　标题
	 * @param content　带图片的html内容 
	 * @param files　附件list<Map<key:文件名称,value:文件地址>>
	 * @param toUser　接收人
	 * @throws javax.mail.MessagingException 
	 */
	public static void sendAttached(String host, int port, String userName, String password, String title, String content,
			List<Map<String, String>> files, String[] toUser) throws MessagingException, javax.mail.MessagingException {
		JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();

		// 设定mail server
		senderImpl.setHost(host);
		// 建立邮件消息,发送简单邮件和html邮件的区别
		MimeMessage mailMessage = senderImpl.createMimeMessage();
		// 注意这里的boolean,等于真的时候才能嵌套图片，在构建MimeMessageHelper时候，所给定的值是true表示启用，
		// multipart模式 为true时发送附件 可以设置html格式
		MimeMessageHelper messageHelper = new MimeMessageHelper(mailMessage, true, "utf-8");

		// 设置收件人，寄件人
		messageHelper.setTo(toUser);
		messageHelper.setFrom(userName);
		messageHelper.setSubject(title);
		// true 表示启动HTML格式的邮件
		messageHelper.setText(content, true);

		for (Map<String, String> filePath : files) {
			Iterator<String> it = filePath.keySet().iterator();
			String fileName = it.next();
			FileSystemResource file = new FileSystemResource(new File(filePath.get(fileName)));
			// 这里的方法调用和插入图片是不同的。
			messageHelper.addAttachment(fileName, file);
		}

		senderImpl.setUsername(userName); // 根据自己的情况,设置username
		senderImpl.setPassword(password); // 根据自己的情况, 设置password
		Properties prop = new Properties();
		prop.put("mail.smtp.auth", "true"); // 将这个参数设为true，让服务器进行认证,认证用户名和密码是否正确
		prop.put("mail.smtp.timeout", "25000");
		senderImpl.setJavaMailProperties(prop);
		// 发送邮件
		senderImpl.send(mailMessage);
	}
}
