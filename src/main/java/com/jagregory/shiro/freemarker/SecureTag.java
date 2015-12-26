package com.jagregory.shiro.freemarker;

import freemarker.core.Environment;
import freemarker.template.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import java.io.IOException;
import java.util.Map;

/**
 * <p>Equivalent to {@link org.apache.shiro.web.tags.SecureTag}</p>
 */
public abstract class SecureTag implements TemplateDirectiveModel {
    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
        verifyParameters(params);
        render(env, params, body);
    }

    public abstract void render(Environment env, Map params, TemplateDirectiveBody body) throws IOException, TemplateException;

    protected String getParam(Map params, String name) {
        Object value = params.get(name);

        if (value instanceof SimpleScalar) {
            return ((SimpleScalar)value).getAsString();
        }
        
        return null;
    }

    protected Subject getSubject() {
        return SecurityUtils.getSubject();
    }

    protected void verifyParameters(Map params) throws TemplateModelException {
    }

    protected void renderBody(Environment env, TemplateDirectiveBody body) throws IOException, TemplateException {
        if (body != null) {
            body.render(env.getOut());
        }
    }
}
