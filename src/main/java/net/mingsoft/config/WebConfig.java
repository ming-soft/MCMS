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

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.spring.stat.BeanTypeAutoProxyCreator;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import net.mingsoft.basic.filter.XSSEscapeFilter;
import net.mingsoft.basic.interceptor.ActionInterceptor;
import net.mingsoft.mdiy.biz.IConfigBiz;
import net.mingsoft.mdiy.entity.ConfigEntity;
import org.apache.commons.lang3.StringUtils;
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

import javax.annotation.Resource;
import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Resource
    private IConfigBiz configBiz;

    @Resource
    private MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter;

    @Bean
    public ActionInterceptor actionInterceptor() {
        return new ActionInterceptor();
    }

//    @Bean
//    public ConfigurationCustomizer configurationCustomizer() {
//        return configuration -> configuration.setUseDeprecatedExecutor(false);
//    }
    // 最新版
//    @Bean
//    public MybatisPlusInterceptor mybatisPlusInterceptor() {
//        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
//        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.));
//        return interceptor;
//    }


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
        String uploadMapping = MSProperties.upload.mapping;
        String uploadFolderPath = MSProperties.upload.path;
        String template = MSProperties.upload.template;
        String htmlDir = MSProperties.diy.htmlDir;
        // 上传路径映射 这里的映射不能使用File.separator Windows会存在映射问题
        registry.addResourceHandler(uploadMapping).addResourceLocations("/" + uploadFolderPath + "/", "file:" + uploadFolderPath + "/");
        registry.addResourceHandler("/" + template + "/**").addResourceLocations("/" + template + "/", "file:" + template + "/");
        registry.addResourceHandler("/"+htmlDir+"/**").addResourceLocations("/"+htmlDir+"/", "file:"+htmlDir+"/");
        //三种映射方式 webapp下、当前目录下、jar内
        registry.addResourceHandler("/app/**").addResourceLocations("/app/", "file:app/", "classpath:/app/");
        registry.addResourceHandler("/static/**").addResourceLocations("/static/", "file:static/", "classpath:/static/", "classpath:/META-INF/resources/");
        registry.addResourceHandler("/api/**").addResourceLocations("/api/", "file:api/", "classpath:/api/");
        if (new File(uploadFolderPath).isAbsolute()) {
            //如果指定了绝对路径，上传的文件都映射到uploadMapping下
            registry.addResourceHandler(uploadMapping).addResourceLocations("file:" + uploadFolderPath + "/"
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
    public FilterRegistrationBean xssFilterRegistration(@Value("${ms.xss.enable:true}") boolean xssEnable,
                                                        @Value("${ms.xss.filter-url}") String filterUrl,
                                                        @Value("${ms.xss.exclude-url}") String excludeUrl,
                                                        @Value("${ms.xss.exclude-filed}") String excludeFiled) {
        XSSEscapeFilter xssFilter = new XSSEscapeFilter();
        Map<String, String> initParameters = new HashMap();
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setName("XSSFilter");
        registration.addUrlPatterns(new String[]{"/*"});
        registration.setOrder(-2147483648);
        if (filterUrl != null && StrUtil.isNotBlank(filterUrl)) {
            xssFilter.includes.addAll(Arrays.asList(filterUrl.split(",")));
        }else {
            xssFilter.includes.add("/**");
        }
        if (excludeUrl != null && StrUtil.isNotBlank(excludeUrl)) {
            xssFilter.excludes.addAll(Arrays.asList(excludeUrl.split(",")));
        }else {
            xssFilter.excludes.add(MSProperties.manager.path + "/**");
        }
        if (excludeFiled != null && StrUtil.isNotBlank(excludeFiled)) {
            xssFilter.excludesFiled.addAll(Arrays.asList(excludeFiled.split(",")));
        }
        initParameters.put("isIncludeRichText", "false");
        registration.setInitParameters(initParameters);
        registration.setFilter(xssFilter);
        registration.setEnabled(xssEnable);
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
        registry.addViewController("/").setViewName("forward:/msIndex");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
        WebMvcConfigurer.super.addViewControllers(registry);
    }


    /**
     * 解决com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException 问题，提交实体不存在的字段异常
     */
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        // TODO Auto-generated method stub
        converters.add(mappingJackson2HttpMessageConverter);
        WebMvcConfigurer.super.configureMessageConverters(converters);

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

    public Map getMap(String configName) {
        if (!StringUtils.isEmpty(configName) && !StringUtils.isEmpty(configName)) {
            ConfigEntity configEntity = new ConfigEntity();
            configEntity.setConfigName(configName);
            configEntity = (ConfigEntity)this.configBiz.getOne(new QueryWrapper(configEntity));
            return configEntity != null && !StringUtils.isEmpty(configEntity.getConfigData()) ? (Map) JSONUtil.toBean(configEntity.getConfigData(), HashMap.class) : null;
        } else {
            return null;
        }
    }

}
