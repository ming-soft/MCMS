/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
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





package net.mingsoft.config;

import jakarta.annotation.Resource;
import jakarta.servlet.Filter;
import net.mingsoft.basic.filter.ShiroLoginFilter;
import net.mingsoft.basic.filter.ShiroRoleFilter;
import net.mingsoft.basic.realm.CustomModularRealmAuthenticator;
import net.mingsoft.basic.realm.ManagerAuthRealm;
import net.mingsoft.basic.strategy.ILoginStrategy;
import net.mingsoft.basic.strategy.IModelStrategy;
import net.mingsoft.basic.strategy.ManagerLoginStrategy;
import net.mingsoft.basic.strategy.ManagerModelStrategy;
import org.apache.shiro.authc.Authenticator;
import org.apache.shiro.authc.pam.AtLeastOneSuccessfulStrategy;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.session.mgt.eis.MemorySessionDAO;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Configuration
public class ShiroConfig {

	@Autowired(required = false)
	MSProperties msProperties;

	@Resource
	ServerProperties serverProperties;

	/**
	 * 开启Shiro的注解(如@RequiresRoles , @RequiresPermissions),需借助SspringAOP扫描使用Sshiro注解的类，并在必要时进行安全逻辑验证
	 * 配置以下两个bean(Defaul tAdvisorAutoProxyCreator和uthorizat ionAttributeSourceAdvisor)即可实现此功能
	 */
	@Bean
	public DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator(){
		DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
		advisorAutoProxyCreator.setProxyTargetClass(true);
		return advisorAutoProxyCreator;
	}

	/**
	 * 开启shiro aop注解支持
	 * 使用代理方式;所以需要开启代码支持
	 * @param securityManager
	 */
	@Bean
	public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager){
		AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
		authorizationAttributeSourceAdvisor.setSecurityManager(securityManager);
		return authorizationAttributeSourceAdvisor;
	}

	@Bean
	public AuthorizationAttributeSourceAdvisor getAuthorizationAttributeSourceAdvisor(
			@Autowired(required = false) DefaultWebSecurityManager securityManager) {
		AuthorizationAttributeSourceAdvisor advisor = new AuthorizationAttributeSourceAdvisor();
		advisor.setSecurityManager(securityManager);
		return advisor;
	}

	@Bean
	public DefaultAdvisorAutoProxyCreator getDefaultAdvisorAutoProxyCreator() {
		DefaultAdvisorAutoProxyCreator autoProxyCreator = new DefaultAdvisorAutoProxyCreator();
		autoProxyCreator.setProxyTargetClass(true);
		return autoProxyCreator;
	}

	@Bean(name = "shiroFilterFactoryBean")
	public ShiroFilterFactoryBean shirFilter(SecurityManager securityManager) {
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		// 必须设置 SecurityManager
		shiroFilterFactoryBean.setSecurityManager(securityManager);
		// setLoginUrl 如果不设置值，默认会自动寻找Web工程根目录下的"/login.jsp"页面 或 "/login" 映射
		shiroFilterFactoryBean.setLoginUrl(MSProperties.manager.path + "/login.do");
		// 设置无权限时跳转的 url;
		shiroFilterFactoryBean.setUnauthorizedUrl(MSProperties.manager.path + "/404.do");


		Map<String, Filter> filters = shiroFilterFactoryBean.getFilters();
		filters.put("authc",new ShiroLoginFilter());
		// 依赖会员后需放开104行,107行
		// PeopleLoginFilter会员登录过滤器，在这里people/**接口都会拦截校验是否登录
		// filters.put("pauth",new PeopleLoginFilter(MSProperties.people.loginUrl));
		// 角色校验过滤器最终会在对应的reaml中的hasRole校验，可以在ShiroRoleFilter中自定义一些操作
		 filters.put("managerRoles", new ShiroRoleFilter(MSProperties.manager.path  + "/login.do"));
		// filters.put("peopleRoles", new ShiroRoleFilter(MSProperties.people.loginUrl));

		// 设置拦截器
		Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
		// 游客，开发权限
		filterChainDefinitionMap.put("/static/**", "anon");
		filterChainDefinitionMap.put("/html/**", "anon");
		// 开放登陆接口
		filterChainDefinitionMap.put(MSProperties.manager.path + "/login.do", "anon");
		filterChainDefinitionMap.put(MSProperties.manager.path + "/checkLogin.do", "anon");
		// 其余接口一律拦截
		// 主要这行代码必须放在所有权限设置的最后，不然会导致所有 url 都被拦截
		// 依赖会员后，放开123行以及202-205行
		// roles[**]中的**值必须和对应的Reaml赋予当前登录的Roles名称一致，然后值必须时CustomUserNamePasswordToken.AuthType中的值，如果这里值和对应Reaml值不一致则会出现无法访问情况
		filterChainDefinitionMap.put(msProperties.getManager().path + "/**", "authc,managerRoles[MANAGER]");
		// filterChainDefinitionMap.put("/people/**", "pauth,peopleRoles[PEOPLE]");

		shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
		return shiroFilterFactoryBean;
	}

	/**
	 * 注入 securityManager
	 */
	@Bean("securityManager")
	public DefaultWebSecurityManager securityManager(List<Realm> realms, Authenticator authenticator, DefaultWebSessionManager sessionManager) {
		DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
		securityManager.setSessionManager(sessionManager);
		securityManager.setAuthenticator(authenticator);
		//集群环境下使用redis共享session用下行代码
//        securityManager.setCacheManager(shiroRedisCacheManager);
		// 设置realm
		securityManager.setRealms(realms);
		return securityManager;
	}

	/**
	 * 重写defaultWebSessionManager,防止url拼接jsessionid
	 * @return
	 */
	@Bean
	public DefaultWebSessionManager defaultWebSessionManager() {
		DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
		if(serverProperties.getServlet().getSession().getTimeout()!=null) {
			//单位毫秒
			sessionManager.setGlobalSessionTimeout(serverProperties.getServlet().getSession().getTimeout().getSeconds()*1000L);
		}
		sessionManager.setSessionDAO(getMemorySessionDAO());
		sessionManager.setSessionIdCookie(getSimpleCookie());
		sessionManager.setSessionIdUrlRewritingEnabled(false);
		return sessionManager;
	}

	/**
	 * 身份验证器
	 * @return Authenticator
	 */
	@Bean
	public Authenticator authenticator() {
		CustomModularRealmAuthenticator modularRealmAuthenticator = new CustomModularRealmAuthenticator();
		modularRealmAuthenticator.setAuthenticationStrategy(new AtLeastOneSuccessfulStrategy());
		return modularRealmAuthenticator;
	}


	@Bean
	public MemorySessionDAO getMemorySessionDAO() {
		return new MemorySessionDAO();
	}

	@Bean
	public SimpleCookie getSimpleCookie() {
		SimpleCookie simpleCookie = new SimpleCookie();
		simpleCookie.setName(msProperties.getCookieName());
		return simpleCookie;

	}



	/**
	 * 自定义身份认证 realm;
	 * <p>
	 * 必须写这个类，并加上 @Bean 注解，目的是注入 CustomRealm， 否则会影响 CustomRealm类 中其他类的依赖注入
	 */
	@Bean
	public ManagerAuthRealm customRealm() {
		return new ManagerAuthRealm();
	}


	/**
	 * 自定义会员身份认证realm，依赖会员后放开202-205行
	 * @return
	 */
//	@Bean("peopleAuth")
//	public PeopleAuthRealm peopleAuthRealm() {
//		return new PeopleAuthRealm();
//	}

	/**
	 * 管理员菜单策略
	 *
	 * @return
	 */
	@Bean
	public IModelStrategy modelStrategy() {
		return  new ManagerModelStrategy();
	}

	/**
	 * 管理登录策略
	 *
	 * @return
	 */
	@Bean
	public ILoginStrategy loginStrategy() {
		return new ManagerLoginStrategy();
	}
}
