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


package net.mingsoft.cms.action;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.file.FileNameUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import io.github.xcodeding.UeditorActionEnter;
import javax.servlet.http.HttpServletRequest;
import net.mingsoft.base.constant.Const;
import net.mingsoft.base.exception.BusinessException;
import net.mingsoft.base.util.BundleUtil;
import net.mingsoft.basic.entity.AppEntity;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.config.MSProperties;
import net.mingsoft.mdiy.util.ConfigUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.MissingResourceException;

/**
 * @Author: 铭飞开源团队--huise
 * @Date: 2019/8/9 20:47
 */
public class BaseAction extends net.mingsoft.basic.action.BaseAction{
    /**
     * 读取国际化资源文件(没有占位符号的)，优先模块对应的资源文件，如果模块资源文件找不到就会优先基础层
     * @param key 国际化文件key
     * @return 国际化字符串
     */
    protected String getResString(String key) {
        return this.getResString(key,"");
    }

    /**
     * 读取国际化资源文件，优先模块对应的资源文件，如果模块资源文件找不到就会优先基础层
     * @param key 国际化文件key
     * @param params 拼接值
     * @return 国际化字符串
     */
    protected String getResString(String key,String... params) {
        // TODO Auto-generated method stub
        String str = "";
        try {
            str = super.getResString(key);
            //替换占位
            for (int i = 0; i < params.length; i++) {
                str = str.replace("{" + i + "}", params[i]);
            }
        } catch (MissingResourceException e) {
            str = BundleUtil.getString(net.mingsoft.cms.constant.Const.RESOURCES, key,params);
        }

        return str;
    }


    /**
     * 抽取百度编辑器执行公共部分
     * @param request 请求
     * @param upfile 文件
     * @param execFileConfigMap 上传大小配置Map 应包含 imageMaxSize、videoMaxSize、fileMaxSize
     * @param version 编辑器版本
     * @return 执行结果响应
     */
    public String exec(HttpServletRequest request, MultipartFile upfile, Map execFileConfigMap, String version){
        String uploadFolderPath = MSProperties.upload.path;

        String configRootPath = ConfigUtil.getString("文件上传配置", "uploadPath", "");
        uploadFolderPath = StringUtils.isBlank(configRootPath) ? uploadFolderPath : configRootPath;
        String rootPath = BasicUtil.getRealPath(uploadFolderPath);

        Map execConfigMap = new HashMap();
        execConfigMap.putAll(execFileConfigMap);

        AppEntity app = BasicUtil.getApp();

        String datePath = DateUtil.format(new Date(), "yyyyMMdd");

        // /appId/editor/yyyyMMdd/{time}
        String filePathFormat = "/".concat(app.getAppId()).concat("/editor/").concat(datePath).concat("/").concat("{time}");

        execConfigMap.put("imagePathFormat", filePathFormat);
        execConfigMap.put("filePathFormat", filePathFormat);
        execConfigMap.put("videoPathFormat", filePathFormat);
        execConfigMap.put("catcherPathFormat", filePathFormat);
        execConfigMap.put("scrawlPathFormat", filePathFormat);
        execConfigMap.put("snapscreenPathFormat", filePathFormat);

        String execConfig = JSONUtil.toJsonStr(execConfigMap);

        // 文件主名称不允许为空
        if (upfile != null){
            String upFileMainName = FileNameUtil.mainName(upfile.getOriginalFilename());
            if (StringUtils.isBlank(upFileMainName)){
                throw new BusinessException(getResString("err.error",getResString("file.name")));
            }
        }

        //过滤非法上传路径
        if (execConfig != null && (execConfig.contains("../") || execConfig.contains("..\\"))) {
            throw new BusinessException(BundleUtil.getString(Const.RESOURCES,"err.error",BundleUtil.getString(net.mingsoft.basic.constant.Const.RESOURCES,"file.path")));
        }
        UeditorActionEnter actionEnter = new UeditorActionEnter(upfile,request, rootPath, execConfig, BasicUtil.getRealPath(""), BasicUtil.getRealPath(StrUtil.format("static/plugins/ueditor/{}/config.json",version)));
        String result = actionEnter.exec();
        Map jsonMap = JSONUtil.toBean(result,Map.class);
        jsonMap.put("url","/".concat(uploadFolderPath).concat(jsonMap.get("url")+""));
        return JSONUtil.toJsonStr(jsonMap);


    }
}
