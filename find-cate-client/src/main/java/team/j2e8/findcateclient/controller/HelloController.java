package team.j2e8.findcateclient.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @auther vinsonws
 * @date 2018/11/25 23:20
 */
@Controller
@RequestMapping("/hello")
public class
HelloController {

    @RequestMapping("")
    public String sayHello(Model model) {
        model.addAttribute("mes","spring!!");
        return "hello";
    }

    @RequestMapping("/hi")
    public String sayHi(Model model) {
        model.addAttribute("mes","hi !!!");
        return "hello";
    }


}
