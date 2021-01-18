/**
 * The MIT License (MIT)
 * Copyright (c) 2020 铭软科技(mingsoft.net)
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

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.spring.stat.BeanTypeAutoProxyCreator;
import com.baomidou.mybatisplus.autoconfigure.ConfigurationCustomizer;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.mingsoft.basic.filter.XSSEscapeFilter;
import net.mingsoft.basic.interceptor.ActionInterceptor;
import net.mingsoft.basic.resolver.MSLocaleResolver;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	/**
	 * 上传路径
	 */
	@Value("${ms.upload.path}")
	private String uploadFloderPath;

	@Value("${ms.upload.template}")
	private String template;
	/**
	 * 上传路径映射
	 */
	@Value("${ms.upload.mapping}")
	private String uploadMapping;
	@Bean
	public ActionInterceptor actionInterceptor() {
		return new ActionInterceptor();
	}

	@Bean
	public ConfigurationCustomizer configurationCustomizer() {
		return configuration -> configuration.setUseDeprecatedExecutor(false);
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
		registry.addResourceHandler(uploadMapping).addResourceLocations(File.separator+uploadFloderPath+File.separator,"file:"+uploadFloderPath+File.separator,"classpath:/template/");
		registry.addResourceHandler("/template/**").addResourceLocations(File.separator+template+File.separator,"file:"+template+File.separator,"classpath:/html/");
		registry.addResourceHandler("/html/**").addResourceLocations("/html/","file:html/");
		//三种映射方式 webapp下、当前目录下、jar内
		registry.addResourceHandler("/app/**").addResourceLocations("/app/","file:app/", "classpath:/app/");
		registry.addResourceHandler("/static/**").addResourceLocations("/static/","file:static/","classpath:/static/","classpath:/META-INF/resources/");
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
	//XSS过滤器
    @Bean
    public FilterRegistrationBean xssFilterRegistration() {
        XSSEscapeFilter xssFilter = new XSSEscapeFilter();
        FilterRegistrationBean registration = new FilterRegistrationBean(xssFilter);
        xssFilter.includes.add(".*/search.do");
        registration.setName("XSSFilter");
        registration.addUrlPatterns("/*");
        registration.setOrder(Ordered.HIGHEST_PRECEDENCE);
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
		registry.addViewController("/").setViewName("forward:/index.do");
		registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
		WebMvcConfigurer.super.addViewControllers(registry);
	}


	/**
	 * 解决com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException 问题，提交实体不存在的字段异常
	 */
	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		// TODO Auto-generated method stub
		converters.add(mappingJackson2HttpMessageConverter());
		WebMvcConfigurer.super.configureMessageConverters(converters);

	}

	@Bean
    public MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter(){
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        ObjectMapper objectMapper = new ObjectMapper();

        //添加此配置
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        converter.setObjectMapper(objectMapper);
        return converter;
    }
	@Bean
	public ExecutorService crawlExecutorPool() {
		// 创建线程池
		ExecutorService pool =
				new ThreadPoolExecutor(20, 20,
						0L, TimeUnit.MILLISECONDS,
						new LinkedBlockingQueue<Runnable>());
		return pool;
	}

	/**
	 * 国际化配置拦截
	 * @return
	 */
	@Bean
	public MSLocaleResolver localeResolver(){
		return new MSLocaleResolver();
	}
}
