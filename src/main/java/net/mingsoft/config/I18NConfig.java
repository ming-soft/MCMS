package net.mingsoft.config;

import com.jagregory.shiro.freemarker.ShiroTags;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import java.io.IOException;

/**
 * 读取国际化配置，传递给freemker
 */
@Configuration
public class I18NConfig {
    @Autowired
    protected freemarker.template.Configuration configuration;

    @Value("${ms.local.default:zh_CN}")
    private String defaultLocal;
    @Value("${ms.local.messages:zh_CN,en_US}")
    private String messages;

    @PostConstruct
    public void init() throws IOException, TemplateException {
        configuration.setSharedVariable("localDefault",defaultLocal);
        configuration.setSharedVariable("localMessages",messages.split(","));
    }

}
