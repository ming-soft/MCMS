/**
 * The MIT License (MIT)
 * Copyright (c) 2012-2022 铭软科技(mingsoft.net)
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


package net.mingsoft.basic.action.web;

import cn.hutool.core.io.FileUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.mingsoft.ueditor.MsUeditorActionEnter;
import net.mingsoft.basic.util.BasicUtil;
import net.mingsoft.config.MSProperties;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 临时修复：百度编辑器上传，会在下一版本合并
 *
 * @author 铭软开发团队
 * @date 2019年7月16日
 * 历史修订 2022-1-21 新增normalize(),
 * editor()方法过滤非法上传路径
 */
@ApiIgnore
@Controller("ueAction")
@RequestMapping("/static/plugins/ueditor/{version}/jsp")
public class EditorAction {

    @ResponseBody
    @RequestMapping(value = "editor", method = {RequestMethod.GET, RequestMethod.POST})
    public String editor(HttpServletRequest request, HttpServletResponse response, String jsonConfig) {
        String uploadFloderPath = MSProperties.upload.path;
        String rootPath = BasicUtil.getRealPath(uploadFloderPath);
        jsonConfig = jsonConfig.replace("{ms.upload}", "/" + uploadFloderPath);
        //过滤非法上传路径
        Map<String, Object> map = (Map<String, Object>) JSONObject.parse(jsonConfig);
        String imagePathFormat = (String) map.get("imagePathFormat");
        imagePathFormat = FileUtil.normalize(imagePathFormat);

        String filePathFormat = (String) map.get("filePathFormat");
        filePathFormat = FileUtil.normalize(filePathFormat);

        String videoPathFormat = (String) map.get("videoPathFormat");
        videoPathFormat = FileUtil.normalize(videoPathFormat);

        map.put("imagePathFormat", imagePathFormat);
        map.put("filePathFormat", filePathFormat);
        map.put("videoPathFormat", videoPathFormat);

        jsonConfig = JSONObject.toJSONString(map);
        MsUeditorActionEnter actionEnter = new MsUeditorActionEnter(request, rootPath, jsonConfig, BasicUtil.getRealPath(""));
        String json = actionEnter.exec();
        Map jsonMap = JSON.parseObject(json,Map.class);
        jsonMap.put("url","/".concat(uploadFloderPath).concat(jsonMap.get("url")+""));
        return JSONObject.toJSONString(jsonMap);
    }

}
