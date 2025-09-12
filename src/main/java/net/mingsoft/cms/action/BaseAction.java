/**
 * The MIT License (MIT)
 * Copyright (c) 2012-present 铭软科技(mingsoft.net)
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * <p>
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * <p>
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
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import jakarta.servlet.http.HttpServletRequest;
import net.mingsoft.base.entity.ResultData;
import net.mingsoft.base.util.BundleUtil;
import net.mingsoft.basic.action.BaseFileAction;
import net.mingsoft.basic.bean.UploadConfigBean;
import net.mingsoft.basic.entity.AppEntity;
import net.mingsoft.basic.service.IUploadBaseService;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.basic.util.SpringUtil;
import net.mingsoft.cms.bean.EditorStateBean;
import net.mingsoft.mdiy.util.ConfigUtil;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.*;

/**
 * @Author: 铭飞开源团队--huise
 * @Date: 2019/8/9 20:47
 */
public class BaseAction extends BaseFileAction {
    /**
     * 读取国际化资源文件(没有占位符号的)，优先模块对应的资源文件，如果模块资源文件找不到就会优先基础层
     *
     * @param key 国际化文件key
     * @return 国际化字符串
     */
    protected String getResString(String key) {
        return this.getResString(key, "");
    }

    /**
     * 读取国际化资源文件，优先模块对应的资源文件，如果模块资源文件找不到就会优先基础层
     *
     * @param key    国际化文件key
     * @param params 拼接值
     * @return 国际化字符串
     */
    protected String getResString(String key, String... params) {
        // TODO Auto-generated method stub
        String str = "";
        try {
            str = super.getResString(key);
            //替换占位
            for (int i = 0; i < params.length; i++) {
                str = str.replace("{" + i + "}", params[i]);
            }
        } catch (MissingResourceException e) {
            str = BundleUtil.getString(net.mingsoft.cms.constant.Const.RESOURCES, key, params);
        }

        return str;
    }


    /**
     * 抽取百度编辑器执行公共部分
     *
     * @param request           请求
     * @param upfile            文件
     * @param execFileConfigMap 上传大小配置Map 应包含 imageMaxSize、videoMaxSize、fileMaxSize
     * @param version           编辑器版本
     * @return 执行结果响应
     */
    public String exec(HttpServletRequest request, MultipartFile upfile, Map execFileConfigMap, String version) {

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

        String action = BasicUtil.getString("action");
        // 判断当前编辑器什么操作
        switch (action) {
            case "uploadscrawl":
                // 上传涂鸦文件
                return uploadEditorScrawlFile(request, uploadPath);
            case "uploadimage":
            case "uploadvideo":
            case "uploadfile":
                // 上传文件
                return uploadEditorFile(uploadPath, upfile);
            case "catchimage":
                // 抓取网络图片到本地
                return catchImage(request, uploadPath);
            default:
                // 获取编辑器配置
                return getEditorConfig(execConfigMap, BasicUtil.getRealPath(StrUtil.format("static/plugins/ueditor/{}/config.json", version)));
        }
    }

    /**
     * 上传编辑器涂鸦图片
     *
     * @param uploadPath 上传路径
     * @param request    HttpServletRequest
     * @return
     */
    private String uploadEditorScrawlFile(HttpServletRequest request, String uploadPath){
        String base64 = request.getParameter("upfile");
        byte[] bytes = Base64.decodeBase64(base64);
        if (bytes == null) {
            return new EditorStateBean(false, "上传涂鸦图片失败").toString();
        }
        // 尝试从流中获取后缀地址
        MultipartFile file = net.mingsoft.basic.util.FileUtil.bytesToMultipartFile(bytes, "png");

        if (ObjectUtil.isNull(file)) {
            return new EditorStateBean(false, "上传涂鸦图片失败").toString();
        }

        UploadConfigBean bean = new UploadConfigBean(uploadPath, file, null, true);
        bean.setFileSize(bytes.length);
        bean.setFileName(file.getName());
        EditorStateBean state = new EditorStateBean();

        try {
            state = this.uploadFile(bean);
        } catch (IOException e) {
            LOG.debug("上传编辑器涂鸦文件失败");
            return new EditorStateBean(false, "上传涂鸦文件失败").toString();
        }

        return state.toString();
    }

    /**
     * 抓取远程图片保存到本地
     *
     * @param request    HttpServletRequest
     * @param uploadPath 上传路径
     * @return
     */
    private String catchImage(HttpServletRequest request, String uploadPath) {
        // 获取图片地址
        String[] remotes = request.getParameterValues("source[]");
        EditorStateBean multiState = new EditorStateBean(true);
        List<EditorStateBean> states = new ArrayList<>();
        for (String remote : remotes) {
            if (StringUtils.isBlank(remote)) {
                continue;
            }

            // 根据文件后缀当默认值，防止出现某些文件通过字节流获取后缀为空的情况
            String suffix = FileNameUtil.getSuffix(remote);
            suffix = StrUtil.isBlank(suffix) ? "png" : suffix;

            // 转成multipartFile对象方便组装成上传bean
            MultipartFile file = net.mingsoft.basic.util.FileUtil.remoteUrlToMultipartFile(remote, suffix);
            if (file == null) {
                continue;
            }

            UploadConfigBean bean = new UploadConfigBean(uploadPath, file, null, true);
            bean.setFileSize(file.getSize());
            bean.setFileName(file.getName());

            EditorStateBean state = new EditorStateBean();
            try {
                state = this.uploadFile(bean);
            } catch (IOException e) {
                LOG.debug("抓取图片失败");
                state = new EditorStateBean(false, "抓取图片失败");
            }
            // 这里还需要把源文件地址添加到结果中
            if (state.isSuccess()) {
                state.put("state", "SUCCESS");
                state.put("source", remote);
            }
            states.add(state);
        }
        multiState.put("list", states);
        return multiState.toString();
    }


    /**
     * 上传编辑器文件
     *
     * @param uploadPath 上传路径
     * @param upfile     文件
     * @return
     */
    private String uploadEditorFile(String uploadPath, MultipartFile upfile) {
        String upFileMainName = FileNameUtil.mainName(upfile.getOriginalFilename());
        if (StringUtils.isBlank(upFileMainName)) {
            return new EditorStateBean(false, getResString("err.error", getResString("file.name"))).toString();
        }
        // 组装uploadConfigBean上传使用
        UploadConfigBean bean = new UploadConfigBean(uploadPath, upfile, null, true);
        bean.setFileSize(upfile.getSize());
        bean.setFileName(upfile.getOriginalFilename());
        try {
            return this.uploadFile(bean).toString();
        } catch (Exception e) {
            e.printStackTrace();
            return new EditorStateBean(false, "上传图片失败").toString();
        }
    }


    /**
     * 获取编辑器配置
     * @param configJson 配置json
     * @param jsonPath json文件路径
     * @return
     */
    private String getEditorConfig(Map configJson, String jsonPath) {
        // 读取本地json文件
        String _configJson = FileUtil.readString(jsonPath, StandardCharsets.UTF_8);
        // 过滤中文字符串
        _configJson = _configJson.replaceAll("/\\*[\\s\\S]*?\\*/", "");
        Map jsonMap = JSONUtil.toBean(_configJson, Map.class);
        // 拿自定义数据替换json中某些数据
        jsonMap.putAll(configJson);
        return JSONUtil.toJsonStr(jsonMap);
    }

    /**
     * 上传文件到本地并且组装成百度编辑器格式返回
     * @param bean 上传配置
     * @return 上传结果
     * @throws IOException 抛出异常
     */
    private EditorStateBean uploadFile(UploadConfigBean bean) throws IOException {
        // 判断是依赖ms-file插件
        String type = ConfigUtil.getString("存储设置", "storeSelect");
        IUploadBaseService uploadBaseService = null;
        EditorStateBean state = new EditorStateBean(true);
        // 单个文件上传计算下各个参数值避免重复上传
        if (StringUtils.isBlank(bean.getFileIdentifier())) {
            try {
                bean.setFileIdentifier(String.valueOf(Hex.encodeHex(MessageDigest.getInstance("MD5").digest(bean.getFile().getBytes()))));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (StringUtils.isNotBlank(type)) {
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
            state = new EditorStateBean(true);
            state.put("original", bean.getFileName());
            state.put("size", bean.getFileSize());
            state.put("title", FileNameUtil.getName(resultData.getData(String.class)));
            state.put("type", "." + FileNameUtil.getSuffix(bean.getFileName()));
            // 由于百度编辑器不是正常的uploadConfigBean，是无法正常通过getFileIdentifier获取到文件标识的，所以在这里做一个容错处理
            state.put("fileIdentifier", bean.getFileIdentifier());
            // 判断是否有contentPath
            String contextPath = BasicUtil.getContextPath();
            String filePath = resultData.getData(String.class);
            if (StringUtils.isNotBlank(filePath) && !filePath.startsWith("http")) {
                filePath = (contextPath.equals("/") ? "" : contextPath) + filePath;
            }
            state.put("url", filePath);
        } else {
            state = new EditorStateBean(false, resultData.getMsg());
        }
        return state;
    }

}
