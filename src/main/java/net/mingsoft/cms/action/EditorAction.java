package net.mingsoft.cms.action;

import cn.hutool.core.map.MapUtil;
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
            map.put("imageMaxSize", MapUtil.getLong(uploadConfig,"imageSize") * 1000);
            map.put("videoMaxSize", MapUtil.getLong(uploadConfig,"videoSize") * 1000);
            map.put("fileMaxSize", MapUtil.getLong(uploadConfig,"fileSize") * 1000);
        }else {
            // 控制大小
            map.put("imageMaxSize", maxFileSize * 1000);
            map.put("videoMaxSize", maxFileSize * 1000);
            map.put("fileMaxSize", maxFileSize * 1000);
        }

        return exec(request,upfile,map,version);
    }

}
