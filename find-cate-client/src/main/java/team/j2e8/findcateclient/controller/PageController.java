package team.j2e8.findcateclient.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * @auther vinsonws
 * @date 2018/12/11 23:16
 */
@Controller
@RequestMapping(value = "/")
public class PageController {
    @Value("${back-end.server}")
    private String backendServer;
    @Value("${image.server}")
    private String imgServer;

    @RequestMapping(value = "/index")
    public ModelAndView index(){

        return new ModelAndView("/page/index")
                .addObject("backserver", backendServer)
                .addObject("imgserver", imgServer);
    }

    @RequestMapping(value = "/user/login")
    public ModelAndView login(){
        return new ModelAndView("/page/login")
                .addObject("backserver", backendServer)
                .addObject("imgserver", imgServer);
    }

    @RequestMapping(value = "/user/afterlogin")
    public ModelAndView login(@RequestParam(required = false) String jwtToken,HttpServletRequest request){
        if (jwtToken != null)
            request.getSession().setAttribute("jwtToken", jwtToken);
        //return new ModelAndView("forward:/index");
        return new ModelAndView("redirect:/index");
    }

    @RequestMapping(value = "/shop/page")
    public ModelAndView shopInformation(@RequestParam( defaultValue = "") Integer shopId){

        return new ModelAndView("/page/detail")
                .addObject("shopId", shopId)
                .addObject("backserver", backendServer)
                .addObject("imgserver", imgServer);
    }

    @RequestMapping(value = "/user/register")
    public ModelAndView register(){
        return new ModelAndView("/page/register")
                .addObject("backserver", backendServer)
                .addObject("imgserver", imgServer);
    }

    @RequestMapping(value = "/user/info")
    public ModelAndView userInfortaion(HttpServletRequest request){
//        if (request.getSession().getAttribute("jwtToken") == null){
//            return new ModelAndView("redirect:/user/login");
//        }else {
//            return new ModelAndView("/page/userinfo")
//                    .addObject("backserver", backendServer)
//                    .addObject("imgserver", imgServer);
//        }
        return new ModelAndView("/page/userinfo")
                    .addObject("backserver", backendServer)
                    .addObject("imgserver", imgServer);
    }

    @RequestMapping(value = "/user/edit")
    public ModelAndView editUserInfortaion(HttpServletRequest request){
//        if (request.getSession().getAttribute("jwtToken") == null){
//            return new ModelAndView("redirect:/user/login");
//        }else {
//            return new ModelAndView("/page/userinfo")
//                    .addObject("backserver", backendServer)
//                    .addObject("imgserver", imgServer);
//        }
        return new ModelAndView("/page/editinfo")
                .addObject("backserver", backendServer)
                .addObject("imgserver", imgServer);
    }

    @RequestMapping(value = "/list")
    public ModelAndView list(){
        return new ModelAndView("/page/listing")
                .addObject("backserver", backendServer)
                .addObject("imgserver", imgServer);
    }
}
