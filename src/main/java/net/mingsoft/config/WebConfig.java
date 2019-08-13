package net.mingsoft.config;

import java.io.File;

import org.springframework.aop.Advisor;
import net.mingsoft.basic.filter.XSSEscapeFilter;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.aop.support.JdkRegexpMethodPointcut;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import com.alibaba.druid.support.spring.stat.BeanTypeAutoProxyCreator;
import com.alibaba.druid.support.spring.stat.DruidStatInterceptor;

import net.mingsoft.basic.interceptor.ActionInterceptor;
import net.mingsoft.basic.util.BasicUtil;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Bean
	public ActionInterceptor actionInterceptor() {
		return new ActionInterceptor();
	}

	@Override
	public void configurePathMatch(PathMatchConfigurer configurer) {
		// 启用.do后缀
		configurer.setUseRegisteredSuffixPatternMatch(true);
	}

	/**
	 * 增加对rest api鉴权的spring mvc拦截器
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// 排除配置
		registry.addInterceptor(actionInterceptor()).excludePathPatterns("/static/**", "/app/**", "/webjars/**",
				"/*.html", "/*.htm");
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		//jar包方式映射处理
		String classPath = BasicUtil.getClassPath("");
		if (classPath.startsWith("file")) {
			registry.addResourceHandler("/upload/**").addResourceLocations("file:" + BasicUtil.getRealPath("upload") + File.separator);
			registry.addResourceHandler("/html/**").addResourceLocations("file:" + BasicUtil.getRealPath("html") + File.separator);
			registry.addResourceHandler("/templets/**").addResourceLocations("file:" + BasicUtil.getRealPath("templets") + File.separator);
		} else {
			//必须做判断，不然jar运行的html路径会被覆盖掉
			registry.addResourceHandler("/html/**").addResourceLocations("/html/");
		}
		registry.addResourceHandler("/app/**").addResourceLocations("/app/", "classpath:/app/");
		registry.addResourceHandler("/static/**").addResourceLocations("/static/", "classpath:/static/");
		registry.addResourceHandler("/api/**").addResourceLocations("/api/", "classpath:/api/");
	}
		/**
         * druidServlet注册
         */
	@Bean
	public ServletRegistrationBean druidServletRegistration() {
		ServletRegistrationBean registration = new ServletRegistrationBean(new StatViewServlet());
		registration.addUrlMappings("/druid/*");
		return registration;
	}

	/**
	 * druid监控 配置URI拦截策略
	 */
	@Bean
	public FilterRegistrationBean druidStatFilter() {
		FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean(new WebStatFilter());
		// 添加过滤规则.
		filterRegistrationBean.addUrlPatterns("/*");
		// 添加不需要忽略的格式信息.
		filterRegistrationBean.addInitParameter("exclusions",
				"/static/*,*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid,/druid/*");
		// 用于session监控页面的用户名显示 需要登录后主动将username注入到session里
		filterRegistrationBean.addInitParameter("principalSessionName", "username");
		return filterRegistrationBean;
	}

	/**
	 * druid数据库连接池监控
	 */
	@Bean
	public DruidStatInterceptor druidStatInterceptor() {
		return new DruidStatInterceptor();
	}

	@Bean
	public JdkRegexpMethodPointcut druidStatPointcut() {
		JdkRegexpMethodPointcut druidStatPointcut = new JdkRegexpMethodPointcut();
		String patterns = "net.mingsoft.*.biz.*";
		// 可以set多个
		druidStatPointcut.setPatterns(patterns);
		return druidStatPointcut;
	}

	/**
	 * druid数据库连接池监控
	 */
	@Bean
	public BeanTypeAutoProxyCreator beanTypeAutoProxyCreator() {
		BeanTypeAutoProxyCreator beanTypeAutoProxyCreator = new BeanTypeAutoProxyCreator();
		beanTypeAutoProxyCreator.setTargetBeanType(DruidDataSource.class);
		beanTypeAutoProxyCreator.setInterceptorNames("druidStatInterceptor");
		return beanTypeAutoProxyCreator;
	}

	/**
	 * druid 为druidStatPointcut添加拦截
	 *
	 * @return
	 */
	@Bean
	public Advisor druidStatAdvisor() {
		return new DefaultPointcutAdvisor(druidStatPointcut(), druidStatInterceptor());
	}

	 /**
	 * xssFilter注册
	 */
	 @Bean
	 public FilterRegistrationBean xssFilterRegistration() {
	 XSSEscapeFilter xssFilter = new XSSEscapeFilter();
	 FilterRegistrationBean registration = new
	 FilterRegistrationBean(xssFilter);
	 registration.addUrlPatterns("/*");
	 return registration;
	 }

	/**
	 * RequestContextListener注册
	 */
	@Bean
	public ServletListenerRegistrationBean<RequestContextListener> requestContextListenerRegistration() {
		return new ServletListenerRegistrationBean<>(new RequestContextListener());
	}
	/**
	 * 设置默认首页
	 */
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("forward:/index");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
		WebMvcConfigurer.super.addViewControllers(registry);
	}
}
