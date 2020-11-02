package net.mingsoft.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import com.baomidou.mybatisplus.extension.toolkit.JdbcUtils;
import net.mingsoft.interceptor.DMInnerInterceptor;
import net.mingsoft.interceptor.MysqlInnerInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;
import java.sql.SQLException;

/**
 * Mybatis 拦截器配置
 */
@Configuration
public class MybatisInterceptorConfig {

    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor(DataSource dataSource, @Autowired(required = false) TenantLineHandler tenantLineHandler) {
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
}
