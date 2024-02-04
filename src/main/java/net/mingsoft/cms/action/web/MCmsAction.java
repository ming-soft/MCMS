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

package net.mingsoft.cms.action.web;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.PageUtil;
import cn.hutool.json.JSONUtil;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.TemplateNotFoundException;
import net.mingsoft.base.constant.Const;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.cms.biz.ICategoryBiz;
import net.mingsoft.cms.biz.IContentBiz;
import net.mingsoft.cms.entity.CategoryEntity;
import net.mingsoft.mdiy.bean.PageBean;
import net.mingsoft.mdiy.biz.IModelBiz;
import net.mingsoft.mdiy.entity.ModelEntity;
import net.mingsoft.mdiy.util.ConfigUtil;
import net.mingsoft.mdiy.util.ParserUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 动态生成页面，需要后台配置自定义页数据
 *
 * @author 铭飞开源团队
 * @date 2018年12月17日
 * @date 2021年8月26日取消默认search.htm
 */
@ApiIgnore
@Controller("dynamicPageAction")
@RequestMapping("/mcms")
public class MCmsAction extends net.mingsoft.cms.action.BaseAction {

    /**
     * 文章管理业务处理层
     */
    @Autowired
    private IContentBiz contentBiz;

    /**
     * 栏目业务层
     */
    @Autowired
    private ICategoryBiz categoryBiz;


    /**
     * 自定义模型
     */
    @Autowired
    private IModelBiz modelBiz;


    @Value("${ms.diy.html-dir:html}")
    private String htmlDir;

    /**
     * 实现前端页面的文章搜索
     * @return 渲染后的搜索页面
     */
    @RequestMapping(value = "search",method = {RequestMethod.GET, RequestMethod.POST},produces= MediaType.TEXT_HTML_VALUE+";charset=utf-8")
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response) {
        String search = BasicUtil.getString("tmpl", "search.htm");
        //设置分页类
        PageBean page = new PageBean();
        page.setSize(ParserUtil.getPageSize(search, 20));

        //参数集合，提供给解析使用
        Map<String, Object> params = new HashMap<>();

        // 读取请求字段
        Map<String, Object> field = BasicUtil.assemblyRequestMap();

        // 自定义字段集合
        Map<String, String> diyFieldName = new HashMap<String, String>();

        //记录自定义模型字段名
        List filedStr = new ArrayList<>();
        // 栏目对应字段的值
        List<DiyModelMap> fieldValueList = new ArrayList<DiyModelMap>();

        // 当前栏目
        CategoryEntity column = null;
        // 栏目对应模型
        ModelEntity contentModel = null;


        //获取栏目信息
        String typeId = null;
        String categoryIds = BasicUtil.getString("categoryIds");
        if ("null".equals(categoryIds)){
            categoryIds = null;
        }

        //当传递了栏目编号，但不是栏目集合
        if (StringUtils.isNotBlank(categoryIds) && !categoryIds.contains(",")) {
            typeId = categoryIds;
        }


        //根据栏目确定自定义模型
        if (typeId != null) {
            column = (CategoryEntity) categoryBiz.getById(typeId);
            // 获取表单类型的id
            if (column != null && ObjectUtil.isNotNull(column.getMdiyModelId())) {
                contentModel = (ModelEntity) modelBiz.getById(column.getMdiyModelId());
                if (contentModel != null) {
                    // 保存自定义模型的数据
                    Map<String, String> fieldMap = contentModel.getFieldMap();
                    for (String s : fieldMap.keySet()) {
                        filedStr.add(fieldMap.get(s));
                    }
                    // 设置自定义模型表名，方便解析的时候关联表查询
                    params.put(ParserUtil.TABLE_NAME, contentModel.getModelTableName());
                }
            }

            // 设置栏目，方便解析的时候关联表查询
            params.put(ParserUtil.COLUMN, column);
        }

        // 处理读取请求字段
        if (field != null) {
            for (Map.Entry<String, Object> entry : field.entrySet()) {
                if (entry != null) {
                    //空值不处理
                    if (ObjectUtil.isNull(entry.getValue())) {
                        continue;
                    }

                    // 对值进行安全处理
                    // 处理由get方法请求中文乱码问题
                    String value = entry.getValue().toString().replaceAll("('|\"|\\\\)", "\\\\$1");
                    //Xss过滤
                    value = clearXss(value);
                    // 如果是get方法需要将请求地址参数转码
                    if (request.getMethod().equals(RequestMethod.GET)) {
                        try {
                            value = new String(value.getBytes("ISO-8859-1"), Const.UTF8);
                        } catch (UnsupportedEncodingException e) {
                            e.printStackTrace();
                        }
                    }

                    // 保存至自定义字段集合
                    if (StringUtils.isNotBlank(value)) {
                        diyFieldName.put(entry.getKey(), value);
                        //判断请求中的是否是自定义模型中的字段
                        if (filedStr.contains(entry.getKey())) {
                            //设置自定义模型字段和值
                            DiyModelMap diyMap = new DiyModelMap();
                            diyMap.setKey(entry.getKey());
                            diyMap.setValue(value);
                            fieldValueList.add(diyMap);
                        }
                    }

                }
            }
        }

        //添加自定义模型的字段和值
        if (fieldValueList.size() > 0) {
            params.put("diyModel", fieldValueList);
        }


        Map<String, Object> searchMap = field;
        String contentTag = BasicUtil.getString("content_tag");
        if (StringUtils.isNotBlank(contentTag)){
            searchMap.put("content_tag", contentTag);
        }
        searchMap.put("categoryIds",categoryIds);
        StringBuilder urlParams = new StringBuilder();

        searchMap.forEach((k, v) -> {
            //sql注入过滤
            if (v != null) {
                searchMap.put(k, v.toString().replaceAll("('|\"|\\\\)", "\\\\$1"));
                searchMap.put(k, clearXss(searchMap.get(k).toString()));
                if (!"size".equals(k) && !"pageNo".equals(k)) {
                    urlParams.append(k).append("=").append(searchMap.get(k)).append("&");
                }
            }
        });

        //查询数量 站群会自动拼appId区分
        int count = contentBiz.getSearchCount(contentModel, fieldValueList, searchMap, categoryIds);
        page.setRcount(count);
        params.put("search", searchMap);

        //站点编号
        Boolean shortSwitch = ConfigUtil.getBoolean("短链配置", "shortLinkSwitch");
        if (BasicUtil.getWebsiteApp() != null) {
            params.put(ParserUtil.APP_DIR, BasicUtil.getWebsiteApp().getAppDir());
            params.put(ParserUtil.URL, BasicUtil.getWebsiteApp().getAppHostUrl());
            params.put(ParserUtil.APP_ID, BasicUtil.getWebsiteApp().getAppId());
        } else if (shortSwitch){
            params.put(ParserUtil.URL, BasicUtil.getUrl());
            params.put(ParserUtil.APP_DIR, "");
        } else {
            params.put(ParserUtil.URL, BasicUtil.getUrl());
            params.put(ParserUtil.APP_DIR, BasicUtil.getApp().getAppDir());
        }
        params.put(ParserUtil.SHORT_SWITCH, shortSwitch);

        //对项目名预处理
        String contextPath = BasicUtil.getContextPath();
        if (StringUtils.isNotBlank(contextPath) && "/".equalsIgnoreCase(contextPath) ){
            contextPath = "";
        }
        params.putIfAbsent(ParserUtil.CONTEXT_PATH, contextPath);

        searchMap.put("pageNo", 0);
//        ParserUtil.read(search, map, page);
        int total = PageUtil.totalPage(count, page.getSize());


        int pageNo = BasicUtil.getInt("pageNo", 1);
        if (pageNo >= total && total != 0) {
            pageNo = total;
        }
        //获取总数
        page.setTotal(total);

        page.setPageNo(pageNo);

        //设置分页的统一链接
        String url = request.getServletPath() + "?" + urlParams;
        String pageNoStr = "size=" + page.getSize() + "&pageNo=";
        //下一页
        String nextUrl = url + pageNoStr + ((pageNo + 1 > total) ? total : pageNo + 1);
        //首页
        String indexUrl = url + pageNoStr + 1;
        //尾页
        String lastUrl = url + pageNoStr + total;
        //上一页 当前页为1时，上一页就是1
        String preUrl = url + pageNoStr + ((pageNo == 1) ? 1 : pageNo - 1);

        page.setIndexUrl(indexUrl);
        page.setNextUrl(nextUrl);
        page.setPreUrl(preUrl);
        page.setLastUrl(lastUrl);

        params.put(ParserUtil.PAGE, page);
        params.put(ParserUtil.HTML, htmlDir);
        //动态解析
        params.put(ParserUtil.IS_DO, false);
        //设置动态请求的模块路径
        params.put(ParserUtil.MODEL_NAME, "mcms");

        //解析后的内容
        String content = "";
        try {
            //根据模板路径，参数生成
            content = ParserUtil.rendering(search, params);
        } catch (TemplateNotFoundException e) {
            e.printStackTrace();
        } catch (MalformedTemplateNameException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return content;
    }

    // 清除路径中的转义字符
    private String clearXss(String value) {

        if (value == null || "".equals(value)) {
            return value;
        }

        value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
        value = value.replaceAll("\\(", "&#40;").replace("\\)", "&#41;");
        value = value.replaceAll("'", "&#39;");
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']",
                "\"\"");
        value = value.replace("script", "");

        return value;
    }

    /**
     * 存储自定义模型字段和接口参数
     *
     * @author 铭软开源团队
     * @date 2019年3月5日
     */
    class DiyModelMap {
        private String key;
        private Object value;

        public String getKey() {
            return key;
        }

        public void setKey(String key) {
            this.key = key;
        }

        public Object getValue() {
            return value;
        }

        public void setValue(Object value) {
            this.value = value;
        }

        @Override
        public String toString() {
            return JSONUtil.toJsonStr(this);
        }
    }

}
