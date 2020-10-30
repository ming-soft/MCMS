package net.mingsoft.handler;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ArrayUtil;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import net.mingsoft.basic.util.BasicUtil;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.LongValue;
import org.springframework.beans.factory.annotation.Value;

import java.util.ArrayList;
import java.util.Arrays;

public class AppHandler implements TenantLineHandler {

    @Value("${ms.mwebsite.tables}")
    private String[] tables;
    @Override
    public Expression getTenantId() {
        //分页插件处理,会被执行两次,一次查询数量，一次查询结果，当查询到了数量之后当前线程变量就会被赋值，再次startPage就会丢失数量，所以判断拿到了数量就不再startPage
        Page<Object> localPage = PageHelper.getLocalPage();
        if(localPage!=null&&localPage.getTotal()==0){
            PageHelper.clearPage();
        }
        //int appId = BasicUtil.getAppId();
        if(localPage!=null&&localPage.getTotal()==0){
            PageHelper.startPage(localPage.getPageNum(),localPage.getPageSize(),localPage.isCount());
            PageHelper.orderBy(localPage.getOrderBy());
        }
        return new LongValue(1);
    }

    @Override
    public String getTenantIdColumn() {
        return "app_id";
    }

    @Override
    public boolean ignoreTable(String tableName) {
        return ArrayUtil.isEmpty(tables)|| !ArrayUtil.contains(tables,tableName);
    }
}
