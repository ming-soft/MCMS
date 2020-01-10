package net.mingsoft.config;

import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.aop.Advisor;
import net.mingsoft.basic.filter.XSSEscapeFilter;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.aop.support.JdkRegexpMethodPointcut;
import org.springframework.beans.factory.annotation.Value;
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

	/**
	 * 上传路径
	 */
	@Value("${ms.upload.path}")
	private String uploadFloderPath;
	/**
	 * 上传路径映射
	 */
	@Value("${ms.upload.mapping}")
	private String uploadMapping;
	@Bean
	public ActionInterceptor actionInterceptor() {
		return new ActionInterceptor();
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
		registry.addResourceHandler("/upload/**").addResourceLocations("/upload/","file:upload/");
		registry.addResourceHandler("/templets/**").addResourceLocations("/templets/","file:templets/");
		registry.addResourceHandler("/html/**").addResourceLocations("/html/","file:html/");
		//三种映射方式 webapp下、当前目录下、jar内
		registry.addResourceHandler("/app/**").addResourceLocations("/app/","file:app/", "classpath:/app/");
		registry.addResourceHandler("/static/**","/**").addResourceLocations("/static/","file:static/","classpath:/static/","classpath:/META-INF/resources/");
		registry.addResourceHandler("/api/**").addResourceLocations("/api/","file:api/", "classpath:/api/");
		if(new File(uploadFloderPath).isAbsolute()){
			//如果指定了绝对路径，上传的文件都映射到uploadMapping下
			registry.addResourceHandler(uploadMapping).addResourceLocations("file:"+uploadFloderPath+ File.separator
					//映射其他路径文件
					//,file:F://images
			);
		}
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
//	XSS过滤器
//    @Bean
//    public FilterRegistrationBean xssFilterRegistration() {
//        XSSEscapeFilter xssFilter = new XSSEscapeFilter();
//        FilterRegistrationBean registration = new FilterRegistrationBean(xssFilter);
//        xssFilter.excludes.add(".*file/upload.do");
//        xssFilter.excludes.add(".*/jsp/editor.do");
//        xssFilter.excludes.add(".*/?(jpg|js|css|gif|png|ico)$");
//        xssFilter.excludes.add("/");
//        registration.addUrlPatterns("/*");
//        return registration;
//    }

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
