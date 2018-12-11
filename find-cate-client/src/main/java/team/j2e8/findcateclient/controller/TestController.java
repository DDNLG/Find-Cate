package team.j2e8.findcateclient.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @auther vinsonws
 * @date 2018/12/11 16:52
 */
@Controller
public class TestController {
    @RequestMapping(value = "/")
    public String test(){
        return "/page/index";
    }
}
