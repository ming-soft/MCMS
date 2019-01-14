package net.mingsoft;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.mingsoft.basic.action.BaseAction;

@Controller
@RequestMapping("/")
public class  Test {


	/**
	 * 加载管理员登录界面
	 * 
	 * @param request
	 *            请求对象
	 * @return 管理员登录界面地址
	 */
	@SuppressWarnings("resource")
	@RequestMapping("/a")
	public String login(HttpServletRequest request) {
		return "/login";
	}
}
