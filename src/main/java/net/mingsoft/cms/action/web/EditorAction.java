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






package net.mingsoft.cms.action.web;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import io.swagger.v3.oas.annotations.Hidden;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import net.mingsoft.cms.action.BaseAction;
import net.mingsoft.config.MSProperties;
import net.mingsoft.mdiy.util.ConfigUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 百度编辑器上传<br>
 * 由于百度编辑器在现如今官方都已经不再维护，推荐各位使用我们MStore中新推出的编辑器插件；
 * @author 铭软开发团队
 * @date 2019年7月16日
 * 历史修订 2022-1-21 新增normalize(),
 * editor()方法过滤非法上传路径
 *
 * 百度编辑器前端，兼容文件上传配置的上传大小
 */
@Hidden
@Controller("webEditorAction")
@RequestMapping("/")
public class EditorAction extends BaseAction {

    @Resource
    private MSProperties msProperties;

    @ResponseBody
    @RequestMapping(value = "editor", method = {RequestMethod.GET, RequestMethod.POST})
    public String editor(MultipartFile upfile,HttpServletRequest request, String version) {
        boolean enableWeb = MSProperties.upload.enableWeb;

        Map uploadConfig = ConfigUtil.getMap("文件上传配置");
        Map<String, Object> map = new HashMap<>();
        long maxFileSize = msProperties.getUpload().getMultipart().getMaxFileSize() * 1000;
        // 兼容其他版本的上传配置
        if (MapUtil.isNotEmpty(uploadConfig)){
            enableWeb = MapUtil.getBool(uploadConfig, "uploadEnable");
            maxFileSize = MapUtil.getLong(uploadConfig,"webFileSize") * 1000;
            // 由于我们webFileType是一个大集合，不像管理员端那样细分，所以这边改成
            // 不做空判断，hutool中的StrUtil.split已做处理，返回一个空数组
            String imageType = MapUtil.getStr(uploadConfig, "imageType");
            String videoType = MapUtil.getStr(uploadConfig, "videoType");
            String fileType = MapUtil.getStr(uploadConfig, "fileType");
            map.put("imageAllowFiles", StrUtil.split(imageType, ",", true,  true).stream().map(str -> "." + str).collect(Collectors.toList()));
            map.put("videoAllowFiles", StrUtil.split(videoType, ",", true,  true).stream().map(str -> "." + str).collect(Collectors.toList()));
            map.put("fileAllowFiles", StrUtil.split(fileType, ",", true,  true).stream().map(str -> "." + str).collect(Collectors.toList()));

        }
        if (!enableWeb) {
            map.put("state","配置不允许前端上传文件");
            return JSONUtil.toJsonStr(map);
        }
        // 控制大小
        map.put("imageMaxSize", maxFileSize);
        map.put("videoMaxSize", maxFileSize);
        map.put("fileMaxSize", maxFileSize);

        return exec(request,upfile,map,version);
    }

}
