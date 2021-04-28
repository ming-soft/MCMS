package net.mingsoft.cms.action.web;

import net.mingsoft.base.action.BaseAction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller()
@RequestMapping("/")
public class ServerAction extends BaseAction {

    @ResponseBody
    @GetMapping("/server.do")
    public String list(HttpServletRequest req, HttpServletResponse resp) {
        LOG.debug("心跳");
        return "";
    }
}
