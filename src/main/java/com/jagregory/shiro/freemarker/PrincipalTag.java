package com.jagregory.shiro.freemarker;

import freemarker.core.Environment;
import freemarker.log.Logger;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModelException;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.util.Map;

/**
 * <p>Tag used to print out the String value of a user's default principal,
 * or a specific principal as specified by the tag's attributes.</p>
 *
 * <p> If no attributes are specified, the tag prints out the <tt>toString()</tt>
 * value of the user's default principal.  If the <tt>type</tt> attribute
 * is specified, the tag looks for a principal with the given type.  If the
 * <tt>property</tt> attribute is specified, the tag prints the string value of
 * the specified property of the principal.  If no principal is found or the user
 * is not authenticated, the tag displays nothing unless a <tt>defaultValue</tt>
 * is specified.</p>
 *
 * <p>Equivalent to {@link org.apache.shiro.web.tags.PrincipalTag}</p>
 *
 * @since 0.2
 */
public class PrincipalTag extends SecureTag {
    static final Logger log = Logger.getLogger("PrincipalTag");

    /**
     * The type of principal to be retrieved, or null if the default principal should be used.
     */
    String getType(Map params) {
        return getParam(params, "type");
    }

    /**
     * The property name to retrieve of the principal, or null if the <tt>toString()</tt> value should be used.
     */
    String getProperty(Map params) {
        return getParam(params, "property");
    }

    @SuppressWarnings("unchecked")
    @Override
    public void render(Environment env, Map params, TemplateDirectiveBody body) throws IOException, TemplateException {
        String result = null;

        if (getSubject() != null) {
            // Get the principal to print out
            Object principal;

            if (getType(params) == null) {
                principal = getSubject().getPrincipal();
            } else {
                principal = getPrincipalFromClassName(params);
            }

            // Get the string value of the principal
            if (principal != null) {
                String property = getProperty(params);

                if (property == null) {
                    result = principal.toString();
                } else {
                    result = getPrincipalProperty(principal, property);
                }
            }
        }

        // Print out the principal value if not null
        if (result != null) {
            try {
                env.getOut().write(result);
            } catch (IOException ex) {
                throw new TemplateException("Error writing ["+result+"] to Freemarker.", ex, env);
            }
        }
    }

    @SuppressWarnings("unchecked")
    Object getPrincipalFromClassName(Map params) {
        String type = getType(params);

        try {
            Class cls = Class.forName(type);
            
            return getSubject().getPrincipals().oneByType(cls);
        } catch (ClassNotFoundException ex) {
            log.error("Unable to find class for name ["+type+"]", ex);
        }

        return null;
    }

    String getPrincipalProperty(Object principal, String property) throws TemplateModelException {
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(principal.getClass());

            // Loop through the properties to get the string value of the specified property
            for (PropertyDescriptor propertyDescriptor : beanInfo.getPropertyDescriptors()) {
                if (propertyDescriptor.getName().equals(property)) {
                    Object value = propertyDescriptor.getReadMethod().invoke(principal, (Object[]) null);

                    return String.valueOf(value);
                }
            }

            // property not found, throw
            throw new TemplateModelException("Property ["+property+"] not found in principal of type ["+principal.getClass().getName()+"]");
        } catch (Exception ex) {
            throw new TemplateModelException("Error reading property ["+property+"] from principal of type ["+principal.getClass().getName()+"]", ex);
        }
    }
}