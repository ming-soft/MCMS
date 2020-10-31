package net.mingsoft.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.spring.stat.BeanTypeAutoProxyCreator;
import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.autoconfigure.ConfigurationCustomizer;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import com.baomidou.mybatisplus.extension.toolkit.JdbcUtils;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.mingsoft.basic.filter.XSSEscapeFilter;
import net.mingsoft.basic.interceptor.ActionInterceptor;
import net.mingsoft.interceptor.DMInnerInterceptor;
import net.mingsoft.interceptor.MysqlInnerInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
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

import javax.sql.DataSource;
import java.io.File;
import java.sql.SQLException;
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
	public MybatisPlusInterceptor mybatisPlusInterceptor(DataSource dataSource,@Autowired(required = false) TenantLineHandler tenantLineHandler) {
		MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
		if(tenantLineHandler!=null){
			interceptor.addInnerInterceptor(new TenantLineInnerInterceptor(tenantLineHandler));
		}
		try {
			//mysql 添加转换sql
			DbType dbType = JdbcUtils.getDbType(dataSource.getConnection().getMetaData().getURL());
			if(DbType.MYSQL==dbType){
				interceptor.addInnerInterceptor(new MysqlInnerInterceptor());
			}else if(DbType.DM==dbType){
				interceptor.addInnerInterceptor( new DMInnerInterceptor());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return interceptor;
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
		registry.addResourceHandler(uploadMapping).addResourceLocations(File.separator+uploadFloderPath+File.separator,"file:"+uploadFloderPath+File.separator);
		registry.addResourceHandler("/templets/**").addResourceLocations(File.separator+template+File.separator,"file:"+template+File.separator);
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
		registry.addViewController("/").setViewName("forward:/index");
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
}
