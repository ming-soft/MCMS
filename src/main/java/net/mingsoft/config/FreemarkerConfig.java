package net.mingsoft.config;

import java.io.IOException;
import java.util.Properties;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.jagregory.shiro.freemarker.ShiroTags;

import freemarker.template.TemplateException;

@Configuration
public class FreemarkerConfig {
	
	@Autowired  
    protected freemarker.template.Configuration configuration;  
	@Autowired  
	protected org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer configurer;  
    @Autowired  
    protected org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver resolver;  
    @Autowired  
    protected org.springframework.web.servlet.view.InternalResourceViewResolver springResolver;

    @PostConstruct
	public void init() throws IOException, TemplateException {
		configuration.setSharedVariable("shiro", new ShiroTags());
	}

}
