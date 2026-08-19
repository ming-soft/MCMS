package net.mingsoft.cms.action;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import io.swagger.v3.oas.annotations.Hidden;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
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
 * 百度编辑器后台上传<br>
 * 由于百度编辑器在现如今官方都已经不再维护，推荐各位使用我们MStore中新推出的编辑器插件；
 * @author 铭软开发团队
 * @date 2019年7月16日
 * 历史修订 2022-1-21 新增normalize(),
 * editor()方法过滤非法上传路径
 *
 * 百度编辑器后台上传，兼容文件上传配置的上传大小
 */


@Hidden
@Controller("managerEditorAction")
@RequestMapping("/${ms.manager.path}")
public class EditorAction extends BaseAction{


    @Resource
    private MSProperties msProperties;

    @ResponseBody
    @RequestMapping(value = "/editor", method = {RequestMethod.GET, RequestMethod.POST})
    public String editor(MultipartFile upfile, HttpServletRequest request, String version) {

        Map uploadConfig = ConfigUtil.getMap("文件上传配置");
        long maxFileSize = msProperties.getUpload().getMultipart().getMaxFileSize();
        Map<String, Object> map = new HashMap<>();
        // 兼容其他版本的上传配置
        if (MapUtil.isNotEmpty(uploadConfig)){
            map.put("imageMaxSize", MapUtil.getLong(uploadConfig,"imageSize", maxFileSize) * 1000);
            map.put("videoMaxSize", MapUtil.getLong(uploadConfig,"videoSize", maxFileSize) * 1000);
            map.put("fileMaxSize", MapUtil.getLong(uploadConfig,"fileSize", maxFileSize) * 1000);

            // 如果存在限制类型配置则使用配置，如果没有则使用编辑器自身配置
            String imageType = MapUtil.getStr(uploadConfig, "imageType");
            if (StrUtil.isNotBlank(imageType)) {
                map.put("imageAllowFiles", StrUtil.split(imageType, ",", true,  true).stream().map(str -> "." + str).collect(Collectors.toList()));
            }
            String videoType = MapUtil.getStr(uploadConfig, "videoType");
            if (StrUtil.isNotBlank(videoType)) {
                map.put("videoAllowFiles", StrUtil.split(videoType, ",", true,  true).stream().map(str -> "." + str).collect(Collectors.toList()));
            }
            String fileType = MapUtil.getStr(uploadConfig, "fileType");
            if (StrUtil.isNotBlank(fileType)) {
                map.put("fileAllowFiles", StrUtil.split(fileType, ",", true,  true).stream().map(str -> "." + str).collect(Collectors.toList()));
            }
        }else {
            // 控制大小
            map.put("imageMaxSize", maxFileSize * 1000);
            map.put("videoMaxSize", maxFileSize * 1000);
            map.put("fileMaxSize", maxFileSize * 1000);
        }

        return exec(request,upfile,map,version);
    }

}
