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
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.file.FileNameUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.State;
import io.github.xcodeding.UeditorActionEnter;
import jakarta.servlet.http.HttpServletRequest;
import net.mingsoft.base.constant.Const;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.base.exception.BusinessException;
import net.mingsoft.base.util.BundleUtil;
import net.mingsoft.basic.action.BaseFileAction;
import net.mingsoft.basic.bean.UploadConfigBean;
import net.mingsoft.basic.entity.AppEntity;
import net.mingsoft.basic.service.IUploadBaseService;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.config.MSProperties;
import net.mingsoft.mdiy.util.ConfigUtil;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.MissingResourceException;

/**
 * @Author: 铭飞开源团队--huise
 * @Date: 2019/8/9 20:47
 */
public class BaseAction extends BaseFileAction {
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
        String uploadMapping = MSProperties.upload.mapping;

        Map uploadConfig = ConfigUtil.getMap("文件上传配置");
        if (MapUtil.isNotEmpty(uploadConfig)){
            uploadFolderPath = uploadConfig.get("uploadPath").toString();
            uploadMapping = uploadConfig.get("uploadMapping").toString();
        }

        // 获取真实完整上传路径
        String rootPath = FileUtil.isAbsolutePath(uploadFolderPath) ? uploadFolderPath : BasicUtil.getRealPath(uploadFolderPath);

        Map execConfigMap = new HashMap();
        execConfigMap.putAll(execFileConfigMap);

        AppEntity app = BasicUtil.getApp();

        String datePath = DateUtil.format(new Date(), "yyyyMMdd");

        // /appId/editor/yyyyMMdd/{time}
        String uploadPath = "/".concat(app.getAppId()).concat("/editor/").concat(datePath).concat("/");

        String filePathFormat = uploadPath.concat("{time}");



        execConfigMap.put("imagePathFormat", filePathFormat);
        execConfigMap.put("filePathFormat", filePathFormat);
        execConfigMap.put("videoPathFormat", filePathFormat);
        execConfigMap.put("catcherPathFormat", filePathFormat);
        execConfigMap.put("scrawlPathFormat", filePathFormat);
        execConfigMap.put("snapscreenPathFormat", filePathFormat);

        String execConfig = JSONUtil.toJsonStr(execConfigMap);

        // 如果upfile不为空，说明此处操作时上传附件操作
        if (upfile != null){
            State state = null;
            String upFileMainName = FileNameUtil.mainName(upfile.getOriginalFilename());
            if (StringUtils.isBlank(upFileMainName)){
                return new BaseState(false, getResString("err.error",getResString("file.name"))).toJSONString();
            }
            // 组装uploadConfigBean上传使用
            UploadConfigBean bean = new UploadConfigBean(uploadPath, upfile, null, true);
            bean.setFileSize(upfile.getSize());
            bean.setFileName(upfile.getOriginalFilename());
            try {
                // 判断是依赖ms-file插件
                String type = ConfigUtil.getString("存储设置", "storeSelect");
                IUploadBaseService uploadBaseService = null;
                if (StringUtils.isNotBlank(type)) {
                    // 单个文件上传计算下各个参数值避免重复上传
                    if (StringUtils.isBlank(bean.getFileIdentifier())){
                        try {
                            bean.setFileIdentifier(String.valueOf(Hex.encodeHex(MessageDigest.getInstance("MD5").digest(bean.getFile().getBytes()))));
                        } catch (NoSuchAlgorithmException e) {
                            e.printStackTrace();
                        }
                    }
                    //ms-file 插件启用
                    uploadBaseService = (IUploadBaseService) SpringUtil.getBean(type);
                }
                ResultData resultData = null;
                // 根据不同类型决定上传逻辑
                if (uploadBaseService != null) {
                    resultData = uploadBaseService.upload(bean);
                } else {
                    resultData = this.upload(bean);
                }
                if (resultData.isSuccess()) {
                    // 组装百度编辑器格式
                    state = new BaseState(true);
                    state.putInfo("original", upfile.getOriginalFilename());
                    state.putInfo("size", upfile.getSize());
                    state.putInfo("title", FileNameUtil.getName(resultData.getData(String.class)));
                    state.putInfo("type", "." + FileNameUtil.getSuffix(upfile.getOriginalFilename()));
                    // 由于百度编辑器不是正常的uploadConfigBean，是无法正常通过getFileIdentifier获取到文件标识的，所以在这里做一个容错处理
                    state.putInfo("fileIdentifier", bean.getFileIdentifier());
                    // 判断是否有contentPath
                    String contextPath = BasicUtil.getContextPath();
                    String filePath = resultData.getData(String.class);
                    if (StringUtils.isNotBlank(filePath) && !filePath.startsWith("http")) {
                        filePath = (contextPath.equals("/") ? "" : contextPath) + filePath;
                    }
                    state.putInfo("url", filePath);
                } else {
                    state = new BaseState(false, resultData.getMsg());
                }
                return state.toJSONString();
            } catch (Exception e) {
                e.printStackTrace();
                return new BaseState(false, 500).toJSONString();
            }
        }

        //过滤非法上传路径
        if (execConfig != null && (execConfig.contains("../") || execConfig.contains("..\\"))) {
            return new BaseState(false, BundleUtil.getString(Const.RESOURCES,"err.error",BundleUtil.getString(net.mingsoft.basic.constant.Const.RESOURCES,"file.path"))).toJSONString();
        }
        UeditorActionEnter actionEnter = new UeditorActionEnter(upfile,request, rootPath, execConfig, BasicUtil.getRealPath(""), BasicUtil.getRealPath(StrUtil.format("static/plugins/ueditor/{}/config.json",version)));
        String result = actionEnter.exec();
        Map jsonMap = JSONUtil.toBean(result,Map.class);
        jsonMap.put("url","/".concat(uploadMapping.replaceAll("/([\\s\\S]*)/\\*\\*",  "$1")).concat(jsonMap.get("url")+""));
        return JSONUtil.toJsonStr(jsonMap);


    }
}
