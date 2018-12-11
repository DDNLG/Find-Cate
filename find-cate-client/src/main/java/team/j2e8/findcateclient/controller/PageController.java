package team.j2e8.findcateclient.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @auther vinsonws
 * @date 2018/12/11 23:16
 */
@Controller
@RequestMapping(value = "/")
public class PageController {
    @Value("${back-end.server}")
    private String backendServer;

    @RequestMapping(value = "/index")
    public String index(){
        return "/page/index";
    }

    @RequestMapping(value = "/user/login")
    public String login(){
        return "/page/login";
    }

    @RequestMapping(value = "/shop/page")
    public String shopInformation(){
        return "/page/detail";
    }

//    @RequestMapping(value = "/user/register")
//    public String register(){
//        return "/page/register";
//    }
}
